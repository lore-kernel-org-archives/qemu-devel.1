Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3079C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:20:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C099121774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 10:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="trsaXujV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C099121774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaGu4-0001mt-Ua
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 05:20:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iaGqf-0000Dt-AX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iaGqY-0000N7-RQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:16:28 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39976)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iaGqY-00009E-KX
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 05:16:26 -0500
Received: by mail-wr1-x442.google.com with SMTP id c14so5765552wrn.7
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 02:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=8vCTa+jUSaiEbt1D3xGTFaEigM1vkzO8O6xiB+JXHrQ=;
 b=trsaXujVuRSPd+9foF84aQXj7LFVGR/0uAYECS8ZUwBt0Fry9bdKl1lpEIAxRVJxTn
 WYZi68AccEs1x/H7QOTk3CYPjzBFm9VJeKaMz7zO9OgX5at4uWmiTwWMezWKx91MVmnT
 ewe9v1yGhKMcASFYc+qDxH46McHAgeLuE+QNzsPztpm5BddrUVzIro+vlzYeRJ4E+cy3
 q1QyXpZR9sJbycCTcllqe0k+joaRgMt8KfaZZz0vAuvNhTlwFvaH//R80rqyuRfOg/Ye
 14b1F31WkpvG+x7dj3B351gAXYaqJaJ4tdjLvd1ns3+hNOSVu/+W/jI0e16gefBjtlFA
 EjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=8vCTa+jUSaiEbt1D3xGTFaEigM1vkzO8O6xiB+JXHrQ=;
 b=o+B6Sf9M6+s6b1EX/v9AADLccsLD0KZbqiUQ23B2+HU6QfmUinNHBb0rT68Gbhx8dV
 Vz16avJQ7Xiy2hcJLfBXYXuKGBEX32cI7SXc6Ee6Y8ljhbq3I8FQFVJcgJwqaezSzYN3
 gy9hdykMQdl6PBXwyLlaLM+d9bAoc0puy4oLc8pBA8AbKvIzgs5QGGoO+fKmngqLn1pP
 v5wf/toktd8DE2wyn5nRrnJ83szb+1r92kcBf4CtxSeQ5cHXWjkKsnqlz9yr+ePCul0H
 NS9t88vsYHuDJQk31wa8O1AldwwwDKSAfRS4MaI9EDsY4G+PcwoKWqnfVbVJr0Wtadkn
 PW9Q==
X-Gm-Message-State: APjAAAVG+zJ/a9rOtRoCb/XCdMEb+DUr41qEqzcLq8x0LvKUUTifADUy
 el6f/zB17Re577sGfQz1s9xjELm2iYo=
X-Google-Smtp-Source: APXvYqyHcuoh3rWD1MQKgyalHjRilAk5vQwqKuPeW9QASuCLx/ZxHaUtRlHnl2Ok2BuZgADsRp9vRw==
X-Received: by 2002:adf:ab4c:: with SMTP id r12mr46374335wrc.3.1574936182562; 
 Thu, 28 Nov 2019 02:16:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m16sm9905410wml.47.2019.11.28.02.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 02:16:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 780001FF87;
 Thu, 28 Nov 2019 10:16:20 +0000 (GMT)
References: <20191127154857.3590-1-thuth@redhat.com>
 <87zhghf9lg.fsf@linaro.org>
 <02c92ddf-e65a-2d2d-40fa-027aa4e4c558@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Run tcg tests with tci
In-reply-to: <02c92ddf-e65a-2d2d-40fa-027aa4e4c558@redhat.com>
Date: Thu, 28 Nov 2019 10:16:20 +0000
Message-ID: <87r21sfgqz.fsf@linaro.org>
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
Cc: qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 27/11/2019 19.38, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> So far we only have compile coverage for tci. But since commit
>>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>>> for INDEX_op_ld16u_i64") has been included, we can also run the
>>> x86 TCG tests with tci, so let's enable them in Travis now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   .travis.yml | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index c09b6a0014..b0b634d484 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -218,7 +218,7 @@ matrix:
>>>       # We manually include builds which we disable "make check" for
>> this comment is out of date now (or rather has been for a while)
>>=20
>>>       - env:
>>>           - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
>> Perhaps as linux-user doesn't add much to testing the TCG we could
>> limit
>> by MAIN_SOFTMMU_TARGETS here?
>
> Limiting is a good idea, but I think we should use the architectures
> that are supported by tests/boot-serial-test.c instead.

Maybe a new env - TESTBOOT_SOFTMMU_TARGETS?

>
>>> -        - TEST_CMD=3D""
>>> +        - TEST_CMD=3D"make run-tcg-tests-x86_64-softmmu V=3D1"
>> How about "make check-qtest check-tcg"
>> > Which will exercise the moderate boot code tests of various
>> architectures as well as x86_64 (if we include the --disable-docker
>> configure stanza)
>
> I tried "check-tcg" before switching to
> "run-tcg-tests-x86_64-softmmu", but "check-tcg" then resulted in a
> docker error:
>
>  https://travis-ci.com/huth/qemu/jobs/260949876#L11974
>
> ... so looks like we indeed have to use --disable-docker in that case.
>
> I'll have a try and send a v2 if that works out fine.
>
>  Thomas


--=20
Alex Benn=C3=A9e

