Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B34D2074B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 13:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WzxIvCfq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B34D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtWT5-0002P9-R6
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 09:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWSV-0001ro-Ia
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:19:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtWST-0001Zx-Ve
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 09:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594300764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WK3duEUX9r0p3fcjJ0IQ4V4UP68S5ACcJhSdpfHGt5o=;
 b=WzxIvCfq208JjxzUViTpnj8gLLGhFMou2jZz5bLeGMkPhVKMF1WLd60+023uWnwwz1tnau
 39+77x+lVcaeXc98xtfczQyUeAd0u/QrphjLzGLEwDCQXEcufx7P8XgsMLeRrc+4DZO8tT
 vLuOuFJoLNB2sqQBn+tT0CcO/awI6pM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-mmZ2nd29NjeyUvgbH-OI5w-1; Thu, 09 Jul 2020 09:19:23 -0400
X-MC-Unique: mmZ2nd29NjeyUvgbH-OI5w-1
Received: by mail-wr1-f72.google.com with SMTP id a18so1904449wrm.14
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 06:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WK3duEUX9r0p3fcjJ0IQ4V4UP68S5ACcJhSdpfHGt5o=;
 b=Ceeo8Lsz87wrmvWd1rrW6OfJ6UUbagUyZSGrUByDuIz95DjZ+/ROdH7EeNTT4kiFC2
 O7aDJ8yAPmTJgnO1dh30v5B0VxBrcCyvOiEawRNBoaEsiISL8KJAXkIjQFeDxKBG3G67
 h6VbF4aBiZjJNBcBDYh83eBZywg39KS3oIA+dRzHNSiQdakZ2/CawJLXhccYtlE+tJ0u
 h70mel9wOapuX3xq9J/wv6WUG+52Y61WSbJoThNm2IGx6ZLJKYEOTfoqpXzRRvShxhV0
 kS3Tiv4U4Kcdz27EoBBtiNLzTqvqpDCKP143J5fGzYyOZQRZAOTZIckcuxtZg87yongN
 q14w==
X-Gm-Message-State: AOAM53134kia75dtsRFUR8DTreXT3KnZ3rvOKvhv77lq6kZi4webj07o
 WnDeAQpFdqWQ7xE06gTQgnaCXxN/p8Q7V8jDgCJPBFRBWnZOOne0laP2xzmOvd64dbh6Z9XzP5A
 V18G0Ho+SQkbV+B0=
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr14023051wmh.176.1594300762156; 
 Thu, 09 Jul 2020 06:19:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzN+rMv1xaogmCi/8siIG1LIyg2Kuh4I5k/CNvuWJh5QBnF4K5O7U7yk/h4dwF2ZSyMr8mP7w==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr14023020wmh.176.1594300761921; 
 Thu, 09 Jul 2020 06:19:21 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g82sm5004328wma.37.2020.07.09.06.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 06:19:21 -0700 (PDT)
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Greg Kurz <groug@kaod.org>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net> <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
 <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
 <20200708213900.GD780932@habkost.net>
 <714621e2-4585-e6ee-5812-f3a45aa09267@redhat.com>
 <20200709115413.722d4feb@bahia.lan>
 <69e8f708-4fa7-6240-1484-febae0246ae6@redhat.com>
 <20200709125525.29d28d6a@bahia.lan>
 <9951d4cb-7aba-bc65-91be-1fe57393d68e@redhat.com>
 <20200709151320.720fb0f0@bahia.lan>
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
Message-ID: <75d3fffa-1740-0868-cf8f-1dd9fd03b1c3@redhat.com>
Date: Thu, 9 Jul 2020 15:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200709151320.720fb0f0@bahia.lan>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 3:13 PM, Greg Kurz wrote:
> On Thu, 9 Jul 2020 14:21:04 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
>> On 7/9/20 12:55 PM, Greg Kurz wrote:
>>> On Thu, 9 Jul 2020 12:18:06 +0200
>>> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>
> 
> [...]
> 
>>>>>
>>>>> FYI, PAPR requires all vCPUs to be "stopped" by default. It is up to the
>>>>> guest to start them explicitly through an RTAS call. The hypervisor is
>>>>> only responsible to start a single vCPU (see spapr_cpu_set_entry_state()
>>>>> called from spapr_machine_reset()) to be able to boot the guest.
>>>>>
>>>>> So I'm not sure to see how that would depend on the accelerator...
>>>>
>>>> $ qemu-system-ppc64 -M pseries-5.0,accel=tcg -d in_asm
>>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>>> cap-cfpc=workaround
>>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>>> cap-sbbc=workaround
>>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>>> cap-ibs=workaround
>>>> qemu-system-ppc64: warning: TCG doesn't support requested feature,
>>>> cap-ccf-assist=on
>>>> ----------------
>>>> IN:
>>>> 0x00000100:  48003f00  b        0x4000
>>>>
>>>> ----------------
>>>> IN:
>>>> 0x00004000:  7c7f1b78  mr       r31, r3
>>>> 0x00004004:  7d6000a6  mfmsr    r11
>>>> 0x00004008:  3980a000  li       r12, 0xa000
>>>> 0x0000400c:  798c83c6  sldi     r12, r12, 0x30
>>>> 0x00004010:  7d6b6378  or       r11, r11, r12
>>>> 0x00004014:  7d600164  mtmsrd   r11
>>>> ...
>>>>
>>>> The vCPU doesn't seem stopped to me...
>>>>
>>>> Am I missing something?
>>>>
>>>
>>> Yeah this is the boot vCPU which is required to be started
>>> by the platform as explained above, but if you had more
>>> vCPUs the other ones would be stopped until the guest OS
>>> asks us to start them.
>>
>> Ah OK, so we are good :)
>>
>> The machine simply has to set the 'start-powered-off' flag on
>> all vCPUS except the 1st one.
>>
> 
> We only want the first vCPU to start when the platform is
> fully configured, so I'd rather put 'start-powered-off' on
> every body and explicitly power on the first one during
> machine reset as we do now.

I meant "we are good" in reference to the beginning of
this thread with Thiago and Eduardo:

- 'start-powered-off' is a CPU feature (not machine)
- machine set the 'start-powered-off' field


