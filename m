Received: from eggs.gnu.org ([2001:4830:134:3::10]:56968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5acm-0005pA-AU
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d5acj-0006X0-4Z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:26:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d5aci-0006W0-R9
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:26:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42GNnT1144587
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 12:25:59 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a6vxxjcbw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:25:59 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 2 May 2017 17:25:55 +0100
Date: Tue, 2 May 2017 18:25:50 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170429123707.16675-1-aik@ozlabs.ru>
References: <20170429123707.16675-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170502182550.5edb9565.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH qemu v5] memory/iommu: QOM'fy IOMMU
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

On Sat, 29 Apr 2017 22:37:07 +1000
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

>  /**
> + * memory_region_init_iommu_type: Initialize a memory region of a custom type
> + * that translates addresses
> + *
> + * An IOMMU region translates addresses and forwards accesses to a target
> + * memory region.
> + *
> + * @typename: QOM class name
> + * @iommumr: the #IOMMUMemoryRegion to be initialized

<bikeshed>
I find "iommumr" terribly hard to read. Maybe iommu_mr is better? (Lots
of times in this patch.)
</bikeshed>

The s390 parts look fine.
