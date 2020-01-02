Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAADC2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:18:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D1C20848
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bn26+xOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D1C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1J5-0002X8-FV
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in1Hu-00025L-7N
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:17:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in1Hs-0002Kq-9N
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:17:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49303
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in1Hs-0002I0-51
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577974639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHB2ksbQwBMn9viF/xw4y5u3oQVkjTL0ulCmZHkmLcc=;
 b=bn26+xOfyWLk5FSflIg7I0CYQ57WBk2t7mgjJ55Kwlh1snymI35893Hvh19WHJL3h4Hj2L
 OAiowh8i4tHp6Ng600pM0F6Rerct8X2OlmfRgYVhH9Rznk40PoEQzaMeR6NPb0ID2okeqE
 v/9BGFNkJeF2IW3ML3n7BlAW6apcp3Y=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-stc9xWuOOASQCoxuwXlxFg-1; Thu, 02 Jan 2020 09:17:17 -0500
Received: by mail-ed1-f69.google.com with SMTP id v11so21175340edw.11
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 06:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LlAXQ1bfDYt+usmpBS9fJA5dUC5Q/phnKAbfdvCNDtI=;
 b=j2WlV6yZeQ6ovsluLw83VJG6u/+DcWSIdyFlLGRCWePssWRHZ+QYlhCivD4cQy6htO
 z8Og+o7pO9SY6PzxxvmQ3MozskvW1/dpTVyFiKlGlDw1lr+7ZFe7D8bTFyI7itCFBjJ4
 er0wAM/gKfhGv4XWvSrqzgUeU0TUeiust1ha7iETmyNYj2pZ9sCGmHrzfpk7Yp7Adsc9
 lCaSp5xh3F8S6kEA5VRi7WZFHpN0+3zQNtnCYQY11bYhciCR1cJrq8fuuG+gaLa1yqqM
 9U8Udbai1IUhWs/EbPlIS1B0KyaJRxvKgk6Rrh6tcTcr8EwmAwpJLbCm87FGtO0Mra/9
 Gjww==
X-Gm-Message-State: APjAAAXw+JpyEYTI2ENcw41CXTHh7X7mJQW5ULcimMqBddwi96MoxBG6
 BcgFxiWOzl8yTTM+ufc32ekoG9KtgPx/iaQmPRj3Ig0qzRsQjf6YqJOn65rGOBep3BRvE7Xnk60
 N8pq8rbVBLk9kaus=
X-Received: by 2002:a17:906:680b:: with SMTP id
 k11mr4017054ejr.0.1577974635934; 
 Thu, 02 Jan 2020 06:17:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCB5tnOvCZYkt+Hb3FFODgmBLhokb8CheCieDEwaQg9ZrSHftUDJPvZTQyInC2hq8w/iTWfQ==
X-Received: by 2002:a17:906:680b:: with SMTP id
 k11mr4017021ejr.0.1577974635668; 
 Thu, 02 Jan 2020 06:17:15 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id cb20sm6987298edb.1.2020.01.02.06.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 06:17:15 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
 <20200102151223.73e1448b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a3017f38-b32b-de32-9896-b287253d0fa2@redhat.com>
Date: Thu, 2 Jan 2020 15:17:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102151223.73e1448b@redhat.com>
Content-Language: en-US
X-MC-Unique: stc9xWuOOASQCoxuwXlxFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 1/2/20 3:12 PM, Igor Mammedov wrote:
> On Thu, 2 Jan 2020 13:06:33 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/2/20 12:31 PM, Helge Deller wrote:
>>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>>>> If user provided non-sense RAM size, board will complain and
>>>>> continue running with max RAM size supported.
>>>>> Also RAM is going to be allocated by generic code, so it won't be
>>>>> possible for board to fix things up for user.
>>>>>
>>>>> Make it error message and exit to force user fix CLI,
>>>>> instead of accepting non-sense CLI values.
>>>>>
>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>>> ---
>>>>>   =C2=A0 hw/hppa/machine.c | 3 ++-
>>>>>   =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>>> index 5d0de26..25f5afc 100644
>>>>> --- a/hw/hppa/machine.c
>>>>> +++ b/hw/hppa/machine.c
>>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine=
)
>>>>>   =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
>>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram=
_size =3D FIRMWARE_START;
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size mo=
re than %d is not supported", FIRMWARE_START);
>>>>> +        exit(EXIT_FAILURE);
>>>>
>>>> $ qemu-system-hppa -m 3841m
>>>> qemu-system-hppa: invalid accelerator kvm
>>>> qemu-system-hppa: falling back to tcg
>>>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>>>
>>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format=
, we can simply use "RAM size more than 3840m is not supported". Is that OK=
 with you?
>>>
>>> I don't really like that change.
>>>
>>> We currently only emulate a 32-bit system, and for those 4GB is the max=
imum.
>>> So, if I start my machine with "qemu-system-hppa -m 4G", the current co=
de
>>> then automatically uses the maximum possible of 3841MB (which is limite=
d by
>>> firmware start address).
>>> I don't expect users to know the excact 3841MB number.
>>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or =
4GB,
>>> but not "3841MB".
>>
>> Thanks for the explanation. This deserves a comment in the source file
>> IMHO (and displaying a warning to the user that the behavior is changed)=
.
>>
>> I understand the CPU can't access this DRAM area because the ROM is
>> mapped there. What about other devices, can they do DMA access to it?
>>
>> Igor: If this complicates your series too much, I think we can directly
>> allocate up-to 4GiB and not worry about the 256MiB lost.
>=20
> Do you mean
> s/"RAM size more than %d is not supported"/"RAM size more than 4Gb is not=
 supported"/

Works for me! You can keep my R-b with this change, thanks.

>>> So, I think that patch is - although it's more correct - not a
>>> benefit for the end user.
>>>
>>> Helge
>>>   =20
>>
>>
>=20


