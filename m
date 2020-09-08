Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC849C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:35:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4547D206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkjnEvMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4547D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFayW-0004KN-E3
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34742)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFaxw-0003o7-Tx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:35:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFaxv-0001Xt-8w
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599561306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0Rbg3y9ewfptBrDhdi0EzEzx8ufzIK3I+C9KjMN0FTc=;
 b=WkjnEvMzRtE2X/xoQEBQq58cjtXP34s0/PvCcHI90o5B5sKRPIyfToxzpuD2culeUCSvMM
 TKa93FzSMS3icbaImrFx8IDyH+UwqkQ1SFosr9BLoCuM/NURvuJuVfeW04jvHNT7WxX+Fs
 s/Gva0/xieu51jor6/nfxMdHgS/J7o8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-DhHzCQnzPqai9MgwL-Hrvw-1; Tue, 08 Sep 2020 06:35:02 -0400
X-MC-Unique: DhHzCQnzPqai9MgwL-Hrvw-1
Received: by mail-wm1-f71.google.com with SMTP id m125so4574020wmm.7
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 03:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=0Rbg3y9ewfptBrDhdi0EzEzx8ufzIK3I+C9KjMN0FTc=;
 b=oPbQqmQPyx9pZcsSrQI7p+h9KYBVnO9CQhCeW69LHLPgQbsxEwJNkVGsd8kj4vkiWL
 kp3aOH4fwyT1artghMAczyitwYGcEUdFeORqKN5czrpMODI1Cd0/JJxrjUYOgpo9vjFP
 LDBO7r9YoTbrdBl7XGSKcXxLKMPe2RnuJu61hJ5xrfjUkiMJwb6of0+mhs8fh8IsXtbP
 lGWk1TSXrLnKosR8rce6sJUvqHE3j6pk2QfSztPIMlqEggJCkjCMnEzZDqMWnSlzZu4n
 2BM1hWLPE7K2pVGEIVusAsw7GgbMMztwcZ6+as8pkIUlF60wADK+lzgZIGNMnbfzw+Zr
 aNtA==
X-Gm-Message-State: AOAM5333uT8ZvM6NwscfQmfa2pWuBU33R4e4mjaGtOAmwaXcKipm/0pQ
 lwVg5MCG2TypvQWSmijfFGjH8n9n9g60PlkNpo4S0EitJhW7PJOjAwza+mTq8qW7uVzydLJG8w3
 XHWM9bGMsTWe0uiw=
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr25742843wrs.274.1599561301242; 
 Tue, 08 Sep 2020 03:35:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIy7uYoBtqFL3UIemtyusnK7nO0BvmyBIPClzK9vNyg5nPdUofEWx8OnRhJzxh6aEoO3WpEA==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr25742811wrs.274.1599561301022; 
 Tue, 08 Sep 2020 03:35:01 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d2sm14341332wro.34.2020.09.08.03.34.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2020 03:35:00 -0700 (PDT)
Subject: Re: [PATCH v4 1/7] usb/hcd-xhci: Make dma read/writes hooks pci free
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Sai Pavan Boddu <saipava@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?=27Marc-Andr=c3=a9_Lureau=27?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1598642380-27817-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1598642380-27817-2-git-send-email-sai.pavan.boddu@xilinx.com>
 <cefca93c-37d5-63b7-aff3-e6966d771892@redhat.com>
 <BY5PR02MB6772B6F211489F7E2A9D5CCDCA290@BY5PR02MB6772.namprd02.prod.outlook.com>
 <2330f661-2ef0-cfb5-4a05-8a2d43ab53e4@redhat.com>
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
Message-ID: <79ff4a95-d276-6681-6a06-9b8dc66de93f@redhat.com>
Date: Tue, 8 Sep 2020 12:34:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <2330f661-2ef0-cfb5-4a05-8a2d43ab53e4@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Vikram Garhwal <fnuv@xilinx.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Ying Fang <fangying1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/8/20 12:30 PM, Philippe Mathieu-Daudé wrote:
>>> On 8/28/20 9:19 PM, Sai Pavan Boddu wrote:
>>>> This patch starts making the hcd-xhci.c pci free, as part of this
>>>> restructuring dma read/writes are handled without passing pci object.
>>>>
>>>> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
>>>> ---
>>>>  hw/usb/hcd-xhci.c | 24 +++++++++++-------------  hw/usb/hcd-xhci.h |
>>>> 3 +++
>>>>  2 files changed, 14 insertions(+), 13 deletions(-)
>>>>
> [...]
>>>> --- a/hw/usb/hcd-xhci.h
>>>> +++ b/hw/usb/hcd-xhci.h
>>>> @@ -22,6 +22,8 @@
>>>>  #ifndef HW_USB_HCD_XHCI_H
>>>>  #define HW_USB_HCD_XHCI_H
>>>>
>>>> +#include "sysemu/dma.h"
>>>
>>> AddressSpace is forward-declared in "qemu/typedefs.h", so no need to
>>> include it here (yes in the sources including hcd-xhci.h).
>> [Sai Pavan Boddu] Yes you are right!, but without this " dma_addr_t " is undefined. 
>> At this point of the patch, hcd-xhci.h is compiled along with pci.h which would provide 'dma_addr_t', but when we strip the pci wrapper around hcd-xhci we would miss it. Let me know, if its good to add later in the patch series when the split happens.
> 
> OK :( I'd prefer to only include "sysemu/dma.h" in hw/usb/hcd-xhci.c.
> 
> Cc'ing David who added dma_addr_t in commit e5332e6334f
> ("iommu: Introduce IOMMU emulation infrastructure"), it
> might be simpler to move its declaration to "qemu/typedefs.h"
> too.

Btw this type should be poisoned for user-mode.

> 
> So no change needed for this patch.
> 
>>
>> Regards,
>> Sai Pavan
>>>
>>> With that fixed:
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>
>>>> +
>>>>  #define TYPE_XHCI "base-xhci"
>>>>  #define TYPE_NEC_XHCI "nec-usb-xhci"
>>>>  #define TYPE_QEMU_XHCI "qemu-xhci"
>>>> @@ -189,6 +191,7 @@ struct XHCIState {
>>>>
>>>>      USBBus bus;
>>>>      MemoryRegion mem;
>>>> +    AddressSpace *as;
>>>>      MemoryRegion mem_cap;
>>>>      MemoryRegion mem_oper;
>>>>      MemoryRegion mem_runtime;
>>>>
>>
> 


