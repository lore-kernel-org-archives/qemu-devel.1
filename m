Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029B9C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41C423107
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW2GVbQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41C423107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLThr-0004Hg-Sd
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLTgz-0003it-Fx
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLTgx-0005FI-8W
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:29:41 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLTgw-0005EK-UT
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:29:39 -0400
Received: by mail-wm1-x342.google.com with SMTP id d202so23479wmd.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zEXPJn9Z+E+1fFGkHkJLSxByfoV1JZFvooIup7043EY=;
 b=tW2GVbQJDo7cw8gwuU1A6fQNS+R5DJOVm8T/cfH3PWxX7kw2eaB75Lgs1BMRhSn+PC
 2Jq/eGxf5eT1DjE8jpdnMnYvd3t3qXzwqpSh4ixctr4leKwwoUg6I56ixnKFGTgTVAe1
 7qRVhkNl7Q7rc57ukX2k4ZRD0CDuE+D7YIFEgITUs1xybl5TkUYyYqxXuRXmJJPxYRW4
 I4Wa8P6AD+rCgg5EMT3hMb3qQSf7Fii5uVWPtLeM6/R6rPdc2FyxZmXlyU4X4oET4S1n
 bG41ktC7x4Z4nsWBxzYzUWv9XqWr2VYtEmVMRGV48D6VNn20MTiCC5Sgv72b3avRF6O7
 sboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zEXPJn9Z+E+1fFGkHkJLSxByfoV1JZFvooIup7043EY=;
 b=oFovxrg70EZsEMoVCpDvQMc29CUPZ21GmGyOMqL5X61nwjfxq3gPkOeYVezmjMA8Qn
 8MmqoMATuSzsxgb2CJNkSw6gSKmqdizkoqZ/UCjKF/AM7HsFEOqXvHvFNhJdFCnQBY7t
 tzzUCuN+G/J26Vmp89Ghgprq40ny9ERVrxDiN7l1Hj7LGM9/ju2/MABinAMnd0J+dc9E
 uPRqq2d8l3lkSHqzjfJsPasI8QyFnXReYwIOZ+pOi4FUhVsbS3EuYm1o630zjE5x1pOB
 3DukbSI5fzu68NIaiWFsMcPrjI9fAVWwX0B1erFgDvuP1GohRecHdUjt35uTEZmvmJ3T
 NdrA==
X-Gm-Message-State: AGi0Puaqnck7tEmSZFGEgOYDP9Fn22ETRgQ4CUTLmulxf0DtVAZPTbMj
 EeLaPoRJm7/7LfPu9R1lz6PucA==
X-Google-Smtp-Source: APiQypKve3DvhSk+LKFqGvd++tmJZN2McZ+CiMwx386pBo1oNXkDa7fmRN6M2SyMgd8Y+ZcZgQmHbA==
X-Received: by 2002:a7b:c205:: with SMTP id x5mr209491wmi.189.1586186977846;
 Mon, 06 Apr 2020 08:29:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q14sm25198752wrx.57.2020.04.06.08.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 08:29:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E90951FF7E;
 Mon,  6 Apr 2020 16:29:34 +0100 (BST)
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-6-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 5/8] .travis.yml: Cache acceptance-test assets
In-reply-to: <20200403172919.24621-6-philmd@redhat.com>
Date: Mon, 06 Apr 2020 16:29:34 +0100
Message-ID: <875zecbpk1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

> Keep all acceptance-test assets in the same cache bucket.
>
> As of v5.0.0-rc1, the cache is 2610.11MB:
> https://travis-ci.org/github/philmd/qemu/jobs/670558103
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .travis.yml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index e0c72210b7..2fd63eceaa 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -318,8 +318,10 @@ jobs:
>        env:
>          - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha=
-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-=
softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,=
sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
> +        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>        after_script:
>          - python3 -c 'import json; r =3D json.load(open("tests/results/l=
atest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["statu=
s"] not in ("PASS", "SKIP")]' | xargs cat
> +        - du -chs $HOME/avocado/data/cache
>        addons:
>          apt:
>            packages:


--=20
Alex Benn=C3=A9e

