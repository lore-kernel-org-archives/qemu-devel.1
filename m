Received: from eggs.gnu.org ([2001:4830:134:3::10]:36781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eErwN-0001fJ-Ls
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:16:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eErwI-0002PJ-OH
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:16:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eErwI-0002OM-H8
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 02:16:50 -0500
Date: Wed, 15 Nov 2017 15:16:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171115071632.GF6821@xz-mi>
References: <1509710516-21084-1-git-send-email-yi.l.liu@linux.intel.com>
	<1509710516-21084-3-git-send-email-yi.l.liu@linux.intel.com>
	<20171113055601.GE1014@umbus.fritz.box>
	<20171113095847.GA9527@sky-dev>
	<ac8ab4be-802e-09ca-b31c-78cf3399aad9@redhat.com>
	<20171114135904.GA3895@sky-dev>
	<cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cce959ac-939c-3b34-6aeb-33e6be353066@redhat.com>
Subject: Re: [Qemu-devel] [RESEND PATCH 2/6] memory: introduce
 AddressSpaceOps and IOMMUObject
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, mst@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>

On Tue, Nov 14, 2017 at 10:52:54PM +0100, Auger Eric wrote:

[...]

> I meant, in the current intel_iommu code, vtd_find_add_as() creates 1
> IOMMU MR and 1 AS per PCIe device, right?

I think this is the most tricky point - in QEMU IOMMU MR is not really
a 1:1 relationship to devices.  For Intel, it's true; for Power, it's
not.  On Power guests, one device's DMA address space can be splited
into different translation windows, while each window corresponds to
one IOMMU MR.

So IMHO the real 1:1 mapping is between the device and its DMA address
space, rather than MRs.

It's been a long time since when I drafted the patches.  I think at
least that should be a more general notifier mechanism comparing to
current IOMMUNotifier thing, which was bound to IOTLB notifies only.
AFAICT if we want to trap first-level translation changes, current
notifier is not even close to that interface - just see the definition
of IOMMUTLBEntry, it is tailored only for MAP/UNMAP of translation
addresses, not anything else.  And IMHO that's why it's tightly bound
to MemoryRegions, and that's the root problem.  The dynamic IOMMU MR
switching problem is related to this issue as well.

I am not sure current "get IOMMU object from address space" solution
would be best, maybe it's "too bigger a scope", I think it depends on
whether in the future we'll have some requirement in such a bigger
scope (say, something we want to trap from vIOMMU and deliver it to
host IOMMU which may not even be device-related?  I don't know).  Now
another alternative I am thinking is, whether we can provide a
per-device notifier, then it can be bound to PCIDevice rather than
MemoryRegions, then it will be in device scope.

Thanks,

-- 
Peter Xu
