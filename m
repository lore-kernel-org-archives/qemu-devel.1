Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3E1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEDD205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiMPXK6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEDD205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6K6-0001Uc-I1
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic6C2-0005l2-Uy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic6C0-00024R-Al
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:18:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38327
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic6C0-00022k-2U
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575371887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHHZ4OmDbbhL2J/cTAKJ2bzCWg8p5IFRZEimMUswq0k=;
 b=PiMPXK6p+0xHTjoNm5Jr0qsb1wWdryODnBCG1wHvqZDKWyv9AYuW3Q8f8N4zvIefxM5ZcV
 1aWAHhuOBzyVjzNbECQ0AmNkcRbpHNWWnP36VPpfWLJPeDEyuWJcOK3xOO409qMTACuQW6
 p1wA5XM/4u0PlB+WrIZBm3dC3SDqxYw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-cUBpdhv-MLGbKBl8jv_shQ-1; Tue, 03 Dec 2019 06:18:04 -0500
Received: by mail-wr1-f69.google.com with SMTP id f17so1595888wrt.19
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mKyaN/5VaEeT/LCd61lOZIzD/drrE1Nr7Ugv43LTJgU=;
 b=uNDZ4u6kk+KN6Xsv+BrjvEqWis7T1606WkI337A3xqHUhhuagvOmwlgC2S2oEB6uL1
 jDnbF/AmoLjWapKg8aJE8x+roAGUTGyEv77vg8mxI8ql4oPe0GseJ26s3bg0NQ5fk34a
 xKWUPn5R/WzY6Ne3jzZBkBVOb/a9E4WxwFvvT0RFJYmriSeB4es8YjtYrlbd8dKgPbzb
 wVmRdFNovXYoX3hZ2kVksZdNQ1apjG1I6gFy0yGJ4GY3hCqDt68j1OZBHFVJwQsxptf8
 uZ1DdN7Tsm0XLYJEW09PUP5dy+wJu0s9iKvLfMGJZ6EDDkCYx+l5H/5Cu6hip9sV7sNx
 VM3Q==
X-Gm-Message-State: APjAAAWzY52iOaPYq6nivFnXx8LUHqjsJgGiY3/tgP0TgPrh9d8982ZF
 V9HbaQdi4E+owYHiSMpjNudYRI1CiTDuFHdcLM1N5jb2ZfdbweFMrnPYsc/BiiqQ19pZ1JOcFwh
 mRehTWIJ+5qrwBps=
X-Received: by 2002:a7b:c308:: with SMTP id k8mr32598402wmj.32.1575371883115; 
 Tue, 03 Dec 2019 03:18:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwzUkdeOoPs6TOWalCGGy65irBN6M8E0+H4KrigeEpdExvzy963MtNtYpE7ixByrGroJc+XJw==
X-Received: by 2002:a7b:c308:: with SMTP id k8mr32598381wmj.32.1575371882856; 
 Tue, 03 Dec 2019 03:18:02 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id m8sm2699432wmf.8.2019.12.03.03.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 03:18:02 -0800 (PST)
Subject: Re: [PATCH v37 10/17] target/avr: Add instruction disassembly function
To: Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <20191127175257.23480-11-mrolnik@gmail.com>
 <CAL1e-=gBNhUExfrvNcsGby6HOUmLsoQ9h68oFoOqms3ExWGBbQ@mail.gmail.com>
 <CAK4993g9sAkBSHiHz5RzMCXJdr-vHU=qGaBMq52GEBku3y=oNw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b24d01f6-7112-8074-f0bf-623024ae4176@redhat.com>
Date: Tue, 3 Dec 2019 12:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK4993g9sAkBSHiHz5RzMCXJdr-vHU=qGaBMq52GEBku3y=oNw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: cUBpdhv-MLGbKBl8jv_shQ-1
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
Cc: "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/2/19 8:04 AM, Michael Rolnik wrote:
> Aleksandar.
>=20
> If this code is going to be merge in 2019 I should modify al the=20
> copyrights, right. or should I put 2020 in?

Usually the copyright date is when you first contributed your code to=20
the world (here, the list). If a patch was on the list in 2018, even if=20
you made modifications and repost it, (c) is 2018.

IOW, If your series gets merged in 2020, it will be merged as (c) 2019.

I'm not sure why Richard's (c) appears here, is target/avr/disas.c based=20
on target/openrisc/disas.c? Then it looks correct to me, but IANAL.

> On Mon, Dec 2, 2019 at 2:28 AM Aleksandar Markovic=20
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>=20
>=20
>     On Wednesday, November 27, 2019, Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>> wrote:
>=20
>         Provide function disassembles executed instruction when `-d
>         in_asm` is
>         provided
>=20
>         Example:
>         `./avr-softmmu/qemu-system-avr -bios
>         free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf -d in_asm` will
>         produce something like the following
>=20
>         ```
>          =C2=A0 =C2=A0 ...
>          =C2=A0 =C2=A0 IN:
>          =C2=A0 =C2=A0 0x0000014a:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x3808
>=20
>          =C2=A0 =C2=A0 IN: main
>          =C2=A0 =C2=A0 0x00003808:=C2=A0 CALL=C2=A0 =C2=A0 =C2=A0 0x4b4
>=20
>          =C2=A0 =C2=A0 IN: vParTestInitialise
>          =C2=A0 =C2=A0 0x000004b4:=C2=A0 LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0r2=
4, 255
>          =C2=A0 =C2=A0 0x000004b6:=C2=A0 STS=C2=A0 =C2=A0 =C2=A0 =C2=A0r2=
4, 0
>          =C2=A0 =C2=A0 0x000004b8:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r2=
0
>          =C2=A0 =C2=A0 0x000004ba:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$1=
, r24
>          =C2=A0 =C2=A0 0x000004bc:=C2=A0 LDS=C2=A0 =C2=A0 =C2=A0 =C2=A0r2=
4, 0
>          =C2=A0 =C2=A0 0x000004be:=C2=A0 MULS=C2=A0 =C2=A0 =C2=A0 r16, r2=
0
>          =C2=A0 =C2=A0 0x000004c0:=C2=A0 OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0$2=
, r24
>          =C2=A0 =C2=A0 0x000004c2:=C2=A0 RET
>          =C2=A0 =C2=A0 ...
>         ```
>=20
>         Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         Suggested-by: Richard Henderson <richard.henderson@linaro.org
>         <mailto:richard.henderson@linaro.org>>
>         Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>         <mailto:philmd@redhat.com>>
>         Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com
>         <mailto:aleksandar.m.mail@gmail.com>>
>         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>         <mailto:philmd@redhat.com>>
>         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>         <mailto:philmd@redhat.com>>
>         ---
>          =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01=
 +
>          =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02=
 +-
>          =C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0| 228
>         +++++++++++++++++++++++++++++++++++++++++
>          =C2=A0target/avr/translate.c |=C2=A0 11 ++
>          =C2=A04 files changed, 241 insertions(+), 1 deletion(-)
>          =C2=A0create mode 100644 target/avr/disas.c
>=20
>         diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>         index 9ea5260165..a3e615a1eb 100644
>         --- a/target/avr/cpu.h
>         +++ b/target/avr/cpu.h
>         @@ -157,6 +157,7 @@ bool avr_cpu_exec_interrupt(CPUState *cpu,
>         int int_req);
>          =C2=A0hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr ad=
dr);
>          =C2=A0int avr_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf,=
 int
>         reg);
>          =C2=A0int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf=
,
>         int reg);
>         +int avr_print_insn(bfd_vma addr, disassemble_info *info);
>=20
>          =C2=A0static inline int avr_feature(CPUAVRState *env, int featur=
e)
>          =C2=A0{
>         diff --git a/target/avr/cpu.c b/target/avr/cpu.c
>         index dae56d7845..52ec21dd16 100644
>         --- a/target/avr/cpu.c
>         +++ b/target/avr/cpu.c
>         @@ -83,7 +83,7 @@ static void avr_cpu_reset(CPUState *cs)
>          =C2=A0static void avr_cpu_disas_set_info(CPUState *cpu,
>         disassemble_info *info)
>          =C2=A0{
>          =C2=A0 =C2=A0 =C2=A0info->mach =3D bfd_arch_avr;
>         -=C2=A0 =C2=A0 info->print_insn =3D NULL;
>         +=C2=A0 =C2=A0 info->print_insn =3D avr_print_insn;
>          =C2=A0}
>=20
>          =C2=A0static void avr_cpu_realizefn(DeviceState *dev, Error **er=
rp)
>         diff --git a/target/avr/disas.c b/target/avr/disas.c
>         new file mode 100644
>         index 0000000000..a51ade7c2a
>         --- /dev/null
>         +++ b/target/avr/disas.c
>         @@ -0,0 +1,228 @@
>         +/*
>         + * AVR disassembler
>         + *
>         + * Copyright (c) 2018 Richard Henderson <rth@twiddle.net
>         <mailto:rth@twiddle.net>>
>=20
>=20
>     Just a detail: since this file is created in 2019, the copyright
>     year should be 2019 too.
>=20
>         + * Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>>
>         + *
>         + * This program is free software: you can redistribute it
>         and/or modify
>         + * it under the terms of the GNU General Public License as
>         published by
>         + * the Free Software Foundation, either version 2 of the
>         License, or
>         + * (at your option) any later version.
>         + *
>         + * This program is distributed in the hope that it will be usefu=
l,
>         + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
>         + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the
>         + * GNU General Public License for more details.
>         + *
>         + * You should have received a copy of the GNU General Public
>         License
>         + * along with this program.=C2=A0 If not, see
>         <http://www.gnu.org/licenses/>.
>         + */
[...]


