Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81156C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BFA7207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mByEehCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFA7207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionXG-00066S-Jr
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iomuT-0004zZ-Bu
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iomuS-0004Cx-3b
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:20:29 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40672)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iomuR-0004Cg-Ru
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:20:28 -0500
Received: by mail-wr1-x443.google.com with SMTP id c14so53482148wrn.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=cj6ih4qNT21L7KAnf2LL/p1j/CBLhVpFVqoiEaAETX8=;
 b=mByEehCMMpsBWGyr7kMtj8DIvs/V2XX3LGVbw7p1pTkQv+G8GdO7E0sLHv7q91VfDy
 pGeUVnjkhdrN4gXNRHs9V3AaBhz3cO4b+HcuV4P5Uqn8+knxBrJ1F0RRyyyhmkv8/BwH
 OikZ65ei6mI0l/GJZJRDq/lJJv7EXfAIq4eVgvjMPph2D7M2GwqeG5dKKz6Yo4TngJR7
 ffuZgYBBah+FCkx1ZtecNMhwGZBR7DYJ4Ku1oNaiH+O/UTe6cek4HRfupir7FwD1LHAO
 yrgvTojJQu2ZxkLLhWHFDunWsTF+Cgs3WSgtvSkCCCLHWKvbrfDLbjm4HWxFM3RSQyvA
 s5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=cj6ih4qNT21L7KAnf2LL/p1j/CBLhVpFVqoiEaAETX8=;
 b=F0CxAoCiHZ0Vrz0iPiXVjaX050FbCC7AuIvpGzYGrx9sQ3Dt5X5y1xW8487Q8JemeR
 MCaZo8dO62ZjocGLkVtuV2EMeMvCQiPI0AiXce1JdWPEFZEYsNRVt2iFMkohjl2pmZ/b
 7ruI1k2j/mRmxEWVpzTPhZCl4+d0neT0d61c4o3kTBbPx8opUZIGk3fIe8ihaHr6HNs7
 R9wXm8Hb+8skBC9ZwnVEU2iicjdj6nThrbnEpynpgHX3uwsuyS/wXoL0M1coJAHveCjk
 6uty5C0OD7RshMVFFmYF5ot5YoSmmcN5dIlkkKuMZg7657Lhd+tgWd23JY+Vavz3b8cY
 UGHg==
X-Gm-Message-State: APjAAAWkaypwJSpE8RjdFmvbn1fOkQR2aHJECHrDRIrhnYVcTIyjqire
 ycPKvPSID7y1lMSXnxEXvzXsmg==
X-Google-Smtp-Source: APXvYqzuWqJiGZtDqn1W3a9bvnefbOn1Im3VIDQrfOyTNmYBi/fnbIKUEi0GLbLTpPI80Ty+v0CccA==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr115725692wrv.9.1578396026215; 
 Tue, 07 Jan 2020 03:20:26 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t125sm26901038wmf.17.2020.01.07.03.20.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 03:20:24 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 22ACF1FF87;
 Tue,  7 Jan 2020 11:20:24 +0000 (GMT)
References: <20191230184327.2800-1-wainersm@redhat.com>
 <20191230184327.2800-2-wainersm@redhat.com>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 1/2] travis.yml: avocado: Print logs of non-pass tests only
In-reply-to: <20191230184327.2800-2-wainersm@redhat.com>
Date: Tue, 07 Jan 2020 11:20:24 +0000
Message-ID: <8736cr5x8n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: fam@euphon.net, philmd@redhat.com, qemu-devel@nongnu.org, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Wainer dos Santos Moschetta <wainersm@redhat.com> writes:

> The acceptance tests build on Travis is configured to print
> the entire Avocado's job log in case any test fail. Usually one is
> interested on failed tests only though. So this change the Travis
> configuration in order to show the log of tests which status is
> different from 'PASS' and 'SKIP' only. Note that 'CANCEL'-ed tests
> will have the log printed too because it can help to debug some
> condition on CI environment which is not being fulfilled.
>
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  .travis.yml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 376b7d6dfa..e7fdcb238c 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -262,8 +262,8 @@ matrix:
>      - env:
>          - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-soft=
mmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>          - TEST_CMD=3D"make check-acceptance"
> -      after_failure:
> -        - cat tests/results/latest/job.log
> +      after_script:
> +        - python3 -c 'import json; r =3D
> json.load(open("tests/results/latest/results.json"));
> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
> ("PASS", "SKIP")]' | xargs cat

Shame there is no scriptlet for this sort of thing packaged with
avocado. Anyway I'll give it a spin and see if any failures come up.


>        addons:
>          apt:
>            packages:


--=20
Alex Benn=C3=A9e

