Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B10C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFA02084D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnZgNU3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFA02084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2bL-0000Lc-7G
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in2ai-0008OH-Tr
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in2ah-0005Ji-F1
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:40:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53920
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in2ah-0005JX-BZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577979650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a6b6QKEvSPVcShq3bkVlAsf2XOlFPFInyMvZJ5Rh8oY=;
 b=NnZgNU3S6SvowyysZ4/CPrV9O30eOUSCnrEhpN3ZMdfiVy5ue3d+v65aOHv/RSZgMpWc1R
 Pk1G1Ok1AQXxWBw7ZXWilWDepft7Vp1iw08o4tVBadFkjs+XG8wrvXexjHHk4n/+jBtQws
 Fl1ln26vFRcodlZGi01uZWZi/RTNjj8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-G8r5o2udPhiDJQl4QtCFcA-1; Thu, 02 Jan 2020 10:40:49 -0500
Received: by mail-wm1-f69.google.com with SMTP id p5so493469wmc.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 07:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FV4G2WIu23L423uwXlUDO73EBerzI1O1ss/bfgv2bxY=;
 b=hEt6zQ60QaNEBx9wl/E9V74lc9RlnPOzHns1IcEVe44nmR8GGz7f9MLrroMQ6WEA47
 tghB91Q6QB88HpyjDTFFFiCPfqRftMlq9s2f1LZkjAw32N88HG5I6sOgYjUIKhWq0qKV
 SSjT2IzwngCRZmMMSIpbK9XLGy90a+NzOTYd53nbLmpr+cfzHX/9LF5aINqeFO0je+5e
 sEh0WjzpDfLYYu5SFppHpdGuXSL28LcGr9ZW23/FaaCsuAEah8KvVReZAjtL9BapnQ+f
 XuYyVcWMAyIqJSYUpXwoRto6MrY4ji9i8L2/vzE/VA0/+FrhRZXm4bY55sSWwxs7PbW0
 pp5A==
X-Gm-Message-State: APjAAAV2tmQPTy0RYU474cWOGbqVlM8P0HjtpXHUbtRPkcf4vxQtRmIB
 7+xziM5auJOKxfDnW3oYbZbRj8FjRf/96+ojg7tp2xqKhWZFWxFKeVaVcmuT1BPEa9QTRLe0F/e
 2I+LV8TZCmNpH7F0=
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr15046942wmm.97.1577979648431; 
 Thu, 02 Jan 2020 07:40:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoKNKScxwwDYPFoUzdmq8zlW0iQA2m0H925gCEIP8ccbWzXT33uMBlEfar7YS6imUhad62lg==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr15046923wmm.97.1577979648170; 
 Thu, 02 Jan 2020 07:40:48 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id h17sm59456242wrs.18.2020.01.02.07.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 07:40:47 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <20200102154158.460b2da6@redhat.com>
 <2953de56-4544-1727-3454-18dc1c19821b@redhat.com>
 <20200102163518.54c36d68@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0324de61-9999-45e5-58c8-b2c9eab3de49@redhat.com>
Date: Thu, 2 Jan 2020 16:40:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102163518.54c36d68@redhat.com>
Content-Language: en-US
X-MC-Unique: G8r5o2udPhiDJQl4QtCFcA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 4:35 PM, Igor Mammedov wrote:
> On Thu, 2 Jan 2020 15:45:55 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/2/20 3:41 PM, Igor Mammedov wrote:
>>> On Thu, 2 Jan 2020 12:31:58 +0100
>>> Helge Deller <deller@gmx.de> wrote:
>>>   =20
>>>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>>>>> If user provided non-sense RAM size, board will complain and
>>>>>> continue running with max RAM size supported.
>>>>>> Also RAM is going to be allocated by generic code, so it won't be
>>>>>> possible for board to fix things up for user.
>>>>>>
>>>>>> Make it error message and exit to force user fix CLI,
>>>>>> instead of accepting non-sense CLI values.
>>>>>>
>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>>> ---
>>>>>>   =C2=A0 hw/hppa/machine.c | 3 ++-
>>>>>>   =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>>> index 5d0de26..25f5afc 100644
>>>>>> --- a/hw/hppa/machine.c
>>>>>> +++ b/hw/hppa/machine.c
>>>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machin=
e)
>>>>>>   =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
>>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ra=
m_size =3D FIRMWARE_START;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size m=
ore than %d is not supported", FIRMWARE_START);
>>>>>> +        exit(EXIT_FAILURE);
>>>>>
>>>>> $ qemu-system-hppa -m 3841m
>>>>> qemu-system-hppa: invalid accelerator kvm
>>>>> qemu-system-hppa: falling back to tcg
>>>>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>>>>
>>>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned forma=
t, we can simply use "RAM size more than 3840m is not supported". Is that O=
K with you?
>>>>
>>>> I don't really like that change.
>>>>
>>>> We currently only emulate a 32-bit system, and for those 4GB is the ma=
ximum.
>>>> So, if I start my machine with "qemu-system-hppa -m 4G", the current c=
ode
>>>> then automatically uses the maximum possible of 3841MB (which is limit=
ed by
>>>> firmware start address).
>>>> I don't expect users to know the excact 3841MB number.
>>> It's annoying to see a error where it used to work before
>>> with no matter what -m value user have used.
>>>
>>> But error message tells exact max size one could use,
>>> so user doesn't have to know max, just fix CLI with provided value.
>>>   =20
>>>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or=
 4GB,
>>>> but not "3841MB".
>>>>
>>>> So, I think that patch is - although it's more correct - not a
>>>> benefit for the end user.
>>> Sure thing that users dislike when we do breaking changes (removing leg=
acy CLI
>>> options, fixups or adding error checks that weren't there before).
>>> But I'd choose correctness (and consistent codebase) vs convenience.
>>> (it's no like we are hiding max from user)
>>
>> Going from 3841MB to 4GB is not a breaking change, and 4GB is correct I
> under breaking change, I've meant exit with error when it used to work wi=
th
> any values.
>=20
> But the point in removing fixups to make user aware of valid input and
> make clear what's going on when someone reads the code.
>=20
> QEMU code is already too complex to read, so I'd avoid supporting values
> that are not really supported by current impl. just for the sake of conve=
nience.
> (a wrapper script could do that RAM size clamping if it is really necessa=
ry)
>=20
>> think. The Raspberry Pi machines do the same (allocate more RAM than the
>> CPU is able to access, and DMA is able to use this extra RAM).
> In current impl. raspi accepts RAM upto 1Gb maps all of it and reports
> that size to the guest. QEMU doesn't mask or waste anything.
> If we where to rise limit upto 4Gb, then there should be the code that
> would inform and allow guest utilize that.

For the raspi2/3, 16MB are lost and we don't complain neither change the=20
ram_size, see the bcm2835-peripherals block overmapping the ram:

$ qemu-system-aarch64 -M raspi3 -monitor stdio -S
QEMU 3.1.1 monitor - type 'help' for more information
(qemu) info mtree
address-space: memory
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-000000003fffffff (prio 0, ram): ram
     000000003f000000-000000003fffffff (prio 1, i/o): bcm2835-peripherals
       000000003f007000-000000003f007fff (prio 0, i/o): bcm2835-dma
       000000003f00b200-000000003f00b3ff (prio 0, i/o): bcm2835-ic
       000000003f00b800-000000003f00bbff (prio 0, i/o): bcm2835-mbox
       000000003f104000-000000003f10400f (prio 0, i/o): bcm2835-rng
       000000003f200000-000000003f200fff (prio 0, i/o): bcm2835_gpio
       000000003f201000-000000003f201fff (prio 0, i/o): pl011
       000000003f202000-000000003f202fff (prio 0, i/o): bcm2835-sdhost
       000000003f215000-000000003f2150ff (prio 0, i/o): bcm2835-aux
       000000003f300000-000000003f3000ff (prio 0, i/o): sdhci
       000000003fe05000-000000003fe050ff (prio 0, i/o): bcm2835-dma-chan15
     0000000040000000-00000000400000ff (prio 0, i/o): bcm2836-control


