Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B05C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA4220663
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="mAKEykZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA4220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMaW-0004P9-GU
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1iSMWI-0002Ml-Ox
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1iSMWH-0000nf-KQ
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:42:50 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:38992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1iSMWH-0000n6-Di
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:42:49 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 5049596EF0;
 Wed,  6 Nov 2019 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1573051368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdecVpG83zVB9k93+NSiTASdzucnUbhFKkloAWANuPQ=;
 b=mAKEykZOe+GAqrzxpb4DVLStDUXK8vjbMWiWvE2AMQjN90gfHZltM5VB4NQMWqkZ9plwjY
 L1e8hmWgOTBGkF5CfaJEQ7e+pHYHOUjII0RdjszVkegCDPlYtfvdTLRe/b2SkcJLMv96Tz
 D8ea3cGO0av/2WoW7WYICp6xoisaE1A=
Subject: Re: [PATCH v1 3/3] target/microblaze: Plug temp leak around
 eval_cond_jmp()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
 <20191106141424.27244-4-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <d1479a02-f038-e478-a748-38cf63f5622a@greensocs.com>
Date: Wed, 6 Nov 2019 15:42:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191106141424.27244-4-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1573051368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdecVpG83zVB9k93+NSiTASdzucnUbhFKkloAWANuPQ=;
 b=7hK76oRhEJdXVizDgQ9PGQxiJ8paJB9afAMvBEL+pPmvtp+QjwW85cPjvjkAlb3MmrpRsH
 /YfbZYipas5Sytde6N+pUK3OcibNkli4m1du+2Zh6XHak12I5FxKQKC6e9FDOEzjKYYFBI
 s35m5KG0IGJKqR0RN9zwT2L3fa3QR34=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1573051368; a=rsa-sha256; cv=none;
 b=Q5ZwnFTVo38UQBq82XWeMKs5SnP5Lf6CZQgvUA5blsxd9axFsI76qyeKQWPZK/C0JM+C+7
 cVLzGL/uocRRwx4NwYfEZdckcA5hj+qXiXPCK/Zm03FGV1QbBiseJydJ/PG1ibm4Mq28W8
 pU1D5sax8Ht7KoWX/e1hGDDU0Q5xeao=
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
> Plug temp leak around eval_cond_jmp().
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  target/microblaze/translate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index e9ff9e650d..93e22a89ac 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1705,7 +1705,10 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
>                  dc->tb_flags &= ~D_FLAG;
>                  /* If it is a direct jump, try direct chaining.  */
>                  if (dc->jmp == JMP_INDIRECT) {
> -                    eval_cond_jmp(dc, env_btarget, tcg_const_i64(dc->pc));
> +                    TCGv_i64 tmp_pc = tcg_const_i64(dc->pc);
> +                    eval_cond_jmp(dc, env_btarget, tmp_pc);
> +                    tcg_temp_free_i64(tmp_pc);
> +
>                      dc->is_jmp = DISAS_JUMP;
>                  } else if (dc->jmp == JMP_DIRECT) {
>                      t_sync_flags(dc);
> 

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

