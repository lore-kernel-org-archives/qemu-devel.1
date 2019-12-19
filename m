Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEB0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A0622465E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4do1gvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A0622465E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjVF-0000TT-KO
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ihjUI-0007zx-SZ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ihjUH-0003Hc-Kn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:16:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33613
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ihjUH-0003H2-G4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576714576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHwP+/ukecQmU1fm7oQoSQBEw1AB6ka1bNyk7IMCrj8=;
 b=I4do1gvUWi4dGOuWZA3atIfy1OkNh9VdsBH44AGno5/Mp5VfbxaV3Fqdt1rDUw8kGVJxrv
 lHfW9qzkpA0YfzW3U3XmxBptFPtCOszXhnfy1AUevp/rFvs6sirCLL2amkKoYKk2KqKbfA
 pTRL029rKOmViWZdszhiyZnnulUDHyQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-1AKacpo4O0WCL5S1nSY53A-1; Wed, 18 Dec 2019 19:16:15 -0500
Received: by mail-wr1-f69.google.com with SMTP id h30so1575808wrh.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hHwP+/ukecQmU1fm7oQoSQBEw1AB6ka1bNyk7IMCrj8=;
 b=H2I4LUW0TtoJwnDnOaJMltx+gw2jcg9TRa90kYhPwA71Gesfr4mAUq6qGPtzwpU/GB
 dgARVjo37THckVF1BwCL3O5RUGQo4bBBjCMvRoVC2t1qGKCklCZv/uM6LusHd2846sv2
 p6uFCHdwdveV6CULl9aSWniAPIs45EAM9SUFlXU9fQOtANqShAv6bhIAzU+djVI4orb8
 h9H1DBi+LSgg4V/OGStGin34mKQIwZjCheFZr6dDvzNSvj1cgwrQ+B/RAyE/4EbxJ9A+
 pMQRaaRj47TPVIVcStCPqO4MhP6xw+fGXEm3zWWOI1Cg/YwQhi/NJk4zZ5jsopB9ccEV
 lszg==
X-Gm-Message-State: APjAAAUMscKEucHdC1IEvkqNtL0yRkrxqIZqg+fmDLYIHp+XYGYqhBlQ
 drBTWiME0Wgq7pShCH0vA0cX+zB/hKHHAfrrHW19ej/9lpa1wCSrO0t8lW7mmOQcM8HpYdnvXP/
 KKZ4HrpXVmm4zvF4=
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr6184604wmj.37.1576714574219;
 Wed, 18 Dec 2019 16:16:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+Y7xRBWqA3f4ES0CHK8SyqK6ZQDnjbhba91gJG6kNlDdqv8V87l7P3N0hkojekhnNKMa9lw==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr6184592wmj.37.1576714574021;
 Wed, 18 Dec 2019 16:16:14 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id t125sm760678wmf.17.2019.12.18.16.16.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 16:16:13 -0800 (PST)
Subject: Re: [PATCH v8 3/4] Acceptance tests: add make targets to download
 images
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191218232500.23530-1-crosa@redhat.com>
 <20191218232500.23530-4-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e1dc21f1-a349-508e-db11-5aee59f31f2e@redhat.com>
Date: Thu, 19 Dec 2019 01:16:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218232500.23530-4-crosa@redhat.com>
Content-Language: en-US
X-MC-Unique: 1AKacpo4O0WCL5S1nSY53A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/19/19 12:24 AM, Cleber Rosa wrote:
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
> ---
>   tests/Makefile.include | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b381387048..78a6f089ff 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -1177,7 +1177,20 @@ $(TESTS_RESULTS_DIR):
>   
>   check-venv: $(TESTS_VENV_DIR)
>   
> -check-acceptance: check-venv $(TESTS_RESULTS_DIR)
> +FEDORA_31_ARCHES_CANDIDATES=$(patsubst ppc64,ppc64le,$(TARGETS))
> +FEDORA_31_ARCHES := x86_64 aarch64 ppc64le s390x
> +FEDORA_31_DOWNLOAD=$(filter $(FEDORA_31_ARCHES),$(FEDORA_31_ARCHES_CANDIDATES))
> +
> +# download one specific Fedora 31 image
> +get-vmimage-fedora-31-%: $(check-venv)
> +	$(call quiet-command, \
> +             $(TESTS_VENV_DIR)/bin/python -m avocado vmimage get \
> +             --distro=fedora --distro-version=31 --arch=$*)
> +
> +# download all vm images, according to defined targets
> +get-vmimage: $(patsubst %,get-vmimage-fedora-31-%, $(FEDORA_31_DOWNLOAD))
> +
> +check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vmimage
>   	$(call quiet-command, \
>               $(TESTS_VENV_DIR)/bin/python -m avocado \
>               --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
> @@ -1188,7 +1201,7 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR)
>   
>   # Consolidated targets
>   
> -.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean
> +.PHONY: check-block check-qapi-schema check-qtest check-unit check check-clean get-vmimage
>   check-qapi-schema: check-tests/qapi-schema/frontend check-tests/qapi-schema/doc-good.texi
>   check-qtest: $(patsubst %,check-qtest-%, $(QTEST_TARGETS))
>   check-block: $(patsubst %,check-%, $(check-block-y))
> 

We have both 'make vm-help' and 'make check-help'. The check-acceptance 
target is in check-help. We get vm image... confusing.

Anyway, can you list this new target, with a hint about the storage size 
required?
Can you add an entry in the 'make


