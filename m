Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5DEC33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766442072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0hCCcE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766442072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipW8u-0001ek-I3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ipW6I-0007RO-EO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ipW6G-0004xN-4Q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:42 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ipW6F-0004t1-QY
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:35:40 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so2529572wmc.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 03:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=u3O/BXfBHkN8t3L8hToAPlIlEY35suov8qjYovfP554=;
 b=J0hCCcE3E5Ls2MauOD5KAMvWO3Xyg8vitKHfpVK8+11CtSiTpvectfd5NLbrhva5ZL
 cTf7L6MpLuNRhoL/uFuyjOBYJ6DzxNLteZvzvTwjBP++donONuQfWCI5N1/HxRa/1YBj
 MNZF9t7YHscr6w24az++MCaKhofVYWe7YFEw5+d6frmQXkqxiJrDKlkFWaqSGbapie80
 df3p04JIeDhhLpNdr31pWYzh7YOF5zi8Xt71mPe+xgWxcb9dDBgA2qcVtNCq38EkFbdd
 oi2MXiuL6einRn9kPRoVerj+9R6UKqhTudISGmVN6SbKVEZXl2NCUNFeqPwvQopm6RWd
 3RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=u3O/BXfBHkN8t3L8hToAPlIlEY35suov8qjYovfP554=;
 b=E1eRHvqCBK3R78aRMy6Xe/Hwofz6xBfub0PZyVULGLWAruuLrXcqID0TTCooDsKrxP
 02WE3u7+M7zRYbyN+B8WWdqxrbL9yePfBtK1UPQleAJMqfa0wfNFo3GaPliYmZi9UrAb
 oyBChoIZxtsG7RVxCYlfj0AytSM0ekYzDKqY0hTynmwRcVdzAkw4V4zU+ayhJCU7mw3B
 y/QppoUG2whjs6rEzi+zUlqMeh63FKQAAywphOUXm4t3PiOPY88R84zRg4LXAIngH3ri
 mdPQ1Bv3fPZ/PGytuojJ+IPaH4AV2tcQV60F1TmZ4dAwMux+YhXNikYhlNQgOU9mrdn3
 jPtw==
X-Gm-Message-State: APjAAAUd/TZUd4HrDZTcEtjXAsktpE20l7a5S/l8ANWlTVIoXBmS4BNk
 9drXHl/6crbs8sxwN9gXAH2giQWUevc=
X-Google-Smtp-Source: APXvYqzo4OnnMN9kLVqK3JUOHyEMd3IB+zyHt0T3UnQ5nd2nT/ffKcdF/H0Bux/mLEunfCEYF3pAbg==
X-Received: by 2002:a1c:9e15:: with SMTP id h21mr4066134wme.95.1578569737732; 
 Thu, 09 Jan 2020 03:35:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s8sm7535343wrt.57.2020.01.09.03.35.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2020 03:35:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A1DFD1FF87;
 Thu,  9 Jan 2020 11:35:35 +0000 (GMT)
References: <20200109021710.1219-1-richard.henderson@linaro.org>
 <20200109021710.1219-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/4] vl: Only choose enabled accelerators in
 configure_accelerators
In-reply-to: <20200109021710.1219-5-richard.henderson@linaro.org>
Date: Thu, 09 Jan 2020 11:35:35 +0000
Message-ID: <87r208j20o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> By choosing "tcg:kvm" when kvm is not enabled, we generate
> an incorrect warning: "invalid accelerator kvm".
>
> Presumably the inverse is also true with --disable-tcg.
>
> Fixes: 28a0961757fc
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  vl.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 887dbfbb5d..9b7651c80d 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2759,11 +2759,10 @@ static void configure_accelerators(const char *pr=
ogname)
>=20=20
>          if (accel =3D=3D NULL) {
>              /* Select the default accelerator */
> -            if (!accel_find("tcg") && !accel_find("kvm")) {
> -                error_report("No accelerator selected and"
> -                             " no default accelerator available");
> -                exit(1);
> -            } else {
> +            bool have_tcg =3D accel_find("tcg");
> +            bool have_kvm =3D accel_find("kvm");
> +
> +            if (have_tcg && have_kvm) {
>                  int pnlen =3D strlen(progname);
>                  if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3],
>          "kvm")) {

I know you're not touching this bit but:

modified   vl.c
@@ -2763,8 +2763,7 @@ static void configure_accelerators(const char *progna=
me)
             bool have_kvm =3D accel_find("kvm");
=20
             if (have_tcg && have_kvm) {
-                int pnlen =3D strlen(progname);
-                if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm=
")) {
+                if (g_str_has_suffix(progname, "kvm")) {
                     /* If the program name ends with "kvm", we prefer KVM =
*/
                     accel =3D "kvm:tcg";
                 } else {


>                      /* If the program name ends with "kvm", we prefer KV=
M */
> @@ -2771,9 +2770,16 @@ static void configure_accelerators(const char *pro=
gname)
>                  } else {
>                      accel =3D "tcg:kvm";
>                  }
> +            } else if (have_kvm) {
> +                accel =3D "kvm";
> +            } else if (have_tcg) {
> +                accel =3D "tcg";
> +            } else {
> +                error_report("No accelerator selected and"
> +                             " no default accelerator available");
> +                exit(1);
>              }
>          }
> -
>          accel_list =3D g_strsplit(accel, ":", 0);
>=20=20
>          for (tmp =3D accel_list; *tmp; tmp++) {

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

