Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65055C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E23F20774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkKMS8xk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E23F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jii2A-0006qY-AT
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihij-0002qT-15
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jihih-0008Mx-Ox
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 13:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591722447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1WyS3ERdgVkk1+s4mjwEXIZprfLEaGTyvGY39bj/XSY=;
 b=IkKMS8xkkmqDVwRVvOYfO38lekrTLNS015vymqTRK62/mzuQmZpD50ZpkJooKu9vY79Z1L
 A51NMBWJcxPiniuJ6AihESjcIbsMMwuDcxAbgGs1Op8uzrUrL4UOYqz16O0LDodtz6xI1l
 EzfWEAAqA8VVyiWwQROjgV6hqpMHN0M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-fk8nzBxIM7iZZWcTOw3nhQ-1; Tue, 09 Jun 2020 13:07:25 -0400
X-MC-Unique: fk8nzBxIM7iZZWcTOw3nhQ-1
Received: by mail-wm1-f69.google.com with SMTP id g84so903868wmf.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 10:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=1WyS3ERdgVkk1+s4mjwEXIZprfLEaGTyvGY39bj/XSY=;
 b=E29kco4hSzeImshH2kMl9VCv7ZVzajI4b1rz5rjGun3Wo9s1iWTfFbVicNE06XKmTA
 ENJBnCMRhnmA7MHelHooDTl18/sfmoX1LfWd8f5kS6mwyCzehA4Le00DY63EquMJeNs4
 Sh/At1bVC1od9XTzUp8xH56R7Wtstyww61jLZZAmniBUwJcB5dTWxO1QEPVfvv2ZRz9d
 c6kIR6ZP8WGx2SN+VsTIQIAOxXPesqBtTS3aiITyUHos/YuxIU0KV3AzotBHpX9+xEBE
 sjq0iUawmSAeojbdbqu/X/sCv8zK5dAX5XHKagfotJJbT+3fej4HXsyNK5NX6jmTPuDd
 SR9g==
X-Gm-Message-State: AOAM533cBjFjbFvCnIIDaqTz35668luGDJybIYOwns1TeqaRlxxDRPeX
 Q6cwWV+tjNlP3c338de+avt+IndkcYYuq/0dyW+m5q2q00FCkt/UZwyB0/CAIYW/RJZPVCTUm9M
 X80binqPBCNAE5Ow=
X-Received: by 2002:a5d:548c:: with SMTP id h12mr5483154wrv.120.1591722444372; 
 Tue, 09 Jun 2020 10:07:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznawMetk8vIBikW80jJWVvyFykoXLc2xRfknvEbeNjUcsscgpE/8PIij1kMjGMv/czNwhvOg==
X-Received: by 2002:a5d:548c:: with SMTP id h12mr5483131wrv.120.1591722444064; 
 Tue, 09 Jun 2020 10:07:24 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id a3sm3506149wmb.7.2020.06.09.10.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 10:07:23 -0700 (PDT)
Subject: Re: [PULL 3/9] tests/migration: Reduce autoconverge initial bandwidth
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200325131632.311034-1-dgilbert@redhat.com>
 <20200325131632.311034-4-dgilbert@redhat.com>
 <20200609123323-mutt-send-email-mst@kernel.org>
 <20200609170017.GD2841@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <98ebe092-615a-da34-0cf9-2924ca8fdd18@redhat.com>
Date: Tue, 9 Jun 2020 19:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200609170017.GD2841@work-vm>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: imammedo@redhat.com, vsementsov@virtuozzo.com, pannengyuan@huawei.com,
 qemu-devel@nongnu.org, maozhongyi@cmss.chinamobile.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 7:00 PM, Dr. David Alan Gilbert wrote:
> * Michael S. Tsirkin (mst@redhat.com) wrote:
>> On Wed, Mar 25, 2020 at 01:16:26PM +0000, Dr. David Alan Gilbert (git) wrote:
>>> From: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>>>
>>> When using max-bandwidth=~100Mb/s, this test fails on Travis-CI
>>> s390x when configured with --disable-tcg:
>>>
>>>   $ make check-qtest
>>>     TEST    check-qtest-s390x: tests/qtest/boot-serial-test
>>>   qemu-system-s390x: -accel tcg: invalid accelerator tcg
>>>   qemu-system-s390x: falling back to KVM
>>>     TEST    check-qtest-s390x: tests/qtest/pxe-test
>>>     TEST    check-qtest-s390x: tests/qtest/test-netfilter
>>>     TEST    check-qtest-s390x: tests/qtest/test-filter-mirror
>>>     TEST    check-qtest-s390x: tests/qtest/test-filter-redirector
>>>     TEST    check-qtest-s390x: tests/qtest/drive_del-test
>>>     TEST    check-qtest-s390x: tests/qtest/device-plug-test
>>>     TEST    check-qtest-s390x: tests/qtest/virtio-ccw-test
>>>     TEST    check-qtest-s390x: tests/qtest/cpu-plug-test
>>>     TEST    check-qtest-s390x: tests/qtest/migration-test
>>>   **
>>>   ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
>>>   ERROR - Bail out! ERROR:tests/qtest/migration-test.c:1229:test_migrate_auto_converge: 'got_stop' should be FALSE
>>>   make: *** [tests/Makefile.include:633: check-qtest-s390x] Error 1
>>>
>>> Per David Gilbert, "it could just be the writing is slow on s390
>>> and the migration thread fast; in which case the autocomplete
>>> wouldn't be needed. Perhaps we just need to reduce the bandwidth
>>> limit."
>>>
>>> Tuning the threshold by reducing the initial bandwidth makes the
>>> autoconverge test pass.
>>>
>>> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Signed-off-by: Philippe Mathieu-DaudÃƒÂ© <philmd@redhat.com>
>>> Message-Id: <20200323184015.11565-1-philmd@redhat.com>
>>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> Tested-by: Alex BennÃƒÂ©e <alex.bennee@linaro.org>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>>
>> This slows make check down significantly for me, it stays
>> at the migration test for minutes.
> 
> Is this on the s390x version or all of them?

Personally I only noticed it on s390x.

Alex have you seen another arch?

> 
>> I'm carrying a revert at top of my tree for now but I'd rather
>> not need that.
>>
>>
>> This seems like a fragile way to test things anyway.
>> What happens if someone slows writing even more
>> e.g. because it's running in a container or a VM?
>>
>> How about detecting that migration finished too early
>> and slowing it down until autocomplete triggers?
> 
> THe problem is you can't rely on any form of consistency in a heavily
> contended container, so the fact that it took n-seconds to migrate at
> this attempt means very little about what the next attempt will take.
> 
> Dave
> 
>>
>>
>>> ---
>>>  tests/qtest/migration-test.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>>> index 3d6cc83b88..2568c9529c 100644
>>> --- a/tests/qtest/migration-test.c
>>> +++ b/tests/qtest/migration-test.c
>>> @@ -1211,7 +1211,7 @@ static void test_migrate_auto_converge(void)
>>>       * without throttling.
>>>       */
>>>      migrate_set_parameter_int(from, "downtime-limit", 1);
>>> -    migrate_set_parameter_int(from, "max-bandwidth", 100000000); /* ~100Mb/s */
>>> +    migrate_set_parameter_int(from, "max-bandwidth", 1000000); /* ~1Mb/s */
>>>  
>>>      /* To check remaining size after precopy */
>>>      migrate_set_capability(from, "pause-before-switchover", true);
>>> -- 
>>> 2.25.1
>>>
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


