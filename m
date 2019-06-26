Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC5EC48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E6520663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E6520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgD1P-0004eg-10
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hgCm9-0006ig-Eu
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hgCm8-0006Gv-Cq
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:36:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:21933)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hgCm8-0006Eb-1A
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:36:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8CD3C7461AE;
 Wed, 26 Jun 2019 20:36:05 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 09BFA7461AA; Wed, 26 Jun 2019 20:36:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01BE974569A;
 Wed, 26 Jun 2019 20:36:05 +0200 (CEST)
Date: Wed, 26 Jun 2019 20:36:04 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20190319172126.7502-13-richard.henderson@linaro.org>
Message-ID: <alpine.BSF.2.21.9999.1906262030380.23988@zero.eik.bme.hu>
References: <20190319172126.7502-1-richard.henderson@linaro.org>
 <20190319172126.7502-13-richard.henderson@linaro.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: Re: [Qemu-devel] [PATCH for-4.1 v3 12/17] tcg/ppc: Initial backend
 support for Altivec
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
Cc: David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Mar 2019, Richard Henderson wrote:
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index ec8e336be8..70a64dd214 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -42,6 +42,9 @@
> # define TCG_REG_TMP1   TCG_REG_R12
> #endif
>
> +#define TCG_VEC_TMP1    TCG_REG_V0
> +#define TCG_VEC_TMP2    TCG_REG_V1
> +
> #define TCG_REG_TB     TCG_REG_R31
> #define USE_REG_TB     (TCG_TARGET_REG_BITS == 64)
>
> @@ -61,6 +64,7 @@
>
> static tcg_insn_unit *tb_ret_addr;
>
> +bool have_isa_altivec;
> bool have_isa_2_06;
> bool have_isa_3_00;
>
> @@ -72,39 +76,15 @@ bool have_isa_3_00;
> #endif
>
> #ifdef CONFIG_DEBUG_TCG
> -static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
> -    "r0",
> -    "r1",
> -    "r2",
> -    "r3",
> -    "r4",
> -    "r5",
> -    "r6",
> -    "r7",
> -    "r8",
> -    "r9",
> -    "r10",
> -    "r11",
> -    "r12",
> -    "r13",
> -    "r14",
> -    "r15",
> -    "r16",
> -    "r17",
> -    "r18",
> -    "r19",
> -    "r20",
> -    "r21",
> -    "r22",
> -    "r23",
> -    "r24",
> -    "r25",
> -    "r26",
> -    "r27",
> -    "r28",
> -    "r29",
> -    "r30",
> -    "r31"
> +static const char tcg_target_reg_names[TCG_TARGET_NB_REGS][4] = {
> +    "r0",  "r1",  "r2",  "r3",  "r4",  "r5",  "r6",  "r7",
> +    "r8",  "r9",  "r10", "r11", "r12", "r13", "r14", "r15",
> +    "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23",
> +    "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31",
> +    "v0",  "v1",  "v2",  "v3",  "v4",  "v5",  "v6",  "v7",
> +    "v8",  "v9",  "v10", "v11", "v12", "v13", "v14", "v15",
> +    "v16", "v17", "v18", "v19", "v20", "v21", "v22", "v23",
> +    "v24", "v25", "v26", "v27", "v28", "v29", "v30", "v31",
> };
> #endif
>
> @@ -139,6 +119,26 @@ static const int tcg_target_reg_alloc_order[] = {
>     TCG_REG_R5,
>     TCG_REG_R4,
>     TCG_REG_R3,

Purely guessing without knowing anything about this but would removing 
TCG_REG_R2 from this tcg_target_reg_alloc_order[] list help? Question is 
why it was not a problem before?

Regards,
BALATON Zoltan

