Received: from eggs.gnu.org ([2001:4830:134:3::10]:34672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g08iK-0006wJ-UN
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1g08iI-0008FQ-9w
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1g08iI-0008F2-3f
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 13:14:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 571B1300207F
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 17:14:01 +0000 (UTC)
Date: Wed, 12 Sep 2018 11:13:54 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180912111354.4163d9ce@t450s.home>
In-Reply-To: <20180911043843.egzz6pqe5ouzju3g@sirius.home.kraxel.org>
References: <20180910064340.30745-1-kraxel@redhat.com>
	<20180910064340.30745-3-kraxel@redhat.com>
	<20180910125409.2b49be3b@t450s.home>
	<20180911043843.egzz6pqe5ouzju3g@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/vfio/display: add ramfb support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, libvir-list@redhat.com

On Tue, 11 Sep 2018 06:38:43 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
> 
> > >      type_register_static(&vfio_pci_dev_info);
> > > +    type_register_static(&vfio_pci_ramfb_dev_info);  
> 
> > My concern here is still all of the extra tooling that needs to be
> > added to management layers above QEMU for this device that exists only
> > because we can't hotplug the primary display in QEMU.  What happens when
> > we can hotplug the primary display?  
> 
> Ramfb uses fw_cfg, and fw_cfg files can't be added or removed at
> runtime, the interface simply isn't designed for that.
> 
> > Aren't disabling hotplug of a
> > vfio-pci device and supporting ramfb two separate things?  I think
> > we're leaking current implementation issues out to the device options
> > when really we'd rather have a "ramfb" (or perhaps "console") option on
> > the vfio-pci device and the hotplug capability determined automatically
> > and available through introspection of the device.  
> 
> Well, I don't think libvirt will have too much trouble handling this.
> We have two variants (with and without vga compatibility) of other
> devices: qxl-vga and qxl, virtio-vga and virtio-gpu-pci.  libvirt copes
> just fine and picks the right one (I think depending on video model
> 'primary' property).
> 
> Also libvirt manages hotpluggability per device *class*, not per device
> *instance*.  So a device being hotpluggable or not depending on some
> device property is a problem for libvirt ...
> 
> I'm open to suggestions how to handle this better, as long as the
> libvirt people are on board with the approach.

Ok, so we need a new class to handle making a device non-hotpluggable,
but I'm still not sure whether we should make:

 -device vfio-pci-ramfb

or

 -device vfio-pci-nohotplug,ramfb=on

Where ramfb would be a property only available on the nohotplug class
variant.  The latter seems to provide a lot more flexibility, but which
is more practical for libvirt?  Thanks,

Alex
