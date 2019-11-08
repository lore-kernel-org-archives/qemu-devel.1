Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E4FC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:22:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4872178F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="DvQrq6XH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4872178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT4DZ-0008NJ-86
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 08:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iT482-0005q5-RI
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iT481-0007C3-EX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:16:42 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:56428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iT47e-0006TC-71
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 08:16:39 -0500
Received: from [192.168.61.102] (lfbn-1-8165-82.w90-112.abo.wanadoo.fr
 [90.112.74.82])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5224B96EF0;
 Fri,  8 Nov 2019 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573218973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FXA4+hqU4HDUJApaUDc4Rb66lE3W8Ezo1Sjt6/ctUU=;
 b=DvQrq6XH+IlC3isniP+iVF+y1x92vl8KaLhlCcmgDIh6vvcdlB6mz9LmZU7SRCuyz5OzUT
 5XNQM5yAwvKQm68w1Xk1OHY8xb7TbZKOMhJBOfEtM31pJT41Yh3QvE7jMPPhZmB1YBxK3T
 QxVS3N/Bu/RlblBTkjqcuj42csFRpjc=
Subject: Re: [PATCH v2 1/3] target/microblaze: Plug temp leaks for loads/stores
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191108124219.31348-1-edgar.iglesias@gmail.com>
 <20191108124219.31348-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <9d32f6be-5448-e285-79a9-594b8e0a7d21@greensocs.com>
Date: Fri, 8 Nov 2019 14:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191108124219.31348-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573218973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6FXA4+hqU4HDUJApaUDc4Rb66lE3W8Ezo1Sjt6/ctUU=;
 b=W8eXjn323xhV71hb895pHyPlfj8gm54E4Hvc21lcO2RQj+q6KbL2xryHRibl1+wsIqOrU+
 QBpp0v7L3Lxp1EkZZgCd/+Gb9gMQlFsNouzEb/0ZPFD6LY5D44XH5mO7KTW3lcFUDoSI6x
 zA6154AAKcD7dxfsHdLt9TkYJpO7CyE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573218973; a=rsa-sha256; cv=none;
 b=7hrV8s1v1odn/aulDK99pHmXscmzGeix1MNPz1WeUTJ2/3TYQyZykZVKJd5579J3wNOAQu
 /cMW5OUv0u91EhSnOtx0YvqxKoidhMZHftLGB3/VgTA9IDRq93vHspK0xWMIy0CcnHRU3o
 edvllKbLqFmq1c+IuiTXIf/MyW10Pgk=
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

On 11/8/19 1:42 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Simplify endian reversion of address also plugging TCG temp
> leaks for loads/stores.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
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
> 

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

