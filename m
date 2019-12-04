Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A88C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C2F20409
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 13:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBlcijuv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C2F20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icV3f-0001cr-Hp
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 08:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icV25-0000eD-Fw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icV24-0002VU-GK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:49:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icV24-0002VQ-AO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 08:49:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so8686048wrh.5
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 05:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=dhD1d0P7txm2eA4HLzDyhSb+d/GB64EQr1Q6qt8rNLI=;
 b=PBlcijuvzYB+3gPPy+CgNNBDRetc7G9LVo6kL0z+a0DeqA6R24qkuN9sUOoTmfdDlv
 kdxk093vGLujVf3IZYhoYUjnH6xw94cTHoh7dktFoQSH4mBSmUXdQm8ALJ2dxqcvUArS
 x2nnNQ5f0JrKXlzB6xTkOiorrHBn6J71ozdu6YBX9cFLRxUNZHJqMeseFhYGsV5kX+er
 dK3STJFIVZJ19Xentl0Vyt4tPp3xkgiP86qaaE9PW6fYcyO01SyPTKQuQ8WLWqJqrMxr
 uA1GfqLvnk56/tdD0G3zBqzFA2BMPP7+zjRTToxTFa91EjR5McLa7iTLBhcXblaHFDJJ
 g2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=dhD1d0P7txm2eA4HLzDyhSb+d/GB64EQr1Q6qt8rNLI=;
 b=AwEcVWL+nWnriH3r/B9niNkWob6Dzx5+QRKqPNLxWmEEkXqrBYBKK8wEgEbJNOTX+K
 U/hxt/zWlZE4qTBhKzj2UqeBmkhIVdSi2ZH8BUsN3sQO32kN+g7bmeVmzYfpkplmlSxR
 mosl+WU3vOiHtPmoCDv+Ov+SF1+ovkn40gGXCqFbSRSWC20A8jEI6kJNMr5iGoVSXw2J
 e8lVGFmRDjHocLSgVFYnx6qMK5iWVJ1YXT7Cb6GAslPtQUnejy73gdcoIjWk1R6DiIpi
 eo3BU6PJLLDBKfvO5liHxl7nZfqQHTstRmP6nZQ0t+xJUhftTEIOGNp1fwEN3spJthuX
 MHKQ==
X-Gm-Message-State: APjAAAWWP74t8E56PX4f8jfNip5AYXFmrc97a6XxUmAhhVZBHuvb60C9
 dREGWp1A5+SQz0rNI0GiBl9LLg==
X-Google-Smtp-Source: APXvYqwe4kyY6KdedTKfssTdz3eWYXLW6Za9QWQiwVSLzTpuUrkc2D6HGgC5mvYshB+FrnnOdPJJbQ==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr4217224wru.220.1575467371075; 
 Wed, 04 Dec 2019 05:49:31 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p9sm7213779wmg.45.2019.12.04.05.49.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 05:49:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1B6FD1FF87;
 Wed,  4 Dec 2019 13:49:29 +0000 (GMT)
References: <157544579267.3537077.17459176619888583836.stgit@bahia.lan>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] travis.yml: Drop libcap-dev
In-reply-to: <157544579267.3537077.17459176619888583836.stgit@bahia.lan>
Date: Wed, 04 Dec 2019 13:49:29 +0000
Message-ID: <87k17c8al2.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Greg Kurz <groug@kaod.org> writes:

> Commit b1553ab12fe0 converted virtfs-proxy-helper to using libcap-ng. The=
re
> aren't any users of libcap anymore. No need to install libcap-dev.
>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>
> Yet another follow-up to Paolo's patch to use libcap-ng instead of libcap.
> Like with the docker and the gitlab CI patches, if I get an ack from Alex
> I'll gladly merge this in the 9p tree and send a PR as soon as 5.0 dev
> begins. I'll make sure the SHA1 for Paolo's patch remains the same.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>  .travis.yml |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 445b0646c18a..6cb8af6fa599 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -26,7 +26,6 @@ addons:
>        - libaio-dev
>        - libattr1-dev
>        - libbrlapi-dev
> -      - libcap-dev
>        - libcap-ng-dev
>        - libgcc-4.8-dev
>        - libgnutls28-dev


--=20
Alex Benn=C3=A9e

