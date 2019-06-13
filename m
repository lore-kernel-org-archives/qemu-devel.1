Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C13C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:44:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC3820679
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 14:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMSncRAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC3820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40524 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbQyB-000153-O4
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 10:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPiA-0007aM-31
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbPgV-0000EO-5R
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:22:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35636)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbPgU-0000C7-9t
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 09:22:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id c6so10143742wml.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 06:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RilUdqydirt8SJtsY7AVq4hQJCB/B6iqQBmjiKuBsNM=;
 b=uMSncRAaqYkZ8ZK03xT0ixjv4uQMrkjuasTOGG3qnsqEOOIUo1w+cB9s1jOvgkeWFE
 sBhB4j1v7SfzKdrPbLCVTX6uEuNaV1gFkpRcWb97ryke4VLc/D7/U0hXzmwXmE7qmoBh
 ep3xOKdxCbKNKI3NPjw3MsxueMHFUBtMOcW6Yn4jC5l1FIxQ/FVTjk6VihYKJDjK150k
 6uZkqF8uQITiGtC6l8cDYA5uBWsVI819K0U/lKFbmqyJ2zM+uZ4S75fI700yyWRG9t74
 cbYvvYKDQwHbfvVF5A/L01DsucNZgLh7EoXE3qJbxQ+iUcqqY38rkFpFA+wgeZfFENGg
 dLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RilUdqydirt8SJtsY7AVq4hQJCB/B6iqQBmjiKuBsNM=;
 b=IEJYUXxeAXswqoYC526RvzX7nXpYxJpToBM4OeJSIyyBaUDP83mKX/JnR/NK6+ZE/r
 LbrIz1vGaF0x5iBWQAzZaAFG5AATt9/CXBciB7hK/jnbS3BUY8LasoAACuXg5KSqYCw3
 BLEyQ18FGOnHRwOz4A2p62B/0khQcEOOVcDZXP042DyEzDz1uUGL7pSeT8yfARntD2nu
 aJEh17UPxQUvrORbNGReJ0CI/d3/qi4Y32nt3n8r07G3MZ4agXj9zXXDD7iVTb2QWUVo
 kTRMCKcBvs6b/YCYiuDK6xvV12jeCRzEXYt/wm+uaUiaMkSetXg2xOmFWXQEmRHJBZHU
 LcXg==
X-Gm-Message-State: APjAAAVjv769NFPfKdfW63Cv+FIA1MfGAsSqnbvej32Ge9iZbjMn5yUC
 SozXSHzL+P83O/8kdY0bySL16Q==
X-Google-Smtp-Source: APXvYqyEQEesfQaUtkbr6XYKmRqOx7doq6k/0TnkI0TR8BnbNUc68D2AKjslzUINmP+L1liqj6j5HA==
X-Received: by 2002:a1c:c706:: with SMTP id x6mr3753933wmf.162.1560432147387; 
 Thu, 13 Jun 2019 06:22:27 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id f1sm3079392wml.28.2019.06.13.06.22.26
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 06:22:26 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F241A1FF87;
 Thu, 13 Jun 2019 14:22:25 +0100 (BST)
References: <20190613130718.3763-1-crosa@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
In-reply-to: <20190613130718.3763-1-crosa@redhat.com>
Date: Thu, 13 Jun 2019 14:22:25 +0100
Message-ID: <87blz1ei26.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 0/4] tests/vm: misc fixes and optimizations
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> A collection of simple fixes and misc optimizations I found
> myself doing while investigating a console issue with the
> vm tests.

Queued to testing/next, thanks.

>
> Cleber Rosa (4):
>   tests/vm: avoid extra compressed image copy
>   tests/vm: avoid image presence check and removal
>   tests/vm: pin ubuntu.i386 image
>   tests/vm: add source repos on ubuntu.i386
>
>  tests/vm/centos      | 6 ++----
>  tests/vm/freebsd     | 6 ++----
>  tests/vm/netbsd      | 6 ++----
>  tests/vm/openbsd     | 6 ++----
>  tests/vm/ubuntu.i386 | 7 ++++---
>  5 files changed, 12 insertions(+), 19 deletions(-)


--
Alex Benn=C3=A9e

