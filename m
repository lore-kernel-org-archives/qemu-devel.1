Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B4EC2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:33:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD3E248A6
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rw4UBeEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD3E248A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLTkj-00078j-O5
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 11:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLTiy-0005X7-07
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLTis-0006YE-6x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:31:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44247)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLTis-0006XQ-0w
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 11:31:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id c15so2099019wro.11
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=eCsBcSRwdbNhZ3apFPLaozEaoCikGytkMNTSku2WWlM=;
 b=rw4UBeEb6dypC1cRzcpyuljZ03AzoTE8JL6aQC10ivONyIZRPwF38SoURgJyKEbKTc
 pbjcYYpuYfaKhDRyc8BKXU+I2yzh1x0Jq1PDN4ddfViXyYDzi87c/nniqzrUGd5HxcPe
 WIIiL4KrjJoumFs+XRC/vZvctPQ5DCrCDhb5e0iVH9hlPZL/VzorhRliDpWLvA6SH4mJ
 y/XXPdYbj/P+CIeYu/y126PaJN7XSqbCGRdvG/raJ8aMT1qtxyP5NOkolzVow3GWFhox
 n4hUbQICreDrjVFMPpZ4TqedK7XtQB9QaVUfv5sIp8qiCtj5bbmTeh3smgGE+R50WSju
 qgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=eCsBcSRwdbNhZ3apFPLaozEaoCikGytkMNTSku2WWlM=;
 b=QuauoL3tprDw8O87jDCMg/DEyThEpKUfJWf+XnZKk9eI5C5DfhOohuxb0jYh7wJY04
 fiXiw+HcmmbvykITnmzNShNSlrDe1fQ3bmWtD1Yle3Un4Iy/J7SZV7WiKWs4m2+kBlWA
 EuZE7VaL2dfysLxwFWceEV+rnpFL5KH4RvXmFgX0/SOUdkH8FHey/LKKkLzlbs011gDZ
 KMR/fbp7X54Q/kExExqwqjjlj4FLmblYGveUw7FWskXaMhKqSyDvGWuaovYIqBIZv4ii
 8lwpR6Ni/aE+jT8uriHxPBYj7IuGL01ZEJLP3Pey48NSrCbPWwTMB+Z+ttoM9pn+0E0V
 gJKA==
X-Gm-Message-State: AGi0PuY9+sE4RIGz43vsjU1Fnw+3XjyiJot1HW4ghBtPDemA09ULICs8
 lTpCex5w1Bxe+hzjt4wPih1fAA==
X-Google-Smtp-Source: APiQypIbrXglk8bKbAc0FR0YnV+3vTGiTVci8EHjjUJjW0P4CSSeHW+Ott2mX49zLKhWVxXRmZBXjA==
X-Received: by 2002:a5d:4a42:: with SMTP id v2mr10556903wrs.333.1586187096521; 
 Mon, 06 Apr 2020 08:31:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j31sm20063766wre.36.2020.04.06.08.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 08:31:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FCF51FF7E;
 Mon,  6 Apr 2020 16:31:33 +0100 (BST)
References: <20200403172919.24621-1-philmd@redhat.com>
 <20200403172919.24621-8-philmd@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1 7/8] .travis.yml: Run fetch-acceptance-assets
 before check-acceptance
In-reply-to: <20200403172919.24621-8-philmd@redhat.com>
Date: Mon, 06 Apr 2020 16:31:33 +0100
Message-ID: <87369gbpgq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 2fd63eceaa..c6b32da447 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -317,7 +317,7 @@ jobs:
>        dist: bionic
>        env:
>          - CONFIG=3D"--enable-tools --target-list=3Daarch64-softmmu,alpha=
-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-=
softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,=
sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
> -        - TEST_CMD=3D"make check-acceptance"
> +        - TEST_CMD=3D"travis_retry make -j1 fetch-acceptance-assets
> check-acceptance DEBUG=3D1"

You could use TEST_BUILD_CMD for the fetching of acceptance tests - can
that be done in parallel?

Also no point in -j1 here - it's implied.

>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-acceptance"
>        after_script:
>          - python3 -c 'import json; r =3D json.load(open("tests/results/l=
atest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["statu=
s"] not in ("PASS", "SKIP")]' | xargs cat


--=20
Alex Benn=C3=A9e

