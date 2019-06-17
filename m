Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94BDC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946E92084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AABVz4bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946E92084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqET-0003qq-R7
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54939)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpxC-0002r5-Ge
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpxA-0001QP-7f
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:38 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34608)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcpxA-0001Ov-1y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id k11so9585840wrl.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yOa9kZzMjmqLZ5LA+8Wo/OBvg98YhZLaWoG4ldtZzRg=;
 b=AABVz4bUPlc/0VDZ8Ebfj1rDiOGgQkdVyb/JFlHaswHNzTSzv/+v4acEHsdcwCSL18
 R8A2Pfe3H90qS/Fb+syPt/uL1vMaL6xsMIlm9h1v9HsnIgbRyK39YjQjSZsPd2ETWq8w
 gxvg3GBtjPPM3VzK0kEpifxYNisli/7mi9XPbQb5LSx9Tg85/9asEKC7M50CkqoAAj+G
 rZ5KhMifiO1FjwBi/3S1ln8uRRIa0/2lnEa6HmKnmGbrXBDOSMA1BULXv/Wawz3OkOMb
 FrOutP5q7oFQvkfI3b+3MKZ/Pckb74cJido4lNgjELqHziON7BAmw4hJ/r2X4GPJ7Bsz
 2xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yOa9kZzMjmqLZ5LA+8Wo/OBvg98YhZLaWoG4ldtZzRg=;
 b=KAYRz8HrlydH2RJuqeHj1o4icaWDHgAGVBFK7pwhYCSO2Ccob0H8/DaPd8YWCa9LmF
 uvNzxd9z/TTY+mgdVkY2i8O7DTrKtE4SeeB5gF4qhiDPLWgyC4EO23vbNo8wVeq6HuDd
 yI/qGJwDTuPwzfGEssjSZJLUKuCcjGrj4nny1fdQgpHg01XiueVnsWdePq5/J8coSqbX
 +x9n+5oBwsGGtJZptZpTIEEkXTLcDkvj4i0RH/Dy+JrRcK87epPR/9lAHcon0TAuRhvl
 BzCrSqLgF+kRq9bongmH8e91RDQws1VrJQSHDcHDi0SamtibK4qov+PyW+fKijrzKObz
 JXVA==
X-Gm-Message-State: APjAAAU+SdgcwL/14V2Tb7NvVn1Pt9dMp2h7OCbyFb7UYbiNsoG+Nlhe
 wBG5llE9T7k9wRGiioCoWpAEqw==
X-Google-Smtp-Source: APXvYqyR7Ekm8bK0VNVI8K1+ItxXdkd3YcUsrNz/QwrrvJDdBYnbz0hAoId1hCpehkgBl0/bzxghBw==
X-Received: by 2002:adf:de8e:: with SMTP id w14mr23758045wrl.130.1560771454795; 
 Mon, 17 Jun 2019 04:37:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id y44sm11200461wrd.13.2019.06.17.04.37.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 04:37:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB9761FF87;
 Mon, 17 Jun 2019 12:37:33 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-4-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-4-philmd@redhat.com>
Date: Mon, 17 Jun 2019 12:37:33 +0100
Message-ID: <878su0bfya.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 03/23] target/arm: Makefile
 cleanup (KVM)
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

> Group KVM objects together.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/Makefile.objs | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 3269dda613..626e340f55 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -1,14 +1,15 @@
>  obj-y +=3D arm-semi.o
>  obj-$(CONFIG_SOFTMMU) +=3D machine.o psci.o arch_dump.o monitor.o
> -obj-$(CONFIG_KVM) +=3D kvm.o
> -obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
> -obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
> -obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
>  obj-y +=3D helper.o cpu.o
>  obj-y +=3D gdbstub.o
>  obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
>  obj-$(CONFIG_SOFTMMU) +=3D arm-powerctl.o
>
> +obj-$(CONFIG_KVM) +=3D kvm.o
> +obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
> +obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
> +obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
> +
>  DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
>
>  target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODET=
REE)


--
Alex Benn=C3=A9e

