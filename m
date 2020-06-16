Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168BBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:57:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D666820644
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdhAcjP3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D666820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlD1r-00086q-3V
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlCo3-0006i5-Rt
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:43:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42872
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jlCo1-0002VZ-GB
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 10:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592318596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MV6YcXhC3UDnQuU58Fe81XaiOeluBx75QeqeVTk4r4g=;
 b=PdhAcjP3zuiF1xxx3M3+20I01Ha/nNv0ag048s1Kg40X3DB0QxSyMSgqC4bD6GJYe3RInk
 H4Vm8Fu04CnsLdO1Vz5HuRS1/vQMlBlSmFLY8FkDnyMBcuMMyyIxP1x622MEUQlcinkLe4
 ZEDUOay4aEQWZgK2Y0LRVAoKpWV0iIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-Y3Aw6_MeNhGeUk51ZSeKzw-1; Tue, 16 Jun 2020 10:43:09 -0400
X-MC-Unique: Y3Aw6_MeNhGeUk51ZSeKzw-1
Received: by mail-wm1-f70.google.com with SMTP id l2so1042380wmi.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 07:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=MV6YcXhC3UDnQuU58Fe81XaiOeluBx75QeqeVTk4r4g=;
 b=Ycxj80nFfzDg+YGnRkWtyMHmtoz+DrAaXCS8b4Ovjx2yBP7ZOg+nHI3YivkW06Oua8
 eIYSf/SM/hbU5RhOCKbDHHdKMaSw7j1hVdXNvBBIACpKapWsFb2BUdpQxuHvRjlQ9F6P
 WfsJkC13Ur3RxIYs2JTyNLXUmFgvYcjYEqI5EY1a90AdEQbGr2pvJkpWlCGHmn0QrLZf
 vn1pu+ZZynf2YEZoJWQ5em19Bin0bcCO2HMI3vk+8pv0k8p4ReYZKieyRRzci2GQqJV+
 PEE++eeGQ0j1XmpNQYe4XKoLnwPtlSp076e3rNaQ3zJXl00QW8mf/PAAcLnWnXt6AkL+
 d8Dw==
X-Gm-Message-State: AOAM533Pb77dqfqoipmgfyxhz4KInQgDz7TazH5gAJyzjLDVaZiJSwRG
 ssSdGysg/oX68+n4Un8taWu8XuaZ9HCyWXrr7PHcz7okn8xdz2Sy9c7tjUALt0eBpAPRg28o3Dz
 vgdS1uEdl7ZvwHEc=
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr3486408wml.24.1592318587892; 
 Tue, 16 Jun 2020 07:43:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSAChiy7Yz8CkMG9gU/AmnlEBzYqDzKL6kDfItd2WoAjUIyiJMTBzTo/+tlO/vy30/nETNIQ==
X-Received: by 2002:a05:600c:2218:: with SMTP id
 z24mr3486388wml.24.1592318587690; 
 Tue, 16 Jun 2020 07:43:07 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id q128sm4349126wma.38.2020.06.16.07.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2020 07:43:07 -0700 (PDT)
Subject: Re: [PULL 01/21] tests/docker: bump fedora to 32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200616125324.19045-1-alex.bennee@linaro.org>
 <20200616125324.19045-2-alex.bennee@linaro.org>
 <e08991ac-cb9f-9092-60d9-0f9e9522695e@redhat.com> <874krb15k9.fsf@linaro.org>
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
Message-ID: <4d18e0ac-09a8-a912-ae0d-2f551d33c4ab@redhat.com>
Date: Tue, 16 Jun 2020 16:43:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <874krb15k9.fsf@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 3:52 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 6/16/20 2:53 PM, Alex Bennée wrote:
>>> We should be keeping this up to date as Fedora goes out of support
>>> quite quickly.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>
>> FWIW this one had:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Thanks, I've issued a v2 of the tag:
> 
>   pull-testing-and-plugin-160620-2

I didn't meant to ask you to resend a v2...
I just wanted to notice that sometimes tags get lost in your
workflow. Sorry for the time lost.

>   
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06556.html
>>
>>> Message-Id: <20200612190237.30436-2-alex.bennee@linaro.org>
>>>
>>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
>>> index 92b6e11c8a8..798ddd2c3e0 100644
>>> --- a/tests/docker/dockerfiles/fedora.docker
>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>> @@ -1,4 +1,4 @@
>>> -FROM fedora:30
>>> +FROM fedora:32
>>>  
>>>  # Please keep this list sorted alphabetically
>>>  ENV PACKAGES \
>>>
> 
> 


