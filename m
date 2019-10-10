Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA660C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8575220673
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 10:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbqOadE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8575220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIW5m-00081a-O2
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 06:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iIW4m-0007Xu-TG
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:53:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iIW4l-0004MD-GH
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:53:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37685)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iIW4l-0004Kh-8W
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 06:53:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id p14so7299862wro.4
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=f32hVp3FSibrA2UkcrKJBmex16vIbZTq6dXv/Rztk4k=;
 b=AbqOadE6DUYeox39s/KQNeElzQBcBEPjQdl3vxgpskhwIXvz3IWWPUWZj6SO8DlXGr
 nTx5zATwuGEnbZC92j9MU6MaY/ifU8kMiW1EbtzGhjpsVT6FSe2TMswVB53Fh8gATVKP
 6FXTWU4g/pbzjLcanZfO7o6nHFW/eoqciqOjxr6gTWiLWYTEJjBEWhjpeF6Js7tCpZJ4
 ZjZDBGGOurXos9pss9sE1YSohMEf6325Y9dCUECBFl3jCbdvDfWkaiZBlBOfMO2Mg48q
 jqgEhCNJucm7Lmo7+KDygIvFz/7hdRyl5AC0o4jlhFMriucdv4fXlJc4smqPdtZMAtJQ
 U/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=f32hVp3FSibrA2UkcrKJBmex16vIbZTq6dXv/Rztk4k=;
 b=p0CTDbZmRqzsPJWouWGEKhACXn1C6OaUL/VGZ+iE3GDFB7tPVgA5bSQd5smJoGSBB4
 c5RV282vM2SB/6DX2dfxRbcWpFgsHR7FvHKiGz3s1wA7kr5f/q9t0JgC/1giAzKl+6tc
 yBQDzpXKCG51D/xjpG3E4idLKseTm62K4jstHcEqfEKgUoaUdjqdQgfz5wa+rie+LOLo
 xg1m3TcGlMC1kEa0lYSY9GWY9xWIFW9v/2kApXgA33WGZktUPrAaF1E4WfpIqLWwHxQz
 cNsa1s6cpKl7sh+icPAxAjKSW3ok9zMu3exUXllyzL2Fv7UPhBmijNCfS3yUDmUn0BVY
 2kRA==
X-Gm-Message-State: APjAAAW8poGzEp0Pj+KC/sTtj5oXANdLAgSkW987730GCvopQCkoE8ks
 zbQwM0obtjq5+zEbvqLkgavVSQ==
X-Google-Smtp-Source: APXvYqxTL9rP6iL89kdAFuyl23hFv4jjm6k3KLZQUKWWXXfmKSyp5icr6u4/Cq+dc9FpTv0RoVHXlQ==
X-Received: by 2002:a5d:53c2:: with SMTP id a2mr7956947wrw.10.1570704821543;
 Thu, 10 Oct 2019 03:53:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a2sm5425199wrp.11.2019.10.10.03.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2019 03:53:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2B2611FF87;
 Thu, 10 Oct 2019 11:53:40 +0100 (BST)
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-6-thuth@redhat.com>
 <2238ed71-5811-c98f-03c8-f8804e480f9d@redhat.com>
 <ce024ffd-1b7f-39e0-b754-dc98a2a7513c@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/5] travis.yml: Compile on arm64, too
In-reply-to: <ce024ffd-1b7f-39e0-b754-dc98a2a7513c@redhat.com>
Date: Thu, 10 Oct 2019 11:53:40 +0100
Message-ID: <8736g0na6j.fsf@linaro.org>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 09/10/2019 21.06, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 10/9/19 7:07 PM, Thomas Huth wrote:
>>> Travis now features an arm64 build host, so let's check compilation
>>> there, too.
>>>
>>> Unfortunately, there are some quirks:
>>> - block/ssh.c does not compile properly in this environment, so we have
>>>    to use --disable-libssh until that problem is fixed.
>>> - test-util-filemonitor fails, so we can not run the unit tests there
>>> - The file system size seems to be very limited, so the iotest tests
>>>    can't be used and the hd-geo-test fails (thus we can't compile
>>>    x86_64-softmmu here and run "check-qtest" afterwards)
>>> - Compiling seems to be quite a bit slower than on the x86 builders,
>>>    so we better limit the target list to some few architectures.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   .travis.yml | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 0c88e8757b..357ca02890 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -342,3 +342,9 @@ matrix:
>>>           -
>>> CONFIG=3D"--target-list=3Dxtensa-softmmu,arm-softmmu,aarch64-softmmu,al=
pha-softmmu"
>>>
>>>           - TEST_CMD=3D"make -j3 check-tcg V=3D1"
>>>           - CACHE_NAME=3D"${TRAVIS_BRANCH}-linux-gcc-default"
>>> +
>>> +    # Non-x86 builds:
>>> +    - env:
>>> +        - CONFIG=3D"--disable-libssh
>>> --target-list=3Daarch64-softmmu,ppc64-softmmu,s390x-softmmu,x86_64-linu=
x-user"
>>>
>>
>> Is aarch64 on aarch64 interesting?
>>
>> Do you know if we can use KVM there?
>
> I don't think that KVM is usable there, but at least this should give us
> some compile coverage for target/arm/kvm.c which we don't get
> otherwise.

We get compile coverage for !x86 kvm from the cross compilers on
shippable. I'm more interested in running tests on !x86.

>
>  Thomas


--
Alex Benn=C3=A9e

