Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F213AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6610F21D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ+6NXAw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6610F21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSlGe-0008QX-DF
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 14:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSlFP-0007VL-Iw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSlFN-00013Q-M8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 14:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602699091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRRNa0QGiEzekj8GyFnqt0jex7jlFdhelws3vCnnKLM=;
 b=jQ+6NXAwtZAw1rf4vV/uWXuXsYsNYewmRml0KueVCtuxK8TmBDquOvaytkT2ipE8PSPL8/
 mVHChA7FInYi5whFZAtn5VRT8geXSqC1xCjcYsbw3zqeIj98SoptSndnxQKFISgozBVzme
 xIwh9MYO1aWWG8PqszSQpJNdUxU4MJY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-c9ssr3yGObeKf2l_SOEm5A-1; Wed, 14 Oct 2020 14:11:27 -0400
X-MC-Unique: c9ssr3yGObeKf2l_SOEm5A-1
Received: by mail-wr1-f71.google.com with SMTP id t3so25591wrq.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 11:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uRRNa0QGiEzekj8GyFnqt0jex7jlFdhelws3vCnnKLM=;
 b=K4sAQrYxs1YRhrTCL8oIroFEfMSPdm156UKjDEMph38L1TcEgzBJBmgYKwKP8ogoMn
 Sjm+WWqtRnrjzEQ55+XHhL7VbW49D/gszUj/39dWV0UhwIqEOOeUWW+WeEYn3Dvr03t7
 KCEipiafRZCeILvU7TfV3WMEbH2e/NXtgVYS1+hMdkFByPJvmLQxn2513OZTagsavroS
 Hoyjkzeao+fPI0Zj6cN2IrT+soacaMBpkcTlmqrV7tOe9DqKHOF6AWAHjYbSF7tFVPEp
 sJV3gBZz8nQtSDrS3vvAqqRDSHNKa8L+Xh0hto1TExq6ulSVEg+NTrp54KeeobOr1mjR
 1oTw==
X-Gm-Message-State: AOAM533i1BQKaaUGknA9qJ16AguRMiPzI1NJsxFjin7FbCg2qPLIg8r7
 KBNXD/iENpS2xjpnw9ssEa/OQMhv2QA5opvwxkplCSuU04Z4EwxdnOFKxvksR9X5aqf0ReJhGhW
 piGJSlw+YT1afDoU=
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr118944wme.188.1602699085767; 
 Wed, 14 Oct 2020 11:11:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk368Es7UdBlmG21+R79L2Xb1ADp8nErpeuFjhM47eTuWBWbqrvEFUC9+9h3maC8zzqyorEA==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr118929wme.188.1602699085488; 
 Wed, 14 Oct 2020 11:11:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id 63sm124370wrh.71.2020.10.14.11.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 11:11:24 -0700 (PDT)
Subject: Re: [PATCH RESEND] pci: Disallow improper BAR registration for type 1
To: Ben Widawsky <ben.widawsky@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20201014171853.71130-1-ben.widawsky@intel.com>
 <20201014135146-mutt-send-email-mst@kernel.org>
 <20201014175651.52dfubrzfob2fv2o@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4bc6120a-dfc0-c0ba-f4b7-ce8744f5f045@redhat.com>
Date: Wed, 14 Oct 2020 20:11:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201014175651.52dfubrzfob2fv2o@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 7:56 PM, Ben Widawsky wrote:
> On 20-10-14 13:52:29, Michael S. Tsirkin wrote:
>> On Wed, Oct 14, 2020 at 10:18:53AM -0700, Ben Widawsky wrote:
>>> This patch informs future developers working on root complexes, root
>>> ports, or bridges that also wish to implement a BAR for those. PCI type
>>> 1 headers only support 2 base address registers. It is incorrect and
>>> difficult to figure out what is wrong with the device when this mistake
>>> is made. With this, it is immediate and obvious what has gone wrong.
>>>
>>> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>>
>> How about an assert + a comment?
>> This is how we usually handle developer bugs. error_report is
>> for user errors and similar issues ...
> 
> Sure, I can do that. I was copying the error above mine which should probably
> also be changed to an assert then, yes?
> 
> I can submit that as well with v2 of this if you'd like.

Yes, and please don't start with "This patch ...":

https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

> 
>>
>>> ---
>>>   hw/pci/pci.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 3c8f10b461..55b0302c57 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -1141,6 +1141,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
>>>       uint32_t addr; /* offset in pci config space */
>>>       uint64_t wmask;
>>>       pcibus_t size = memory_region_size(memory);
>>> +    uint8_t hdr_type;
>>>   
>>>       assert(region_num >= 0);
>>>       assert(region_num < PCI_NUM_REGIONS);
>>> @@ -1150,6 +1151,15 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
>>>           exit(1);
>>>       }
>>>   
>>> +    hdr_type =
>>> +        pci_dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_FUNCTION;
>>> +    if (hdr_type == PCI_HEADER_TYPE_BRIDGE && region_num > 1) {
>>> +        error_report("ERROR: PCI Type 1 header only has 2 BARs "
>>> +                     "requested BAR=%d",
>>> +                     region_num);
>>> +        exit(1);
>>> +    }
>>> +
>>>       r = &pci_dev->io_regions[region_num];
>>>       r->addr = PCI_BAR_UNMAPPED;
>>>       r->size = size;
>>> -- 
>>> 2.28.0
>>
> 


