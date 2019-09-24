Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D2C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9211F20872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="Ryt7upiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9211F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCiwI-0007QX-D5
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 07:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1iCitP-0006sS-5d
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:22:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1iCitN-0002TO-MD
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:22:02 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:47792)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1iCitN-0002Sw-5U
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 07:22:01 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 581A096F50;
 Tue, 24 Sep 2019 11:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1569324118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+vtoew4dueRVmlHkPMMt5GlUyA2j/AX+NpBRj1zIHQ=;
 b=Ryt7upiTT5ZrOW6WqhDIYYaHFi0HAOI5b87gJcQIREJ0Zc2sVe0/1mm73xxdxDZUfg9mec
 rCR3xl8TZAuT4W2TGp62kNZNnn00bMExWiMEwmxEaj3khrBTyxw3OcpctId+t7mCGknylE
 I2LcZ4XY6pNrtxwLlDsGxB/0x4nERW8=
Subject: Re: [PATCH v4 02/10] hw/core: create Resettable QOM interface
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190821163341.16309-1-damien.hedde@greensocs.com>
 <20190821163341.16309-3-damien.hedde@greensocs.com>
 <20190911080642.GC13785@umbus.fritz.box>
 <1a3b4d7b-77a9-46af-e6f4-dc7b3ba13b4f@greensocs.com>
 <20190918091135.GA22790@umbus.fritz.box>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <f482912f-9541-f90c-bd80-5c95322e670d@greensocs.com>
Date: Tue, 24 Sep 2019 13:21:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190918091135.GA22790@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1569324118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+vtoew4dueRVmlHkPMMt5GlUyA2j/AX+NpBRj1zIHQ=;
 b=o6n2q11IK/KNe6pVW6lkUb4LzWUQPyuN3J/HbCYrHzGwBS1RLcx84wJqxQyRva027J+vxH
 QyN/qaHa8XbGA/bgqen0FGwOBxoyHI8eCRcv0TB5kToPaD6pnrdWYWT+Yn6yIpoJw4zdXM
 1AGFJja7k8BtCbXpRhtGb1uW3+lSjdc=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1569324118; a=rsa-sha256; cv=none;
 b=p8BOOWszDz94fNV8ybl43kc8a8V6l6NF77A3Tra7M0mazX377pXhjulo7B0DJAUcmcbr43
 hdZwZDW8FRf5K9EnXO6zvwyzbT4AgfjfTiScmTGnsuSgJUWZfjHIo35YUDPET9j0GhZB6Z
 xEhYEvzveA/DBDzxmFTLmNLWRuRAOv0=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, berrange@redhat.com,
 ehabkost@redhat.com, mark.burton@greensocs.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi All,

Do you think I should respin with the sugestions made by David so far ?

+ reset type removal
+ s/init/enter/ for the phases terminology
+ handling of parent changes during reset

On 9/18/19 11:11 AM, David Gibson wrote:
> On Wed, Sep 11, 2019 at 04:56:13PM +0200, Damien Hedde wrote:
>>
>>
>> On 9/11/19 10:06 AM, David Gibson wrote:
>>> On Wed, Aug 21, 2019 at 06:33:33PM +0200, Damien Hedde wrote:
>>>> This commit defines an interface allowing multi-phase reset. 
>>>
>>> So, I certainly prefer the more general "reset type" approach taken in
>>> this version.  That said, I find it pretty hard to imagine what types
>>> of reset other than cold will exist that have well enough defined
>>> semantics to be meaningfully used from an external subsystem.
>>
>> Maybe I should completely remove the type then ?
> 
> That makes sense to me.  I don't know if other possible users of the
> mechanism have different opinions though.
> 
>>>
>>>> +static void resettable_init_reset(Object *obj, ResetType type)
>>>
>>> I wonder if "enter reset" would be better terminology so this doesn't
>>> get confused with the initial, well, initialization of the device.
>>
>> Do you mean for the function here or in general for the name of the phase ?
> 
> In general.
> 
>>>> +    /*
>>>> +     * we could assert that count > 0 but there are some corner cases
>>>> +     * where we prefer to let it go as it is probably harmless.
>>>> +     * For example: if there is reset support addition between
>>>> +     * hosts when doing a migration. We may do such things as
>>>> +     * deassert a non-existing reset.
>>>> +     */
>>>> +    if (s->count > 0) {
>>>> +        s->count -= 1;
>>>> +    } else {
>>>> +        trace_resettable_count_underflow(obj);
>>>
>>> Should this be an assert(), IIUC this could only come about from an
>>> error within the qemu code, right?
>>
>> Initially I was thinking that so I put an assert.
>>
>> But while testing I found out that it is triggered by the raspi machine
>> during its reset because the qbus tree is modified during it.
>>
>> So it depends if we consider this kind of action to be faulty. With no
>> migration support, the only way to trigger it is to modify the qdev
>> hierarchy during reset.
> 
> Hm, I see.  It feels like just ignoring underflow is ignoring the
> error rather than really addressing it.  When we add a device to the
> heirarchy, do we need to initialize its reset count based on its
> parent's current count or something.
> 

I can add that.

Thanks,
--
Damien

