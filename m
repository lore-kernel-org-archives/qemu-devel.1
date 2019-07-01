Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2252C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF9520659
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 09:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqjMh6YU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF9520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhsSx-0004Da-71
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 05:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45581)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhsMm-0007Eo-Ex
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcel.apfelbaum@gmail.com>) id 1hhsMl-0000dd-4j
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:12:52 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1hhsMk-0000d2-SH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 05:12:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so12901518wrt.6
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 02:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:cc:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=3l4lK0DihfH9nlvEcwn7t+55gQ69F9MGIGsnOyRnYqc=;
 b=FqjMh6YU/5MGdoE932BiK9FVNDCXhvsLtHKNRCBYivylD8uI+HSt+nzSEs+TORYkSC
 hLbeF5laRbrjEPq+1TZXUY5BXFy2zaFkEor+q/krRYuKAP4xoPc3NvjZklewpftDigy1
 rN0G1ZxKClaB8oIK/FgTWT+xAY5SmlfI0NdVuDPrQ4JsjAQolCp0aEUD4rx3eN8FaKxf
 Y5CA4ySDrHIImkftPdu80GXzKMuO124veiXj/EIaIgvX+bSZ6Owpp8d03oL09K8DMwzP
 KvGyeERjZDfK1sBZ0igLR5EdzDwwG9lX5Zr+LdxEibocI3LKZFButr9/FOQFrTCT6Kpn
 4kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3l4lK0DihfH9nlvEcwn7t+55gQ69F9MGIGsnOyRnYqc=;
 b=pISb4WqyZScO2wRv6e5aDWovHlBmN2v81swPcVZqrsq2jZopIPc2wct8KJOUqGV5kX
 CUYqEvmiY4l+4wdKt+P9z3RUEGRFQZQHjlueLBQ6WvicU9Kkka8FoZpsb4JIdV84eEY6
 tFqrbRKpKmdn7lBXEAN5OAhQvIf1GjpRRFva2dctAHOHHuzF0hZ4HYpIImmWF/gY3R4R
 mYLbK9R2aSE1tdUZmtMJv6OhgaqaHAv/L0Kwcggv559NJ9opJIz/9fHUOVMdrwIhGQD1
 haJmwRA0D7yiZxC082hmdXDhmmzaNWbHfDYsVnGKk0rH8KOydCqI2z5WnYvQfQpP5wPJ
 jJ1A==
X-Gm-Message-State: APjAAAWxrTELdNl62BZqHmK53igxENYtMBTjS8/7HxMndTRcrvsl4cQ+
 sc0pWsuve8/AIgNSojNBx5+aDU2x
X-Google-Smtp-Source: APXvYqwo0CEoav/1gIJOXj1L4voccUoymwflk37H9GK9H508Qsj0ctLIJ1FAUvFAIjYctzHDR35p8g==
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr4507872wrw.323.1561972369706; 
 Mon, 01 Jul 2019 02:12:49 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.12])
 by smtp.gmail.com with ESMTPSA id h15sm5884822wrp.17.2019.07.01.02.12.48
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 02:12:49 -0700 (PDT)
To: Igor Mammedov <imammedo@redhat.com>
References: <20190621064615.20099-1-mst@redhat.com>
 <20190621064615.20099-4-mst@redhat.com>
 <4e4314f7-91cc-1413-9853-bfd2bbb26311@gmail.com>
 <20190701105708.5d28f497@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <039d8321-bbe3-66ed-e64d-5a64c402990c@gmail.com>
Date: Mon, 1 Jul 2019 12:13:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701105708.5d28f497@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 3/3] pcie: work around for racy guest init
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CCing qemu-devel

On 7/1/19 11:57 AM, Igor Mammedov wrote:
> On Mon, 1 Jul 2019 10:04:01 +0300
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> wrote:
>
>> On 6/21/19 9:46 AM, Michael S. Tsirkin wrote:
>>> During boot, linux guests tend to clear all bits in pcie slot status
>>> register which is used for hotplug.
>>> If they clear bits that weren't set this is racy and will lose events:
>>> not a big problem for manual hotplug on bare-metal, but a problem for us.
>>>
>>> For example, the following is broken ATM:
>>>
>>> /x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
>>>       -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
>>>       -device virtio-balloon-pci,id=balloon,bus=pcie_root_port_0 \
>>>       -monitor stdio disk.qcow2
>>> (qemu)device_del balloon
>>> (qemu)cont
>>>
>>> Balloon isn't deleted as it should.
>>>
>>> As a work-around, detect this attempt to clear slot status and revert
>>> status to what it was before the write.
>>>
>>> Note: in theory this can be detected as a duplicate button press
>>> which cancels the previous press. Does not seem to happen in
>>> practice as guests seem to only have this bug during init.
>>>
>>> Note2: the right thing to do is probably to fix Linux to
>>> read status before clearing it, and act on the bits that are set.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>    hw/pci/pcie.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
>>> index f8490a00de..c605d32dd4 100644
>>> --- a/hw/pci/pcie.c
>>> +++ b/hw/pci/pcie.c
>>> @@ -610,6 +610,25 @@ void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_s
>>>        uint16_t sltsta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
>>>    
>>>        if (ranges_overlap(addr, len, pos + PCI_EXP_SLTSTA, 2)) {
>>> +        /*
>>> +         * Guests tend to clears all bits during init.
>>> +         * If they clear bits that weren't set this is racy and will lose events:
>>> +         * not a big problem for manual button presses, but a problem for us.
>>> +         * As a work-around, detect this and revert status to what it was
>>> +         * before the write.
>>> +         *
>>> +         * Note: in theory this can be detected as a duplicate button press
>>> +         * which cancels the previous press. Does not seem to happen in
>>> +         * practice as guests seem to only have this bug during init.
>>> +         */
>>> +#define PCIE_SLOT_EVENTS (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD | \
>>> +                          PCI_EXP_SLTSTA_MRLSC | PCI_EXP_SLTSTA_PDC | \
>>> +                          PCI_EXP_SLTSTA_CC)
>>> +
>>> +        if (val & ~slt_sta & PCIE_SLOT_EVENTS) {
>>> +            sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
>>> +            pci_set_word(exp_cap + PCI_EXP_SLTSTA, sltsta);
>>> +        }
>>>            hotplug_event_clear(dev);
>>>        }
>>>      
>> Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Hi Marcel,
>
> What about my question about
>     sltsta = (sltsta & ~PCIE_SLOT_EVENTS) | (slt_sta & PCIE_SLOT_EVENTS);
> being nop like
>     sltsta = LOWER_PART(sltsta) | UPPER_PART(sltsta)
>
> Can you point out what I'm missing here?

Oops, I missed that, maybe it should look like:

     if (...) {
       sltsta = (val & ~PCIE_SLOT_EVENTS) | (sltsta & PCIE_SLOT_EVENTS);
       ....
   }

to keep the PCIE_SLOT_EVENTS that were set before the write.


Thanks,
Marcel

>> Thanks,
>> Marcel
>>


