Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87405C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496222071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 16:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6B36G0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496222071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzEF-00085g-Fu
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzDh-0007gX-RM
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:47:57 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzDg-0007b6-MC
 for qemu-devel@nongnu.org; Wed, 27 May 2020 12:47:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id j10so9111595wrw.8
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lfX4TONnBkxnzXdWoWKWUN49foo9bM7R5Rf3Jq1RMjU=;
 b=s6B36G0h2EZL8ClIYI0kpAIiEv4eYkrb/nF9c5NFcfkfHX6nB6XL6wv2xA9O6FqSsv
 Iyfou6rC2Z9btcRy9kwcWD3f+YAChvyrx0UbMdEuavilspvMo3yJLaNb6vsg3lHNIYo7
 /8Nu024Ot2/O9q2C5Z4T1DtgkRVOe/eZcHpnaqX7ZuVuInwLw6v1MyTG+tzCiw5Wlnn3
 qj+X/cRcKiVUSYGn83Sx+b1q5Vq+KImuP5VNRSwL66up2a+EZCnxeKmJBVB4cePsMRXw
 w8Qoa5SOrRIXS/yJu0MUz+bAtDIeF3vUq8G0fWHm6+TDZGU6tIzeUgPY3XEY71LW4qb9
 cZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lfX4TONnBkxnzXdWoWKWUN49foo9bM7R5Rf3Jq1RMjU=;
 b=A5vofkRIHYpwftuYFf8ifES0Gnbymdw++ceZWWQBjvBXCcvKqBcJ4uJcUhliNim4BW
 BuErWUIK4BxtvMJ7sUYqBqGfsEye7QybWB/Qs6mDBOsFwgRmnV+8vwyZ9sDGBRAQHPIq
 uNZMWjFr40NwTp9R68w8x8IKUqtdSxKK+hBYojdWGG3QRpHIvu1NbZmi/JH5GjJMDhcY
 dM5QM5eTIH3S9JWMEjcN7Enywnn/FuW/Hhs3PlDhrSa604DZaKxMST1JSiV+s1SJj/bY
 WG/VNiq7WF+ENwC0HBgoybTZ8TV5VAcDFsehDnE9L8XLIJnWcAJigny59aTSR0oBlBtS
 bPYQ==
X-Gm-Message-State: AOAM531xdvTFJbrZhzD8nLnWI78Ly8QIPnAeFMt+BAcBemA4AiDlb9Ua
 h3KDygoUinW9SyfZrF42KJIkJtRXHe4=
X-Google-Smtp-Source: ABdhPJxMHDa0plH9DezBG/iYCj3SkO/0Y8vNl7iePvKtin5EuulqilvZ/GP+yZMEjRPwOAUHuFS0+w==
X-Received: by 2002:adf:a399:: with SMTP id l25mr24912338wrb.212.1590598074246; 
 Wed, 27 May 2020 09:47:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q5sm3255760wrm.62.2020.05.27.09.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 09:47:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7D2571FF7E;
 Wed, 27 May 2020 17:47:52 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-3-thuth@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/7] gitlab-ci: Remove flex/bison packages
In-reply-to: <20200525131823.715-3-thuth@redhat.com>
Date: Wed, 27 May 2020 17:47:52 +0100
Message-ID: <87d06p5npj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> QEMU does not use flex/bison packages.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200515163029.12917-4-philmd@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index b889fb96b6..994774250f 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -4,7 +4,7 @@ include:
>=20=20
>  before_script:
>   - apt-get update -qq
> - - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev geni=
soimage
> + - apt-get install -y -qq libglib2.0-dev libpixman-1-dev genisoimage
>=20=20
>  build-system1:
>   script:


--=20
Alex Benn=C3=A9e

