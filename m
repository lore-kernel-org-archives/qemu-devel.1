Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C2BC4360D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:16:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCB421D80
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ipeHKTGd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCB421D80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9y6-0007N2-FH
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41000)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9tj-00051A-Rt
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9ti-0000lY-2B
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:12:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iD9th-0000l7-Q7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:12:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id l3so7629590wru.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9iLeRBMimSs9vFLEpak/WeSOe7x8qLywP6xtQLKok5A=;
 b=ipeHKTGdH1MR96uZvDacDyBv5KBKgXrv5XLTF+4U6ntaVXxtfR0quM8MRnoSlVeuNk
 YIPB7tK0MHEyd1Ch/yx/y0Izqs9Y7A8WJgG1njiTnlBus5LXVYz7halM1o1YOCRs9f84
 sGcL2oXsPVKy602F+NyUyvc9oe4AWK5R6KlPFFdZLGrH2jm9pY/cvAFKOuBXrhfmoZIl
 l2STt8vN0mpf7qc+yP7zJPLdYjhgF43ulA2XHXivT6+Z30edYwzz70lyewmSoxpM2jyK
 YKcbQyyX7YzUgNPCQY5S9XlzBJLbY+0sUHyxJ8iwyHCT8hgjoFGbmyb1Oo2/Zjy+sfUr
 fBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9iLeRBMimSs9vFLEpak/WeSOe7x8qLywP6xtQLKok5A=;
 b=sfjmX5My1Bybts3ldCbQSWIU9KKjbDthJr+JRv3Ko2qYkJ571trcV3n2rxHjdl0LDo
 cVTqP5mf+o6ArlzINgfLCGDOVCutBUZK2cKerejx1Z6T0o+FfVpcHVuCABc7dWdoR4aS
 dCHFXu2ObcggKWXMb836CsIRvYyo3c409x2vp6/zu8BA7Fjfg4S1rQZuy9wRoymXO4bi
 ipiLG0Se6/NYTLwYL2veTh6ODiYawizccAJ9dxKkSdgULHBPm/CAlxVgKdbKf+OLIIHg
 CAM4NWtzb1tYJLBlp18hAcpDfRdU0dIfKRRsOTlH3Vvkwz3967ApdUyH9tuye6CkWR5p
 2D9A==
X-Gm-Message-State: APjAAAUwyedO5FHiH3bNeoDkMIQi2r6HzFMlB35PDE/PuR6+waXQe2Ht
 8EGGYi0kEy1sbnxS+yMwwMjQaw==
X-Google-Smtp-Source: APXvYqxAUnFgpoofNB0CqhYOwywsxDCGsZzljR01HH0tc9dkPXRuYOcqaWmeOs7uTglVZGUcSJrYMQ==
X-Received: by 2002:a05:6000:14c:: with SMTP id
 r12mr10141046wrx.303.1569427927744; 
 Wed, 25 Sep 2019 09:12:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s10sm6485599wmf.48.2019.09.25.09.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:12:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 37B0A1FF87;
 Wed, 25 Sep 2019 17:12:06 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-11-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 10/16] cputlb: Partially inline
 memory_region_section_get_iotlb
In-reply-to: <20190923230004.9231-11-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:12:06 +0100
Message-ID: <87r2449wyx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> There is only one caller, tlb_set_page_with_attrs.  We cannot
> inline the entire function because the AddressSpaceDispatch
> structure is private to exec.c, and cannot easily be moved to
> include/exec/memory-internal.h.
>
> Compute is_ram and is_romd once within tlb_set_page_with_attrs.
> Fold the number of tests against these predicates.  Compute
> cpu_physical_memory_is_clean outside of the tlb lock region.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/exec/exec-all.h |  6 +---
>  accel/tcg/cputlb.c      | 68 ++++++++++++++++++++++++++---------------
>  exec.c                  | 22 ++-----------
>  3 files changed, 47 insertions(+), 49 deletions(-)
>
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 81b02eb2fe..49db07ba0b 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -509,11 +509,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int=
 asidx, hwaddr addr,
>                                    hwaddr *xlat, hwaddr *plen,
>                                    MemTxAttrs attrs, int *prot);
>  hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section,
> -                                       target_ulong vaddr,
> -                                       hwaddr paddr, hwaddr xlat,
> -                                       int prot,
> -                                       target_ulong *address);
> +                                       MemoryRegionSection *section);
>  #endif
>
>  /* vl.c */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 05212ff244..05530a8b0c 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -704,13 +704,14 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>      MemoryRegionSection *section;
>      unsigned int index;
>      target_ulong address;
> -    target_ulong code_address;
> +    target_ulong write_address;
>      uintptr_t addend;
>      CPUTLBEntry *te, tn;
>      hwaddr iotlb, xlat, sz, paddr_page;
>      target_ulong vaddr_page;
>      int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
>      int wp_flags;
> +    bool is_ram, is_romd;
>
>      assert_cpu_is_self(cpu);
>
> @@ -739,18 +740,46 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>      if (attrs.byte_swap) {
>          address |=3D TLB_BSWAP;
>      }
> -    if (!memory_region_is_ram(section->mr) &&
> -        !memory_region_is_romd(section->mr)) {
> -        /* IO memory case */
> -        address |=3D TLB_MMIO;
> -        addend =3D 0;
> -    } else {
> +
> +    is_ram =3D memory_region_is_ram(section->mr);
> +    is_romd =3D memory_region_is_romd(section->mr);
> +
> +    if (is_ram || is_romd) {
> +        /* RAM and ROMD both have associated host memory. */
>          addend =3D (uintptr_t)memory_region_get_ram_ptr(section->mr) + x=
lat;
> +    } else {
> +        /* I/O does not; force the host address to NULL. */
> +        addend =3D 0;
> +    }
> +
> +    write_address =3D address;
> +    if (is_ram) {
> +        iotlb =3D memory_region_get_ram_addr(section->mr) + xlat;
> +        /*
> +         * Computing is_clean is expensive; avoid all that unless
> +         * the page is actually writable.
> +         */
> +        if (prot & PAGE_WRITE) {
> +            if (section->readonly) {
> +                write_address |=3D TLB_ROM;
> +            } else if (cpu_physical_memory_is_clean(iotlb)) {
> +                write_address |=3D TLB_NOTDIRTY;
> +            }
> +        }
> +    } else {
> +        /* I/O or ROMD */
> +        iotlb =3D memory_region_section_get_iotlb(cpu, section) + xlat;
> +        /*
> +         * Writes to romd devices must go through MMIO to enable write.
> +         * Reads to romd devices go through the ram_ptr found above,
> +         * but of course reads to I/O must go through MMIO.
> +         */
> +        write_address |=3D TLB_MMIO;
> +        if (!is_romd) {
> +            address =3D write_address;
> +        }
>      }
>
> -    code_address =3D address;
> -    iotlb =3D memory_region_section_get_iotlb(cpu, section, vaddr_page,
> -                                            paddr_page, xlat, prot, &add=
ress);
>      wp_flags =3D cpu_watchpoint_address_matches(cpu, vaddr_page,
>                                                TARGET_PAGE_SIZE);
>
> @@ -790,8 +819,8 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ul=
ong vaddr,
>      /*
>       * At this point iotlb contains a physical section number in the low=
er
>       * TARGET_PAGE_BITS, and either
> -     *  + the ram_addr_t of the page base of the target RAM (if NOTDIRTY=
 or ROM)
> -     *  + the offset within section->mr of the page base (otherwise)
> +     *  + the ram_addr_t of the page base of the target RAM (RAM)
> +     *  + the offset within section->mr of the page base (I/O, ROMD)
>       * We subtract the vaddr_page (which is page aligned and thus won't
>       * disturb the low bits) to give an offset which can be added to the
>       * (non-page-aligned) vaddr of the eventual memory access to get
> @@ -814,25 +843,14 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>      }
>
>      if (prot & PAGE_EXEC) {
> -        tn.addr_code =3D code_address;
> +        tn.addr_code =3D address;
>      } else {
>          tn.addr_code =3D -1;
>      }
>
>      tn.addr_write =3D -1;
>      if (prot & PAGE_WRITE) {
> -        tn.addr_write =3D address;
> -        if (memory_region_is_romd(section->mr)) {
> -            /* Use the MMIO path so that the device can switch states. */
> -            tn.addr_write |=3D TLB_MMIO;
> -        } else if (memory_region_is_ram(section->mr)) {
> -            if (section->readonly) {
> -                tn.addr_write |=3D TLB_ROM;
> -            } else if (cpu_physical_memory_is_clean(
> -                        memory_region_get_ram_addr(section->mr) + xlat))=
 {
> -                tn.addr_write |=3D TLB_NOTDIRTY;
> -            }
> -        }
> +        tn.addr_write =3D write_address;
>          if (prot & PAGE_WRITE_INV) {
>              tn.addr_write |=3D TLB_INVALID_MASK;
>          }
> diff --git a/exec.c b/exec.c
> index dc7001f115..961d7d6497 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1459,26 +1459,10 @@ bool cpu_physical_memory_snapshot_get_dirty(Dirty=
BitmapSnapshot *snap,
>
>  /* Called from RCU critical section */
>  hwaddr memory_region_section_get_iotlb(CPUState *cpu,
> -                                       MemoryRegionSection *section,
> -                                       target_ulong vaddr,
> -                                       hwaddr paddr, hwaddr xlat,
> -                                       int prot,
> -                                       target_ulong *address)
> +                                       MemoryRegionSection *section)
>  {
> -    hwaddr iotlb;
> -
> -    if (memory_region_is_ram(section->mr)) {
> -        /* Normal RAM.  */
> -        iotlb =3D memory_region_get_ram_addr(section->mr) + xlat;
> -    } else {
> -        AddressSpaceDispatch *d;
> -
> -        d =3D flatview_to_dispatch(section->fv);
> -        iotlb =3D section - d->map.sections;
> -        iotlb +=3D xlat;
> -    }
> -
> -    return iotlb;
> +    AddressSpaceDispatch *d =3D flatview_to_dispatch(section->fv);
> +    return section - d->map.sections;
>  }
>  #endif /* defined(CONFIG_USER_ONLY) */


--
Alex Benn=C3=A9e

