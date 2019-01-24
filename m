Received: from eggs.gnu.org ([209.51.188.92]:35320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmh9w-0002b7-JG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:43:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmgz6-0000LL-Tz
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:32:06 -0500
Date: Thu, 24 Jan 2019 16:31:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190124153153.GI4601@localhost.localdomain>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190122185740.GC5220@localhost.localdomain>
	<4474e54a-1c60-a04b-e404-ad8e570edc1d@virtuozzo.com>
	<20190123163303.GC5748@linux.fritz.box>
	<62aa7f86-4ac7-0eeb-9e9d-30cb6ff229de@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62aa7f86-4ac7-0eeb-9e9d-30cb6ff229de@virtuozzo.com>
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

Am 24.01.2019 um 15:36 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 23.01.2019 19:33, Kevin Wolf wrote:
> > Am 23.01.2019 um 12:53 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> 22.01.2019 21:57, Kevin Wolf wrote:
> >>> Am 11.01.2019 um 12:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>> 11.01.2019 13:41, Kevin Wolf wrote:
> >>>>> Am 10.01.2019 um 14:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>>>> drv_co_block_status digs bs->file for additional, more accurate search
> >>>>>> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> >>>>>>
> >>>>>> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> >>>>>> knows, where are holes and where is data. But every block_status
> >>>>>> request calls lseek additionally. Assume a big disk, full of
> >>>>>> data, in any iterative copying block job (or img convert) we'll call
> >>>>>> lseek(HOLE) on every iteration, and each of these lseeks will have to
> >>>>>> iterate through all metadata up to the end of file. It's obviously
> >>>>>> ineffective behavior. And for many scenarios we don't need this lseek
> >>>>>> at all.
> >>>>>>
> >>>>>> So, let's "5daa74a6ebc" by default, leaving an option to return
> >>>>>> previous behavior, which is needed for scenarios with preallocated
> >>>>>> images.
> >>>>>>
> >>>>>> Add iotest illustrating new option semantics.
> >>>>>>
> >>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>>>
> >>>>> I still think that an option isn't a good solution and we should try use
> >>>>> some heuristics instead.
> >>>>
> >>>> Do you think that heuristics would be better than fair cache for lseek results?
> >>>
> >>> I just played a bit with this (qemu-img convert only), and how much
> >>> caching lseek() results helps depends completely on the image. As it
> >>> happened, my test image was the worst case where caching didn't buy us
> >>> much. Obviously, I can just as easily construct an image where it makes
> >>> a huge difference. I think that most real-world images should be able to
> >>> take good advantage of it, though, and it doesn't hurt, so maybe that's
> >>> a first thing that we can do in any case. It might not be the complete
> >>> solution, though.
> >>>
> >>> Let me explain my test images: The case where all of this actually
> >>> matters for qemu-img convert is fragmented qcow2 images. If your image
> >>> isn't fragmented, we don't do lseek() a lot anyway because a single
> >>> bdrv_block_status() call already gives you the information for the whole
> >>> image. So I constructed a fragmented image, by writing to it backwards:
> >>>
> >>> ./qemu-img create -f qcow2 /tmp/test.qcow2 1G
> >>> for i in $(seq 16384 -1 0); do
> >>>       echo "write $((i * 65536)) 64k"
> >>> done | ./qemu-io /tmp/test.qcow2
> >>>
> >>> It's not really surprising that caching the lseek() results doesn't help
> >>> much there as we're moving backwards and lseek() only returns results
> >>> about the things after the current position, not before the current
> >>> position. So this is probably the worst case.
> >>>
> >>> So I constructed a second image, which is fragmented, too, but starts at
> >>> the beginning of the image file:
> >>>
> >>> ./qemu-img create -f qcow2 /tmp/test_forward.qcow2 1G
> >>> for i in $(seq 0 2 16384); do
> >>>       echo "write $((i * 65536)) 64k"
> >>> done | ./qemu-io /tmp/test_forward.qcow2
> >>> for i in $(seq 1 2 16384); do
> >>>       echo "write $((i * 65536)) 64k"
> >>> done | ./qemu-io /tmp/test_forward.qcow2
> >>>
> >>> Here caching makes a huge difference:
> >>>
> >>>       time ./qemu-img convert -p -n $IMG null-co://
> >>>
> >>>                           uncached        cached
> >>>       test.qcow2             ~145s         ~70s
> >>>       test_forward.qcow2     ~110s        ~0.2s
> >>
> >> Unsure about your results, at least 0.2s means, that we benefit from
> >> cached read, not lseek.
> > 
> > Yes, all reads are from the kernel page cache, this is on tmpfs.
> > 
> > I chose tmpfs for two reasons: I wanted to get expensive I/O out of the
> > way so that the lseek() performance is even visible; and tmpfs was
> > reported to perform especially bad for SEEK_DATA/HOLE (which my results
> > confirm). So yes, this setup really makes the lseek() calls stand out
> > much more than in the common case (which makes sense when you want to
> > fix the overhead introduced by them).
> 
> Ok, missed this. On the other hand tmpfs is not a real production case..

Yes, I fully agree. But it was a simple case where I knew there is a
problem.

I also have a bug report on XFS with an image that is very fragmented on
the file system level. But I don't know how to produce such a file to
run benchmarks on it.

Kevin
