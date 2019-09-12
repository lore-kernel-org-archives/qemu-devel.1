Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD56C47404
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86ED22075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pgSryyPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86ED22075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8NuG-0005z8-Lu
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NtK-0005GA-9n
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:08:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i8NtJ-0000hh-6X
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:08:02 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37171)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i8NtI-0000dE-VI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:08:01 -0400
Received: by mail-wm1-x341.google.com with SMTP id r195so7395564wme.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=hq6C1y/RzoYGXUdykHvU5k7MY7q0GFXj55Vp0X2GBQU=;
 b=pgSryyPnEh+Fi7VA4VF6heEpQYyRZxKhRs4w+pKUZwmkuvSnk18RPjYE4OIdMrHISf
 3Pmh5OkURdLG7TpgzTcj1lfGiSclwkrd34G8HNx5FQN5kgFCI5liq74FxFHnFNHF7ZBV
 m+SdUFJSZLNqE20RsdEoV88Zbnb0WyWIDAZW+tqVqnpnOeCW6aLhX+4Hw7uDCL08YJyz
 GSquNKQ5L+qQprmKNi0DPFZocGQzFAPSoQGUkRujDMprXziscgb4heQgdknXr3tEyeCc
 N8badAGhlPJT8TUxg4hWCL/gGPs6PLPjKeGrv1znypPe5lwP94ITiKaWXhfvjjCLxaTo
 oHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=hq6C1y/RzoYGXUdykHvU5k7MY7q0GFXj55Vp0X2GBQU=;
 b=D5EO/Yp3i19SVUnmfTDXEWEhnoqeP1HPG9KbHIb+KRcdA1Sp81hzU+yQoClgqFKzog
 O2UVT3alA8SgMWe65dLzJ5kZbKAwo+iWuYJnskLwn+FtUudf7csIRwxstSCChqi7FHdu
 2DeRPGNRWfYb7ZdMLU9weTPYT/jo5jB27ikNyOfLUWsO/Q57C/OnMiRKGYGvEJmlEjWe
 WWzuqr/qhwzGC5CFnJwzg+dLUQ136lRVUMGC1bu7GrTdgrmjgpj1XjU5kQKqUGSSaHGx
 0Im6DS0qAWCP50FGKs6rTBtXi9NzkEG6b4Pz48W5HMzmT5LyFI5EQISa1JRNL/hkVdZi
 HCvQ==
X-Gm-Message-State: APjAAAXfBtLx7+uLCFiVuiTiArPsggPr619xjztM4JFXO4HH2Zbhexzt
 bQS9ev/LSH+j9gr3ZfJxOE0jtw==
X-Google-Smtp-Source: APXvYqwFpVPuaR0fEwTxl8fALLO4g3yZd7Z1tDCtz3Lt1soUjt3v6nlBy6/l9Pu1GdrgYcC9+1GRCg==
X-Received: by 2002:a7b:cc0a:: with SMTP id f10mr8672627wmh.6.1568290079789;
 Thu, 12 Sep 2019 05:07:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z25sm6237470wmk.0.2019.09.12.05.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2019 05:07:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BDB91FF87;
 Thu, 12 Sep 2019 13:07:58 +0100 (BST)
References: <20190910144428.32597-1-peter.maydell@linaro.org>
 <20190910144428.32597-14-peter.maydell@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190910144428.32597-14-peter.maydell@linaro.org>
Date: Thu, 12 Sep 2019 13:07:58 +0100
Message-ID: <878sqtzpi9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 13/13] target/arm/arm-semi:
 Implement SH_EXT_EXIT_EXTENDED extension
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> SH_EXT_EXIT_EXTENDED is a v2.0 semihosting extension: it
> indicates that the implementation supports the SYS_EXIT_EXTENDED
> function. This function allows both A64 and A32/T32 guests to
> exit with a specified exit status, unlike the older SYS_EXIT
> function which only allowed this for A64 guests. Implement
> this extension.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Aside from the ordering nit mentioned in the previous commit:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/arm-semi.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
> index 0df8d4d69d6..3900bd4e1e6 100644
> --- a/target/arm/arm-semi.c
> +++ b/target/arm/arm-semi.c
> @@ -66,6 +66,7 @@ typedef void TaskState;
>  #define TARGET_SYS_HEAPINFO    0x16
>  #define TARGET_SYS_EXIT        0x18
>  #define TARGET_SYS_SYNCCACHE   0x19
> +#define TARGET_SYS_EXIT_EXTENDED 0x20
>
>  /* ADP_Stopped_ApplicationExit is used for exit(0),
>   * anything else is implemented as exit(1) */
> @@ -485,7 +486,7 @@ static const uint8_t featurefile_data[] =3D {
>      SHFB_MAGIC_1,
>      SHFB_MAGIC_2,
>      SHFB_MAGIC_3,
> -    SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
> +    SH_EXT_EXIT_EXTENDED | SH_EXT_STDOUT_STDERR, /* Feature byte 0 */
>  };
>
>  static void init_featurefile_guestfd(int guestfd)
> @@ -1026,11 +1027,14 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              return 0;
>          }
>      case TARGET_SYS_EXIT:
> -        if (is_a64(env)) {
> +    case TARGET_SYS_EXIT_EXTENDED:
> +        if (nr =3D=3D TARGET_SYS_EXIT_EXTENDED || is_a64(env)) {
>              /*
> -             * The A64 version of this call takes a parameter block,
> +             * The A64 version of SYS_EXIT takes a parameter block,
>               * so the application-exit type can return a subcode which
>               * is the exit status code from the application.
> +             * SYS_EXIT_EXTENDED is an a new-in-v2.0 optional function
> +             * which allows A32/T32 guests to also provide a status code.
>               */
>              GET_ARG(0);
>              GET_ARG(1);
> @@ -1042,8 +1046,10 @@ target_ulong do_arm_semihosting(CPUARMState *env)
>              }
>          } else {
>              /*
> -             * ARM specifies only Stopped_ApplicationExit as normal
> -             * exit, everything else is considered an error
> +             * The A32/T32 version of SYS_EXIT specifies only
> +             * Stopped_ApplicationExit as normal exit, but does not
> +             * allow the guest to specify the exit status code.
> +             * Everything else is considered an error.
>               */
>              ret =3D (args =3D=3D ADP_Stopped_ApplicationExit) ? 0 : 1;
>          }


--
Alex Benn=C3=A9e

