Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18636C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:49:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9F1A2133F
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPdW8fsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F1A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGAqZ-0003eT-2B
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57746)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGAVX-0008PW-A1
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGAVU-0006oH-HO
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:27:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31380
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iGAVU-0006mh-BO
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1570145255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZjAxt4cP4IRJPHO7T1aBscLO1IaHI6oOKh+GLrbAAI=;
 b=fPdW8fsfh3mT9vX2fprQcRpSbCsuu30U/hd7t8OPPtXnHcOoZPv9usc36o6qUBuhsT8qG3
 UqprqsXWTNwGe+fiqqTLpLDvcOx1TE0XRRJF3ElH5rGXtE9g4hLLKjwYqWidpdY9EbhXJG
 9p/NczhoFyLxVKQCrhXi45l+JaDU61g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-URoXAFOaMuOWAJxDyq5pEw-1; Thu, 03 Oct 2019 19:27:33 -0400
Received: by mail-wr1-f69.google.com with SMTP id v17so1415622wru.12
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2019 16:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0ForYoJMzBgOc+AT5Ml/lQK+m86Hmnd8hRSvmswKqu8=;
 b=YuZmgYy1t8EcSdFVdsDqCI8J8apXYnmHpapgAwZvOWsP8fo/tQxnL5y14GjsqdLSRc
 dDINaqJ9m0rwHqGmedLumK2YP8OQEANTl7cdSd1dazgF1APVXtN5qGnI+XsgYwEnoYyS
 umUWx3kw47Eh7qJZhNNkh02lN0V1kymvhQ2rVvc4ldgJmVVpfGeP7rB7WHM0cFXcWF7l
 ail2iX/ypOfRtAn0UYkNp+Sfl4Fwg31aS69Wj1BCJ39MVN/jXqTgLkCiMjcG4fcxaarM
 fW2VFkXpOTB1YG6OS3io6qQpvvKP3j5f5sM0fTQoGITpdQdbrP+8qP8nB7Z2YQcQT+Lm
 MY0g==
X-Gm-Message-State: APjAAAVi3/CX61l+4UD3VZggyKEAjF7pqLZzVGBAV9vqzeKvx+mX7Y73
 /cAbaKR/SkFsqrSh87QnwoQ6p6vsGBnB50s2XY+tg+xZ3PbGgNR612WxIZ/pz2QlDFo9uDJcnIs
 higIRQN8HIinHUTk=
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr7984476wmj.4.1570145251810; 
 Thu, 03 Oct 2019 16:27:31 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz3BZ8GBtzdQ5vW+7hTTIG8Tpa5nvO2JK+QFajsFJExGX47KL2LRlWti21CTToHaU6r3Qd7LQ==
X-Received: by 2002:a05:600c:252:: with SMTP id 18mr7984467wmj.4.1570145251558; 
 Thu, 03 Oct 2019 16:27:31 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id g3sm8224865wro.14.2019.10.03.16.27.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2019 16:27:31 -0700 (PDT)
Subject: Re: [Qemu-devel] [PATCH v2 02/15] target/arm/arm-semi: Always set
 some kind of errno for failed calls
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190916141544.17540-1-peter.maydell@linaro.org>
 <20190916141544.17540-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0c3b2796-b7e9-ecfd-0b63-a466ee03cdbf@redhat.com>
Date: Fri, 4 Oct 2019 01:27:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190916141544.17540-3-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: URoXAFOaMuOWAJxDyq5pEw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
> If we fail a semihosting call we should always set the
> semihosting errno to something; we were failing to do
> this for some of the "check inputs for sanity" cases.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/arm/arm-semi.c | 45 ++++++++++++++++++++++++++-----------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
>=20
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 03e60105c05..51b55816faf 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -232,11 +232,13 @@ static target_ulong arm_gdb_syscall(ARMCPU *cpu, gd=
b_syscall_complete_cb cb,
>   #define GET_ARG(n) do {                                 \
>       if (is_a64(env)) {                                  \
>           if (get_user_u64(arg ## n, args + (n) * 8)) {   \
> -            return -1;                                  \
> +            errno =3D EFAULT;                             \
> +            return set_swi_errno(ts, -1);               \
>           }                                               \
>       } else {                                            \
>           if (get_user_u32(arg ## n, args + (n) * 4)) {   \
> -            return -1;                                  \
> +            errno =3D EFAULT;                             \
> +            return set_swi_errno(ts, -1);               \
>           }                                               \
>       }                                                   \
>   } while (0)
> @@ -287,12 +289,13 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>           GET_ARG(2);
>           s =3D lock_user_string(arg0);
>           if (!s) {
> -            /* FIXME - should this error code be -TARGET_EFAULT ? */
> -            return (uint32_t)-1;
> +            errno =3D EFAULT;
> +            return set_swi_errno(ts, -1);
>           }
>           if (arg1 >=3D 12) {
>               unlock_user(s, arg0, 0);
> -            return (uint32_t)-1;
> +            errno =3D EINVAL;
> +            return set_swi_errno(ts, -1);
>           }
>           if (strcmp(s, ":tt") =3D=3D 0) {
>               int result_fileno =3D arg1 < 4 ? STDIN_FILENO : STDOUT_FILE=
NO;
> @@ -413,8 +416,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>           } else {
>               s =3D lock_user_string(arg0);
>               if (!s) {
> -                /* FIXME - should this error code be -TARGET_EFAULT ? */
> -                return (uint32_t)-1;
> +                errno =3D EFAULT;
> +                return set_swi_errno(ts, -1);
>               }
>               ret =3D  set_swi_errno(ts, remove(s));
>               unlock_user(s, arg0, 0);
> @@ -432,11 +435,12 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>               char *s2;
>               s =3D lock_user_string(arg0);
>               s2 =3D lock_user_string(arg2);
> -            if (!s || !s2)
> -                /* FIXME - should this error code be -TARGET_EFAULT ? */
> -                ret =3D (uint32_t)-1;
> -            else
> +            if (!s || !s2) {
> +                errno =3D EFAULT;
> +                ret =3D set_swi_errno(ts, -1);
> +            } else {
>                   ret =3D set_swi_errno(ts, rename(s, s2));
> +            }
>               if (s2)
>                   unlock_user(s2, arg2, 0);
>               if (s)
> @@ -456,8 +460,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>           } else {
>               s =3D lock_user_string(arg0);
>               if (!s) {
> -                /* FIXME - should this error code be -TARGET_EFAULT ? */
> -                return (uint32_t)-1;
> +                errno =3D EFAULT;
> +                return set_swi_errno(ts, -1);
>               }
>               ret =3D set_swi_errno(ts, system(s));
>               unlock_user(s, arg0, 0);
> @@ -517,19 +521,22 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>  =20
>               if (output_size > input_size) {
>                   /* Not enough space to store command-line arguments.  *=
/
> -                return -1;
> +                errno =3D E2BIG;
> +                return set_swi_errno(ts, -1);
>               }
>  =20
>               /* Adjust the command-line length.  */
>               if (SET_ARG(1, output_size - 1)) {
>                   /* Couldn't write back to argument block */
> -                return -1;
> +                errno =3D EFAULT;
> +                return set_swi_errno(ts, -1);
>               }
>  =20
>               /* Lock the buffer on the ARM side.  */
>               output_buffer =3D lock_user(VERIFY_WRITE, arg0, output_size=
, 0);
>               if (!output_buffer) {
> -                return -1;
> +                errno =3D EFAULT;
> +                return set_swi_errno(ts, -1);
>               }
>  =20
>               /* Copy the command-line arguments.  */
> @@ -544,7 +551,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>  =20
>               if (copy_from_user(output_buffer, ts->info->arg_start,
>                                  output_size)) {
> -                status =3D -1;
> +                errno =3D EFAULT;
> +                status =3D set_swi_errno(ts, -1);
>                   goto out;
>               }
>  =20
> @@ -614,7 +622,8 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>  =20
>                   if (fail) {
>                       /* Couldn't write back to argument block */
> -                    return -1;
> +                    errno =3D EFAULT;
> +                    return set_swi_errno(ts, -1);
>                   }
>               }
>               return 0;
>=20


