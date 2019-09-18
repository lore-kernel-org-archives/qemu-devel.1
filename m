Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389C5C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07E29214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dtyRmTr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E29214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAY6N-0005pQ-Ue
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45443)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAY4w-0004b4-1X
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAY4u-00054O-KQ
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:24:57 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54984)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAY4t-00053l-Uh
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:24:56 -0400
Received: by mail-wm1-x343.google.com with SMTP id p7so2166738wmp.4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=QCfrlPo3gi0pRC2bFXoDJAOcIK/1t1gNeLswZkIWMhQ=;
 b=dtyRmTr8Y2ED915UJmbmJCAxO9qEu9OC/e3qISfRbRNlIMQ+Wss1CTHpU+zisAyu22
 xOfXNw3GmxtaJu+tmwcX60yxPDwfcOuQfXd+AiP9/Ar8r92mnnqQGv+UXCtcu0Ao6cup
 YeKtmrhG5XIXrc92nwVmJcKIgQK+lPDs/P1M+DLFBbOQwuT3oO7i2xz28H47WYVW6WPD
 i141QpXYsXPqNgVKj0MOONQ7qcVZWdEqMr1iScggb/3oCRWiicdunqn5p9MIUWn9CiUx
 0EHPxux6b0S1JAO5q0U5VuzdzW4psJeu4u+pymfP/ic2tFtZ0jHCOB+g7G4xTB0pAWz/
 sPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=QCfrlPo3gi0pRC2bFXoDJAOcIK/1t1gNeLswZkIWMhQ=;
 b=Fm1GmGhOBdayKrdD00L67/ouWRRyBmAhIb+I3DzzJVZ6Y2/f+HIz5k1rvD4/k1Ez2S
 Anuxhmahz7UFGLqRuOwUSlX0o7VpxL9ZkxTwJ1ZuhqoGV0c6uMr7+k8i/j+t/8GAe6RH
 xwM/i11HSdMcxf9H5O6palw3ZBh/MwXGKFjiFkq8EmWn9sjWpWpK7GgCJEZU5KxfzZwQ
 AouB+WQ7Dmvfe4PGdia4i0B8Qprp8aotQtoKakA2c1E/S5ak+q3KRJMovmnF7BzBgcdU
 LzabyzR7dMzeYo5fIlxqnEp4+gHYseiB7NyI9Zup/0bkU4jFJY6b1cV+TxGxIL2F5xsK
 +ahQ==
X-Gm-Message-State: APjAAAWoxViJU1hREzsAsY3A0kIKfdWJKfzrhPUJ6KT3kCV7NBInqXEs
 HCGK3+6vSz8kmhTlIiOhbbQb6A==
X-Google-Smtp-Source: APXvYqwjpTDIw2xNtAa/WUePs8ju8r5YhgFCf0yATtSExfD3yYYKBIe9eRJ4o2ecG+sJtjrQoHDnqA==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr2296325wmb.34.1568805894275; 
 Wed, 18 Sep 2019 04:24:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t14sm4258580wrs.6.2019.09.18.04.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 04:24:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0C541FF87;
 Wed, 18 Sep 2019 12:24:52 +0100 (BST)
References: <20190916135806.1269-1-david@redhat.com>
 <20190916135806.1269-30-david@redhat.com> <875zlq0wd4.fsf@linaro.org>
 <1f44e951-2b08-82b0-a7e7-7459b140731f@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
In-reply-to: <1f44e951-2b08-82b0-a7e7-7459b140731f@redhat.com>
Date: Wed, 18 Sep 2019 12:24:52 +0100
Message-ID: <871rwd26ez.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 29/29] tests/tcg: target/s390x: Test MVO
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Cole Robinson <crobinso@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 18.09.19 11:47, Alex Benn=C3=A9e wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
>>> Let's add the simple test based on the example from the PoP.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  tests/tcg/s390x/Makefile.target |  1 +
>>>  tests/tcg/s390x/mvo.c           | 25 +++++++++++++++++++++++++
>>>  2 files changed, 26 insertions(+)
>>>  create mode 100644 tests/tcg/s390x/mvo.c
>>>
>>> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile=
.target
>>> index 151dc075aa..6a3bfa8b29 100644
>>> --- a/tests/tcg/s390x/Makefile.target
>>> +++ b/tests/tcg/s390x/Makefile.target
>>> @@ -6,3 +6,4 @@ TESTS+=3Dipm
>>>  TESTS+=3Dexrl-trt
>>>  TESTS+=3Dexrl-trtr
>>>  TESTS+=3Dpack
>>> +TESTS+=3Dmvo
>>> diff --git a/tests/tcg/s390x/mvo.c b/tests/tcg/s390x/mvo.c
>>> new file mode 100644
>>> index 0000000000..5546fe2a97
>>> --- /dev/null
>>> +++ b/tests/tcg/s390x/mvo.c
>>> @@ -0,0 +1,25 @@
>>> +#include <stdint.h>
>>> +#include <stdio.h>
>>> +
>>> +int main(void)
>>> +{
>>> +    uint8_t dest[6] =3D {0xff, 0x77, 0x88, 0x99, 0x0c, 0xff};
>>> +    uint8_t src[5] =3D {0xee, 0x12, 0x34, 0x56, 0xee};
>>> +    uint8_t expected[6] =3D {0xff, 0x01, 0x23, 0x45, 0x6c, 0xff};
>>> +    int i;
>>> +
>>> +    asm volatile (
>>> +        "    mvo 0(4,%[dest]),0(3,%[src])\n"
>>> +        :
>>> +        : [dest] "d" (dest + 1),
>>> +          [src] "d" (src + 1)
>>> +        : "memory");
>>> +
>>> +    for (i =3D 0; i < sizeof(expected); i++) {
>>> +        if (dest[i] !=3D expected[i]) {
>>> +            fprintf(stderr, "bad data\n");
>>> +            return 1;
>>> +        }
>>> +    }
>>> +    return 0;
>>> +}
>>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> but...
>>
>> can this test be expanded to check the page cross cases that caused you
>> so much trouble to track down?
>
> I might add a MVC test that tries to reproduce this. But with
> speculative page faults and things like that it might not be very easy
> to reproduce. However, I can give it a try.

I may not be fully understanding the correct behaviour but wouldn't the
test be:

  * map two page's worth of address space
  * mprot(!write) the top page
  * attempt mvc based copy to mmap region (say p0+(PAGE_SIZE>>1) to p1+(PAG=
E_SIZE>>1))
  * catch the fault
  * check the bottom page wasn't written to

or does the test need to be lower level and run in kernel mode in
softmmu and catch the appropriate low level exceptions?

>
> Thanks!
>
>>
>> --
>> Alex Benn=C3=A9e
>>


--
Alex Benn=C3=A9e

