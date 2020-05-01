Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE73C47257
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FC082166E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r8/4svVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC082166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUXH6-0005XK-LT
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 11:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUXDl-0007lo-VB
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUXBy-000632-1M
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:04:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38061)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUXBx-00062B-IO
 for qemu-devel@nongnu.org; Fri, 01 May 2020 11:03:05 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so6591495wmh.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/aNguQy6oBE0ygvZFT8zko0QK5po8ASEU5LXmZepCX0=;
 b=r8/4svVnQlPs5B37V9YBXoWxrB30J++8m+6IXooE+hTDKR1ukVEVsdFBeGZgXEYEQZ
 dzR0dgfeZdRVrhdT45/ag6Ro6IALOXiK6bUTMSCFNu1rV1ffEmg6T8+Pcp1oVsmUI/YE
 iHpc4KF8yeHXdb+PRgXRCKI471GStQmQ6muRhrMEW317wji/yt//+9DWrKWnQfbdhGxU
 j2vPMXYE0UWfT4264kdcxfU7+owq1ERNf2RY2xxpF0NNENSEdwwdXF66fuP0BK4ITXAd
 b/Nuj7nMHvQSau40q/FpreegNBPhsEIK3X+wwNiRvIHgsEn/3DBh+DMHO2wXTmpFAn39
 PdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/aNguQy6oBE0ygvZFT8zko0QK5po8ASEU5LXmZepCX0=;
 b=GGS82YvC5pBsrQSuZmbPHiDmeJEaPIrAoYZp8FeSNKnMIbHuvEHo6hkd0gKsym+CK1
 11tRxjS887fOsaze0Lon+aFwouhyBy+RVoIu3Kn3ASCgcKCnqRFCxJ8cW+ZVhpxWrWzP
 jqMtaz2gjE6r9+SkRBhrY9TNm4dPa2HNtzHj9pQIM9ESUFEzNBO3cfo+9yN9PJ0Ex5UJ
 L+yxI5mbgHRBfp1fcaU+JAmTSRTYVsUpEXsoA4TE2C6apFeYeRQJSSayKypkIEtNxF3t
 9kBMn3uXxBE9CYBzPPc4v73YSc9BSUPzVzNnsmMPpNta5Ot1C5ZvnQFjPuFrhOqnGI3S
 1IhQ==
X-Gm-Message-State: AGi0PuaInXlR8FLBxjUGVttUyaloyXwLLywO9hBLRPNPdGtTEhg5KrsB
 Cl7X2hdo/SZgNq/eIAHir1LlAw==
X-Google-Smtp-Source: APiQypIF0rQB7ImeIW3gbZHmf4g5AvDjQgjxvErRkwaZMlJECbJoUqDYklNYIeKEvFSLnuSueMj3LQ==
X-Received: by 2002:a05:600c:214b:: with SMTP id
 v11mr4698904wml.151.1588345383837; 
 Fri, 01 May 2020 08:03:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y18sm4801721wmc.45.2020.05.01.08.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 08:03:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 45C1D1FF7E;
 Fri,  1 May 2020 16:03:01 +0100 (BST)
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-3-alex.bennee@linaro.org>
 <20200501112105.GJ2203114@redhat.com>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH  v1 2/4] .travis.yml: drop MacOSX
In-reply-to: <20200501112105.GJ2203114@redhat.com>
Date: Fri, 01 May 2020 16:03:01 +0100
Message-ID: <87pnbnitp6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, May 01, 2020 at 12:15:03PM +0100, Alex Benn=C3=A9e wrote:
>> This keeps breaking on Travis so lets just fall back to the Cirrus CI
>> builds which seem to be better maintained. Fix up the comments while
>> we are doing this as we never had a windows build.
>
> FYI the current problem with macOS biulds is not a Travis problem,
> it is a Homebrew problem, fixed by this patch:
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg04234.html

I did have this in my queue but I thought we hit another problem after
that? Even your log message wasn't overly confident about timeouts hence
my desire to sack it off and leave it to Cirrus.

>
>
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 28 +---------------------------
>>  1 file changed, 1 insertion(+), 27 deletions(-)
>>=20
>> diff --git a/.travis.yml b/.travis.yml
>> index a4c3c6c805..49267b73b3 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -9,9 +9,8 @@ compiler:
>>  cache:
>>    # There is one cache per branch and compiler version.
>>    # characteristics of each job are used to identify the cache:
>> -  # - OS name (currently, linux, osx, or windows)
>> +  # - OS name (currently only linux)
>>    # - OS distribution (for Linux, xenial, trusty, or precise)
>> -  # - macOS image name (e.g., xcode7.2)
>>    # - Names and values of visible environment variables set in .travis.=
yml or Settings panel
>>    timeout: 1200
>>    ccache: true
>> @@ -271,31 +270,6 @@ jobs:
>>          - TEST_CMD=3D""
>>=20=20
>>=20=20
>> -    # MacOSX builds - cirrus.yml also tests some MacOS builds including=
 latest Xcode
>> -
>> -    - name: "OSX Xcode 10.3"
>> -      env:
>> -        - BASE_CONFIG=3D"--disable-docs --enable-tools"
>> -        - CONFIG=3D"--target-list=3Di386-softmmu,ppc-softmmu,ppc64-soft=
mmu,m68k-softmmu,x86_64-softmmu"
>> -      os: osx
>> -      osx_image: xcode10.3
>> -      compiler: clang
>> -      addons:
>> -        homebrew:
>> -          packages:
>> -            - ccache
>> -            - glib
>> -            - pixman
>> -            - gnu-sed
>> -            - python
>> -          update: true
>> -      before_script:
>> -        - brew link --overwrite python
>> -        - export PATH=3D"/usr/local/opt/ccache/libexec:$PATH"
>> -        - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>> -        - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config=
.log && exit 1; }
>> -
>> -
>>      # Python builds
>>      - name: "GCC Python 3.5 (x86_64-softmmu)"
>>        env:
>> --=20
>> 2.20.1
>>=20
>>=20
>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

