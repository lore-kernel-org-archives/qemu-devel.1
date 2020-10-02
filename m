Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C9AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CA3206DD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 19:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/TRIrwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CA3206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOQsV-0007Pn-1p
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 15:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kOQrl-0006x0-VD
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kOQri-0000K4-Vh
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 15:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601667433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n75bJuA2m99Fej8MnE25K+GTxsmFiqlcjOQPTPQ37lw=;
 b=Q/TRIrwUZzCICn7fBN24ziA6bKABim6cf1ycU7IOXFQhIgm7+bkzzA4dwDPY25v5shNF3u
 HFp+Inbaxuld3DJS5Uoy0VDJYnBPwk0Bae6yAXzSEHQjj+9HgbJ6k5BsXKXKPq0PBtNIIs
 pqlkdWEobQYTy/kSYs0JUtvBfPm6CAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-lIRCmPNfOueQHNqQKim9sQ-1; Fri, 02 Oct 2020 15:37:08 -0400
X-MC-Unique: lIRCmPNfOueQHNqQKim9sQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 517BE425F1;
 Fri,  2 Oct 2020 19:37:07 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 726285D9D3;
 Fri,  2 Oct 2020 19:37:06 +0000 (UTC)
Subject: Re: [PATCH] ide:do nothing for identify cmd if no any device attached
To: Max Reitz <mreitz@redhat.com>, zhaoxinRockCuioc <RockCui-oc@zhaoxin.com>, 
 qemu-devel@nongnu.org
References: <20200817033803.14014-1-RockCui-oc@zhaoxin.com>
 <8dbcc856-879a-af83-1a76-a2a875da3699@redhat.com>
 <0347935f-5235-3c61-07cc-fb4435ec45d1@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3fc6d5fa-c305-606a-5e8f-23e90eadd588@redhat.com>
Date: Fri, 2 Oct 2020 15:37:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0347935f-5235-3c61-07cc-fb4435ec45d1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, CobeChen@zhaoxin.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 6:40 AM, Max Reitz wrote:
> On 02.09.20 20:02, John Snow wrote:
>> (CC Max for block backend model confusion, see below)
>>
>> On 8/16/20 11:38 PM, zhaoxin\RockCuioc wrote:
>>> This patch is for avoiding win7 IDE driver polling 0x1f7 when
>>> no any device attached. During Win7 VM boot procedure, if use virtio for
>>> disk and there is no any device be attached on hda & hdb, the win7 IDE
>>> driver
>>> would poll 0x1f7 for a while. This action may be stop windows LOGO
>>> atomic for
>>> a while too on a poor performance CPU.
>>>
>>
>> A few questions:
>>
>> (1) How slow is the probing?
>>
>> (2) If there are no devices attached, why don't you remove the IDE
>> controller so that Windows doesn't have to probe it?
>>
>>> Signed-off-by: zhaoxin\RockCuioc <RockCui-oc@zhaoxin.com>
>>> ---
>>>    hw/ide/core.c | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index d997a78e47..26d86f4b40 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -2073,8 +2073,9 @@ void ide_exec_cmd(IDEBus *bus, uint32_t val)
>>>        s = idebus_active_if(bus);
>>>        trace_ide_exec_cmd(bus, s, val);
>>>    -    /* ignore commands to non existent slave */
>>> -    if (s != bus->ifs && !s->blk) {
> 
> (Was the first one basically meant to be “s != &bus->ifs[0]”, i.e. to
> check that this doesn’t go to the ma^W primary?  Not too obvious.)
> 

Yeah, I think it was meant to say:

if (s == bus->ifs[1] && !s->blk)

(But I don't know why it was important to guard device1 specifically. 
Knowledge lost to the sands of time.)

By the way, the correct terms are "device0" and "device1" and have been 
since at least ATA2. I believe ATA1 used the terms "disk0" and "disk1". 
"Primary" and "Secondary" are used to refer to the controllers, not the 
devices.

- Primary
   - device0
   - device1
- Secondary
   - device0
   - device1

Thanks for coming to my TED talk!

>>> +    /* ignore commands if no any device exist or non existent slave */
>>> +    if ((!bus->ifs[0].blk && !bus->ifs[1].blk) ||
>>> +        (s != bus->ifs && !s->blk)) {
> 
> (Maybe this could be improved here)
> 
>>>            return;
>>>        }
>>>    
>>
>> I think it's the case that Empty CD-ROM drives will have an anonymous
>> block backend representing the empty drive,
> 
> (As far as I remember,) yes.
> 
> (ide_dev_initfn() ensures all CD drives have one, even if it’s empty.)
> 

(Thanks)

>> so I suppose this is maybe
>> fine?
>>
>> I suppose the idea is that with no drives on the bus that it's fine to
>> ignore the register writes, as there are no devices to record those writes.
>>
>> (But then, why did we ever only check device1? ...)
>>
>> Maybe before the block-backend split we used to have to check to see if
>> we had attached media or not, but I think nowadays we should always have
>> a blk pointer if we have a device model intended to be operating at this
>> address.
> 
> The check in ide_dev_initfn() looks that way to me.
> 
>> So I guess it can be simplified ...?
>>
>> if (!s->blk) {
>>      return;
>> }
> 
> Probably.  Although there’s a difference, of course, namely if you have
> only a secondary device and try to access the primary, this simplified
> version will be a no-op, whereas the more complicated version in this
> patch would still go on.  I don’t know how real hardware would handle
> that case.  Is it even possible to have just a secondary with no primary?
> 

I think so. From what I understand, two drives on a single channel both 
receive all of the same register update commands, including the "SELECT" 
register, which has a bit devoted to which drive we have selected.

When we write to the COMMAND register, only the selective drive should 
actually respond to it.

so what I expect happens on real machines:

- You select device0
- You write to a bunch of registers
- You issue a command
- Nobody responds.

--js


