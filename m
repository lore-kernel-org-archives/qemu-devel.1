Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77ECC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7421F21907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmD8geoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7421F21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAYGJ-0003gx-DY
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAYEk-0002kF-MV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAYEj-0002LO-My
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:35:06 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50955)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAYEj-0002Kl-Du
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:35:05 -0400
Received: by mail-wm1-x342.google.com with SMTP id 5so2219223wmg.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=NMCP6vDcIAkOcXQMmqhpcPAXIgHQNkSeyKtYiQJ7OeI=;
 b=XmD8geoDjJ0FA95jtw1xX73WiXYXAGJfsq0SiqQSv8ipadFihOJ2cU+sLQ8yaAah7s
 LjSrBz4xjwEgRyCv6WZQUQnhMPSlvwfWP/TPI1VVRGQnp0zjnrj/Xz5RDqjTc8L0cIb8
 NTHhshc/cs1f5tSWe2O4fiNxn0QA0k4QCUosFZiM9D5p/lBMYacdmejWuzS4SxlUDpen
 IxUWYCCKpC6uWckh1+IEIQQH1IGFkInzQC8OMMvvgagbw5G4tz3MNQaE7zUk1GDrap03
 ilnG8ua5leg95tgTRN5RGowD9srkScNH69hpBjrB7cgweIOJK54SFIy3uuHGFiHZeNNS
 ltPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=NMCP6vDcIAkOcXQMmqhpcPAXIgHQNkSeyKtYiQJ7OeI=;
 b=TkWLfxYxQaohAnWqH5lyIHODNBdeI48IvgIM0+cxmpnslDoBgv817emMfMjPaKILgy
 0PSFfXeDTkja1582P/1lG35E8XQQndhue/r8Ypo04hKffa4z0dcco4JLeuPgGp9C8o7z
 VuU9FxW1ceUcvG7KppDIttP28jP76TcHo8QIoLq+CzecWJuXHAMoCItn214nCpWNDrWQ
 IJ/ifJ6b3spfF/xDZulGHjeSgZQpre6Fkp+gD56xEX4/evak7n0mxaHciZDUzBfkCeph
 ZfS2GNPBdCLNA9GA0EdSm1LZtAcYGPJ3ch97lXKqGXMn8yJVY79z7Q3gjZ5jVbKsMF8s
 umNA==
X-Gm-Message-State: APjAAAWmNXrqqGBcU1qLQJHPEgRcUtetsk58sp8Eam5UQhmKyjZzlgrB
 QinziOe5HWFdZHQYHr1D5zJXRw==
X-Google-Smtp-Source: APXvYqwZDXiuC+ZoXw5GmfDQIFyxCY+SCvD/BX80srjZ3COvA9lnbl4+CnNoHlyQSE/z9TA251EnvQ==
X-Received: by 2002:a7b:cb4e:: with SMTP id v14mr2428422wmj.159.1568806504055; 
 Wed, 18 Sep 2019 04:35:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o188sm3626579wma.14.2019.09.18.04.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 04:35:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 82BE31FF87;
 Wed, 18 Sep 2019 12:35:02 +0100 (BST)
References: <20190917185537.25417-1-jsnow@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
In-reply-to: <20190917185537.25417-1-jsnow@redhat.com>
Date: Wed, 18 Sep 2019 12:35:02 +0100
Message-ID: <87y2ylzvkp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] tests/docker: fix typo for debian9-mxe
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

> We spelled it debian-9-mxe, but the image is debian9-mxe.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

I'll merge this fix with the other typo fix while I'm at it. Thanks.

> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 50a400b573..7eac1516f6 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -7,7 +7,7 @@ DOCKER_FILES_DIR :=3D $(SRC_PATH)/tests/docker/dockerfiles
>  DOCKER_DEPRECATED_IMAGES :=3D debian
>  # we don't run tests on intermediate images (used as base by another ima=
ge)
>  DOCKER_PARTIAL_IMAGES :=3D debian debian8 debian9 debian10 debian-sid
> -DEBIAN_PARTIAL_IMAGES +=3D debian8-mxe debian-9-mxe debian-ports debian-=
bootstrap
> +DEBIAN_PARTIAL_IMAGES +=3D debian8-mxe debian9-mxe debian-ports debian-b=
ootstrap
>  DOCKER_IMAGES :=3D $(filter-out $(DOCKER_DEPRECATED_IMAGES),$(sort $(not=
dir $(basename $(wildcard $(DOCKER_FILES_DIR)/*.docker)))))
>  DOCKER_TARGETS :=3D $(patsubst %,docker-image-%,$(DOCKER_IMAGES))
>  # Use a global constant ccache directory to speed up repetitive builds


--
Alex Benn=C3=A9e

