Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB0AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:18:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6959520678
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcmrwZSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6959520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOGS-0004Zt-MK
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOODq-0003Ak-Pn
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOODf-0003gN-UY
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:15:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41143)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLlx-0002D2-6n
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z9fk1FZ5PL/3L7zp+GTWtd8fh/sXn29wzFEZH+P5iIE=;
 b=UcmrwZSu+EBSYwrluS0ZAPwRtlmnGi7Cbt48DLyLxIry3ifXM8s4/ILlToAdTiPnpGsdgP
 UBE2vqxnQXxSFqFfo/0djxGKt/anEO5aI9BEOGJ9E3ynfnG8jNodEjkDOakATFpaXSX4Da
 XXqryrb5yVjlPbWIPkGD07hKb6JXQdo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-44tCwFUbP1OpRfPF7yajJw-1; Tue, 14 Apr 2020 09:38:34 -0400
X-MC-Unique: 44tCwFUbP1OpRfPF7yajJw-1
Received: by mail-wr1-f71.google.com with SMTP id f15so8746889wrj.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U2f8jlgchG9U7r9iqMBR+8QkZlGakwp21aGt7KBSf5o=;
 b=VGDiLYpZy+HM1PZEXtkNj55+eUgRyv00JBhARa37Mgl+6jJDBVVMkrisfFsV1UcZCz
 jIhTUMkP1tD6Wo3zDqWH/6TlfoIgVugggXThgjmDeSBYiDxGYihASuFEc4hBxda2FbdI
 Ajrgc56Ms/YRQ4QlzWuAdCClawFmjqkvFohqVfosZh8idqXgaz6oQgOE6qkCG0vSCrJF
 kGG92NJ9LXsqFVdXg/NBL8VNZVcsL/gpb4LC3GNSfY5fNxwjUwhHY9rBo20JrvAKW3ob
 BQDbnPErdzYJOnpiV9ysDPYvdZz5gOuQhAU/xiCCge9IpDlyMWSoSuKRhUFRORb+tcrA
 U/yA==
X-Gm-Message-State: AGi0PuZGj7HZUQupktKAEH2BxVHO7+afoqENNt/s0QXzEmksuNScrbfJ
 92XRfAAnX9SdzyeMYGpHG+j133LyiFuHVd+pzSqoMxb6yTcZvFIwiNyhsFMkGtcdjNh2oWVQV0Z
 FWNlRVwyvyb5J1A0=
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr23023670wmf.141.1586871512586; 
 Tue, 14 Apr 2020 06:38:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypK9qVbb7eL4h0LZJ9cK1gmKap1NB7SELjQGe6PNX19ZN1BryTgkCoJc/GQ/Y4L0+68FT+9s9g==
X-Received: by 2002:a1c:bd54:: with SMTP id n81mr23023589wmf.141.1586871511601; 
 Tue, 14 Apr 2020 06:38:31 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id n6sm19606047wrs.81.2020.04.14.06.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 06:38:30 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] gdbstub: Rename GByteArray variable 'mem_buf' as
 'array'
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200414112849.21787-1-philmd@redhat.com>
 <CAHiYmc6o0TKVmXO4LoR_63RE=u+5xArw-6q9r=w_30T0WOks-A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a096077a-49bf-c7c0-71ca-e7f057c15ad5@redhat.com>
Date: Tue, 14 Apr 2020 15:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc6o0TKVmXO4LoR_63RE=u+5xArw-6q9r=w_30T0WOks-A@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Chris Wulff <crwulff@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 3:35 PM, Aleksandar Markovic wrote:
> 1:28 PM Uto, 14.04.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
=20
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>  >
>  > GByteArray type has should not be treated as a u8[] buffer.
>  > The GLib Byte Arrays API should be used instead.
>  > Rename the 'mem_buf' variable as 'array' to make it more
>  > obvious in the code.
>  >
>=20
> Hi, Philippe.
>=20
> "array" is a horrible choice for a name. It must be more specific.

This is how the prototype is documented:

https://developer.gnome.org/glib/stable/glib-Byte-Arrays.html#g-byte-array-=
append

GByteArray *
g_byte_array_append (GByteArray *array,
                      const guint8 *data,
                      guint len);

What do you suggest?

>=20
> Regards,
> Aleksandar
>=20
>  > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=20
> <mailto:philmd@redhat.com>>
>  > ---
>  > Based-on: <20200414111846.27495-1-philmd@redhat.com=20
> <mailto:20200414111846.27495-1-philmd@redhat.com>>
>  > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=20
> <mailto:philmd@redhat.com>>
>  > ---
>  > =C2=A0include/exec/gdbstub.h=C2=A0 =C2=A0 =C2=A0 | 34 +++++++-------
>  > =C2=A0include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>  > =C2=A0target/alpha/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +=
-
>  > =C2=A0target/arm/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 4 +-
>  > =C2=A0target/cris/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 4 +-
>  > =C2=A0target/hppa/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-
>  > =C2=A0target/i386/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-
>  > =C2=A0target/lm32/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-
>  > =C2=A0target/m68k/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-
>  > =C2=A0target/microblaze/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>  > =C2=A0target/mips/internal.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +-
>  > =C2=A0target/openrisc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>  > =C2=A0target/ppc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 4 +-
>  > =C2=A0target/riscv/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +=
-
>  > =C2=A0target/rx/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-
>  > =C2=A0target/s390x/internal.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-
>  > =C2=A0target/sh4/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 +-
>  > =C2=A0target/sparc/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 +=
-
>  > =C2=A0target/xtensa/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +=
-
>  > =C2=A0gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 6 +--
>  > =C2=A0hw/core/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 +-
>  > =C2=A0target/alpha/gdbstub.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +-
>  > =C2=A0target/arm/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++--
>  > =C2=A0target/arm/gdbstub64.c=C2=A0 =C2=A0 =C2=A0 | 10 ++--
>  > =C2=A0target/cris/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 34 +++++++----=
---
>  > =C2=A0target/hppa/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +--
>  > =C2=A0target/i386/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 92 +++++++++++=
+++++++-------------------
>  > =C2=A0target/lm32/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 18 ++++----
>  > =C2=A0target/m68k/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 ++--
>  > =C2=A0target/m68k/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 24 +++++-----
>  > =C2=A0target/microblaze/gdbstub.c |=C2=A0 6 +--
>  > =C2=A0target/mips/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++++++-----=
-
>  > =C2=A0target/nios2/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +=
+--
>  > =C2=A0target/openrisc/gdbstub.c=C2=A0 =C2=A0| 10 ++--
>  > =C2=A0target/riscv/gdbstub.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +--
>  > =C2=A0target/rx/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 22 ++++--=
---
>  > =C2=A0target/s390x/gdbstub.c=C2=A0 =C2=A0 =C2=A0 | 28 +++++------
>  > =C2=A0target/sh4/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 38 +++++++----=
----
>  > =C2=A0target/sparc/gdbstub.c=C2=A0 =C2=A0 =C2=A0 | 46 +++++++++-------=
---
>  > =C2=A0target/xtensa/gdbstub.c=C2=A0 =C2=A0 =C2=A0| 20 ++++----
>  > =C2=A040 files changed, 254 insertions(+), 253 deletions(-)
>  >
>  > diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>  > index 52a4a936c6..29150d1344 100644
>  > --- a/include/exec/gdbstub.h
>  > +++ b/include/exec/gdbstub.h
>  > @@ -80,47 +80,47 @@ void gdb_register_coprocessor(CPUState *cpu,
>  > =C2=A0 * append to the array.
>  > =C2=A0 */
>  >
>  > -static inline int gdb_get_reg8(GByteArray *buf, uint8_t val)
>  > +static inline int gdb_get_reg8(GByteArray *array, uint8_t val)
>  > =C2=A0{
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, &val, 1);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, &val, 1);
>  > =C2=A0 =C2=A0 =C2=A0return 1;
>  > =C2=A0}
>  >
>  > -static inline int gdb_get_reg16(GByteArray *buf, uint16_t val)
>  > +static inline int gdb_get_reg16(GByteArray *array, uint16_t val)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0uint16_t to_word =3D tswap16(val);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_word, 2);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_word, 2);
>  > =C2=A0 =C2=A0 =C2=A0return 2;
>  > =C2=A0}
>  >
>  > -static inline int gdb_get_reg32(GByteArray *buf, uint32_t val)
>  > +static inline int gdb_get_reg32(GByteArray *array, uint32_t val)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0uint32_t to_long =3D tswap32(val);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_long, 4);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_long, 4);
>  > =C2=A0 =C2=A0 =C2=A0return 4;
>  > =C2=A0}
>  >
>  > -static inline int gdb_get_reg64(GByteArray *buf, uint64_t val)
>  > +static inline int gdb_get_reg64(GByteArray *array, uint64_t val)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0uint64_t to_quad =3D tswap64(val);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_quad, 8);
>  > =C2=A0 =C2=A0 =C2=A0return 8;
>  > =C2=A0}
>  >
>  > -static inline int gdb_get_reg128(GByteArray *buf, uint64_t val_hi,
>  > +static inline int gdb_get_reg128(GByteArray *array, uint64_t val_hi,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t val_lo)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0uint64_t to_quad;
>  > =C2=A0#ifdef TARGET_WORDS_BIGENDIAN
>  > =C2=A0 =C2=A0 =C2=A0to_quad =3D tswap64(val_hi);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_quad, 8);
>  > =C2=A0 =C2=A0 =C2=A0to_quad =3D tswap64(val_lo);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_quad, 8);
>  > =C2=A0#else
>  > =C2=A0 =C2=A0 =C2=A0to_quad =3D tswap64(val_lo);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_quad, 8);
>  > =C2=A0 =C2=A0 =C2=A0to_quad =3D tswap64(val_hi);
>  > -=C2=A0 =C2=A0 g_byte_array_append(buf, (uint8_t *) &to_quad, 8);
>  > +=C2=A0 =C2=A0 g_byte_array_append(array, (uint8_t *) &to_quad, 8);
>  > =C2=A0#endif
>  > =C2=A0 =C2=A0 =C2=A0return 16;
>  > =C2=A0}
>  > @@ -154,16 +154,16 @@ static inline int gdb_get_zeroes(GByteArray=20
> *array, size_t len)
>  > =C2=A0 * element for additional processing. Some front-ends do additio=
nal
>  > =C2=A0 * dynamic swapping of the elements based on CPU state.
>  > =C2=A0 */
>  > -static inline uint8_t * gdb_get_reg_ptr(GByteArray *buf, int len)
>  > +static inline uint8_t *gdb_get_reg_ptr(GByteArray *array, int len)
>  > =C2=A0{
>  > -=C2=A0 =C2=A0 return buf->data + buf->len - len;
>  > +=C2=A0 =C2=A0 return array->data + array->len - len;
>  > =C2=A0}
>  >
>  > =C2=A0#if TARGET_LONG_BITS =3D=3D 64
>  > -#define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
>  > +#define gdb_get_regl(array, val) gdb_get_reg64(array, val)
>  > =C2=A0#define ldtul_p(addr) ldq_p(addr)
>  > =C2=A0#else
>  > -#define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
>  > +#define gdb_get_regl(array, val) gdb_get_reg32(array, val)
>  > =C2=A0#define ldtul_p(addr) ldl_p(addr)
>  > =C2=A0#endif
>  >
>  > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>  > index 5bf94d28cf..31434d3b1f 100644
>  > --- a/include/hw/core/cpu.h
>  > +++ b/include/hw/core/cpu.h
>  > @@ -193,7 +193,7 @@ typedef struct CPUClass {
>  > =C2=A0 =C2=A0 =C2=A0hwaddr (*get_phys_page_attrs_debug)(CPUState *cpu,=
 vaddr addr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0MemTxAttrs *attrs);
>  > =C2=A0 =C2=A0 =C2=A0int (*asidx_from_attrs)(CPUState *cpu, MemTxAttrs =
attrs);
>  > -=C2=A0 =C2=A0 int (*gdb_read_register)(CPUState *cpu, GByteArray *buf=
, int reg);
>  > +=C2=A0 =C2=A0 int (*gdb_read_register)(CPUState *cpu, GByteArray *arr=
ay, int reg);
>  > =C2=A0 =C2=A0 =C2=A0int (*gdb_write_register)(CPUState *cpu, uint8_t *=
buf, int reg);
>  > =C2=A0 =C2=A0 =C2=A0bool (*debug_check_watchpoint)(CPUState *cpu, CPUW=
atchpoint *wp);
>  > =C2=A0 =C2=A0 =C2=A0void (*debug_excp_handler)(CPUState *cpu);
>  > diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
>  > index be29bdd530..94853d0bee 100644
>  > --- a/target/alpha/cpu.h
>  > +++ b/target/alpha/cpu.h
>  > @@ -280,7 +280,7 @@ void alpha_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool alpha_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > =C2=A0void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags);
>  > =C2=A0hwaddr alpha_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int=
=20
> reg);
>  > +int alpha_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=20
> int reg);
>  > =C2=A0int alpha_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, in=
t reg);
>  > =C2=A0void alpha_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMUAccessType acces=
s_type,
>  > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>  > index 8b9f2961ba..cbd3a262f3 100644
>  > --- a/target/arm/cpu.h
>  > +++ b/target/arm/cpu.h
>  > @@ -975,7 +975,7 @@ bool arm_cpu_exec_interrupt(CPUState *cpu, int=20
> int_req);
>  > =C2=A0hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr ad=
dr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MemTxAttrs *attrs);
>  >
>  > -int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);
>  > +int arm_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int =
reg);
>  >
>  > =C2=A0/*
>  > @@ -997,7 +997,7 @@ int=20
> arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int cpuid, void *opaque);
>  >
>  > =C2=A0#ifdef TARGET_AARCH64
>  > -int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,=20
> int reg);
>  > +int aarch64_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=
=20
> int reg);
>  > =C2=A0int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, =
int=20
> reg);
>  > =C2=A0void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  > =C2=A0void aarch64_sve_change_el(CPUARMState *env, int old_el,
>  > diff --git a/target/cris/cpu.h b/target/cris/cpu.h
>  > index 8f08d7628b..474a06f929 100644
>  > --- a/target/cris/cpu.h
>  > +++ b/target/cris/cpu.h
>  > @@ -195,8 +195,8 @@ void cris_cpu_dump_state(CPUState *cs, FILE *f,=20
> int flags);
>  >
>  > =C2=A0hwaddr cris_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  >
>  > -int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,=20
> int reg);
>  > -int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  > +int crisv10_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=
=20
> int reg);
>  > +int cris_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int cris_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int=
 reg);
>  >
>  > =C2=A0/* you can call this signal handler from your SIGBUS and SIGSEGV
>  > diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
>  > index 801a4fb1ba..d584ad49b4 100644
>  > --- a/target/hppa/cpu.h
>  > +++ b/target/hppa/cpu.h
>  > @@ -321,7 +321,7 @@ void cpu_hppa_change_prot_id(CPUHPPAState *env);
>  >
>  > =C2=A0int cpu_hppa_signal_handler(int host_signum, void *pinfo, void *=
puc);
>  > =C2=A0hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr);
>  > -int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  > +int hppa_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int hppa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int=
 reg);
>  > =C2=A0void hppa_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool hppa_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>  > index e818fc712a..9ad798c87e 100644
>  > --- a/target/i386/cpu.h
>  > +++ b/target/i386/cpu.h
>  > @@ -1770,7 +1770,7 @@ void x86_cpu_dump_state(CPUState *cs, FILE *f,=
=20
> int flags);
>  > =C2=A0hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr ad=
dr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MemTxAttrs *attrs);
>  >
>  > -int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);
>  > +int x86_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int x86_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int =
reg);
>  >
>  > =C2=A0void x86_cpu_exec_enter(CPUState *cpu);
>  > diff --git a/target/lm32/cpu.h b/target/lm32/cpu.h
>  > index 01d408eb55..b64e7fdc44 100644
>  > --- a/target/lm32/cpu.h
>  > +++ b/target/lm32/cpu.h
>  > @@ -202,7 +202,7 @@ void lm32_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool lm32_cpu_exec_interrupt(CPUState *cs, int int_req);
>  > =C2=A0void lm32_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr lm32_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  > +int lm32_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int lm32_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int=
 reg);
>  >
>  > =C2=A0typedef enum {
>  > diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
>  > index 521ac67cdd..705d26746d 100644
>  > --- a/target/m68k/cpu.h
>  > +++ b/target/m68k/cpu.h
>  > @@ -168,7 +168,7 @@ void m68k_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool m68k_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > =C2=A0void m68k_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr m68k_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  > +int m68k_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int m68k_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int=
 reg);
>  >
>  > =C2=A0void m68k_tcg_init(void);
>  > diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
>  > index 1a700a880c..77d6c859ae 100644
>  > --- a/target/microblaze/cpu.h
>  > +++ b/target/microblaze/cpu.h
>  > @@ -313,7 +313,7 @@ void mb_cpu_do_interrupt(CPUState *cs);
>  > =C2=A0bool mb_cpu_exec_interrupt(CPUState *cs, int int_req);
>  > =C2=A0void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr mb_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)=
;
>  > +int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int re=
g);
>  > =C2=A0int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int r=
eg);
>  >
>  > =C2=A0void mb_tcg_init(void);
>  > diff --git a/target/mips/internal.h b/target/mips/internal.h
>  > index 1bf274b3ef..27a9e811f7 100644
>  > --- a/target/mips/internal.h
>  > +++ b/target/mips/internal.h
>  > @@ -82,7 +82,7 @@ void mips_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool mips_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > =C2=A0void mips_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr mips_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  > +int mips_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int mips_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int=
 reg);
>  > =C2=A0void mips_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType access=
_type,
>  > diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
>  > index f37a52e153..1d2d5214c2 100644
>  > --- a/target/openrisc/cpu.h
>  > +++ b/target/openrisc/cpu.h
>  > @@ -320,7 +320,7 @@ void openrisc_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool openrisc_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > =C2=A0void openrisc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cpu, vaddr add=
r);
>  > -int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf,=20
> int reg);
>  > +int openrisc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=
=20
> int reg);
>  > =C2=A0int openrisc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf,=
 int=20
> reg);
>  > =C2=A0void openrisc_translate_init(void);
>  > =C2=A0bool openrisc_cpu_tlb_fill(CPUState *cs, vaddr address, int size=
,
>  > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>  > index 88d9449555..049400f8d7 100644
>  > --- a/target/ppc/cpu.h
>  > +++ b/target/ppc/cpu.h
>  > @@ -1207,8 +1207,8 @@ bool ppc_cpu_exec_interrupt(CPUState *cpu, int=
=20
> int_req);
>  > =C2=A0void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0void ppc_cpu_dump_statistics(CPUState *cpu, int flags);
>  > =C2=A0hwaddr ppc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg=
);
>  > -int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray *buf,=
=20
> int reg);
>  > +int ppc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > +int ppc_cpu_gdb_read_register_apple(CPUState *cpu, GByteArray=20
> *array, int reg);
>  > =C2=A0int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int =
reg);
>  > =C2=A0int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf=
,=20
> int reg);
>  > =C2=A0#ifndef CONFIG_USER_ONLY
>  > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>  > index 7d21addbab..806cb3b044 100644
>  > --- a/target/riscv/cpu.h
>  > +++ b/target/riscv/cpu.h
>  > @@ -293,7 +293,7 @@ extern const char * const riscv_excp_names[];
>  > =C2=A0extern const char * const riscv_intr_names[];
>  >
>  > =C2=A0void riscv_cpu_do_interrupt(CPUState *cpu);
>  > -int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int=
=20
> reg);
>  > +int riscv_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=20
> int reg);
>  > =C2=A0int riscv_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, in=
t reg);
>  > =C2=A0bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_reques=
t);
>  > =C2=A0bool riscv_cpu_fp_enabled(CPURISCVState *env);
>  > diff --git a/target/rx/cpu.h b/target/rx/cpu.h
>  > index d1fb1ef3ca..994ab0c6fd 100644
>  > --- a/target/rx/cpu.h
>  > +++ b/target/rx/cpu.h
>  > @@ -128,7 +128,7 @@ const char *rx_crname(uint8_t cr);
>  > =C2=A0void rx_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool rx_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > =C2=A0void rx_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > -int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)=
;
>  > +int rx_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int re=
g);
>  > =C2=A0int rx_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int r=
eg);
>  > =C2=A0hwaddr rx_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  >
>  > diff --git a/target/s390x/internal.h b/target/s390x/internal.h
>  > index 8c95c734db..04fcb7da74 100644
>  > --- a/target/s390x/internal.h
>  > +++ b/target/s390x/internal.h
>  > @@ -292,7 +292,7 @@ uint16_t float128_dcmask(CPUS390XState *env,=20
> float128 f1);
>  >
>  >
>  > =C2=A0/* gdbstub.c */
>  > -int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int re=
g);
>  > +int s390_cpu_gdb_read_register(CPUState *cpu, GByteArray *array, int=
=20
> reg);
>  > =C2=A0int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int=
 reg);
>  > =C2=A0void s390_cpu_gdb_init(CPUState *cs);
>  >
>  > diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
>  > index dbe58c7888..6901c88d7e 100644
>  > --- a/target/sh4/cpu.h
>  > +++ b/target/sh4/cpu.h
>  > @@ -208,7 +208,7 @@ void superh_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0bool superh_cpu_exec_interrupt(CPUState *cpu, int int_req);
>  > =C2=A0void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr superh_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)=
;
>  > -int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int=
=20
> reg);
>  > +int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=20
> int reg);
>  > =C2=A0int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, i=
nt reg);
>  > =C2=A0void superh_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType=
 access_type,
>  > diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
>  > index b9369398f2..bb9126b546 100644
>  > --- a/target/sparc/cpu.h
>  > +++ b/target/sparc/cpu.h
>  > @@ -571,7 +571,7 @@ extern const VMStateDescription vmstate_sparc_cpu;
>  > =C2=A0void sparc_cpu_do_interrupt(CPUState *cpu);
>  > =C2=A0void sparc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
>  > =C2=A0hwaddr sparc_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>  > -int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int=
=20
> reg);
>  > +int sparc_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=20
> int reg);
>  > =C2=A0int sparc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, in=
t reg);
>  > =C2=A0void QEMU_NORETURN sparc_cpu_do_unaligned_access(CPUState *cpu,=
=20
> vaddr addr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMUAccessType=20
> access_type,
>  > diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
>  > index 7a46dccbe1..8a851e0b00 100644
>  > --- a/target/xtensa/cpu.h
>  > +++ b/target/xtensa/cpu.h
>  > @@ -572,7 +572,7 @@ void xtensa_cpu_dump_state(CPUState *cpu, FILE=20
> *f, int flags);
>  > =C2=A0hwaddr xtensa_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)=
;
>  > =C2=A0void xtensa_count_regs(const XtensaConfig *config,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 unsigned *n_regs, unsigned *n_core_regs);
>  > -int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int=
=20
> reg);
>  > +int xtensa_cpu_gdb_read_register(CPUState *cpu, GByteArray *array,=20
> int reg);
>  > =C2=A0int xtensa_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, i=
nt reg);
>  > =C2=A0void xtensa_cpu_do_unaligned_access(CPUState *cpu, vaddr addr,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MMUAccessType=
 access_type,
>  > diff --git a/gdbstub.c b/gdbstub.c
>  > index 171e150950..bc24b613b2 100644
>  > --- a/gdbstub.c
>  > +++ b/gdbstub.c
>  > @@ -906,19 +906,19 @@ static const char *get_feature_xml(const char=20
> *p, const char **newp,
>  > =C2=A0 =C2=A0 =C2=A0return name ? xml_builtin[i][1] : NULL;
>  > =C2=A0}
>  >
>  > -static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
>  > +static int gdb_read_register(CPUState *cpu, GByteArray *array, int re=
g)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0CPUClass *cc =3D CPU_GET_CLASS(cpu);
>  > =C2=A0 =C2=A0 =C2=A0CPUArchState *env =3D cpu->env_ptr;
>  > =C2=A0 =C2=A0 =C2=A0GDBRegisterState *r;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (reg < cc->gdb_num_core_regs) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cc->gdb_read_register(cpu, buf, re=
g);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return cc->gdb_read_register(cpu, array, =
reg);
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0for (r =3D cpu->gdb_regs; r; r =3D r->next) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r->base_reg <=3D reg && reg < r-=
>base_reg + r->num_regs) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r->get_reg(env, buf,=
 reg - r->base_reg);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r->get_reg(env, arra=
y, reg - r->base_reg);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/hw/core/cpu.c b/hw/core/cpu.c
>  > index 786a1bec8a..0f2bd00176 100644
>  > --- a/hw/core/cpu.c
>  > +++ b/hw/core/cpu.c
>  > @@ -177,7 +177,8 @@ static int=20
> cpu_common_write_elf64_note(WriteCoreDumpFunction f,
>  > =C2=A0}
>  >
>  >
>  > -static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray=20
> *buf, int reg)
>  > +static int cpu_common_gdb_read_register(CPUState *cpu, GByteArray=20
> *array,
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
reg)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  > diff --git a/target/alpha/gdbstub.c b/target/alpha/gdbstub.c
>  > index 0cd76ddaa9..415f422b03 100644
>  > --- a/target/alpha/gdbstub.c
>  > +++ b/target/alpha/gdbstub.c
>  > @@ -21,7 +21,7 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=20
> int n)
>  > +int alpha_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int =
n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0AlphaCPU *cpu =3D ALPHA_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUAlphaState *env =3D &cpu->env;
>  > @@ -54,7 +54,7 @@ int alpha_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 return gdb_get_regl(mem_buf, val);
>  > +=C2=A0 =C2=A0 return gdb_get_regl(array, val);
>  > =C2=A0}
>  >
>  > =C2=A0int alpha_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf,=
 int n)
>  > diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
>  > index 063551df23..66a8af8a19 100644
>  > --- a/target/arm/gdbstub.c
>  > +++ b/target/arm/gdbstub.c
>  > @@ -33,21 +33,21 @@ typedef struct RegisterSysregXmlParam {
>  > =C2=A0 =C2=A0 We hack round this by giving the FPA regs zero size when=
 talking to a
>  > =C2=A0 =C2=A0 newer gdb.=C2=A0 */
>  >
>  > -int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int =
n)
>  > +int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUARMState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 16) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Core integer register.=C2=A0 */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0if (n < 24) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FPA registers.=C2=A0 */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gdb_has_xml) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes(mem_buf, 12);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes(array, 12);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 24:
>  > @@ -55,10 +55,10 @@ int arm_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (gdb_has_xml) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, 0);
>  > =C2=A0 =C2=A0 =C2=A0case 25:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CPSR */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, cpsr_read(e=
nv));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, cpsr_read(env=
));
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0/* Unknown register.=C2=A0 */
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
>  > index 35d0b80c2d..16860a0522 100644
>  > --- a/target/arm/gdbstub64.c
>  > +++ b/target/arm/gdbstub64.c
>  > @@ -20,22 +20,22 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=
=20
> int n)
>  > +int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *array,=20
> int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0ARMCPU *cpu =3D ARM_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUARMState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 31) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Core integer register.=C2=A0 */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, env->xregs[=
n]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, env->xregs[n]=
);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 31:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, env->xregs[=
31]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, env->xregs[31=
]);
>  > =C2=A0 =C2=A0 =C2=A0case 32:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0case 33:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, pstate_read=
(env));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, pstate_read(e=
nv));
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0/* Unknown register.=C2=A0 */
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/cris/gdbstub.c b/target/cris/gdbstub.c
>  > index b01b2aa081..dd7f754935 100644
>  > --- a/target/cris/gdbstub.c
>  > +++ b/target/cris/gdbstub.c
>  > @@ -21,31 +21,31 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=
=20
> int n)
>  > +int crisv10_cpu_gdb_read_register(CPUState *cs, GByteArray *array,=20
> int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0CRISCPU *cpu =3D CRIS_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUCRISState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 15) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n =3D=3D 15) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 16:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf=
, env->pregs[n - 16]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(array, =
env->pregs[n - 16]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 17:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf=
, env->pregs[n - 16]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(array, =
env->pregs[n - 16]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 20:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 21:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(mem_bu=
f, env->pregs[n - 16]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(array,=
 env->pregs[n - 16]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n >=3D 23) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg32(mem_buf, env->pregs[n - 16]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg32(array, env->pregs[n - 16]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > @@ -53,7 +53,7 @@ int crisv10_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  >
>  > -int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int=
 n)
>  > +int cris_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n=
)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0CRISCPU *cpu =3D CRIS_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUCRISState *env =3D &cpu->env;
>  > @@ -61,28 +61,28 @@ int cris_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  >
>  > =C2=A0 =C2=A0 =C2=A0srs =3D env->pregs[PR_SRS];
>  > =C2=A0 =C2=A0 =C2=A0if (n < 16) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n >=3D 21 && n < 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->pregs[=
n - 16]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->pregs[n =
- 16]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0if (n >=3D 33 && n < 49) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->sregs[=
srs][n - 33]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->sregs[sr=
s][n - 33]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 16:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, env->pregs[0=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(array, env->pregs[0])=
;
>  > =C2=A0 =C2=A0 =C2=A0case 17:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, env->pregs[1=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(array, env->pregs[1])=
;
>  > =C2=A0 =C2=A0 =C2=A0case 18:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->pregs[=
2]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->pregs[2]=
);
>  > =C2=A0 =C2=A0 =C2=A0case 19:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(mem_buf, srs);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg8(array, srs);
>  > =C2=A0 =C2=A0 =C2=A0case 20:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(mem_buf, env->pregs[=
4]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg16(array, env->pregs[4]=
);
>  > =C2=A0 =C2=A0 =C2=A0case 32:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
>  > index a6428a2893..d0618f5175 100644
>  > --- a/target/hppa/gdbstub.c
>  > +++ b/target/hppa/gdbstub.c
>  > @@ -21,7 +21,7 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int=
 n)
>  > +int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n=
)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0HPPACPU *cpu =3D HPPA_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUHPPAState *env =3D &cpu->env;
>  > @@ -140,9 +140,9 @@ int hppa_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (TARGET_REGISTER_BITS =3D=3D 64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, val);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, val);
>  > =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, val);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, val);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0}
>  >
>  > diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
>  > index f3d23b614e..40f1b03a36 100644
>  > --- a/target/i386/gdbstub.c
>  > +++ b/target/i386/gdbstub.c
>  > @@ -79,7 +79,7 @@ static const int gpr_map32[8] =3D { 0, 1, 2, 3, 4, 5=
,=20
> 6, 7 };
>  > =C2=A0#endif
>  >
>  >
>  > -int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int =
n)
>  > +int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0X86CPU *cpu =3D X86_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUX86State *env =3D &cpu->env;
>  > @@ -93,25 +93,25 @@ int x86_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0if (n < CPU_NB_REGS) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TARGET_LONG_BITS =3D=3D 64) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env->hflags & HF_C=
S64_MASK) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->regs[gpr_map[n]]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->regs[gpr_map[n]]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (n < CPU_NB_=
REGS32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf,
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env->regs[gp=
r_map[n]] &=20
> 0xffffffffUL);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_regl(mem_buf, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_regl(array, 0);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->regs[gpr_map32[n]]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->regs[gpr_map32[n]]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0} else if (n >=3D IDX_FP_REGS && n < IDX_FP_REGS +=
 8) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0floatx80 *fp =3D (floatx80 *) &env->=
fpregs[n - IDX_FP_REGS];
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_reg64(mem_buf, cpu_to=
_le64(fp->low));
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg16(mem_buf + len, cpu=
_to_le16(fp->high));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_reg64(array, cpu_to_l=
e64(fp->low));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg16(array + len, cpu_t=
o_le16(fp->high));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;
>  > =C2=A0 =C2=A0 =C2=A0} else if (n >=3D IDX_XMM_REGS && n < IDX_XMM_REGS=
 + CPU_NB_REGS) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0n -=3D IDX_XMM_REGS;
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n < CPU_NB_REGS32 || TARGET_LONG=
_BITS =3D=3D 64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg128(mem_b=
uf,
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg128(array=
,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->xmm_regs[n].ZMM=
_Q(0),
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->xmm_regs[n].ZMM=
_Q(1));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > @@ -120,95 +120,95 @@ int x86_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_IP_REG:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TARGET_LONG_BITS =
=3D=3D 64) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env-=
>hflags & HF_CS64_MASK) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return gdb_get_reg64(mem_buf, env->eip);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return gdb_get_reg64(array, env->eip);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return gdb_get_reg64(mem_buf, env->eip &=20
> 0xffffffffUL);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 return gdb_get_reg64(array, env->eip &=20
> 0xffffffffUL);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg32(mem_buf, env->eip);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg32(array, env->eip);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FLAGS_REG:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->eflags);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->eflags);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_CS].selector);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_CS].selector);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 1:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_SS].selector);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_SS].selector);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 2:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_DS].selector);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_DS].selector);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 3:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_ES].selector);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_ES].selector);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 4:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_FS].selector);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_FS].selector);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 5:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_GS].selector);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_GS].selector);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 6:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->segs[R_FS].base);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->segs[R_FS].base);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_FS].base);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_FS].base);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 7:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->segs[R_GS].base);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->segs[R_GS].base);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->segs[R_GS].base);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->segs[R_GS].base);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_SEG_REGS + 8:
>  > =C2=A0#ifdef TARGET_X86_64
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->kernelgsbase);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->kernelgsbase);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->kernelgsbase);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->kernelgsbase);
>  > =C2=A0#else
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0);
>  > =C2=A0#endif
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 8:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->fpuc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->fpuc);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 9:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, (env->fpus & ~0x3800) |
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 (env->fpus & ~0x3800) |
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(env->fpstt & 0x7) << 11);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 10:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0); /* ftag */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0); /* ftag */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 11:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0); /* fiseg */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0); /* fiseg */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 12:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0); /* fioff */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0); /* fioff */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 13:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0); /* foseg */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0); /* foseg */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 14:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0); /* fooff */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0); /* fooff */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_FP_REGS + 15:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0); /* fop */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0); /* fop */
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_MXCSR_REG:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->mxcsr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->mxcsr);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_CTL_CR0_REG:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->cr[0]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->cr[0]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->cr[0]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->cr[0]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_CTL_CR2_REG:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->cr[2]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->cr[2]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->cr[2]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->cr[2]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_CTL_CR3_REG:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->cr[3]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->cr[3]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->cr[3]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->cr[3]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_CTL_CR4_REG:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->cr[4]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->cr[4]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->cr[4]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->cr[4]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_CTL_CR8_REG:
>  > =C2=A0#ifdef CONFIG_SOFTMMU
>  > @@ -217,15 +217,15 @@ int x86_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tpr =3D 0;
>  > =C2=A0#endif
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, tpr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, tpr);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, tpr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 tpr);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case IDX_CTL_EFER_REG:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->hflags & HF_=
CS64_MASK) || GDB_FORCE_64) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(mem_buf, env->efer);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_reg64(array, env->efer);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->efer);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->efer);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
>  > index b6fe12e1d6..6198719944 100644
>  > --- a/target/lm32/gdbstub.c
>  > +++ b/target/lm32/gdbstub.c
>  > @@ -22,30 +22,30 @@
>  > =C2=A0#include "exec/gdbstub.h"
>  > =C2=A0#include "hw/lm32/lm32_pic.h"
>  >
>  > -int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int=
 n)
>  > +int lm32_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n=
)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0LM32CPU *cpu =3D LM32_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPULM32State *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0} else {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 32:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->pc);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME: put in right exception ID =
*/
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 33:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 0);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 34:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->eba);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->eba);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 35:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->deba);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->deba);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 36:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->ie);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->ie);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 37:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f,=20
> lm32_pic_get_im(env->pic_state));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
=20
> lm32_pic_get_im(env->pic_state));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 38:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f,=20
> lm32_pic_get_ip(env->pic_state));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
=20
> lm32_pic_get_ip(env->pic_state));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/m68k/gdbstub.c b/target/m68k/gdbstub.c
>  > index eb2d030e14..9405dc4b4e 100644
>  > --- a/target/m68k/gdbstub.c
>  > +++ b/target/m68k/gdbstub.c
>  > @@ -21,24 +21,24 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int=
 n)
>  > +int m68k_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n=
)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0M68kCPU *cpu =3D M68K_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUM68KState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 8) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* D0-D7 */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->dregs[=
n]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->dregs[n]=
);
>  > =C2=A0 =C2=A0 =C2=A0} else if (n < 16) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* A0-A7 */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->aregs[=
n - 8]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->aregs[n =
- 8]);
>  > =C2=A0 =C2=A0 =C2=A0} else {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 16:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SR is made of SR+CC=
R, CCR is many 1bit flags so uses=20
> helper */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->sr |=20
> cpu_m68k_get_ccr(env));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->sr |=20
> cpu_m68k_get_ccr(env));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 17:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->pc);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0/*
>  > diff --git a/target/m68k/helper.c b/target/m68k/helper.c
>  > index 014657c637..968371476a 100644
>  > --- a/target/m68k/helper.c
>  > +++ b/target/m68k/helper.c
>  > @@ -68,19 +68,19 @@ void m68k_cpu_list(void)
>  > =C2=A0 =C2=A0 =C2=A0g_slist_free(list);
>  > =C2=A0}
>  >
>  > -static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray=20
> *mem_buf, int n)
>  > +static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *array,=
=20
> int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0if (n < 8) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0float_status s;
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf,=20
> floatx80_to_float64(env->fregs[n].d, &s));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array,=20
> floatx80_to_float64(env->fregs[n].d, &s));
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 8: /* fpcontrol */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->fpcr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->fpcr);
>  > =C2=A0 =C2=A0 =C2=A0case 9: /* fpstatus */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->fpsr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->fpsr);
>  > =C2=A0 =C2=A0 =C2=A0case 10: /* fpiar, not implemented */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, 0);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  > @@ -105,21 +105,21 @@ static int cf_fpu_gdb_set_reg(CPUM68KState=20
> *env, uint8_t *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  >
>  > -static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray=20
> *mem_buf, int n)
>  > +static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray=20
> *array, int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0if (n < 8) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_reg16(mem_buf, env->f=
regs[n].l.upper);
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg16(mem_buf + len, 0);
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg64(mem_buf + len, env=
->fregs[n].l.lower);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int len =3D gdb_get_reg16(array, env->fre=
gs[n].l.upper);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg16(array + len, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len +=3D gdb_get_reg64(array + len, env->=
fregs[n].l.lower);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return len;
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 8: /* fpcontrol */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->fpcr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->fpcr);
>  > =C2=A0 =C2=A0 =C2=A0case 9: /* fpstatus */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->fpsr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->fpsr);
>  > =C2=A0 =C2=A0 =C2=A0case 10: /* fpiar, not implemented */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, 0);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  > diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
>  > index f41ebf1f33..40d41e12ce 100644
>  > --- a/target/microblaze/gdbstub.c
>  > +++ b/target/microblaze/gdbstub.c
>  > @@ -21,15 +21,15 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
>  > +int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0MicroBlazeCPU *cpu =3D MICROBLAZE_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUMBState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->sregs[=
n - 32]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->sregs[n =
- 32]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  > diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
>  > index 98f56e660d..0fc957d5cd 100644
>  > --- a/target/mips/gdbstub.c
>  > +++ b/target/mips/gdbstub.c
>  > @@ -22,54 +22,54 @@
>  > =C2=A0#include "internal.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int=
 n)
>  > +int mips_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n=
)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0MIPSCPU *cpu =3D MIPS_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUMIPSState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->active_=
tc.gpr[n]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->active_tc=
.gpr[n]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0if (env->CP0_Config1 & (1 << CP0C1_FP) && n >=3D 3=
8 && n < 72) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 70:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf=
,=20
> (int32_t)env->active_fpu.fcr31);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, =
(int32_t)env->active_fpu.fcr31);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 71:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf=
, (int32_t)env->active_fpu.fcr0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, =
(int32_t)env->active_fpu.fcr0);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env->CP0_Status & =
(1 << CP0St_FR)) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_regl(mem_buf,
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_regl(array,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0env->active_fpu.fpr[n - 38].d);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_regl(mem_buf,
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_ge=
t_regl(array,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0env->active_fpu.fpr[n - 38].w[FP_ENDIAN_IDX]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 32:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (int32_t)env=
->CP0_Status);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, (int32_t)env->=
CP0_Status);
>  > =C2=A0 =C2=A0 =C2=A0case 33:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->active_=
tc.LO[0]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->active_tc=
.LO[0]);
>  > =C2=A0 =C2=A0 =C2=A0case 34:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->active_=
tc.HI[0]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->active_tc=
.HI[0]);
>  > =C2=A0 =C2=A0 =C2=A0case 35:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->CP0_Bad=
VAddr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->CP0_BadVA=
ddr);
>  > =C2=A0 =C2=A0 =C2=A0case 36:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (int32_t)env=
->CP0_Cause);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, (int32_t)env->=
CP0_Cause);
>  > =C2=A0 =C2=A0 =C2=A0case 37:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->active_=
tc.PC |
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->active_tc=
.PC |
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!(env->hfla=
gs & MIPS_HFLAG_M16));
>  > =C2=A0 =C2=A0 =C2=A0case 72:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, 0); /* fp */
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, 0); /* fp */
>  > =C2=A0 =C2=A0 =C2=A0case 89:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (int32_t)env=
->CP0_PRid);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, (int32_t)env->=
CP0_PRid);
>  > =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n > 89) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 16 embedded regs.=C2=A0 */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, 0);
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
>  > index 8f7011fcb9..3cf696402f 100644
>  > --- a/target/nios2/cpu.c
>  > +++ b/target/nios2/cpu.c
>  > @@ -124,7 +124,7 @@ static void nios2_cpu_disas_set_info(CPUState=20
> *cpu, disassemble_info *info)
>  > =C2=A0#endif
>  > =C2=A0}
>  >
>  > -static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray=20
> *mem_buf, int n)
>  > +static int nios2_cpu_gdb_read_register(CPUState *cs, GByteArray=20
> *array, int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0Nios2CPU *cpu =3D NIOS2_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUClass *cc =3D CPU_GET_CLASS(cs);
>  > @@ -135,11 +135,11 @@ static int nios2_cpu_gdb_read_register(CPUState=
=20
> *cs, GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 GP regs */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0} else if (n =3D=3D 32) {=C2=A0 =C2=A0 /* PC */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[R=
_PC]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[R_P=
C]);
>  > =C2=A0 =C2=A0 =C2=A0} else if (n < 49) {=C2=A0 =C2=A0 =C2=A0/* Status =
regs */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[n=
 - 1]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[n -=
 1]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0/* Invalid regs */
>  > diff --git a/target/openrisc/gdbstub.c b/target/openrisc/gdbstub.c
>  > index 095bf76c12..c34d3696ec 100644
>  > --- a/target/openrisc/gdbstub.c
>  > +++ b/target/openrisc/gdbstub.c
>  > @@ -21,23 +21,23 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray=20
> *mem_buf, int n)
>  > +int openrisc_cpu_gdb_read_register(CPUState *cs, GByteArray *array,=
=20
> int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0OpenRISCCPU *cpu =3D OPENRISC_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUOpenRISCState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, cpu_get_gpr=
(env, n));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, cpu_get_gpr(e=
nv, n));
>  > =C2=A0 =C2=A0 =C2=A0} else {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 32:=C2=A0 =C2=A0 /* PPC */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->ppc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->ppc);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 33:=C2=A0 =C2=A0 /* NPC (equals=
 PC) */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->pc);
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 34:=C2=A0 =C2=A0 /* SR */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, cpu_get_sr(env));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 cpu_get_sr(env));
>  >
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>  > diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
>  > index eba12a86f2..8e1d64c1cf 100644
>  > --- a/target/riscv/gdbstub.c
>  > +++ b/target/riscv/gdbstub.c
>  > @@ -270,15 +270,15 @@ static int csr_register_map[] =3D {
>  > =C2=A0 =C2=A0 =C2=A0CSR_MHCOUNTEREN,
>  > =C2=A0};
>  >
>  > -int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=20
> int n)
>  > +int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int =
n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0RISCVCPU *cpu =3D RISCV_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPURISCVState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->gpr[n])=
;
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->gpr[n]);
>  > =C2=A0 =C2=A0 =C2=A0} else if (n =3D=3D 32) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  > diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
>  > index 9391e8151e..91dee774f6 100644
>  > --- a/target/rx/gdbstub.c
>  > +++ b/target/rx/gdbstub.c
>  > @@ -20,32 +20,32 @@
>  > =C2=A0#include "cpu.h"
>  > =C2=A0#include "exec/gdbstub.h"
>  >
>  > -int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n=
)
>  > +int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0RXCPU *cpu =3D RXCPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPURXState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 0 ... 15:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->regs[n]=
);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->regs[n]);
>  > =C2=A0 =C2=A0 =C2=A0case 16:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (env->psw_u)=
 ? env->regs[0] :=20
> env->usp);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, (env->psw_u) ?=
 env->regs[0] :=20
> env->usp);
>  > =C2=A0 =C2=A0 =C2=A0case 17:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (!env->psw_u=
) ? env->regs[0] :=20
> env->isp);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, (!env->psw_u) =
? env->regs[0] :=20
> env->isp);
>  > =C2=A0 =C2=A0 =C2=A0case 18:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, rx_cpu_pack_=
psw(env));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, rx_cpu_pack_ps=
w(env));
>  > =C2=A0 =C2=A0 =C2=A0case 19:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0case 20:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->intb);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->intb);
>  > =C2=A0 =C2=A0 =C2=A0case 21:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->bpsw);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->bpsw);
>  > =C2=A0 =C2=A0 =C2=A0case 22:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->bpc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->bpc);
>  > =C2=A0 =C2=A0 =C2=A0case 23:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->fintv);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->fintv);
>  > =C2=A0 =C2=A0 =C2=A0case 24:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->fpsw);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->fpsw);
>  > =C2=A0 =C2=A0 =C2=A0case 25:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0 =C2=A0 =C2=A0}
>  > diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
>  > index d6fce5ff1e..adbe7b5d39 100644
>  > --- a/target/s390x/gdbstub.c
>  > +++ b/target/s390x/gdbstub.c
>  > @@ -27,7 +27,7 @@
>  > =C2=A0#include "sysemu/hw_accel.h"
>  > =C2=A0#include "sysemu/tcg.h"
>  >
>  > -int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int=
 n)
>  > +int s390_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int n=
)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0S390CPU *cpu =3D S390_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUS390XState *env =3D &cpu->env;
>  > @@ -40,13 +40,13 @@ int s390_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cc_op =3D calc_cc(env,=
 env->cc_op, env->cc_src, env->cc_dst,
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env->cc_vr);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D deposit64(env-=
>psw.mask, 44, 2, cc_op);
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf=
, val);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, =
val);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->psw.mas=
k);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->psw.mask)=
;
>  > =C2=A0 =C2=A0 =C2=A0case S390_PSWA_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->psw.add=
r);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->psw.addr)=
;
>  > =C2=A0 =C2=A0 =C2=A0case S390_R0_REGNUM ... S390_R15_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->regs[n =
- S390_R0_REGNUM]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->regs[n - =
S390_R0_REGNUM]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0}
>  > @@ -223,25 +223,25 @@ static int cpu_write_c_reg(CPUS390XState *env,=
=20
> uint8_t *mem_buf, int n)
>  > =C2=A0/* total number of registers in s390-virt.xml */
>  > =C2=A0#define S390_NUM_VIRT_REGS 8
>  >
>  > -static int cpu_read_virt_reg(CPUS390XState *env, GByteArray=20
> *mem_buf, int n)
>  > +static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *array,=
=20
> int n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_CKC_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->ckc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->ckc);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_CPUTM_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->cputm);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->cputm);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_BEA_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->gbea);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->gbea);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_PREFIX_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->psa);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->psa);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_PP_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pp);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pp);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_PFT_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pfault_=
token);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pfault_to=
ken);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_PFS_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pfault_=
select);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pfault_se=
lect);
>  > =C2=A0 =C2=A0 =C2=A0case S390_VIRT_PFC_REGNUM:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pfault_=
compare);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pfault_co=
mpare);
>  > =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>  > =C2=A0 =C2=A0 =C2=A0}
>  > diff --git a/target/sh4/gdbstub.c b/target/sh4/gdbstub.c
>  > index da95205889..964b31d065 100644
>  > --- a/target/sh4/gdbstub.c
>  > +++ b/target/sh4/gdbstub.c
>  > @@ -24,7 +24,7 @@
>  > =C2=A0/* Hint: Use "set architecture sh4" in GDB to see fpu registers =
*/
>  > =C2=A0/* FIXME: We should use XML for this.=C2=A0 */
>  >
>  > -int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=
=20
> int n)
>  > +int superh_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int=
 n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0SuperHCPU *cpu =3D SUPERH_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUSH4State *env =3D &cpu->env;
>  > @@ -32,43 +32,43 @@ int superh_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 0 ... 7:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((env->sr & (1u << SR_MD)) && (en=
v->sr & (1u << SR_RB))) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf=
, env->gregs[n + 16]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, =
env->gregs[n + 16]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf=
, env->gregs[n]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, =
env->gregs[n]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0case 8 ... 15:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->gregs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->gregs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0case 16:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0case 17:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pr);
>  > =C2=A0 =C2=A0 =C2=A0case 18:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->gbr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->gbr);
>  > =C2=A0 =C2=A0 =C2=A0case 19:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->vbr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->vbr);
>  > =C2=A0 =C2=A0 =C2=A0case 20:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->mach);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->mach);
>  > =C2=A0 =C2=A0 =C2=A0case 21:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->macl);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->macl);
>  > =C2=A0 =C2=A0 =C2=A0case 22:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, cpu_read_sr(=
env));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, cpu_read_sr(en=
v));
>  > =C2=A0 =C2=A0 =C2=A0case 23:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->fpul);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->fpul);
>  > =C2=A0 =C2=A0 =C2=A0case 24:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->fpscr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->fpscr);
>  > =C2=A0 =C2=A0 =C2=A0case 25 ... 40:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (env->fpscr & FPSCR_FR) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_freg32(mem_b=
uf, env->fregs[n - 9]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_freg32(array=
, env->fregs[n - 9]);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_freg32(mem_buf, env->fregs=
[n - 25]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_freg32(array, env->fregs[n=
 - 25]);
>  > =C2=A0 =C2=A0 =C2=A0case 41:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->ssr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->ssr);
>  > =C2=A0 =C2=A0 =C2=A0case 42:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->spc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->spc);
>  > =C2=A0 =C2=A0 =C2=A0case 43 ... 50:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->gregs[n=
 - 43]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->gregs[n -=
 43]);
>  > =C2=A0 =C2=A0 =C2=A0case 51 ... 58:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->gregs[n=
 - (51 - 16)]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->gregs[n -=
 (51 - 16)]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
>  > index 78dc8dcc98..6e6dc9f184 100644
>  > --- a/target/sparc/gdbstub.c
>  > +++ b/target/sparc/gdbstub.c
>  > @@ -27,78 +27,78 @@
>  > =C2=A0#define gdb_get_rega(buf, val) gdb_get_regl(buf, val)
>  > =C2=A0#endif
>  >
>  > -int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=20
> int n)
>  > +int sparc_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int =
n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0SPARCCPU *cpu =3D SPARC_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUSPARCState *env =3D &cpu->env;
>  >
>  > =C2=A0 =C2=A0 =C2=A0if (n < 8) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* g0..g7 */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->gregs[n=
]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->gregs[n])=
;
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0if (n < 32) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* register window */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->regwptr=
[n - 8]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->regwptr[n=
 - 8]);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0#if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
>  > =C2=A0 =C2=A0 =C2=A0if (n < 64) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* fprs */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n & 1) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->fpr[(n - 32) /=20
> 2].l.lower);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->fpr[(n - 32) / 2].l.lower);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->fpr[(n - 32) /=20
> 2].l.upper);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->fpr[(n - 32) / 2].l.upper);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0/* Y, PSR, WIM, TBR, PC, NPC, FPSR, CPSR */
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 64:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->y);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->y);
>  > =C2=A0 =C2=A0 =C2=A0case 65:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, cpu_get_psr(=
env));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, cpu_get_psr(en=
v));
>  > =C2=A0 =C2=A0 =C2=A0case 66:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->wim);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->wim);
>  > =C2=A0 =C2=A0 =C2=A0case 67:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->tbr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->tbr);
>  > =C2=A0 =C2=A0 =C2=A0case 68:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0case 69:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->npc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->npc);
>  > =C2=A0 =C2=A0 =C2=A0case 70:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, env->fsr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, env->fsr);
>  > =C2=A0 =C2=A0 =C2=A0case 71:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, 0); /* csr *=
/
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, 0); /* csr */
>  > =C2=A0 =C2=A0 =C2=A0default:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(mem_buf, 0);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_rega(array, 0);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0#else
>  > =C2=A0 =C2=A0 =C2=A0if (n < 64) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* f0-f31 */
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (n & 1) {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->fpr[(n - 32) /=20
> 2].l.lower);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->fpr[(n - 32) / 2].l.lower);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f, env->fpr[(n - 32) /=20
> 2].l.upper);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,=
 env->fpr[(n - 32) / 2].l.upper);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0if (n < 80) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* f32-f62 (double width, even numbe=
rs only) */
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_buf, env->fpr[(n=
 - 32) / 2].ll);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array, env->fpr[(n -=
 32) / 2].ll);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0 =C2=A0 =C2=A0switch (n) {
>  > =C2=A0 =C2=A0 =C2=A0case 80:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->pc);
>  > =C2=A0 =C2=A0 =C2=A0case 81:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->npc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->npc);
>  > =C2=A0 =C2=A0 =C2=A0case 82:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, (cpu_get_ccr=
(env) << 32) |
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, (cpu_get_ccr(e=
nv) << 32) |
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((env->asi &=
 0xff) << 24) |
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((env->pstat=
e & 0xfff) << 8) |
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_get_cwp6=
4(env));
>  > =C2=A0 =C2=A0 =C2=A0case 83:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->fsr);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->fsr);
>  > =C2=A0 =C2=A0 =C2=A0case 84:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->fprs);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->fprs);
>  > =C2=A0 =C2=A0 =C2=A0case 85:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(mem_buf, env->y);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_regl(array, env->y);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0#endif
>  > =C2=A0 =C2=A0 =C2=A0return 0;
>  > diff --git a/target/xtensa/gdbstub.c b/target/xtensa/gdbstub.c
>  > index 4d43f1340a..26d8f4ee9b 100644
>  > --- a/target/xtensa/gdbstub.c
>  > +++ b/target/xtensa/gdbstub.c
>  > @@ -63,7 +63,7 @@ void xtensa_count_regs(const XtensaConfig *config,
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0}
>  >
>  > -int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf,=
=20
> int n)
>  > +int xtensa_cpu_gdb_read_register(CPUState *cs, GByteArray *array, int=
 n)
>  > =C2=A0{
>  > =C2=A0 =C2=A0 =C2=A0XtensaCPU *cpu =3D XTENSA_CPU(cs);
>  > =C2=A0 =C2=A0 =C2=A0CPUXtensaState *env =3D &cpu->env;
>  > @@ -81,40 +81,40 @@ int xtensa_cpu_gdb_read_register(CPUState *cs,=20
> GByteArray *mem_buf, int n)
>  >
>  > =C2=A0 =C2=A0 =C2=A0switch (reg->type) {
>  > =C2=A0 =C2=A0 =C2=A0case xtRegisterTypeVirtual: /*pc*/
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->pc);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->pc);
>  >
>  > =C2=A0 =C2=A0 =C2=A0case xtRegisterTypeArRegfile: /*ar*/
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xtensa_sync_phys_from_window(env);
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->phys_r=
egs[(reg->targno &=20
> 0xff)
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->phys_reg=
s[(reg->targno & 0xff)
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 %=20
> env->config->nareg]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0case xtRegisterTypeSpecialReg: /*SR*/
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->sregs[=
reg->targno & 0xff]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->sregs[re=
g->targno & 0xff]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0case xtRegisterTypeUserReg: /*UR*/
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->uregs[=
reg->targno & 0xff]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->uregs[re=
g->targno & 0xff]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0case xtRegisterTypeTieRegfile: /*f*/
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D reg->targno & 0x0f;
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (reg->size) {
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 4:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_bu=
f,
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array,
>  >                                  =20
> float32_val(env->fregs[i].f32[FP_F32_LOW]));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case 8:
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(mem_bu=
f,=20
> float64_val(env->fregs[i].f64));
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg64(array,=
 float64_val(env->fregs[i].f64));
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIM=
P, "%s from reg %d of unsupported=20
> size %d\n",
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, n, reg->size);
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes(mem_b=
uf, reg->size);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes(array=
, reg->size);
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>  >
>  > =C2=A0 =C2=A0 =C2=A0case xtRegisterTypeWindow: /*a*/
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(mem_buf, env->regs[r=
eg->targno & 0x0f]);
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_reg32(array, env->regs[reg=
->targno & 0x0f]);
>  >
>  > =C2=A0 =C2=A0 =C2=A0default:
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_UNIMP, "%s from re=
g %d of unsupported type=20
> %d\n",
>  > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0__func__, n, reg->type);
>  > -=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes(mem_buf, reg->size)=
;
>  > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return gdb_get_zeroes(array, reg->size);
>  > =C2=A0 =C2=A0 =C2=A0}
>  > =C2=A0}
>  >
>  > --
>  > 2.21.1
>  >
>=20


