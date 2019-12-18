Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42378C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079FC2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 19:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sn7PQAgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079FC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfJu-0003jQ-6d
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 14:49:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihfHq-00020S-2i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihfHo-0000un-Is
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:47:09 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35673)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihfHo-0000oK-92
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 14:47:08 -0500
Received: by mail-wr1-x443.google.com with SMTP id g17so3606800wro.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1VE/tOTDmFemYxZAzEg5Gig4bfBJNSgb+p0cFmbInxw=;
 b=Sn7PQAgATJup/f0qb2gNN2OCjjKXTeLye/5iYFiMJKnZAjvXwsDjzCwhTUnLlRjSbd
 d8mYjAm/WdfOfJ1/5POt5wdybrpA5/iEgsEbbkchPQdNh2Ry8JSVl75uAZH4ltuHClOq
 tdxGuS6gfQkAiWxCef+JillV48ACZPkYlVy2QRs58YH/cAfr1EH8gT/eC8lg6/0hXx8G
 ylfQlx6mk7N+jNdX2f4ju+X4keSZi4r2Nwy2ExjFRkJ2wJQUMqayT/KYy54J+9mgL0vu
 tXl3GrWhD5sXHAZpElVX5Wi/Lt77f0YVPpGuxLGX2q9QrrbEpStBGuvUlW5Tf2HXL17M
 79Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1VE/tOTDmFemYxZAzEg5Gig4bfBJNSgb+p0cFmbInxw=;
 b=A3T/7xZmkDzp4JHilcOWyoT3jIOT9LjVJRJ3420eeNZrbvRV9Msp3UOkMRH2i3uMjT
 9n1d8g037SzqPSt5W3mk5dQif/yn76G6ziD31P61nfOXZVrAxFRG3w8cAIMiW1NXKQjv
 E2bnJAgcbvelLbW6NQ7OYMNCp9ousEFK9jfYNTrdS8l7itDwWssRtucR5Dug5rA5qOhJ
 Cna8hWephULYL4BT5IfDyfhdgboVMZNxHcsN1ZXa9LEpbwqVEMdi7O8bXt/gvxhR1+2d
 DVruNYh/hDSwMGBzww1nC1WSkeV3L/jw7/1HyrkTlB7rEkqaqV/aY00kOkDiwIFjei1a
 xNrQ==
X-Gm-Message-State: APjAAAWEkm/awUe6tX32W+ZeDv7cwyFfIGnbLZiTGr4dq88oBXvREm1F
 omZ+xnwkE5uw00avfdCCFOm1uObOZPE=
X-Google-Smtp-Source: APXvYqwqY1qsw6UbZSuKX9N/wAkBz82BsI0bVcoAuWoZuj0GlQTwEpDtAdS6hrvdwrrNWAZCa3vjXw==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4917899wrq.64.1576698426429;
 Wed, 18 Dec 2019 11:47:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p26sm3451385wmc.24.2019.12.18.11.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 11:47:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4F2E91FF87;
 Wed, 18 Dec 2019 19:47:04 +0000 (GMT)
References: <1576632611-55032-1-git-send-email-pbonzini@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docker: gtester is no longer used
In-reply-to: <1576632611-55032-1-git-send-email-pbonzini@redhat.com>
Date: Wed, 18 Dec 2019 19:47:04 +0000
Message-ID: <874kxxfmbr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> We are using tap-driver.pl, do not require anymore gtester to be installed
> to run the testsuite in docker-based tests.

Queued to pullreq/testing-logging-misc, thanks.

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/common.rc | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/tests/docker/common.rc b/tests/docker/common.rc
> index 512202b..02cd67a 100755
> --- a/tests/docker/common.rc
> +++ b/tests/docker/common.rc
> @@ -53,12 +53,7 @@ check_qemu()
>          INVOCATION=3D"$@"
>      fi
>=20=20
> -    if command -v gtester > /dev/null 2>&1 && \
> -           gtester --version > /dev/null 2>&1; then
> -        make $MAKEFLAGS $INVOCATION
> -    else
> -        echo "No working gtester, skipping make $INVOCATION"
> -    fi
> +    make $MAKEFLAGS $INVOCATION
>  }
>=20=20
>  test_fail()


--=20
Alex Benn=C3=A9e

