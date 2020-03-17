Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51643C5ACD6
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4F720724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 21:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUwBRwuW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4F720724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEK76-0001Pu-Av
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 17:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrampazz@redhat.com>) id 1jEK6I-0000rl-Eb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:50:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrampazz@redhat.com>) id 1jEK6H-0005FC-5K
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:50:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:54538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrampazz@redhat.com>) id 1jEK6H-0005B3-1H
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 17:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584481812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grqFsHOg4QrltrWQJzr0+hied9socK2T9rJsxFrQTxI=;
 b=AUwBRwuWo8C3M0+DnRGjeKiPLvJyrDfVYi8b8j5FbE7LtMW0Itfz65jO1huUaN8YslG7Tc
 YaLB91EFub2Qfhy+idF1h2otNdhGO7f7PjeWK8hpMlNnR1itwoIdPsMonMBzftXe6TGREp
 FFbu78r1aBZ429KmD4kuglHagTsRO/M=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-pEUAPPRDNk2mm6WigG1uvw-1; Tue, 17 Mar 2020 17:50:10 -0400
X-MC-Unique: pEUAPPRDNk2mm6WigG1uvw-1
Received: by mail-ua1-f70.google.com with SMTP id 16so4414102uag.13
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 14:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cXLgNdZLOni2wjqzU6hPkaqg3fK369aFs/4zE9r+p8I=;
 b=rrst0ATphinwhXaITYs45FXTQf11ki9pws9aqEUE2PFGR4osM/fO5USrL9+KEmH77j
 fp4N0S164lj4SMyYFlq0Nb+d3dQGTvextn1YQvcFzwGxOHyCI6gyLTKNCjfIL2di3074
 10wdQi1vv4jUjoJT3m8t2k/SxLOBkqGfAdDgXbxjKjxJP72CZtljdYWjZ7BlySJIM0c4
 uC6rq+PXoOoR06+ud2Zm+ehMt648wf6UX3JMK3wSJrCbt9A4a5lpLafQ+SwBVTcAuxc5
 DjLJu86RVh5vOyYxqqviS7KC/sXegcPMFe/7ZKX3C50ycnaNtejFoWe4vO2x6I28upay
 IOTg==
X-Gm-Message-State: ANhLgQ3kHUlsao29EqbUQDUu3mA9FJpXKoMIWe/Vl276dgHITzzyRHX9
 O/I0A0IjAvPs0ToLC+b5PmsyLo0Q6Xxe0A/x7RWnfhRXpH67LX7PukHHyPX7QBviM3IuNxMqHYV
 czeycUk0nl3CCwX42Q+qEgkxvhgoGNEU=
X-Received: by 2002:a67:7f58:: with SMTP id a85mr969268vsd.28.1584481810402;
 Tue, 17 Mar 2020 14:50:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vurwPnel5R4HSgEEm9GccRVwnlWUYd5la5uuqMvEIOYfbrLDtrQVpYqpltyE0O8Zsx/Ro6bRF5LdMJOdbv0V6U=
X-Received: by 2002:a67:7f58:: with SMTP id a85mr969247vsd.28.1584481810115;
 Tue, 17 Mar 2020 14:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200317141654.29355-1-crosa@redhat.com>
 <20200317141654.29355-4-crosa@redhat.com>
In-Reply-To: <20200317141654.29355-4-crosa@redhat.com>
From: Willian Rampazzo <wrampazz@redhat.com>
Date: Tue, 17 Mar 2020 18:49:59 -0300
Message-ID: <CAKJDGDbpO90n4kMxBkvaRFDpBMh0Pe0UeKUU5TcaZp1ft=Cv0w@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] Acceptance tests: add make targets to download
 images
To: Cleber Rosa <crosa@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <willianr@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 11:17 AM Cleber Rosa <crosa@redhat.com> wrote:
>
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
>         @echo " $(MAKE) check-venv           Creates a Python venv for te=
sts"
>         @echo " $(MAKE) check-clean          Clean the tests and related =
data"
>         @echo
> +       @echo " $(MAKE) get-vm-images        Downloads all images used by=
 acceptance tests, according to configured targets (~350 MB each, 1.5 GB ma=
x)"
> +       @echo
>         @echo
>         @echo "The variable SPEED can be set to control the gtester speed=
 setting."
>         @echo "Default options are -k and (for $(MAKE) V=3D1) --verbose; =
they can be"
> @@ -889,7 +891,20 @@ $(TESTS_RESULTS_DIR):
>
>  check-venv: $(TESTS_VENV_DIR)
>
> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +FEDORA_31_ARCHES_CANDIDATES=3D$(patsubst ppc64,ppc64le,$(TARGETS))
> +FEDORA_31_ARCHES :=3D x86_64 aarch64 ppc64le s390x
> +FEDORA_31_DOWNLOAD=3D$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CAN=
DIDATES))
> +
> +# download one specific Fedora 31 image
> +get-vm-image-fedora-31-%: $(check-venv)
> +       $(call quiet-command, \
> +             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
> +             --distro=3Dfedora --distro-version=3D31 --arch=3D$*)
> +
> +# download all vm images, according to defined targets
> +get-vm-images: $(check-venv) $(patsubst %,get-vm-image-fedora-31-%, $(FE=
DORA_31_DOWNLOAD))

I tested this target and it works as expected. In this case, also a

Tested-by: Willian Rampazzo <willianr@redhat.com>

> +
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>         $(call quiet-command, \
>              $(TESTS_VENV_DIR)/bin/python -m avocado \
>              --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_RES=
ULTS_DIR) \
> @@ -900,7 +915,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>
>  # Consolidated targets
>
> -.PHONY: check-block check-qapi-schema check-qtest check-unit check check=
-clean
> +.PHONY: check-block check-qapi-schema check-qtest check-unit check check=
-clean get-vm-images
>  check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-sch=
ema/doc-good.texi
>  check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>  ifeq ($(CONFIG_TOOLS),y)
> --
> 2.25.1
>


