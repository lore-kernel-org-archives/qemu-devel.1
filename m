Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D1C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 12:07:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85B121655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9NP5SxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85B121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imzGB-00051s-UY
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 07:07:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imzFR-0004Jp-GF
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imzFO-0005kn-F5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:06:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42408
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imzFO-0005k8-7u
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 07:06:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577966797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RYhfHmeeHMKKOsO/cCqHLaF0/+NzxaX0b/2oNpbXcTw=;
 b=R9NP5SxQyMYNVJ3f/GxiPpZJtcGfnjqmo/Es5XUDBlHZvgfrgCyQuDgOFFcL7i8YGeLkjd
 Qub2Em5T4YzT2Gv/n82ArDQIYj2oFcNX0R/OxD3B5x4UpucDT1eC1hXBVvDvjabKMbyQky
 E8sH6B6yaYZTokmFPUMf6Xz8IZPvwvk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-N4GfrclcObaa9oEGbMY0_Q-1; Thu, 02 Jan 2020 07:06:36 -0500
Received: by mail-ed1-f71.google.com with SMTP id w9so14570721eds.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 04:06:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Crq6E72DrLGSxDyhaQ7XsAYH/SCQyFWp5IEVCTQyHI=;
 b=rqU9VdBwRmCckJ1QkWORBMlZ9n9KyJH60SgkgDyNNk6JM3UKoKzGNJ5bItcAg1Zmeu
 XrE9qgF2qq/lSJyzJSNvLKltWX8BRq7bEdrX1o9IKgpbZPSd609FmIyPBKzulg22QsJ/
 GnG+mqRpdq6Achw46S42cIMOK2bcpmWaekFW2RwPQqSTjF5LZlyB7dgVEihoRRfdh1w8
 1STzmiVAyYLspB+CHse74rgVVA6z7qi88TV7tQJcGMx3wsuVRz/QKV3SH9PipUZKY5ez
 WRwi+yos5Jy1gBqO0DfqeowjgaeXcUjeUU+D+7UF7Ic+yV8QkPn5nYZOKtlS2LdhnBXs
 iO2Q==
X-Gm-Message-State: APjAAAUv4BtrWV77uS+AGxY1q7BTqpASO6b+Em2yluHmyDBQHKIGsbDG
 rylu1Mt3azF7c/TvguOtE/bcyaCFHkWUbAU5M8EeltHxqkD7KZoAEo3XaXCEE2Ky7526chxL048
 CD8zV8yy7L+Vw0+0=
X-Received: by 2002:a50:d849:: with SMTP id v9mr86991974edj.105.1577966794885; 
 Thu, 02 Jan 2020 04:06:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbA7qRy+OpK90HHeXnw/OPLrcRp0UuVqnOm63Kk32/VPhU5fhbxla1bZAcGiCBrZqMA8+hew==
X-Received: by 2002:a50:d849:: with SMTP id v9mr86991953edj.105.1577966794654; 
 Thu, 02 Jan 2020 04:06:34 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id md13sm7365967ejb.85.2020.01.02.04.06.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 04:06:34 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Helge Deller <deller@gmx.de>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
Date: Thu, 2 Jan 2020 13:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
Content-Language: en-US
X-MC-Unique: N4GfrclcObaa9oEGbMY0_Q-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 12:31 PM, Helge Deller wrote:
> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>> If user provided non-sense RAM size, board will complain and
>>> continue running with max RAM size supported.
>>> Also RAM is going to be allocated by generic code, so it won't be
>>> possible for board to fix things up for user.
>>>
>>> Make it error message and exit to force user fix CLI,
>>> instead of accepting non-sense CLI values.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>>  =C2=A0 hw/hppa/machine.c | 3 ++-
>>>  =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>> index 5d0de26..25f5afc 100644
>>> --- a/hw/hppa/machine.c
>>> +++ b/hw/hppa/machine.c
>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine)
>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram_s=
ize =3D FIRMWARE_START;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size more=
 than %d is not supported", FIRMWARE_START);
>>> +        exit(EXIT_FAILURE);
>>
>> $ qemu-system-hppa -m 3841m
>> qemu-system-hppa: invalid accelerator kvm
>> qemu-system-hppa: falling back to tcg
>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>
>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format, =
we can simply use "RAM size more than 3840m is not supported". Is that OK w=
ith you?
>=20
> I don't really like that change.
>=20
> We currently only emulate a 32-bit system, and for those 4GB is the maxim=
um.
> So, if I start my machine with "qemu-system-hppa -m 4G", the current code
> then automatically uses the maximum possible of 3841MB (which is limited =
by
> firmware start address).
> I don't expect users to know the excact 3841MB number.
> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or 4G=
B,
> but not "3841MB".

Thanks for the explanation. This deserves a comment in the source file=20
IMHO (and displaying a warning to the user that the behavior is changed).

I understand the CPU can't access this DRAM area because the ROM is=20
mapped there. What about other devices, can they do DMA access to it?

Igor: If this complicates your series too much, I think we can directly=20
allocate up-to 4GiB and not worry about the 256MiB lost.

> So, I think that patch is - although it's more correct - not a
> benefit for the end user.
>=20
> Helge
>=20


