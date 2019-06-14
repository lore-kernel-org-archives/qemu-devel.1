Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71A3F20866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TzfwC8Rk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A3F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52090 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnDR-0003eI-JQ
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbmnT-0003ZQ-7G
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbmnR-0007Xj-Ue
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:03:15 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbmnR-0007SM-O2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:03:13 -0400
Received: by mail-wr1-x441.google.com with SMTP id m3so2697097wrv.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qq4VHN8N+SWKk9YIa+opW+lplvmoYBo+YzFJJwj5ISY=;
 b=TzfwC8RkkLHIenL1m4+vljKjDGV7iqwI8HtCUj47Ja6bzLVHiP0Lg86vWbbn/JnpNc
 nhr7YXD0bDKn/FXQQMQbVM/5A8++BRlMr3QWB/Psy10TsQMAo6pfAnTqTSb6RfjB4LoN
 IT5aEqRTFh8ESpcGe4PcQeNvOLNmRaGIB2ARsnvM9EMaclQmwEhxcKJCbQGzIFJpWElW
 CqyUjHGW5z9fernkdtOyzBSOOu0YHtgJBsUp/SYF5aePZEbNcbqMnP5VefNVfXo59juK
 BfCKnursIxiivK//EmmOpplmovT35eeSQb6jM440t2QreNGUvVuQ0lxW11IiMCPJniPj
 utrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qq4VHN8N+SWKk9YIa+opW+lplvmoYBo+YzFJJwj5ISY=;
 b=JaWH6/Clr73CpFAyomoq2yQ0oQ2+2zP5MMWs0FKEjPs8XEzqZxJWIc7LlGNpxBJhdw
 BOn/d5c3JwHhkrN2ftHCwdPf9n1GeqRdfUUsf7VRpqDHpJ0xjuLoJDcLLXNxhKJWE9ge
 bGqRDgoU4nXgxRCgi2TCbnjNwfTBHJPP3LQH+F6FE94SKdcshanCzcr48GyFaLtiGvkL
 sHjqx0OaDYthjqrMpVW5IInUXcpIKW/8uz7bVVahmIFOwSZ5tEejVC+2LvE4pp4hubjw
 uXoYfDyy0ecAsqbjNLSpeuTcsqP+sfWEQHhY799NzaRQ0gLS1ZrM/UlsbXl2bASR3V33
 +i7w==
X-Gm-Message-State: APjAAAUJXLPLQaCDIDYUKRft+NIeumEJ4RrdD9t/7/Oe1sZdOAaMKXdT
 XsBN3/lhmxHsFEwX0cdk0HVjlQ==
X-Google-Smtp-Source: APXvYqziuQ9Ev/Fc9LC41dX0WDXvNzGxaTwHOZmr1FTCNg2pRxnpLH96RNfexheD9LsY/XsTlGO38w==
X-Received: by 2002:adf:e8d0:: with SMTP id k16mr51745429wrn.31.1560520985928; 
 Fri, 14 Jun 2019 07:03:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 67sm3388136wmd.38.2019.06.14.07.03.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 07:03:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E818D1FF87;
 Fri, 14 Jun 2019 15:03:04 +0100 (BST)
References: <20190614072432.820-1-philmd@redhat.com>
 <20190614072432.820-7-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190614072432.820-7-philmd@redhat.com>
Date: Fri, 14 Jun 2019 15:03:04 +0100
Message-ID: <871rzwe02v.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH 6/6] .travis.yml: Test static linking
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 integration@gluster.org,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, =?utf-8?Q?Lo=C3=AFc?= Minier <loic.minier@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Bharata B Rao <bharata@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This job currently fails:
>
>       LINK    lm32-softmmu/qemu-system-lm32
>     /usr/bin/ld: cannot find -lgtk-3
>     /usr/bin/ld: cannot find -latk-bridge-2.0
>     /usr/bin/ld: cannot find -latspi
>     /usr/bin/ld: cannot find -lsystemd
>     /usr/bin/ld: cannot find -lgdk-3
>     /usr/bin/ld: cannot find -lwayland-egl
>     /usr/bin/ld: cannot find -lmirclient
>     /usr/bin/ld: cannot find -lmircore
>     /usr/bin/ld: cannot find -lmircookie
>     /usr/bin/ld: cannot find -lepoxy
>     /usr/bin/ld: cannot find -latk-1.0
>     /usr/bin/ld: cannot find -lgdk_pixbuf-2.0
>     /usr/bin/ld: cannot find -lselinux
>     /usr/bin/ld: cannot find -lgtk-3
>     /usr/bin/ld: cannot find -latk-bridge-2.0
>     /usr/bin/ld: cannot find -latspi
>     /usr/bin/ld: cannot find -lsystemd
>     /usr/bin/ld: cannot find -lgdk-3
>     /usr/bin/ld: cannot find -lwayland-egl
>     /usr/bin/ld: cannot find -lmirclient
>     /usr/bin/ld: cannot find -lmircore
>     /usr/bin/ld: cannot find -lmircookie
>     /usr/bin/ld: cannot find -lepoxy
>     /usr/bin/ld: cannot find -latk-1.0
>     /usr/bin/ld: cannot find -lgdk_pixbuf-2.0
>     /usr/bin/ld: cannot find -lselinux
>     /usr/bin/ld: attempted static link of dynamic object `/usr/lib/x86_64=
-linux-gnu/libz.so'
>     collect2: error: ld returned 1 exit status
>     Makefile:204: recipe for target 'qemu-system-lm32' failed
>     make[1]: *** [qemu-system-lm32] Error 1
>     Makefile:472: recipe for target 'subdir-lm32-softmmu' failed
>     make: *** [subdir-lm32-softmmu] Error 2
> ---
>  .travis.yml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 08502c0aa2..6962fff826 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -92,6 +92,11 @@ matrix:
>          - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTMM=
U_TARGETS}"
>
>
> +    # Test static linking
> +    - env:
> +        - CONFIG=3D"--static --target-list=3Dlm32-softmmu"
> +
> +

It's probably more useful to have a:

  CONFIG=3D"--disable-system --static"

In fact arguably we could just add it to the first --disable-system
stanza as there are other linux-user builds scattered about to catch the
cases where we break dynamically linked linux-user builds.

>      # Just build tools and run minimal unit and softfloat checks
>      - env:
>          - BASE_CONFIG=3D"--enable-tools"


--
Alex Benn=C3=A9e

