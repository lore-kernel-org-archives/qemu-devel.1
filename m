Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34401C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F127A20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UCyr17z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F127A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDrFs-0003Gp-Fw
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 11:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDodI-00015D-IM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDodD-00066o-N7
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:14:12 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDodD-0005uz-FN
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 08:14:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id f11so4127308wrp.8
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 05:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=StU4zDv+Lb9NiYdv8+hnIiKqX8SBCEaFj/IXTof6NBQ=;
 b=UCyr17z1McBaJFsnG5GkBtzWexvLgeGyMGyoKb8dU9MJDUjdsHfhhh7AgnTcqjPuD5
 PzwtAS4ZsR5G5bIAA3uEISkoWaYSdv0vIOG9xI2CtxcokIFvy4kFJdYv9ETbvj4VRphp
 mmVvwPM1VF/JwACLVn1dPJDGl8uLcAX8zEnz6HIEjjwZar7AqQY0panhbRKGOfunyu72
 LGfZfmgmDWMMCMTopL44DhVRDOgdm3bm5/2zR8V4fOTGbVFy9CAL1CkbdHK3pGd7HXpl
 cRO+XpxVr+xzfkMNXOAeb3JnwttZnbcPt6ougoCxwdo8d0h2lxfWJSSK2L3Dj9KJGvZ0
 rJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=StU4zDv+Lb9NiYdv8+hnIiKqX8SBCEaFj/IXTof6NBQ=;
 b=PrhjoBgD0QNXESDMLM7PNcPMih+OF8llocioNAhfHe5I3obfYn/vnOo2JAZgnmZ/vc
 nW7Y56n7P3hLfgF/0nC5N8k9cm43orGLUgFGW/JUVrnxSmBhZQoecfbv/2/Vl5XSTX8v
 YDKL+5t2bgHHOgZ8od5xzAdnA4egM+B0PCUeMpasXrg4kqi4G4fKbUksDXUMa2lb0vR+
 9TmK/OzwmQdSJDUiJjRmaPEBpm0yjbA4EbF5vZ+G4S5pQIsteu/7C7zms+cZIxg1hvgL
 /fcLNWIbFWXHBNjIogh/IVqNyNgS+viveqjn8uzzEKxSwCMrPwDs2ZFvpjUvZS6O3K6/
 8INg==
X-Gm-Message-State: ANhLgQ0Wn9TuvHQnGrb3FYQopgXAZDUh84o1ZRH/WUfvpJx19PC8ez5k
 JgBd24GAHWvMz+/pSpGR6BrU7w==
X-Google-Smtp-Source: ADFU+vvvNC7btcpPK2KKw7zUt1XgNuTGZf2xGB+D3Jste4Y9av5ou2NDWMyJTgNgBg7hTY7xeKujxQ==
X-Received: by 2002:a5d:5089:: with SMTP id a9mr36349714wrt.187.1584360845952; 
 Mon, 16 Mar 2020 05:14:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t5sm15116497wmi.34.2020.03.16.05.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 05:14:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5C391FF7E;
 Mon, 16 Mar 2020 12:14:03 +0000 (GMT)
References: <20200316101544.22361-1-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH] travis.yml: Set G_MESSAGES_DEBUG do report GLib errors
In-reply-to: <20200316101544.22361-1-philmd@redhat.com>
Date: Mon, 16 Mar 2020 12:14:03 +0000
Message-ID: <875zf4lcok.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P . Berrange" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Since commit f5852efa293 we can display GLib errors with the QEMU
> error reporting API. Set it to the 'error' level, as this helps
> understanding failures from QEMU calls to GLib on Travis-CI.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to testing/next, thanks.

> ---
>  .travis.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index b92798ac3b..ccf68aa9ab 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,6 +79,7 @@ env:
>      - MAIN_SOFTMMU_TARGETS=3D"aarch64-softmmu,mips64-softmmu,ppc64-softm=
mu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>      - CCACHE_SLOPPINESS=3D"include_file_ctime,include_file_mtime"
>      - CCACHE_MAXSIZE=3D1G
> +    - G_MESSAGES_DEBUG=3Derror
>=20=20
>=20=20
>  git:


--=20
Alex Benn=C3=A9e

