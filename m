Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71756C432C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 10:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3762075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 10:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3762075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iazdx-0007hw-Tv
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 05:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iazcf-0006tW-0P
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <a13xp0p0v88@gmail.com>) id 1iazcc-0002BQ-AH
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 05:05:04 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <a13xp0p0v88@gmail.com>)
 id 1iazcX-00024A-Ay; Sat, 30 Nov 2019 05:04:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so22463012lfp.8;
 Sat, 30 Nov 2019 02:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=iC10XA6B8Wvw8Ud9BZWTOyn5shxMYd+dnZup3O3qxII=;
 b=MfTx2WeX74GzUm8ITOvuiO0P8uYNDzSRCWGRNp6bmxJwUaaCYgsQXPVNyoIlp6jjD+
 3Ea8S+AFS18boFeDiVtXx5SSHauTyuIJSWNv7NTJq44n+7WfENokuETy5V6a8o8t5WLt
 CWbwz9nzcvmankWlXtyUx0Ea8j4B625ME4bu99j8ySV49h1+BE2gFHO0fSRWmwgzaKce
 3L4yqdROe8KIIQi0WJAiRKWnaOLhoZ7Us0nIkJr+MpyacYh7lAc3zgmUpUkE538rx/7G
 nZryscCQfVKWTfj429fgjba+17A1v+JKDAo5In9knAmXpvjJPMN3nY0x/Frwc9VVu24I
 Ntag==
X-Gm-Message-State: APjAAAWC7y/a2QfkvINfiBgnO8DnaR/9Vpn072uSVBiE00+UKl43YR+a
 R7m8WyR6JxDikh/WGpl5Zrg=
X-Google-Smtp-Source: APXvYqxssNY0tby6bPldjYG6PVEgKApsV/wVlOlNDdwSPOicCerRlUs5nSc5dBrbeGO6aZW4uzupag==
X-Received: by 2002:ac2:5216:: with SMTP id a22mr37304153lfl.18.1575108295214; 
 Sat, 30 Nov 2019 02:04:55 -0800 (PST)
Received: from [192.168.1.183] (128-68-70-109.broadband.corbina.ru.
 [128.68.70.109])
 by smtp.gmail.com with ESMTPSA id q8sm3617904lfk.33.2019.11.30.02.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2019 02:04:53 -0800 (PST)
Subject: Re: [PATCH v2 1/1] ide: check DMA transfer size in ide_dma_cb() to
 prevent qemu DoS from quests
To: Kevin Wolf <kwolf@redhat.com>
References: <20191114172531.10644-1-alex.popov@linux.com>
 <20191121150352.GH6007@linux.fritz.box>
 <214785dc-d4b3-598f-4c48-c5703a28b8c4@linux.com>
 <20191126220936.GF5889@linux.fritz.box>
From: Alexander Popov <alex.popov@linux.com>
Autocrypt: addr=alex.popov@linux.com; prefer-encrypt=mutual; keydata=
 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
 j3lCqPk=
Message-ID: <27638c9e-a63c-b7e0-dfad-b2e463be61d0@linux.com>
Date: Sat, 30 Nov 2019 13:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126220936.GF5889@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.67
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
Reply-To: alex.popov@linux.com
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Kashyap Chamarthy <kashyap.cv@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27.11.2019 01:09, Kevin Wolf wrote:
> Am 26.11.2019 um 22:24 hat Alexander Popov geschrieben:
>> Hello Kevin,
>>
>> Thanks for your review,
>>
>> On 21.11.2019 18:03, Kevin Wolf wrote:
>>> Am 14.11.2019 um 18:25 hat Alexander Popov geschrieben:
>>>> The commit a718978ed58a from July 2015 introduced the assertion which
>>>> implies that the size of successful DMA transfers handled in ide_dma_cb()
>>>> should be multiple of 512 (the size of a sector). But guest systems can
>>>> initiate DMA transfers that don't fit this requirement.
>>>>
>>>> PoC for Linux that uses SCSI_IOCTL_SEND_COMMAND to perform such an ATA
>>>> command and crash qemu:
>> ...
>>>
>>> It would be nicer to turn the reproducer into a test case for
>>> tests/ide-test.c.
>>
>> Yes, I can do that.
>>
>>>> For fixing that let's check the number of bytes prepared for the transfer
>>>> by the prepare_buf() handler. If it is not a multiple of 512 then end
>>>> the DMA transfer with an error.
>>>>
>>>> That also fixes the I/O stall in guests after a DMA transfer request
>>>> for less than the size of a sector.
>>>>
>>>> Signed-off-by: Alexander Popov <alex.popov@linux.com>
>>>
>>> This patch makes ide-test fail:
>>>
>>>   TEST    check-qtest-x86_64: tests/ide-test
>>> **
>>> ERROR:tests/ide-test.c:469:test_bmdma_short_prdt: assertion failed (status == 0): (0x00000004 == 0x00000000)
>>> ERROR - Bail out! ERROR:tests/ide-test.c:469:test_bmdma_short_prdt: assertion failed (status == 0): (0x00000004 == 0x00000000)
>>
>> Thanks for the notice.
>> Yes, I can reproduce it too with `make check-qtest-i386`.
>>
>>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>>> index 754ff4dc34..85aac614f0 100644
>>>> --- a/hw/ide/core.c
>>>> +++ b/hw/ide/core.c
>>>> @@ -849,6 +849,7 @@ static void ide_dma_cb(void *opaque, int ret)
>>>>      int64_t sector_num;
>>>>      uint64_t offset;
>>>>      bool stay_active = false;
>>>> +    int32_t prepared = 0;
>>>>  
>>>>      if (ret == -EINVAL) {
>>>>          ide_dma_error(s);
>>>> @@ -892,12 +893,10 @@ static void ide_dma_cb(void *opaque, int ret)
>>>>      n = s->nsector;
>>>>      s->io_buffer_index = 0;
>>>>      s->io_buffer_size = n * 512;
>>>> -    if (s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size) < 512) {
>>>> -        /* The PRDs were too short. Reset the Active bit, but don't raise an
>>>> -         * interrupt. */
>>>> -        s->status = READY_STAT | SEEK_STAT;
>>>> -        dma_buf_commit(s, 0);
>>>> -        goto eot;
>>>> +    prepared = s->bus->dma->ops->prepare_buf(s->bus->dma, s->io_buffer_size);
>>>> +    if (prepared % 512) {
>>>> +        ide_dma_error(s);
>>>
>>> Which I assume is because you changed the error mode here compared to
>>> the old version.
>>
>> Yes, you are right.
>>
>>> I'm not sure offhand what the correct behaviour is for non-aligned
>>> values > 512. I think we actually have two cases here: Either a short or
>>> a long PRD. The commit message should explain this with spec references
>>> and a test case should be added for both cases.
>>
>> I've found the "Programming Interface for Bus Master IDE Controller" (revision
>> 1.0 5/16/94). The chapter 3.1 (Status Bit Interpretation) provides some answers.
> 
> Yes, I think that's the same that I've used before. I assume it's the
> relevant spec.
> 
>> It says that:
>>   1. If PRD's specified a smaller size than the IDE transfer size, then the
>> Interrupt and Active bits in the Controller status register are not set.
> 
>>   2. If the size of the physical memory regions was larger than the IDE device
>> transfer size, the Interrupt and Active bits in the Controller status register
>> are both set to 1.
>>
>> So my changing of the error mode in short PRD's case was wrong, and the
>> test_bmdma_short_prdt() is correct.
> 
> Yes, I think 1. is implemented correctly for PRDs that are too small and
> smaller than a sector.
> 
> I think the assumption may have been that if the PRDT contains at least
> one more full sector, we'll do that one sector before coming back to the
> same place and hitting the code path for a too short PRDT.
> 
> However, the code neglects to actually use the return value of
> .prepare_buf() to limit the number of sectors accessed. So if we ask for
> a scatter/gather list for 5 sectors and we get 3 sectors, we still
> assume we can write to all 5. This is obviously wrong.
> 
>> Now let's think about the proper fix of the qemu crash.
>>
>> Currently I don't really understand how ide_dma_cb() emulates the logic
>> described in Status Bit Interpretation chapter. I don't see any comparison
>> between the DMA transfer size and PRD's size.
>>
>> We only have this check against the size of a sector (512 bytes), which doesn't
>> catch all short PRD's cases (PRD in my PoC is 1337 bytes).
> 
> I think for making the above assumption work, we'd have to check the
> return value, which gets us something like:
> 
>     ret = s->bus->dma->ops->prepare_buf()
>     if (ret < 512) {
>         ... short PRDT code ...
>     } else if (ret < n * 512) {
>         n = ret / 512;
>     }
> 
> Instead of doing the extra iteration and executing I/O for the first
> part of the request, maybe this would work, too:
> 
>     ret = s->bus->dma->ops->prepare_buf()
>     if (ret < n * 512) {
>         ... short PRDT code ...
>     }
> 
> We need to check in the spec whether we're supposed to actually do
> partial I/O for short PRDTs. I couldn't find a clear answer with a quick
> look, but I'm leaning towards doing the partial I/O (i.e. implementing
> the first pseudo-code piece above).
> 
> 
> As for handling long PRDTs, we have code that looks like it's meant to
> handle the case:
> 
>     n = s->io_buffer_size >> 9;
>     if (n > s->nsector) {
>         /* The PRDs were longer than needed for this request. Shorten them so
>          * we don't get a negative remainder. The Active bit must remain set
>          * after the request completes. */
>         n = s->nsector;
>         stay_active = true;
>     }
> 
> bmdma_prepare_buf() does potentially set s->io_buffer_size to a value
> larger than the passed limit, so maybe this is already correct. We have
> a basic test for it in test_bmdma_long_prdt(), but I can't rule out that
> there are more complicated cases where it fails.
> 
> I'm pretty sure we must handle the long PRDT case only after doing I/O
> (like we currently do) because the operation is supposed to have
> completed by the time we signal that the PRDT was long, so the guest can
> trust that a read has actually read something and a write has reached
> the disk. The spec says "This is a valid completion case".
> 
> 
> Does this make sense to you?

Thanks a lot, Kevin!

First of all I'll improve the unit-tests to cover all cases.

Then I'll try both approaches you described and return with the results.

I'll also try to find more info about partial I/O behavior in other datasheets.

Best regards,
Alexander

