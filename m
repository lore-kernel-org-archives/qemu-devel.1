Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793BBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:06:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48342207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbvlmP9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48342207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVpF-0006gL-Fk
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itVoQ-0005o6-Vi
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itVoP-000595-N1
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:05:46 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itVoP-00058Y-Fe
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:05:45 -0500
Received: by mail-lj1-x242.google.com with SMTP id y4so33564639ljj.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 04:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hdAp30xrsSt2od2S8ebUYdHVYwa2PaAeyPBmHJMBeH4=;
 b=HbvlmP9xWIenwVkpBAmnZhrGpucKnoa3sr1CdWNuSYMpl9LHHYszzQKVEYKN1mYRgj
 hDoBRicAMJF/s+S/4eMwZEIrzs1UnIUtwHkOv3z2YEKjt+kxklCQ3+TyzdT49OijMHrj
 B9n26Q/Blm9yYQkCe9GwH6MQYAau744Nxsgur8EeygPe5LGr1YUUiAsnOp92FslRd3S0
 0kESpL9KCMzFxe0tNE+KaVIhTaTJs9smepJSrZqVE9RGUEoU+HMuqzQ19LOZxj1dzOFN
 8TatOB3xDsfodnUz2B6IU0rY8lVdsfpbtyEpoSJwrmnGxqB/BpATocNtNh3K5SYaeXFO
 N4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hdAp30xrsSt2od2S8ebUYdHVYwa2PaAeyPBmHJMBeH4=;
 b=tYbJSNK4abfz8tvh+gZKRn2ytF4fqzpdXHjYD707+P8P62851AgqFuqiYhGAbsgozX
 Ot9xVKd+VXYDU462z1oVpEMZc9BYk+EDAoNW1DVq03GAA6sBEOE9RWHySlx9QJEbvGyo
 wJbbkmcL6rPtrhXhhoDIKE/WiHqbcNHPmD5exDrTE/6tw2977SncMpMko2a8VQjEws4D
 EdN2UlDnHrIvaOfpl7H15HKGxhD+pwjJxJtYozlfvj67u5VFoG72IZrGzgm2YokZ5CFF
 e4lcp+kCPvwtfctKnmfqKv52KxaSOxMt/Iy8ah9ugqKBYrtxBGWSSlArz4Z8WbV63xYf
 OsAQ==
X-Gm-Message-State: APjAAAV9gAR5eLAdUOdpTDJcRcB5e2SVmEdgAkwn4sCbp6YB2HZFI8+E
 wwwWvDDDWB95TtgWZTKw7T8q4mNlt+CJRMQcFaU=
X-Google-Smtp-Source: APXvYqxv94DPGhCjdTuyG8jmDEOM4aYuleAZAL3l5UoKo4f2MhhA2bA0PB64cv0fPVFkAL67HoSJXH4orDsU2wV7+Js=
X-Received: by 2002:a2e:8946:: with SMTP id b6mr13205075ljk.1.1579521943812;
 Mon, 20 Jan 2020 04:05:43 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-5-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-5-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jan 2020 22:05:14 +1000
Message-ID: <CAKmqyKO+TA2QG0zLPyUAz5a58sA8FPbtJdFA9CRWOTnz0hDVkA@mail.gmail.com>
Subject: Re: [PATCH 4/9] cputlb: Hoist tlb portions in tlb_mmu_resize_locked
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 12:52 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> No functional change, but the smaller expressions make
> the code easier to read.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  accel/tcg/cputlb.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 49c605b6d8..c7dc1dc85a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -115,8 +115,8 @@ static void tlb_dyn_init(CPUArchState *env)
>
>  /**
>   * tlb_mmu_resize_locked() - perform TLB resize bookkeeping; resize if necessary
> - * @env: CPU that owns the TLB
> - * @mmu_idx: MMU index of the TLB
> + * @desc: The CPUTLBDesc portion of the TLB
> + * @fast: The CPUTLBDescFast portion of the same TLB
>   *
>   * Called with tlb_lock_held.
>   *
> @@ -153,10 +153,9 @@ static void tlb_dyn_init(CPUArchState *env)
>   * high), since otherwise we are likely to have a significant amount of
>   * conflict misses.
>   */
> -static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
> +static void tlb_mmu_resize_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>  {
> -    CPUTLBDesc *desc = &env_tlb(env)->d[mmu_idx];
> -    size_t old_size = tlb_n_entries(&env_tlb(env)->f[mmu_idx]);
> +    size_t old_size = tlb_n_entries(fast);
>      size_t rate;
>      size_t new_size = old_size;
>      int64_t now = get_clock_realtime();
> @@ -198,14 +197,15 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
>          return;
>      }
>
> -    g_free(env_tlb(env)->f[mmu_idx].table);
> -    g_free(env_tlb(env)->d[mmu_idx].iotlb);
> +    g_free(fast->table);
> +    g_free(desc->iotlb);
>
>      tlb_window_reset(desc, now, 0);
>      /* desc->n_used_entries is cleared by the caller */
> -    env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
> -    env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
> -    env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
> +    fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
> +    fast->table = g_try_new(CPUTLBEntry, new_size);
> +    desc->iotlb = g_try_new(CPUIOTLBEntry, new_size);
> +
>      /*
>       * If the allocations fail, try smaller sizes. We just freed some
>       * memory, so going back to half of new_size has a good chance of working.
> @@ -213,25 +213,24 @@ static void tlb_mmu_resize_locked(CPUArchState *env, int mmu_idx)
>       * allocations to fail though, so we progressively reduce the allocation
>       * size, aborting if we cannot even allocate the smallest TLB we support.
>       */
> -    while (env_tlb(env)->f[mmu_idx].table == NULL ||
> -           env_tlb(env)->d[mmu_idx].iotlb == NULL) {
> +    while (fast->table == NULL || desc->iotlb == NULL) {
>          if (new_size == (1 << CPU_TLB_DYN_MIN_BITS)) {
>              error_report("%s: %s", __func__, strerror(errno));
>              abort();
>          }
>          new_size = MAX(new_size >> 1, 1 << CPU_TLB_DYN_MIN_BITS);
> -        env_tlb(env)->f[mmu_idx].mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
> +        fast->mask = (new_size - 1) << CPU_TLB_ENTRY_BITS;
>
> -        g_free(env_tlb(env)->f[mmu_idx].table);
> -        g_free(env_tlb(env)->d[mmu_idx].iotlb);
> -        env_tlb(env)->f[mmu_idx].table = g_try_new(CPUTLBEntry, new_size);
> -        env_tlb(env)->d[mmu_idx].iotlb = g_try_new(CPUIOTLBEntry, new_size);
> +        g_free(fast->table);
> +        g_free(desc->iotlb);
> +        fast->table = g_try_new(CPUTLBEntry, new_size);
> +        desc->iotlb = g_try_new(CPUIOTLBEntry, new_size);
>      }
>  }
>
>  static void tlb_flush_one_mmuidx_locked(CPUArchState *env, int mmu_idx)
>  {
> -    tlb_mmu_resize_locked(env, mmu_idx);
> +    tlb_mmu_resize_locked(&env_tlb(env)->d[mmu_idx], &env_tlb(env)->f[mmu_idx]);
>      env_tlb(env)->d[mmu_idx].n_used_entries = 0;
>      env_tlb(env)->d[mmu_idx].large_page_addr = -1;
>      env_tlb(env)->d[mmu_idx].large_page_mask = -1;
> --
> 2.20.1
>
>

