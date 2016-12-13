Received: from eggs.gnu.org ([2001:4830:134:3::10]:59637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cGmcv-0000e8-8s
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1cGmcr-000233-9K
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:56:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1cGmcr-00022u-0u
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:56:09 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBDCsoTE054956
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 07:56:07 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27acdaqw0y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 07:56:06 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 13 Dec 2016 05:56:06 -0700
References: <20161212111857.23399-1-pbonzini@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 13 Dec 2016 13:56:00 +0100
MIME-Version: 1.0
In-Reply-To: <20161212111857.23399-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <13f7fc4b-3869-f150-f692-634cf9053998@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] speedup vring processing with
 MemoryRegionCaches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, mst@redhat.com

On 12/12/2016 12:18 PM, Paolo Bonzini wrote:
> It is known that virtio's usage of ld_*_phys and st_*_phys functions
> wastes time in address_space_translate, visiting the
> AddressSpaceDispatch's radix tree.
> 
> This series introduces a small cache that changes these functions
> to a simple range check and memory access.  The effect is a bit
> underwhelming, because the improvement is only 1-2Kiops/second.
> Nevertheless I'm throwing out the patches so that for example they
> can be tested on s390.

It does seem to save some cpu cycles and by that it gives some benefit
if you are cpu bound (e.g. with just one host CPU I get ~4% benefit in 
terms of throughput)

> 
> Things to fix: handle address_space_cache_init failures
> in virtio_init_region_cache.  Also, once virtio breaks free of
> address_space_memoory, we'll need to handle invalidation in IOMMU regions.
> For the latter, maybe it's worth introducing a new abstraction that
> is higher-level than MemoryListener and covers both regular and IOMMU
> memory regions.
> 
> Paolo
> 
> Paolo Bonzini (11):
>   exec: optimize remaining address_space_* cases
>   exec: introduce memory_ldst.inc.c
>   exec: introduce address_space_extend_translation
>   exec: introduce MemoryRegionCache
>   virtio: make virtio_should_notify static
>   virtio: add virtio_*_phys_cached
>   virtio: use address_space_map/unmap to access descriptors
>   virtio: use MemoryRegionCache to access descriptors
>   virtio: add MemoryListener to cache ring translations
>   virtio: use VRingMemoryRegionCaches for descriptor ring
>   virtio: use VRingMemoryRegionCaches for avail and used rings
> 
>  exec.c                            | 687 +++++-------------------------------
>  hw/net/virtio-net.c               |  14 +-
>  hw/virtio/virtio.c                | 322 +++++++++++++----
>  include/exec/cpu-all.h            |  23 ++
>  include/exec/cpu-common.h         |  15 -
>  include/exec/memory.h             | 166 +++++++++
>  include/hw/virtio/virtio-access.h |  52 +++
>  include/hw/virtio/virtio.h        |   2 +-
>  include/qemu/typedefs.h           |   1 +
>  memory_ldst.inc.c                 | 709 ++++++++++++++++++++++++++++++++++++++
>  10 files changed, 1316 insertions(+), 675 deletions(-)
>  create mode 100644 memory_ldst.inc.c
> 
