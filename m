Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868BC31E59
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:02:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB25420673
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fv9R+kJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB25420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqLS-0008It-QN
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpxh-0003K4-LN
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:38:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpxg-00025K-L3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:38:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcpxg-00024a-F4
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:38:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id p11so9573487wre.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Nd4e2DQy6cSq6hflaPyBwzVRFv1VdqLwU3MaaSMiCZg=;
 b=fv9R+kJwDrJ8G3iT8taeTToJJzOUAuxfVmq1+m9gc31bG3C+pH1vRKe9SDZCxVUMsf
 L5LFy3/1X5Us+YpQ25Qh7bHm6ZNmcdLvCxysootwkrdCkrD710uSAi1KjMcZVocWuNp5
 GSAOnMYdUccET84QDGbPNCvoWyDvAsV8c6/s1SjM2gbSLhwqoB4iXPjxBAgTzBKdiyZn
 3iHsKFzfCwTL4c1CsFGKelvGcwmpqV/NHJR2o7OqnStcHR6O5KSJIzTVjVoq9oaJRt5h
 8yN4xmnUCt/Taa7UkslcNu4bFN2s3VoNOm7iWuPNZWuev2ty1y5FEgl+RXZmL6PrsFoD
 jQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Nd4e2DQy6cSq6hflaPyBwzVRFv1VdqLwU3MaaSMiCZg=;
 b=rLRQOxUbdWvLj2chzzs2zpRVNF7qJqbM32+hz2SwCOXf1IMOkj6wcIr7G7Zw5L2WOV
 LxtiKYz/x4nWrhlzoaGYcDQQ0A8LJFLo7QcPk/bm8IU+Qor5rbChpdPM83kRyf66ye6e
 HkB5Oqm+9e0z1NIZNBgKJKUKcDBDBwguhnbNiW5+mWlKExjdLIZcL+9lXdAdacaLPWkZ
 y2iNBbQayKNYsALLr0jlWWN1LEg0nBDzXapazeeO7qrs2U01ZJpISj3y9dhHJG6C03Ru
 N7e4o6kEQstC3Cv/hTsGh3r21aHrY7W7HOgl85/rMrLQRS5p8Bt2uRQ4oKeM4LC4m4mk
 84aA==
X-Gm-Message-State: APjAAAUmzW+vEKJaTi6mvjC0Oohk7tFbI4XtX16nCNvGM3GWQ5Uxukwd
 GZ+Eb7SsQVFHxXgfxpir5wXVSg==
X-Google-Smtp-Source: APXvYqztT95FXRMvZ+SyPbP7h1DpvUpoobUTSmjCT+Ryq1Lr2NUOH8QwNlqBSu44+CLd0L6ghZVgkQ==
X-Received: by 2002:adf:e311:: with SMTP id b17mr76454026wrj.11.1560771487330; 
 Mon, 17 Jun 2019 04:38:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a84sm2374559wmf.29.2019.06.17.04.38.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 04:38:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 602091FF87;
 Mon, 17 Jun 2019 12:38:06 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-5-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-5-philmd@redhat.com>
Date: Mon, 17 Jun 2019 12:38:06 +0100
Message-ID: <877e9kbfxd.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 04/23] target/arm: Makefile
 cleanup (softmmu)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Group SOFTMMU objects together.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/Makefile.objs | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 626e340f55..72b42f825f 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -1,9 +1,9 @@
>  obj-y +=3D arm-semi.o
> -obj-$(CONFIG_SOFTMMU) +=3D machine.o psci.o arch_dump.o monitor.o
> -obj-y +=3D helper.o cpu.o
> -obj-y +=3D gdbstub.o
> +obj-y +=3D cpu.o helper.o gdbstub.o
>  obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
> -obj-$(CONFIG_SOFTMMU) +=3D arm-powerctl.o
> +
> +obj-$(CONFIG_SOFTMMU) +=3D machine.o arch_dump.o monitor.o arm-powerctl.o
> +obj-$(CONFIG_SOFTMMU) +=3D psci.o
>
>  obj-$(CONFIG_KVM) +=3D kvm.o
>  obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o


--
Alex Benn=C3=A9e

