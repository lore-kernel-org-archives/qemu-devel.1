Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9179207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="h9JXVGkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9179207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4S4-0007yt-Vr
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1iw4QV-0007Ci-Ao
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1iw4QS-000849-8z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:27:39 -0500
Received: from [51.158.76.159] (port=45984 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>)
 id 1iw4QR-0007uj-Ly; Mon, 27 Jan 2020 08:27:36 -0500
Subject: Re: [PATCH rc2 01/25] target/avr: Add outward facing interfaces and
 core CPU logic
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1580131649;
 bh=LNepkTTft75YKLHu+tJKpzW+WV3XJ7iffrR1RL5YM+4=;
 h=Subject:To:Cc:References:From:In-Reply-To;
 b=h9JXVGkHqBOuQYXyK/AyYqVR9If2nWZftkIJmS1NPRiy+V83JSQTcqkA6TIxCQYiQ
 qalzfZxG744rscZpBKLTY2Kngq6d1YgnVTWy+j/ypvoDRY1jEMITv0GfwKExicJtg7
 wkQn+KAHityWh2wAUh1Xmv6xG8A1U5DOb/XqRUa8xrvzui9hxdU0G18y4Jj4RMO4Cx
 u2+v/cS5f6I5TI3WyR5F5XonxrgH9B9UuqGD2ciRXQjcSn379aeNHF3uLHbmRuCQJJ
 9SBsv+u4eYqBOgRS62rdMPS8WCUS5y7TRn5LvYB41+AqSpLPmu1XXXHU8JV55Lp6gZ
 N5TSuzUm/jeEw==
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org
References: <20200124005131.16276-1-f4bug@amsat.org>
 <20200124005131.16276-2-f4bug@amsat.org>
From: Joaquin de Andres <me@xcancerberox.com.ar>
Openpgp: preference=signencrypt
Autocrypt: addr=me@xcancerberox.com.ar; keydata=
 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
 OZRo+ULKJ1xXuVGe8hnP9Q==
Message-ID: <8be57265-7077-45cc-5b5a-d3a4345b4eae@xcancerberox.com.ar>
Date: Mon, 27 Jan 2020 14:27:28 +0100
Mime-Version: 1.0
In-Reply-To: <20200124005131.16276-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 dovgaluk@ispras.ru, imammedo@redhat.com,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/24/20 1:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> From: Michael Rolnik <mrolnik@gmail.com>
>=20
> This includes:
> - CPU data structures
> - object model classes and functions
> - migration functions
> - GDB hooks
>=20
> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
> Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Message-Id: <20200118191416.19934-2-mrolnik@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> ...
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> new file mode 100644
> index 0000000000..c74c5106fe
> --- /dev/null
> +++ b/target/avr/cpu.c
> @@ -0,0 +1,826 @@
> ...
> +/*
> + * Setting features of AVR core type avr1
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at90s1200, attiny11, attiny12, attiny15, attiny28
> + */
> +static void avr_avr1_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +> +    avr_set_feature(env, AVR_FEATURE_LPM);

Hi! According to the datasheets the at90s1200 is an special case and the
LPM instruction is not present.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with at90s1200 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr2
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at90s2313, at90s2323, at90s2333, at90s2343, attiny22, attiny26, at9=
0s4414,
> + * at90s4433, at90s4434, at90s8515, at90c8534, at90s8535
> + */
> +static void avr_avr2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with at90s2313 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with at90s2313 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with at90s2313 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with at90s2313 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with at90s2313 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +}
> +
> +/*
> + * Setting features of AVR core type avr25
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5272, ata6616c, attiny13, attiny13a, attiny2313, attiny2313a, at=
tiny24,
> + * attiny24a, attiny4313, attiny44, attiny44a, attiny441, attiny84, at=
tiny84a,
> + * attiny25, attiny45, attiny85, attiny261, attiny261a, attiny461, att=
iny461a,
> + * attiny861, attiny861a, attiny43u, attiny87, attiny48, attiny88, att=
iny828,
> + * attiny841, at86rf401
> + */
> +static void avr_avr25_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with attiny13 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with attiny13 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with attiny13 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with attiny13 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with attiny13 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);> +    avr_set_feature(env,=
 AVR_FEATURE_MOVW);

Ok. Checked with attiny13 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr3
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * at43usb355, at76c711
> + */
> +static void avr_avr3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with at43usb355 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);> +    avr_set_featur=
e(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with at43usb355 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with at43usb355 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);
> +}

I couldn't find the full instruction set for this microcontrollers, but
according with this [1] (not a certainty at all) wikipedia page, all the
instructions in the features are part of the instruction set (BREAK,
ICALL, IJMP, JMP, CALL, ADIW, SBIW).

> +
> +/*
> + * Setting features of AVR core type avr31
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega103, at43usb320
> + */
> +static void avr_avr31_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ELPM);

Ok. Checked with atmega103 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atmega103 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr35
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5505, ata6617c, ata664251, at90usb82, at90usb162, atmega8u2, atm=
ega16u2,
> + * atmega32u2, attiny167, attiny1634
> + */
> +static void avr_avr35_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atmega8u2/16u2/32u2 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr4
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata6285, ata6286, ata6289, ata6612c, atmega8, atmega8a, atmega48, a=
tmega48a,
> + * atmega48p, atmega48pa, atmega48pb, atmega88, atmega88a, atmega88p,
> + * atmega88pa, atmega88pb, atmega8515, atmega8535, atmega8hva, at90pwm=
1,
> + * at90pwm2, at90pwm2b, at90pwm3, at90pwm3b, at90pwm81
> + */
> +static void avr_avr4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);
> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atmega8 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr5
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * ata5702m322, ata5782, ata5790, ata5790n, ata5791, ata5795, ata5831,=
 ata6613c,
> + * ata6614q, ata8210, ata8510, atmega16, atmega16a, atmega161, atmega1=
62,
> + * atmega163, atmega164a, atmega164p, atmega164pa, atmega165, atmega16=
5a,
> + * atmega165p, atmega165pa, atmega168, atmega168a, atmega168p, atmega1=
68pa,
> + * atmega168pb, atmega169, atmega169a, atmega169p, atmega169pa, atmega=
16hvb,
> + * atmega16hvbrevb, atmega16m1, atmega16u4, atmega32a, atmega32, atmeg=
a323,
> + * atmega324a, atmega324p, atmega324pa, atmega325, atmega325a, atmega3=
25p,
> + * atmega325pa, atmega3250, atmega3250a, atmega3250p, atmega3250pa, at=
mega328,
> + * atmega328p, atmega328pb, atmega329, atmega329a, atmega329p, atmega3=
29pa,
> + * atmega3290, atmega3290a, atmega3290p, atmega3290pa, atmega32c1, atm=
ega32m1,
> + * atmega32u4, atmega32u6, atmega406, atmega64, atmega64a, atmega640, =
atmega644,
> + * atmega644a, atmega644p, atmega644pa, atmega645, atmega645a, atmega6=
45p,
> + * atmega6450, atmega6450a, atmega6450p, atmega649, atmega649a, atmega=
649p,
> + * atmega6490, atmega16hva, atmega16hva2, atmega32hvb, atmega6490a, at=
mega6490p,
> + * atmega64c1, atmega64m1, atmega64hve, atmega64hve2, atmega64rfr2,
> + * atmega644rfr2, atmega32hvbrevb, at90can32, at90can64, at90pwm161, a=
t90pwm216,
> + * at90pwm316, at90scr100, at90usb646, at90usb647, at94k, m3000
> + */
> +static void avr_avr5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atmega640 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atmega8 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);> +    avr_set_feature=
(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atmega8 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atmega8 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr51
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega128, atmega128a, atmega1280, atmega1281, atmega1284, atmega12=
84p,
> + * atmega128rfa1, atmega128rfr2, atmega1284rfr2, at90can128, at90usb12=
86,
> + * at90usb1287
> + */
> +static void avr_avr51_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atmega128 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atmega128 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atmega128 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avr6
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atmega2560, atmega2561, atmega256rfr2, atmega2564rfr2
> + */
> +static void avr_avr6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atmega2560 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atmega2560 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atmega2560 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type avrtiny
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * attiny4, attiny5, attiny9, attiny10, attiny20, attiny40
> + */
> +static void avr_avrtiny_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

According with the attiny4/5/9/10 datasheet there is no LPM instruction.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with attiny4/5/9/10 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with attiny4/5/9/10 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with attiny4/5/9/10 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_1_BYTE_SP);
> +}
> +
> +/*
> + * Setting features of AVR core type xmega2
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega8e5, atxmega16a4, atxmega16d4, atxmega16e5, atxmega32a4, atx=
mega32c3,
> + * atxmega32d3, atxmega32d4, atxmega16a4u, atxmega16c4, atxmega32a4u,
> + * atxmega32c4, atxmega32e5
> + */
> +static void avr_xmega2_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);
> +    avr_set_feature(env, AVR_FEATURE_SRAM);
> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RMW);

Ok. Checked with atxmega8e5/16e5/32e5 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type xmega3
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * attiny212, attiny214, attiny412, attiny414, attiny416, attiny417, a=
ttiny814,
> + * attiny816, attiny817, attiny1614, attiny1616, attiny1617, attiny321=
4,
> + * attiny3216, attiny3217, atmega808, atmega809, atmega1608, atmega160=
9,
> + * atmega3208, atmega3209, atmega4808, atmega4809
> + */
> +static void avr_xmega3_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with attiny212 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with attiny212 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RMW);

Ok. Checked with attiny212 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type xmega4
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega64a3, atxmega64d3, atxmega64a3u, atxmega64a4u, atxmega64b1,
> + * atxmega64b3, atxmega64c3, atxmega64d4
> + */
> +static void avr_xmega4_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atxmega64a3 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atxmega64a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RMW);

Ok. Checked with atxmega64a3 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type xmega5
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega64a1, atxmega64a1u
> + */
> +static void avr_xmega5_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atxmega64a1 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atxmega64a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RMW);

Ok. Checked with atxmega64a1 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type xmega6
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega128a3, atxmega128d3, atxmega192a3, atxmega192d3, atxmega256a=
3,
> + * atxmega256a3b, atxmega256a3bu, atxmega256d3, atxmega128a3u, atxmega=
128b1,
> + * atxmega128b3, atxmega128c3, atxmega128d4, atxmega192a3u, atxmega192=
c3,
> + * atxmega256a3u, atxmega256c3, atxmega384c3, atxmega384d3
> + */
> +static void avr_xmega6_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atxmega128a3 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);
> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atxmega128a3 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RMW);

Ok. Checked with atxmega128a3 datasheet.

> +}
> +
> +/*
> + * Setting features of AVR core type xmega7
> + * --------------------------------------
> + *
> + * This type of AVR core is present in the following AVR MCUs:
> + *
> + * atxmega128a1, atxmega128a1u, atxmega128a4u
> + */
> +static void avr_xmega7_initfn(Object *obj)
> +{
> +    AVRCPU *cpu =3D AVR_CPU(obj);
> +    CPUAVRState *env =3D &cpu->env;
> +
> +    avr_set_feature(env, AVR_FEATURE_LPM);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_IJMP_ICALL);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ADIW_SBIW);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_SRAM);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_BREAK);

Ok. Checked with atxmega128a1 datasheet.

> +
> +    avr_set_feature(env, AVR_FEATURE_3_BYTE_PC);
> +    avr_set_feature(env, AVR_FEATURE_2_BYTE_SP);
> +    avr_set_feature(env, AVR_FEATURE_RAMPD);
> +    avr_set_feature(env, AVR_FEATURE_RAMPX);
> +    avr_set_feature(env, AVR_FEATURE_RAMPY);
> +    avr_set_feature(env, AVR_FEATURE_RAMPZ);
> +    avr_set_feature(env, AVR_FEATURE_EIJMP_EICALL);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_ELPMX);
> +    avr_set_feature(env, AVR_FEATURE_ELPM);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_JMP_CALL);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_LPMX);
> +    avr_set_feature(env, AVR_FEATURE_MOVW);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_MUL);

Ok. Checked with atxmega128a1 datasheet.

> +    avr_set_feature(env, AVR_FEATURE_RMW);

Ok. Checked with atxmega128a1 datasheet.

> +}
> ...


I hope this cross check is useful. The features that I didn't comment on
is because I'm not sure.

Really nice to have this in qemu :). Thanks!

--joa

[1] https://en.wikipedia.org/wiki/Atmel_AVR_instruction_set

