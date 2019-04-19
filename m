Received: from eggs.gnu.org ([209.51.188.92]:41517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hHSYm-0000mn-GF
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 08:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hHSYl-0002UA-Er
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 08:24:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hHSYk-0002P1-L1
	for qemu-devel@nongnu.org; Fri, 19 Apr 2019 08:24:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so6738724wra.12
	for <qemu-devel@nongnu.org>; Fri, 19 Apr 2019 05:24:00 -0700 (PDT)
Date: Fri, 19 Apr 2019 14:23:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190419122356.7dmwwdbtnzgimydw@steredhat>
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
	<CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
	<20190411130245.ltfyp7d2dfe2cr3h@steredhat>
	<CA+aFP1B7ZZ_xwNOfMbKUzEjYbMH=9dJstLYEyVq4LphPR81u0Q@mail.gmail.com>
	<20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
	<20190417073438.r57lemi6emu4x3ld@steredhat>
	<20190417080443.GA8330@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417080443.GA8330@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: dillaman@redhat.com, qemu-devel <qemu-devel@nongnu.org>, Josh Durgin <jdurgin@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

Hi Kevin,

On Wed, Apr 17, 2019 at 10:04:43AM +0200, Kevin Wolf wrote:
> Am 17.04.2019 um 09:34 hat Stefano Garzarella geschrieben:
> > On Mon, Apr 15, 2019 at 10:04:52AM +0200, Kevin Wolf wrote:
> > > 
> > > I think a potential actual use case could be persistent dirty bitmaps
> > > for incremental backup. Though maybe that would be better served by
> > > using the rbd image just as a raw external data file and keeping the
> > > qcow2 metadata on a filesystem.
> > 
> > Thanks to point it out! I'll take a look to understand how to keep
> > metadata separated from the data.
> 
> I'd consider the feature still experimental, but for local files, it
> works like this:
> 
>     qemu-img create -f qcow2 -o data_file=test.raw test.qcow2 4G
> 
> And then just use test.qcow2. As long as you can put everything you need
> into an rbd URL, the same approach should work. Otherwise, you may need
> to use QMP blockdev-create on creation and possibly the data-file option
> of the qcow2 driver for opening.
>

Very interesting, I'll try to add this support also in the rbd driver.

> > > How fast is rbd_resize()? Does automatically resizing for every write
> > > request actually work reasonably well in practice? If it does, there is
> > > probably little reason not to allow it, even if the use cases are rather
> > > obscure.
> > 
> > I'll try to measure the percentage of the time spent in the rbd_resize.
> > 
> > Another solution could be to pass to the rbd driver the virtual size of
> > the image and resize it only one time also if the preallocation is
> > disabled, because RBD will not allocate blocks but IIUC it only set the max
> > size.
> > 
> > Do you think make sense? Is it feasible?
> 
> In theory yes, though it requires modification of every driver that
> should be usable together with rbd (i.e. ideally all of the drivers). If
> automatic resize works good enough, I'd prefer that

I did some tests and it seems that the cost of rbd_resize() is
negligible. IIUC it only updates the metadata without allocating any
blocks (if we are growing, like that case).

Anyway the automatic resize will not affect the current use-case (raw
images on rbd), where the file size is set during the creation, so I
think there should not be side effects with this patch.

I'm also adding the support for preallocation (i.e. full) in the rbd
driver that can be useful for qcow2 images.

If you prefer I can resend this patch with the preallocation series.

Thanks,
Stefano
