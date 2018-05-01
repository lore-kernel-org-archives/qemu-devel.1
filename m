Received: from eggs.gnu.org ([2001:4830:134:3::10]:45541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDR6T-0002He-4V
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fDR6S-0006us-6L
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:57:41 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:46419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fDR6S-0006ua-0p
	for qemu-devel@nongnu.org; Tue, 01 May 2018 04:57:40 -0400
Received: by mail-ot0-x22b.google.com with SMTP id t1-v6so12332566ott.13
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 01:57:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430181905.32327-1-peter.maydell@linaro.org>
References: <20180430181905.32327-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 May 2018 09:57:18 +0100
Message-ID: <CAFEAcA9mkV+9rmdVEMaz0msK9wej_kgGcyMx=i6Gt+CVCT2qaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] iommu: add MemTxAttrs argument
 to IOMMU translate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 30 April 2018 at 19:18, Peter Maydell <peter.maydell@linaro.org> wrote:
> This is an RFC patchset because it's a little bit unmotivated
> and only lightly tested, but in principle it could be
> committed, so half-RFC-half-not :-)
>
> The Arm SMMU wants to know if the transaction it is handling
> is secure/nonsecure and user/privileged, because the iommu
> page tables can be configured by the guest to only allow
> transactions which satisfy those criteria. At the moment
> Eric's implementation ignores all that, because we don't
> provide the IOMMUMemoryRegion translate function with any
> memory transaction attribute information. This patchset fixes
> that by plumbing through transaction attributes.
>
> Most of the patchset is just starting at the leaves of the calltree
> rooted at "flatview_do_translate()" and making callsites provide
> attributes where appropriate or plumbing through existing attribute
> information where it exists.  General principles of when I made a
> caller pass MEMTXATTRS_UNSPECIFIED and when I had it take an
> attrs value from further up:
>  * dma_memory_* functions all assume UNSPECIFIED (matching
>    the read/write/rw functions that already do that)
>  * cpu_physical_memory_* also all assume UNSPECIFIED,
>    following the pattern of existing functions in that family
>  * address_space_* take an attributes argument, by analogy
>    with existing functions in that family
>  * endpoints like target-specific code or vhost has to
>    provide attributes, but for all the targets affected here
>    they don't care about attributes and can use UNSPECIFIED
>
> As well as the SMMU, I'm also thinking about using the IOMMU
> infrastructure for the v8M Memory Protection Controller
> (though that is a bit trickier as I also need it to support
> TCG execution in an IOMMU-controlled region, which is an
> orthogonal bit of work to attribute support).
>
> Based-on: <20180430122404.10741-1-peter.maydell@linaro.org>
> ("memory.h: Improve IOMMU related documentation") but
> only for textual reasons.
>
> thanks
> -- PMM
>
> Peter Maydell (11):
>   Make address_space_translate() take a MemTxAttrs argument
>   Make address_space_map() take a MemTxAttrs argument
>   Make address_space_access_valid() take a MemTxAttrs argument
>   Make flatview_extend_translation() take a MemTxAttrs argument
>   Make memory_region_access_valid() take a MemTxAttrs argument
>   Make MemoryRegion valid.accepts callback take a MemTxAttrs argument
>   Make flatview_access_valid() take a MemTxAttrs argument
>   Make flatview_translate() take a MemTxAttrs argument
>   Make address_space_get_iotlb_entry() take a MemTxAttrs argument
>   Make flatview_do_translate() take a MemTxAttrs argument
>   Add MemTxAttrs argument to IOMMU translate function

Whoops, I misdrove the git format-patch command and it's missing
what should have been patch 1 in the set:
    Make tb_invalidate_phys_addr() take a MemTxAttrs argument

I'll resend the series, that's probably easiest.

-- PMM
