Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67998C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CA22080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JHVRiXIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CA22080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycrZ-0000V1-F1
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iycqy-0008TW-N7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iycqx-0003m0-O4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:37:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iycqx-0003lN-I3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:37:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id a6so18444746wrx.12
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mwIRasez9hCiSvnmviaUwI1WpgIorlmt2wVR/XzX058=;
 b=JHVRiXIteI2anpwjmdf6RGRgXoptyox9fXhL+pgdHOZ3b98f+Yg76neDZT8mk3vckO
 w4VVk3Pq6iD77zJgfAmb+khVxJkS7kil1kpf4m5n98AQeh4TNCdfmDWC/wIxW8ghRidU
 J2FfyIYLexmJuyUZKEiM2rzt3sYuebmCd6JCg/15VPdJ0Q2n2mpms+3c2CTwZf2sBpXz
 FsInZZ0fAJDpyJHicNCpNHwcTJHhFKEwpMxJitJNvNgIY64aVCNs4Ox2rPmZpy5Qr2x7
 Is8cHt+hPfzOxqqIiUqP4ens0ksZes3KIEQbwNGhpPwTrd2r3QmyJC+DPlG237O+Yexf
 x+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mwIRasez9hCiSvnmviaUwI1WpgIorlmt2wVR/XzX058=;
 b=P0dI8zu2KOYZM6Ajbq/FmzqD482qS/dO7NUTCK3w5OdXF1MBxpUMrpLnDEt0E1VSkN
 HfxL7ukT9EqpAbK9WiCz1REyz6R0wM0RmCeM6lif9AL4S8FMdgC36/2+7U8FWNSPdWdC
 8HAvhZR8kmqf9YOCHumsDTgoC7vDR4CVlYCfDG4sHoUc6dGSLoR1KdoZlmfE9YsGRdmz
 PC7z4SAzLNmQv6kYRRE8H+05hwExurNOl2ZAGpmcofiLUZ+VYBZK+UN6SUIsgLWmQDyM
 /Ggt9xGzNoxLqJjcU8hkLO3VSheDnUVMItRulB4Gf/sh0L35Dqa39a1dv1HvtH+8JG3O
 G02A==
X-Gm-Message-State: APjAAAV7QKDfsP1RsFVdgfrfbtqFGtMO8+fWmryveKvlrlYvZLfEFrz4
 iKjPIM6/BXs9iJSWOfEojEaPlQ==
X-Google-Smtp-Source: APXvYqxIeJMOx1bI9Xac6S960AZWW66SozOIEG6yx7LiGfkhRFsc5WnQORYL13pn9DX07ni7XWhh8A==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr15667667wro.310.1580740650594; 
 Mon, 03 Feb 2020 06:37:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y20sm22750133wmi.25.2020.02.03.06.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:37:29 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7F68F1FF87;
 Mon,  3 Feb 2020 14:37:28 +0000 (GMT)
References: <20200203090932.19147-1-alex.bennee@linaro.org>
 <20200203090932.19147-18-alex.bennee@linaro.org>
 <e1f501e7-b3c4-5d88-3f10-cd2c1c7a1cd6@redhat.com>
 <21b86fba-8f28-736e-89d1-f7548e1f92e2@redhat.com>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 17/17] .travis.yml: single thread build-tcg
In-reply-to: <21b86fba-8f28-736e-89d1-f7548e1f92e2@redhat.com>
Date: Mon, 03 Feb 2020 14:37:28 +0000
Message-ID: <87blqfag9j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/3/20 11:01 AM, Thomas Huth wrote:
>> On 03/02/2020 10.09, Alex Benn=C3=A9e wrote:
>>> I've theorised that a parallel build-tcg is somehow getting confused
>>> when two fedora-30 based cross compilers attempt to build at the same
>>> time. From one data-point so far this may fix the problem although the
>>> plugins job runs quite close to timeout.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>   .travis.yml | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index c1c6df475a8..3b35b7cf04d 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -380,7 +380,7 @@ matrix:
>>>       - name: "GCC check-tcg (user)"
>>>         env:
>>>           - CONFIG=3D"--disable-system --enable-debug-tcg"
>>> -        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
>>> +        - TEST_BUILD_CMD=3D"make build-tcg"
>>>           - TEST_CMD=3D"make check-tcg"
>>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>>>   @@ -391,7 +391,7 @@ matrix:
>>>       - name: "GCC plugins check-tcg (user)"
>>>         env:
>>>           - CONFIG=3D"--disable-system --enable-plugins --enable-debug-=
tcg --target-list-exclude=3Dsparc64-linux-user,cris-linux-user"
>>> -        - TEST_BUILD_CMD=3D"make -j${JOBS} build-tcg"
>>> +        - TEST_BUILD_CMD=3D"make build-tcg"
>>>           - TEST_CMD=3D"make check-tcg"
>>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug-tcg"
>> Squash it into patch 14/17 ?
>
> I'd rather not, ideally we will revert this patch once the issue is
> fixed.

Yeah - there should be no reason that we can't build all the tcg tests
in parallel. For some reason I think the two fedora30 based images have
an issue, despite there not being a common base.

--=20
Alex Benn=C3=A9e

