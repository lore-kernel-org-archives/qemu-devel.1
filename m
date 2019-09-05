Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF38C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:07:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF8321743
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhTiNSPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF8321743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ofk-0005WK-IV
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5oeW-0004Hw-AH
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5oeV-0008Eq-0q
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:06:07 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55994)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5oeU-0008EX-O5
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:06:06 -0400
Received: by mail-wm1-x342.google.com with SMTP id g207so2041978wmg.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 03:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Zwhcn1S6JQfG96QKucF0fKMRHN1jYIE+8pOC0M2myJY=;
 b=zhTiNSPufsGGMqm8wjPf2y5N21pfSOm16vkHyJJm6KRmw/uAlypHFsp6xR44c/6605
 HuTGLOzQfIs8Bu98Tm1+DFYHJhGdnApjQ3xHxHsDldj1VEaxPTbrf/CwsJTHtzSblcIH
 WKu3bOkFFm/X5Fw4UQHKxvN95vJtCg4/MV8LMmxHRIE6m6Q6RoTeuDp4hn0c+exlPZ4J
 Hf5PiQ2brwqFK1KAU7YOMFp9SlW1wtnzN7zMe4Ol+J3O8j9gAqrc6R032jd3fYlhmhgi
 rDOvJ6rqoMRJug7nPNtPR4SgrbF4mSa/SfTniu/RCiP+v6Xorfretj3wTzewuSLLRYA8
 3ONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Zwhcn1S6JQfG96QKucF0fKMRHN1jYIE+8pOC0M2myJY=;
 b=SSM0/sXkh2pVHMW7S8/U2IP6jPYji8ZEydUt2En4odhaDorsItD5Yue9irLyktoC0Q
 P5lQifCVy2W3qB+WuydgxRpx8yuUBLhXDJ0Y2b6Wv7B/5o51QyOAT7uMxdV9q5XrgV7F
 pTMSElGgXJG0zPqdKNUN+tnaXC/R1kJtghRNDTgjPctYSxvFeGz6Dwlu1HMoai+3is+J
 XoYXYJvudEcWP30YpWQTWCv9U13cHDFYqfgf2Hy5YZIvsWnn5ix+jNKxZALa/iIZSGvZ
 RA1A5ETEoxTgS6vodrKgNV5wLuTKDmnFelAGnSaVSY/AP7K8dOoPwBQiKkr8COGVgKQ5
 6DCg==
X-Gm-Message-State: APjAAAVLaNjDzGLlWs/qkCynqh19mYrORBFOZLyiOccnDN/Unaw5wh0/
 LjwCkRR2FU7FktYoVcczdyVXMA==
X-Google-Smtp-Source: APXvYqxwiW+EZg17CiU0kpuQ53GmTZoOuInu3KkC2UDkQW1UQ1umFNxhcCDZLplPmOkGaStfULUVnw==
X-Received: by 2002:a05:600c:212:: with SMTP id
 18mr2165290wmi.168.1567677965363; 
 Thu, 05 Sep 2019 03:06:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u10sm1816491wmm.43.2019.09.05.03.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 03:06:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 187331FF87;
 Thu,  5 Sep 2019 11:06:04 +0100 (BST)
References: <20190904232451.26466-1-jsnow@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
In-reply-to: <20190904232451.26466-1-jsnow@redhat.com>
Date: Thu, 05 Sep 2019 11:06:04 +0100
Message-ID: <87ef0v83cj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Use --userns=keep-id for
 podman
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 mlureau@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> The workaround that attempts to accomplish the same result as --userns=3D=
keep-id
> does not appear to work well with UIDs much above 1000 (like mine, which =
is
> above 20000.)
>
> Since we have official support for this "trick" now, use the supported me=
thod.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Queued to testing/next, thanks.

> ---
>  tests/docker/docker.py | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ac5baab4ca..fe17d5f709 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -368,9 +368,7 @@ class RunCommand(SubCommand):
>              argv =3D [ "-u", str(uid) ] + argv
>              docker =3D Docker()
>              if docker._command[0] =3D=3D "podman":
> -                argv =3D [ "--uidmap", "%d:0:1" % uid,
> -                         "--uidmap", "0:1:%d" % uid,
> -                         "--uidmap", "%d:%d:64536" % (uid + 1, uid + 1)]=
 + argv
> +                argv.insert(0, '--userns=3Dkeep-id')
>          return Docker().run(argv, args.keep, quiet=3Dargs.quiet)


--
Alex Benn=C3=A9e

