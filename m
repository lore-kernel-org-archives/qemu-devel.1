Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2CEC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967D72083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhpvSmsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967D72083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35491 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvwn-0000m8-BO
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:13:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYvvK-00084p-9j
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:11:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hYvvE-0005gW-TO
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:11:32 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hYvvD-0005cs-KH
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:11:28 -0400
Received: by mail-oi1-x243.google.com with SMTP id s184so2100766oie.9
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=oDo/eJz7seNbyvluGufRetR1IVlNGbhn/it44XhT/nE=;
	b=FhpvSmsxjTCjtND4v1eccwx742BOIZYsVoGtkp/Lm71IH4enGWRnqomt3nbUiibyQ0
	U2I8pUA7pYACT7c5OgL/dJrOlgQKqNeuOAEfPAiU3Xf2xwbnbZwEJbGABK+YPBjwwdvU
	ibCL3mRWWHu/JBY0+9PiSetOcvSMKqP4b97l9NCmkdgdltn6B02gKOHKMKsLN3ih2Gkt
	uKwG5LZmmXJft5mANDwcOt1Orfgnvo1/bDNkv6DWSb3Q7fkyCZHTqHEJOfrTB2KhxTLg
	2aBtxm7K3td9grm4YCkgqcxhMXMyWOFk2074l+6VZywBL3JbEe/OodSrclJIueCQj9XN
	+KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=oDo/eJz7seNbyvluGufRetR1IVlNGbhn/it44XhT/nE=;
	b=C2agbM+XVOvwK9Ss8kBKhASCAi6C/zLBrtE3pom78NKDIXIY8oyi+JN9rgU6gJLPv3
	b2rmNZvKOOP9SnPNAId9nzaJRaPZ87BBEkM2CSdG7fbOrv0eI2lZ9IdpclXO43Bh+yNV
	eu2GJJKvbUIU5hD3oFL2WkmAu5IoodUIZ0jRvkxPm7al7MxpInYbzuI0ekhXupovF88x
	6dd7nSCdrocsSOsBTMaMsGIsO87FnOIZcvFvq7aETffeyetnX3AVAvA3meyI+ju/iVvj
	ZuCsEtllAMwgB0g42pDyuehXRNzc8pMn29UKO7GH28E8uSnueaa5rpY+0vBlPRxzLZDp
	i0eA==
X-Gm-Message-State: APjAAAVXjByOJfj1HrkPf2b+rl0FZPtbk3OP3RvTd6qzbRdKMRibBT2o
	/FjRvrMYGVeQiZZR3LmUs7Tc1diJhSCndTQs35TUXg==
X-Google-Smtp-Source: APXvYqw3sbnz8ddG0XE9M3EEL1oUZI49Z2tfeyHVxmCnWbqbY/y6WT3kCmfSAPyqjvjwQRSWqYxATHLWlUej3PaB5Qg=
X-Received: by 2002:a05:6808:8f1:: with SMTP id
	d17mr780286oic.170.1559841085131; 
	Thu, 06 Jun 2019 10:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190606082900.6330-1-alex.bennee@linaro.org>
In-Reply-To: <20190606082900.6330-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jun 2019 18:11:13 +0100
Message-ID: <CAFEAcA847_9x22Jdv4UTJGqD=X02X2ZJTcpUyYW_bicC7G_1JQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: put myself forward for gdbstub
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Jun 2019 at 09:51, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> As I've been reviewing a lot of this recently and I'm going to put
> together a pull request I'd better keep an eye on it.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a96829ea83..8ef34cf1ce 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1872,7 +1872,8 @@ F: util/error.c
>  F: util/qemu-error.c
>
>  GDB stub
> -S: Orphan
> +M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +S: Maintained
>  F: gdbstub*
>  F: gdb-xml/
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

