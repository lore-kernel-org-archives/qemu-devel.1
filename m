Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFA3C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185FE20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 07:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2bsBFG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185FE20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY36G-00082Q-8m
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 03:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY35g-0007dK-I8
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:43:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jY35f-0000cd-5B
 for qemu-devel@nongnu.org; Mon, 11 May 2020 03:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589182984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63Owy1DgNNS0fKAtxQfA9/6g1HMm+Q4uD1OvNlUIcIQ=;
 b=Y2bsBFG+d3IRnpGRwT3/Y7pfItFPSTi1urYUQrBflkUJSlOJmW28opM8L6eN7gWmccErW4
 8A565Fkp4L8maHHChy8xRMqrMaGDt+Zc6Gvj3+ddzF7RkLAs10mK0RWcTWAoerPHWDZppg
 r6vNUUmYmvxNUh01rr8QWLRO2tYuXw4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-w7n2PfzqPKaE81j5EfP5QQ-1; Mon, 11 May 2020 03:42:59 -0400
X-MC-Unique: w7n2PfzqPKaE81j5EfP5QQ-1
Received: by mail-wr1-f72.google.com with SMTP id f2so4842639wrm.9
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 00:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=63Owy1DgNNS0fKAtxQfA9/6g1HMm+Q4uD1OvNlUIcIQ=;
 b=t5Gb+2PAQwhf8Hme7pbkTq07UWdENksEX1HdU8jrq/T1Vrizgfhh2Dvd3CxvJCph7K
 WUUDzHJYoveDqivF8Gq7BC57wegRIpkvFGhmTnCPP8ccan/6/FWZ43KbP+MyalfAF73e
 BvoeqzYBmNutTU/K5xfy5DHUq+tHOQS6gt8B5pbuDhwOMrT+eM/0NG6hyv+vJVUAomBq
 q6Sww3gIoiyxE5geDlzYU9S4QlmwmqsTZGgtuqe8F8uvEfSkkiPyZQHgVhP7Jzf/r2sI
 CGfGKR4rk+0Suluh8aks2HemmWZXAqsnBVglj8Cfe4h9gCWF7/ObM1I+OaX0o4tplscH
 51bw==
X-Gm-Message-State: AGi0PuZaF9pKz79MCaTcuiXVlGC49sGIh0CD2eK10HQfToMnsoQ8wcsE
 IIFoxrH1R/zXC69YbQBEyg/j4crQnPBYw+htvdJnqXkO/pckfNMgrb/sCSwMoqEJJ4+mOP4M0hT
 b7/kaZg0R2+MLYPQ=
X-Received: by 2002:adf:f207:: with SMTP id p7mr17123575wro.20.1589182978764; 
 Mon, 11 May 2020 00:42:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypKKSJaP5cF669IqMnBHcVsBiN0MFUbAJRHXs3GQQcunTjN8A/7I4U8oSNAHmJj4GjOlQR1fmg==
X-Received: by 2002:adf:f207:: with SMTP id p7mr17123562wro.20.1589182978549; 
 Mon, 11 May 2020 00:42:58 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id k5sm15387981wrx.16.2020.05.11.00.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2020 00:42:57 -0700 (PDT)
Subject: Re: Abort in mch_update_pciexbar
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200511045912.keffhizkobgwqcag@mozz.bu.edu>
 <c6b66f8a-40e4-8ad5-afb4-09bddbcac529@redhat.com>
 <2344dc20-5c7f-75eb-96d2-bef0153550d6@redhat.com>
 <20200511033045-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <49e451a3-0cdf-39ba-db9c-c61af6a58492@redhat.com>
Date: Mon, 11 May 2020 09:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200511033045-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 02:55:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/11/20 9:39 AM, Michael S. Tsirkin wrote:
> On Mon, May 11, 2020 at 09:10:48AM +0200, Philippe Mathieu-DaudÃƒÂ© wrote:
>> On 5/11/20 8:19 AM, Philippe Mathieu-DaudÃƒÂ© wrote:
>>> On 5/11/20 6:59 AM, Alexander Bulekov wrote:
>>>> Hello,
>>>> While fuzzing, I found an input that triggers an assertion failure in
>>>> mch_update_pciexbar:
>>>>
>>>> #6 0x7f38d387c55a in abort
>>>> /build/glibc-GwnBeO/glibc-2.30/stdlib/abort.c:79:7
>>>> #7 0x55c27e94ffd0 in mch_update_pciexbar hw/pci-host/q35.c:331:9
>>>> #8 0x55c27e94db38 in mch_write_config hw/pci-host/q35.c:487:9
>>>> #9 0x55c27e9e3f4c in pci_host_config_write_common hw/pci/pci_host.c:81:5
>>>> #10 0x55c27e9e5307 in pci_data_write hw/pci/pci_host.c:118:5
>>>> #11 0x55c27e9e6601 in pci_host_data_write hw/pci/pci_host.c:165:9
>>>> #12 0x55c27ca3b17b in memory_region_write_accessor memory.c:496:5
>>>> #13 0x55c27ca3a5e4 in access_with_adjusted_size memory.c:557:18
>>>> #14 0x55c27ca38177 in memory_region_dispatch_write memory.c:1488:16
>>>> #15 0x55c27c721325 in flatview_write_continue exec.c:3174:23
>>>> #16 0x55c27c70994d in flatview_write exec.c:3214:14
>>>> #17 0x55c27c709462 in address_space_write exec.c:3305:18
>>>
>>> These lines don't match QEMU v5.0.0.
>>>
>>>>
>>>> I can reproduce it in a qemu 5.0 build using:
>>>> cat << EOF | ~/Development/qemu/build/i386-softmmu/qemu-system-i386
>>>> -M pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
>>>> outl 0xcf8 0xf2000060
>>>> outl 0xcfc 0x8400056e
>>>
>>> The guest shouldn't ask for a reserved bar length (grep for
>>> MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD). I suppose we should simply report
>>> it as GUEST_ERROR and ignore it.
>>
>> This patch prevent the crash:
>>
>> -- >8 --
>> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
>> index 2bbc90b28f..2b744aca93 100644
>> --- a/hw/pci-host/q35.c
>> +++ b/hw/pci-host/q35.c
>> @@ -36,6 +36,7 @@
>>   #include "qapi/error.h"
>>   #include "qapi/visitor.h"
>>   #include "qemu/module.h"
>> +#include "qemu/log.h"
>>
>>
>> /****************************************************************************
>>    * Q35 host
>> @@ -320,6 +321,9 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>>           addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
>>           break;
>>       case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid use of reserved
>> value\n",
>> +                                       __func__);
>> +        return;
>>       default:
>>           abort();
>>       }
> 
> Maybe report the value too.

This is a 2 bit field, all are covered except 0b11 which is the RESERVED 
case, and the abort() now will never fire. It is unclear why the 
compiler doesn't notice that.

> 
>> ---
>>
>> But the real question is what would the real hardware do in this case.
> 
> Spec doesn't say unfortunately. All it says is:
> 	Designers must not rely on the absence or characteristics of any
> 	features or instructions marked "reserved" or "undefined." Intel
> 	reserves these for
> 
> 	future definition and shall have no responsibility whatsoever
> 	for conflicts or incompatibilities arising from future changes to them.

OK, thanks for checking. I'll submit formal patch with proper description.

> 
>>>
>>>> EOF
>>>>
>>>> I also uploaded the above trace, in case the formatting is broken:
>>>>
>>>> curl https://paste.debian.net/plain/1146095 | qemu-system-i386 -M
>>>> pc-q35-5.0 -display none -nodefaults -nographic -qtest stdio
>>>>
>>>> Please let me know if I can provide any further info.
>>>
>>> It would help the community if you fill your bug reports with Launchpad,
>>> so they don't get lost in the high email flow, and we can track/update
>>> them. See for example:
>>> https://bugs.launchpad.net/qemu/+bug/1835865 and
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06082.html
>>> which refers it.
> 


