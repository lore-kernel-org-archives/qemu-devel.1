Return-Path: <SRS0=aHsE=2L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF3AC2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461DD2070B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 16:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHptzExZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461DD2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iihWQ-0006pp-Bo
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 11:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iihVi-0006Fj-D6
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:21:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iihVf-0004Tj-J9
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:21:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iihVf-0004QZ-6N
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 11:21:43 -0500
Received: by mail-oi1-x243.google.com with SMTP id p125so3657926oif.10
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 08:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ufIy8xzMtT86dTTBOFmSlR9aBkvQqhnk4nkLa85OtfU=;
 b=DHptzExZ5c2mk6FC55hcGkP7OdIeju9WYhdwb27LmL7oDNtrvOWuvGAmxMUmVCbzeo
 +fxk31JBiOoFvouJQa4lSnJY2FwCoqkXWNufT6dDyKx0L4TcO//gHsN+X/aWyE/sD/s0
 tynYvkBW36GmCKIpaSwEcZ3zyQpyPNKkrOl2zkmHME2hu2jIwC9XDcs77b3jdStuRBgB
 olP+1K4ZAMiIqyxEQQ5suYux8k0P+6KcyYtBtbm+ptEJQPWoUW38gr8P6oDczqfuR1Pl
 qzCbCdovkEUfPecj74bHCdNXWmrmfN411xIF9CVx/LPRx4qpoiUA0bTqBbXUc7Wldddq
 Nyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ufIy8xzMtT86dTTBOFmSlR9aBkvQqhnk4nkLa85OtfU=;
 b=iqEAgNxma972pElomFYfaOP/SCYDgfKzsPKVpcZLPtNfJH1I2Rn9t/C4cNE+CMRSxq
 u3V3oHLfkb7p9sInE4CyDXviRufw//wsrI6GxgBRoIUWjnYyn02k+g7Ht7hl/XZ2Q9am
 HeH1sYtrCprO0AofYpp0ovX7g4DHtXHcaYWIcPhysHWVveyVMxQbPxJIgoa1jcH+eJpS
 PxIBn9cjxVboFmGxEQrljh/kH4K46cFH0BbmGq8PD7tOl24egusVdDH37IQDiAR5bBKR
 Hlwduev0jKM2ICZs7JTila6srhcQO56APMv13uAD8jWZK8ohbs+VtdSzpXavH1cBKZUT
 fAXQ==
X-Gm-Message-State: APjAAAV1FXLetQRw235GQLnZMht24xf8Fsez8mXWwcU8Xqmdcda3d6CQ
 g/tDmM2f5j8N8JpMIJeix01cteqqsFZCO7LNnu8=
X-Google-Smtp-Source: APXvYqyr0fPouKWnOMNY6Gpk7QVLejt3//NHSqaTk/Vs/vl224Fzy0OHXa/hvw1yREU1TIeKcaF3ANa5wH632fExxHg=
X-Received: by 2002:aca:bbc6:: with SMTP id l189mr5330146oif.53.1576945302292; 
 Sat, 21 Dec 2019 08:21:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 21 Dec 2019 08:21:41 -0800 (PST)
In-Reply-To: <CAK4993iuuCZzyEzsqodpf_T_3xSSJeF-PP1XLO8PsXy6JwrgfA@mail.gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-4-mrolnik@gmail.com>
 <CAL1e-=hB5FhRtuxo1OGBSKA-aw1GW4RgpisKJWaT0TPHKaTVhw@mail.gmail.com>
 <CAK4993iuuCZzyEzsqodpf_T_3xSSJeF-PP1XLO8PsXy6JwrgfA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 21 Dec 2019 17:21:41 +0100
Message-ID: <CAL1e-=iQ=iBzn9sRDgx9Edi+rO=uP7RqpMyDJQD9RyiB5MwA=A@mail.gmail.com>
Subject: Re: [PATCH v39 03/22] target/avr: Add instruction decoding
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000092ce3d059a3930e8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000092ce3d059a3930e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Saturday, December 21, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi Aleksandar.
>
> please explain.
>
>>
>>
Hi, Michael.

I wanted to say:


1. Cut the parts of insn.decode that describe coding of arithmetic and
logic instructions and include them in the patch:

target/avr: Add instruction translation - Arithmetic and Logic Instructions


2. Cut the parts of insn.decode that describe coding of branch
instructions and include them in the patch:

target/avr: Add instruction translation - Branch Instructions

3. Cut the parts of insn.decode that describe coding of data transfer
instructions
and include them in the patch:

target/avr: Add instruction translation - Data Transfer Instructions


4. Cut the parts of insn.decode that describe coding of bit and bit-test
instructions and include them in the patch:

target/avr: Add instruction translation - Bit and Bit-test Instructions


5. Cut the parts of insn.decode that describe coding of MCU control
instructions
and include them in the patch:

target/avr: Add instruction translation - MCU Control Instructions


This way, your patches become logicaly-organized rather than file
organized. The patch on, let's say, arithmetic and logic instructions will
contain all elements needed for their implementation, rather than those
elements being split between decode and omplementation parts .



Regards,

Aleksandar



> On Sat, Dec 21, 2019 at 1:18 PM Aleksandar Markovic <
> aleksandar.m.mail@gmail.com> wrote:
>
>>
>>
>> On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com>
>> wrote:
>>
>>> This includes:
>>> - encoding of all 16 bit instructions
>>> - encoding of all 32 bit instructions
>>>
>>> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> ---
>>
>>
>> Michael,
>>
>> I am very pleased that you rearranged the order to be in sync with the
>> documentation.
>>
>> Now, for the next version, I would ask you to make this patch disappear.
>>
>> More precisely, "MCU Control Instructions" section of insn.decode file
>> move to be a part of "Add MCU Control Instructions" (not sure abiut the
>> title, but it is 6 or 7 patches after this one)  patch, and so on, in th=
e
>> same fashion, for all groups of instructions.
>>
>> Kind regards,
>>
>> Aleksandar
>>
>>
>>
>>  target/avr/insn.decode | 183 +++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 183 insertions(+)
>>>  create mode 100644 target/avr/insn.decode
>>>
>>> diff --git a/target/avr/insn.decode b/target/avr/insn.decode
>>> new file mode 100644
>>> index 0000000000..0e4ec9ddf0
>>> --- /dev/null
>>> +++ b/target/avr/insn.decode
>>> @@ -0,0 +1,183 @@
>>> +#
>>> +# AVR instruction decode definitions.
>>> +#
>>> +# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
>>> +#
>>> +# This library is free software; you can redistribute it and/or
>>> +# modify it under the terms of the GNU Lesser General Public
>>> +# License as published by the Free Software Foundation; either
>>> +# version 2.1 of the License, or (at your option) any later version.
>>> +#
>>> +# This library is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> +# Lesser General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU Lesser General Public
>>> +# License along with this library; if not, see <
>>> http://www.gnu.org/licenses/>.
>>> +#
>>> +
>>> +#
>>> +#   regs_16_31_by_one =3D [16 .. 31]
>>> +#   regs_16_23_by_one =3D [16 .. 23]
>>> +#   regs_24_30_by_two =3D [24, 26, 28, 30]
>>> +#   regs_00_30_by_two =3D [0, 2, 4, 6, 8, .. 30]
>>> +
>>> +%rd             4:5
>>> +%rr             9:1 0:4
>>> +
>>> +%rd_a           4:4                         !function=3Dto_regs_16_31_=
by_
>>> one
>>> +%rd_b           4:3                         !function=3Dto_regs_16_23_=
by_
>>> one
>>> +%rd_c           4:2                         !function=3Dto_regs_24_30_=
by_
>>> two
>>> +%rd_d           4:4                         !function=3Dto_regs_00_30_=
by_
>>> two
>>> +%rr_a           0:4                         !function=3Dto_regs_16_31_=
by_
>>> one
>>> +%rr_b           0:3                         !function=3Dto_regs_16_23_=
by_
>>> one
>>> +%rr_d           0:4                         !function=3Dto_regs_00_30_=
by_
>>> two
>>> +
>>> +%imm6           6:2 0:4
>>> +%imm8           8:4 0:4
>>> +
>>> +%io_imm         9:2 0:4
>>> +%ldst_d_imm     13:1 10:2 0:3
>>> +
>>> +# The 22-bit immediate is partially in the opcode word,
>>> +# and partially in the next.  Use append_16 to build the
>>> +# complete 22-bit value.
>>> +%imm_call       4:5 0:1                     !function=3Dappend_16
>>> +
>>> +
>>> +&rd_rr          rd rr
>>> +&rd_imm         rd imm
>>> +
>>> +@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=3D%rd rr=3D=
%rr
>>> +@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=3D%rd_c
>>> imm=3D%imm6
>>> +@op_rd_imm8     .... .... .... ....         &rd_imm     rd=3D%rd_a
>>> imm=3D%imm8
>>> +@op_bit         .... .... . bit:3 ....
>>> +@op_bit_imm     .... .. imm:s7 bit:3
>>> +@fmul           .... .... . ... . ...       &rd_rr      rd=3D%rd_b
>>> rr=3D%rr_b
>>> +@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=3D%rd
>>> imm=3D%io_imm
>>> +@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=3D%ldst_d_=
imm
>>> +
>>> +# The 16-bit immediate is completely in the next word.
>>> +# Fields cannot be defined with no bits, so we cannot play
>>> +# the same trick and append to a zero-bit value.
>>> +# Defer reading the immediate until trans_{LDS,STS}.
>>> +@ldst_s         .... ... rd:5 ....          imm=3D0
>>> +
>>> +#
>>> +# Arithmetic Instructions
>>> +#
>>> +ADD             0000 11 . ..... ....        @op_rd_rr
>>> +ADC             0001 11 . ..... ....        @op_rd_rr
>>> +ADIW            1001 0110 .. .. ....        @op_rd_imm6
>>> +SUB             0001 10 . ..... ....        @op_rd_rr
>>> +SUBI            0101 .... .... ....         @op_rd_imm8
>>> +SBC             0000 10 . ..... ....        @op_rd_rr
>>> +SBCI            0100 .... .... ....         @op_rd_imm8
>>> +SBIW            1001 0111 .. .. ....        @op_rd_imm6
>>> +AND             0010 00 . ..... ....        @op_rd_rr
>>> +ANDI            0111 .... .... ....         @op_rd_imm8
>>> +OR              0010 10 . ..... ....        @op_rd_rr
>>> +ORI             0110 .... .... ....         @op_rd_imm8
>>> +EOR             0010 01 . ..... ....        @op_rd_rr
>>> +COM             1001 010 rd:5 0000
>>> +NEG             1001 010 rd:5 0001
>>> +INC             1001 010 rd:5 0011
>>> +DEC             1001 010 rd:5 1010
>>> +MUL             1001 11 . ..... ....        @op_rd_rr
>>> +MULS            0000 0010 .... ....         &rd_rr      rd=3D%rd_a
>>> rr=3D%rr_a
>>> +MULSU           0000 0011 0 ... 0 ...       @fmul
>>> +FMUL            0000 0011 0 ... 1 ...       @fmul
>>> +FMULS           0000 0011 1 ... 0 ...       @fmul
>>> +FMULSU          0000 0011 1 ... 1 ...       @fmul
>>> +DES             1001 0100 imm:4 1011
>>> +
>>> +#
>>> +# Branch Instructions
>>> +#
>>> +RJMP            1100 imm:s12
>>> +IJMP            1001 0100 0000 1001
>>> +EIJMP           1001 0100 0001 1001
>>> +JMP             1001 010 ..... 110 .        imm=3D%imm_call
>>> +RCALL           1101 imm:s12
>>> +ICALL           1001 0101 0000 1001
>>> +EICALL          1001 0101 0001 1001
>>> +CALL            1001 010 ..... 111 .        imm=3D%imm_call
>>> +RET             1001 0101 0000 1000
>>> +RETI            1001 0101 0001 1000
>>> +CPSE            0001 00 . ..... ....        @op_rd_rr
>>> +CP              0001 01 . ..... ....        @op_rd_rr
>>> +CPC             0000 01 . ..... ....        @op_rd_rr
>>> +CPI             0011 .... .... ....         @op_rd_imm8
>>> +SBRC            1111 110 rr:5 0 bit:3
>>> +SBRS            1111 111 rr:5 0 bit:3
>>> +SBIC            1001 1001 reg:5 bit:3
>>> +SBIS            1001 1011 reg:5 bit:3
>>> +BRBS            1111 00 ....... ...         @op_bit_imm
>>> +BRBC            1111 01 ....... ...         @op_bit_imm
>>> +
>>> +#
>>> +# Data Transfer Instructions
>>> +#
>>> +MOV             0010 11 . ..... ....        @op_rd_rr
>>> +MOVW            0000 0001 .... ....         &rd_rr      rd=3D%rd_d
>>> rr=3D%rr_d
>>> +LDI             1110 .... .... ....         @op_rd_imm8
>>> +LDS             1001 000 ..... 0000         @ldst_s
>>> +LDX1            1001 000 rd:5 1100
>>> +LDX2            1001 000 rd:5 1101
>>> +LDX3            1001 000 rd:5 1110
>>> +LDY2            1001 000 rd:5 1001
>>> +LDY3            1001 000 rd:5 1010
>>> +LDZ2            1001 000 rd:5 0001
>>> +LDZ3            1001 000 rd:5 0010
>>> +LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
>>> +LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
>>> +STS             1001 001 ..... 0000         @ldst_s
>>> +STX1            1001 001 rr:5 1100
>>> +STX2            1001 001 rr:5 1101
>>> +STX3            1001 001 rr:5 1110
>>> +STY2            1001 001 rd:5 1001
>>> +STY3            1001 001 rd:5 1010
>>> +STZ2            1001 001 rd:5 0001
>>> +STZ3            1001 001 rd:5 0010
>>> +STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
>>> +STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
>>> +LPM1            1001 0101 1100 1000
>>> +LPM2            1001 000 rd:5 0100
>>> +LPMX            1001 000 rd:5 0101
>>> +ELPM1           1001 0101 1101 1000
>>> +ELPM2           1001 000 rd:5 0110
>>> +ELPMX           1001 000 rd:5 0111
>>> +SPM             1001 0101 1110 1000
>>> +SPMX            1001 0101 1111 1000
>>> +IN              1011 0 .. ..... ....        @io_rd_imm
>>> +OUT             1011 1 .. ..... ....        @io_rd_imm
>>> +PUSH            1001 001 rd:5 1111
>>> +POP             1001 000 rd:5 1111
>>> +XCH             1001 001 rd:5 0100
>>> +LAC             1001 001 rd:5 0110
>>> +LAS             1001 001 rd:5 0101
>>> +LAT             1001 001 rd:5 0111
>>> +
>>> +#
>>> +# Bit and Bit-test Instructions
>>> +#
>>> +LSR             1001 010 rd:5 0110
>>> +ROR             1001 010 rd:5 0111
>>> +ASR             1001 010 rd:5 0101
>>> +SWAP            1001 010 rd:5 0010
>>> +SBI             1001 1010 reg:5 bit:3
>>> +CBI             1001 1000 reg:5 bit:3
>>> +BST             1111 101 rd:5 0 bit:3
>>> +BLD             1111 100 rd:5 0 bit:3
>>> +BSET            1001 0100 0 bit:3 1000
>>> +BCLR            1001 0100 1 bit:3 1000
>>> +
>>> +#
>>> +# MCU Control Instructions
>>> +#
>>> +BREAK           1001 0101 1001 1000
>>> +NOP             0000 0000 0000 0000
>>> +SLEEP           1001 0101 1000 1000
>>> +WDR             1001 0101 1010 1000
>>> +
>>> --
>>> 2.17.2 (Apple Git-113)
>>>
>>>
>
> --
> Best Regards,
> Michael Rolnik
>

--00000000000092ce3d059a3930e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, December 21, 2019, Michael Rolnik &lt;<a href=3D"mailt=
o:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div dir=3D"ltr">Hi Aleksandar.<div><br></div><div>please exp=
lain.</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquote></blockquo=
te><div><br></div><div>Hi, Michael.</div><div><br></div><div>I wanted to sa=
y:</div><div><br></div><div><br></div><div>1. Cut the parts of insn.decode =
that describe coding of arithmetic and logic instructions and include them =
in the patch:</div><div><pre>target/avr: Add instruction <span style=3D"fon=
t-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif">translation -=
 Arithmetic and Logic Instructions</span></pre><pre><span style=3D"font-fam=
ily:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif"><br></span></pre><=
pre><div style=3D"font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans=
-serif;white-space:normal">2. Cut the parts of insn.decode that describe co=
ding of branch instructions and include them in the patch:</div><div style=
=3D"font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;white-s=
pace:normal"></div></pre><pre>target/avr: Add instruction translation - Bra=
nch Instructions
<br></pre><div>3. Cut the parts of insn.decode that describe coding of d<sp=
an style=3D"white-space:pre-wrap">ata transfer </span>instructions and incl=
ude them in the=C2=A0patch:<br></div><div></div><pre><span style=3D"font-fa=
mily:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif">target/avr: Add i=
nstruction translation - Data Transfer Instructions</span></pre><pre><span =
style=3D"font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif"><=
br></span></pre><div>4. Cut the parts of insn.decode that describe coding o=
f bit and bit-test instructions and include them in the patch:</div><div></=
div><pre><span style=3D"font-family:&#39;Helvetica Neue&#39;,Helvetica,Aria=
l,sans-serif">target/avr: Add instruction translation - Bit and Bit-test In=
structions</span></pre><pre><span style=3D"font-family:&#39;Helvetica Neue&=
#39;,Helvetica,Arial,sans-serif"><br></span></pre><div>5. Cut the parts of =
insn.decode that describe coding of=C2=A0<span style=3D"white-space:pre-wra=
p">MCU control</span>=C2=A0instructions and include them in=C2=A0the patch:=
<br></div><div></div><pre><span style=3D"font-family:&#39;Helvetica Neue&#3=
9;,Helvetica,Arial,sans-serif">target/avr: Add instruction translation - MC=
U Control Instructions</span><br></pre></div><div><br></div><div>This way, =
your patches become logicaly-organized rather than file organized. The patc=
h on, let&#39;s say, arithmetic and logic instructions will contain all ele=
ments needed for their implementation, rather than those elements being spl=
it between decode and omplementation parts .</div><div><br></div><div><br><=
/div><div><br></div><div>Regards,</div><div><br></div><div>Aleksandar</div>=
<div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Dec 21, 2019=
 at 1:18 PM Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.m.mail@gma=
il.com" target=3D"_blank">aleksandar.m.mail@gmail.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><br><br>On Wednesday, =
December 18, 2019, Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" =
target=3D"_blank">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">This includes:<br>
- encoding of all 16 bit instructions<br>
- encoding of all 32 bit instructions<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" targ=
et=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.=
com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
---</blockquote><div><br></div><div>Michael,</div><div><br></div><div>I am =
very pleased that you rearranged the order to be in sync with the documenta=
tion.</div><div><br></div><div>Now, for the next version, I would ask you t=
o make this patch disappear.</div><div><br></div><div>More precisely, &quot=
;MCU Control Instructions&quot; section of=C2=A0insn.decode file move to be=
 a part of &quot;Add MCU Control Instructions&quot; (not sure abiut the tit=
le, but it is 6 or 7 patches after this one) =C2=A0patch, and so on, in the=
 same fashion, for all groups of instructions.</div><div><br></div><div>Kin=
d regards,</div><div><br></div><div>Aleksandar</div><div><br></div><div><br=
></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0target/avr/insn.decode | 183 ++++++++++++++++++++++++++++++<wbr>+++++=
++++++<br>
=C2=A01 file changed, 183 insertions(+)<br>
=C2=A0create mode 100644 target/avr/insn.decode<br>
<br>
diff --git a/target/avr/insn.decode b/target/avr/insn.decode<br>
new file mode 100644<br>
index 0000000000..0e4ec9ddf0<br>
--- /dev/null<br>
+++ b/target/avr/insn.decode<br>
@@ -0,0 +1,183 @@<br>
+#<br>
+# AVR instruction decode definitions.<br>
+#<br>
+# Copyright (c) 2019 Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.co=
m" target=3D"_blank">mrolnik@gmail.com</a>&gt;<br>
+#<br>
+# This library is free software; you can redistribute it and/or<br>
+# modify it under the terms of the GNU Lesser General Public<br>
+# License as published by the Free Software Foundation; either<br>
+# version 2.1 of the License, or (at your option) any later version.<br>
+#<br>
+# This library is distributed in the hope that it will be useful,<br>
+# but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU<b=
r>
+# Lesser General Public License for more details.<br>
+#<br>
+# You should have received a copy of the GNU Lesser General Public<br>
+# License along with this library; if not, see &lt;<a href=3D"http://www.g=
nu.org/licenses/" target=3D"_blank">http://www.gnu.org/licenses/</a>&gt;<wb=
r>.<br>
+#<br>
+<br>
+#<br>
+#=C2=A0 =C2=A0regs_16_31_by_one =3D [16 .. 31]<br>
+#=C2=A0 =C2=A0regs_16_23_by_one =3D [16 .. 23]<br>
+#=C2=A0 =C2=A0regs_24_30_by_two =3D [24, 26, 28, 30]<br>
+#=C2=A0 =C2=A0regs_00_30_by_two =3D [0, 2, 4, 6, 8, .. 30]<br>
+<br>
+%rd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04:5<br>
+%rr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09:1 0:4<br>
+<br>
+%rd_a=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04:4=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_16_31_by_<wbr>one<br>
+%rd_b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04:3=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_16_23_by_<wbr>one<br>
+%rd_c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04:2=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_24_30_by_<wbr>two<br>
+%rd_d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A04:4=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_00_30_by_<wbr>two<br>
+%rr_a=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:4=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_16_31_by_<wbr>one<br>
+%rr_b=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:3=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_16_23_by_<wbr>one<br>
+%rr_d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00:4=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=
=3Dto_regs_00_30_by_<wbr>two<br>
+<br>
+%imm6=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06:2 0:4<br>
+%imm8=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A08:4 0:4<br>
+<br>
+%io_imm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A09:2 0:4<br>
+%ldst_d_imm=C2=A0 =C2=A0 =C2=A013:1 10:2 0:3<br>
+<br>
+# The 22-bit immediate is partially in the opcode word,<br>
+# and partially in the next.=C2=A0 Use append_16 to build the<br>
+# complete 22-bit value.<br>
+%imm_call=C2=A0 =C2=A0 =C2=A0 =C2=A04:5 0:1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!function=3Dappend_16<br>
+<br>
+<br>
+&amp;rd_rr=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rd rr<br>
+&amp;rd_imm=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd imm<br>
+<br>
+@op_rd_rr=C2=A0 =C2=A0 =C2=A0 =C2=A0.... .. . ..... ....=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &amp;rd_rr=C2=A0 =C2=A0 =C2=A0 rd=3D%rd rr=3D%rr<br>
+@op_rd_imm6=C2=A0 =C2=A0 =C2=A0.... .... .. .. ....=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &amp;rd_imm=C2=A0 =C2=A0 =C2=A0rd=3D%rd_c imm=3D%imm6<br>
+@op_rd_imm8=C2=A0 =C2=A0 =C2=A0.... .... .... ....=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;rd_imm=C2=A0 =C2=A0 =C2=A0rd=3D%rd_a imm=3D%imm8<br>
+@op_bit=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.... .... . bit:3 ....<br>
+@op_bit_imm=C2=A0 =C2=A0 =C2=A0.... .. imm:s7 bit:3<br>
+@fmul=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.... .... . ... . ...=C2=A0 =
=C2=A0 =C2=A0 =C2=A0&amp;rd_rr=C2=A0 =C2=A0 =C2=A0 rd=3D%rd_b rr=3D%rr_b<br=
>
+@io_rd_imm=C2=A0 =C2=A0 =C2=A0 .... . .. ..... ....=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 &amp;rd_imm=C2=A0 =C2=A0 =C2=A0rd=3D%rd imm=3D%io_imm<br>
+@ldst_d=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.. . . .. . rd:5=C2=A0 . ...=C2=
=A0 =C2=A0 =C2=A0&amp;rd_imm=C2=A0 =C2=A0 =C2=A0imm=3D%ldst_d_imm<br>
+<br>
+# The 16-bit immediate is completely in the next word.<br>
+# Fields cannot be defined with no bits, so we cannot play<br>
+# the same trick and append to a zero-bit value.<br>
+# Defer reading the immediate until trans_{LDS,STS}.<br>
+@ldst_s=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.... ... rd:5 ....=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 imm=3D0<br>
+<br>
+#<br>
+# Arithmetic Instructions<br>
+#<br>
+ADD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000 11 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+ADC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00001 11 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+ADIW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0110 .. .. ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 @op_rd_imm6<br>
+SUB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00001 10 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+SUBI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0101 .... .... ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0@op_rd_imm8<br>
+SBC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000 10 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+SBCI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0100 .... .... ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0@op_rd_imm8<br>
+SBIW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0111 .. .. ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 @op_rd_imm6<br>
+AND=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00010 00 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+ANDI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0111 .... .... ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0@op_rd_imm8<br>
+OR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0010 10 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+ORI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00110 .... .... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@op_rd_imm8<br>
+EOR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00010 01 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+COM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 0000<br>
+NEG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 0001<br>
+INC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 0011<br>
+DEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 1010<br>
+MUL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 11 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+MULS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000 0010 .... ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;rd_rr=C2=A0 =C2=A0 =C2=A0 rd=3D%rd_a rr=3D%=
rr_a<br>
+MULSU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000 0011 0 ... 0 ...=C2=A0 =
=C2=A0 =C2=A0 =C2=A0@fmul<br>
+FMUL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000 0011 0 ... 1 ...=C2=A0 =
=C2=A0 =C2=A0 =C2=A0@fmul<br>
+FMULS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000 0011 1 ... 0 ...=C2=A0 =
=C2=A0 =C2=A0 =C2=A0@fmul<br>
+FMULSU=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000 0011 1 ... 1 ...=C2=A0 =C2=
=A0 =C2=A0 =C2=A0@fmul<br>
+DES=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0100 imm:4 1011<br=
>
+<br>
+#<br>
+# Branch Instructions<br>
+#<br>
+RJMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1100 imm:s12<br>
+IJMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0100 0000 1001<br>
+EIJMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0100 0001 1001<br>
+JMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 ..... 110 .=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 imm=3D%imm_call<br>
+RCALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01101 imm:s12<br>
+ICALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 0000 1001<br>
+EICALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0101 0001 1001<br>
+CALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 010 ..... 111 .=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 imm=3D%imm_call<br>
+RET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 0000 1000<br>
+RETI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0101 0001 1000<br>
+CPSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0001 00 . ..... ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+CP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0001 01 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+CPC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000 01 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+CPI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00011 .... .... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@op_rd_imm8<br>
+SBRC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1111 110 rr:5 0 bit:3<br>
+SBRS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1111 111 rr:5 0 bit:3<br>
+SBIC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 1001 reg:5 bit:3<br>
+SBIS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 1011 reg:5 bit:3<br>
+BRBS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1111 00 ....... ...=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0@op_bit_imm<br>
+BRBC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1111 01 ....... ...=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0@op_bit_imm<br>
+<br>
+#<br>
+# Data Transfer Instructions<br>
+#<br>
+MOV=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00010 11 . ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @op_rd_rr<br>
+MOVW=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0000 0001 .... ....=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;rd_rr=C2=A0 =C2=A0 =C2=A0 rd=3D%rd_d rr=3D%=
rr_d<br>
+LDI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01110 .... .... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@op_rd_imm8<br>
+LDS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 000 ..... 0000=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@ldst_s<br>
+LDX1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 1100<br>
+LDX2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 1101<br>
+LDX3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 1110<br>
+LDY2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 1001<br>
+LDY3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 1010<br>
+LDZ2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 0001<br>
+LDZ3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 0010<br>
+LDDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10 . 0 .. 0 ..... 1 ...=C2=
=A0 =C2=A0 =C2=A0@ldst_d<br>
+LDDZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10 . 0 .. 0 ..... 0 ...=C2=
=A0 =C2=A0 =C2=A0@ldst_d<br>
+STS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 001 ..... 0000=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0@ldst_s<br>
+STX1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rr:5 1100<br>
+STX2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rr:5 1101<br>
+STX3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rr:5 1110<br>
+STY2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rd:5 1001<br>
+STY3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rd:5 1010<br>
+STZ2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rd:5 0001<br>
+STZ3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rd:5 0010<br>
+STDY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10 . 0 .. 1 ..... 1 ...=C2=
=A0 =C2=A0 =C2=A0@ldst_d<br>
+STDZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10 . 0 .. 1 ..... 0 ...=C2=
=A0 =C2=A0 =C2=A0@ldst_d<br>
+LPM1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0101 1100 1000<br>
+LPM2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 0100<br>
+LPMX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 000 rd:5 0101<br>
+ELPM1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 1101 1000<br>
+ELPM2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 000 rd:5 0110<br>
+ELPMX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 000 rd:5 0111<br>
+SPM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 1110 1000<br>
+SPMX=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0101 1111 1000<br>
+IN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1011 0 .. ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @io_rd_imm<br>
+OUT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01011 1 .. ..... ....=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 @io_rd_imm<br>
+PUSH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 001 rd:5 1111<br>
+POP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 000 rd:5 1111<br>
+XCH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 001 rd:5 0100<br>
+LAC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 001 rd:5 0110<br>
+LAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 001 rd:5 0101<br>
+LAT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 001 rd:5 0111<br>
+<br>
+#<br>
+# Bit and Bit-test Instructions<br>
+#<br>
+LSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 0110<br>
+ROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 0111<br>
+ASR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 010 rd:5 0101<br>
+SWAP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 010 rd:5 0010<br>
+SBI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 1010 reg:5 bit:3<b=
r>
+CBI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 1000 reg:5 bit:3<b=
r>
+BST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01111 101 rd:5 0 bit:3<b=
r>
+BLD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01111 100 rd:5 0 bit:3<b=
r>
+BSET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0100 0 bit:3 1000<br>
+BCLR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 1001 0100 1 bit:3 1000<br>
+<br>
+#<br>
+# MCU Control Instructions<br>
+#<br>
+BREAK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 1001 1000<br>
+NOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00000 0000 0000 0000<br>
+SLEEP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 1000 1000<br>
+WDR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01001 0101 1010 1000<br>
+<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>
</blockquote>

--00000000000092ce3d059a3930e8--

