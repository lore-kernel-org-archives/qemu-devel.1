Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F08C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:04:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED9620872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 01:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED9620872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCvj6-0003tJ-2G
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 21:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ren_guo@c-sky.com>) id 1iCvhr-00035c-TN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ren_guo@c-sky.com>) id 1iCvhp-0003Gt-Ee
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 21:02:59 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56369)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ren_guo@c-sky.com>)
 id 1iCvhp-0003El-1w; Tue, 24 Sep 2019 21:02:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.004386386|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.532088-0.00754032-0.460371; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03302; MF=ren_guo@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.Fb-GL-z_1569373368; 
Received: from 192.168.123.159(mailfrom:ren_guo@c-sky.com
 fp:SMTPD_---.Fb-GL-z_1569373368)
 by smtp.aliyun-inc.com(10.147.41.138);
 Wed, 25 Sep 2019 09:02:48 +0800
Subject: Re: [PATCH V2] target/riscv: Bugfix reserved bits in PTE for RV64
To: Alistair Francis <alistair23@gmail.com>
References: <1569311902-12173-1-git-send-email-guoren@kernel.org>
 <CAKmqyKMzpTKBT+urX_7qFASqcAd4kkfJmf6LUk-0V=0LOuHLxw@mail.gmail.com>
 <8E7A78A5-5E6F-49A2-89BC-85D2506229C6@c-sky.com>
 <CAKmqyKPAnb1bb+v=+v_jHmA58bRjmUqO9XcZbLyxsUX1udtXBQ@mail.gmail.com>
From: Guo Ren <ren_guo@c-sky.com>
Message-ID: <872a2987-1dd5-d9fe-e80a-386eb3d68a23@c-sky.com>
Date: Wed, 25 Sep 2019 09:02:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKPAnb1bb+v=+v_jHmA58bRjmUqO9XcZbLyxsUX1udtXBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, guoren@kernel.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

在 2019/9/25 上午8:21, Alistair Francis 写道:
> On Tue, Sep 24, 2019 at 5:13 PM Guo Ren <ren_guo@c-sky.com> wrote:
>>
>>
>>> 在 2019年9月25日，上午7:33，Alistair Francis <alistair23@gmail.com> 写道：
>>>
>>> On Tue, Sep 24, 2019 at 12:58 AM <guoren@kernel.org> wrote:
>>>>
>>>> From: Guo Ren <ren_guo@c-sky.com>
>>>>
>>>> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
>>>> need to ignore them. They can not be a part of ppn.
>>>>
>>>> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>>>>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>>>>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>>>
>>> Thanks for the patch!
>>>
>>> The spec says "must be zeroed by software for forward compatibility"
>>> so I don't think it's correct for QEMU to zero out the bits.
>> QEMU don’t zero out the bits, QEMU just ignore the bits for ppn.
> 
> Yes, from reading the spec that seems to be the correct behaviour.
Thank you very much :)

> 
>>
>>>
>>> Does this fix a bug you are seeing?
>> Yes, because we try to reuse these bits as attributes.
> 
> That isn't really a bug then, the spec says not to do that.
Yes, I'll change the tile that "Ignore reserved bits in PTE for RV64"

> 
>>
>>>
>>>>
>>>> Changelog V2:
>>>> - Bugfix pte destroyed cause boot fail
>>>> - Change to AND with a mask instead of shifting both directions
>>>
>>> The changelog shouldn't be in the commit, it should be kept under the
>>> line line below.
>> I just prefer to save them in commit.
> 
> Fair, but in QEMU we don't commit the change log in the commit.
Ok.

> 
>>
>>>
>>>>
>>>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>>>> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
>>>> ---
>>>
>>> The change log should go here.
>> OK, but git am we’ll lose them.
>>
>>>
>>>> target/riscv/cpu_bits.h   | 3 +++
>>>> target/riscv/cpu_helper.c | 3 ++-
>>>> 2 files changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>>> index e998348..ae8aa0f 100644
>>>> --- a/target/riscv/cpu_bits.h
>>>> +++ b/target/riscv/cpu_bits.h
>>>> @@ -470,6 +470,9 @@
>>>> #define PTE_D               0x080 /* Dirty */
>>>> #define PTE_SOFT            0x300 /* Reserved for Software */
>>>>
>>>> +/* Reserved highest 10 bits in PTE */
>>>> +#define PTE_RESERVED        ((target_ulong)0x3ff << 54)
>>>
>>> I think it's just easier to define this as 0xFFC0000000000000ULL and
>>> remove the cast.
>> OK follow your rule, but I still prefer prior.
>>
>>>
>>>> +
>>>> /* Page table PPN shift amount */
>>>> #define PTE_PPN_SHIFT       10
>>>>
>>>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>>> index 87dd6a6..7a540cc 100644
>>>> --- a/target/riscv/cpu_helper.c
>>>> +++ b/target/riscv/cpu_helper.c
>>>> @@ -258,10 +258,11 @@ restart:
>>>>          }
>>>> #if defined(TARGET_RISCV32)
>>>>          target_ulong pte = ldl_phys(cs->as, pte_addr);
>>>> +        hwaddr ppn = pte >> PTE_PPN_SHIFT;
>>>> #elif defined(TARGET_RISCV64)
>>>>          target_ulong pte = ldq_phys(cs->as, pte_addr);
>>>> +        hwaddr ppn = (pte & ~PTE_RESERVED) >> PTE_PPN_SHIFT;
>>>> #endif
>>>> -        hwaddr ppn = pte >> PTE_PPN_SHIFT;
>>>
>>> You don't have to move this shift
>> En… Do you want this: ?
>>
>> #if defined(TARGET_RISCV32)
>>          target_ulong pte = ldl_phys(cs->as, pte_addr);
>> +      hwaddr ppn = pte;
>> #elif defined(TARGET_RISCV64)
>>           target_ulong pte = ldq_phys(cs->as, pte_addr);
>> +       hwaddr ppn = (pte & ~PTE_RESERVED);
>> #endif
>> +        ppn = ppn >> PTE_PPN_SHIFT;
>>
> 
> Yeah, it seems a little cleaner.
:)

Best Regards
  Guo Ren

