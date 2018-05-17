Received: from eggs.gnu.org ([2001:4830:134:3::10]:36276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJIJ6-0008T3-37
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fJIJ2-0000FC-Ua
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:46:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fJIJ2-0000E2-P3
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:46:52 -0400
References: <20180501085939.6201-1-peter.maydell@linaro.org>
	<c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
	<CAFEAcA_Dei48HtKk6GnEgXYcXdY2htCXej4pSfY+q9V6f=abdA@mail.gmail.com>
	<1738f78f-b310-3cde-ac5e-1a147d3ca5f6@redhat.com>
	<CAFEAcA-o3M2ruUfU7hk89S=eGgCP=b+hPyKrSdSR79OP_Ug9vg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d52e9bd-93e7-58fd-af73-8eccda3bcb63@redhat.com>
Date: Thu, 17 May 2018 14:46:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-o3M2ruUfU7hk89S=eGgCP=b+hPyKrSdSR79OP_Ug9vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/12] iommu: add MemTxAttrs
 argument to IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 17/05/2018 12:48, Peter Maydell wrote:
> So I had an idea this morning for a slightly different way to approach
> this, which is that we add a concept of an iommu_idx, analogous to
> our existing TCG mmu_idx. Basically an iommu_idx represents a
> page table (kind of like what Arm calls a "translation regime"), so
> that for any particular iommu index and input address the output
> address and permissions are always the same. For the memory
> protection controller there would be two iommu_idxes, one for
> secure and one for non-secure.
> 
> The API changes would be something like:
>  * new method get_num_indexes() which returns the number of iommu indexes
>    this IOMMU implements (default implementation: return 1)
>  * translate method takes an iommu index (and not the txattrs)
>  * new method index_from_attrs() which takes a MemTxAttrs and
>    returns the iommu index that should be used (default implementation:
>    always return 0)
>  * memory_region_register_iommu_notifier() takes an iommu index
>  * the default 'replay' method does "for each supported index,
>    for each address, call @translate"
>  * vfio and vhost can register their notifiers using the index
>    returned by index_from_attrs(MEMTXATTRS_UNSPECIFIED)
>  * maybe they could call get_num_indexes() and bail out if the
>    IOMMU has support for multiple indexes?
>  * maybe they could be enhanced to support tracking multiple
>    page tables if necessary in future
> 
> I haven't worked through the details yet, but this seems to me
> more flexible than working directly with txattrs. It also means
> it's harder to accidentally write an iommu implementation that
> looks at more fields in the txattrs than its notifier interface
> claims are significant to it.

Yes, this also sounds good.  It does have the same issue for VFIO that
get_num_indexes() would be called too late to fail (and again, in a
place where it's hard to fail).

Maybe the index count and the index-from/to-attrs translation should be
static (index-to-attrs could use the same pair of MemTxAttrs for "which
bits matter" and "what value should they have"), so that VFIO can
inspect it and decide if it's okay to proceed with e.g. the first iommu_idx?

Thanks,

Paolo
