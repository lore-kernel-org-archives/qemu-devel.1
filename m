Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C892C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B4F20708
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCNly3c5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B4F20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhx3-0006JF-8k
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:39:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iwhw3-00059N-41
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iwhw0-0007Nw-IU
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:38:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30861
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iwhvz-0007M1-Fs
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580283526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BVouiB7cX6UAz1EuHq1iPrnS+RuqIUVEZFoVzYCiKo4=;
 b=GCNly3c5dVhKN5uKRsYYYZkqRjbRT3fvczpIbovI2ToGOKfPpABFvpS4hStZFHrAytlpVh
 4OVjtJ78H2qQceger3ffZA3E7AgjgDfM2OXVBLopO+B1OqRH3VJFb8kJ6vdyJRaQQlSwOO
 pwaXQ19ae1XcMGptsM754W/KJVMT//M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-NRFiXRenP6esGVJvzwOHvg-1; Wed, 29 Jan 2020 02:38:42 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so2019262wma.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 23:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sDA9XPzYOH0YwnMweZz0iziK+flIOqnwcwlMUtgXUDo=;
 b=XFvf2jfraZQjNd9t/d0nDTuRUC1mryYWYhEsN9pxyDt2JWzZofqxORxZxUq5A4Lo6y
 NhXSXEuI2j3QGsmBOMnHArBiXovex3DcbJVOAsFN94zn9ZBlvxil7CJjBmBosW7IUDXq
 7Al2LQMCzC2j5wTwRcjg6yh6PKZzY0MyVynxI8k9kinKrTcmSQu4pofT4Idu7YKDP0+k
 VlaOthyTOakKoD9wY6z9mypBmc2wbj6KA//+e6BCL4v6tc6nYpsJdM7bF9cZc4dWGUzU
 8/Su+YG2i+GH3j5fGn60SNYKVHYUlkDQZNc11ptD8h058gmAinNhSc8iPBoE1342sKfF
 0j5w==
X-Gm-Message-State: APjAAAUsnD8hlyahpxTw220lCNar4plDQRJWAzDh9Jpjw0vn4t1BOM3Z
 sXarTIZFzJvLKMxJso3U2yBse+bISLtkz7bNBPGDy5HYWVHEWBmf5eMGicIf+LRH8o5A6/EYSBF
 /zOsl6+WhUYoVoAI=
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr33051514wrw.319.1580283520862; 
 Tue, 28 Jan 2020 23:38:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDPgO4WMKBmKXESLFD9tasVltX5l0S90mL4vksHWchHdc1e7REqFhPhcQKnn7HwBH0sVF46Q==
X-Received: by 2002:a5d:67c7:: with SMTP id n7mr33051469wrw.319.1580283520430; 
 Tue, 28 Jan 2020 23:38:40 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id w13sm1732012wru.38.2020.01.28.23.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 23:38:39 -0800 (PST)
Subject: Re: [PATCH rc3 01/30] target/avr: Add basic parameters for new AVR
 platform
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Michael Rolnik <mrolnik@gmail.com>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAK4993itnp5EyT8g-zGcMY6Oud9pC9GRv1Aa2dvofrH8mLWnOQ@mail.gmail.com>
 <CAK4993hTqhuZArVNbNs8M8MJkdQbneq0fCsW2b2-fEKaAtCuOQ@mail.gmail.com>
 <CAL1e-=jeQAqQ3GrVg2z9Y9qW+5KXvOURhpX6ApM5SJ2aJ8oDMQ@mail.gmail.com>
 <CAK4993jy-nPPANFW9aFW7Kk=B7EpOqdq8Pf9qStn5g+gevNHYg@mail.gmail.com>
 <CAL1e-=hn3kJw6hVkDeP=-45WxMUVZfdrj=_DyAGJGFTTMJQp6w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ea8b187-e425-d7ac-bc91-6d36b3eaba69@redhat.com>
Date: Wed, 29 Jan 2020 08:38:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hn3kJw6hVkDeP=-45WxMUVZfdrj=_DyAGJGFTTMJQp6w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: NRFiXRenP6esGVJvzwOHvg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 7:01 PM, Aleksandar Markovic wrote:
> Works for me too.
>=20
>=20
> 16:10 Uto, 28.01.2020. Michael Rolnik <mrolnik@gmail.com=20
> <mailto:mrolnik@gmail.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>=20
>     Sounds good to me.
>=20
>     On Tue, Jan 28, 2020 at 3:49 PM Aleksandar Markovic
>     <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
>     wrote:
>=20
>=20
>=20
>         On Tuesday, January 28, 2020, Michael Rolnik <mrolnik@gmail.com
>         <mailto:mrolnik@gmail.com>> wrote:
>=20
>             Hi all.
>=20
>             I am totally lost in the email.
>             Are there any action items for me / someone=C2=A0else ?
>=20
>             Regards,
>             Michael Rolnik
>=20
>=20
>         I think it would be helpful if we have rc4 with two action items:
>=20
>          =C2=A0 =C2=A0- remove CONFIG_USER_ONLY references, and all dead =
code thay
>         may have come with it + add check in cpu.h that Philippe suggeste=
d.
>          =C2=A0 =C2=A0- remove "Atmel" word from all elements of the seri=
es (patch
>         names, messages, filenames, structure names, ...)
>=20
>         Needless to say that this must be done with extreme care.
>=20
>         I propose that Philippe do rc4.

I won't have time to work on AVR this week-end and the next one (family=20
plans). If I find time I prefer prioritize the raspi machine because I=20
want to see some work merged before Igor "use memdev for RAM" series get=20
in. So if you guys have time & motivation, go for it!

>=20
>         Sincerely,
>         Aleksandar
>=20
>=20
>             On Mon, Jan 27, 2020 at 10:54 AM Michael Rolnik
>             <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
>=20
>                 Thanks for you help guys.
>=20
>                 On Mon, Jan 27, 2020 at 12:55 AM Aleksandar Markovic
>                 <aleksandar.markovic@rt-rk.com
>                 <mailto:aleksandar.markovic@rt-rk.com>> wrote:
>=20
>                     From: Michael Rolnik <mrolnik@gmail.com
>                     <mailto:mrolnik@gmail.com>>
>=20
>                     This includes definitions of various basic
>                     parameters needed
>                     for integration of a new platform into QEMU.
>=20
>                     Co-developed-by: Michael Rolnik <mrolnik@gmail.com
>                     <mailto:mrolnik@gmail.com>>
>                     Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk
>                     <mailto:S.E.Harris@kent.ac.uk>>
>                     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>                     <mailto:mrolnik@gmail.com>>
>                     Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
>                     <mailto:S.E.Harris@kent.ac.uk>>
>                     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
>                     <mailto:mrolnik@gmail.com>>
>                     Acked-by: Igor Mammedov <imammedo@redhat.com
>                     <mailto:imammedo@redhat.com>>
>                     Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com
>                     <mailto:philmd@redhat.com>>
>                     Signed-off-by: Richard Henderson
>                     <richard.henderson@linaro.org
>                     <mailto:richard.henderson@linaro.org>>
>                     Signed-off-by: Aleksandar Markovic
>                     <aleksandar.m.mail@gmail.com
>                     <mailto:aleksandar.m.mail@gmail.com>>
>                     ---
>                      =C2=A0target/avr/cpu-param.h | 37 ++++++++++++++++++=
++++++++
>                      =C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 7=
2
>                     ++++++++++++++++++++++++++++++++++++++++++++++++++
>                      =C2=A02 files changed, 109 insertions(+)
>                      =C2=A0create mode 100644 target/avr/cpu-param.h
>                      =C2=A0create mode 100644 target/avr/cpu.h
>=20
>                     diff --git a/target/avr/cpu-param.h
>                     b/target/avr/cpu-param.h
>                     new file mode 100644
>                     index 0000000..0c29ce4
>                     --- /dev/null
>                     +++ b/target/avr/cpu-param.h
>                     @@ -0,0 +1,37 @@
>                     +/*
>                     + * QEMU AVR CPU
>                     + *
>                     + * Copyright (c) 2019 Michael Rolnik
>                     + *
>                     + * This library is free software; you can
>                     redistribute it and/or
>                     + * modify it under the terms of the GNU Lesser
>                     General Public
>                     + * License as published by the Free Software
>                     Foundation; either
>                     + * version 2.1 of the License, or (at your option)
>                     any later version.
>                     + *
>                     + * This library is distributed in the hope that it
>                     will be useful,
>                     + * but WITHOUT ANY WARRANTY; without even the
>                     implied warranty of
>                     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR
>                     PURPOSE.=C2=A0 See the GNU
>                     + * Lesser General Public License for more details.
>                     + *
>                     + * You should have received a copy of the GNU
>                     Lesser General Public
>                     + * License along with this library; if not, see
>                     + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>                     + */
>                     +
>                     +#ifndef AVR_CPU_PARAM_H
>                     +#define AVR_CPU_PARAM_H
>                     +
>                     +#define TARGET_LONG_BITS 32
>                     +/*
>                     + * TARGET_PAGE_BITS cannot be more than 8 bits becau=
se
>                     + * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00f=
f]
>                     address range, and they
>                     + *=C2=A0 =C2=A0 =C2=A0should be implemented as a dev=
ice and not memory
>                     + * 2.=C2=A0 SRAM starts at the address 0x0100
>                     + */
>                     +#define TARGET_PAGE_BITS 8
>                     +#define TARGET_PHYS_ADDR_SPACE_BITS 24
>                     +#define TARGET_VIRT_ADDR_SPACE_BITS 24
>                     +#define NB_MMU_MODES 2
>                     +
>                     +
>                     +#endif
>                     diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>                     new file mode 100644
>                     index 0000000..d122611
>                     --- /dev/null
>                     +++ b/target/avr/cpu.h
>                     @@ -0,0 +1,72 @@
>                     +/*
>                     + * QEMU AVR CPU
>                     + *
>                     + * Copyright (c) 2019 Michael Rolnik
>                     + *
>                     + * This library is free software; you can
>                     redistribute it and/or
>                     + * modify it under the terms of the GNU Lesser
>                     General Public
>                     + * License as published by the Free Software
>                     Foundation; either
>                     + * version 2.1 of the License, or (at your option)
>                     any later version.
>                     + *
>                     + * This library is distributed in the hope that it
>                     will be useful,
>                     + * but WITHOUT ANY WARRANTY; without even the
>                     implied warranty of
>                     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR
>                     PURPOSE.=C2=A0 See the GNU
>                     + * Lesser General Public License for more details.
>                     + *
>                     + * You should have received a copy of the GNU
>                     Lesser General Public
>                     + * License along with this library; if not, see
>                     + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>                     + */
>                     +
>                     +#ifndef QEMU_AVR_CPU_H
>                     +#define QEMU_AVR_CPU_H
>                     +
>                     +#include "cpu-qom.h"
>                     +#include "exec/cpu-defs.h"
>                     +
>                     +#define TCG_GUEST_DEFAULT_MO 0
>                     +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
>                     +#define AVR_CPU_TYPE_NAME(name) (name
>                     AVR_CPU_TYPE_SUFFIX)
>                     +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
>                     +
>                     +/*
>                     + * AVR has two memory spaces, data & code.
>                     + * e.g. both have 0 address
>                     + * ST/LD instructions access data space
>                     + * LPM/SPM and instruction fetching access code
>                     memory space
>                     + */
>                     +#define MMU_CODE_IDX 0
>                     +#define MMU_DATA_IDX 1
>                     +
>                     +#define EXCP_RESET 1
>                     +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
>                     +
>                     +/* Number of CPU registers */
>                     +#define NUMBER_OF_CPU_REGISTERS 32
>                     +/* Number of IO registers accessible by ld/st/in/out=
 */
>                     +#define NUMBER_OF_IO_REGISTERS 64
>                     +
>                     +/*
>                     + * Offsets of AVR memory regions in host memory spac=
e.
>                     + *
>                     + * This is needed because the AVR has separate code
>                     and data address
>                     + * spaces that both have start from zero but have
>                     to go somewhere in
>                     + * host memory.
>                     + *
>                     + * It's also useful to know where some things are,
>                     like the IO registers.
>                     + */
>                     +/* Flash program memory */
>                     +#define OFFSET_CODE 0x00000000
>                     +/* CPU registers, IO registers, and SRAM */
>                     +#define OFFSET_DATA 0x00800000
>                     +/* CPU registers specifically, these are mapped at
>                     the start of data */
>                     +#define OFFSET_CPU_REGISTERS OFFSET_DATA
>                     +/*
>                     + * IO registers, including status register, stack
>                     pointer, and memory
>                     + * mapped peripherals, mapped just after CPU registe=
rs
>                     + */
>                     +#define OFFSET_IO_REGISTERS (OFFSET_DATA +
>                     NUMBER_OF_CPU_REGISTERS)
>                     +
>                     +#define EF_AVR_MACH 0x7F
>                     +
>                     +#endif /* !defined (QEMU_AVR_CPU_H) */
>                     --=20
>                     2.7.4
>=20
>=20
>=20
>                 --=20
>                 Best Regards,
>                 Michael Rolnik
>=20
>=20
>=20
>             --=20
>             Best Regards,
>             Michael Rolnik
>=20
>=20
>=20
>     --=20
>     Best Regards,
>     Michael Rolnik
>=20


