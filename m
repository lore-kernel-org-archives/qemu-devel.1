Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18E1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F72C206F5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+cSHBQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F72C206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4WL-0002wn-Mc
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4Vm-0002WR-Pg
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:53:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jv4Vl-0003ba-32
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:53:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so18043496wrj.13
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ims/TK/lXcRIAVJ8of+RxnPu26UUAXLieGdfLRAROTA=;
 b=i+cSHBQ3EpHK4SX3W3DQCoxoGh7sO34QKfVTRhvl0Adp8EUtAOhSmno+dE9/Bnc7YM
 PSgaixZI/s9xUB+zr7KS7krt4AD3Dc4Qzi1K9PJ+43AN5tCNXNV80XABYrd8iC9IHabn
 HiPayfqcbZsN0l7ycZ2m8ONAChQGko4akO/kKoXVO89Us51O0PnnxmUDf6xMHblB/g1s
 Vwp4NQVXfVxX82KmoIO68GYeAqSCqcVTb4IQQ3KlDyz1YzY7qe//cTYpQrSt/DCRkFiI
 FpPMR8oHoIyeGH9lDRKmnH/J+JMiAKUSpQ/yeo//K5BGuIlntUgzHUlC/UDkfQWlPakH
 VuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ims/TK/lXcRIAVJ8of+RxnPu26UUAXLieGdfLRAROTA=;
 b=eOx30gHpb5klwI0p8H+crC+m1vEPKhjsAvRF8d8IZr2PuW9yHhWrG5N4CBIMv3p6Yc
 JyCbjVoya9QsrAHcL6o7YjoWzOp0F6F0X8KUTg1MheqyZK5WGLrBaH4pMELlIJJSUSVR
 25vIDxfJXzBPyV+0amNRfBkx6CJ7sjvKOlFkmLJqv0FaeTEfkWVhjkGH271JBiDMQdEN
 JWg/zQ5nWjghftqTVX6vRw4KsSyL/11yU+HVxgMFF/e3000M0vxKmwki/Ei853naGFXa
 rCMMRpoDD7Oeg3jicyss2IH/RxTcDCu/dEm2RDTg+9W9omeMIML6IZ9wiN6wlnhG1MXM
 XpqA==
X-Gm-Message-State: AOAM532E5R72LqRwU4LomP4U5jBJfFx70xkXfMfxHFM4QGt/Lk8lsZwu
 r/98KRqcvxi/QtOa6PY9X+cJyw==
X-Google-Smtp-Source: ABdhPJyeiftft73zn7+9CyojUn7WkPrrM93SY5N/YGzhHCCnJtpTgf7FOGQ4FucWGB/VgsoaSPenjw==
X-Received: by 2002:adf:c404:: with SMTP id v4mr1093104wrf.85.1594669991494;
 Mon, 13 Jul 2020 12:53:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j75sm15014910wrj.22.2020.07.13.12.53.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 12:53:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 81C561FF7E;
 Mon, 13 Jul 2020 20:53:09 +0100 (BST)
References: <20200713185237.9419-1-thuth@redhat.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] tests/docker: Remove the libssh workaround from the
 ubuntu 20.04 image
In-reply-to: <20200713185237.9419-1-thuth@redhat.com>
Date: Mon, 13 Jul 2020 20:53:09 +0100
Message-ID: <87o8ojyyxm.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> The libssh problem only exists in Ubuntu 18.04 - we can enable it
> in 20.04 again.

Queued to misc/for-5.1-rc0, thanks.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/ubuntu2004.docker | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/do=
ckerfiles/ubuntu2004.docker
> index f7aac840bf..8d10934a2a 100644
> --- a/tests/docker/dockerfiles/ubuntu2004.docker
> +++ b/tests/docker/dockerfiles/ubuntu2004.docker
> @@ -65,9 +65,6 @@ RUN apt-get update && \
>  RUN dpkg -l $PACKAGES | sort > /packages.txt
>  ENV FEATURES clang tsan pyyaml sdl2
>=20=20
> -# https://bugs.launchpad.net/qemu/+bug/1838763
> -ENV QEMU_CONFIGURE_OPTS --disable-libssh
> -
>  # Apply patch https://reviews.llvm.org/D75820
>  # This is required for TSan in clang-10 to compile with QEMU.
>  RUN sed -i 's/^const/static const/g' /usr/lib/llvm-10/lib/clang/10.0.0/i=
nclude/sanitizer/tsan_interface.h


--=20
Alex Benn=C3=A9e

