Received: from eggs.gnu.org ([2001:4830:134:3::10]:56275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6aqm-0006UM-0P
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6aqi-0003yB-St
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:52:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6aqi-0003we-Kj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:52:36 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45AmeMs049920
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 06:52:35 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8eck7kt9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 06:52:34 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 5 May 2017 11:52:31 +0100
Date: Fri, 5 May 2017 12:52:26 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170505101930.45837-1-aik@ozlabs.ru>
References: <20170505101930.45837-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170505125226.5c962179.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH qemu v6] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Fri,  5 May 2017 20:19:30 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> as a parent.
> 
> This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> dymanic QOM casting in fast path (address_space_translate, etc),
> this adds an @is_iommu boolean flag to MR and provides new helper to
> do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> is set in the instance init callback. This defines
> memory_region_is_iommu as memory_region_get_iommu()!=NULL.
> 
> This switches MemoryRegion to IOMMUMemoryRegion in most places except
> the ones where MemoryRegion may be an alias.
> 
> This defines memory_region_init_iommu_type() to allow creating
> IOMMUMemoryRegion subclasses. In order to support custom QOM type,
> this splits memory_region_init() to object_initialize() +
> memory_region_do_init.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v6:
> * s/\<iommumr\>/iommu_mr/g
> 
> v5:
> * fixed sparc64, first time in many years did run "./configure" without
> --target-list :-D Sorry for the noise though :(
> 
> v4:
> * fixed alpha, mips64el and sparc
> 
> v3:
> * rebased on sha1 81b2d5ceb0
> 
> v2:
> * added mr->is_iommu
> * updated i386/x86_64/s390/sun
> ---
>  hw/s390x/s390-pci-bus.h       |   2 +-
>  include/exec/memory.h         |  77 +++++++++++++++++++-------
>  include/hw/i386/intel_iommu.h |   2 +-
>  include/hw/mips/mips.h        |   2 +-
>  include/hw/ppc/spapr.h        |   3 +-
>  include/hw/vfio/vfio-common.h |   2 +-
>  include/qemu/typedefs.h       |   1 +
>  exec.c                        |  16 +++---
>  hw/alpha/typhoon.c            |   8 ++-
>  hw/dma/rc4030.c               |   8 +--
>  hw/i386/amd_iommu.c           |   9 +--
>  hw/i386/intel_iommu.c         |  17 +++---
>  hw/mips/mips_jazz.c           |   2 +-
>  hw/pci-host/apb.c             |   6 +-
>  hw/ppc/spapr_iommu.c          |  20 ++++---
>  hw/s390x/s390-pci-bus.c       |   6 +-
>  hw/s390x/s390-pci-inst.c      |   8 +--
>  hw/vfio/common.c              |  12 ++--
>  hw/vfio/spapr.c               |   3 +-
>  memory.c                      | 124 +++++++++++++++++++++++++++++-------------
>  20 files changed, 213 insertions(+), 115 deletions(-)

Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
