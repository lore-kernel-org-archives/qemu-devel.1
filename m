Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE2CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C738520C56
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 10:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQSWBvfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C738520C56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL25a-0003Ix-Ps
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 06:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL23S-0002hl-2l
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21566)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kL23J-0005hX-G7
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600857067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xYGMmv7RqVc8QVbUt4/Prut0LKaQU/3HzAdbvf83XeA=;
 b=VQSWBvfh5uw3FhxYehqqe50HmcMNOwI5uIfwLwmv/8myRvMXvFTp2QBgRrmoRQvAS9jFV2
 8ujTld2Tge6SHDyPP/Uy8Eg0l8+vvED8dTbMp4vc7k3RQrnw004hSMXGI++66paOzvxHNJ
 w85UQusBHgAPXfxZ3iTzeUtPo3IJl5I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-hwDiBNzBOHuxiiYOh3UfKA-1; Wed, 23 Sep 2020 06:31:05 -0400
X-MC-Unique: hwDiBNzBOHuxiiYOh3UfKA-1
Received: by mail-wm1-f70.google.com with SMTP id b20so2154492wmj.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 03:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=xYGMmv7RqVc8QVbUt4/Prut0LKaQU/3HzAdbvf83XeA=;
 b=LlnNRG3N6xUCx0YGp4WpANc6RraXPJz/kA9x7S6k0vjQmUnqOQM20OZDea1ybkK5qq
 AEbgVFGEIPCoSVD0+o725HrZucDIwByAmi9h7wBlIxM9uLrMdNusS0/xnLP924jlgH8B
 L0ElbdBT/uffYw+Xnn4WqBJlpxmLjm0ZI/Z4DHphOanIIugJwj5nUrOOe2UtiWhQTJu/
 HmO4UN/9QN73VBvi/ZgTHoodh6tM1NkkHfMnxfOXoSOGut81bhfLuTX3CG5ZW5CzuJa5
 WurY2UgHnzxombeNeXzLSmV+dg8cCdzxVuzkg7U07tnxiOdm1eeJ8ceByIHZtXC8GvCE
 Dylw==
X-Gm-Message-State: AOAM533gisUtAgTqDEMLFh6hTi9rylbGKPi+Nb4T6zy6C2Ak2aesMcY8
 wdffgC+xs/HwvRp01Oeu+saoAxaFaK2HK07M4DYLtb2NfOxDc7lcC1QXima/g9Rt+1cvySVnXi8
 auU3ka5G2GCpzh/o=
X-Received: by 2002:a7b:c958:: with SMTP id i24mr6036649wml.50.1600857064059; 
 Wed, 23 Sep 2020 03:31:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfkFmARBdWxOrxMrBPWSMlGDA8W2MvHDXqIW2davGyHOaNezKThxbGoRLqmJFjbeYY+VB68Q==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr6036626wml.50.1600857063800; 
 Wed, 23 Sep 2020 03:31:03 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id q4sm29359865wru.65.2020.09.23.03.31.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2020 03:31:03 -0700 (PDT)
Subject: Re: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-5-philmd@redhat.com>
 <CAFEAcA9XOpCyWr0QXn6T_y9nh4ZX5Op2ztonefr-pV2oQfU3iw@mail.gmail.com>
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
Message-ID: <fd8a9c3e-45f2-caae-25ab-5e1365fd9298@redhat.com>
Date: Wed, 23 Sep 2020 12:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9XOpCyWr0QXn6T_y9nh4ZX5Op2ztonefr-pV2oQfU3iw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 12:16 PM, Peter Maydell wrote:
> On Wed, 23 Sep 2020 at 11:09, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> All our supported compilers provide the __builtin_bswap()
>> functions. Drop the <byteswap.h> dependency.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
>> index 6875e48d617..c192a6ad3e7 100644
>> --- a/include/qemu/bswap.h
>> +++ b/include/qemu/bswap.h
>> @@ -10,23 +10,6 @@
>>  # include <sys/endian.h>
>>  #elif defined(__HAIKU__)
>>  # include <endian.h>
>> -#elif defined(CONFIG_BYTESWAP_H)
>> -# include <byteswap.h>
>> -
>> -static inline uint16_t bswap16(uint16_t x)
>> -{
>> -    return bswap_16(x);
>> -}
>> -
>> -static inline uint32_t bswap32(uint32_t x)
>> -{
>> -    return bswap_32(x);
>> -}
>> -
>> -static inline uint64_t bswap64(uint64_t x)
>> -{
>> -    return bswap_64(x);
>> -}
>>  #else
>>  # define bswap16(_x) __builtin_bswap16(_x)
>>  # define bswap32(_x) __builtin_bswap32(_x)
> 
> I suppose if we wanted to just use the __builtin_bswap*
> implementation on all hosts (ie drop the special casing
> of CONFIG_MACHINE_BSWAP_H/FreeBSD/Haiku) we'd need to
> rename our macros to avoid potential conflicts with the
> versions in the system headers there in case they were
> pulled in via some other path ?

Yes, this is why I couldn't get ride of everything

After reading Paolo's suggestion to use qatomic*, I
am tempted to suggest qbswap* but I am still looking
for better alternatives...

> 
> thanks
> -- PMM
> 


