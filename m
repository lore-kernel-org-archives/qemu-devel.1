Received: from eggs.gnu.org ([2001:4830:134:3::10]:44040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzaZS-0005iW-Ia
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzaRz-0006wT-F5
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:38:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fzaRv-0006uM-5L
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 00:38:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 699FCDFED
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 04:38:48 +0000 (UTC)
Date: Tue, 11 Sep 2018 06:38:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180911043843.egzz6pqe5ouzju3g@sirius.home.kraxel.org>
References: <20180910064340.30745-1-kraxel@redhat.com>
	<20180910064340.30745-3-kraxel@redhat.com>
	<20180910125409.2b49be3b@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910125409.2b49be3b@t450s.home>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com

  Hi,

> >      type_register_static(&vfio_pci_dev_info);
> > +    type_register_static(&vfio_pci_ramfb_dev_info);

> My concern here is still all of the extra tooling that needs to be
> added to management layers above QEMU for this device that exists only
> because we can't hotplug the primary display in QEMU.  What happens when
> we can hotplug the primary display?

Ramfb uses fw_cfg, and fw_cfg files can't be added or removed at
runtime, the interface simply isn't designed for that.

> Aren't disabling hotplug of a
> vfio-pci device and supporting ramfb two separate things?  I think
> we're leaking current implementation issues out to the device options
> when really we'd rather have a "ramfb" (or perhaps "console") option on
> the vfio-pci device and the hotplug capability determined automatically
> and available through introspection of the device.

Well, I don't think libvirt will have too much trouble handling this.
We have two variants (with and without vga compatibility) of other
devices: qxl-vga and qxl, virtio-vga and virtio-gpu-pci.  libvirt copes
just fine and picks the right one (I think depending on video model
'primary' property).

Also libvirt manages hotpluggability per device *class*, not per device
*instance*.  So a device being hotpluggable or not depending on some
device property is a problem for libvirt ...

I'm open to suggestions how to handle this better, as long as the
libvirt people are on board with the approach.

cheers,
  Gerd
