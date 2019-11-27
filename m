Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC774C43215
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753C32154A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5JTXqpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C32154A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia4iO-0004Fz-9z
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 16:19:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ia4gk-0003hd-C1
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ia4gY-0000ct-Q4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:17:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29092
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ia4gT-0000Vs-OC
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 16:17:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574889428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BgXJ6sEEgt0ldJKEETjNUW4qUf5kKMqt/6CwJVbU5rA=;
 b=c5JTXqpLr0h2u4PGL/Aotkg3O4JfCWqkLvZrOPzxcHZ+5SanaPlsbo0GSMkWxYIVt3inv9
 orX3tHpOVI7Wjkv2wAhinLYUnRQwzNXovn29O7UKXBCmrfhZzQ8shRQEsnwk/uSE1wqo4C
 JIuRw0jedZIG6KllZbVQsPqlMb1MGaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-r2UcojAaNI2yZOHxl50CDQ-1; Wed, 27 Nov 2019 16:17:05 -0500
Received: by mail-wm1-f71.google.com with SMTP id y14so2873737wmj.9
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 13:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eZuEw1qoxWBtvsPnYJcsSDxsm1VGNtQFgvEKHgCegbs=;
 b=TKjl5CSkf5mdcUAFEzxfljlXJnjSIfr25MZzV8FaiRtgAWMbQlv2iRAlo2KzHATwCh
 jZqz8Fi+9em5Q+E5XNPUdwuaGePWsNwOw0s3qbEbXk+F4rWIQ+uPVMRta5jRTwZaN/YX
 pJzssciM65DmaquoPKZ5L3r49bPZ2X9qUDdcU1mYObZiP38VIgLtnefQVEA8Hvtx9FHR
 weRjh69FtgZpqJnszBQ7VN2PJdo0VtR4/18bYT+lXVNZqRXgsOJCj1r/uxGdflNgWdDr
 ExLzGAvlyG3bg1xQ5D324WS2eDGKZeAgQCbd96m2Gh9sK5vuzzXzV24UMeBnk49SsPzo
 dKsg==
X-Gm-Message-State: APjAAAU+/qh+vY33+/dwRYeAvN9IEO5LwaJUWe1jaerfNHLw/hrOR1V2
 Kuqff7pkugDmce4Sm5CsnezDu2MmFbgCK5V5O0ws22zZN6Ltq0PM/9gKlxWxYIE0uknnFkvUvum
 T/tYfQSI09DttT0U=
X-Received: by 2002:a5d:6441:: with SMTP id d1mr1101433wrw.93.1574889424055;
 Wed, 27 Nov 2019 13:17:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7MKpJ6xKJUsYO4FGGPpKE55sVrfUhJ2Y4wHgSjvWsCBHb+wRuoCBcdJr4JmyGPxfrwdeW5w==
X-Received: by 2002:a5d:6441:: with SMTP id d1mr1101415wrw.93.1574889423782;
 Wed, 27 Nov 2019 13:17:03 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id r63sm8207692wma.2.2019.11.27.13.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2019 13:17:03 -0800 (PST)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191125104103.28962-1-philmd@redhat.com>
 <CAL1e-=gJxBRvkiPzdAKOqVLEc7mmLpJRrprv5Rjcd8p2jD+_Hg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8fa0f275-797a-6a3c-4fac-43f4f7a8b975@redhat.com>
Date: Wed, 27 Nov 2019 22:17:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gJxBRvkiPzdAKOqVLEc7mmLpJRrprv5Rjcd8p2jD+_Hg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: r2UcojAaNI2yZOHxl50CDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Thomas Huth <thuth@redhat.com>, libvir-list@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

On 11/27/19 7:47 PM, Aleksandar Markovic wrote:
> On Mon, Nov 25, 2019 at 11:41 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>>
>> The r4k machine was introduced in 2005 (6af0bf9c7) and its last
>> logical change was in 2005 (9542611a6). After we can count 164
>> maintenance commits (QEMU API changes) with the exception of
>> 1 fix in 2015 (memory leak, commit 3ad9fd5a).
>>
>> This machine was introduced as a proof of concept to run a MIPS
>> CPU. 2 years later, the Malta machine was add (commit 5856de80)
>> modeling a real platform.
>>

Since you queued this patch, do you mind adding Aurelien comment to the=20
patch description, as it appears important information:

'''
The Linux kernel support for this machine has been dropped more
than 10 years ago in this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D302922e5f6901eb6f29c58539631f71b3d9746b8
'''

I was not sure when sending the patch, but as an improvement, we can=20
also remove Aurelien and Aleksandar Rikalo from the MAINTAINERS section.

And I assume we can also add (which was explicit in your previous patch):
Acked-by: Aurelien Jarno <aurelien@aurel32.net>

If you want I can resend this patch with all that amended.

>> Note also this machine has no specification except 5 lines in
>> the header of this file:
>>
>>   * emulates a simple machine with ISA-like bus.
>>   * ISA IO space mapped to the 0x14000000 (PHYS) and
>>   * ISA memory at the 0x10000000 (PHYS, 16Mb in size).
>>   * All peripherial devices are attached to this "bus" with
>>   * the standard PC ISA addresses.
>>
>> It is time to deprecate this obsolete machine. Users are
>> recommended to use the Malta board, which hardware is well
>> documented.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   qemu-deprecated.texi | 5 +++++
>>   hw/mips/mips_r4k.c   | 1 +
>>   MAINTAINERS          | 2 +-
>>   3 files changed, 7 insertions(+), 1 deletion(-)
>>
>=20
> Applied to MIPS queue.
>=20
>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> index 4b4b7425ac..05265b43c8 100644
>> --- a/qemu-deprecated.texi
>> +++ b/qemu-deprecated.texi
>> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should =
use 'scsi-hd' or
>>
>>   @section System emulator machines
>>
>> +@subsection mips r4k platform (since 4.2)
>> +
>> +This machine type is very old and unmaintained. Users should use the 'm=
alta'
>> +machine type instead.
>> +
>>   @subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
>>
>>   These machine types are very old and likely can not be used for live m=
igration
>> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
>> index 70024235ae..0b79ad26cb 100644
>> --- a/hw/mips/mips_r4k.c
>> +++ b/hw/mips/mips_r4k.c
>> @@ -294,6 +294,7 @@ void mips_r4k_init(MachineState *machine)
>>
>>   static void mips_machine_init(MachineClass *mc)
>>   {
>> +    mc->deprecation_reason =3D "use malta machine type instead";
>>       mc->desc =3D "mips r4k platform";
>>       mc->init =3D mips_r4k_init;
>>       mc->block_default_type =3D IF_IDE;
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5e5e3e52d6..3b3a88e264 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -972,7 +972,7 @@ F: hw/net/mipsnet.c
>>   R4000
>>   M: Aurelien Jarno <aurelien@aurel32.net>
>>   R: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
>> -S: Maintained
>> +S: Obsolete
>>   F: hw/mips/mips_r4k.c
>>
>>   Fulong 2E
>> --
>> 2.21.0
>>
>>
>=20


