Received: from eggs.gnu.org ([2001:4830:134:3::10]:46908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7bX3-0004Au-52
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7bWz-0002f7-4i
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:48:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7bWy-0002ex-VO
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:48:25 -0400
Date: Mon, 8 May 2017 13:48:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170508054814.GA2820@pxdev.xzpeter.org>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170501045822.GM13773@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Mon, May 01, 2017 at 02:58:22PM +1000, David Gibson wrote:
> On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> > This is something similar to MemoryRegionOps, it's just for address
> > spaces to store arch-specific hooks.
> > 
> > The first hook I would like to introduce is iommu_get().
> > 
> > For systems that have IOMMUs, we will create a special address space per
> > device which is different from system default address space for
> > it (please refer to pci_device_iommu_address_space()). Normally when
> > that happens, there will be one specific IOMMU (or say, translation
> > unit) stands right behind that new address space.
> > 
> > This iommu_get() fetches that guy behind the address space. Here, the
> > guy is defined as IOMMUObject, which is currently a (void *). In the
> > future, maybe we can make it a better definition, but imho it's good
> > enough for now, considering it's arch-dependent.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> This doesn't make sense to me.  It would be entirely possible for a
> single address space to have different regions mapped by different
> IOMMUs.  Or some regions mapped by IOMMUs and others direct mapped to
> a device or memory block.

Oh, so it's more complicated than I thought... Then, do we really have
existing use case that one device is managed by more than one IOMMU
(on any of the platform)? Frankly speaking I haven't thought about
complicated scenarios like this, or nested IOMMUs yet.

This patch derived from a requirement in virt-svm project (on x86).
Virt-svm needs some notification mechanism for each IOMMU (or say, the
IOMMU that managers the SVM-enabled device). For now, all IOMMU
notifiers are per-memory-region not per-iommu, and that's imho not
what virt-svm wants. Any suggestions?

Thanks,

-- 
Peter Xu
