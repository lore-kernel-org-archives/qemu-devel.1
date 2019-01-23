Received: from eggs.gnu.org ([209.51.188.92]:53420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmLTD-0004a3-9p
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:33:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmLTB-0003B8-Bu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 11:33:43 -0500
Date: Wed, 23 Jan 2019 17:33:03 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190123163303.GC5748@linux.fritz.box>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190122185740.GC5220@localhost.localdomain>
	<4474e54a-1c60-a04b-e404-ad8e570edc1d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4474e54a-1c60-a04b-e404-ad8e570edc1d@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 23.01.2019 um 12:53 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 22.01.2019 21:57, Kevin Wolf wrote:
> > Am 11.01.2019 um 12:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 11.01.2019 13:41, Kevin Wolf wrote:
> >>> Am 10.01.2019 um 14:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>> drv_co_block_status digs bs->file for additional, more accurate search
> >>>> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> >>>>
> >>>> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> >>>> knows, where are holes and where is data. But every block_status
> >>>> request calls lseek additionally. Assume a big disk, full of
> >>>> data, in any iterative copying block job (or img convert) we'll call
> >>>> lseek(HOLE) on every iteration, and each of these lseeks will have to
> >>>> iterate through all metadata up to the end of file. It's obviously
> >>>> ineffective behavior. And for many scenarios we don't need this lseek
> >>>> at all.
> >>>>
> >>>> So, let's "5daa74a6ebc" by default, leaving an option to return
> >>>> previous behavior, which is needed for scenarios with preallocated
> >>>> images.
> >>>>
> >>>> Add iotest illustrating new option semantics.
> >>>>
> >>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>
> >>> I still think that an option isn't a good solution and we should try use
> >>> some heuristics instead.
> >>
> >> Do you think that heuristics would be better than fair cache for lseek results?
> > 
> > I just played a bit with this (qemu-img convert only), and how much
> > caching lseek() results helps depends completely on the image. As it
> > happened, my test image was the worst case where caching didn't buy us
> > much. Obviously, I can just as easily construct an image where it makes
> > a huge difference. I think that most real-world images should be able to
> > take good advantage of it, though, and it doesn't hurt, so maybe that's
> > a first thing that we can do in any case. It might not be the complete
> > solution, though.
> > 
> > Let me explain my test images: The case where all of this actually
> > matters for qemu-img convert is fragmented qcow2 images. If your image
> > isn't fragmented, we don't do lseek() a lot anyway because a single
> > bdrv_block_status() call already gives you the information for the whole
> > image. So I constructed a fragmented image, by writing to it backwards:
> > 
> > ./qemu-img create -f qcow2 /tmp/test.qcow2 1G
> > for i in $(seq 16384 -1 0); do
> >      echo "write $((i * 65536)) 64k"
> > done | ./qemu-io /tmp/test.qcow2
> > 
> > It's not really surprising that caching the lseek() results doesn't help
> > much there as we're moving backwards and lseek() only returns results
> > about the things after the current position, not before the current
> > position. So this is probably the worst case.
> > 
> > So I constructed a second image, which is fragmented, too, but starts at
> > the beginning of the image file:
> > 
> > ./qemu-img create -f qcow2 /tmp/test_forward.qcow2 1G
> > for i in $(seq 0 2 16384); do
> >      echo "write $((i * 65536)) 64k"
> > done | ./qemu-io /tmp/test_forward.qcow2
> > for i in $(seq 1 2 16384); do
> >      echo "write $((i * 65536)) 64k"
> > done | ./qemu-io /tmp/test_forward.qcow2
> > 
> > Here caching makes a huge difference:
> > 
> >      time ./qemu-img convert -p -n $IMG null-co://
> > 
> >                          uncached        cached
> >      test.qcow2             ~145s         ~70s
> >      test_forward.qcow2     ~110s        ~0.2s
> 
> Unsure about your results, at least 0.2s means, that we benefit from
> cached read, not lseek.

Yes, all reads are from the kernel page cache, this is on tmpfs.

I chose tmpfs for two reasons: I wanted to get expensive I/O out of the
way so that the lseek() performance is even visible; and tmpfs was
reported to perform especially bad for SEEK_DATA/HOLE (which my results
confirm). So yes, this setup really makes the lseek() calls stand out
much more than in the common case (which makes sense when you want to
fix the overhead introduced by them).

> = my results =
> 
> in short:
> 
> uncached read:
> +--------------+--------+------+------+--------+
> |              | master | you  |  me  | master |
> +--------------+--------+------+------+--------+
> | test         |   30.4 | 32.6 | 33.9 |   32.4 |
> | test_forward |   28.3 | 33.5 | 32.9 |   32.8 |
> +--------------+--------+------+------+--------+
> 
> ('you' is your patch, 'me' is my simple patch, see below)
> 
> (I retested master, as first test run seemed noticeable faster than patched)
> So, No significant difference may be noticed (if ignore first run:). Or I need a lot more test runs,
> to calculate the average.
> However, I don't expect any difference here, I'm afraid that lseek() time becomes noticeable in
> comparison with read() for a lot larger disks.
> Also, problems of lseek are mostly related to lseek bugs, now seems that my kernel is not buggy..
> What kernel and fs do you use to get such a significant difference between cached/uncached lseek?

$ uname -r
4.20.3-200.fc29.x86_64

> On the other hand, results with cached read are more interesting:
> 
> +--------------+--------+------+------+--------+
> |              | master | you  |  me  | master |
> +--------------+--------+------+------+--------+
> | test         |   0.24 | 0.20 | 0.16 |   0.24 |
> | test_forward |   0.24 | 0.16 | 0.16 |   0.24 |
> +--------------+--------+------+------+--------+
> 
> And they show, that my patch wins. So no lseeks = no problems.

This is not surprising. You included the worst case for my patch, but
not the worst case for your patch. If I include that, too, I get:

+-----------------+------------+------------+--------------+
|                 |   master   |  no lseek  | cached lseek |
+-----------------+------------+------------+--------------+
| on tmpfs:       |            |            |              |
|   test          |        115 |       0.16 |           58 |
|   test_forward  |        115 |       0.16 |         0.16 |
|   test_prealloc |       0.07 |       0.65 |         0.07 |
+-----------------+------------+------------+--------------+
| on xfs          |            |            |              |
|   test          |       0.20 |       0.16 |         0.18 |
|   test_forward  |       0.20 |       0.16 |         0.16 |
|   test_prealloc |       0.07 |       0.73 |         0.07 |
+-----------------+------------+------------+--------------+
| on xfs, -T none |            |            |              |
|   test          |       1.33 |       1.31 |         1.33 |
|   test_forward  |       1.00 |       1.00 |         1.00 |
|   test_prealloc |       0.08 |       0.65 |         0.08 |
+-----------------+------------+------------+--------------+

test_prealloc is an empty image with metadata preallocation:

$ ./qemu-img create -f qcow2 -o preallocation=metadata ~/tmp/test_prealloc.qcow2 1G

So your patch is a clear winner for test on tmpfs, but also a clear
loser for test_prealloc on all backends. Otherwise, I don't see much of
a significant difference.

> Moreover, keeping in mind, that we in Virtuozzo don't have scenarios,
> where we'll benefit from lseeks, and after two slow-lseek bugs, it's
> definitely safer for me to just keep one out-of-tree patch, than
> rely on lseek-cache + lseek, which both are not needed in our case.

With which filesystems did you have those slow lseek bugs?

I mean, I can understand your point that you're not using preallocation
anyway, but for upstream, that's obviously not going to work. My
priority is getting something that improves the situation for everyone.
If we then still need a user-visible option to squeeze out the last
millisecond, we can talk about it. But the option can't be the primary
solution for everyone.

> Of-course, lseek-cache is a good thing, and your patch seems reasonable,
> but I'll go with my patch anyway, and I proposed an option to bring
> such behavior to upstream, if someone wants it.

Okay, if you think it makes sense, I can post it as a proper patch.

Kevin
