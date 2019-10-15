Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF69C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06044217F9
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FW8kPYn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06044217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKJjS-0001Fh-1A
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKJic-0000NC-D3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKJiZ-0000BT-Tv
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:06:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59279
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKJiZ-0000B4-Mk
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571133974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZyK1qTTuvPaKu68RYNfAPqVn/5ErwwOFeVCVE+az9Jk=;
 b=FW8kPYn9Uc0pI46pDhGMC8pfYIadvNL7JqXYnLc+snwzOK8CaWLt7pZ88g4KYpe+DLripk
 PmtKbqcocaHqUNVCbNtXJRp1bKqQOXT+Sss1vGgBTpDnueDXf8uRq6DabUeLT1mT1PZuid
 YfV0RB2aHP0Jsi3ddWmKa4jTdJq5kkY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-eOt2NP-DMYy1VCDkI9QEsw-1; Tue, 15 Oct 2019 06:06:12 -0400
Received: by mail-wm1-f69.google.com with SMTP id j125so8414775wmj.6
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 03:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZW7efItTmgShnmCYD3U0+q8VttEPUqwbHUm3w8RUkDk=;
 b=bnDcIG1JWbNq8vW268SF1fSR8ImpA+H7PEfPyiGrmTJ+wwU2/R3tD6hC65UETWk4vP
 3w5LCTTHz1gy1PTGN9RVxkOyznEd4qAw7IK9oj37dIAoE7BQlrlcs75MUABONJriC3pf
 +IUmvGeoaF+YEa/mq+H93yriiwwWyrn+9sqvwXs0h7dvfsz9j/X0b/vDBuOt/e+OYpXh
 +1XgHgbUnJpJy5iguIOHdsRJYykJ1GtbmbGiXcxjfMEkzBbQ4C2+1ooLPkeGid4y0Dd+
 BZHdTReUnAjEbnhXHZC1sxzIpnaIIDRdPtLxuEHtVnj0PA5kc8IMuyVEH/01gvBOU3LV
 j+Xw==
X-Gm-Message-State: APjAAAXx/2kxWlLHpuK3jkkw0gTFn2funOB34PtZFgWE9qOXHWz3dX70
 sRHgwK1AFON3onu2dah0YrW4KX71OUSJKdg591xZLxwiCi62mASDtC5uPNTej9q8qbAcBke1inE
 5Ij1LVcrF6Bmt1Lc=
X-Received: by 2002:adf:e98d:: with SMTP id h13mr28519399wrm.70.1571133971493; 
 Tue, 15 Oct 2019 03:06:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxw/X5YHp+bLoLO5W9k34BN5fE3LEv0gnwWvmkO9Z0JTn6meDEppn9FlzXZ/DaY6VQ0eWG8yw==
X-Received: by 2002:adf:e98d:: with SMTP id h13mr28519378wrm.70.1571133971241; 
 Tue, 15 Oct 2019 03:06:11 -0700 (PDT)
Received: from [192.168.1.36] (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id a204sm34921830wmh.21.2019.10.15.03.06.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2019 03:06:10 -0700 (PDT)
Subject: Re: [PATCH] tcg/arm: Expand epilogue inline
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191015012936.16275-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62616c04-4072-db8a-bf56-1d72dd4a628d@redhat.com>
Date: Tue, 15 Oct 2019 12:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015012936.16275-1-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: eOt2NP-DMYy1VCDkI9QEsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Richard,

On 10/15/19 3:29 AM, Richard Henderson wrote:
> It is, after all, just two instructions.
>=20
> Profiling on a cortex-a15, using -d nochain to increase the number
> of exit_tb that are executed, shows a minor improvement of 0.5%.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/arm/tcg-target.inc.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>=20
> diff --git a/tcg/arm/tcg-target.inc.c b/tcg/arm/tcg-target.inc.c
> index 94d80d79d1..2a9ebfe25a 100644
> --- a/tcg/arm/tcg-target.inc.c
> +++ b/tcg/arm/tcg-target.inc.c
> @@ -1745,24 +1745,18 @@ static void tcg_out_qemu_st(TCGContext *s, const =
TCGArg *args, bool is64)
>   #endif
>   }
>  =20
> -static tcg_insn_unit *tb_ret_addr;
> +static void tcg_out_epilogue(TCGContext *s);
>  =20
> -static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
> -                const TCGArg *args, const int *const_args)
> +static void tcg_out_op(TCGContext *s, TCGOpcode opc,
> +                       const TCGArg *args, const int *const_args)
>   {
>       TCGArg a0, a1, a2, a3, a4, a5;
>       int c;
>  =20
>       switch (opc) {
>       case INDEX_op_exit_tb:
> -        /* Reuse the zeroing that exists for goto_ptr.  */
> -        a0 =3D args[0];
> -        if (a0 =3D=3D 0) {
> -            tcg_out_goto(s, COND_AL, s->code_gen_epilogue);
> -        } else {
> -            tcg_out_movi32(s, COND_AL, TCG_REG_R0, args[0]);
> -            tcg_out_goto(s, COND_AL, tb_ret_addr);
> -        }
> +        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, args[0]);
> +        tcg_out_epilogue(s);
>           break;
>       case INDEX_op_goto_tb:
>           {
> @@ -2284,19 +2278,17 @@ static void tcg_out_nop_fill(tcg_insn_unit *p, in=
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
> @@ -2310,11 +2302,13 @@ static void tcg_target_qemu_prologue(TCGContext *=
s)
>        */
>       s->code_gen_epilogue =3D s->code_ptr;
>       tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_R0, 0);
> +    tcg_out_epilogue(s);
> +}
>  =20
> -    /* TB epilogue */
> -    tb_ret_addr =3D s->code_ptr;
> +static void tcg_out_epilogue(TCGContext *s)

Do you mind splitting this patch in 2?
First use tcg_out_epilogue(), then optimize tcg_out_op().

> +{
>       tcg_out_dat_rI(s, COND_AL, ARITH_ADD, TCG_REG_CALL_STACK,
> -                   TCG_REG_CALL_STACK, stack_addend, 1);
> +                   TCG_REG_CALL_STACK, STACK_ADDEND, 1);
>  =20
>       /* ldmia sp!, { r4 - r11, pc } */
>       tcg_out32(s, (COND_AL << 28) | 0x08bd8ff0);
>=20


