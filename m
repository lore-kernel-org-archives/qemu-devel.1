Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18AFC10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550D5208E3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJ8hsMtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550D5208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGB3N-0004YX-QA
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAXD-0001M9-9B
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAXB-0008VC-D4
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:29:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34288
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAXB-0008UL-8q
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lug1IHNMsci9kH3TbbG/SfQVLQjhIg+n01QH3RSNDvo=;
 b=jJ8hsMtGXiyQu+2mM6r9u7Qw+3pzdOXJ4m+VehCT5z7IZNaZvvN9t6ZLAO4fZGWU+Zr9T8
 CmqWth6aEJWNs6XrzpwCbiHnX1xK8ZQPIaG0K/Oy7rsDiBKP/89lqR6HM1tHBVm12qeUVW
 MvqJtxAzNBqtQQOmoREYlkw6xBqiTRI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-UPZ4QZGPM9GQBNX7ckq9wA-1; Thu, 03 Oct 2019 19:29:19 -0400
Received: by mail-wr1-f72.google.com with SMTP id f3so1805504wrr.23
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mQdrfWT4Jc40UpM8uY0IF8lHGug5x5FrZQcKkl53+Tg=;
 b=SU6EDM7lpjBzBEA5SGiybDZTO6Ixwv2ic4QzTvtINkv5iUG09UryLODDB0/RJAouUh
 VTNO0jKRId4j/kUsOp2Pkk8dzY7ZbCRjm/zh6TLqhXHv/i12p3vm2PTQ8NdJMr0Am/8O
 Lj3tfm6As8yl4L66tDv4iQ9NIhKtAmjL83gipBbdq5/xg+RKaS1oEAbb49BxcdlQfioy
 ZLy058Gv8W6NDoMW5xIBwPdQ2WkNzunlB2Sjmk9VX5SgJTaVLfUeQZs5o+tNu1S5nMzM
 z5bDGM589QPHl9K6FnHmew8ZZNPZXc8AvaCI/pXDvVlnLoR0TZHkYPWKvSynbTsRb86b
 jhEQ==
X-Gm-Message-State: APjAAAWpctcNHaLVYPEK+D1JTR01SPSYK586b3kDK6gStXRy/nZWYbYV
 ZEx4pRD3T2JC5oGexIx2obBXKHxnUo2enTM4l/9TZkCSAG4NoVdMq4M4u3g20G/fQbQ73rQqR/4
 rtWlCC46bS3O2TYI=
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr8364957wmd.1.1570145357996; 
 Thu, 03 Oct 2019 16:29:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSK5ijJvBhdmA5DBIIgpX5zGUlvYXt3Wdrqq9Rjv+xCOP74VxhIkS2Is4FqrZ61Y+RVwWPAg==
X-Received: by 2002:a05:600c:351:: with SMTP id
 u17mr8364952wmd.1.1570145357764; 
 Thu, 03 Oct 2019 16:29:17 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id l11sm4768017wmh.34.2019.10.03.16.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:29:17 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 06/15] target/arm/arm-semi: Use
 set_swi_errno() in gdbstub callback functions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <660550a6-60c1-13ba-1caf-a9e5126b7b0f@redhat.com>
Date: Fri, 4 Oct 2019 01:29:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-7-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: UPZ4QZGPM9GQBNX7ckq9wA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/19 4:15 PM, Peter Maydell wrote:
> When we are routing semihosting operations through the gdbstub, the
> work of sorting out the return value and setting errno if necessary
> is done by callback functions which are invoked by the gdbstub code.
> Clean up some ifdeffery in those functions by having them call
> set_swi_errno() to set the semihosting errno.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 27 ++++++---------------------
>   1 file changed, 6 insertions(+), 21 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 2618588076f..02cd673d47d 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -259,17 +259,11 @@ static void arm_semi_cb(CPUState *cs, target_ulong =
ret, target_ulong err)
>   {
>       ARMCPU *cpu =3D ARM_CPU(cs);
>       CPUARMState *env =3D &cpu->env;
> -#ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D cs->opaque;
> -#endif
>       target_ulong reg0 =3D is_a64(env) ? env->xregs[0] : env->regs[0];
>  =20
>       if (ret =3D=3D (target_ulong)-1) {
> -#ifdef CONFIG_USER_ONLY
> -        ts->swi_errno =3D err;
> -#else
> -        syscall_err =3D err;
> -#endif
> +        errno =3D err;
> +        set_swi_errno(env, -1);
>           reg0 =3D ret;
>       } else {
>           /* Fixup syscalls that use nonstardard return conventions.  */
> @@ -326,11 +320,8 @@ static void arm_semi_flen_cb(CPUState *cs, target_ul=
ong ret, target_ulong err)
>       } else {
>           env->regs[0] =3D size;
>       }
> -#ifdef CONFIG_USER_ONLY
> -    ((TaskState *)cs->opaque)->swi_errno =3D err;
> -#else
> -    syscall_err =3D err;
> -#endif
> +    errno =3D err;
> +    set_swi_errno(env, -1);
>   }
>  =20
>   static int arm_semi_open_guestfd;
> @@ -339,15 +330,9 @@ static void arm_semi_open_cb(CPUState *cs, target_ul=
ong ret, target_ulong err)
>   {
>       ARMCPU *cpu =3D ARM_CPU(cs);
>       CPUARMState *env =3D &cpu->env;
> -#ifdef CONFIG_USER_ONLY
> -    TaskState *ts =3D cs->opaque;
> -#endif
>       if (ret =3D=3D (target_ulong)-1) {
> -#ifdef CONFIG_USER_ONLY
> -        ts->swi_errno =3D err;
> -#else
> -        syscall_err =3D err;
> -#endif
> +        errno =3D err;
> +        set_swi_errno(env, -1);
>           dealloc_guestfd(arm_semi_open_guestfd);
>       } else {
>           associate_guestfd(arm_semi_open_guestfd, ret);
>=20


