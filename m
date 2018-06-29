Received: from eggs.gnu.org ([2001:4830:134:3::10]:42322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYx78-0004Xi-Q0
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYx77-0004DO-KF
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:23:18 -0400
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:38366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYx77-0004CQ-DP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:23:17 -0400
Received: by mail-ot0-x232.google.com with SMTP id w22-v6so10724414otk.5
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 10:23:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e3cd9aec-5cd4-bd81-eead-6cb14040d2d0@linaro.org>
References: <e3cd9aec-5cd4-bd81-eead-6cb14040d2d0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 18:22:55 +0100
Message-ID: <CAFEAcA9cezRcs6LGfYkKZ8LKDngu5n8HcQdSZ9Fmz+Cq3wEnZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu-system-aarch64 crash from kernel null pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 29 June 2018 at 00:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Given a debian standard 4.16.0 kernel,
>
> https://github.com/rth7680/qemu/tree/tgt-arm-sve-c
>
> will crash qemu:
>
> $ gdb --args ../bld/aarch64-softmmu/qemu-system-aarch64 \
>   -cpu max -M virt -m 4G -smp 8 \
>   -drive if=virtio,file=./deb-arm64.img,format=raw \
>   -bios /usr/share/edk2/aarch64/QEMU_EFI.fd
>
> (gdb) bt 5
> #0  0x00005555558017b3 in address_space_lookup_region (d=0x0, addr=0,
> resolve_subpage=false) at /home/rth/work/qemu/qemu/exec.c:416
> #1  0x00005555558018dc in address_space_translate_internal (d=0x0, addr=0,
> xlat=0x7fffdaefb478, plen=0x7fffdaefb540, resolve_subpage=false)
>     at /home/rth/work/qemu/qemu/exec.c:440
> #2  0x00005555558022b5 in address_space_translate_for_iotlb
> (cpu=0x7ffff7e2f010, asidx=1, addr=0, xlat=0x7fffdaefb548, plen=0x7fffdaefb540,
> attrs=..., prot=0x7fffdaefb520)
>     at /home/rth/work/qemu/qemu/exec.c:753
> #3  0x000055555587c5a7 in tlb_set_page_with_attrs (cpu=0x7ffff7e2f010, vaddr=0,
> paddr=0, attrs=..., prot=7, mmu_idx=3, size=4096)
>     at /home/rth/work/qemu/qemu/accel/tcg/cputlb.c:634
> #4  0x00005555559fe957 in arm_tlb_fill (cs=0x7ffff7e2f010, address=0,
> access_type=MMU_INST_FETCH, mmu_idx=3, fi=0x7fffdaefb680)
>     at /home/rth/work/qemu/qemu/target/arm/helper.c:10446
> #5  0x00005555559e6e7c in tlb_fill (cs=0x7ffff7e2f010, addr=1536, size=0,
> access_type=MMU_INST_FETCH, mmu_idx=3, retaddr=0)
>     at /home/rth/work/qemu/qemu/target/arm/op_helper.c:178

Yeah, we really shouldn't crash here, so we should investigate this.
I don't have a kernel binary so it would save me a bit of time if
you provided it (or you could investigate the crash yourself ;-))

thanks
-- PMM
