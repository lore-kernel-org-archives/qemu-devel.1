Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24867C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BF52146E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rfqJPdzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BF52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBz4A-0004gX-5H
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBz3X-00047G-6w
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBz3V-0007gw-S9
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:57:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBz3V-0007gJ-JX
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:57:41 -0400
Received: by mail-wm1-x342.google.com with SMTP id g62so1582199wme.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 03:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fJ66gpqAlIE9PWKQILLY9GcYiKdMgSqWCLqOY603SY8=;
 b=rfqJPdzWgEhLwHT4BEdsB1sOeCB6MbmZ97cf26wYYt/AGhnewy7pJSmpeYTFfiZOuj
 szfO8ravBNAboO9zbKqbjoJPy8olIatg0UNdn3FEzmokZRI87sdU6j8z3TwB6gtB+kRs
 FpG/L5iw9Ansm1ar9e8QOuwSMWtfHIuRC+N3DXxI//yu4mHtSKwoBspIArPnlpKKcrWu
 75Cx6h30Hx61hYvMJkL8Hktw9w1ixMGgT9Upl2D3e274ZFh5h23aq/0nX3Ku4DygFuJo
 pxFsAX/a7+WxWQEZsTmBKJ8tdyO4U49XSBxvz+i8m713LOP8Pa5h/Go5xDf+C5R1AHx+
 b9FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fJ66gpqAlIE9PWKQILLY9GcYiKdMgSqWCLqOY603SY8=;
 b=jGYauhzWvQ/p5lIoFO9l6/eUgpEHB+bdFybsY47VFvcTeOHZOPHst+6MQpv6mTi96o
 WkdxJ6D2MvcXTbSY3h0gi3JhkpEaWpFLVf4MEyRcHEgliZ1CYaIFlWORy5c1GEeT35i2
 DhUsww+HwKJ9+dEfInNdBy1eIEzhuy+WTskN+FFCe7BqJFjBty7dpZLiDX0xgt0/EtRt
 UIefvq+5LLx5lYHYPOVTSkrvhjbpshzc+38Iy3IBc3T3UTWk+fAFI7Tw3G63iClvh6gy
 sb1k2UuxT58Suc61bpjxQkATqTvVyJnH/13GJRgZvNelKEVzUojghZ4UdssoBRAihNHJ
 7RCQ==
X-Gm-Message-State: ANhLgQ22olZqtQDTNbuG7ZNFAcs/Aff0nan99SfV19rrdlnWeMKcBxEY
 DZhHncQk91djXZnMcZVhS5GYUA==
X-Google-Smtp-Source: ADFU+vuYGCCMsQhgf95cEJ/Pw6lZdzv5B3fMYEyRAtadySjmvUe5h2EXWLL1W56SCTjBBN4G3HelvA==
X-Received: by 2002:a1c:2ed2:: with SMTP id u201mr3224756wmu.3.1583924258766; 
 Wed, 11 Mar 2020 03:57:38 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b18sm72439441wrm.86.2020.03.11.03.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 03:57:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C03B01FF7E;
 Wed, 11 Mar 2020 10:57:36 +0000 (GMT)
References: <20200310182536.11137-1-robert.foley@linaro.org>
 <20200310182536.11137-2-robert.foley@linaro.org>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v3 01/10] tests/vm: Add validation of target
In-reply-to: <20200310182536.11137-2-robert.foley@linaro.org>
Date: Wed, 11 Mar 2020 10:57:36 +0000
Message-ID: <87sgifgnvj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: peter.puhov@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This validation is now useful since some targets
> may not be valid if their dependencies are not installed.
> Instead of allowing the scripts to fail with missing dependencies
> we will fail earlier with a helpful error message.
>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>
> ---
>  tests/vm/Makefile.include | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 1bf9693d19..835e3f3549 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -2,7 +2,7 @@
>=20=20
>  .PHONY: vm-build-all vm-clean-all
>=20=20
> -IMAGES :=3D freebsd netbsd openbsd centos fedora
> +IMAGES :=3D freebsd netbsd openbsd fedora
>  ifneq ($(GENISOIMAGE),)
>  IMAGES +=3D ubuntu.i386 centos
>  endif
> @@ -49,9 +49,20 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  vm-clean-all:
>  	rm -f $(IMAGE_FILES)
>=20=20
> +# Validate the target since some targets will not
> +# be valid if their software dependencies are not installed.
> +define validate_target
> +	@echo $(1) | grep $(2) || \
> +	(echo "Invalid target ($(2))"; \
> +	echo "Valid Targets are: $(1)"; \
> +	echo "See make vm-help for more information."; \
> +	exit 1;)
> +endef
> +
>  $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
>  			$(SRC_PATH)/tests/vm/basevm.py \
>  			$(SRC_PATH)/tests/vm/Makefile.include
> +	$(call validate_target,${IMAGES},$*)

This mechanism seems suspect to me. Surely the "make" way is to just
ensure we don't include the targets when we don't have the dependencies
like we do above for GENISOIMAGE?

Random side note: I wonder how this sort of problem is solved in a meson
world? Paolo?

--=20
Alex Benn=C3=A9e

