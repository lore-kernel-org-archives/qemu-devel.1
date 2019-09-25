Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4D7C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941C82146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W5n8kOVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941C82146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9rk-0001jT-RI
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9nz-0005vr-P5
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:06:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9nx-0007J1-HZ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:06:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40698)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iD9nx-0007HI-0L
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:06:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id b24so5566728wmj.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xIr7kGQVFYi8Rx/WrnCQMQN7qigP2h6mkNh+yC2A4dI=;
 b=W5n8kOVzIg28hRLGXVe3jbT++X1AaoPQtx1z8/hYy8uuUpG4xK21CN7Ek9y0jUHjUc
 l/VaYPif1n/kFshooE1uA2EKQUr7zGrpzbVrcYPWZTmB5MRGXu36FGeVMnUTXf0wE1j2
 CR0qJ2YunoHIA6s1Sm+zM6lzheUyV2uXWFmZUyDCNW4tASJUshoqvPntgyptraBsjOD9
 EVHpBPMUt9J+CzfcY+SYWJ7Go8orSznAGFCCwutppbY7ENmOZ5Gj0m7raS7slRjJBzgA
 INspldZEunVOP6jgZl7nOdSyfR8E1zmDTtw0ucGXVF9hX9/f3yJ8VZLtYC6JXby1xEPB
 gliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xIr7kGQVFYi8Rx/WrnCQMQN7qigP2h6mkNh+yC2A4dI=;
 b=EPU2/1UrRCuImJMGgeaECZVTxbjVTToJ8oagd/eiJED7lT9v2j42vfjkAOlzRtF0Uc
 BOi7amsegL3QuNcwbjrTq+BPFjgJtLD3k35QJpbiTo/BBBX775lXQDk7rWh0WMiaXuKJ
 noI7u8bm2yREhjy5MmrdrNMMJbPqVnpuCXotghnu0Vqa4j1/fhi/27ysoj8DltQ3sL4L
 qsQ1F55+P/XttE2sDx8VobYzBk8jYqCVxFOkSf2X/6cyoVV8tgwAZfRN5FI3ae6GjMEi
 xmDyPudVtBMiUQSYI6Y5Z1JKIXETy5WDvkFVgTCESeWNfmDZYFmppb9baQkeDFLY1gUJ
 SD6g==
X-Gm-Message-State: APjAAAUGD0kFm75lovFM+OVkR5jgq6dPwuHlb2bLBrDw/eM+vgA9I3sn
 06WrYlmJ1bjl935JohMaCZi+oQ==
X-Google-Smtp-Source: APXvYqzuMVSL+myarsKCRkr8z3GQTqTKhjHpfj0og+J4XErLdPTLwU1mNjMeeybSoLerf3HcGuSKAw==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr8623480wmk.49.1569427570292; 
 Wed, 25 Sep 2019 09:06:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b144sm5988272wmb.3.2019.09.25.09.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:06:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A498A1FF87;
 Wed, 25 Sep 2019 17:06:08 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-10-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 09/16] cputlb: Move NOTDIRTY handling from I/O path
 to TLB path
In-reply-to: <20190923230004.9231-10-richard.henderson@linaro.org>
Date: Wed, 25 Sep 2019 17:06:08 +0100
Message-ID: <87sgok9x8v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

> Pages that we want to track for NOTDIRTY are RAM.  We do not
> really need to go through the I/O path to handle them.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-common.h |  2 --
>  accel/tcg/cputlb.c        | 26 +++++++++++++++++---
>  exec.c                    | 50 ---------------------------------------
>  memory.c                  | 16 -------------
>  4 files changed, 23 insertions(+), 71 deletions(-)

Nice clean-up ;)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 1c0e03ddc2..81753bbb34 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -100,8 +100,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
>
>  void cpu_flush_icache_range(hwaddr start, hwaddr len);
>
> -extern struct MemoryRegion io_mem_notdirty;
> -
>  typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
>
>  int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index af9a44a847..05212ff244 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -904,7 +904,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBE=
ntry *iotlbentry,
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
>      cpu->mem_io_pc =3D retaddr;
> -    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
> +    if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>
> @@ -945,7 +945,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntr=
y *iotlbentry,
>      section =3D iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attr=
s);
>      mr =3D section->mr;
>      mr_offset =3D (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
> -    if (mr !=3D &io_mem_notdirty && !cpu->can_do_io) {
> +    if (!cpu->can_do_io) {
>          cpu_io_recompile(cpu, retaddr);
>      }
>      cpu->mem_io_vaddr =3D addr;
> @@ -1607,7 +1607,7 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
>          need_swap =3D size > 1 && (tlb_addr & TLB_BSWAP);
>
>          /* Handle I/O access.  */
> -        if (likely(tlb_addr & (TLB_MMIO | TLB_NOTDIRTY))) {
> +        if (tlb_addr & TLB_MMIO) {
>              io_writex(env, iotlbentry, mmu_idx, val, addr, retaddr,
>                        op ^ (need_swap * MO_BSWAP));
>              return;
> @@ -1620,6 +1620,26 @@ store_helper(CPUArchState *env, target_ulong addr,=
 uint64_t val,
>
>          haddr =3D (void *)((uintptr_t)addr + entry->addend);
>
> +        /* Handle clean RAM pages.  */
> +        if (tlb_addr & TLB_NOTDIRTY) {
> +            NotDirtyInfo ndi;
> +
> +            /* We require mem_io_pc in tb_invalidate_phys_page_range.  */
> +            env_cpu(env)->mem_io_pc =3D retaddr;
> +
> +            memory_notdirty_write_prepare(&ndi, env_cpu(env), addr,
> +                                          addr + iotlbentry->addr, size);
> +
> +            if (unlikely(need_swap)) {
> +                store_memop(haddr, val, op ^ MO_BSWAP);
> +            } else {
> +                store_memop(haddr, val, op);
> +            }
> +
> +            memory_notdirty_write_complete(&ndi);
> +            return;
> +        }
> +
>          if (unlikely(need_swap)) {
>              store_memop(haddr, val, op ^ MO_BSWAP);
>          } else {
> diff --git a/exec.c b/exec.c
> index ea8c0b18ac..dc7001f115 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -88,7 +88,6 @@ static MemoryRegion *system_io;
>  AddressSpace address_space_io;
>  AddressSpace address_space_memory;
>
> -MemoryRegion io_mem_notdirty;
>  static MemoryRegion io_mem_unassigned;
>  #endif
>
> @@ -191,7 +190,6 @@ typedef struct subpage_t {
>  } subpage_t;
>
>  #define PHYS_SECTION_UNASSIGNED 0
> -#define PHYS_SECTION_NOTDIRTY 1
>
>  static void io_mem_init(void);
>  static void memory_map_init(void);
> @@ -1472,9 +1470,6 @@ hwaddr memory_region_section_get_iotlb(CPUState *cp=
u,
>      if (memory_region_is_ram(section->mr)) {
>          /* Normal RAM.  */
>          iotlb =3D memory_region_get_ram_addr(section->mr) + xlat;
> -        if (!section->readonly) {
> -            iotlb |=3D PHYS_SECTION_NOTDIRTY;
> -        }
>      } else {
>          AddressSpaceDispatch *d;
>
> @@ -2783,42 +2778,6 @@ void memory_notdirty_write_complete(NotDirtyInfo *=
ndi)
>      }
>  }
>
> -/* Called within RCU critical section.  */
> -static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
> -                               uint64_t val, unsigned size)
> -{
> -    NotDirtyInfo ndi;
> -
> -    memory_notdirty_write_prepare(&ndi, current_cpu, current_cpu->mem_io=
_vaddr,
> -                         ram_addr, size);
> -
> -    stn_p(qemu_map_ram_ptr(NULL, ram_addr), size, val);
> -    memory_notdirty_write_complete(&ndi);
> -}
> -
> -static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
> -                                 unsigned size, bool is_write,
> -                                 MemTxAttrs attrs)
> -{
> -    return is_write;
> -}
> -
> -static const MemoryRegionOps notdirty_mem_ops =3D {
> -    .write =3D notdirty_mem_write,
> -    .valid.accepts =3D notdirty_mem_accepts,
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
>  /* Generate a debug exception if a watchpoint has been hit.  */
>  void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
>                            MemTxAttrs attrs, int flags, uintptr_t ra)
> @@ -3014,13 +2973,6 @@ static void io_mem_init(void)
>  {
>      memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops,=
 NULL,
>                            NULL, UINT64_MAX);
> -
> -    /* io_mem_notdirty calls tb_invalidate_phys_page_fast,
> -     * which can be called without the iothread mutex.
> -     */
> -    memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NUL=
L,
> -                          NULL, UINT64_MAX);
> -    memory_region_clear_global_locking(&io_mem_notdirty);
>  }
>
>  AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv)
> @@ -3030,8 +2982,6 @@ AddressSpaceDispatch *address_space_dispatch_new(Fl=
atView *fv)
>
>      n =3D dummy_section(&d->map, fv, &io_mem_unassigned);
>      assert(n =3D=3D PHYS_SECTION_UNASSIGNED);
> -    n =3D dummy_section(&d->map, fv, &io_mem_notdirty);
> -    assert(n =3D=3D PHYS_SECTION_NOTDIRTY);
>
>      d->phys_map  =3D (PhysPageEntry) { .ptr =3D PHYS_MAP_NODE_NIL, .skip=
 =3D 1 };
>
> diff --git a/memory.c b/memory.c
> index 57c44c97db..a99b8c0767 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -434,10 +434,6 @@ static MemTxResult  memory_region_read_accessor(Memo=
ryRegion *mr,
>      tmp =3D mr->ops->read(mr->opaque, addr, size);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp,=
 size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a =
TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp,=
 size);
> @@ -460,10 +456,6 @@ static MemTxResult memory_region_read_with_attrs_acc=
essor(MemoryRegion *mr,
>      r =3D mr->ops->read_with_attrs(mr->opaque, addr, &tmp, size, attrs);
>      if (mr->subpage) {
>          trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp,=
 size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a =
TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp,=
 size);
> @@ -484,10 +476,6 @@ static MemTxResult memory_region_write_accessor(Memo=
ryRegion *mr,
>
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp=
, size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a =
TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp=
, size);
> @@ -508,10 +496,6 @@ static MemTxResult memory_region_write_with_attrs_ac=
cessor(MemoryRegion *mr,
>
>      if (mr->subpage) {
>          trace_memory_region_subpage_write(get_cpu_index(), mr, addr, tmp=
, size);
> -    } else if (mr =3D=3D &io_mem_notdirty) {
> -        /* Accesses to code which has previously been translated into a =
TB show
> -         * up in the MMIO path, as accesses to the io_mem_notdirty
> -         * MemoryRegion. */
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp=
, size);


--
Alex Benn=C3=A9e

