Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1ECC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F9DE22286
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDINmPPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F9DE22286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXPS-0003vz-Te
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIXOZ-0003GI-Hy
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:22:47 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kIXOW-0004C4-Tg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:22:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id e17so2788915wme.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FTdKJyZhaqzqiFS20GLeWOq3/b3XBWF+NtSFpOI43Yc=;
 b=QDINmPPA35tial5PZkbsE3CHirxd8L6IGNzvPvcUFSXjLDApmW5cJWIxdgJRKlytJL
 Ss/w1t6xsX2BMbd6AuAUN6PPGHw2SiF7F1Odp+FNixu1Ko7lyH/r9TGgh41XTSc5B5w+
 FaEaXHhI52kT1dQGSruFTtvztn5qsxyMcF2ujYlU3ivlDG6oVRRI/2BXs6A21G7mzDrp
 ig/q7m489zjj0w7DnoTK7vxRlzZTK8l2xzqJfZH7GCSsD7xdm1nmBsJmSlUP6GE+kdbx
 aQYhnGeqz8v97XLkQYmExLHPjqnrE1Q8QNItGAPsaXV7UUFBusENqn/0OQk+tDvMO4X1
 5WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FTdKJyZhaqzqiFS20GLeWOq3/b3XBWF+NtSFpOI43Yc=;
 b=KYuWwAsEiQWyM/dQCZnhE1DdP5+3oRmIi8XbS+OmJ+fLyK1Wjd0VXZVQbfAUXSjBIY
 GAVgSgRAWCG9sN6YWxjImBn5nPNJ0Hpcrkw3FSXStzLMB+Q0uDAvyn4iDn1MhZ8JGbaN
 K4jKSTFxHvmgu502mwSl0Ynz0s9QAR6k5NjKTMIFRrAu4fNRezUhxmLDRtRyP9kMyfK/
 94xSUkJVeoWSTJSvQghI9zz8gIjc3U+xZWq1v1ZKJQJOzjsfbep7bLQXOtqRTSdl+Ydw
 cG1KcyEWL7iKo0R6j/qXu0s47knH3oID8XhwR/y/kWz58trp/954br5cPd5RAeKXgGwW
 sQBQ==
X-Gm-Message-State: AOAM530x3Ovmqb60uTmyC6tCQpCpvcUSNs3kTFIxG17Rw18IYqia2XXz
 HPjl8+ToCGSx2MoOGBdhB1alUA==
X-Google-Smtp-Source: ABdhPJwxDth1xXnI5Z6c72AmA34OMtA98s7dds2V4IuCofKIKjY/qiHPunLXnoKFzLBuCZfJtPRSmQ==
X-Received: by 2002:a1c:6254:: with SMTP id w81mr4621840wmb.94.1600262563184; 
 Wed, 16 Sep 2020 06:22:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d23sm5172353wmb.6.2020.09.16.06.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 06:22:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 550E01FF7E;
 Wed, 16 Sep 2020 14:22:41 +0100 (BST)
References: <20200805185403.15227-1-thuth@redhat.com>
 <c1927c74-da26-a17d-e92e-1e052540733f@redhat.com>
 <dcf9c72a-069a-d853-594c-64a3a9187358@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] travis.yml: Drop the default softmmu builds
In-reply-to: <dcf9c72a-069a-d853-594c-64a3a9187358@redhat.com>
Date: Wed, 16 Sep 2020 14:22:41 +0100
Message-ID: <87lfh9zwim.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 05/09/2020 14.15, Thomas Huth wrote:
>> On 05/08/2020 20.54, Thomas Huth wrote:
>>> The total runtime of all Travis jobs is very long and we are testing
>>> all softmmu targets in the gitlab-CI already - so we can speed up the
>>> Travis testing a little bit by not testing the softmmu targets here
>>> anymore.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  Well, ok, we do not test all the softmmu targets on gitlab-CI with
>>>  that same ancient version of Ubuntu ... but do we still care about
>>>  testing all softmmut targets on Ubuntu Xenial at all? ... at least
>>>  according to our support policy, we do not care about Xenial anymore.
>>>
>>>  .travis.yml | 14 --------------
>>>  1 file changed, 14 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6695c0620f..18290bc51d 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -123,20 +123,6 @@ jobs:
>>>          - CONFIG=3D"--disable-system --static"
>>>          - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>>=20=20
>>> -
>>> -    # we split the system builds as it takes a while to build them all
>>> -    - name: "GCC (main-softmmu)"
>>> -      env:
>>> -        - CONFIG=3D"--disable-user --target-list=3D${MAIN_SOFTMMU_TARG=
ETS}"
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> -
>>> -
>>> -    - name: "GCC (other-softmmu)"
>>> -      env:
>>> -       - CONFIG=3D"--disable-user --target-list-exclude=3D${MAIN_SOFTM=
MU_TARGETS}"
>>> -        - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> -
>>> -
>>>      # Just build tools and run minimal unit and softfloat checks
>>>      - name: "GCC check-softfloat (user)"
>>>        env:
>>>
>>=20
>> Ping?
>
> Ping^2 ... Alex, Philippe, any opinions on this patch?

I'm agnostic on this. Is it worth slightly reducing our coverage for ~50
minutes of runtime out of 10 hours? I guess it would be a bit greener.

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

