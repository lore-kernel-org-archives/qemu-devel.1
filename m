Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA4EC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD902072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDLu9y4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD902072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3d1C-0000Xq-0q
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3czz-0007ne-CS
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3czx-0001uo-0q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:47:30 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37546
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3czv-0001lQ-OV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581932847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ncKmvgGjO8By5zg11pKvLSpkLNcfSzlmFFiEDnG7lU=;
 b=dDLu9y4+ip5qyGPDTT1vCCInXom/ZauLc1NzC/nZ3dC+QsXr7H1dJpvB06uJIJLoBCgvIR
 IngC6GahY/kJNRCdr78xsXUTrrJX6vGu+lhJo79W7Hy7HLuoO4aIq8AGt79rSF/q+wq0bL
 h2lSeb4DVtdIMlJgSRQQqp409ZNZM4s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-QRgx3AUcMISgpFbJQzpGaA-1; Mon, 17 Feb 2020 04:47:19 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so6780001wma.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 01:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6PbbIjwubHm09ghFzSHiUhYwLPPMhzcbj7A5Y5mj3OU=;
 b=C9WXg7Pn4/cBElG9zwaXF6z2379ndpClgcjJQ6/YXdSKoo86ZkSuN4evep+TWRqv0D
 5uEJF4cAA10cN6OvJmr5s5SW7TpThP7rXyEzktH3J+wfF6nIMnOWaNoIJKYeHCSTNe/g
 8vO8IlwtcMj545jBEbyMCGEhHQTiXN1L2TgqPJP1AZateazxDnP2wLY3/Wk5wSJB+fDQ
 wuIpgUDU2Ef2JGe09pZN3xyG7brue9W4R1uao+cQG6CWFTbXZU+CYVHKGZefbcXPWWRQ
 O8ACuEju73B+o1NxZiBXrKWPnNOJi7Zgc1QY48dUwzDdn+uDSqQgziKAJioc7wTKh+18
 5FVQ==
X-Gm-Message-State: APjAAAV6vv7MSyIxoTfXtHtEjNUD+5RvV7uxcguHLZmVt4PNgDQCWXqH
 VJxvJY7XcBqppuF0ySRFej8gkmDVJKvNwjB2y68trM+Eq2z5/P977W+2SSKImUDuqfqqAeVqUmH
 GORvHJU0FC329vS0=
X-Received: by 2002:adf:f28c:: with SMTP id k12mr22062932wro.360.1581932838255; 
 Mon, 17 Feb 2020 01:47:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBbaRxw96f0ampzKUYmruyKaHQaNI5t/IPkBYNtyOfSOq6hyLc57eloMhpuC//Ulix2bgFVQ==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr22062905wro.360.1581932838021; 
 Mon, 17 Feb 2020 01:47:18 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a13sm100564wrp.93.2020.02.17.01.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 01:47:17 -0800 (PST)
Subject: Re: [PATCH v2 1/2] tcg/arm: Split out tcg_out_epilogue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200216094143.14201-1-richard.henderson@linaro.org>
 <20200216094143.14201-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5d692992-4260-c371-cce7-f5f0f8b2a6d3@redhat.com>
Date: Mon, 17 Feb 2020 10:47:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200216094143.14201-2-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: QRgx3AUcMISgpFbJQzpGaA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/16/20 10:41 AM, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
>=20
> We will shortly use this function from tcg_out_op as well.
>=20
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>   tcg/arm/tcg-target.inc.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index fffb6611e2..e1aa740ba4 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -1746,6 +1746,7 @@ static void tcg_out_qemu_st(TCGContext *s, const TC=
GArg *args, bool is64)
>   }
>  =20
>   static tcg_insn_unit *tb_ret_addr;
> +static void tcg_out_epilogue(TCGContext *s);
>  =20
>   static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
>                   const TCGArg *args, const int *const_args)
> @@ -2284,19 +2285,17 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, in=
t count)
>         + TCG_TARGET_STACK_ALIGN - 1) \
>        & -TCG_TARGET_STACK_ALIGN)
>  =20
> +#define STACK_ADDEND  (FRAME_SIZE - PUSH_SIZE)
> +
>   static void tcg_target_qemu_prologue(TCGContext *s)
>   {
> -    int stack_addend;
> -
>       /* Calling convention requires us to save r4-r11 and lr.  */
>       /* stmdb sp!, { r4 - r11, lr } */
>       tcg_out32(s, (COND_AL << 28) | 0x092d4ff0);
>  =20
>       /* Reserve callee argument and tcg temp space.  */
> -    stack_addend =3D FRAME_SIZE - PUSH_SIZE;
> -
>       tcg_out_dat_rI(s, COND_AL, ARITH_SUB, TCG_REG_CALL_STACK,
> -                   TCG_REG_CALL_STACK, stack_addend, 1);
> +                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
>       tcg_set_frame(s, TCG_REG_CALL_STACK, TCG_STATIC_CALL_ARGS_SIZE,
>                     CPU_TEMP_BUF_NLONGS * sizeof(long));
>  =20
> @@ -2310,11 +2309,15 @@ static void tcg_target_qemu_prologue(TCGContext *=
s)
>        */
>       s->code_gen_epilogue =3D s->code_ptr;
>       tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
> -
> -    /* TB epilogue */
>       tb_ret_addr =3D s->code_ptr;
> +    tcg_out_epilogue(s);
> +}
> +
> +static void tcg_out_epilogue(TCGContext *s)
> +{
> +    /* Release local stack frame.  */
>       tcg_out_dat_rI(s, COND_AL, ARITH_ADD, TCG_REG_CALL_STACK,
> -                   TCG_REG_CALL_STACK, stack_addend, 1);
> +                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
>  =20
>       /* ldmia sp!, { r4 - r11, pc } */
>       tcg_out32(s, (COND_AL << 28) | 0x08bd8ff0);
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks for splitting v1 :)


