Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C9C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E49020872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JoiF21wB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E49020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCthg-0004CG-7i
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCtfh-0001YE-0f
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCtff-0003Qa-BS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:52:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCtff-0003Pu-4I
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:52:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id 7so2224301wme.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 15:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NUugoBhEbrlg67mSoN0zDVzqKc0iZQAyUuDcywtPlx4=;
 b=JoiF21wBKZVIfLMzhR+dd8EM0bFzxsn4N4flAg0GggES2zVxn7Ad9AdpiTDCw/iFnz
 39ecEKTg3weXpFPi6bboDNwcShOZCgL+Mqu6eX9c896Bo6Yi8TF5danhSmpxxNC8bE4Q
 H3Z9enczuqwwInM/nTG9bhVTaSM8LV9xEj+Dkp4cyG4qH4jYmJ0SuH+egQ1ha6k82HQG
 EYAxJJIBefh7+2tbD+L7rKS0AEcY1zH+5bcXWSeJ/DOM7nKqG8gG3ept35rGGrVndRsR
 DOBDeHR03ksoo/19m/6MlqQcFVeQo5PAJEONrG6aZJNkoYlnqQv9it5ufdEHs6ltNSmI
 AZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NUugoBhEbrlg67mSoN0zDVzqKc0iZQAyUuDcywtPlx4=;
 b=QyVggufQHRZEAFzus93zTfPBswVNU9PaVR0PUWYiLWKy5TDZzCHHo6n0Jvg9D9yA6f
 PfEOpoV7+0z1D79Uxps08hsx5zJmxnXuYjkn4UIfp/+XO31cyordAKj2rAzxHieOZp20
 KfD3fNMK3C62cxHItGd7C4Ay4XrI+48HXrtmE/dDxRLAcUwhump3GO0fiZeV9DbB/4+q
 Rln9+qtm1jbtgQXyA8bcycqmxTq4ZGQfcxCaREr5qUkdh1jEJPY0FiBHdNtuGhGWwEVk
 pxdiy31CmzknF2K2ieV2MTmeIBfv2QVUpDbLRbprJSEQAFeZBNrIWDc0qjyjrh4UCkok
 5YkA==
X-Gm-Message-State: APjAAAULHgxipTilhK32bAt5M1+weaR8qkZsRyHPbytxG5WVtpLNpP/U
 6LipBJ88GnFo4AlWktBDUnTjsEIXu+loKA==
X-Google-Smtp-Source: APXvYqwovsC6RFP5IJpS9Dhft0hon1KBf6S+l5GtjPhOK9dsb2t1NNcZWakCQZ1p7iglTJ33U6VlGQ==
X-Received: by 2002:a1c:a94b:: with SMTP id s72mr2830454wme.9.1569362001655;
 Tue, 24 Sep 2019 14:53:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g4sm3868127wrw.9.2019.09.24.14.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:53:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F3D191FF87;
 Tue, 24 Sep 2019 22:53:19 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 07/16] exec: Adjust notdirty tracing
In-reply-to: <20190923230004.9231-8-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 22:53:19 +0100
Message-ID: <87wodx9x9s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
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

> The memory_region_tb_read tracepoint is unreachable, since notdirty
> is supposed to apply only to writes.  The memory_region_tb_write
> tracepoint is mis-named, because notdirty is not only used for TB
> invalidation.  It is also used for e.g. VGA RAM updates and migration.
>
> Replace memory_region_tb_write with memory_notdirty_write_access,
> and place it in memory_notdirty_write_prepare where it can catch
> all of the instances.  Add memory_notdirty_set_dirty to log when
> we no longer intercept writes to a page.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  exec.c       | 3 +++
>  memory.c     | 4 ----
>  trace-events | 4 ++--
>  3 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 8b998974f8..5f2587b621 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2755,6 +2755,8 @@ void memory_notdirty_write_prepare(NotDirtyInfo *nd=
i,
>      ndi->size =3D size;
>      ndi->pages =3D NULL;
>
> +    trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
> +
>      assert(tcg_enabled());
>      if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)=
) {
>          ndi->pages =3D page_collection_lock(ram_addr, ram_addr + size);
> @@ -2779,6 +2781,7 @@ void memory_notdirty_write_complete(NotDirtyInfo *n=
di)
>      /* we remove the notdirty callback only if the code has been
>         flushed */
>      if (!cpu_physical_memory_is_clean(ndi->ram_addr)) {
> +        trace_memory_notdirty_set_dirty(ndi->mem_vaddr);
>          tlb_set_dirty(ndi->cpu, ndi->mem_vaddr);
>      }
>  }
> diff --git a/memory.c b/memory.c
> index b9dd6b94ca..57c44c97db 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -438,7 +438,6 @@ static MemTxResult  memory_region_read_accessor(Memor=
yRegion *mr,
>          /* Accesses to code which has previously been translated into a =
TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp,=
 size);
> @@ -465,7 +464,6 @@ static MemTxResult memory_region_read_with_attrs_acce=
ssor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into a =
TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_read(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_READ_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp,=
 size);
> @@ -490,7 +488,6 @@ static MemTxResult memory_region_write_accessor(Memor=
yRegion *mr,
>          /* Accesses to code which has previously been translated into a =
TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp=
, size);
> @@ -515,7 +512,6 @@ static MemTxResult memory_region_write_with_attrs_acc=
essor(MemoryRegion *mr,
>          /* Accesses to code which has previously been translated into a =
TB show
>           * up in the MMIO path, as accesses to the io_mem_notdirty
>           * MemoryRegion. */
> -        trace_memory_region_tb_write(get_cpu_index(), addr, tmp, size);
>      } else if (TRACE_MEMORY_REGION_OPS_WRITE_ENABLED) {
>          hwaddr abs_addr =3D memory_region_to_absolute_addr(mr, addr);
>          trace_memory_region_ops_write(get_cpu_index(), mr, abs_addr, tmp=
, size);
> diff --git a/trace-events b/trace-events
> index 823a4ae64e..20821ba545 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -52,14 +52,14 @@ dma_map_wait(void *dbs) "dbs=3D%p"
>  find_ram_offset(uint64_t size, uint64_t offset) "size: 0x%" PRIx64 " @ 0=
x%" PRIx64
>  find_ram_offset_loop(uint64_t size, uint64_t candidate, uint64_t offset,=
 uint64_t next, uint64_t mingap) "trying size: 0x%" PRIx64 " @ 0x%" PRIx64 =
", offset: 0x%" PRIx64" next: 0x%" PRIx64 " mingap: 0x%" PRIx64
>  ram_block_discard_range(const char *rbname, void *hva, size_t length, bo=
ol need_madvise, bool need_fallocate, int ret) "%s@%p + 0x%zx: madvise: %d =
fallocate: %d ret: %d"
> +memory_notdirty_write_access(uint64_t vaddr, uint64_t ram_addr, unsigned=
 size) "0x%" PRIx64 " ram_addr 0x%" PRIx64 " size %u"
> +memory_notdirty_set_dirty(uint64_t vaddr) "0x%" PRIx64
>
>  # memory.c
>  memory_region_ops_read(int cpu_index, void *mr, uint64_t addr, uint64_t =
value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size=
 %u"
>  memory_region_ops_write(int cpu_index, void *mr, uint64_t addr, uint64_t=
 value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" siz=
e %u"
>  memory_region_subpage_read(int cpu_index, void *mr, uint64_t offset, uin=
t64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
>  memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, ui=
nt64_t value, unsigned size) "cpu %d mr %p offset 0x%"PRIx64" value 0x%"PRI=
x64" size %u"
> -memory_region_tb_read(int cpu_index, uint64_t addr, uint64_t value, unsi=
gned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
> -memory_region_tb_write(int cpu_index, uint64_t addr, uint64_t value, uns=
igned size) "cpu %d addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
>  memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, ui=
nt64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx6=
4" size %u"
>  memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, u=
int64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx=
64" size %u"
>  flatview_new(void *view, void *root) "%p (root %p)"


--
Alex Benn=C3=A9e

