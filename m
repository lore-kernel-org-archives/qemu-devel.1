Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC417C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B472082F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZqAilxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B472082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8Fd-0002Mb-WE
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo8Ec-0001iC-TS
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:26:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21983
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jo8EZ-0007Qu-0r
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593016005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=inXIERzzsGyTDRlVFUpwn4rhGFRVx4cIW5FxvrHyFZA=;
 b=WZqAilxynhzGqaODXRGimYgOXb4JIs96uXbCh7+ZlBMm09uJ2hme31WZneeDqnjpH96f3U
 UfUg/p4poNRXCcH8oc1Zkd6/ejWLOLtxvKQLPKQ9o2V9NsF703ZZXkJqhTkf07dlmRIPU7
 fMtrPYMN7yRf8XoWVyaoW/4EVjpJJSc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-y8oP9T3APtq1JFUYelRNIQ-1; Wed, 24 Jun 2020 12:26:38 -0400
X-MC-Unique: y8oP9T3APtq1JFUYelRNIQ-1
Received: by mail-wr1-f72.google.com with SMTP id i12so3187066wrx.11
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 09:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=inXIERzzsGyTDRlVFUpwn4rhGFRVx4cIW5FxvrHyFZA=;
 b=dirI+azi6odqmgdbxcF/azqpGWPfgm1r4/0+fv4XihhvUHFl51nmEqv7oyq7854Tjn
 vB36LghYkhUoy4hd0d1yAYpzXUqppCl6t2ac1aCLlMCFKgwDFCwj5wL8IPNh+oWME5dO
 gMvwmVFNA4YIHpJVZNxOxCgB1juWu2iFkTBnWwvrBCPUrlxQZCNnSwhe3ByZHQE4fXhh
 ifk1cJoRH1AbTOSeUg8ePoTMT9gJ/O72iOtq5J+ZRCWd/PR8K1X51QTfMo0Di5si/Pez
 ryLzcQsMf4soMd8pmc9G71gSL7L8RdgjEJQB8ScaAtyVA1+j5OmsETTFQkZHCCy6P9sk
 I3KA==
X-Gm-Message-State: AOAM531jRN1ypOrXuSU7n2/8lKV49iZd4zh9wfKax7Kfwc7JFIaTb6h/
 HKdKQOTOLvRaqWj0ktMHCuVQQew+iKKwAFNyu5VrKbhRloanQx9itmYc1E9V/Jp9GWgV0xHAVnc
 Hau8vbjlact0A4QM=
X-Received: by 2002:a5d:5490:: with SMTP id h16mr34173624wrv.394.1593015996983; 
 Wed, 24 Jun 2020 09:26:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaJcTG5OqHkJ5vHTToulNNv2NEM121huPN9zmUe/7XY2j2XcrZucCBmYs8DqOyAYGSMAxP7A==
X-Received: by 2002:a5d:5490:: with SMTP id h16mr34173597wrv.394.1593015996664; 
 Wed, 24 Jun 2020 09:26:36 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c20sm24362766wrb.65.2020.06.24.09.26.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 09:26:36 -0700 (PDT)
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200623145506.439100-1-mst@redhat.com>
 <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
 <5d3c4773-5aa2-e80d-68c7-a94eac8a7422@redhat.com>
 <66821238-4da7-ec35-4bb7-6dc46bcbca1d@redhat.com>
 <99caf774-fec0-08e4-3565-228d9a0c688b@redhat.com>
 <e4ba1b70-9bad-05a0-fa4e-6e9a610d4c9c@redhat.com>
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
Message-ID: <c0fca999-411b-a097-0513-32c7a5e3ff99@redhat.com>
Date: Wed, 24 Jun 2020 18:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e4ba1b70-9bad-05a0-fa4e-6e9a610d4c9c@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thomas,

On 6/24/20 12:21 PM, Philippe Mathieu-Daudé wrote:
> On 6/24/20 7:04 AM, Thomas Huth wrote:
>> On 23/06/2020 19.35, Philippe Mathieu-Daudé wrote:
>>> On 6/23/20 7:07 PM, Thomas Huth wrote:
>>>> On 23/06/2020 17.39, Philippe Mathieu-Daudé wrote:
>>>>> On 6/23/20 4:56 PM, Michael S. Tsirkin wrote:
>>>>>> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
>>>>>> since that change makes unit tests much slower for all developers, while it's not
>>>>>> a robust way to fix migration tests. Migration tests need to find
>>>>>> a more robust way to discover a reasonable bandwidth without slowing
>>>>>> things down for everyone.
>>>>>
>>>>> Please also mention we can do this since 1de8e4c4dcf which allow
>>>>> marked the s390x job as "unstable" and allow it to fail.
>>>>>
>>>>> But if nobody is going to look at it, instead lets disable
>>>>> it until someone figure out the issue:
>>>>>
>>>>> -- >8 --
>>>>> diff --git a/.travis.yml b/.travis.yml
>>>>> index 74158f741b..364e67b14b 100644
>>>>> --- a/.travis.yml
>>>>> +++ b/.travis.yml
>>>>> @@ -507,6 +507,7 @@ jobs:
>>>>>
>>>>>      - name: "[s390x] Clang (disable-tcg)"
>>>>>        arch: s390x
>>>>> +      if: false # Temporarily disabled due to issue testing migration
>>>>> (see commit 6d1da867e65).
>>>>>        dist: bionic
>>>>>        compiler: clang
>>>>>        addons:
>>>>
>>>> Sorry, but that looks wrong. First, the disable-tcg test does not run
>>>> the qtests at all. So this is certainly the wrong location here.
>>>
>>> Indeed, this is the previous job:
>>>
>>> -- >8 --
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 74158f741b..b399e20078 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -464,6 +464,7 @@ jobs:
>>>          - CONFIG="--disable-containers
>>> --target-list=ppc64-softmmu,ppc64le-linux-user"
>>>
>>>      - name: "[s390x] GCC check-tcg"
>>> +      if: false # Temporarily disabled due to issue testing migration
>>> (see commit 6d1da867e65).
>>>        arch: s390x
>>>        dist: bionic
>>>        addons:
>>> ---
>>>
>>>> Second,
>>>> if just one of the qtests is failing, please only disable that single
>>>> failing qtest and not the whole test pipeline.
>>>
>>> Last time we talked about this Dave was against that option:
>>>
>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg690085.html
>>>
>>
>> Was he? Citing his reply to the mail from your URL:
>>
>>  "Before we take the hammer to it, could you try reducing it's initial
>> bandwidth"
>>
>> So all I can see is that he first wanted to try something different than
>> disabling the test. And now,  instead of using a small hammer to disable
>> just this test, you now even use a very *big* hammer to disable *all*
>> tests. That's just a very bad idea. Please don't.

You asked on IRC the CI failures history:

https://travis-ci.org/github/philmd/qemu/jobs/663607963
https://travis-ci.org/github/philmd/qemu/jobs/663622229
https://travis-ci.org/github/philmd/qemu/jobs/663642522

"No output has been received in the last 10m0s, this potentially
indicates a stalled build or something wrong with the build itself."

> 
> You are right. I was being concerned about having CI working because
> the more red it stay, the less likely the community will worry about
> it, and I didn't want we loose interest in testing (or discredit its
> importance). I now understand without having CI gating, it is
> pointless to try to keep it green (at the cost of having all local
> testing running slower, it is worst if maintainers stop their local
> testing).
> 
> WRT this test I have no idea what it is doing, furthermore why it
> fails on s390x containers, so I sent a simple patch to fix the CI,
> but failed to foreseen its negative effect on the rest of the
> developers.
> 
> Thanks Michael for fixing my mess with your patch:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Regards,
> 
> Phil.
> 


