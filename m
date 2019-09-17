Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC883C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:00:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776C9214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7gcmdbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776C9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIhv-0001nL-AT
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIfx-0000LE-5Y
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIfv-0000Ma-QQ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:58:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAIft-0000M6-Ue
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:58:06 -0400
Received: by mail-wr1-x441.google.com with SMTP id a11so4351937wrx.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=u0EZaMLkjpp0BUfbZLStbT33PVq26lohOvyd/vyI/v0=;
 b=P7gcmdbBfTz+9CI0fWjL1PHPPcC0nPere8Vk+qNx2D9RWa2DTDFGikLJ4aGtodNUGN
 n5RJl6GAVbYC50nobmTuDv67xFhzxbnfvxSnAAw5QMijy0iRhfOW8URUrfokhSmCaMG2
 //rmdfCXuKJ2XaFduQZSDVkKGRzGmxX+Gddt4Mj/4QGT3Xve1MfLdrXV1FMLYXKTEdpW
 5fZbnqO/fwXWxhZ4dwotJriE4mK/a1RKYNgw4s/eI+OvdIBv4k3PLuJlqrY26trItk4y
 ia3KKRKG+4ftyRxy7sSJNtTGjYzx7Ui7vMau9GQUWL3pfV6jy0LeVjamdwLRJb6OIDXH
 81JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=u0EZaMLkjpp0BUfbZLStbT33PVq26lohOvyd/vyI/v0=;
 b=Z3RYo56uiJbbOgthV2ZwW5DYGYWgvW0vUgDhbVG3m3lkR/0JR6mKN4WYpHljHCnT9K
 LeHcF4i4qJ4P1qh3R9rptlU+ryXYxtkibExqU0nT4BDmkrf5iyr5llhpLdT3n5EgqRyh
 6nAvpUP4sUxRAS9DdzgvZab5DDd7RA+/vz5eny9tX4x/qRC8qZEf87IPv5NG1iFCUHbE
 cfejeWQe0yV0F0zhW5Idy4u2IknwQlEzb2mZCl/6Ld3rWl17d1sEgeffSxuNlbZRD27k
 XSMSYZJIYQ73BBKgKQy0kFakxMAfckbKAXXvTdsE6jUFFn36GkgM4D/SrA0U2OCX+Tbk
 KHeA==
X-Gm-Message-State: APjAAAUP3oUJvzBtVM+WiyIaAeiWvBmJFc+l/7mzdRP7LDi8QHWIuj6j
 UA1hhIsjlO1I70AaRC188s4Elw==
X-Google-Smtp-Source: APXvYqxBwyG2riInXVRpiR4oFJBsLIaNIfGLZmpJ0p6/xw+DX/TigD6ntltmfdZiulyUDKR7X2wuXg==
X-Received: by 2002:adf:e605:: with SMTP id p5mr84003wrm.105.1568746684320;
 Tue, 17 Sep 2019 11:58:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v4sm4836630wrg.56.2019.09.17.11.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 11:58:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0918B1FF87;
 Tue, 17 Sep 2019 19:58:03 +0100 (BST)
References: <20190917184948.24627-1-jsnow@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
In-reply-to: <20190917184948.24627-1-jsnow@redhat.com>
Date: Tue, 17 Sep 2019 19:58:02 +0100
Message-ID: <87d0fy21j9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH] tests/vm: remove unused --target-list
 option
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> It's not used; so remove the distraction.

It's a developer feature so you can run specific builds against the VM
images. I certainly have used it, unless you are saying it's broken now?

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/vm/Makefile.include | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index fea348e845..61758101fa 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -28,7 +28,6 @@ vm-help vm-test:
>  	@echo
>  	@echo "Special variables:"
>  	@echo "    BUILD_TARGET=3Dfoo		 - Override the build target"
> -	@echo "    TARGET_LIST=3Da,b,c    	 - Override target list in builds"
>  	@echo '    EXTRA_CONFIGURE_OPTS=3D"..."'
>  	@echo "    J=3D[0..9]*            	 - Override the -jN parameter for ma=
ke commands"
>  	@echo "    DEBUG=3D1              	 - Enable verbose output on host and=
 interactive debugging"
> @@ -65,7 +64,6 @@ vm-build-%: $(IMAGES_DIR)/%.img
>  		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
>  		--snapshot \
>  		--build-qemu $(SRC_PATH) -- \
> -		$(if $(TARGET_LIST),--target-list=3D$(TARGET_LIST)) \
>  		$(if $(EXTRA_CONFIGURE_OPTS),$(EXTRA_CONFIGURE_OPTS)), \
>  		"  VM-BUILD $*")


--
Alex Benn=C3=A9e

