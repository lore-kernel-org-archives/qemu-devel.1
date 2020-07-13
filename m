Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33D8C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:37:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF007206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD2VGDpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF007206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvpr-0005TE-0p
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juvpC-0004yj-RS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:36:42 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juvpB-0000jT-CM
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:36:42 -0400
Received: by mail-ej1-x644.google.com with SMTP id br7so2478021ejb.5
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/xhmnQ4B1Z9aJUpLizP/4AuO2kQWjDwswGbaz3djwh0=;
 b=PD2VGDpD1JtXpbVWhCtiUcyIX2X7i5bM3ylgOS5okfgR6H2zNJV73UxGPUfEYG7DNm
 v4P9R9MpdCq+dIGzunCy7wHEuftidjv5uEFL23L7Jui2/jFYS+w3CBj1gH+6SiA1bnyK
 ejv2E7gpUfVRcY6PQFaUBivuED70GXUq4oF7wrgmNU83r34hbCYn/9DGjgcaM8O3kw+k
 kdf4bDiDZ9pILEoUubg/S5LxgACYejrvcqv7sxdyYA6q+rsPkhfV9k7jLeFXGTTcv5ln
 Q4tCS1+bKhwN+P1NLsLHoppbE4wMTCk7sAgEX8r23LaLcgfIwtwJM83Tu+DG2CBpYaZz
 nNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/xhmnQ4B1Z9aJUpLizP/4AuO2kQWjDwswGbaz3djwh0=;
 b=ekiEJQ/70WFlUc6gbStd9Jel589bClT5vOs9WnI6sVMMFgGNzYH9lm4aP2PLb4AiEW
 gmVi2d8EiArF46GhXPCB9Kv90vG/ICT/arPARphl6CTjK3et6HF4ayr5YsWk35vYY5Qy
 2Mf+R/y1TIcjEDKI4REkWm9nLhfTudCekX0yKUAwGd9/8EPV+40HlwWYTLyCdyiFZMYb
 sRhjDA3DCWY9PRZyqGns7gOZbaEx6Eeua6zyaC7Pq1dRr26MzG0xlnyA5td8L4dKzQNh
 MUXwjqWedD7nrJVLgrJ2Iy9BSiOGAlRVCj8tZNANtD2SdUt5NNePfiDHWivh4s73eh3t
 +8cQ==
X-Gm-Message-State: AOAM532MKedHXiNcTNQKU2ywsf6IyVPSpx5XcmAvwCZ0iE2T9xvRQBv/
 M85phAo/YRhrnu0mHZiHAP0=
X-Google-Smtp-Source: ABdhPJxFuF0FT5wiptMHMPpaSQ9qgXuw5Sz+X1EI8Mp4ncFeYrPjMzT5HpUJQI/6zgF1CODWwooI3w==
X-Received: by 2002:a17:906:ae56:: with SMTP id
 lf22mr72113160ejb.59.1594636599703; 
 Mon, 13 Jul 2020 03:36:39 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id aq25sm9604297ejc.11.2020.07.13.03.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 03:36:39 -0700 (PDT)
Subject: Re: [PATCH 11/12] target/sh4: Remove superfluous breaks
To: Yi Wang <wang.yi59@zte.com.cn>, qemu-devel@nongnu.org
References: <1594631142-36745-1-git-send-email-wang.yi59@zte.com.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df368f24-8327-b6f9-2852-72f5fb0c91f2@amsat.org>
Date: Mon, 13 Jul 2020 12:36:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594631142-36745-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: xue.zhihong@zte.com.cn, wang.liang82@zte.com.cn,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 11:05 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Remove superfluous breaks, as there is a "return" before them.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

I hadn't reviewed this patch, but now I did.

> ---
>  target/sh4/translate.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 6192d83..60c863d 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -1542,7 +1542,6 @@ static void _decode_opc(DisasContext * ctx)
>          tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
>                              MO_TEUL | MO_UNALN);
>          return;
> -        break;
>      case 0x40e9:                /* movua.l @Rm+,R0 */
>          CHECK_SH4A
>          /* Load non-boundary-aligned data */
> @@ -1550,7 +1549,6 @@ static void _decode_opc(DisasContext * ctx)
>                              MO_TEUL | MO_UNALN);
>          tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
>          return;
> -        break;
>      case 0x0029:		/* movt Rn */
>          tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
>  	return;
> @@ -1638,7 +1636,6 @@ static void _decode_opc(DisasContext * ctx)
>          CHECK_SH4A
>          tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>          return;
> -        break;
>      case 0x4024:		/* rotcl Rn */
>  	{
>  	    TCGv tmp = tcg_temp_new();
> 


