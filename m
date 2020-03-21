Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC99C4332E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 10:40:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FB12072C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 10:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgfvhr2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FB12072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFbYG-0000Kk-Rh
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 06:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFbXN-0008LT-DR
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 06:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFbXL-0003Hd-QU
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 06:39:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:26735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFbXL-0003Gh-JX
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 06:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584787166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U1h1rU0PWnrGEXz9OnB9gfKRhCPwlSyIVgsyj/nrSTw=;
 b=dgfvhr2kgGYhz6EXfKE7cfwNKSML6vLUSwUpNEjBR2kj4ZKcD3EruS4nlxlamLY7dvDbuQ
 I9SETu+qnTb7LO5xXMeLHwIL1sz0FL00pcOheh0F2yzpx3SsyWDFk8M9YqdAQFdTr0Mbt3
 +brkD9yKBO6qo7labRAomMAxs2FI7lg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-Kh3BVebWPMSOKPeWWB6WXQ-1; Sat, 21 Mar 2020 06:39:24 -0400
X-MC-Unique: Kh3BVebWPMSOKPeWWB6WXQ-1
Received: by mail-ed1-f69.google.com with SMTP id y14so7236640edq.22
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 03:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U1h1rU0PWnrGEXz9OnB9gfKRhCPwlSyIVgsyj/nrSTw=;
 b=rBjq5lThiKWU5bdzWHR8WwO7BgWDvVgl7j/U8qkmXne5680HjIf+zAs1izbRf0jLQF
 YuuRgE5vKssgjISyqcI4bF+57ZLvOyPZRjnsX4to4knTOKhEgxkgqBQOaPPQ5rL8KMm9
 WNayBAP4NupJ6lZxq/AUOABtSqcrNOMw6GTDSQzHs/qJWK2yYZktofsvcLYWz/8bVtmX
 iaC1My+dsoy7O6SH5vYx58q4L0IiWMSo2L0Pa8GwQBnnCVcWToJp6fPO6SJI4W0AGBps
 D7fL37JAMHy2M4kbXV88kFQYMBDvbUxsXctdFJeYYJK0OCTZCL7XSjJJrkoCQmfXvPfF
 0qzw==
X-Gm-Message-State: ANhLgQ3G79L35OliBH67y6u3sKY4Qw3w19y53iXosReehED3FhruLeK9
 t3l9GWJRitNYJI9KlrwyfmliY+SnnmYjtJXxnDg+QgyvBGBqJFl1ESRPunIi1noE1FrKZe2G+3a
 8t+udYhP56mcoIz0=
X-Received: by 2002:a17:906:29c7:: with SMTP id
 y7mr6112718eje.174.1584787163452; 
 Sat, 21 Mar 2020 03:39:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtAqdI638WjvDE40MysD5RdCtsHjCELJPCbp5Rj0J1CgEQtPxqhOG7UuKgtEPDBQAeR+JmN2Q==
X-Received: by 2002:a17:906:29c7:: with SMTP id
 y7mr6112703eje.174.1584787163155; 
 Sat, 21 Mar 2020 03:39:23 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b7sm562344edy.74.2020.03.21.03.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 03:39:22 -0700 (PDT)
Subject: Re: [PATCH] target/mips: Fix loongson multimedia condition
 instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20200321045621.2139953-1-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3a52de21-180b-9f85-e33d-563752151017@redhat.com>
Date: Sat, 21 Mar 2020 11:39:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200321045621.2139953-1-jiaxun.yang@flygoat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: aleksandar.qemu.devel@gmail.com, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 5:56 AM, Jiaxun Yang wrote:
> Loongson multimedia condition instructions were previously implemented as
> write 0 to rd due to lack of documentation. So I just confirmed with Loongson
> about their encoding and implemented them correctly.

Can you refer to the datasheet in the commit message, or have someone 
from Loongson Technology, Lemote Tech or with access to the specs ack 
your patch?

> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/mips/translate.c | 40 ++++++++++++++++++++++++++++++++++------
>   1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d745bd2803..43be8d27b5 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5529,6 +5529,8 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>   {
>       uint32_t opc, shift_max;
>       TCGv_i64 t0, t1;
> +    TCGCond cond;
> +    TCGLabel *lab;
>   
>       opc = MASK_LMI(ctx->opcode);
>       switch (opc) {
> @@ -5816,7 +5818,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>       case OPC_DADD_CP2:
>           {
>               TCGv_i64 t2 = tcg_temp_new_i64();
> -            TCGLabel *lab = gen_new_label();
> +            lab = gen_new_label();
>   
>               tcg_gen_mov_i64(t2, t0);
>               tcg_gen_add_i64(t0, t1, t2);
> @@ -5837,7 +5839,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>       case OPC_DSUB_CP2:
>           {
>               TCGv_i64 t2 = tcg_temp_new_i64();
> -            TCGLabel *lab = gen_new_label();
> +            lab = gen_new_label();
>   
>               tcg_gen_mov_i64(t2, t0);
>               tcg_gen_sub_i64(t0, t1, t2);
> @@ -5862,14 +5864,39 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>   
>       case OPC_SEQU_CP2:
>       case OPC_SEQ_CP2:
> +        cond = TCG_COND_EQ;
> +        goto do_cc_cond;
> +        break;
> +
>       case OPC_SLTU_CP2:
> +        cond = TCG_COND_LTU;
> +        goto do_cc_cond;
> +        break;
> +
>       case OPC_SLT_CP2:
> +        cond = TCG_COND_LT;
> +        goto do_cc_cond;
> +        break;
> +
>       case OPC_SLEU_CP2:
> +        cond = TCG_COND_LEU;
> +        goto do_cc_cond;
> +        break;
> +
>       case OPC_SLE_CP2:
> -        /*
> -         * ??? Document is unclear: Set FCC[CC].  Does that mean the
> -         * FD field is the CC field?
> -         */
> +        cond = TCG_COND_LE;
> +    do_cc_cond:
> +        {
> +            int cc = (ctx->opcode >> 8) & 0x7;
> +            lab = gen_new_label();
> +            tcg_gen_ori_i32(fpu_fcr31, fpu_fcr31, 1 << get_fp_bit(cc));
> +            tcg_gen_brcond_i64(cond, t0, t1, lab);
> +            tcg_gen_xori_i32(fpu_fcr31, fpu_fcr31, 1 << get_fp_bit(cc));
> +            gen_set_label(lab);
> +        }
> +        goto no_rd;
> +        break;
> +
>       default:
>           MIPS_INVAL("loongson_cp2");
>           generate_exception_end(ctx, EXCP_RI);
> @@ -5878,6 +5905,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>   
>       gen_store_fpr64(ctx, t0, rd);
>   
> +no_rd:
>       tcg_temp_free_i64(t0);
>       tcg_temp_free_i64(t1);
>   }
> 


