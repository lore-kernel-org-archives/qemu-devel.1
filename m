Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B1C46477
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B5F2084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNfaSatT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B5F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqCo-0002f8-M4
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54842)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpx4-0002gF-RS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpx3-0001H6-PB
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:30 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcpx0-0000mt-Tv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:37:28 -0400
Received: by mail-wm1-x344.google.com with SMTP id x15so8883920wmj.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LE/vgjgV3L2QM0IhA5UFBw8V9LoyfknCUTpbu7QPvNI=;
 b=bNfaSatTu5/oEUz1MJnL/d53E0lqWTgm3zx2lBMHMxbUW26D5IDBqjWZp74cKnOYZD
 rwskse9AG8fQ6y0K3+/q+23J508aGpj4EAjCvZoHMvsW+QJIzQiZxo3po/1qSYEMx2qG
 R7M5MKeBy8RzpRj1T0VroXfSiZ86aHjKLHAYc1oAR8YgiX8Q+q57b85ylFMvHhAWVY4E
 ErSCaOxhmX4Ift2Efnj5BsIzd17cjEsFdeCy+4R0zlstF5w9miMvFs4GFY9zYKbbeGHS
 3u0lQ4/YzHC7TkAmzx0DnPF1sRlfgbdpBYfRCwr8klIklhHcSGJVsk5qq8FQQRedfs0W
 hGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LE/vgjgV3L2QM0IhA5UFBw8V9LoyfknCUTpbu7QPvNI=;
 b=glyLM5HkKurC+Xuh0WxIfXJg/EGjC5BK4A8k3fic4rvY8N+FL1FeviT0N9zaeOcO4H
 zvzVGEGAyxsqmBdU0PEea/OtxiyU7jRPw4Xn5ONQvsjd3HE8mCGPEFtkq19T1MJBlIot
 3vVnh1YEnvu/VJuI0HZMytpnUAKcgwvpTD5GhfVHtlaYM/Rq2YvT/fsx9YmKPN/VBNkp
 Jcweu1VkyjMTPic+PB0DBw/jbWBrpSkpKInXJRA+o4F32qgjlu84EKVFAU7qlMtJktUy
 /Z9PoAqUhs/57uVJEs4HxGF7QK6RHJUcD8A++1eluPdl6tVzTMm2VicsREJWZal6/eWR
 gm/w==
X-Gm-Message-State: APjAAAVfTUZ3KXBiTaRvcU4OzVcPDJUVwExsklPVCV77LCW+CI7M2HOn
 dPIIlLb+ZjuWu3B0usBrG2iZ3Q==
X-Google-Smtp-Source: APXvYqwrU3ctzBmwoYgKzhLRzaRExEBUCv+jiCcLWCH2kPjEZZTEpmk/eEAm21rpXzrt2s90kRvy/g==
X-Received: by 2002:a1c:8049:: with SMTP id b70mr17842412wmd.33.1560771426413; 
 Mon, 17 Jun 2019 04:37:06 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t14sm8322680wrr.33.2019.06.17.04.37.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 04:37:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 34D221FF87;
 Mon, 17 Jun 2019 12:37:05 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-3-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-3-philmd@redhat.com>
Date: Mon, 17 Jun 2019 12:37:05 +0100
Message-ID: <87a7egbfz2.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 02/23] target/arm: Makefile
 cleanup (ARM)
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

> Group ARM objects together, TCG related ones at the bottom.
> This will help when restricting TCG-only objects.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/Makefile.objs | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 7c31fa01c1..3269dda613 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -4,11 +4,9 @@ obj-$(CONFIG_KVM) +=3D kvm.o
>  obj-$(call land,$(CONFIG_KVM),$(call lnot,$(TARGET_AARCH64))) +=3D kvm32=
.o
>  obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) +=3D kvm64.o
>  obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
> -obj-y +=3D translate.o op_helper.o helper.o cpu.o
> -obj-y +=3D neon_helper.o iwmmxt_helper.o vec_helper.o vfp_helper.o
> +obj-y +=3D helper.o cpu.o
>  obj-y +=3D gdbstub.o
>  obj-$(TARGET_AARCH64) +=3D cpu64.o gdbstub64.o
> -obj-y +=3D crypto_helper.o
>  obj-$(CONFIG_SOFTMMU) +=3D arm-powerctl.o
>
>  DECODETREE =3D $(SRC_PATH)/scripts/decodetree.py
> @@ -32,6 +30,11 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.c
>  target/arm/translate.o: target/arm/decode-vfp.inc.c
>  target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
>
> +obj-y +=3D translate.o op_helper.o
> +obj-y +=3D crypto_helper.o
> +obj-y +=3D iwmmxt_helper.o vec_helper.o
> +obj-y +=3D neon_helper.o vfp_helper.o
> +
>  obj-$(TARGET_AARCH64) +=3D translate-a64.o helper-a64.o
>  obj-$(TARGET_AARCH64) +=3D translate-sve.o sve_helper.o
>  obj-$(TARGET_AARCH64) +=3D pauth_helper.o


--
Alex Benn=C3=A9e

