Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49EC2D0EE
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A9FC2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 15:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvIA6I1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A9FC2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIwWu-0003gc-Ln
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 11:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jIwW1-0002jV-0J
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jIwVz-0001Ce-CQ
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:39:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jIwVz-00019y-51
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 11:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585582790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imvPM6bWUnn1mDnSwC1ZUhdPVrwZp267rM1NSx6Gnpc=;
 b=VvIA6I1GeGBpyTDF/NB6kWsHgZLSKdYbFTfovDrCx9tF9S82Oq+Of2NcLV8n9m4S9PCk45
 TVzyIkxrBUlPLP/uHmazUcQNJ0KERJKEeyNl15JR5IZp4JO4msMMliaV2ELsryFSRw8x5J
 PQvadeKJdC1fV8yThjMC69+UNDqW8QE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-uMiFzNTCNnKb4C1fLDqqJw-1; Mon, 30 Mar 2020 11:39:48 -0400
X-MC-Unique: uMiFzNTCNnKb4C1fLDqqJw-1
Received: by mail-wm1-f69.google.com with SMTP id f9so7266949wme.7
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 08:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=imvPM6bWUnn1mDnSwC1ZUhdPVrwZp267rM1NSx6Gnpc=;
 b=VP5G7znkn3mMkpDgsJX/v3/9vhvq9IFB66rl4YnrVgpkTkNKnKwrzCJRYb3cNV3JtF
 6kBLu4zVs2Vf9AUGPWKb81n3XrrBRNwHPUr4g00yMv43Ph0OesZn37Nf7u6O+zuQokTd
 VoLRWMU+XIhDuqovbq0WYrInGSzKE3LxmHeWTIlA4gDxsJQzXj938PFcTJ/Va/SiEE8U
 7TtxqjtGMMbUEqMy9Snm78ea3xUuxJGRjfocXqPMHEfdPJsdGTmMo27PzJlLoOYXlwV9
 eqMj34xBM2R82f3LnBUc6Y00GNVF/XYtGpwqxqzfUXEybtDYi9eUIu+7j3EbLcLBoMa1
 AM1w==
X-Gm-Message-State: ANhLgQ3hOR2Xh2E/YNTZL4KOIUv3ghjtnk2i2UYEBNpuC2aniiWR9EP4
 k2NSri+qPxOQXDmt3vOny2kkxQnWxpgYmo6VBRnj53rzvkuwGtzCJ5cR740vgRShqhVuZIUd5Ee
 Ryns3nJWfPZ4OppM=
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr13953025wml.181.1585582787333; 
 Mon, 30 Mar 2020 08:39:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuBctEJGbBFglrSY38NK55WNAXrPzFpbdGeq/LqrpdxRDe1oZOl3g1+pJDkLhTt5fP/A9MnHg==
X-Received: by 2002:a7b:c8cd:: with SMTP id f13mr13953004wml.181.1585582787061; 
 Mon, 30 Mar 2020 08:39:47 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id 19sm8942658wmi.32.2020.03.30.08.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 08:39:46 -0700 (PDT)
Subject: Re: [PATCH for-5.0, v1] target/mips: Fix loongson multimedia
 condition instructions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <39c28108-5d85-d611-c2ea-abbbf913b981@redhat.com>
Date: Mon, 30 Mar 2020 17:39:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Huacai Chen <chenhc@lemote.com>, aleksandar.qemu.devel@gmail.com,
 richard.henderson@linaro.org, aleksandar.rikalo@rt-rk.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Jiaxun Yang,

On 3/24/20 1:22 PM, Jiaxun Yang wrote:
> Loongson multimedia condition instructions were previously implemented as
> write 0 to rd due to lack of documentation. So I just confirmed with Loongson
> about their encoding and implemented them correctly.

If you have a binary using loongson multimedia instructions, can you add 
a test? So this code won't bitrot.

I'm in particular interested by a test covering the MAC2008 
instructions. You can look at examples in the tests/tcg/mips/ directory, 
Aleksandar added a lot of tests there.

Thanks,

Phil.

> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Acked-by: Huacai Chen <chenhc@lemote.com>
> ---
> v1: Use deposit opreations according to Richard's suggestion.
> ---
>   target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index d745bd2803..25b595a17d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -5529,6 +5529,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>   {
>       uint32_t opc, shift_max;
>       TCGv_i64 t0, t1;
> +    TCGCond cond;
>   
>       opc = MASK_LMI(ctx->opcode);
>       switch (opc) {
> @@ -5862,14 +5863,39 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>   
>       case OPC_SEQU_CP2:
>       case OPC_SEQ_CP2:
> +        cond = TCG_COND_EQ;
> +        goto do_cc_cond;
> +        break;
>       case OPC_SLTU_CP2:
> +        cond = TCG_COND_LTU;
> +        goto do_cc_cond;
> +        break;
>       case OPC_SLT_CP2:
> +        cond = TCG_COND_LT;
> +        goto do_cc_cond;
> +        break;
>       case OPC_SLEU_CP2:
> +        cond = TCG_COND_LEU;
> +        goto do_cc_cond;
> +        break;
>       case OPC_SLE_CP2:
> -        /*
> -         * ??? Document is unclear: Set FCC[CC].  Does that mean the
> -         * FD field is the CC field?
> -         */
> +        cond = TCG_COND_LE;
> +    do_cc_cond:
> +        {
> +            int cc = (ctx->opcode >> 8) & 0x7;
> +            TCGv_i64 t64 = tcg_temp_new_i64();
> +            TCGv_i32 t32 = tcg_temp_new_i32();
> +
> +            tcg_gen_setcond_i64(cond, t64, t0, t1);
> +            tcg_gen_extrl_i64_i32(t32, t64);
> +            tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
> +                                get_fp_bit(cc), 1);
> +
> +            tcg_temp_free_i32(t32);
> +            tcg_temp_free_i64(t64);
> +        }
> +        goto no_rd;
> +        break;
>       default:
>           MIPS_INVAL("loongson_cp2");
>           generate_exception_end(ctx, EXCP_RI);
> @@ -5878,6 +5904,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
>   
>       gen_store_fpr64(ctx, t0, rd);
>   
> +no_rd:
>       tcg_temp_free_i64(t0);
>       tcg_temp_free_i64(t1);
>   }
> 


