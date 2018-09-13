Received: from eggs.gnu.org ([2001:4830:134:3::10]:51429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0LuP-0005hd-Ee
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0LuL-0008CT-Jc
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:19:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0LuJ-0008AY-S7
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 03:19:20 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E313381107
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 07:19:17 +0000 (UTC)
Date: Thu, 13 Sep 2018 09:19:13 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180913071913.vqyy6jf42ylwe24b@sirius.home.kraxel.org>
References: <20180912123700.7708-1-kraxel@redhat.com>
	<20180912123700.7708-3-kraxel@redhat.com>
	<efd77dd1-0402-c68e-7ee9-e8b240c4abd9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efd77dd1-0402-c68e-7ee9-e8b240c4abd9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] display/stdvga: add edid support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

> > --- a/docs/specs/standard-vga.txt
> > +++ b/docs/specs/standard-vga.txt
> > @@ -61,7 +61,7 @@ MMIO area spec
> >   Likewise applies to the pci variant only for obvious reasons.
> > -0000 - 03ff : reserved, for possible virtio extension.
> > +0000 - 03ff : edid data blob.
> 
> 
> > +    if (edid) {
> > +        qemu_edid_info info = {
> > +            .prefx = d->xres,
> > +            .prefy = d->yres,
> > +        };
> > +        qemu_edid_generate(d->edid, sizeof(d->edid), &info);
> > +        qemu_edid_region_io(&subs[3], owner, d->edid, sizeof(d->edid));
> > +        memory_region_add_subregion(parent, 0, &subs[3]);
> 
> Is there ever a risk that this could overflow?  Or, if the blob is always
> smaller than 0x3ff, should we still leave reserved bytes?

It's 128 bytes long.  There can be (multiple) extensions, each 128 bytes
long too.  Current generator doesn't create any extensions.  So, only a
fraction of the space is actually used right now.

I'd leave the room reserved for edid nevertheless.  There is still
plenty of unused address space should we need something at some point in
the future.  The mmio bar is one page (4k), with more than 2k at the end
being not used (from info mtree):

  00000000febf0000-00000000febf0fff (prio 1, i/o): vga.mmio
    00000000febf0000-00000000febf007f (prio 0, i/o): edid
    00000000febf0400-00000000febf041f (prio 0, i/o): vga ioports remapped
    00000000febf0500-00000000febf0515 (prio 0, i/o): bochs dispi interface
    00000000febf0600-00000000febf0607 (prio 0, i/o): qemu extended regs

cheers,
  Gerd
