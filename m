Received: from eggs.gnu.org ([2001:4830:134:3::10]:45313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEfdY-0005Ps-B3
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:08:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eEfdT-0000pi-7t
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:08:40 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eEfdT-0000p3-1t
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 13:08:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id b189so16959218wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 10:08:35 -0800 (PST)
References: <alpine.BSF.2.21.1707270007490.20438@zero.eik.bme.hu>
	<alpine.BSF.2.21.1708192307590.44932@zero.eik.bme.hu>
	<alpine.BSF.2.21.1708202246550.65843@zero.eik.bme.hu>
	<d4ffee34-8a82-95ea-bedc-ed37ae5fae67@ilande.co.uk>
	<alpine.BSF.2.21.1710081718490.54240@zero.eik.bme.hu>
	<alpine.BSF.2.21.1710151239410.57072@zero.eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59a84d4f-08c9-5ddb-d487-08026c9cefa3@redhat.com>
Date: Tue, 14 Nov 2017 19:08:26 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1710151239410.57072@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] How to debug crash in TCG code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org

On 15/10/2017 13:30, BALATON Zoltan wrote:
> I've got a bit further with this but still could use some hints to find
> what is happening. Here are some more details I've found so far.
> 
> The memory map I have (see below) is a bit complex but the interesting
> part is that I have sii3112.bar5 as an mmio region with sii3112.bar0-4
> as io region aliases into this. The crash is happening when the firmware
> is accessing one of these aliased io regions when
> 
> tlb_set_page_with_attrs: vaddr=d8001000 paddr=0x0000000c08001000 prot=3
> idx=1
> 
> is called in accel/tcg/cputlb.c:616 which then calls
> 
> 635        section = address_space_translate_for_iotlb(cpu, asidx,
> paddr, &xlat, &sz);
> 
> this in turn calls address_space_translate_internal which calls
> 
> 441        section = address_space_lookup_region(d, addr, resolve_subpage);
> 
> that eventually gets the cached section at exec.c:411
> 
> 411        MemoryRegionSection *section = atomic_read(&d->mru_section);
> 
> When this is not a region covering the address as verifed by

Could it be that the cached region is only for a small part of the page,
while phys_page_find returns a subpage (and resolve_subpage is false)?

Maybe it's enough to skip mru_section if resolve_subpage is false.

Thanks,

Paolo
