Received: from eggs.gnu.org ([2001:4830:134:3::10]:46426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d1692-0004lH-CW
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:04:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d168y-0008Lj-Bl
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d168y-0008LR-5B
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 03:04:44 -0400
Date: Thu, 20 Apr 2017 15:04:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170420070420.GF26087@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257439054049@shsmsx102.ccr.corp.intel.com>
	<20170418045400.GC22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390540D1@shsmsx102.ccr.corp.intel.com>
	<20170418072717.GD22226@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439054360@shsmsx102.ccr.corp.intel.com>
	<672ae592-e6ba-9152-b775-ec2bde931ef1@intel.com>
	<20170420030427.GA26087@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C2574390555FB@shsmsx102.ccr.corp.intel.com>
	<20170420054018.GD26087@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257439055667@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439055667@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v2 7/7] intel_iommu: support passthrough
 (PT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, "Tian, Kevin" <kevin.tian@intel.com>

On Thu, Apr 20, 2017 at 06:36:16AM +0000, Liu, Yi L wrote:

[...]

> > > In my understanding, container->space->as->root cannot work here no
> > > matter passthru-mode is enabled or not. The code here is aiming to
> > > check if vIOMMU exists. After the vfio series, the vtd_dev_as->root is
> > > not initialized to be a iommu MemoryRegion. Compared with checking if
> > > it is system_memory(), I think adding a mechanism to get the iommu
> > MemoryRegion may be a better choice. Just like the current
> > pci_device_iommu_address_space().
> > 
> > Isn't pci_device_iommu_address_space() used to get that IOMMU memory region?

Again I should say s/memory region/address space/...

> 
> It actually returns the AddressSpace, and the AddressSpace includes a memory region.
> It is as->root. But after adding the vfio series, through the IOMMU memory region
> is got, but it has no iommu_ops. Just as the following code shows. That's why I said
> even without passthru-mode, Tianyu's that code snippet is not able to get the correct
> check.
> 
>         memory_region_init(&vtd_dev_as->root, OBJECT(s),
>                            "vtd_root", UINT64_MAX);
>         address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, name);

The problem is, I am not sure whether there is always _only_ one IOMMU
region behind one device. E.g., IIUC ppc can have more than one IOMMU
memory regions, but translate for different address ranges.

Thanks,

-- 
Peter Xu
