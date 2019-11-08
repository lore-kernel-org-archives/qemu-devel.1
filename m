Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BD4FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1A621D7E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPN0UlNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT7CY-0007xP-Ke
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 11:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iT7AQ-0006Ry-Ce
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iT7AN-0001Uv-Ld
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:31:21 -0500
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46563)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iT7AN-0001QS-Ci
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 11:31:19 -0500
Received: by mail-lj1-x244.google.com with SMTP id e9so6821054ljp.13
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 08:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TRtp0V9VrfV458gX/yt6vqT1rGMsqUatsW/00pWYS0g=;
 b=QPN0UlNya+jVX4rmscDx/l1en6jrs/xK+4KVzxzI7BL2ZTjXE23fDNdJVB3v6L6bCi
 lPbWoCfRfwiTzd1/dw6Pcq6DWkjOY+li405+JMB+fplj6+cV70c5x1KOH3+h030r+P0f
 X6NDGaPE5XrjF84g4Q+2Lj8jHadML18hbh+2PFHCBzK0tb+kSc+KiSy6g2SkTSzMIYrN
 Kaj3rC7c1lklMaKXp5U4lZ9JBqanM4m9kyehXnIA43Chr2lYAnsXCV7/8ave79JyAqwL
 rbkwRKva0UX+W/01SSt5atJZgBd7MOn3lGdhX0IcQ8KyjZ6o19yMnkMahFRM7aKhMmRD
 8t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TRtp0V9VrfV458gX/yt6vqT1rGMsqUatsW/00pWYS0g=;
 b=n9mHjfqo+lkgrlS2v8n+wtNSq0RZrTxjNs/+jrPdS1IBBTngo8oB1UurSRz+14iJsp
 NRB6WM6iHvveMRwP2VMd6coy75B+BOJbcafQp00qaQ9/fcVjZ+u99k8jnrQb8x7oib71
 08DOufgjdv/zl8O6w4ncFcCrguAkfbudbYZGmSmpjEta4SNbpf5yRiasO7BnNgv7wR98
 wlhmPhLzAIsRkkZVo7pEsgnfyDXRZ60cKPZD9cM2PCI7bBp1vZwGArzKCePqIk4JJSBG
 askzHUfaod5oXjfBpdpz6+64oQfZzouAi4Eub65AWaUbaYBaqBLnrge8MYoSXPBPkCkm
 r8Gw==
X-Gm-Message-State: APjAAAX/cjuql230nWZBckTCKy26xV7lIwgYKIazOXRPzyTTdXUK98xj
 QS+cybkFWQ/xq9xG5AjMhvNZ+b9w5zFC3Hg1gT5KS63S
X-Google-Smtp-Source: APXvYqzlnkUNYCFn+YmGVsxcIPiiAbNFGJyh++Nwy9bI3n8O1erW6LI4FdRMjbXXzzcyOjWG3H+Yz6BwkQOr/k3OM8E=
X-Received: by 2002:a2e:420a:: with SMTP id p10mr7708018lja.16.1573230677682; 
 Fri, 08 Nov 2019 08:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20191108124219.31348-1-edgar.iglesias@gmail.com>
 <20191108124219.31348-2-edgar.iglesias@gmail.com>
In-Reply-To: <20191108124219.31348-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 8 Nov 2019 08:30:50 -0800
Message-ID: <CAKmqyKMY8PhT-72L7+WyagfwhKNv3P0mYYt=VrnRFuuhhiJkcA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 8, 2019 at 4:43 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Simplify endian reversion of address also plugging TCG temp
> leaks for loads/stores.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/microblaze/translate.c | 46 +++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 761f535357..c8442b18e1 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -962,17 +962,7 @@ static void dec_load(DisasContext *dc)
>          switch (size) {
>              case 1:
>              {
> -                /* 00 -> 11
> -                   01 -> 10
> -                   10 -> 10
> -                   11 -> 00 */
> -                TCGv low = tcg_temp_new();
> -
> -                tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> -                tcg_gen_andi_tl(addr, addr, ~3);
> -                tcg_gen_or_tl(addr, addr, low);
> -                tcg_temp_free(low);
> +                tcg_gen_xori_tl(addr, addr, 3);
>                  break;
>              }
>
> @@ -1006,9 +996,16 @@ static void dec_load(DisasContext *dc)
>      tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
>
>      if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
> +        TCGv_i32 t0 = tcg_const_i32(0);
> +        TCGv_i32 treg = tcg_const_i32(dc->rd);
> +        TCGv_i32 tsize = tcg_const_i32(size - 1);
> +
>          tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
> -        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> -                            tcg_const_i32(0), tcg_const_i32(size - 1));
> +        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
> +
> +        tcg_temp_free_i32(t0);
> +        tcg_temp_free_i32(treg);
> +        tcg_temp_free_i32(tsize);
>      }
>
>      if (ex) {
> @@ -1095,17 +1092,7 @@ static void dec_store(DisasContext *dc)
>          switch (size) {
>              case 1:
>              {
> -                /* 00 -> 11
> -                   01 -> 10
> -                   10 -> 10
> -                   11 -> 00 */
> -                TCGv low = tcg_temp_new();
> -
> -                tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> -                tcg_gen_andi_tl(addr, addr, ~3);
> -                tcg_gen_or_tl(addr, addr, low);
> -                tcg_temp_free(low);
> +                tcg_gen_xori_tl(addr, addr, 3);
>                  break;
>              }
>
> @@ -1124,6 +1111,10 @@ static void dec_store(DisasContext *dc)
>
>      /* Verify alignment if needed.  */
>      if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
> +        TCGv_i32 t1 = tcg_const_i32(1);
> +        TCGv_i32 treg = tcg_const_i32(dc->rd);
> +        TCGv_i32 tsize = tcg_const_i32(size - 1);
> +
>          tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
>          /* FIXME: if the alignment is wrong, we should restore the value
>           *        in memory. One possible way to achieve this is to probe
> @@ -1131,8 +1122,11 @@ static void dec_store(DisasContext *dc)
>           *        the alignment checks in between the probe and the mem
>           *        access.
>           */
> -        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
> -                            tcg_const_i32(1), tcg_const_i32(size - 1));
> +        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
> +
> +        tcg_temp_free_i32(t1);
> +        tcg_temp_free_i32(treg);
> +        tcg_temp_free_i32(tsize);
>      }
>
>      if (ex) {
> --
> 2.20.1
>
>

