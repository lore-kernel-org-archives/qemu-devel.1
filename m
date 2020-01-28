Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74882C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:11:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F682207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvQKT5uB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F682207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwSWv-0001UH-D4
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iwSVR-0000Qb-S6
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iwSVO-0007pf-3W
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:10:21 -0500
Received: from mail-qv1-xf41.google.com ([2607:f8b0:4864:20::f41]:45581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iwSVN-0007ol-Sc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:10:18 -0500
Received: by mail-qv1-xf41.google.com with SMTP id l14so6377135qvu.12
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 07:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/3i+6uWHntbFVMTXt5pWQP2Zse5t11nwBwzHH6oXH1c=;
 b=FvQKT5uBmfmt7qw5EZb0YySAwi2ktD0TAO3jQcYviFbWmOco28bgar6cxt7cQ5j3oB
 zHPwww5BewbY8TFL1TkDRjk2MZWrLaHgyuEULXLJsvbBzrtdghKMZ/AITm9T79SuONvV
 +XsAJN22a/P69UZLFR3KEeT0AwdZfhZ+jI44zOqzHAEUsJvA6+3izJvMUJR7EqO4Zcnk
 eEddNvHhq3wlIxnAG5dk+8VVq8i/mSNwN/9wdayihi+QVxEb7EcL0plb7B2Uo590cJ5P
 9M8TE8IP+GK1CXbihNuFYSF6PrdI5xblCU44ngGPIniJGtdhP3S2M4DhfBqmNGsP4mAW
 mc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/3i+6uWHntbFVMTXt5pWQP2Zse5t11nwBwzHH6oXH1c=;
 b=mYp9IXy4naxo8TpWKPXNDrPBXdF9U9xStf0KAzAWxtYAnV7/0TwmTZ/9lDsrVteHIu
 kTRQcsTT4eU37gvepaFN/kyvhqx/A9Hcr7oBVS4OMWW74EN8rMmsf4tgofHIRBwlSNEW
 KoK5vXxJDLXYKV4E7WrcDYh7F7D3WfsSauGmp84mw1hKRXxbp6TmtQOWDGpce8ZiRTOa
 EniNUpmd+kuQl6Wt+ElKhlN3Jarkp0NM+51eKSO8rlox0cHDB9IWHuM9RYHBIUfDy0VU
 NTKNvyTVGcB8trJ0/Sqzi2ZWNKRh0Y+PoYE1P+RfmZYOJAV0X0XH43xfJo5BbVwZmeUo
 kf5w==
X-Gm-Message-State: APjAAAUD4xug5csizJWHPiORDCizqPAvC4cD1zpvE9yFyLPjD3X/N/Ll
 3RU0l1cYes0RbFy+LZkwRO82n/aKc0VvIRLc2HQ=
X-Google-Smtp-Source: APXvYqwS+pFA67s9ALsm4chkaYOmj1RQM02tqYFzulglRabI0fOI8/zAIfWaMaLqOuL0ygbYgRkHpwNdz61jYln5kFw=
X-Received: by 2002:a0c:8d0a:: with SMTP id r10mr21399093qvb.7.1580224216687; 
 Tue, 28 Jan 2020 07:10:16 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAK4993itnp5EyT8g-zGcMY6Oud9pC9GRv1Aa2dvofrH8mLWnOQ@mail.gmail.com>
 <CAK4993hTqhuZArVNbNs8M8MJkdQbneq0fCsW2b2-fEKaAtCuOQ@mail.gmail.com>
 <CAL1e-=jeQAqQ3GrVg2z9Y9qW+5KXvOURhpX6ApM5SJ2aJ8oDMQ@mail.gmail.com>
In-Reply-To: <CAL1e-=jeQAqQ3GrVg2z9Y9qW+5KXvOURhpX6ApM5SJ2aJ8oDMQ@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 28 Jan 2020 17:10:09 +0200
Message-ID: <CAK4993jy-nPPANFW9aFW7Kk=B7EpOqdq8Pf9qStn5g+gevNHYg@mail.gmail.com>
Subject: Re: [PATCH rc3 01/30] target/avr: Add basic parameters for new AVR
 platform
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000019e9f6059d349f7c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f41
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000019e9f6059d349f7c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good to me.

On Tue, Jan 28, 2020 at 3:49 PM Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Tuesday, January 28, 2020, Michael Rolnik <mrolnik@gmail.com> wrote:
>
>> Hi all.
>>
>> I am totally lost in the email.
>> Are there any action items for me / someone else ?
>>
>> Regards,
>> Michael Rolnik
>>
>>
> I think it would be helpful if we have rc4 with two action items:
>
>    - remove CONFIG_USER_ONLY references, and all dead code thay may have
> come with it + add check in cpu.h that Philippe suggested.
>    - remove "Atmel" word from all elements of the series (patch names,
> messages, filenames, structure names, ...)
>
> Needless to say that this must be done with extreme care.
>
> I propose that Philippe do rc4.
>
> Sincerely,
> Aleksandar
>
>
>
>>
>> On Mon, Jan 27, 2020 at 10:54 AM Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>>
>>> Thanks for you help guys.
>>>
>>> On Mon, Jan 27, 2020 at 12:55 AM Aleksandar Markovic <
>>> aleksandar.markovic@rt-rk.com> wrote:
>>>
>>>> From: Michael Rolnik <mrolnik@gmail.com>
>>>>
>>>> This includes definitions of various basic parameters needed
>>>> for integration of a new platform into QEMU.
>>>>
>>>> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
>>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>>> Acked-by: Igor Mammedov <imammedo@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>>>> ---
>>>>  target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++
>>>>  target/avr/cpu.h       | 72
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 109 insertions(+)
>>>>  create mode 100644 target/avr/cpu-param.h
>>>>  create mode 100644 target/avr/cpu.h
>>>>
>>>> diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
>>>> new file mode 100644
>>>> index 0000000..0c29ce4
>>>> --- /dev/null
>>>> +++ b/target/avr/cpu-param.h
>>>> @@ -0,0 +1,37 @@
>>>> +/*
>>>> + * QEMU AVR CPU
>>>> + *
>>>> + * Copyright (c) 2019 Michael Rolnik
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see
>>>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>>>> + */
>>>> +
>>>> +#ifndef AVR_CPU_PARAM_H
>>>> +#define AVR_CPU_PARAM_H
>>>> +
>>>> +#define TARGET_LONG_BITS 32
>>>> +/*
>>>> + * TARGET_PAGE_BITS cannot be more than 8 bits because
>>>> + * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and
>>>> they
>>>> + *     should be implemented as a device and not memory
>>>> + * 2.  SRAM starts at the address 0x0100
>>>> + */
>>>> +#define TARGET_PAGE_BITS 8
>>>> +#define TARGET_PHYS_ADDR_SPACE_BITS 24
>>>> +#define TARGET_VIRT_ADDR_SPACE_BITS 24
>>>> +#define NB_MMU_MODES 2
>>>> +
>>>> +
>>>> +#endif
>>>> diff --git a/target/avr/cpu.h b/target/avr/cpu.h
>>>> new file mode 100644
>>>> index 0000000..d122611
>>>> --- /dev/null
>>>> +++ b/target/avr/cpu.h
>>>> @@ -0,0 +1,72 @@
>>>> +/*
>>>> + * QEMU AVR CPU
>>>> + *
>>>> + * Copyright (c) 2019 Michael Rolnik
>>>> + *
>>>> + * This library is free software; you can redistribute it and/or
>>>> + * modify it under the terms of the GNU Lesser General Public
>>>> + * License as published by the Free Software Foundation; either
>>>> + * version 2.1 of the License, or (at your option) any later version.
>>>> + *
>>>> + * This library is distributed in the hope that it will be useful,
>>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>>> + * Lesser General Public License for more details.
>>>> + *
>>>> + * You should have received a copy of the GNU Lesser General Public
>>>> + * License along with this library; if not, see
>>>> + * <http://www.gnu.org/licenses/lgpl-2.1.html>
>>>> + */
>>>> +
>>>> +#ifndef QEMU_AVR_CPU_H
>>>> +#define QEMU_AVR_CPU_H
>>>> +
>>>> +#include "cpu-qom.h"
>>>> +#include "exec/cpu-defs.h"
>>>> +
>>>> +#define TCG_GUEST_DEFAULT_MO 0
>>>> +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
>>>> +#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
>>>> +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
>>>> +
>>>> +/*
>>>> + * AVR has two memory spaces, data & code.
>>>> + * e.g. both have 0 address
>>>> + * ST/LD instructions access data space
>>>> + * LPM/SPM and instruction fetching access code memory space
>>>> + */
>>>> +#define MMU_CODE_IDX 0
>>>> +#define MMU_DATA_IDX 1
>>>> +
>>>> +#define EXCP_RESET 1
>>>> +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
>>>> +
>>>> +/* Number of CPU registers */
>>>> +#define NUMBER_OF_CPU_REGISTERS 32
>>>> +/* Number of IO registers accessible by ld/st/in/out */
>>>> +#define NUMBER_OF_IO_REGISTERS 64
>>>> +
>>>> +/*
>>>> + * Offsets of AVR memory regions in host memory space.
>>>> + *
>>>> + * This is needed because the AVR has separate code and data address
>>>> + * spaces that both have start from zero but have to go somewhere in
>>>> + * host memory.
>>>> + *
>>>> + * It's also useful to know where some things are, like the IO
>>>> registers.
>>>> + */
>>>> +/* Flash program memory */
>>>> +#define OFFSET_CODE 0x00000000
>>>> +/* CPU registers, IO registers, and SRAM */
>>>> +#define OFFSET_DATA 0x00800000
>>>> +/* CPU registers specifically, these are mapped at the start of data =
*/
>>>> +#define OFFSET_CPU_REGISTERS OFFSET_DATA
>>>> +/*
>>>> + * IO registers, including status register, stack pointer, and memory
>>>> + * mapped peripherals, mapped just after CPU registers
>>>> + */
>>>> +#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
>>>> +
>>>> +#define EF_AVR_MACH 0x7F
>>>> +
>>>> +#endif /* !defined (QEMU_AVR_CPU_H) */
>>>> --
>>>> 2.7.4
>>>>
>>>>
>>>
>>> --
>>> Best Regards,
>>> Michael Rolnik
>>>
>>
>>
>> --
>> Best Regards,
>> Michael Rolnik
>>
>

--=20
Best Regards,
Michael Rolnik

--00000000000019e9f6059d349f7c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Sounds good to me.=C2=A0<br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 28, 2020 at 3:49 P=
M Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gmail.com">al=
eksandar.m.mail@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><br><br>On Tuesday, January 28, 2020, Michael Roln=
ik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmail=
.com</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr">Hi all.<div><br></div><div>I am totally lost in the email.</=
div><div>Are there any action items for me / someone=C2=A0else ?</div><div>=
<br></div><div>Regards,</div><div>Michael Rolnik</div><div><br></div></div>=
</blockquote><div><br></div><div>I think it would be helpful if we have rc4=
 with two action items:</div><div><br></div><div>=C2=A0 =C2=A0- remove CONF=
IG_USER_ONLY references, and all dead code thay may have come with it + add=
 check in cpu.h that Philippe suggested.</div><div>=C2=A0 =C2=A0- remove &q=
uot;Atmel&quot; word from all elements of the series (patch names, messages=
, filenames, structure names, ...)</div><div><br></div><div>Needless to say=
 that this must be done with extreme care.</div><div><br></div><div>I propo=
se that Philippe do rc4.</div><div><br></div><div>Sincerely,</div><div>Alek=
sandar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 27, 2020 at 10:54 AM Michae=
l Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">Thanks for you help guys.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 27, 2020=
 at 12:55 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.markovic@=
rt-rk.com" target=3D"_blank">aleksandar.markovic@rt-rk.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: Michael Rol=
nik &lt;<a href=3D"mailto:mrolnik@gmail.com" target=3D"_blank">mrolnik@gmai=
l.com</a>&gt;<br>
<br>
This includes definitions of various basic parameters needed<br>
for integration of a new platform into QEMU.<br>
<br>
Co-developed-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" ta=
rget=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Co-developed-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" =
target=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Signed-off-by: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk" ta=
rget=3D"_blank">S.E.Harris@kent.ac.uk</a>&gt;<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Acked-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=
=3D"_blank">imammedo@redhat.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@=
gmail.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 72 +++++++++++++++++++++=
+++++++++++++++++++++++++++++<br>
=C2=A02 files changed, 109 insertions(+)<br>
=C2=A0create mode 100644 target/avr/cpu-param.h<br>
=C2=A0create mode 100644 target/avr/cpu.h<br>
<br>
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h<br>
new file mode 100644<br>
index 0000000..0c29ce4<br>
--- /dev/null<br>
+++ b/target/avr/cpu-param.h<br>
@@ -0,0 +1,37 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"norefe=
rrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&gt;<b=
r>
+ */<br>
+<br>
+#ifndef AVR_CPU_PARAM_H<br>
+#define AVR_CPU_PARAM_H<br>
+<br>
+#define TARGET_LONG_BITS 32<br>
+/*<br>
+ * TARGET_PAGE_BITS cannot be more than 8 bits because<br>
+ * 1.=C2=A0 all IO registers occupy [0x0000 .. 0x00ff] address range, and =
they<br>
+ *=C2=A0 =C2=A0 =C2=A0should be implemented as a device and not memory<br>
+ * 2.=C2=A0 SRAM starts at the address 0x0100<br>
+ */<br>
+#define TARGET_PAGE_BITS 8<br>
+#define TARGET_PHYS_ADDR_SPACE_BITS 24<br>
+#define TARGET_VIRT_ADDR_SPACE_BITS 24<br>
+#define NB_MMU_MODES 2<br>
+<br>
+<br>
+#endif<br>
diff --git a/target/avr/cpu.h b/target/avr/cpu.h<br>
new file mode 100644<br>
index 0000000..d122611<br>
--- /dev/null<br>
+++ b/target/avr/cpu.h<br>
@@ -0,0 +1,72 @@<br>
+/*<br>
+ * QEMU AVR CPU<br>
+ *<br>
+ * Copyright (c) 2019 Michael Rolnik<br>
+ *<br>
+ * This library is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU Lesser General Public<br>
+ * License as published by the Free Software Foundation; either<br>
+ * version 2.1 of the License, or (at your option) any later version.<br>
+ *<br>
+ * This library is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<=
br>
+ * Lesser General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU Lesser General Public<br>
+ * License along with this library; if not, see<br>
+ * &lt;<a href=3D"http://www.gnu.org/licenses/lgpl-2.1.html" rel=3D"norefe=
rrer" target=3D"_blank">http://www.gnu.org/licenses/lgpl-2.1.html</a>&gt;<b=
r>
+ */<br>
+<br>
+#ifndef QEMU_AVR_CPU_H<br>
+#define QEMU_AVR_CPU_H<br>
+<br>
+#include &quot;cpu-qom.h&quot;<br>
+#include &quot;exec/cpu-defs.h&quot;<br>
+<br>
+#define TCG_GUEST_DEFAULT_MO 0<br>
+#define AVR_CPU_TYPE_SUFFIX &quot;-&quot; TYPE_AVR_CPU<br>
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)<br>
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU<br>
+<br>
+/*<br>
+ * AVR has two memory spaces, data &amp; code.<br>
+ * e.g. both have 0 address<br>
+ * ST/LD instructions access data space<br>
+ * LPM/SPM and instruction fetching access code memory space<br>
+ */<br>
+#define MMU_CODE_IDX 0<br>
+#define MMU_DATA_IDX 1<br>
+<br>
+#define EXCP_RESET 1<br>
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)<br>
+<br>
+/* Number of CPU registers */<br>
+#define NUMBER_OF_CPU_REGISTERS 32<br>
+/* Number of IO registers accessible by ld/st/in/out */<br>
+#define NUMBER_OF_IO_REGISTERS 64<br>
+<br>
+/*<br>
+ * Offsets of AVR memory regions in host memory space.<br>
+ *<br>
+ * This is needed because the AVR has separate code and data address<br>
+ * spaces that both have start from zero but have to go somewhere in<br>
+ * host memory.<br>
+ *<br>
+ * It&#39;s also useful to know where some things are, like the IO registe=
rs.<br>
+ */<br>
+/* Flash program memory */<br>
+#define OFFSET_CODE 0x00000000<br>
+/* CPU registers, IO registers, and SRAM */<br>
+#define OFFSET_DATA 0x00800000<br>
+/* CPU registers specifically, these are mapped at the start of data */<br=
>
+#define OFFSET_CPU_REGISTERS OFFSET_DATA<br>
+/*<br>
+ * IO registers, including status register, stack pointer, and memory<br>
+ * mapped peripherals, mapped just after CPU registers<br>
+ */<br>
+#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)<br>
+<br>
+#define EF_AVR_MACH 0x7F<br>
+<br>
+#endif /* !defined (QEMU_AVR_CPU_H) */<br>
-- <br>
2.7.4<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Best Regards,<br>Michael Rolnik</div>

--00000000000019e9f6059d349f7c--

