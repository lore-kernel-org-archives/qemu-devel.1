Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB73C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A7520735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFVSP15f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A7520735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEH8C-0002s1-5n
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEH4h-0005tD-Ro
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEH4g-00014K-KO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:36:23 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEH4g-0000vo-AN
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 14:36:22 -0400
Received: by mail-wr1-x441.google.com with SMTP id a25so27064725wrd.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=1QV6QjxpBz1oTUXKtsmy/dpWi6SiQuScvTnQVcrmG7I=;
 b=uFVSP15f0KbQL52SlWhzYh5IqcK03Nc68ilxOi6Bmv/7vInGURMXHWxl8n4szv1R9K
 4VfSe4wdU0JowBiQn5Eii7B8rzuBStClWn10dHSwXijwL4jv42B2okJbvTgq0esTA/SR
 7KWPvQttvNPMpweTChY2bbzcePJ2YetjwRRfYaR1itoqgTkaj3sRgizFYD1Whe+QKlvH
 zt2ihVXCqDK+mtPQvkh4DdMQqyfXCpsG26/GPQjZ0PMQpCRxz99+teIbZT1iyIsyOrFl
 omsgb0wbPHokDWcTA7OwDksbLr3pHH5c3oaz+MUj0fmzjipOR2HUpt8UwAph/RsIeXw2
 AaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=1QV6QjxpBz1oTUXKtsmy/dpWi6SiQuScvTnQVcrmG7I=;
 b=ZpCYMCixRGK69mhFkYbzs/8zOW1UXJH24P/mNqFTdL1pipwgEASNdUU9GqDrrmHWUS
 KOkwS+K8tDZDYJqEN1X8ZtUShJleQ1njyEhZ6SOFjGWF+43gzj4L5KhX7y0Oqi9fnpWE
 17JYcN3iRfgZaZF5tOZLSgEUD7/9ORLBloQMda+CkoJPsqSUGUbMOYyHRrtUHtjtNsqt
 8wxH9HlFJOOcNj55I51l6xIp1HzpNlavRRVe/ZLknLQ381VivfbDnMytGIpmRBMqfuuy
 UQJkkR4HSRx1DXSEupJPUIEeaCOgU+p02noonULQCOPzBRFt0cBUTL8XCkijXH1jKI0+
 a/Jw==
X-Gm-Message-State: ANhLgQ0mJKIzektnqVds30nhnaJtoPA8GbL6ktL5qZouUxdCVa/bThME
 3fLrO0mol54Yz1lRWbC/YFVcfw==
X-Google-Smtp-Source: ADFU+vuJG96nTqa2GpOqwYpGVVp5BwPUbIA0ODgc8qsPp0unqUsOVKCXjNqphzkab6R+NzJNEIX+gA==
X-Received: by 2002:a05:6000:11c1:: with SMTP id
 i1mr367938wrx.146.1584470181081; 
 Tue, 17 Mar 2020 11:36:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l26sm317516wmi.37.2020.03.17.11.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 11:36:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 752B21FF7E;
 Tue, 17 Mar 2020 18:36:18 +0000 (GMT)
References: <20200317141654.29355-1-crosa@redhat.com>
 <20200317141654.29355-4-crosa@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v10 3/3] Acceptance tests: add make targets to download
 images
In-reply-to: <20200317141654.29355-4-crosa@redhat.com>
Date: Tue, 17 Mar 2020 18:36:18 +0000
Message-ID: <87d09akevx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Cleber Rosa <crosa@redhat.com> writes:

> The newly introduced "boot linux" tests make use of Linux images that
> are larger than usual, and fall into what Avocado calls "vmimages",
> and can be referred to by name, version and architecture.
>
> The images can be downloaded automatically during the test. But, to
> make for more reliable test results, this introduces a target that
> will download the vmimages for the architectures that have been
> configured and are available for the currently used distro (Fedora
> 31).
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Willian Rampazzo <willianr@redhat.com>
> ---
>  tests/Makefile.include | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 67e8fcddda..9c19229a06 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -20,6 +20,8 @@ check-help:
>  	@echo " $(MAKE) check-venv           Creates a Python venv for tests"
>  	@echo " $(MAKE) check-clean          Clean the tests and related data"
>  	@echo
> +	@echo " $(MAKE) get-vm-images        Downloads all images used by accep=
tance tests, according to configured targets (~350 MB each, 1.5 GB max)"
> +	@echo

I'm not overly enamoured with a super long line help for something that
is a dependency anyway but whatever...


>  	@echo
>  	@echo "The variable SPEED can be set to control the gtester speed setti=
ng."
>  	@echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; they c=
an be"
> @@ -889,7 +891,20 @@ $(TESTS_RESULTS_DIR):
>=20=20
>  check-venv: $(TESTS_VENV_DIR)
>=20=20
> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
> +FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
> +FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CAN=
DIDATES))
> +
> +# download one specific Fedora 31 image
> +get-vm-image-fedora-31-%: $(check-venv)

Why $(check-venv) instead of check-venv

> +	$(call quiet-command, \
> +             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
> +             --distro=3Dfedora --distro-version=3D31 --arch=3D$*)

Some short text for the operation would be nice (DNLD acceptance images?)

> +
> +# download all vm images, according to defined targets
> +get-vm-images: $(check-venv) $(patsubst %,get-vm-image-fedora-31-%, $(FE=
DORA_31_DOWNLOAD))
> +
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>  	$(call quiet-command, \
>              $(TESTS_VENV_DIR)/bin/python -m avocado \
>              --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
> @@ -900,7 +915,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>=20=20
>  # Consolidated targets
>=20=20
> -.PHONY: check-block check-qapi-schema check-qtest check-unit check check=
-clean
> +.PHONY: check-block check-qapi-schema check-qtest check-unit check check=
-clean get-vm-images
>  check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-sch=
ema/doc-good.texi
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  ifeq ($(CONFIG_TOOLS),y)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e

