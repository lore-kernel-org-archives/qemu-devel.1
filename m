Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CBCC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49E6521850
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E6521850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj19r-00086Q-E6
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42447)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hj17B-0006BN-QX
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hj179-0003MN-RS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:45:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hj176-00039O-N4
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:45:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so5619707wmj.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 05:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qcjPnzIcS3Fc6KlzPVNVPcgJAlqhxScqn5yKRSzpLsY=;
 b=CipPS+pD3TnDBHEg1bQV5dZ+wp+nqVnGzOPBhFTWQG+XMDWnir0ic8uBkyFktoX0zb
 OCmHes+tobgbvuJxn2tfo6uKul3ywd8ucPBaaMxV36jUA04LDi+DzsOSIbK2IfQCAiHF
 NUDmv+rSSHtdBQJ7Nm/2UKHobERwG8AGs4G1Ic2GhvTrsFw5QIQpNhJVWruCWGXQklSK
 XBnPJgHGeyyL88/x1FTpi+L2JpEuajWV+/NJOZYbz2AB9bWiXQHLKZ/66zXB5Vj1/oie
 24CElRUDBXBnGsCDabIzPosdOqxcU6T5YJfmZEXPu+Md8htsHkCPLENEr64uPfMm6guA
 gicg==
X-Gm-Message-State: APjAAAU4Rx6gPVYYJPathGGUjyX0HzHLqJl9mNOiZyCZRUxah5yQ4bdO
 vv/0+sYC9npBlbw1V/y4FMtHxg==
X-Google-Smtp-Source: APXvYqxDdWnhLZ1J5jYZi8CpC+s27OqYTudFBDYY9+dxsISitC30o68c7HbH8DLLA9nEwiutU+cEaA==
X-Received: by 2002:a05:600c:20ca:: with SMTP id
 y10mr12051931wmm.72.1562244316932; 
 Thu, 04 Jul 2019 05:45:16 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id h8sm5342521wmf.12.2019.07.04.05.45.15
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 04 Jul 2019 05:45:16 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Antony Pavlov <antonynpavlov@gmail.com>
References: <20190702005912.15905-1-philmd@redhat.com>
 <20190702005912.15905-28-philmd@redhat.com>
 <C6F80CB3-2D5D-4EE0-A085-DDA8AA334279@oberlin.edu>
 <05be219a-4af9-f939-3abe-6137f5a7deba@redhat.com>
 <3D8F6CD2-6C74-469C-83C1-3DF0A458B757@oberlin.edu>
 <e8d65586-63b0-0c43-a043-efd4a59b3834@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <9cf78fb6-e56c-8ebc-3158-34cdf8fa70e6@redhat.com>
Date: Thu, 4 Jul 2019 14:45:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e8d65586-63b0-0c43-a043-efd4a59b3834@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PULL 27/27] hw/block/pflash_cfi02: Reduce I/O
 accesses to 16-bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing PPC/taihu_405ep and ARM/Digic4 maintainers.

On 7/3/19 6:36 PM, Philippe Mathieu-Daudé wrote:
> On 7/3/19 6:20 PM, Stephen Checkoway wrote:
>>> On Jul 3, 2019, at 12:02, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>> On 7/3/19 5:52 PM, Stephen Checkoway wrote:
>>>>
>>>>
>>>>> On Jul 1, 2019, at 20:59, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>>>>
>>>>> Parallel NOR flashes are limited to 16-bit bus accesses.
>>>>
>>>> I don't think this is correct. The CFI spec defines an x32 interface for parallel NOR. CFI addresses 0x28 and 0x29 specify the interface and value 3 is x32 and value 5 is x16/x32.
>>>>
>>>> Here's an example of an x32 device <https://www.mouser.com/datasheet/2/100/002-00948_29CD032J_S29CD016J_S29CL032J_S29CL016J_3-1316792.pdf>.
>>>
>>> OK, I was not aware of these.
>>>
>>> QEMU never CFI-announced itself as x32 capable:
>>>
>>>    /* Flash device interface (8 & 16 bits) */
>>>    pfl->cfi_table[0x28] = 0x02;
>>>    pfl->cfi_table[0x29] = 0x00;
>>>
>>> So while the commit description is incorrect, the code is safe with the
>>> current device model.
>>>
>>> I am not comfortable keeping untested 32-bit mode.
>>> Were you using it?
>>
>> I'm not using it. I did have some code to set these CFI values based on the parameters used to control the interleaving <https://github.com/stevecheckoway/qemu/commit/f9a79a6e18b2c7c5a05e344ff554a7d980a56042#diff-d33881bd0ef099e2f46ebd4797c653bcR599>.
>>
>> In general, a better testing harness would be nice though.
> 
> We can revert it if it helps you.

So after further analysis, there are not guest visible changes, because
32-bit accesses are still valid (.valid.max_access_size = 4) but now
they are processed as two 16-bit accesses, shifted by
access_with_adjusted_size().
Well, I haven't checked (yet) when the guest and the flash are in
different endianess, and I wish we don't use that.

Now I see 2 different guests "registering" the flash in 32-bit access:

- PPC/taihu_405ep

  The CFI id matches the S29AL008J that is a 1MB in x16, while the code
  QEMU forces it to be 2MB, and checking Linux it expects a 4MB flash
  there, Yay \o/

- ARM/Digic4

  While the comment says "Samsung K8P3215UQB 64M Bit (4Mx16)", this
  flash is 32Mb (2MB). Also note the CFI id does not match the comment.
  Again, Yay.

Anyway, better safe than sorry, so I'll revert.

Thanks for following and catching this,

Phil.

[...]
>>>>> Remove the 32-bit dead code.
>>>>>
>>>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>>>> Message-Id: <20190627202719.17739-29-philmd@redhat.com>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>> ---
>>>>> hw/block/pflash_cfi02.c | 5 +----
>>>>> 1 file changed, 1 insertion(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
>>>>> index 83084b9d72..5392290c72 100644
>>>>> --- a/hw/block/pflash_cfi02.c
>>>>> +++ b/hw/block/pflash_cfi02.c
>>>>> @@ -317,8 +317,6 @@ static uint64_t pflash_read(void *opaque, hwaddr offset, unsigned int width)
>>>>>    boff = offset & 0xFF;
>>>>>    if (pfl->width == 2) {
>>>>>        boff = boff >> 1;
>>>>> -    } else if (pfl->width == 4) {
>>>>> -        boff = boff >> 2;
>>>>>    }
>>>>>    switch (pfl->cmd) {
>>>>>    default:
>>>>> @@ -449,8 +447,6 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>>>>>    boff = offset;
>>>>>    if (pfl->width == 2) {
>>>>>        boff = boff >> 1;
>>>>> -    } else if (pfl->width == 4) {
>>>>> -        boff = boff >> 2;
>>>>>    }
>>>>>    /* Only the least-significant 11 bits are used in most cases. */
>>>>>    boff &= 0x7FF;
>>>>> @@ -710,6 +706,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
>>>>> static const MemoryRegionOps pflash_cfi02_ops = {
>>>>>    .read = pflash_read,
>>>>>    .write = pflash_write,
>>>>> +    .impl.max_access_size = 2,
>>>>>    .valid.min_access_size = 1,
>>>>>    .valid.max_access_size = 4,
>>>>>    .endianness = DEVICE_NATIVE_ENDIAN,
>>>>> -- 
>>>>> 2.20.1

