Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81A4C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD082084D
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="ksqYUgEe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD082084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMYi-00036k-C6
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:45:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iSMUh-0001UE-TB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iSMUg-0000Cc-OB
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:41:11 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:38878)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iSMUg-0000CM-EL
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:41:10 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id C040396EF2;
 Wed,  6 Nov 2019 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573051269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/7k9ViW/vlAdKSBwsMoKZSyhELqP+zjWpBdTniHlD0=;
 b=ksqYUgEe0N178aiBZu5p5kyGGuluSvtPMigSc3FOy2dvqVXu1JPa3cQAJrd1tNoOE6tBeE
 EWE7WQZsusnQ1VMeRihfcxMEMblgrh3PBi9Ei6SOVemdmq0ClXk8N5419GmpeOr6dY2bTA
 QsFZf7atPb8e/3TKLDL0O0BYit8aZ68=
Subject: Re: [PATCH v1 2/3] target/microblaze: Plug temp leaks with delay slot
 setup
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-3-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <24212a15-b0cf-770a-7132-92ae48488468@greensocs.com>
Date: Wed, 6 Nov 2019 15:41:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573051269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/7k9ViW/vlAdKSBwsMoKZSyhELqP+zjWpBdTniHlD0=;
 b=ISvcL/MeTGxK18SAjyB9tWzUGf9rCTvNy9dRDuESmrgONkeCPkD5HXWrjJq3LB2NVQydSX
 zlTaeBgwER4JuW/FV3Ndi+pI3Ebp26Hme2z3iF7rEwxUxnDmpolXbDTNK1CKx1UNZ/76Li
 GJZXVtjIV9NjoNx8FAhMrO/TweKPL5Y=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573051269; a=rsa-sha256; cv=none;
 b=7dUD8TJBYoWUMIH8+l0GqdClom8TPJkLuYPo48UktF5RLnecuYznvZztx27WqabzUuUcWQ
 t6GfeVSBJ69DxgM3fX/ToC/JaWEVJ/UQXKll+16IKblYCSVYKBbkeYcrdEAViDPzKeWkpB
 3WOADHKDUc5ikTbwA1kSPmiaIJyjM2k=
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
> Plug temp leaks with delay slot setup.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index ba143ede5f..e9ff9e650d 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1201,6 +1201,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
>      tcg_temp_free_i64(tmp_zero);
>  }
>  
> +static void dec_setup_dslot(DisasContext *dc)
> +{
> +        TCGv_i32 tmp = tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG));
> +
> +        dc->delayed_branch = 2;
> +        dc->tb_flags |= D_FLAG;
> +
> +        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
> +        tcg_temp_free_i32(tmp);
> +}
> +
>  static void dec_bcc(DisasContext *dc)
>  {
>      unsigned int cc;
> @@ -1212,10 +1223,7 @@ static void dec_bcc(DisasContext *dc)
>  
>      dc->delayed_branch = 1;
>      if (dslot) {
> -        dc->delayed_branch = 2;
> -        dc->tb_flags |= D_FLAG;
> -        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> -                      cpu_env, offsetof(CPUMBState, bimm));
> +        dec_setup_dslot(dc);
>      }
>  
>      if (dec_alu_op_b_is_small_imm(dc)) {
> @@ -1274,10 +1282,7 @@ static void dec_br(DisasContext *dc)
>  
>      dc->delayed_branch = 1;
>      if (dslot) {
> -        dc->delayed_branch = 2;
> -        dc->tb_flags |= D_FLAG;
> -        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> -                      cpu_env, offsetof(CPUMBState, bimm));
> +        dec_setup_dslot(dc);
>      }
>      if (link && dc->rd)
>          tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
> @@ -1379,10 +1384,7 @@ static void dec_rts(DisasContext *dc)
>          return;
>      }
>  
> -    dc->delayed_branch = 2;
> -    dc->tb_flags |= D_FLAG;
> -    tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
> -                  cpu_env, offsetof(CPUMBState, bimm));
> +    dec_setup_dslot(dc);
>  
>      if (i_bit) {
>          LOG_DIS("rtid ir=%x\n", dc->ir);
> 

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

