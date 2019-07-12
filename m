Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C67C742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36745206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jeczzikg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36745206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvi3-0000aa-G2
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlvht-00006h-Vs
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlvhr-0001JA-Vt
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:35:25 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlvhq-0001CU-PV
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:35:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so10004319wrt.6
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PZjNUGnp9hE1v1OpcRP8uAuJuGodI90xg6mxgdaF+n4=;
 b=jeczzikgytkooYUH+MC4c8AbAMlOkXeg0qCYsD9ObBbyGoiCS3R5cJBWXCuPBRB91m
 YW1BVlzoflBQcd8QlG5T7otgeVrtkULryUFXprW2oBwYQw92Qj8ulIdTykgXnUQEI8yt
 wsHJ2a35r94C0/IIsjrE7q5FBk8lsWfjiTsKN5dRS4G9nyLgkawDqibNJeTynriDVg7o
 JD4ClGuG0GY6Kc4/tGrW5LyxKCz0TEST28eFiVlMDp76NsGyDWIibsPLm+xWCTX8nnkf
 GMMKDpGeBOVRPLCdTdPlIeepJiJbnmYknLG1MIGJfFLq7Toc2o6p0MQF66vczQ3JO2uQ
 y+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PZjNUGnp9hE1v1OpcRP8uAuJuGodI90xg6mxgdaF+n4=;
 b=fZHc9tRBO+p0/Ih8gFDVVmtbrRE5Maj4DyeTYsp5AYxN5wryjypZvDmE1wnQY1dIrm
 ik3ZgW8q4u7PnLhn+ET8YI5SpNHy+CsSgwFRZ6x2/Z29lyMMhwQXw3mKEpbsNkkFIISb
 eUdaYXv6WX9qK14tOp74dInd4n19OhzTYq5UuXjT6alGOJ96TbBjurlfBRd6H8bw/U7e
 FfltWGbS0uxmkCEuPTr2Cxht0lDKj1NqUAT3X5yiwZDc2p5CFsm1LJN1dhZcgrS+NobR
 rprOUHliP02kcwylMbtcD+SYxzLNyB0PO7mecGfWVuiam0vNA0WW5+qvJStB+iEyzlv+
 OAMw==
X-Gm-Message-State: APjAAAWbL2zAkf7/bsCaZ5tNqDqvsqwRG9Hllc8zrrFk4ZwftaSEmKrL
 oHkoHGjAHsP7g/zvAGxwOTQeVg==
X-Google-Smtp-Source: APXvYqzH2yUmXzrlNXh3UKSxzOaFv6shbZHss4ZcAxJjG/gnvcwADVOKlG1jaigWSyI5NHbol61amw==
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr11651141wrt.57.1562938521481; 
 Fri, 12 Jul 2019 06:35:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id j17sm4173663wrb.35.2019.07.12.06.35.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 06:35:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 949B31FF87;
 Fri, 12 Jul 2019 14:35:20 +0100 (BST)
References: <20190712111849.9006-1-alex.bennee@linaro.org>
 <20190712111849.9006-6-alex.bennee@linaro.org>
 <a8137849-8d9c-bd87-523f-f2c7cdfa013c@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Laurent Vivier <lvivier@redhat.com>
In-reply-to: <a8137849-8d9c-bd87-523f-f2c7cdfa013c@redhat.com>
Date: Fri, 12 Jul 2019 14:35:20 +0100
Message-ID: <87y313cr53.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v1 5/7] tests/migration-test: don't spam
 the logs when we fail
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
Cc: Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Laurent Vivier <lvivier@redhat.com> writes:

> On 12/07/2019 13:18, Alex Benn=C3=A9e wrote:
>> Quite often the information about which test failed is hidden by the
>> wall of repeated failures for each page. Stop outputting the error
>> after 10 bad pages and just summarise the total damage at the end.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/migration-test.c | 19 ++++++++++++-------
>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/migration-test.c b/tests/migration-test.c
>> index b6434628e1c..ce041f80c2a 100644
>> --- a/tests/migration-test.c
>> +++ b/tests/migration-test.c
>> @@ -308,7 +308,7 @@ static void check_guests_ram(QTestState *who)
>>      uint8_t first_byte;
>>      uint8_t last_byte;
>>      bool hit_edge =3D false;
>> -    bool bad =3D false;
>> +    int bad =3D 0;
>>
>>      qtest_memread(who, start_address, &first_byte, 1);
>>      last_byte =3D first_byte;
>> @@ -327,15 +327,20 @@ static void check_guests_ram(QTestState *who)
>>                  hit_edge =3D true;
>>                  last_byte =3D b;
>>              } else {
>> -                fprintf(stderr, "Memory content inconsistency at %x"
>> -                                " first_byte =3D %x last_byte =3D %x cu=
rrent =3D %x"
>> -                                " hit_edge =3D %x\n",
>> -                                address, first_byte, last_byte, b, hit_=
edge);
>> -                bad =3D true;
>> +                bad++;
>> +                if (bad <=3D 10) {
>> +                    fprintf(stderr, "Memory content inconsistency at %x"
>> +                            " first_byte =3D %x last_byte =3D %x curren=
t =3D %x"
>> +                            " hit_edge =3D %x\n",
>> +                            address, first_byte, last_byte, b, hit_edge=
);
>> +                }
>>              }
>>          }
>>      }
>> -    g_assert_false(bad);
>> +    if (bad >=3D 10) {
>> +        fprintf(stderr, "and in another %d pages", bad);
>
> "bad - 10" as you have already displayed 10 errors.

Will do.

>
> Thanks,
> Laurent


--
Alex Benn=C3=A9e

