Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D1C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351B220872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 00:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YlxCWLhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351B220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCv1O-0004hc-8T
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 20:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCuyU-0002Ks-Hf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCuyS-0008HJ-BK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:16:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCuyS-0008H7-3a
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 20:16:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id y21so2221518wmi.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 17:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0ODopj+No7wKifKkAPpUYP23m+jkzTaNVUbH4b2Bk5U=;
 b=YlxCWLhEUgODUE5StXLN0sfwdZokgFpYk0nhd78oOo3c5cWTIYpfW1ur09o0FdmxSq
 irndlgr9FKO6rb4TCWGe45SQu43Yz5YLGUv3NfuuDhDCQ32Mor6T6RCLgiKuWypzbTRL
 9p04rxoFn4T+9yiM9hjzSbcM41obmtCAWgZJhGuNZdJdFKRA8E6+MuCFx3yJSKUWv/C+
 WkdW5Q7Z1Dm7JN5CD3O3a7jMRGFoLkYgJadmq7jrGWQM9iMaD9WYu+zMxtxAtkbpL8jb
 IuiOEKbGOTkq7PPTem+f1O86NUSwGx/GRoosDsCzCcwqdGnowsteqHsdXvKHpTjVD7el
 rPbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0ODopj+No7wKifKkAPpUYP23m+jkzTaNVUbH4b2Bk5U=;
 b=WK5SYbRvKmIg3AnuruRSYiT7+ohEQFcjLddaj6Bg40FjxFoT7s+cB5UEkFXLeV7yQD
 3nXmqr9jQz0qRbH38NeDLMUE0vzunPMiW7rpjSV9sIbuskcbmCH8mbgZfvX9F/Hogn/1
 wpZYgvazmqbx3pXEexSutHOhfg5XF+U4s56esVYA16gOOO0Ssp0S71kDI50Ow2ssh37x
 gvkAzEu5I0jhGPg4hamnPJ4AHUKDoVUf06ZliWuV7S12bsCroZhMI2+YkbP4p+H7eWVZ
 zloiBDMY+3RRD8Ivc5b0r18n0nwKRQ/XlvnCjlDvc7PoRk2dskF832P99IAA6hTd2xPF
 oKdA==
X-Gm-Message-State: APjAAAWCblEUMMon8uudjnl/HOrIg/fYLu51DsaNavBkGLco65i+GIx1
 gh3kLBnRHVbDsCiQZlXv1n2GQA==
X-Google-Smtp-Source: APXvYqxg8id2fn7BkNvzI3qxkCG2WaLjG1BBfuRsLvAjc87CFCJgIM9ecipoDqiEsE4e0FYUNWsZWQ==
X-Received: by 2002:a1c:1fd3:: with SMTP id f202mr3571554wmf.18.1569370562398; 
 Tue, 24 Sep 2019 17:16:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b15sm1918971wmb.28.2019.09.24.17.16.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 17:16:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F16FB1FF87;
 Wed, 25 Sep 2019 01:16:00 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-9-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 08/16] cputlb: Move ROM handling from I/O path to TLB
 path
In-reply-to: <20190923230004.9231-9-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 01:16:00 +0100
Message-ID: <87v9th9qnz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

> It does not require going through the whole I/O path
> in order to discard a write.
>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h    |  5 ++++-
>  include/exec/cpu-common.h |  1 -
>  accel/tcg/cputlb.c        | 35 +++++++++++++++++++--------------
>  exec.c                    | 41 +--------------------------------------
>  4 files changed, 25 insertions(+), 57 deletions(-)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index d148bded35..26547cd6dd 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
<snip>
> @@ -822,16 +821,17 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_=
ulong vaddr,
>
>      tn.addr_write =3D -1;
>      if (prot & PAGE_WRITE) {
> -        if ((memory_region_is_ram(section->mr) && section->readonly)
> -            || memory_region_is_romd(section->mr)) {
> -            /* Write access calls the I/O callback.  */
> -            tn.addr_write =3D address | TLB_MMIO;
> -        } else if (memory_region_is_ram(section->mr)
> -                   && cpu_physical_memory_is_clean(
> -                       memory_region_get_ram_addr(section->mr) + xlat)) {
> -            tn.addr_write =3D address | TLB_NOTDIRTY;
> -        } else {
> -            tn.addr_write =3D address;
> +        tn.addr_write =3D address;
> +        if (memory_region_is_romd(section->mr)) {
> +            /* Use the MMIO path so that the device can switch states. */
> +            tn.addr_write |=3D TLB_MMIO;
> +        } else if (memory_region_is_ram(section->mr)) {
> +            if (section->readonly) {
> +                tn.addr_write |=3D TLB_ROM;
> +            } else if (cpu_physical_memory_is_clean(
> +                        memory_region_get_ram_addr(section->mr) + xlat))=
 {
> +                tn.addr_write |=3D TLB_NOTDIRTY;
> +            }

This reads a bit weird because we are saying romd isn't a ROM but
something that identifies as RAM can be ROM rather than just a memory
protected piece of RAM.

>          }
>          if (prot & PAGE_WRITE_INV) {
>              tn.addr_write |=3D TLB_INVALID_MASK;

So at the moment I don't see what the TLB_ROM flag gives us that setting
TLB_INVALID doesn't - either way we won't make the write to our
ram-not-ram-rom.

> @@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
>      cpu->mem_io_pc =3D retaddr;
> -    if (mr !=3D &io_mem_rom && mr !=3D &io_mem_notdirty && !cpu->can_do_=
io) {
> +    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>
> @@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attr=
s);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> -    if (mr !=3D &io_mem_rom && mr !=3D &io_mem_notdirty && !cpu->can_do_=
io) {
> +    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>      cpu->mem_io_vaddr =3D addr;
> @@ -1125,7 +1125,7 @@ void *probe_access(CPUArchState *env, target_ulong =
addr, int size,
>      }
>
>      /* Reject I/O access, or other required slow-path.  */
> -    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP)) {
> +    if (tlb_addr & (TLB_NOTDIRTY | TLB_MMIO | TLB_BSWAP | TLB_ROM)) {
>          return NULL;
>      }
>
> @@ -1613,6 +1613,11 @@ store_helper(CPUArchState *env, target_ulong addr,=
 uint64_t val,
>              return;
>          }
>
> +        /* Ignore writes to ROM.  */
> +        if (unlikely(tlb_addr & TLB_ROM)) {
> +            return;
> +        }
> +
>          haddr =3D (void *)((uintptr_t)addr + entry->addend);
>
>          if (unlikely(need_swap)) {
> diff --git a/exec.c b/exec.c
> index 5f2587b621..ea8c0b18ac 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -88,7 +88,7 @@ static MemoryRegion *system_io;
>  AddressSpace address_space_io;
>  AddressSpace address_space_memory;
>
> -MemoryRegion io_mem_rom, io_mem_notdirty;
> +MemoryRegion io_mem_notdirty;
>  static MemoryRegion io_mem_unassigned;
>  #endif
>
> @@ -192,7 +192,6 @@ typedef struct subpage_t {
>
>  #define PHYS_SECTION_UNASSIGNED 0
>  #define PHYS_SECTION_NOTDIRTY 1
> -#define PHYS_SECTION_ROM 2
>
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> @@ -1475,8 +1474,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cp=
u,
>          iotlb =3D memory_region_get_ram_addr(section->mr) + xlat;
>          if (!section->readonly) {
>              iotlb |=3D PHYS_SECTION_NOTDIRTY;
> -        } else {
> -            iotlb |=3D PHYS_SECTION_ROM;
>          }
>      } else {
>          AddressSpaceDispatch *d;
> @@ -3002,38 +2999,6 @@ static uint16_t dummy_section(PhysPageMap *map, Fl=
atView *fv, MemoryRegion *mr)
>      return phys_section_add(map, &section);
>  }
>
> -static void readonly_mem_write(void *opaque, hwaddr addr,
> -                               uint64_t val, unsigned size)
> -{
> -    /* Ignore any write to ROM. */
> -}
> -
> -static bool readonly_mem_accepts(void *opaque, hwaddr addr,
> -                                 unsigned size, bool is_write,
> -                                 MemTxAttrs attrs)
> -{
> -    return is_write;
> -}
> -
> -/* This will only be used for writes, because reads are special cased
> - * to directly access the underlying host ram.
> - */
> -static const MemoryRegionOps readonly_mem_ops =3D {
> -    .write =3D readonly_mem_write,
> -    .valid.accepts =3D readonly_mem_accepts,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> -    .valid =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -        .unaligned =3D false,
> -    },
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 8,
> -        .unaligned =3D false,
> -    },
> -};
> -
>  MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>                                        hwaddr index, MemTxAttrs attrs)
>  {
> @@ -3047,8 +3012,6 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
>
>  static void io_mem_init(void)
>  {
> -    memory_region_init_io(&io_mem_rom, NULL, &readonly_mem_ops,
> -                          NULL, NULL, UINT64_MAX);
>      memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops,=
 NULL,
>                            NULL, UINT64_MAX);
>
> @@ -3069,8 +3032,6 @@ AddressSpaceDispatch *address_space_dispatch_new(Fl=
atView *fv)
>      assert(n =3D=3D PHYS_SECTION_UNASSIGNED);
>      n =3D dummy_section(&d->map, fv, &io_mem_notdirty);
>      assert(n =3D=3D PHYS_SECTION_NOTDIRTY);
> -    n =3D dummy_section(&d->map, fv, &io_mem_rom);
> -    assert(n =3D=3D PHYS_SECTION_ROM);
>
>      d->phys_map  =3D (PhysPageEntry) { .ptr =3D PHYS_MAP_NODE_NIL, .skip=
 =3D 1 };


--
Alex Benn=C3=A9e

