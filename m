Received: from eggs.gnu.org ([2001:4830:134:3::10]:40615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1clXhj-0002dp-GN
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:16:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1clXhf-0002NC-FM
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:16:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1clXhf-0002LZ-9Y
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:16:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8351B6AAC2
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 09:16:15 +0000 (UTC)
Date: Wed, 8 Mar 2017 17:16:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170308091608.GE7135@pxdev.xzpeter.org>
References: <1488877751-13419-1-git-send-email-jasowang@redhat.com>
	<7594c183-6d38-3dce-75e7-62bf3be324fc@redhat.com>
	<20170308024349.GC31585@pxdev.xzpeter.org>
	<9d2dd1a4-aadc-a497-3dbb-6afb6d621587@redhat.com>
	<5b388627-dcae-6c11-008d-f3c5da57b334@redhat.com>
	<20170308090945.GD7135@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170308090945.GD7135@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH V3] virtio: do not require IOMMU to be
 created in advance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Mar 08, 2017 at 05:09:45PM +0800, Peter Xu wrote:
> On Wed, Mar 08, 2017 at 10:17:09AM +0200, Marcel Apfelbaum wrote:
> 
> [...]
> 
> > 
> > I am sorry I was not clear enough:
> > If a device is added after the system is up (hotplug), we cannot depend on the "machine_done"
> > event to enable "bus master".
> > This is why we have
> >    if (qdev_hotplug)
> >         pci_init_bus_master(pci_dev);
> > 
> > The code you proposed changes the order, so this call is done *after* realize.
> > 
> > My question was: What if any other device may require the bus_master_as
> > at realize time (and can be hot-plugged) ?
> > For example: hcd-ehci/hcd-ohci devices call pci_get_address_space()
> > and caches the bus_master_as.
> 
> Oh, I didn't notice that there are other devices that used
> bus_master_as during realization. If so... Would this really work even
> without hot plug? Considering that bus_master_as won't be inited until
> machine done phase?

Please ignore my question... I think the answer is that these devices
are only caching the pointer of bus_master_as. So it won't really use
the address space before machine_done.

If so, IMHO moving pci_init_bus_master() after device specific
realize() is okay as well then, right?

Thanks,

-- peterx
