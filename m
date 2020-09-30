Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FCC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397D320708
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6yhUpvZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397D320708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNeoe-0007OJ-47
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNenD-0006q3-SY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNen6-00047A-A9
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:17:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601482634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zE4/WyurK5yQ4i1ZCyTvcfzgw23AZ3fmpBgVSNh9/Vo=;
 b=A6yhUpvZY+CKcCmhO+G5fzFTfor2nUXaDcoih+shh7RhHA2crPcWSI0X76VNOARVfjhRe1
 sxKBVOGI3zm6hNuIyW4HldWMeNzIuHVqCttvDV36r7xKd8HGm8US9awLC4sCZB3/dBc1mu
 GCB0jyfEDOkjnubwYSXFiQB8VFX72PU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-UvQg8Ft5OnGGg7sG3fldTg-1; Wed, 30 Sep 2020 12:17:13 -0400
X-MC-Unique: UvQg8Ft5OnGGg7sG3fldTg-1
Received: by mail-wr1-f70.google.com with SMTP id d13so783465wrr.23
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=zE4/WyurK5yQ4i1ZCyTvcfzgw23AZ3fmpBgVSNh9/Vo=;
 b=MzTxwb5N5L9GRmUHDlze6buu8tGPhUjkbLiWSM7TzHPpGPes0nMxI0ODF5WMIp2ArW
 yUrbUC1+U4dB+UZBY30IJPUNv38Cj/YDt6TlwZZQuIqBnoL86q05yNtIigSGQU7Z6pnL
 cdtj3fglf6JGfxRc653VTsnwmoVpx3eSOA4L3f7IiBsay80kQUVS54pls+1FGOdCwP5Z
 FDtpkbelpZjpaOC0iKaXreC5Q/xrhZ0wqqMrhdtVCgWjjVp2HgvsXbwdMsYUSqlxyxSg
 kpZVYoEUzQI0HoYYgdZE4h4nh95X+pPjjyStGZUwqzdm0XqPotvvHw3fmo9HQAqojTKT
 sQyw==
X-Gm-Message-State: AOAM533lL5jakMDIqhKj3A+wDlEvOA66O4Llre1pnGU7n8mZpmtCh55T
 hLsJfphRbNcZBA90VOg06HDZi7aaApljFattHit4hSoJGO8Fhqh+zTRDA92DnT9GPIZBu0704az
 2BZnwjYQwIPCykKg=
X-Received: by 2002:a1c:1fc6:: with SMTP id f189mr3913607wmf.20.1601482631753; 
 Wed, 30 Sep 2020 09:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsEybPni74FkRHlglQRvZ2cW/6lQLCTJVtRTKSgbZd5iL4SrzPj7b9XRDsm20IxmZi4Va2Jg==
X-Received: by 2002:a1c:1fc6:: with SMTP id f189mr3913583wmf.20.1601482631546; 
 Wed, 30 Sep 2020 09:17:11 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b8sm3595152wmb.4.2020.09.30.09.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 09:17:10 -0700 (PDT)
Subject: Re: [Qemu-devel] [PULL 04/28] hw/arm: Express dependencies of the
 highbank machines with Kconfig
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20190505135714.11277-1-thuth@redhat.com>
 <20190505135714.11277-5-thuth@redhat.com>
 <f2489790-8fcd-a9c3-4ec3-c8a72240f172@redhat.com>
 <b56334d8-e165-4aac-2092-2912d442e6a9@redhat.com>
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
Message-ID: <72ee8d49-eb98-8fe3-208b-67d8e093e9ca@redhat.com>
Date: Wed, 30 Sep 2020 18:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b56334d8-e165-4aac-2092-2912d442e6a9@redhat.com>
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 6:10 PM, Thomas Huth wrote:
> On 30/09/2020 17.38, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 5/5/19 3:56 PM, Thomas Huth wrote:
>>> Add Kconfig dependencies for the highbank machine (and the midway
>>> machine).
>>> This patch is slightly based on earlier work by Ákos Kovács (i.e.
>>> his "hw/arm/Kconfig: Add ARM Kconfig" patch).
>>>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  default-configs/arm-softmmu.mak |  9 +--------
>>>  hw/arm/Kconfig                  | 11 +++++++++++
>>>  2 files changed, 12 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
>>> index 2a11e76cc7..50a4be3cad 100644
>>> --- a/default-configs/arm-softmmu.mak
>>> +++ b/default-configs/arm-softmmu.mak
>>> @@ -8,6 +8,7 @@ CONFIG_PCI_DEVICES=y
>>>  CONFIG_PCI_TESTDEV=y
>>>  
>>>  CONFIG_EXYNOS4=y
>>> +CONFIG_HIGHBANK=y
>>>  
>>>  CONFIG_VGA=y
>>>  CONFIG_NAND=y
>>> @@ -45,24 +46,17 @@ CONFIG_PLATFORM_BUS=y
>>>  CONFIG_VIRTIO_MMIO=y
>>>  
>>>  CONFIG_ARM11MPCORE=y
>>> -CONFIG_A15MPCORE=y
>>>  
>>>  CONFIG_NETDUINO2=y
>>>  
>>> -CONFIG_ARM_TIMER=y
>>> -CONFIG_PL011=y
>>> -CONFIG_PL022=y
>>> -CONFIG_PL031=y
>>>  CONFIG_PL041=y
>>>  CONFIG_PL050=y
>>> -CONFIG_PL061=y
>>>  CONFIG_PL080=y
>>>  CONFIG_PL110=y
>>>  CONFIG_PL181=y
>>>  CONFIG_PL190=y
>>>  CONFIG_PL330=y
>>>  CONFIG_CADENCE=y
>>> -CONFIG_XGMAC=y
>>>  CONFIG_PXA2XX=y
>>>  CONFIG_BITBANG_I2C=y
>>>  CONFIG_FRAMEBUFFER=y
>>> @@ -150,7 +144,6 @@ CONFIG_XILINX_AXI=y
>>>  CONFIG_PCI_EXPRESS_DESIGNWARE=y
>>>  
>>>  CONFIG_STRONGARM=y
>>> -CONFIG_HIGHBANK=y
>>>  CONFIG_MUSICPAL=y
>>>  
>>>  # for realview and versatilepb
>>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>>> index acd07b2add..0ba377ac18 100644
>>> --- a/hw/arm/Kconfig
>>> +++ b/hw/arm/Kconfig
>>> @@ -18,6 +18,17 @@ config EXYNOS4
>>>  
>>>  config HIGHBANK
>>>      bool
>>> +    select A9MPCORE
>>> +    select A15MPCORE
>>> +    select AHCI
>>> +    select ARM_TIMER # sp804
>>> +    select ARM_V7M
>>
>> Hmm I missed that... This machine doesn't use a v7M core, right?
> 
> I think you're right: The machines seem to use A9 and A15 ... so I guess
> this was a copy-n-paste bug ... could you send a patch to clean it up,
> please?

Yes, will do.

> 
>  Thomas
> 


