Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E43C5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5BD2076C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UnQF4XWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5BD2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46905 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jETgK-0000k3-BK
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 04:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51145)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jETfR-0008Gd-8X
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jETfQ-0002zv-3P
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:03:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42830)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jETfQ-0002yl-05
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 04:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584518587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GkcU0choQRMyQG0VKZNML8tlxNz+Puj7nqIpRq0lYJ0=;
 b=UnQF4XWo9NrDvvU5184eEqkG8rfa9lA7NrlfMl18dPB5tQee4GAlrar2fJNQLIvHUPmDol
 sgxy/eXvq4V5TrTtEVtZGczCVRLHL0c6OfHeTs+uEiMRNJakjEvhD9CnKYOjXBWkV3tSGa
 gjLaa5Dz9Xv1ocqDX+UC+U0+RD5ymB8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-4HMCn-T6MUG4hYkNuTxu4Q-1; Wed, 18 Mar 2020 04:03:03 -0400
X-MC-Unique: 4HMCn-T6MUG4hYkNuTxu4Q-1
Received: by mail-wr1-f69.google.com with SMTP id t4so7646486wrr.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 01:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DrNhLk4md8xADgsdvQBP5jOJ066yz8mp9cRBDVJqbW8=;
 b=KMhnbKYRfcwJgrHL8PEezVcM8U4ZOukWeK4S50lQbM4Aa3H0ZfMYlZGriHjl9czECM
 GAMs1NPjmHLc8YN/XJti9wMF1PdbtqwWDfjnfoL2bOuEJh76ZyE53ZpBRl7pPIWXpIkP
 kA/v7S91W/dt4++n1GlpELR3cHdqbawooKhn7e2CCZiKqnnOCKIzNtweS3H6KeVBR4ss
 YEaqVmgDv5xd2lriY5U3nex7ZiAP93UKvJcdLOAXmIkSl+HTvqN/a+jvRMnvqgI7A6NO
 2ljOI1o52bgK2uxI4xkSSzXtSboaE/i0xztgbUbetWwIYE9InDWGmUrByv/j0K/4zJdP
 1lag==
X-Gm-Message-State: ANhLgQ0rATBdIhkf6hqK3z/paq2iLC+wCZ+FpwkZzjZZzYp9xBS9L+oW
 RQ+JYRhQe0SrFW43di6KYq3n0WerusUrsLMoEyAuUrXVSXH/zn/D8kL8rFOEaBInNByJ8DUqSau
 5AKaXGFnpuDQ95JU=
X-Received: by 2002:adf:ba48:: with SMTP id t8mr4022776wrg.329.1584518581959; 
 Wed, 18 Mar 2020 01:03:01 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUeJYzEAwT9sV92I5+QTQzgEgoI6pQwelTEA1s/JSOZGrp6z6YIVSjJfEE8KjGplxwXDi8kg==
X-Received: by 2002:adf:ba48:: with SMTP id t8mr4022739wrg.329.1584518581669; 
 Wed, 18 Mar 2020 01:03:01 -0700 (PDT)
Received: from [192.168.1.34] (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b5sm8105179wrw.86.2020.03.18.01.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 01:03:01 -0700 (PDT)
Subject: Re: [PATCH 3/4] tests/migration: Disable autoconverge test on
 Travis-CI s390x
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200317200541.6246-1-philmd@redhat.com>
 <20200317200541.6246-4-philmd@redhat.com> <20200317202620.GJ3369@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5f13b5d-03bf-5821-9539-6ba59632ad1f@redhat.com>
Date: Wed, 18 Mar 2020 09:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317202620.GJ3369@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Fam Zheng <fam@euphon.net>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/17/20 9:26 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> This test fails on Travis-CI s390x when configured with --disable-tcg:
>>
>>    $ make check-qtest
>>      TEST    check-qtest-s390x: tests/qtest/boot-serial-test
>>    qemu-system-s390x: -accel tcg: invalid accelerator tcg
>>    qemu-system-s390x: falling back to KVM
>>      TEST    check-qtest-s390x: tests/qtest/pxe-test
>>      TEST    check-qtest-s390x: tests/qtest/test-netfilter
>>      TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
>>      TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
>>      TEST    check-qtest-s390x: tests/qtest/drive_del-test
>>      TEST    check-qtest-s390x: tests/qtest/device-plug-test
>>      TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
>>      TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
>>      TEST    check-qtest-s390x: tests/qtest/migration-test
>>    **
>>    ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: '=
got_stop' should be FALSE
>>    ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrat=
e_auto_converge: 'got_stop' should be FALSE
>>    make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
>=20
> Before we take the hammer to it, could you try reducing it's initial
> bandwidth, the code that says:
>=20
>      /*
>       * Set the initial parameters so that the migration could not conver=
ge
>       * without throttling.
>       */
>      migrate_set_parameter_int(from, "downtime-limit", 1);
>      migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100=
Mb/s */
>=20
> knock a couple of 0's off that and see if it's happy.

You are right! One 0 is not enough, but a couple makes the test succeed.

Can that change have other (bad) effects on other archs?
IOW can I send a generic patch updating this value, or should I add a=20
check on the architecture?

Thanks!

>=20
> Dave
>=20
>> Per David Gilbert, it might be a threshold requiring tuning:
>> "it could just be the writing is slow on s390 and the migration
>> thread fast; in which case the autocomplete wouldn't be needed.
>> Perhaps we just need to reduce the bandwidth limit."
>>
>> Disable the autoconverge test for now.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   tests/qtest/migration-test.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 3d6cc83b88..878399666e 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1181,6 +1181,16 @@ static void test_migrate_auto_converge(void)
>>       MigrateStart *args =3D migrate_start_new();
>>       QTestState *from, *to;
>>       int64_t remaining, percentage;
>> +    char *travis_arch;
>> +
>> +    /*
>> +     * This test does not work reliably on Travis s390x.
>> +     */
>> +    travis_arch =3D getenv("TRAVIS_CPU_ARCH");
>> +    if (travis_arch && g_str_equal(travis_arch, "s390x")) {
>> +        g_test_skip("Test does not work reliably on s390x Travis contai=
ners.");
>> +        return;
>> +    }
>>  =20
>>       /*
>>        * We want the test to be stable and as fast as possible.
>> --=20
>> 2.21.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


