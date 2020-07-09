Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F968C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C55920663
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 10:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fftw/Y6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C55920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtTTd-0005Kt-EB
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 06:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtTSv-0004iI-Uz
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:07:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55622
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtTSu-0005UV-5z
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 06:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594289259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=auihBxFb9cjWOGNIiF4X2LgiAl2xiZYtPtnAIbdvRro=;
 b=fftw/Y6MN4/LIhdUD3XzENNUGbHt3XZz/JwkBVoN7tthGV/awuSR4U4hpxoX288EoAVcQe
 ztY68cSINw1SUZtGP0Fpe6Iy0S+f/pK5XmBGDJQ6ON9NZfSEi542hWlL6BIjX298iscrax
 UYfdHEEh4pb1Knas3rT6ALCnz7ByPOc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-GK9YFvtgMeSebcRMwYeKXQ-1; Thu, 09 Jul 2020 06:07:35 -0400
X-MC-Unique: GK9YFvtgMeSebcRMwYeKXQ-1
Received: by mail-wr1-f69.google.com with SMTP id c6so1575462wru.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 03:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=auihBxFb9cjWOGNIiF4X2LgiAl2xiZYtPtnAIbdvRro=;
 b=V90xKvJH21XSYFOOzGxW3JJaQ3Zf6EPsScK7gsqTQYCHH5ArBkvgrKqgMTwP8JCVPp
 0LOPJ2IuBpwIYUNt6a3ItHmVWcu1vLn2uQHzXoy4TNGZwccQ34Ur53U6tWzMp6RyS3Zy
 AOqqGksXzP3SiMQxAybGbDyQC6vI901GBVIMa2+cOdQ2b74ynvnwOkGlQgaIp51r+oin
 c2VsNzkM5Q4g4zWtxu2G/vwSwKe8UsKBn+slP7QujsuKr9QnvaKLLtvgo2uGHYokZZeS
 BD2xEHEf2MoqvFmZB1v16NroE7Yl+cW6A1G0YbJrBwKBfbG2rprObN8TGQmGAkPj3BGq
 m5Jw==
X-Gm-Message-State: AOAM533PKe2FZ8WmNyw967my3jZOf8NEmVtStCmCEKXy9gADdzTbIRml
 u/sJMbBu0eYoGE2L4TDV7YxZJf6wNml75Og4lP58SfcuLjnZ7CrW3eJLui3uv0WOfxH3n2wj4SD
 IA5hw06JiwzLvEzU=
X-Received: by 2002:a5d:6412:: with SMTP id z18mr61104230wru.310.1594289254548; 
 Thu, 09 Jul 2020 03:07:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVlEMTihkNrwp4H2OKTekkypxW+dyhpj5k7SeQwtug5EabLWeHnMpPgiDbDmBnogUrliYNsg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr61104195wru.310.1594289254279; 
 Thu, 09 Jul 2020 03:07:34 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id j15sm4691729wrx.69.2020.07.09.03.07.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 03:07:33 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] GitLab Gating CI: initial set of jobs,
 documentation and scripts
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200709024657.2500558-1-crosa@redhat.com>
 <20200709024657.2500558-3-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <05209e8d-e501-74d0-ef58-25f2a971a4a8@redhat.com>
Date: Thu, 9 Jul 2020 12:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709024657.2500558-3-crosa@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 4:46 AM, Cleber Rosa wrote:
> This is a mapping of Peter's "remake-merge-builds" and
> "pull-buildtest" scripts, gone through some updates, adding some build
> option and removing others.
> 
> The jobs currently cover the machines that the QEMU project owns, and that
> are setup and ready to run jobs:
> 
>  - Ubuntu 18.04 on S390x
>  - Ubuntu 20.04 on aarch64
> 
> During the development of this set of jobs, the GitLab CI was tested
> with many other architectures, including ppc64, s390x and aarch64,
> along with the other OSs (not included here):
> 
>  - Fedora 30
>  - FreeBSD 12.1
> 
> More information can be found in the documentation itself.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  .gitlab-ci.d/gating.yml                | 146 +++++++++++++++++
>  .gitlab-ci.yml                         |   1 +
>  docs/devel/testing.rst                 | 147 +++++++++++++++++

Time to consider moving the CI doc in a separate file...

>  scripts/ci/setup/build-environment.yml | 217 +++++++++++++++++++++++++
>  scripts/ci/setup/gitlab-runner.yml     |  72 ++++++++
>  scripts/ci/setup/inventory             |   2 +
>  scripts/ci/setup/vars.yml              |  13 ++

Should we name these last two as inventory.template
and vars.yml.template?

Maybe you can add them with gitlab-runner.yml and a part of
the documentation in a first patch,

Then build-environment.yml and another part of the doc
in another patch,

Finally gating.yml and the related missing doc as the
last patch?

>  7 files changed, 598 insertions(+)
>  create mode 100644 .gitlab-ci.d/gating.yml
>  create mode 100644 scripts/ci/setup/build-environment.yml
>  create mode 100644 scripts/ci/setup/gitlab-runner.yml
>  create mode 100644 scripts/ci/setup/inventory
>  create mode 100644 scripts/ci/setup/vars.yml
[...]


