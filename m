Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4916FC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 19:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E5A2206C2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 19:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OeWVxrUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5A2206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHYLS-00037E-46
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 15:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iHYJo-0001jO-Iy
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 15:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iHYJm-0000hJ-SH
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 15:05:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iHYJm-0000fd-LN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 15:05:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id j18so15789067wrq.10
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ImwCl+sAKa7K84ezFkWNL03Z+17AeiQXxz6dwHWgE1o=;
 b=OeWVxrUQDUIqewJW4Yi8RIKTUjbMJ7iKVlf8eB3f8Mk6USXcAU60d0cst3UAzmjM5w
 1hKzGxA1VZLk6rNKEjpoHAO/txAmop3SCQIV/TBJ8GIQMzeIEFA+HI2otafb1RoaxMmW
 9Y6sNekdXCS2H6OH6RCBHWJ+JqeJq8POz67E0yyGUeV+g3AY9ZDDIERPIIDE5nQO1pTq
 tqrvI9WrW6p/tzzej3yCiGhtxQmM/D9sTId1wpOpoSPZ4Y+UEY5AU2tx2GCiRojpj4R9
 kki1szhBqL0O3AwxPOziq3jZ2V081Hu0uSRVhrbP/1B0Ty2fYG6Kkt1hLKyQz1WeasDb
 S7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ImwCl+sAKa7K84ezFkWNL03Z+17AeiQXxz6dwHWgE1o=;
 b=TlkTb9yRiBY4pcE42MUE7MtEpY91fsOjFgQfJbuRUrxWC/g+dTtPy/rfdMMcwLS6vu
 j3eS0vfwKzzkCTJGM3QS1pMjxDPqjutx5wzaeO9yd68/cmQVWaY2Mhc6lNoKFy6JH+af
 4F2oLYW1E82qpg/O1pHZhhRFK583VF3XHoBAfuiV3Wy7RHRq74H6SFk4+GVm5XGtwwJX
 hOAnzyChD7HxMWwYkC+3YCNf/J2L/FkhfZK/uzr25QbO07dNMcJFhbuKxUj+6ETOohrp
 3P+3OqripwRhpmIaqALzAzwifVTFqXMHwCElO9wIc1zcdSQWGMwOwg4WT/dfdXAHtZZm
 OtQA==
X-Gm-Message-State: APjAAAWExdW6RFtPUr6JRMLhAO/FaMBDmHxcmLriK6iLU/EOXeOpIJhZ
 Z5IDnYOXN8FvcDHOVzLNmLB2pQ==
X-Google-Smtp-Source: APXvYqz8DXFwUVULMuWioGMPwIidTa7aqBOHkU/jMSvVXS8Q/I1cc7v6npZfTLqMyHK2UeD5OjM5pQ==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr18960591wrw.142.1570475111794; 
 Mon, 07 Oct 2019 12:05:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h63sm882208wmf.15.2019.10.07.12.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 12:05:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5044C1FF87;
 Mon,  7 Oct 2019 20:05:10 +0100 (BST)
References: <20191007160708.26208-1-alex.bennee@linaro.org>
 <CAFEAcA940hceuNdjNDBuJugrz64=7TQK78dR+KfYaR3xuhYf8w@mail.gmail.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] .travis.yml: reduce scope of the --enable-debug build
In-reply-to: <CAFEAcA940hceuNdjNDBuJugrz64=7TQK78dR+KfYaR3xuhYf8w@mail.gmail.com>
Date: Mon, 07 Oct 2019 20:05:10 +0100
Message-ID: <877e5gjs0p.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 7 Oct 2019 at 17:22, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Adding debug makes things run a bit slower so lets not hammer all the
>> targets.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .travis.yml | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index d0b9e099b9..fc0888aff5 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -124,12 +124,13 @@ matrix:
>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>
>>
>> +    # --enable-debug implies --enable-debug-tcg, also runs quite a bit =
slower
>>      - env:
>> -        - CONFIG=3D"--enable-debug --enable-debug-tcg --disable-user"
>> +        - CONFIG=3D"--enable-debug --enable-debug-tcg --target-list=3D$=
{MAIN_SOFTMMU_TARGETS}"
>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-debug"
>
> If (as noted in the comment) --enable-debug implies
> --enable-debug-tcg, why do we need to give both options ?

We don't really - I was just being verbose. I'll drop it.

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

