Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5D9C2D0DB
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9076420716
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7wtN1Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9076420716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivQL9-0007e6-Qt
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 13:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQKI-00072G-0y
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQKG-0001ee-Mb
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 13:38:33 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52605)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ivQKB-0001b5-Ly; Sat, 25 Jan 2020 13:38:27 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so2661387wmc.2;
 Sat, 25 Jan 2020 10:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8GIFXBe0JSd/fyILjKjL55XGjg+TuGX/sPNd+9vQIgI=;
 b=i7wtN1EcP412gXG3IKHkWZFji/yK1v0HjTL1gWvfOWTmEJAKAsdELZRJ9Qs3V180ke
 uK7yvaFfJ+K9p4Z1Y6IpCUdNiqh1/e1aXyPk+QA2sYcMHex4aN7c4bZZw1pSLMmy0BA1
 D0HzDy02iDDMjBg6PUZNdlI6GMOjYyHbg5DyWARAmvc8iOW205nYZhSIV3fipt6wEjBQ
 1uQs1Ux2IHo1p0qWiaPPKG3KECWssOkw7qU1Bt/GuHTJSHkrfgptdQelfbLHE0P1DdE5
 R/YJ4crxL7Hzv9gpnVKaAHk3PiWF9LBNFmN3yr19u7xobtCOCqKh79ujw6WcwsBd2mUK
 MEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=8GIFXBe0JSd/fyILjKjL55XGjg+TuGX/sPNd+9vQIgI=;
 b=Lqy0aXLdZFngxBgZ3viRbXXxRuLigGQFqemYS+6QWUegZQXXFsUIXdNG4m5ycvnmQ8
 bAONh9LZy+7ogtCZ9hc8ZRe5wcDcQWQBhBLyEXb5KIG6rMLjtELJKuHAJ56NGIdKYElF
 MFZEVbGzNirNj7DvQLEqaGJzGS1z6i9Q8EZ+1xuAELk4wUNeoHtulV7J0VFnYtNa8ITm
 Hji+8HC/4ptBDqJAkVJOUyhImfAv+ugdZgSlacGbwg2NmVda66p/rv6e5WJdaQMSN+3y
 4zuNKDQJ/6Kmp/sB/VqvBj+DfHlW5g7akuAGra4vxLb233rkDOOr2KX7S9mGPdB+TzFS
 jpDQ==
X-Gm-Message-State: APjAAAX2gLkeyMzzjm5grTxjJii9unkwHlx+I1TGz64MNZwJDumrrfWJ
 +7Pobk0wa2CLXIARSCqzRLI=
X-Google-Smtp-Source: APXvYqw34vGwbDFx+Rh/8c6pIf5WfyKfaP8vaENi9d7xJ/3o3CKAdtsiiDnxGRfLYVVrx/ELD5Zang==
X-Received: by 2002:a1c:ddd6:: with SMTP id u205mr4860000wmg.151.1579977506480; 
 Sat, 25 Jan 2020 10:38:26 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm12970419wre.13.2020.01.25.10.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2020 10:38:25 -0800 (PST)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for some of the QEMU
 advent calendar images
To: Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200124170325.30072-1-thuth@redhat.com>
 <8f085a1a-b9df-29d4-db51-eb345a44a971@redhat.com>
 <1f564925-2ee1-ab17-a946-f9bcd656926f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <4d5fe645-0652-893f-4e6b-2929849d3cdc@amsat.org>
Date: Sat, 25 Jan 2020 19:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1f564925-2ee1-ab17-a946-f9bcd656926f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/25/20 5:43 PM, Thomas Huth wrote:
> On 24/01/2020 22.28, Wainer dos Santos Moschetta wrote:
>>
>> On 1/24/20 3:03 PM, Thomas Huth wrote:
>>> The 2018 edition of the QEMU advent calendar 2018 featured Linux images
>>> for various non-x86 machines. We can use them for a boot tests in our
>>> acceptance test suite.

Excellent idea!

>>>
>>> Let's also make sure that we build the corresponding machines in Travis,
>>> and while we're there, drop the superfluous --python parameter (python3
>>> is now the only supported version anyway).

I'd rather see this change as another commit.

>>
>> Yes, please, removal of --python was in my wish list.
>>
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   .travis.yml                            |  2 +-
>>>   tests/acceptance/boot_linux_console.py | 96 ++++++++++++++++++++++++++
>>>   2 files changed, 97 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6c1038a0f1..73ca12c921 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -268,7 +268,7 @@ matrix:
>>>         # Acceptance (Functional) tests
>>>       - env:
>>> -        - CONFIG="--python=/usr/bin/python3
>>> --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
>>>
>>> +        -
>>> CONFIG="--target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
>>>
>>
>>
>> Perhaps use MAIN_SOFTMMU_TARGETS in only append the other targets, like:
>>
>> --target-list=${MAIN_SOFTMMU_TARGETS},alpha-softmmu,sparc-softmmu,....
> 
> Not sure ... while it is a nice way to shorten the line here, it adds a
> dependecy to that variable ... and MAIN_SOFTMMU_TARGETS has been changed
> a couple of times during the course of time, so we might risk to lose
> some testing coverage here in case someone removes a target from
> MAIN_SOFTMMU_TARGETS but forgets to add it here again...? I think we
> should better use the explicit list here instead.

Maybe related: "Split enterprise vs. hobbyist acceptance test job"
https://www.mail-archive.com/qemu-devel@nongnu.org/msg644683.html

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

