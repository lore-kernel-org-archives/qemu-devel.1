Received: from eggs.gnu.org ([209.51.188.92]:35366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmh9a-0002bL-PD
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gmh6e-0007dK-GN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:39:53 -0500
Date: Thu, 24 Jan 2019 16:39:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190124153945.GJ4601@localhost.localdomain>
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190122185740.GC5220@localhost.localdomain>
	<340bf08d-57ff-c6b3-13f4-b7c1b0a5e707@virtuozzo.com>
	<02acf2a0-50d9-16d8-c2c4-3001a1d30b23@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02acf2a0-50d9-16d8-c2c4-3001a1d30b23@virtuozzo.com>
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

Am 24.01.2019 um 15:37 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 23.01.2019 15:04, Vladimir Sementsov-Ogievskiy wrote:
> > 22.01.2019 21:57, Kevin Wolf wrote:
> >> Am 11.01.2019 um 12:40 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>> 11.01.2019 13:41, Kevin Wolf wrote:
> >>>> Am 10.01.2019 um 14:20 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >>>>> drv_co_block_status digs bs->file for additional, more accurate search
> >>>>> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
> >>>>>
> >>>>> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> >>>>> knows, where are holes and where is data. But every block_status
> >>>>> request calls lseek additionally. Assume a big disk, full of
> >>>>> data, in any iterative copying block job (or img convert) we'll call
> >>>>> lseek(HOLE) on every iteration, and each of these lseeks will have to
> >>>>> iterate through all metadata up to the end of file. It's obviously
> >>>>> ineffective behavior. And for many scenarios we don't need this lseek
> >>>>> at all.
> >>>>>
> >>>>> So, let's "5daa74a6ebc" by default, leaving an option to return
> >>>>> previous behavior, which is needed for scenarios with preallocated
> >>>>> images.
> >>>>>
> >>>>> Add iotest illustrating new option semantics.
> >>>>>
> >>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>>
> >>>> I still think that an option isn't a good solution and we should try use
> >>>> some heuristics instead.
> >>>
> >>> Do you think that heuristics would be better than fair cache for lseek results?
> >>
> >> I just played a bit with this (qemu-img convert only), and how much
> >> caching lseek() results helps depends completely on the image. As it
> >> happened, my test image was the worst case where caching didn't buy us
> >> much. Obviously, I can just as easily construct an image where it makes
> >> a huge difference. I think that most real-world images should be able to
> >> take good advantage of it, though, and it doesn't hurt, so maybe that's
> >> a first thing that we can do in any case. It might not be the complete
> >> solution, though.
> > 
> > Hmm, and one more idea from Den:
> > 
> > We can detect preallocated image, comparing allocated size of real file with
> > number of non-zero qcow2 refcounts. So, real allocation is much less than
> > allocation in qcow2 point of view, we'll enable lseeks, otherwise - not.
> > 
> 
> Kevin, what do you think?

I'm unsure. I think it requires scanning all refcount blocks in
qcow2_open(), right? This could be slow on huge images. On the other
hand, the first cluster allocation will probably do this anyway, so it
might be reasonable enough.

How would you communicate this? Another block_status return flag that
says "don't bother to ask the protocol layer" and which we would only
set in qcow2 if the probing came to the conclusion that it's not
preallocated?

Kevin
