Received: from eggs.gnu.org ([2001:4830:134:3::10]:57038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJGSn-0003C1-Ty
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJGSn-00024j-4a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:48:49 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJGSm-00024c-Uf
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:48:49 -0400
Received: by mail-oi0-x242.google.com with SMTP id c203-v6so3547646oib.7
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 03:48:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1738f78f-b310-3cde-ac5e-1a147d3ca5f6@redhat.com>
References: <20180501085939.6201-1-peter.maydell@linaro.org>
	<c338d0d3-2b02-26e7-f745-fbc5c1893453@redhat.com>
	<CAFEAcA_Dei48HtKk6GnEgXYcXdY2htCXej4pSfY+q9V6f=abdA@mail.gmail.com>
	<1738f78f-b310-3cde-ac5e-1a147d3ca5f6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 11:48:27 +0100
Message-ID: <CAFEAcA-o3M2ruUfU7hk89S=eGgCP=b+hPyKrSdSR79OP_Ug9vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 15 May 2018 at 17:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 15/05/2018 18:28, Peter Maydell wrote:
>>
>> Presumably we also want a way for notifier users like vfio to
>> detect "I'm dealing with an IOMMU that is txattrs aware in a
>> way I can't deal with" so they can usefully bail out rather than
>> not working.
>>
>> Unfortunately I don't really know enough about our two current
>> users of notifiers (vhost and vfio) to know what they actually
>> need the iommu notifications for...
>
> As you guessed on IRC, they basically establish a shadow IOMMU page
> table or TLB.  My proposal would be to add two MemTxAttrs arguments to
> the IOMMUNotify typedef and to memory_region_notify_one, respectively to
> indicate which attributes matter (0 = indifferent, 1 = matter) and their
> value.  So far so good.
>
> Perhaps memory_region_register_iommu_notifier can also get an argument
> with the supported attributes.  The function would then fail if there
> are fewer bits set in that argument than what the IOMMU supports...

So I had an idea this morning for a slightly different way to approach
this, which is that we add a concept of an iommu_idx, analogous to
our existing TCG mmu_idx. Basically an iommu_idx represents a
page table (kind of like what Arm calls a "translation regime"), so
that for any particular iommu index and input address the output
address and permissions are always the same. For the memory
protection controller there would be two iommu_idxes, one for
secure and one for non-secure.

The API changes would be something like:
 * new method get_num_indexes() which returns the number of iommu indexes
   this IOMMU implements (default implementation: return 1)
 * translate method takes an iommu index (and not the txattrs)
 * new method index_from_attrs() which takes a MemTxAttrs and
   returns the iommu index that should be used (default implementation:
   always return 0)
 * memory_region_register_iommu_notifier() takes an iommu index
 * the default 'replay' method does "for each supported index,
   for each address, call @translate"
 * vfio and vhost can register their notifiers using the index
   returned by index_from_attrs(MEMTXATTRS_UNSPECIFIED)
 * maybe they could call get_num_indexes() and bail out if the
   IOMMU has support for multiple indexes?
 * maybe they could be enhanced to support tracking multiple
   page tables if necessary in future

I haven't worked through the details yet, but this seems to me
more flexible than working directly with txattrs. It also means
it's harder to accidentally write an iommu implementation that
looks at more fields in the txattrs than its notifier interface
claims are significant to it.

thanks
-- PMM
