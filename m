Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CB2C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:28:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 352BF2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 10:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7PCUVsl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352BF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic5PZ-0003PZ-C2
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 05:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ic5IG-0000dK-0Y
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ic5He-00037S-Br
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:19:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36773)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ic5Hb-0002Y3-1m
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 05:19:54 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so2820483wma.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pvtsfTLnYuplq6zcnzslrl1WWhDsLwtscZZKhaf3T3U=;
 b=z7PCUVslzyb5iYeB1wDix1epp8pNqN4XwfMq1DcMqJJTUyvLLU9xB/A1Xv/mSkzrKu
 anFsN3pW6GIwU4ydtfT3o1z3jUDa78trHPmqrmrL09mPsEIrLP6FDzxLJUXIcDA4PVNP
 FbhEDgUpa+Au3VTW5ueFEhxH5HofATLDuz51EEjwdDJWoT9rhFz1cX74kFze3FD06LNN
 0m3gGHMnpEWb5dkFWXPH8uNftpMiY1mAJZtt0gV6jzpeKrnljVz3N+/Ku9Q+6ZJSG28N
 We8rLkAmgH+4XuEmPQPJUOmaZvVYn6iKpjeYhZGXtVBPyKa39gEQ2EtX496v8AIkE0TL
 HKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pvtsfTLnYuplq6zcnzslrl1WWhDsLwtscZZKhaf3T3U=;
 b=FSj1sn59+/JqLJcFEqTWe7zKlvOt9NEOlplC8BHKe9ayGgq6vX5Z7io8Yxn+WJ9/bA
 H/1KeNcdawB+R410eA13sedhOAygQt7xJwkJJ+TJY/lKDXfjZB83B/oy5cs4H2ihZgOa
 H5Xb+YoGzdY0ght7MCyyQYLIp/1aZ3gFfayc4U/W/tIO9DGjMObgMc2HdfHn8JX6LDPy
 yZZnOyqwW0rNx5eHC9KFu529/jLW7BfZsMLApyYlLMWvWuHK6t3nrZCab1xUe6S4m4fx
 JHb1YEYV7F8qHznOKk8ajL9pQ3lqTx0EFyRNhWaPEibI2LE0HUcBIuVXPtbFeDLXy48E
 8pAQ==
X-Gm-Message-State: APjAAAXZupQh7PryjSE0kzAXuxAcLyJHipnE6xxYF2Pm1s04SELdUcMv
 A8nIBluhwnYHoAuK9kx5Y3Idx4+DsKw=
X-Google-Smtp-Source: APXvYqyV9CRN+xv2KstCrUB0DAWR1NqtF1BoRWJn72YxugDHPaMN7leoukCVRS3R76aX/qQHUIM5HQ==
X-Received: by 2002:a1c:7306:: with SMTP id d6mr13347621wmb.164.1575368383249; 
 Tue, 03 Dec 2019 02:19:43 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm2838576wrr.95.2019.12.03.02.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 02:19:41 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23A011FF87;
 Tue,  3 Dec 2019 10:19:41 +0000 (GMT)
References: <20191128153525.2646-1-thuth@redhat.com>
 <20191128153525.2646-3-thuth@redhat.com>
 <672f7c1a-71d6-5dfa-101a-ed3070be0b05@weilnetz.de>
 <81dcaadd-8941-a192-bb15-5791f0d8e17b@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 2/2] travis.yml: Run tcg tests with tci
In-reply-to: <81dcaadd-8941-a192-bb15-5791f0d8e17b@redhat.com>
Date: Tue, 03 Dec 2019 10:19:41 +0000
Message-ID: <87lfrtbtj6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Stefan Weil <sw@weilnetz.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 28/11/2019 22.06, Stefan Weil wrote:
>> Am 28.11.19 um 16:35 schrieb Thomas Huth:
>>=20
>>> So far we only have compile coverage for tci. But since commit
>>> 2f160e0f9797c7522bfd0d09218d0c9340a5137c ("tci: Add implementation
>>> for INDEX_op_ld16u_i64") has been included now, we can also run the
>>> "tcg" and "qtest" tests with tci, so let's enable them in Travis now.
>>> Since we don't gain much additional test coverage by compiling all
>>> targets, and TCI is broken e.g. with the Sparc targets, we also limit
>>=20
>>=20
>> As far as I know it is broken with Sparc hosts (not Sparc targets).
>
> It was definitely hanging with sparc64-softmmu:
>
>  https://travis-ci.com/huth/qemu/jobs/261335163
>
> ... but since you've mentioned that it should work with the 32-bit
> sparc-softmmu, I'll give it another try with sparc-softmmu.
>
>>> the target list to a reasonable subset now (which should still get
>>> us test coverage by tests/boot-serial-test for example).
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  .travis.yml | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index c09b6a0014..de7559e777 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -215,10 +215,11 @@ matrix:
>>>          - TEST_CMD=3D""
>>>=20=20
>>>=20=20
>>> -    # We manually include builds which we disable "make check" for
>>> +    # Check the TCG interpreter (TCI)
>>>      - env:
>>> -        - CONFIG=3D"--enable-debug --enable-tcg-interpreter"
>>> -        - TEST_CMD=3D""
>>> +        - CONFIG=3D"--enable-debug --enable-tcg-interpreter --disable-=
containers
>>=20
>>=20
>> You could also --disable-kvm. It should not be needed, and disabling it
>> might need less build resources.
>
> Good idea. KVM is not usable by default in Travis, so we should not
> accidentally use it for the tests that specify "accel=3Dkvm:tcg", but in
> case that changes with a future version of the environment, we should
> maybe be prepared.

Makes sense, I'll wait for v3 before applying to me tree.

>
>>> +            --target-list=3Dalpha-softmmu,arm-softmmu,hppa-softmmu,m68=
k-softmmu,microblaze-softmmu,moxie-softmmu,ppc-softmmu,s390x-softmmu,x86_64=
-softmmu"
>>> +        - TEST_CMD=3D"make check-qtest check-tcg V=3D1"
>>>=20=20
>>>=20=20
>>>      # We don't need to exercise every backend with every front-end
>>=20
>>=20
>> Thank you for adding these tests.
>>=20
>> Tested-by: Stefan Weil <sw@weilnetz.de>
>
>  Thanks,
>   Thomas


--=20
Alex Benn=C3=A9e

