Received: from eggs.gnu.org ([209.51.188.92]:50507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1go2Hb-0002Ni-Ly
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:28:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1go2Ha-0004Zu-RL
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:28:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1go2Ha-0004Yp-Ke
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:28:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id y8so12799636wmi.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 00:28:42 -0800 (PST)
Date: Mon, 28 Jan 2019 09:28:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190128082837.6xdlg3b57pqay5ah@steredhat>
References: <20190124172323.230296-1-sgarzare@redhat.com>
	<20190124172323.230296-2-sgarzare@redhat.com>
	<20190125145856.GC28305@stefanha-x1.localdomain>
	<20190125161813.tyd5ququvhdunt4d@steredhat>
	<20190127125144.GB13784@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190127125144.GB13784@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Sun, Jan 27, 2019 at 12:51:44PM +0000, Stefan Hajnoczi wrote:
> On Fri, Jan 25, 2019 at 05:18:13PM +0100, Stefano Garzarella wrote:
> > On Fri, Jan 25, 2019 at 02:58:56PM +0000, Stefan Hajnoczi wrote:
> > > On Thu, Jan 24, 2019 at 06:23:22PM +0100, Stefano Garzarella wrote:
> > > > +            virtio_error(vdev, "virtio-blk discard/wzeroes header too short");
> > > > +            return -1;
> > > > +        }
> > > > +
> > > > +        sector = virtio_ldq_p(VIRTIO_DEVICE(req->dev), &dwz_hdr.sector);
> > > > +        bytes = virtio_ldl_p(VIRTIO_DEVICE(req->dev),
> > > > +                             &dwz_hdr.num_sectors) << BDRV_SECTOR_BITS;
> > > 
> > > Please handle num_sectors << BDRV_SECTOR_BITS overflow so that we don't
> > > need to worry about what happens with an overflowed value later on.
> > > 
> > 
> > Should I also check if num_sectors is less than "max_discard_sectors" or
> > "max_write_zeroes_sectors"?
> 
> Yes, anything that virtio_blk_sect_range_ok() doesn't check needs to be
> checked manually in this patch.  I can't see a reason for allowing
> requests through that exceed the limit.
> 
> > Do you think make sense flush the MultiReqBuffer before call
> > blk_aio_pdiscard() or blk_aio_pwrite_zeroes()?
> 
> I don't think that is necessary since virtio-blk doesn't guarantee
> ordering (the legacy barrier feature isn't supported by QEMU).
> 
> Even the MultiReqBuffer is flushed, -drive aio=threads (the default
> setting) could end up submitting discard/write zeroes before "earlier"
> requests - it depends on host kernel thread scheduler decisions.
> 

Thanks for the details!

Stefano
