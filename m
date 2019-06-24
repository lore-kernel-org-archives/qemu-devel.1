Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D9C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFAD520679
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 09:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hfiqFgAs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48998 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfL6g-000745-2i
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 05:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52789)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfL4m-0005uR-70
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfL4k-0007mk-W9
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:15:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfL4i-0007Vz-45
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 05:15:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id n4so12997895wrw.13
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yPT+p/oPFgsesjCyQq2ViD4VEzs7q1Wyyw2Dq9TRy24=;
 b=hfiqFgAsFn+nqeRcezBksGjM85+kYxz2QKOqqkdBjJPZXq7Eu28Z5SHbl3xsqAHa7A
 hZEfBWF7uDQHhYMxZ7vFK1asYFL2N5f9bCtvA7PSazP4W/TW2jqWOufHZ3w/FH1I8hPQ
 ncvG1ZEmX4o225+9UoLDQmETL2c2RO4tFCjQyDxEcFXEHYkcMbzMjrgTyLBAKqQeNJuN
 YgHlj+dDYCDxvAflqxqltLjJucSsCn9gS6Q70sA+8xlQ+zWk4azcS8HPPTKoJZ9s2v5W
 NCyC4+KBQcCb2+82tPZujStiFB0AunUXrKhKBSNtEsU4hXUyO226M4MFfCKyW0CTaI9h
 QDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yPT+p/oPFgsesjCyQq2ViD4VEzs7q1Wyyw2Dq9TRy24=;
 b=oK1z0qIRiiE3d2AYyJ7B3Nm+g+X22CFJbtPtyNgdloaDNnWdTclVrKworwUzl6HSmf
 VGYBYPnFbhZ8DQ2mrk3KyW+FGU30NVj4vGF2eve1GR/fHrx8LYyl/pEugmCU/iPUN5Gk
 8VS5Y4GWdliEnaRbSKIQArguS2OXkXYJ+4ESsbUuw/9KL1b8z3GUg3bdOpcrChOzY6D2
 fK8wzrmNKSacuMXEAeZpTZa0W4bLkLzgoivRCDgJzK5z8GYP+XThNqyhx9SNWsus5ZRT
 hRVuXfu1osiNJqjYDe+lqL8g53vPsCnkC/x6jiDqsfxNxNQlwPA/XD9CorfC8qPWfCZ+
 E7EA==
X-Gm-Message-State: APjAAAUB/iEEhrRRpajsSdeZ1q7HuXO2DVtwvpGkkQXmLX/7jPx0c9U1
 IaPhnLJ/SgXuICQHDZNELkRvuQ==
X-Google-Smtp-Source: APXvYqwnqu7jQCq+ELf9TYNkl8NJQ2+lPGy879F8/wogaH+RarUeIQF2QvRe5fhIk05O6jTogb/zLA==
X-Received: by 2002:adf:f3c7:: with SMTP id g7mr31412137wrp.133.1561367738652; 
 Mon, 24 Jun 2019 02:15:38 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j32sm24957260wrj.43.2019.06.24.02.15.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 02:15:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEEAD1FF87;
 Mon, 24 Jun 2019 10:15:37 +0100 (BST)
References: <20190531064341.29730-1-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
In-reply-to: <20190531064341.29730-1-philmd@redhat.com>
Date: Mon, 24 Jun 2019 10:15:37 +0100
Message-ID: <87tvcf1gzq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] Makefile: Rename the 'vm-test' target as
 'vm-help'
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> We already have 'make check-help', use the 'make vm-help' form
> to display helps about VM testing. Keep the old target to not
> bother old customs.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to testing/next, thanks.

> ---
> Based-on: <20190530101603.22254-1-alex.bennee@linaro.org>
>           "testing/next queue"
> ---
>  Makefile                  | 4 ++--
>  docs/devel/testing.rst    | 4 ++--
>  tests/vm/Makefile.include | 5 +++--
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index f0be624f47..f67739df7c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -9,7 +9,7 @@ SRC_PATH=3D.
>  UNCHECKED_GOALS :=3D %clean TAGS cscope ctags dist \
>      html info pdf txt \
>      help check-help print-% \
> -    docker docker-% vm-test vm-build-%
> +    docker docker-% vm-help vm-test vm-build-%
>
>  print-%:
>  	@echo '$*=3D$($*)'
> @@ -1121,7 +1121,7 @@ endif
>  	@echo  'Test targets:'
>  	@echo  '  check           - Run all tests (check-help for details)'
>  	@echo  '  docker          - Help about targets running tests inside Doc=
ker containers'
> -	@echo  '  vm-test         - Help about targets running tests inside VM'
> +	@echo  '  vm-help         - Help about targets running tests inside VM'
>  	@echo  ''
>  	@echo  'Documentation targets:'
>  	@echo  '  html info pdf txt'
> diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
> index da2d0fc964..68aba3926e 100644
> --- a/docs/devel/testing.rst
> +++ b/docs/devel/testing.rst
> @@ -399,12 +399,12 @@ VM testing
>
>  This test suite contains scripts that bootstrap various guest images tha=
t have
>  necessary packages to build QEMU. The basic usage is documented in ``Mak=
efile``
> -help which is displayed with ``make vm-test``.
> +help which is displayed with ``make vm-help``.
>
>  Quickstart
>  ----------
>
> -Run ``make vm-test`` to list available make targets. Invoke a specific m=
ake
> +Run ``make vm-help`` to list available make targets. Invoke a specific m=
ake
>  command to run build test in an image. For example, ``make vm-build-free=
bsd``
>  will build the source tree in the FreeBSD image. The command can be exec=
uted
>  from either the source tree or the build dir; if the former, ``./configu=
re`` is
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5e37063d32..b7311d7bd9 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -8,8 +8,9 @@ IMAGE_FILES :=3D $(patsubst %, $(IMAGES_DIR)/%.img, $(IMA=
GES))
>
>  .PRECIOUS: $(IMAGE_FILES)
>
> -vm-test:
> -	@echo "vm-test: Test QEMU in preconfigured virtual machines"
> +# 'vm-help' target was historically named 'vm-test'
> +vm-help vm-test:
> +	@echo "vm-help: Test QEMU in preconfigured virtual machines"
>  	@echo
>  	@echo "  vm-build-ubuntu.i386            - Build QEMU in ubuntu i386 VM"
>  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"


--
Alex Benn=C3=A9e

