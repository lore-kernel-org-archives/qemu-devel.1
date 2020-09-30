Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4DAC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:35:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D787F20738
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 11:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KU05lpqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D787F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNaOb-0001FV-0d
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 07:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNaNG-0007jo-ML
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNaNB-0004C3-5u
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 07:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601465648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yGzZAb6CUUfvuB+rABpzetf5qwBH7y5IfxJJd8oY32Y=;
 b=KU05lpqwUylMBQ1JUI5o4oRuxy0X9Lre8EZyEEQ4VbZVH0cIIRuCVfsAjzNLSUPlV7q7AR
 4LG5w34DXxWEAQTw0M5qJgvKKiur3V0Gtzes4e9oxoMkFaoG1ceP6yB6XuvKFpP8fEbYhD
 4q6VgCcoqnr2/Zt2P+LCKOaEWZ+bR5Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-NDGXttYaN6-zJi9dfuxITw-1; Wed, 30 Sep 2020 07:34:04 -0400
X-MC-Unique: NDGXttYaN6-zJi9dfuxITw-1
Received: by mail-wm1-f70.google.com with SMTP id u5so511900wme.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 04:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=yGzZAb6CUUfvuB+rABpzetf5qwBH7y5IfxJJd8oY32Y=;
 b=Adf5JBbZll5gC7cOlB6OzE83Ev3lb10GxNePh6nZqLK3rBzizZFZpFJxQmiq3+a2lC
 SaLaZZPCCYu+7DTW3U8PmMJ9iHxSUwWT2WTXEu5z3BmpUc39A693YxBcBJY0xrRPY+ZK
 t6DL/ciggNXTLar1doHiwU1mKJCcXUAbHsguAtToWhrNNHOZZX0RVEEI/L2J23uyTw03
 3AhUSD9G5ME3QXD+qCeIJ5rjK/fn71w+6GE2hlB5N8j0IFD8/xWV3BZBsTstmcm5i1aF
 4nN4jeNDWCe6uAzshzX7/zgLwP99/YCsDW+faIZX+f+jBs/bXuG6cg0Oo/FZsgR+ay7r
 0KXQ==
X-Gm-Message-State: AOAM530Z1CnL8cVk2ZwHOsbPXSGNVLfOFXUktDvF+50Uqj062PsSDs7W
 uZhbpas10OFB219uLOLeg7bbSyecQqRi5Zb+w/RVhScdTLM6B1igy2raN5lGdkLhusr2RZvykkB
 ayKyna1Nb3dlCCfg=
X-Received: by 2002:adf:ab46:: with SMTP id r6mr2782766wrc.360.1601465643250; 
 Wed, 30 Sep 2020 04:34:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCahAtti8/jIRElMMKZkLDYAmEv6FFAYXsHamV1hvfPLJAy5gl7lkB7Y1e/U8mBSmgfjhfLw==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr2782743wrc.360.1601465643018; 
 Wed, 30 Sep 2020 04:34:03 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 92sm2673330wra.19.2020.09.30.04.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 04:34:02 -0700 (PDT)
Subject: Re: [PATCH] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
To: Dongjiu Geng <gengdongjiu@huawei.com>, qemu-devel@nongnu.org
References: <20200929125609.1088330-1-philmd@redhat.com>
 <12be4400-c37f-2b7f-2f15-f8700dad6003@huawei.com>
 <056736d8-dc89-a94b-7e76-93825492c957@redhat.com>
 <5b5e1b32-0e9b-8154-e645-9b922119db33@huawei.com>
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
Message-ID: <4f2f3b35-a0a9-1a2e-4d14-b6aad728d6a6@redhat.com>
Date: Wed, 30 Sep 2020 13:34:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5b5e1b32-0e9b-8154-e645-9b922119db33@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Xiang Zheng <zhengxiang9@huawei.com>,
 qemu-arm@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 1:05 PM, Dongjiu Geng wrote:
> 
> On 2020/9/30 18:35, Philippe Mathieu-Daudé wrote:
>> On 9/30/20 7:08 AM, Dongjiu Geng wrote:
>>> On 2020/9/29 20:56, Philippe Mathieu-Daudé wrote:
>>>> As only the Virt machine uses the RAS Virtualization feature (see
>>>> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option"),
>>>> restrict the APEI tables generation code to the virt machine.
>>>
>>> APEI is a generic feature for X86 and arm64.  X86 platform also can use it, although currently it was mainly
>>> used by ARM64. what is reason that we restrict APEI tables generation to the 'virt' machine?
>>
>> It is currently only selected on (all) the ARM machines, not the X86
>> ones. I am simply restricting it to the 'virt' machine which is the
>> single one enabling the RAS. Without RAS the table is not built, so
>> for the case of the SBSA-Ref machine this code is unreachable, no need
>> to select ACPI_APEI.
>>
>> When a X86 machine configure a RAS it will have to 'select ACPI_APEI'
>> to get it built (I'm not forbidding it, I'm restricting it to where
>> it is used).
> 
> Got it, thanks for the explanation.
> 
> Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>

Thanks, I'll reword the description, ...

> 
> BTW：There is a build test error, but it is seems do not related with this patch.
> https://patchew.org/logs/20200929125609.1088330-1-philmd@redhat.com/testing.docker-quick@centos7/?type=message

... and look at that error before posting.

> 
>>
>>>
>>>>
>>>> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardware error fw_cfg blob")
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> Cc: Laszlo Ersek <lersek@redhat.com>
>>>> Cc: Xiang Zheng <zhengxiang9@huawei.com>
>>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>>> Cc: Dongjiu Geng <gengdongjiu@huawei.com>
>>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>>> ---
>>>>  default-configs/arm-softmmu.mak | 1 -
>>>>  hw/arm/Kconfig                  | 1 +
>>>>  2 files changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>>> index 9a94ebd0be..08a32123b4 100644
>>>> --- a/default-configs/arm-softmmu.mak
>>>> +++ b/default-configs/arm-softmmu.mak
>>>> @@ -43,4 +43,3 @@ CONFIG_FSL_IMX7=y
>>>>  CONFIG_FSL_IMX6UL=y
>>>>  CONFIG_SEMIHOSTING=y
>>>>  CONFIG_ALLWINNER_H3=y
>>>> -CONFIG_ACPI_APEI=y
>>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>>> index f303c6bead..7d040827af 100644
>>>> --- a/hw/arm/Kconfig
>>>> +++ b/hw/arm/Kconfig
>>>> @@ -26,6 +26,7 @@ config ARM_VIRT
>>>>      select ACPI_MEMORY_HOTPLUG
>>>>      select ACPI_HW_REDUCED
>>>>      select ACPI_NVDIMM
>>>> +    select ACPI_APEI
>>>>  
>>>>  config CHEETAH
>>>>      bool
>>>>
>>>
>>
>> .
>>
> 


