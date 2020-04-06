Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68962C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD2F248D1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9JvenN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD2F248D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLTtz-0005PS-8y
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLTsq-0004im-Gc
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLTsp-0004yc-DG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:41:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLTsp-0004xX-5e
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:41:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id z7so68390wmk.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 08:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SNsKV9g8GvqYOrTRpF0yinkQNTow1PAHU5ikRPSAU+Y=;
 b=L9JvenN9vIZduJnWgDMGd12cOJw9facbDNvo9y1cZDT7eKUakTeSeoqXOLUiSbTIu3
 9nh0RX/2FmOSJ7Rr7iuMPbRxXuqSDholnQdW8WEmJSRv8WWVvn2m9c82jFQCqUTHK7mg
 k8Jz5sYN+UFKSH/zeQbzYdrJG1RTE/YoFBTjuNDomEzFc5VgtRvuWXHdqTMq0tyEu6So
 X3OIQG8ksX7mjnOGgtBAEp7AxbFun2S6PMhVFMXgfpWkoHNlUUYU6wJt2Yhh3soOA223
 PHmKSjjK/9w8PEhS9l1Zw12iq1e8np5/4w+zv8cXk7GIFcpe7pVYAZPB94iJcjjyItZz
 J4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SNsKV9g8GvqYOrTRpF0yinkQNTow1PAHU5ikRPSAU+Y=;
 b=mq5Ik+rODhmZFNqApS1isOXIfRLsRA4m/o3kiDl0fn+x9YOktGj/Sor6MCco/OarIq
 ZhhFoKQ1uEgOxsrWRZbm+dwCFU8qpPbriY7kKzVGlG3mL/nqje2q5M1IH4yLZOODD0Kn
 06PibhLT4NntlTOY+gP7qZO+qLXEtyu1RoLtdIxATZ0jlIrxVkCURAv+clml3rFc+bj3
 rVdu6yZ9xqt+zcKqHaQOcQpEUB/7GxBNfmO6H+/JNx6+8mJCzSLvpMb9JuOPZqUdqNoy
 GodOqT3ikI/6+weP18NZnkNRxjlIh+26O1kSr+kdhhFbY4sVr9Vtj5S8REAMjGTaSJm9
 p4lA==
X-Gm-Message-State: AGi0PuYLJCNIhQCOi0QiC7szxb7szMfPdvxsYRxClUq9DirGosyN2eyX
 Yb8whN/WEU4RL6hFlTfG8ZJJhg==
X-Google-Smtp-Source: APiQypJyLXFe96Dyyn0y7IaGw2gcpDZHslElhWy9mBvXglK9NgxM4p0WcAmFh55JqmZWax069JFxew==
X-Received: by 2002:a7b:c053:: with SMTP id u19mr5745wmc.118.1586187713719;
 Mon, 06 Apr 2020 08:41:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q4sm377853wmj.1.2020.04.06.08.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 08:41:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 01A5C1FF7E;
 Mon,  6 Apr 2020 16:41:50 +0100 (BST)
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-7-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1 6/8] tests/Makefile: Add fetch-acceptance-assets
 rule
In-reply-to: <20200403172919.24621-7-philmd@redhat.com>
Date: Mon, 06 Apr 2020 16:41:50 +0100
Message-ID: <87zhboaaf5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?utf-8?Q?Her?= =?utf-8?Q?v=C3=A9?= Poussineau <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/Makefile.include | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 51de676298..90f457593c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -906,6 +906,13 @@ get-vm-image-fedora-31-%: check-venv
>  # download all vm images, according to defined targets
>  get-vm-images: check-venv $(patsubst %,get-vm-image-fedora-31-%, $(FEDOR=
A_31_DOWNLOAD))
>=20=20
> +fetch-acceptance-assets: check-venv
> +	$(call quiet-command, \
> +            $(TESTS_VENV_DIR)/bin/python -m avocado \
> +            --show=3D$(if $(DEBUG),avocado.test,$(AVOCADO_SHOW)) assets =
fetch \
> +            tests/acceptance/*py, \
> +            "AVOCADO", "tests/acceptance")
> +

I'm wondering if we could expand this to a rule per-test group and
therefor allow parallel fetching of groups of assets?

>  check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>  	$(call quiet-command, \
>              $(TESTS_VENV_DIR)/bin/python -m avocado \


--=20
Alex Benn=C3=A9e

