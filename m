Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC05C32771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 21:18:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFA66222C4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 21:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggQ86Tcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA66222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inqnX-0004N0-In
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 16:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1inqmt-0003x6-F2
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 16:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1inqmp-0000W6-Tt
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 16:16:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1inqmp-0000S2-IY
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 16:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578172602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D6W6iOhK6cSxo9LTtPbGg+CnvAHuYDIooJY1wpTYmvw=;
 b=ggQ86TcsbXGPmL0hQYVwPC6pHxgJRaAxvHhAq7KIeKH38iKqApiojQsSBRkBj6wh6nCRvg
 ri9fx50c98sQ+IL/utGJG60aUuZuSoKpm3vHjJ6llvgcvTCnLMUK4HvOc3XvbWudHsyuiY
 nZOasbH8/AI0OdyHXUsa9kSpgFBC094=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-QT01YwezNFGf28Z-9PnPTw-1; Sat, 04 Jan 2020 16:16:40 -0500
Received: by mail-wm1-f70.google.com with SMTP id b131so1964409wmd.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jan 2020 13:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R1AV8f9G1raJhvI8kfi3bs8HrqZl4JjQK6Iv5N8ksfU=;
 b=jjxmAj3UZ9bx6D6gnSZuDTvmDVK4Ll7bhTtZR0aSVhphp0koreeTWB3FqxQLG7frBB
 FCkwW/HVDqEI/ci9uSB03ULkWqTnw6L0soNBJJrR4VxvPDsD6qF2H30XdJRrgJIX93PJ
 BjXK47uERVA+qbuGF79RQ86YSvmznojtbAddlXgbJc0OpFwZIPtS6g6VT+CO3/Nc4k3S
 uLvepaAp+MSFVQY0uYBLFzegVUz4+ZRYwmS6DBPjsTWDv0MvtAE6uETSfr6sCjLKoKHy
 WaGhuJBnqzGMttAVAi/R2O6bj9XvclsW58yHZhSJWQWu28iCkogt6iFga/tJk3yISfqt
 Xawg==
X-Gm-Message-State: APjAAAUtpXVAHB9AF/bATWzYu/7Wb0Fog4CicryATqpUgRja8BwJ4DZ8
 hEBd312ZFO1kEfkbnINaOrnNzosksldeoGPtBq/gwJ5AvyrUcXbaMXlo4vTpTIGVZYlVEmJb8C+
 TTyKL6V6PEnuJu2M=
X-Received: by 2002:a5d:538e:: with SMTP id d14mr96790106wrv.358.1578172599012; 
 Sat, 04 Jan 2020 13:16:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyx0HXiZwE/cJ9E3Sysok8ruANt8g4+cD+/wr0sK7mvdOCsATlM0VEqsGY6pF0jXgtZz60w0w==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr96790086wrv.358.1578172598727; 
 Sat, 04 Jan 2020 13:16:38 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id u22sm70204247wru.30.2020.01.04.13.16.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jan 2020 13:16:38 -0800 (PST)
Subject: Re: [Qemu-devel] What should a virtual board emulate?
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20190319144013.26584-1-pbonzini@redhat.com>
 <alpine.BSF.2.21.9999.1903192350550.11467@zero.eik.bme.hu>
 <87imwe847x.fsf_-_@dusky.pond.sub.org>
 <CAAdtpL5Z1OXqZ_zzA0RLq9soydNtTFt2oCOEfui1rq19bLKUgA@mail.gmail.com>
 <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9b92b3c4-c5d5-9a51-7b96-50dcf113ee5a@redhat.com>
Date: Sat, 4 Jan 2020 22:16:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d9d5ac96-c0f5-dd83-d305-10e20c745dd1@redhat.com>
Content-Language: en-US
X-MC-Unique: QT01YwezNFGf28Z-9PnPTw-1
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 3/20/19 11:35 AM, Paolo Bonzini wrote:
> On 20/03/19 11:03, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> -display/-vga options suffers same clarity problems than -net. Is it a
>> card device or a cable linking to a network? Here is it a card device or
>> a cable connecting a monitor display?
>=20
> -display is a cable, -vga is a card ("-nic none" is a card, "-nic
> anythingelse" is a card+cable; "-net nic" is a card, "-net anythingelse"
> is a cable).
>=20
>>      Mind, I'm not demanding mips-fulong2e should continue to ignore -vg=
a;
>>      that's for its maintainer to decide.=C2=A0 I don't demand, I ask: w=
hat should
>>      a virtual board emulate?=C2=A0 What should -nodefaults do?
>>
>> IMHO -nodefaults contains soldered/mmio chipsets.
>> Whether you plug a display or not is a different story.
>=20
> In principle you could also cut the copper tracks that connect the card
> to the PCI bus...

But then you have a crippled machine... We are not trying to model that.

I went back to continue a Fuloong Avocado test I started a year ago, and=20
it was failing. I remember I had something working, so I bisected and=20
reached this commit...

78c37d88f1b8b0b3ebcc632c458f0c3779fe2951 is the first bad commit
commit 78c37d88f1b8b0b3ebcc632c458f0c3779fe2951
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Tue Mar 19 15:37:19 2019 +0100

     mips-fulong2e: obey -vga none

     Do not create an ATI VGA if "-vga none" was passed on the command line=
.

Booting PMON 1.1.2:

console: PMON2000 MIPS Initializing. Standby...
console: ERRORPC=3D00000000 CONFIG=3D00030932
console: PRID=3D00006302
console: DIMM read
console: 00000080
console: read memory type
console: read number of rows
console: read memory size per side
console: read blocks per ddrram
console: read number of sides
console: read width
console: DIMM SIZE=3D10000000
console: sdcfg=3D3d5043df
console: msize=3D10000000
console: Init SDRAM Done!
console: Sizing caches...
console: Init caches...
console: godson2 caches found
console: Init caches done, cfg =3D 00030932
console: Copy PMON to execute location...
console: start =3D 0x85000000
console: s0 =3D 0x3ac00000
console: a5000000
console: a5010000
console: a5020000
console: a5030000
console: a5040000
console: copy text section done.
console: Copy PMON to execute location done.
console: sp=3D84ffc000Uncompressing Bios........................OK,Booting=
=20
Bios
console: FREQ
console: FREI
console: DONE
console: TTYI
console: TTYD
console: ENVI
console: MAPV
console: Mfg  0, Id 60
console: STDV
console: 80100000: heap is already above this point
console: SBDD
console: 686I
console: 0x3f8=3Dff
console: PPCIH
console: PCI bus 0 slot 5/0: reg 0x10 =3D 0x0
console: PCI bus 0 slot 5/0: reg 0x14 =3D 0x0
console: PCI bus 0 slot 5/0: reg 0x18 =3D 0x0
console: PCI bus 0 slot 5/0: reg 0x1c =3D 0x0
console: PCI bus 0 slot 5/0: reg 0x20 =3D 0x0
console: PCI bus 0 slot 5/0: reg 0x24 =3D 0x0
console: PCI bus 0 slot 5/1: reg 0x10 =3D 0xfffffff9
console: PCI bus 0 slot 5/1: reg 0x14 =3D 0xfffffffd
console: PCI bus 0 slot 5/1: reg 0x18 =3D 0xfffffff9
console: PCI bus 0 slot 5/1: reg 0x1c =3D 0xfffffffd
console: PCI bus 0 slot 5/1: reg 0x20 =3D 0xfffffff1
console: PCI bus 0 slot 5/1: reg 0x24 =3D 0x0
console: PCI bus 0 slot 5/2: reg 0x10 =3D 0x0
console: PCI bus 0 slot 5/2: reg 0x14 =3D 0x0
console: PCI bus 0 slot 5/2: reg 0x18 =3D 0x0
console: PCI bus 0 slot 5/2: reg 0x1c =3D 0x0
console: PCI bus 0 slot 5/2: reg 0x20 =3D 0xffffffe1
console: PCI bus 0 slot 5/2: reg 0x24 =3D 0x0
console: PCI bus 0 slot 5/3: reg 0x10 =3D 0x0
console: PCI bus 0 slot 5/3: reg 0x14 =3D 0x0
console: PCI bus 0 slot 5/3: reg 0x18 =3D 0x0
console: PCI bus 0 slot 5/3: reg 0x1c =3D 0x0
console: PCI bus 0 slot 5/3: reg 0x20 =3D 0xffffffe1
console: PCI bus 0 slot 5/3: reg 0x24 =3D 0x0
console: PCI bus 0 slot 5/4: reg 0x10 =3D 0x0
console: PCI bus 0 slot 5/4: reg 0x14 =3D 0x0
console: PCI bus 0 slot 5/4: reg 0x18 =3D 0x0
console: PCI bus 0 slot 5/4: reg 0x1c =3D 0x0
console: PCI bus 0 slot 5/4: reg 0x20 =3D 0x0
console: PCI bus 0 slot 5/4: reg 0x24 =3D 0x0
console: PCI bus 0 slot 5/5: reg 0x10 =3D 0x0
console: PCI bus 0 slot 5/5: reg 0x14 =3D 0x0
console: PCI bus 0 slot 5/5: reg 0x18 =3D 0x0
console: PCI bus 0 slot 5/5: reg 0x1c =3D 0x0
console: PCI bus 0 slot 5/5: reg 0x20 =3D 0x0
console: PCI bus 0 slot 5/5: reg 0x24 =3D 0x0
console: PCI bus 0 slot 5/6: reg 0x10 =3D 0x0
console: PCI bus 0 slot 5/6: reg 0x14 =3D 0x0
console: PCI bus 0 slot 5/6: reg 0x18 =3D 0x0
console: PCI bus 0 slot 5/6: reg 0x1c =3D 0x0
console: PCI bus 0 slot 5/6: reg 0x20 =3D 0x0
console: PCI bus 0 slot 5/6: reg 0x24 =3D 0x0
console: PCIS
console: PCIR
console: PCIW
console: NETI
console: RTCL
console: PCID
console: VGAI
console: Default MODE_ID 2
console: starting radeon init...
^
Current QEMU is stuck here.

Before it would continue:

console: iobase=3Dbfd0a100,mmbase=3Db5050000
console: mc_status=3D5
console: mc_status=3D5
console: mc_status=3D5
console: mc_status=3D5
console: ppll_div_3 =3D 301f4
console: Wrote: 0x00000043 0x000301f4 0x00000000 (0x00000000)
console: Wrote: rd=3D67, fd=3D500, pd=3D3
console: VCLK_ECP_CNTL =3D 000000C3
console: radeon init done
console: FRBI
console: cfb_console init,fb=3Db4000000
console: Video: Drawing the logo ...
console: CONSOLE_SIZE 450560HSTI
...

Since:

1/ the Radeon chip is soldered on the motherboard,

2/ the default BIOS expects the Radeon chip to be
    unconditionally present,

I insist this patch is incorrect for the particular case of the=20
Fuloong2e board. I plan to revert it when I post the test.

BTW I'm not using --nodefault, I'm running default ./configure:

qemu-system-mips64el -M fulong2e -bios pmon_2e.bin \
-display none -vga none -serial stdio

Regards,

Phil.


