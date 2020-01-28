Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A1CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:56:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B250224683
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="texwmNdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B250224683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQPf-0006js-Ui
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iwQOa-0005Eq-LQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:55:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iwQOY-0002Cm-9a
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:55:07 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38392)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iwQOY-0002BU-21
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:55:06 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y17so15894091wrh.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 04:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=C12msp26di9mlt2OU7RT56HbtoCfCCrRoRn/lITvTvs=;
 b=texwmNdjnTSsZd9Xh9LslOZrUxLWmyaW+yoTGQ53jEUNV2OS81+g467QfBWt6xuiT1
 hYpvODX5vRPIqSp3EJQuboMPNAGojqsYRm1DI7FCf1xyLzVC4ohTM6qPbHoYfNlR6JfJ
 oxCOf0ZkXSC8EopG/BHhklto+qKkDKQnsEAif2cG/fm27h6xUyESVmS5jrNeyw1jjPlj
 k/axNZ6t2OjjUt2g5tJ4Dwz2fPp//1UuS78Y7GoTqV49SCddTm92kpy1TS9LfkIhdDp8
 jE19lJDXuL3wX+oGdNQSkX/dbZkMyFD1QSa3kgyCsL2wcUT9wf0GXLG6tuvtHyvGh5+G
 moQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=C12msp26di9mlt2OU7RT56HbtoCfCCrRoRn/lITvTvs=;
 b=CdXCr48e5dc2hDuhqtkk9T1LjUHpKr+yUvfUnNLXPY/96V+GCHgrIxBsnrJSbz7KED
 TXI/G3ca0sKvsw+LidjtJFy6V6XV1ERuA+xEzSXJH4glibTIh65tD2VCfmwoQtLptHZn
 FNDkxl2F5W/Sj4oiAUYOm/4Y6aDk5Mv5TZnuVjWECK36AIfgN1VBMCMo5YXOPUstJ2OF
 2alMNGnQGLzT6cLbPx3hq7r5OwdjKEFYmH0xYCEMGD+OClKTOS2WHZtY3qRSj4BGptJ8
 SBy+8Pu5Zno7Jfd1rvJnlmEwGMHh3DoYjFQvqNBnL3dQAd5DDGAKvnxOpTtRIoA6R0hu
 3WNQ==
X-Gm-Message-State: APjAAAWLPjVBIEZRcEWio3zvSm4/bVtwL6m4jyUanfv23BSWb8o3Ayzi
 Bf2aPpBfoR44+OBgLYOeRf4EQw==
X-Google-Smtp-Source: APXvYqwELf5Y3SdoYtfUaq3JNOqX5yAiTgYFuWhBAikzwdgk/svtbn/c11iGlIZslrPzHG4h4ZkhaA==
X-Received: by 2002:a5d:6ac5:: with SMTP id u5mr30172982wrw.271.1580216104385; 
 Tue, 28 Jan 2020 04:55:04 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w8sm3089278wmm.0.2020.01.28.04.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 04:55:03 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 600471FF87;
 Tue, 28 Jan 2020 12:55:02 +0000 (GMT)
References: <20200125183135.28317-1-f4bug@amsat.org>
 <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] .travis.yml: Add description to each job
In-reply-to: <79c2d168-498c-88eb-0857-4c3b195f7e32@redhat.com>
Date: Tue, 28 Jan 2020 12:55:02 +0000
Message-ID: <874kwfg2qh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 25/01/2020 19.31, Philippe Mathieu-Daud=C3=A9 wrote:
>> The NAME variable can be used to describe nicely a job (see [*]).
>> As we currently have 32 jobs, use it. This helps for quickly
>> finding a particular job.
>>=20
>>   before: https://travis-ci.org/qemu/qemu/builds/639887646
>>   after: https://travis-ci.org/philmd/qemu/builds/641795043
>
> Very good idea, correlating a job in the GUI to an entry in the yml file
> was really a pain, so far.
>
>> [*] https://docs.travis-ci.com/user/customizing-the-build/#naming-jobs-w=
ithin-matrices
>>=20
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>  .travis.yml | 101 ++++++++++++++++++++++++++++++++++------------------
>>  1 file changed, 67 insertions(+), 34 deletions(-)
>>=20
>> diff --git a/.travis.yml b/.travis.yml
>> index 6c1038a0f1..d68e35a2c5 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -94,24 +94,28 @@ after_script:
>>=20=20
>>  matrix:
>>    include:
>> -    - env:
>> +    - name: "[x86] GCC static (user)"
>
> Could you please drop the [x86] and other architectures from the names?
> Travis already lists the build architecture in the job status page, so
> this information is redundant.

Hmm for me the Travis page mis-renders the architecture (on firefox) so
I do find the arch in the text fairly handy.

>
> [...]
>>      # Alternate coroutines implementations are only really of interest =
to KVM users
>>      # However we can't test against KVM on Travis so we can only run un=
it tests
>> -    - env:
>> +    - name: "[x86] check-unit coroutine=3Ducontext"
>> +      env:
>>          - CONFIG=3D"--with-coroutine=3Ducontext --disable-tcg"
>>          - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>=20=20
>>=20=20
>> -    - env:
>> +    - name: "[x86] check-unit coroutine=3Dsigaltstack"
>> +      env:
>>          - CONFIG=3D"--with-coroutine=3Dsigaltstack --disable-tcg"
>>          - TEST_CMD=3D"make check-unit -j3 V=3D1"
>>
>
> Off-topic to your patch, but aren't coroutines something that is only
> used in the softmmu targets? If so, we could add --disable-user to the
> above two builds to speed things up a little bit.

I think --disable-tcg implies --disable-user as you can't run without
it.

>
>>=20=20
>>      # Check we can build docs and tools (out of tree)
>> -    - env:
>> +    - name: "[x86] tools and docs"
>> +      env:
>>          - BUILD_DIR=3D"out-of-tree/build/dir" SRC_DIR=3D"../../.."
>
> Also off-topic, but I think we can now remove the above line and fix the
> comment - since all builds are now out-of-tree anyway, see commit
> bc4486fb233573e.
>
>
>> @@ -250,7 +271,8 @@ matrix:
>>=20=20
>>=20=20
>>      # Python builds
>> -    - env:
>> +    - name: "[x86] GCC Python 3.5 (x86_64-softmmu)"
>> +      env:
>
> Off-topic again:
> Python 3.5 is the default on xenial, and since we stopped using Python
> 2.7, I think we could remove this job now.
>
> We could add some jobs with Bionic + Python 3.7 and 3.8 instead.
>
>>          - CONFIG=3D"--target-list=3Dx86_64-softmmu"
>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>        language: python
>> @@ -258,7 +280,8 @@ matrix:
>>          - "3.5"
>>=20=20
>>=20=20
>> -    - env:
>> +    - name: "[x86] GCC Python 3.6 (x86_64-softmmu)"
>> +      env:
>>          - CONFIG=3D"--target-list=3Dx86_64-softmmu"
>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>        language: python
>
>  Thomas


--=20
Alex Benn=C3=A9e

