Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE5CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC362075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5/eZxdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC362075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyQS-00080R-3y
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuyPE-0006bZ-3j
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuyPC-000183-4w
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:49:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60011
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuyPC-00016m-0Y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579870185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaVr7FaAPrzlakHju3fBTVcglRGeU5edmafiCiWxbx4=;
 b=K5/eZxdpP7oGOhMrm4k0jRTl76+iue9mis35zMvlDRRG6UJK1PnBW/wggbJ6MqSorO/rS2
 cgVmvZwR0RyzzWmxwq+FxCcgcthlo2czE1p4hXCuECfH+v2b8AfG9fr86n3tqnuYoUfVIT
 lF8YPCf0RO/PaLvSxsxOdaXrE7oKuVw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-J-cZEnNMMKakAbTooZDqWQ-1; Fri, 24 Jan 2020 07:49:41 -0500
Received: by mail-wm1-f69.google.com with SMTP id s25so599133wmj.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 04:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HAvV1dC5xoQRUBS2/CTV2GT9Qa0yMY+Lz/g8I+J+m00=;
 b=HEP9TnPOom0qqygmtcEFbjX0cozzoqvAGw6ttkgABTL8gclAR/bw5xTM8PpX62pcb4
 W1As5Cgcxfi57r5Gba3CBfYvFoTcJX+8RtrVVkQYjiH2XvTShCIdzq430113X/4BGNE4
 Qlwty0aNHjcUQ3Lyfoo1RrNzBe2ht7ZBU/6mYjYPFzEtKEJFSCis5LiuyNsgsHySlR/h
 95P6gi3vLSkiF53UxwKY4ShfKwwDdTZ6aIsAmKIKVweCk/XzL50B+r3ZvvGbwtd1aqea
 laJrg4aN1i4ioX9nJ7LMzpfqvmPpWjfuJqCWHxW7di9j/H6/+s69kRAljNLKNqVIHOYq
 SyHg==
X-Gm-Message-State: APjAAAViEV4RjOPdFxeGPLO5ZfiYBtJew57gd8zUV/kWQYWOpnv63KS+
 4oHoOfasEFX4ktFb6/lUEvKTmahdoQxfE4pRO277uM5Pu7GNRrXYScIxQqc2R2NovlC74CSEUjO
 z86ILzZJvMtTUoZo=
X-Received: by 2002:a5d:4085:: with SMTP id o5mr4113692wrp.321.1579870180490; 
 Fri, 24 Jan 2020 04:49:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqx+1NKwwKukHPGIajVcd16qteybc1uuPclxRSM4A0ejDE+j2k6zu7p/oZJIG94pSatZ6dTDOg==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr4113646wrp.321.1579870180113; 
 Fri, 24 Jan 2020 04:49:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id t81sm6911368wmg.6.2020.01.24.04.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2020 04:49:39 -0800 (PST)
Subject: Re: [PATCH rc2 00/25] target/avr merger
To: Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
 <CAK4993iG+t7fZS=cekXfJVpDQ_L7jLu8i2V4mHVLbS-r69=AVg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <00c08b6d-6ca2-7fa6-3dab-b834aea5a8d3@redhat.com>
Date: Fri, 24 Jan 2020 13:49:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAK4993iG+t7fZS=cekXfJVpDQ_L7jLu8i2V4mHVLbS-r69=AVg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: J-cZEnNMMKakAbTooZDqWQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 12:41 PM, Michael Rolnik wrote:
> Tested-by: Michael Rolnik <mrolnik@gmail.com <mailto:mrolnik@gmail.com>>

Thanks a lot!

> The only thing I want to change is instead of -kernel put -bios in=20
> qemu-doc.texi file. Should I send a new series?

Please do NOT :)

Richard can do the trivial fixup directly.

> On Fri, Jan 24, 2020 at 2:51 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org=20
> <mailto:f4bug@amsat.org>> wrote:
>=20
>     This is the AVR port from Michael release (merge) candidate 2.
>=20
>     Since v1 [1]:
>     - Addressed Thomas comments
>     - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
>     - Added ELF parsing requested by Aleksandar
>     - Dropped default machine (as with the ARM port)
>=20
>     Change since rc1:
>=20
>     $ git backport-diff -u avr-rc1 -r origin/master..
>     Key:
>     [----] : patches are identical
>     [####] : number of functional differences between
>     upstream/downstream patch
>     [down] : patch is downstream-only
>     The flags [FC] indicate (F)unctional and (C)ontextual differences,
>     respectively
>=20
>     001/25:[----] [--] 'target/avr: Add outward facing interfaces and
>     core CPU logic'
>     002/25:[----] [--] 'target/avr: Add instruction helpers'
>     003/25:[----] [--] 'target/avr: Add instruction translation -
>     Registers definition'
>     004/25:[----] [--] 'target/avr: Add instruction translation -
>     Arithmetic and Logic Instructions'
>     005/25:[----] [--] 'target/avr: Add instruction translation - Branch
>     Instructions'
>     006/25:[----] [--] 'target/avr: Add instruction translation - Data
>     Transfer Instructions'
>     007/25:[----] [--] 'target/avr: Add instruction translation - Bit
>     and Bit-test Instructions'
>     008/25:[----] [--] 'target/avr: Add instruction translation - MCU
>     Control Instructions'
>     009/25:[----] [--] 'target/avr: Add instruction translation - CPU
>     main translation function'
>     010/25:[----] [--] 'target/avr: Add instruction disassembly function'
>     011/25:[----] [--] 'hw/char: Add limited support for Atmel USART
>     peripheral'
>     012/25:[0045] [FC] 'hw/timer: Add limited support for Atmel 16 bit
>     timer peripheral'
>     013/25:[----] [--] 'hw/misc: Add Atmel power device'
>     014/25:[0024] [FC] 'target/avr: Add section about AVR into QEMU
>     documentation'
>     015/25:[----] [--] 'target/avr: Register AVR support with the rest
>     of QEMU'
>     016/25:[----] [--] 'target/avr: Add machine none test'
>     017/25:[0002] [FC] 'target/avr: Update MAINTAINERS file'
>     018/25:[down]=C2=A0 =C2=A0 =C2=A0 'hw/core/loader: Let load_elf popul=
ate the
>     processor-specific flags'
>     019/25:[down]=C2=A0 =C2=A0 =C2=A0 'hw/avr: Add helper to load raw/ELF=
 firmware
>     binaries'
>     020/25:[0015] [FC] 'hw/avr: Add some ATmega microcontrollers'
>     021/25:[0040] [FC] 'hw/avr: Add some Arduino boards'
>     022/25:[----] [--] 'target/avr: Update build system'
>     023/25:[----] [--] 'tests/boot-serial-test: Test some Arduino boards
>     (AVR based)'
>     024/25:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560 board=
'
>     025/25:[----] [--] '.travis.yml: Run the AVR acceptance tests'
>=20
>     Repo: https://gitlab.com/philmd/qemu/commits/avr-rc2
>=20
>     [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg672926.html
>     Supersedes: <20200123000307.11541-1-richard.henderson@linaro.org
>     <mailto:20200123000307.11541-1-richard.henderson@linaro.org>>
>=20
>     Michael Rolnik (20):
>      =C2=A0 target/avr: Add outward facing interfaces and core CPU logic
>      =C2=A0 target/avr: Add instruction helpers
>      =C2=A0 target/avr: Add instruction translation - Registers definitio=
n
>      =C2=A0 target/avr: Add instruction translation - Arithmetic and Logi=
c
>      =C2=A0 =C2=A0 Instructions
>      =C2=A0 target/avr: Add instruction translation - Branch Instructions
>      =C2=A0 target/avr: Add instruction translation - Data Transfer Instr=
uctions
>      =C2=A0 target/avr: Add instruction translation - Bit and Bit-test
>      =C2=A0 =C2=A0 Instructions
>      =C2=A0 target/avr: Add instruction translation - MCU Control Instruc=
tions
>      =C2=A0 target/avr: Add instruction translation - CPU main translatio=
n
>      =C2=A0 =C2=A0 function
>      =C2=A0 target/avr: Add instruction disassembly function
>      =C2=A0 hw/char: Add limited support for Atmel USART peripheral
>      =C2=A0 hw/timer: Add limited support for Atmel 16 bit timer peripher=
al
>      =C2=A0 hw/misc: Add Atmel power device
>      =C2=A0 target/avr: Add section about AVR into QEMU documentation
>      =C2=A0 target/avr: Register AVR support with the rest of QEMU
>      =C2=A0 target/avr: Add machine none test
>      =C2=A0 target/avr: Update MAINTAINERS file
>      =C2=A0 target/avr: Update build system
>      =C2=A0 tests/boot-serial-test: Test some Arduino boards (AVR based)
>      =C2=A0 tests/acceptance: Test the Arduino MEGA2560 board
>=20
>     Philippe Mathieu-Daud=C3=A9 (5):
>      =C2=A0 hw/core/loader: Let load_elf populate the processor-specific =
flags
>      =C2=A0 hw/avr: Add helper to load raw/ELF firmware binaries
>      =C2=A0 hw/avr: Add some ATmega microcontrollers
>      =C2=A0 hw/avr: Add some Arduino boards
>      =C2=A0 .travis.yml: Run the AVR acceptance tests
>=20
>      =C2=A0qemu-doc.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A051 +
>      =C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +
>      =C2=A0default-configs/avr-softmmu.mak=C2=A0 |=C2=A0 =C2=A0 5 +
>      =C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-
>      =C2=A0hw/avr/atmel_atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A048 +
>      =C2=A0hw/avr/boot.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A033 +
>      =C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A019 +
>      =C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +
>      =C2=A0include/hw/char/atmel_usart.h=C2=A0 =C2=A0 |=C2=A0 =C2=A093 +
>      =C2=A0include/hw/elf_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 6 +-
>      =C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 6 +-
>      =C2=A0include/hw/misc/atmel_power.h=C2=A0 =C2=A0 |=C2=A0 =C2=A046 +
>      =C2=A0include/hw/timer/atmel_timer16.h |=C2=A0 =C2=A094 +
>      =C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 1 +
>      =C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A037 +
>      =C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A054 +
>      =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 259 +++
>      =C2=A0target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A029 +
>      =C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +
>      =C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 151 ++
>      =C2=A0hw/avr/atmel_atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 470 +++++
>      =C2=A0hw/avr/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A074 +
>      =C2=A0hw/char/atmel_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 320 ++++
>      =C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A015 +-
>      =C2=A0hw/misc/atmel_power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 112 ++
>      =C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-
>      =C2=A0hw/timer/atmel_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 605 ++++++
>      =C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 826 ++++++++
>      =C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 246 +++
>      =C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A084 +
>      =C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 347 ++++
>      =C2=A0target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 121 ++
>      =C2=A0target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2997 ++++++++++++++++++++++++++++++
>      =C2=A0tests/qtest/boot-serial-test.c=C2=A0 =C2=A0|=C2=A0 =C2=A011 +
>      =C2=A0tests/qtest/machine-none-test.c=C2=A0 |=C2=A0 =C2=A0 1 +
>      =C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-
>      =C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A030 +
>      =C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A049 +
>      =C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 +
>      =C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 =C2=A0 3 +
>      =C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +
>      =C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A0 1 +
>      =C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +
>      =C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 |=C2=A0 =C2=A0 2 +
>      =C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 3 +
>      =C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 2 +
>      =C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A034 +
>      =C2=A0target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 182 ++
>      =C2=A0tests/acceptance/machine_avr6.py |=C2=A0 =C2=A050 +
>      =C2=A0tests/qtest/Makefile.include=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0=
 2 +
>      =C2=A050 files changed, 7539 insertions(+), 13 deletions(-)
>      =C2=A0create mode 100644 default-configs/avr-softmmu.mak
>      =C2=A0create mode 100644 hw/avr/atmel_atmega.h
>      =C2=A0create mode 100644 hw/avr/boot.h
>      =C2=A0create mode 100644 include/hw/char/atmel_usart.h
>      =C2=A0create mode 100644 include/hw/misc/atmel_power.h
>      =C2=A0create mode 100644 include/hw/timer/atmel_timer16.h
>      =C2=A0create mode 100644 target/avr/cpu-param.h
>      =C2=A0create mode 100644 target/avr/cpu-qom.h
>      =C2=A0create mode 100644 target/avr/cpu.h
>      =C2=A0create mode 100644 target/avr/helper.h
>      =C2=A0create mode 100644 hw/avr/arduino.c
>      =C2=A0create mode 100644 hw/avr/atmel_atmega.c
>      =C2=A0create mode 100644 hw/avr/boot.c
>      =C2=A0create mode 100644 hw/char/atmel_usart.c
>      =C2=A0create mode 100644 hw/misc/atmel_power.c
>      =C2=A0create mode 100644 hw/timer/atmel_timer16.c
>      =C2=A0create mode 100644 target/avr/cpu.c
>      =C2=A0create mode 100644 target/avr/disas.c
>      =C2=A0create mode 100644 target/avr/gdbstub.c
>      =C2=A0create mode 100644 target/avr/helper.c
>      =C2=A0create mode 100644 target/avr/machine.c
>      =C2=A0create mode 100644 target/avr/translate.c
>      =C2=A0create mode 100644 gdb-xml/avr-cpu.xml
>      =C2=A0create mode 100644 hw/avr/Kconfig
>      =C2=A0create mode 100644 hw/avr/Makefile.objs
>      =C2=A0create mode 100644 target/avr/Makefile.objs
>      =C2=A0create mode 100644 target/avr/insn.decode
>      =C2=A0create mode 100644 tests/acceptance/machine_avr6.py
>=20
>     --=20
>     2.21.1
>=20
>=20
>=20
> --=20
> Best Regards,
> Michael Rolnik


