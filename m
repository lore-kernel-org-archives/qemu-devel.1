Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50449C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:42:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E682084D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="C+STlFk7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E682084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMVb-0001Kf-3U
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:42:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iSMR2-0007Qu-QA
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:37:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iSMR0-00074e-TM
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:37:24 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:38716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iSMR0-00073d-2D
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:37:22 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id D998096EF0;
 Wed,  6 Nov 2019 14:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573051039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMyfoa0xpy0UxDdlyjDC/1sStxH66WxPOeh3Hv5ds30=;
 b=C+STlFk73zSspdCvHfC/uD2fiFZ++7FxbBiOiMvKDlo403R363jUAD2UOhLAYSzJ9q/FSl
 QgG9biC/lQEy2EF21iYFph/qnp/qVQtLvJKtR+oz28nGWm3h6CH/rYHHJYnK1jM641FcCm
 nA4axxXxEIkILgCri6d7oFeJI7DO590=
Subject: Re: [PATCH v1 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <37d5e4a6-bf93-44e0-3a18-3b5d37a9c824@greensocs.com>
Date: Wed, 6 Nov 2019 15:37:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573051039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tMyfoa0xpy0UxDdlyjDC/1sStxH66WxPOeh3Hv5ds30=;
 b=X9fniFhx82FOnKT6z7TXc82Z87KbaSJZEnwxhbPgf4YngeH/8UBDnhhbg+19NJlDQ+od78
 JxU1lI0xXB6G+4fTQ93ER+DqYYPa1dVlCg+LJEQSa+5TT+wyIXzmst3lwpeNnQ9853A3MC
 ijCOPBKc+36iKmi//6+U4lQ8JhZCUv8=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573051039; a=rsa-sha256; cv=none;
 b=qr1ecUKaba+UHiFP67o1uyTo/E0LAGyeB/sqjCg3S+54uAiHlJNdbsnQT8jmCj92e94dNQ
 oO3DrI/Bx9KC7AjwmCqOgnXh0dhgw4+/MscCBYGNitiHWX3l4vSr+81hx4bsRBuoFaDqNU
 JxLCNZXhnx5aPhFuy3MmNAFAVFDYyC0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.135.226.135
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 3:14 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Plug TCG temp leaks for loads/stores.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 30 ++++++++++++++++++++++++------
>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 761f535357..ba143ede5f 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -967,12 +967,14 @@ static void dec_load(DisasContext *dc)
>                     10 -> 10
>                     11 -> 00 */
>                  TCGv low = tcg_temp_new();
> +                TCGv t3 = tcg_const_tl(3);
>  
>                  tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
For this one, I think you can use tcg_gen_subfi_tl(low, 3, low)
>                  tcg_gen_andi_tl(addr, addr, ~3);
>                  tcg_gen_or_tl(addr, addr, low);
>                  tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                  break;
>              }
>  
> @@ -1006,9 +1008,16 @@ static void dec_load(DisasContext *dc)
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
> @@ -1100,12 +1109,14 @@ static void dec_store(DisasContext *dc)
>                     10 -> 10
>                     11 -> 00 */
>                  TCGv low = tcg_temp_new();
> +                TCGv t3 = tcg_const_tl(3);
>  
>                  tcg_gen_andi_tl(low, addr, 3);
> -                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
> +                tcg_gen_sub_tl(low, t3, low);
Same here.

With or without those modifications:
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

>                  tcg_gen_andi_tl(addr, addr, ~3);
>                  tcg_gen_or_tl(addr, addr, low);
>                  tcg_temp_free(low);
> +                tcg_temp_free(t3);
>                  break;
>              }
>  
> @@ -1124,6 +1135,10 @@ static void dec_store(DisasContext *dc)
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
> @@ -1131,8 +1146,11 @@ static void dec_store(DisasContext *dc)
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
> 

