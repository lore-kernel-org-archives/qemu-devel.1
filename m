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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD842C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 11:19:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD7920665
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2019 11:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q+beBWX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD7920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38441 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iicnI-0007qL-I9
	for qemu-devel@archiver.kernel.org; Sat, 21 Dec 2019 06:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iicmR-0007Lx-3J
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iicmO-0005W7-3W
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:18:42 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:43621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iicmN-0005Ul-Ik
 for qemu-devel@nongnu.org; Sat, 21 Dec 2019 06:18:39 -0500
Received: by mail-ot1-x329.google.com with SMTP id p8so15395321oth.10
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2019 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=jjwFFTfyJcvCHimv+MIKSpGgYzmnm4XB8e1P5ZjHbYU=;
 b=q+beBWX+fDsCL+2Eek0yof2JFSecmoBTlLjDwqlYBs1b/5f5LL8QQxFCRlFjK0TfxO
 2pJ6BV1h7jzie1JI+yep2nvi+83GEOUiU3JgBI1F6Ob+2tzFEJPRHpSwHubVME8Rqybg
 4Ejm61OmDURZdQEamLuDhniC8IRknA/qH56HG1n71J0ezJ+iqpqrsVpoZx2/FnK6lI/3
 BtqFdcrY3egXeQq6eHY/GkQpTDdf5LAG53MhFE/xQmdwN7XtoAisOQGFmX2b9N9JVp0c
 etGAb/p3e1It5Gx6YZ13I8lZkAuObVCPJrD+sMSXhfJhtv89sU8iLdQxxieLyWqFQrwz
 LHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=jjwFFTfyJcvCHimv+MIKSpGgYzmnm4XB8e1P5ZjHbYU=;
 b=kXUHTlOLbv2exdWiyKndJTVjMz9U9WZf/arOyQYBEAf4Ae2lxHFKmFyCk02d19eOOx
 rZ648hxPruaKrfQkcW3/AHNB6KXtmyUi9pq1QUDtlMHIDBpWYDJReqxHY9oNyLGgz1os
 hkvnnvfXNJywCiu889+IYrsIS5RiOG+tlTXFkbyLmA06ugJWhvkUZDLGfgKPmh9pYK1w
 eaVvLYncuuvbaqJgSQdw3KS+C7HHc79ul0E3Q3Ls57Yipv4vtfbJeSFTIjV+usmKK7gg
 Ju6ZBd9CcwQzVL3psWBOiOk/n4JS5ugIAEX7mitaylw7rj2Mh/ZvHauxlBVoYV5iJyUf
 Ccog==
X-Gm-Message-State: APjAAAWaXQFyIrL31usoXWLB7t5DInIAGC15fAP94Vj/cmELlHt2ALKM
 G6yG6TMmD8FK9/FiIwZBEu5DktRMfyC6KCxpQHg=
X-Google-Smtp-Source: APXvYqw4AZll1Qv5nw10C2fhN52283WxBHk0c4A/NuwMa88sdshqUjl66tXLDsZbGDljSJuMpTFdADoRyR75YV98wnM=
X-Received: by 2002:a05:6830:1741:: with SMTP id
 1mr21446182otz.295.1576927118597; 
 Sat, 21 Dec 2019 03:18:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Sat, 21 Dec 2019 03:18:38 -0800 (PST)
In-Reply-To: <20191218210329.1960-4-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-4-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 21 Dec 2019 12:18:38 +0100
Message-ID: <CAL1e-=hB5FhRtuxo1OGBSKA-aw1GW4RgpisKJWaT0TPHKaTVhw@mail.gmail.com>
Subject: Re: [PATCH v39 03/22] target/avr: Add instruction decoding
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bda4ad059a34f4c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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

--000000000000bda4ad059a34f4c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> This includes:
> - encoding of all 16 bit instructions
> - encoding of all 32 bit instructions
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


Michael,

I am very pleased that you rearranged the order to be in sync with the
documentation.

Now, for the next version, I would ask you to make this patch disappear.

More precisely, "MCU Control Instructions" section of insn.decode file move
to be a part of "Add MCU Control Instructions" (not sure abiut the title,
but it is 6 or 7 patches after this one)  patch, and so on, in the same
fashion, for all groups of instructions.

Kind regards,

Aleksandar



 target/avr/insn.decode | 183 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 183 insertions(+)
>  create mode 100644 target/avr/insn.decode
>
> diff --git a/target/avr/insn.decode b/target/avr/insn.decode
> new file mode 100644
> index 0000000000..0e4ec9ddf0
> --- /dev/null
> +++ b/target/avr/insn.decode
> @@ -0,0 +1,183 @@
> +#
> +# AVR instruction decode definitions.
> +#
> +# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
> +#
> +# This library is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU Lesser General Public
> +# License as published by the Free Software Foundation; either
> +# version 2.1 of the License, or (at your option) any later version.
> +#
> +# This library is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +# Lesser General Public License for more details.
> +#
> +# You should have received a copy of the GNU Lesser General Public
> +# License along with this library; if not, see <
> http://www.gnu.org/licenses/>.
> +#
> +
> +#
> +#   regs_16_31_by_one =3D [16 .. 31]
> +#   regs_16_23_by_one =3D [16 .. 23]
> +#   regs_24_30_by_two =3D [24, 26, 28, 30]
> +#   regs_00_30_by_two =3D [0, 2, 4, 6, 8, .. 30]
> +
> +%rd             4:5
> +%rr             9:1 0:4
> +
> +%rd_a           4:4                         !function=3Dto_regs_16_31_by=
_one
> +%rd_b           4:3                         !function=3Dto_regs_16_23_by=
_one
> +%rd_c           4:2                         !function=3Dto_regs_24_30_by=
_two
> +%rd_d           4:4                         !function=3Dto_regs_00_30_by=
_two
> +%rr_a           0:4                         !function=3Dto_regs_16_31_by=
_one
> +%rr_b           0:3                         !function=3Dto_regs_16_23_by=
_one
> +%rr_d           0:4                         !function=3Dto_regs_00_30_by=
_two
> +
> +%imm6           6:2 0:4
> +%imm8           8:4 0:4
> +
> +%io_imm         9:2 0:4
> +%ldst_d_imm     13:1 10:2 0:3
> +
> +# The 22-bit immediate is partially in the opcode word,
> +# and partially in the next.  Use append_16 to build the
> +# complete 22-bit value.
> +%imm_call       4:5 0:1                     !function=3Dappend_16
> +
> +
> +&rd_rr          rd rr
> +&rd_imm         rd imm
> +
> +@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=3D%rd rr=3D%r=
r
> +@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=3D%rd_c imm=
=3D%imm6
> +@op_rd_imm8     .... .... .... ....         &rd_imm     rd=3D%rd_a imm=
=3D%imm8
> +@op_bit         .... .... . bit:3 ....
> +@op_bit_imm     .... .. imm:s7 bit:3
> +@fmul           .... .... . ... . ...       &rd_rr      rd=3D%rd_b rr=3D=
%rr_b
> +@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=3D%rd imm=3D%=
io_imm
> +@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=3D%ldst_d_im=
m
> +
> +# The 16-bit immediate is completely in the next word.
> +# Fields cannot be defined with no bits, so we cannot play
> +# the same trick and append to a zero-bit value.
> +# Defer reading the immediate until trans_{LDS,STS}.
> +@ldst_s         .... ... rd:5 ....          imm=3D0
> +
> +#
> +# Arithmetic Instructions
> +#
> +ADD             0000 11 . ..... ....        @op_rd_rr
> +ADC             0001 11 . ..... ....        @op_rd_rr
> +ADIW            1001 0110 .. .. ....        @op_rd_imm6
> +SUB             0001 10 . ..... ....        @op_rd_rr
> +SUBI            0101 .... .... ....         @op_rd_imm8
> +SBC             0000 10 . ..... ....        @op_rd_rr
> +SBCI            0100 .... .... ....         @op_rd_imm8
> +SBIW            1001 0111 .. .. ....        @op_rd_imm6
> +AND             0010 00 . ..... ....        @op_rd_rr
> +ANDI            0111 .... .... ....         @op_rd_imm8
> +OR              0010 10 . ..... ....        @op_rd_rr
> +ORI             0110 .... .... ....         @op_rd_imm8
> +EOR             0010 01 . ..... ....        @op_rd_rr
> +COM             1001 010 rd:5 0000
> +NEG             1001 010 rd:5 0001
> +INC             1001 010 rd:5 0011
> +DEC             1001 010 rd:5 1010
> +MUL             1001 11 . ..... ....        @op_rd_rr
> +MULS            0000 0010 .... ....         &rd_rr      rd=3D%rd_a rr=3D=
%rr_a
> +MULSU           0000 0011 0 ... 0 ...       @fmul
> +FMUL            0000 0011 0 ... 1 ...       @fmul
> +FMULS           0000 0011 1 ... 0 ...       @fmul
> +FMULSU          0000 0011 1 ... 1 ...       @fmul
> +DES             1001 0100 imm:4 1011
> +
> +#
> +# Branch Instructions
> +#
> +RJMP            1100 imm:s12
> +IJMP            1001 0100 0000 1001
> +EIJMP           1001 0100 0001 1001
> +JMP             1001 010 ..... 110 .        imm=3D%imm_call
> +RCALL           1101 imm:s12
> +ICALL           1001 0101 0000 1001
> +EICALL          1001 0101 0001 1001
> +CALL            1001 010 ..... 111 .        imm=3D%imm_call
> +RET             1001 0101 0000 1000
> +RETI            1001 0101 0001 1000
> +CPSE            0001 00 . ..... ....        @op_rd_rr
> +CP              0001 01 . ..... ....        @op_rd_rr
> +CPC             0000 01 . ..... ....        @op_rd_rr
> +CPI             0011 .... .... ....         @op_rd_imm8
> +SBRC            1111 110 rr:5 0 bit:3
> +SBRS            1111 111 rr:5 0 bit:3
> +SBIC            1001 1001 reg:5 bit:3
> +SBIS            1001 1011 reg:5 bit:3
> +BRBS            1111 00 ....... ...         @op_bit_imm
> +BRBC            1111 01 ....... ...         @op_bit_imm
> +
> +#
> +# Data Transfer Instructions
> +#
> +MOV             0010 11 . ..... ....        @op_rd_rr
> +MOVW            0000 0001 .... ....         &rd_rr      rd=3D%rd_d rr=3D=
%rr_d
> +LDI             1110 .... .... ....         @op_rd_imm8
> +LDS             1001 000 ..... 0000         @ldst_s
> +LDX1            1001 000 rd:5 1100
> +LDX2            1001 000 rd:5 1101
> +LDX3            1001 000 rd:5 1110
> +LDY2            1001 000 rd:5 1001
> +LDY3            1001 000 rd:5 1010
> +LDZ2            1001 000 rd:5 0001
> +LDZ3            1001 000 rd:5 0010
> +LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
> +LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
> +STS             1001 001 ..... 0000         @ldst_s
> +STX1            1001 001 rr:5 1100
> +STX2            1001 001 rr:5 1101
> +STX3            1001 001 rr:5 1110
> +STY2            1001 001 rd:5 1001
> +STY3            1001 001 rd:5 1010
> +STZ2            1001 001 rd:5 0001
> +STZ3            1001 001 rd:5 0010
> +STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
> +STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
> +LPM1            1001 0101 1100 1000
> +LPM2            1001 000 rd:5 0100
> +LPMX            1001 000 rd:5 0101
> +ELPM1           1001 0101 1101 1000
> +ELPM2           1001 000 rd:5 0110
> +ELPMX           1001 000 rd:5 0111
> +SPM             1001 0101 1110 1000
> +SPMX            1001 0101 1111 1000
> +IN              1011 0 .. ..... ....        @io_rd_imm
> +OUT             1011 1 .. ..... ....        @io_rd_imm
> +PUSH            1001 001 rd:5 1111
> +POP             1001 000 rd:5 1111
> +XCH             1001 001 rd:5 0100
> +LAC             1001 001 rd:5 0110
> +LAS             1001 001 rd:5 0101
> +LAT             1001 001 rd:5 0111
> +
> +#
> +# Bit and Bit-test Instructions
> +#
> +LSR             1001 010 rd:5 0110
> +ROR             1001 010 rd:5 0111
> +ASR             1001 010 rd:5 0101
> +SWAP            1001 010 rd:5 0010
> +SBI             1001 1010 reg:5 bit:3
> +CBI             1001 1000 reg:5 bit:3
> +BST             1111 101 rd:5 0 bit:3
> +BLD             1111 100 rd:5 0 bit:3
> +BSET            1001 0100 0 bit:3 1000
> +BCLR            1001 0100 1 bit:3 1000
> +
> +#
> +# MCU Control Instructions
> +#
> +BREAK           1001 0101 1001 1000
> +NOP             0000 0000 0000 0000
> +SLEEP           1001 0101 1000 1000
> +WDR             1001 0101 1010 1000
> +
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000bda4ad059a34f4c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBXZWRuZXNkYXksIERlY2VtYmVyIDE4LCAyMDE5LCBNaWNoYWVsIFJvbG5payAm
bHQ7PGEgaHJlZj0ibWFpbHRvOm1yb2xuaWtAZ21haWwuY29tIj5tcm9sbmlrQGdtYWlsLmNvbTwv
YT4mZ3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6
MWV4Ij5UaGlzIGluY2x1ZGVzOjxicj4NCi0gZW5jb2Rpbmcgb2YgYWxsIDE2IGJpdCBpbnN0cnVj
dGlvbnM8YnI+DQotIGVuY29kaW5nIG9mIGFsbCAzMiBiaXQgaW5zdHJ1Y3Rpb25zPGJyPg0KPGJy
Pg0KU2lnbmVkLW9mZi1ieTogTWljaGFlbCBSb2xuaWsgJmx0OzxhIGhyZWY9Im1haWx0bzptcm9s
bmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+Jmd0Ozxicj4NClRlc3RlZC1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgJmx0OzxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0
LmNvbSI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0Ozxicj4NCi0tLTwvYmxvY2txdW90ZT48ZGl2
Pjxicj48L2Rpdj48ZGl2Pk1pY2hhZWwsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFtIHZl
cnkgcGxlYXNlZCB0aGF0IHlvdSByZWFycmFuZ2VkIHRoZSBvcmRlciB0byBiZSBpbiBzeW5jIHdp
dGggdGhlIGRvY3VtZW50YXRpb24uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ob3csIGZvciB0
aGUgbmV4dCB2ZXJzaW9uLCBJIHdvdWxkIGFzayB5b3UgdG8gbWFrZSB0aGlzIHBhdGNoIGRpc2Fw
cGVhci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk1vcmUgcHJlY2lzZWx5LCAmcXVvdDtNQ1Ug
Q29udHJvbCBJbnN0cnVjdGlvbnMmcXVvdDsgc2VjdGlvbiBvZsKgaW5zbi5kZWNvZGUgZmlsZSBt
b3ZlIHRvIGJlIGEgcGFydCBvZiAmcXVvdDtBZGQgTUNVIENvbnRyb2wgSW5zdHJ1Y3Rpb25zJnF1
b3Q7IChub3Qgc3VyZSBhYml1dCB0aGUgdGl0bGUsIGJ1dCBpdCBpcyA2IG9yIDcgcGF0Y2hlcyBh
ZnRlciB0aGlzIG9uZSkgwqBwYXRjaCwgYW5kIHNvIG9uLCBpbiB0aGUgc2FtZSBmYXNoaW9uLCBm
b3IgYWxsIGdyb3VwcyBvZiBpbnN0cnVjdGlvbnMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5L
aW5kIHJlZ2FyZHMsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbGVrc2FuZGFyPC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgY2xh
c3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4
ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+DQrCoHRhcmdldC9hdnIvaW5zbi5kZWNvZGUg
fCAxODMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPHdicj4rKysrKysrKysrKzxicj4N
CsKgMSBmaWxlIGNoYW5nZWQsIDE4MyBpbnNlcnRpb25zKCspPGJyPg0KwqBjcmVhdGUgbW9kZSAx
MDA2NDQgdGFyZ2V0L2F2ci9pbnNuLmRlY29kZTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS90YXJn
ZXQvYXZyL2luc24uZGVjb2RlIGIvdGFyZ2V0L2F2ci9pbnNuLmRlY29kZTxicj4NCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0PGJyPg0KaW5kZXggMDAwMDAwMDAwMC4uMGU0ZWM5ZGRmMDxicj4NCi0tLSAv
ZGV2L251bGw8YnI+DQorKysgYi90YXJnZXQvYXZyL2luc24uZGVjb2RlPGJyPg0KQEAgLTAsMCAr
MSwxODMgQEA8YnI+DQorIzxicj4NCisjIEFWUiBpbnN0cnVjdGlvbiBkZWNvZGUgZGVmaW5pdGlv
bnMuPGJyPg0KKyM8YnI+DQorIyBDb3B5cmlnaHQgKGMpIDIwMTkgTWljaGFlbCBSb2xuaWsgJmx0
OzxhIGhyZWY9Im1haWx0bzptcm9sbmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+
Jmd0Ozxicj4NCisjPGJyPg0KKyMgVGhpcyBsaWJyYXJ5IGlzIGZyZWUgc29mdHdhcmU7IHlvdSBj
YW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcjxicj4NCisjIG1vZGlmeSBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBMZXNzZXIgR2VuZXJhbCBQdWJsaWM8YnI+DQorIyBMaWNlbnNlIGFzIHB1
Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXI8YnI+DQorIyB2
ZXJzaW9uIDIuMSBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIg
dmVyc2lvbi48YnI+DQorIzxicj4NCisjIFRoaXMgbGlicmFyeSBpcyBkaXN0cmlidXRlZCBpbiB0
aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLDxicj4NCisjIGJ1dCBXSVRIT1VUIEFOWSBX
QVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mPGJyPg0KKyMgTUVS
Q0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLsKgIFNlZSB0
aGUgR05VPGJyPg0KKyMgTGVzc2VyIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy48YnI+DQorIzxicj4NCisjIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2Yg
dGhlIEdOVSBMZXNzZXIgR2VuZXJhbCBQdWJsaWM8YnI+DQorIyBMaWNlbnNlIGFsb25nIHdpdGgg
dGhpcyBsaWJyYXJ5OyBpZiBub3QsIHNlZSAmbHQ7PGEgaHJlZj0iaHR0cDovL3d3dy5nbnUub3Jn
L2xpY2Vuc2VzLyIgdGFyZ2V0PSJfYmxhbmsiPmh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy88
L2E+Jmd0Ozx3YnI+Ljxicj4NCisjPGJyPg0KKzxicj4NCisjPGJyPg0KKyPCoCDCoHJlZ3NfMTZf
MzFfYnlfb25lID0gWzE2IC4uIDMxXTxicj4NCisjwqAgwqByZWdzXzE2XzIzX2J5X29uZSA9IFsx
NiAuLiAyM108YnI+DQorI8KgIMKgcmVnc18yNF8zMF9ieV90d28gPSBbMjQsIDI2LCAyOCwgMzBd
PGJyPg0KKyPCoCDCoHJlZ3NfMDBfMzBfYnlfdHdvID0gWzAsIDIsIDQsIDYsIDgsIC4uIDMwXTxi
cj4NCis8YnI+DQorJXJkwqAgwqAgwqAgwqAgwqAgwqAgwqA0OjU8YnI+DQorJXJywqAgwqAgwqAg
wqAgwqAgwqAgwqA5OjEgMDo0PGJyPg0KKzxicj4NCislcmRfYcKgIMKgIMKgIMKgIMKgIMKgNDo0
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAhZnVuY3Rpb249dG9fcmVnc18x
Nl8zMV9ieV9vbmU8YnI+DQorJXJkX2LCoCDCoCDCoCDCoCDCoCDCoDQ6M8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIWZ1bmN0aW9uPXRvX3JlZ3NfMTZfMjNfYnlfb25lPGJy
Pg0KKyVyZF9jwqAgwqAgwqAgwqAgwqAgwqA0OjLCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCFmdW5jdGlvbj10b19yZWdzXzI0XzMwX2J5X3R3bzxicj4NCislcmRfZMKgIMKg
IMKgIMKgIMKgIMKgNDo0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAhZnVu
Y3Rpb249dG9fcmVnc18wMF8zMF9ieV90d288YnI+DQorJXJyX2HCoCDCoCDCoCDCoCDCoCDCoDA6
NMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIWZ1bmN0aW9uPXRvX3JlZ3Nf
MTZfMzFfYnlfb25lPGJyPg0KKyVycl9iwqAgwqAgwqAgwqAgwqAgwqAwOjPCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCFmdW5jdGlvbj10b19yZWdzXzE2XzIzX2J5X29uZTxi
cj4NCislcnJfZMKgIMKgIMKgIMKgIMKgIMKgMDo0wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAhZnVuY3Rpb249dG9fcmVnc18wMF8zMF9ieV90d288YnI+DQorPGJyPg0KKyVp
bW02wqAgwqAgwqAgwqAgwqAgwqA2OjIgMDo0PGJyPg0KKyVpbW04wqAgwqAgwqAgwqAgwqAgwqA4
OjQgMDo0PGJyPg0KKzxicj4NCislaW9faW1twqAgwqAgwqAgwqAgwqA5OjIgMDo0PGJyPg0KKyVs
ZHN0X2RfaW1twqAgwqAgwqAxMzoxIDEwOjIgMDozPGJyPg0KKzxicj4NCisjIFRoZSAyMi1iaXQg
aW1tZWRpYXRlIGlzIHBhcnRpYWxseSBpbiB0aGUgb3Bjb2RlIHdvcmQsPGJyPg0KKyMgYW5kIHBh
cnRpYWxseSBpbiB0aGUgbmV4dC7CoCBVc2UgYXBwZW5kXzE2IHRvIGJ1aWxkIHRoZTxicj4NCisj
IGNvbXBsZXRlIDIyLWJpdCB2YWx1ZS48YnI+DQorJWltbV9jYWxswqAgwqAgwqAgwqA0OjUgMDox
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAhZnVuY3Rpb249YXBwZW5kXzE2PGJyPg0K
Kzxicj4NCis8YnI+DQorJmFtcDtyZF9ycsKgIMKgIMKgIMKgIMKgIHJkIHJyPGJyPg0KKyZhbXA7
cmRfaW1twqAgwqAgwqAgwqAgwqByZCBpbW08YnI+DQorPGJyPg0KK0BvcF9yZF9ycsKgIMKgIMKg
IMKgLi4uLiAuLiAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCAmYW1wO3JkX3JywqAgwqAgwqAgcmQ9
JXJkIHJyPSVycjxicj4NCitAb3BfcmRfaW1tNsKgIMKgIMKgLi4uLiAuLi4uIC4uIC4uIC4uLi7C
oCDCoCDCoCDCoCAmYW1wO3JkX2ltbcKgIMKgIMKgcmQ9JXJkX2MgaW1tPSVpbW02PGJyPg0KK0Bv
cF9yZF9pbW04wqAgwqAgwqAuLi4uIC4uLi4gLi4uLiAuLi4uwqAgwqAgwqAgwqAgwqAmYW1wO3Jk
X2ltbcKgIMKgIMKgcmQ9JXJkX2EgaW1tPSVpbW04PGJyPg0KK0BvcF9iaXTCoCDCoCDCoCDCoCDC
oC4uLi4gLi4uLiAuIGJpdDozIC4uLi48YnI+DQorQG9wX2JpdF9pbW3CoCDCoCDCoC4uLi4gLi4g
aW1tOnM3IGJpdDozPGJyPg0KK0BmbXVswqAgwqAgwqAgwqAgwqAgwqAuLi4uIC4uLi4gLiAuLi4g
LiAuLi7CoCDCoCDCoCDCoCZhbXA7cmRfcnLCoCDCoCDCoCByZD0lcmRfYiBycj0lcnJfYjxicj4N
CitAaW9fcmRfaW1twqAgwqAgwqAgLi4uLiAuIC4uIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCAmYW1w
O3JkX2ltbcKgIMKgIMKgcmQ9JXJkIGltbT0laW9faW1tPGJyPg0KK0BsZHN0X2TCoCDCoCDCoCDC
oCDCoC4uIC4gLiAuLiAuIHJkOjXCoCAuIC4uLsKgIMKgIMKgJmFtcDtyZF9pbW3CoCDCoCDCoGlt
bT0lbGRzdF9kX2ltbTxicj4NCis8YnI+DQorIyBUaGUgMTYtYml0IGltbWVkaWF0ZSBpcyBjb21w
bGV0ZWx5IGluIHRoZSBuZXh0IHdvcmQuPGJyPg0KKyMgRmllbGRzIGNhbm5vdCBiZSBkZWZpbmVk
IHdpdGggbm8gYml0cywgc28gd2UgY2Fubm90IHBsYXk8YnI+DQorIyB0aGUgc2FtZSB0cmljayBh
bmQgYXBwZW5kIHRvIGEgemVyby1iaXQgdmFsdWUuPGJyPg0KKyMgRGVmZXIgcmVhZGluZyB0aGUg
aW1tZWRpYXRlIHVudGlsIHRyYW5zX3tMRFMsU1RTfS48YnI+DQorQGxkc3Rfc8KgIMKgIMKgIMKg
IMKgLi4uLiAuLi4gcmQ6NSAuLi4uwqAgwqAgwqAgwqAgwqAgaW1tPTA8YnI+DQorPGJyPg0KKyM8
YnI+DQorIyBBcml0aG1ldGljIEluc3RydWN0aW9uczxicj4NCisjPGJyPg0KK0FERMKgIMKgIMKg
IMKgIMKgIMKgIMKgMDAwMCAxMSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+
DQorQURDwqAgwqAgwqAgwqAgwqAgwqAgwqAwMDAxIDExIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKg
IEBvcF9yZF9ycjxicj4NCitBRElXwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTEwIC4uIC4uIC4u
Li7CoCDCoCDCoCDCoCBAb3BfcmRfaW1tNjxicj4NCitTVULCoCDCoCDCoCDCoCDCoCDCoCDCoDAw
MDEgMTAgLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK1NVQknCoCDCoCDC
oCDCoCDCoCDCoCAwMTAxIC4uLi4gLi4uLiAuLi4uwqAgwqAgwqAgwqAgwqBAb3BfcmRfaW1tODxi
cj4NCitTQkPCoCDCoCDCoCDCoCDCoCDCoCDCoDAwMDAgMTAgLiAuLi4uLiAuLi4uwqAgwqAgwqAg
wqAgQG9wX3JkX3JyPGJyPg0KK1NCQ0nCoCDCoCDCoCDCoCDCoCDCoCAwMTAwIC4uLi4gLi4uLiAu
Li4uwqAgwqAgwqAgwqAgwqBAb3BfcmRfaW1tODxicj4NCitTQklXwqAgwqAgwqAgwqAgwqAgwqAg
MTAwMSAwMTExIC4uIC4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfaW1tNjxicj4NCitBTkTCoCDC
oCDCoCDCoCDCoCDCoCDCoDAwMTAgMDAgLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3Jy
PGJyPg0KK0FOREnCoCDCoCDCoCDCoCDCoCDCoCAwMTExIC4uLi4gLi4uLiAuLi4uwqAgwqAgwqAg
wqAgwqBAb3BfcmRfaW1tODxicj4NCitPUsKgIMKgIMKgIMKgIMKgIMKgIMKgIDAwMTAgMTAgLiAu
Li4uLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK09SScKgIMKgIMKgIMKgIMKgIMKg
IMKgMDExMCAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgQG9wX3JkX2ltbTg8YnI+DQorRU9S
wqAgwqAgwqAgwqAgwqAgwqAgwqAwMDEwIDAxIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBvcF9y
ZF9ycjxicj4NCitDT03CoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIHJkOjUgMDAwMDxicj4N
CitORUfCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIHJkOjUgMDAwMTxicj4NCitJTkPCoCDC
oCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIHJkOjUgMDAxMTxicj4NCitERUPCoCDCoCDCoCDCoCDC
oCDCoCDCoDEwMDEgMDEwIHJkOjUgMTAxMDxicj4NCitNVUzCoCDCoCDCoCDCoCDCoCDCoCDCoDEw
MDEgMTEgLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK01VTFPCoCDCoCDC
oCDCoCDCoCDCoCAwMDAwIDAwMTAgLi4uLiAuLi4uwqAgwqAgwqAgwqAgwqAmYW1wO3JkX3JywqAg
wqAgwqAgcmQ9JXJkX2EgcnI9JXJyX2E8YnI+DQorTVVMU1XCoCDCoCDCoCDCoCDCoCDCoDAwMDAg
MDAxMSAwIC4uLiAwIC4uLsKgIMKgIMKgIMKgQGZtdWw8YnI+DQorRk1VTMKgIMKgIMKgIMKgIMKg
IMKgIDAwMDAgMDAxMSAwIC4uLiAxIC4uLsKgIMKgIMKgIMKgQGZtdWw8YnI+DQorRk1VTFPCoCDC
oCDCoCDCoCDCoCDCoDAwMDAgMDAxMSAxIC4uLiAwIC4uLsKgIMKgIMKgIMKgQGZtdWw8YnI+DQor
Rk1VTFNVwqAgwqAgwqAgwqAgwqAgMDAwMCAwMDExIDEgLi4uIDEgLi4uwqAgwqAgwqAgwqBAZm11
bDxicj4NCitERVPCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMCBpbW06NCAxMDExPGJyPg0K
Kzxicj4NCisjPGJyPg0KKyMgQnJhbmNoIEluc3RydWN0aW9uczxicj4NCisjPGJyPg0KK1JKTVDC
oCDCoCDCoCDCoCDCoCDCoCAxMTAwIGltbTpzMTI8YnI+DQorSUpNUMKgIMKgIMKgIMKgIMKgIMKg
IDEwMDEgMDEwMCAwMDAwIDEwMDE8YnI+DQorRUlKTVDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEw
MCAwMDAxIDEwMDE8YnI+DQorSk1QwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCAuLi4uLiAx
MTAgLsKgIMKgIMKgIMKgIGltbT0laW1tX2NhbGw8YnI+DQorUkNBTEzCoCDCoCDCoCDCoCDCoCDC
oDExMDEgaW1tOnMxMjxicj4NCitJQ0FMTMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAxIDAwMDAg
MTAwMTxicj4NCitFSUNBTEzCoCDCoCDCoCDCoCDCoCAxMDAxIDAxMDEgMDAwMSAxMDAxPGJyPg0K
K0NBTEzCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAxMCAuLi4uLiAxMTEgLsKgIMKgIMKgIMKgIGlt
bT0laW1tX2NhbGw8YnI+DQorUkVUwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMDEgMDAwMCAx
MDAwPGJyPg0KK1JFVEnCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAxMDEgMDAwMSAxMDAwPGJyPg0K
K0NQU0XCoCDCoCDCoCDCoCDCoCDCoCAwMDAxIDAwIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBv
cF9yZF9ycjxicj4NCitDUMKgIMKgIMKgIMKgIMKgIMKgIMKgIDAwMDEgMDEgLiAuLi4uLiAuLi4u
wqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK0NQQ8KgIMKgIMKgIMKgIMKgIMKgIMKgMDAwMCAw
MSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+DQorQ1BJwqAgwqAgwqAgwqAg
wqAgwqAgwqAwMDExIC4uLi4gLi4uLiAuLi4uwqAgwqAgwqAgwqAgwqBAb3BfcmRfaW1tODxicj4N
CitTQlJDwqAgwqAgwqAgwqAgwqAgwqAgMTExMSAxMTAgcnI6NSAwIGJpdDozPGJyPg0KK1NCUlPC
oCDCoCDCoCDCoCDCoCDCoCAxMTExIDExMSBycjo1IDAgYml0OjM8YnI+DQorU0JJQ8KgIMKgIMKg
IMKgIMKgIMKgIDEwMDEgMTAwMSByZWc6NSBiaXQ6Mzxicj4NCitTQklTwqAgwqAgwqAgwqAgwqAg
wqAgMTAwMSAxMDExIHJlZzo1IGJpdDozPGJyPg0KK0JSQlPCoCDCoCDCoCDCoCDCoCDCoCAxMTEx
IDAwIC4uLi4uLi4gLi4uwqAgwqAgwqAgwqAgwqBAb3BfYml0X2ltbTxicj4NCitCUkJDwqAgwqAg
wqAgwqAgwqAgwqAgMTExMSAwMSAuLi4uLi4uIC4uLsKgIMKgIMKgIMKgIMKgQG9wX2JpdF9pbW08
YnI+DQorPGJyPg0KKyM8YnI+DQorIyBEYXRhIFRyYW5zZmVyIEluc3RydWN0aW9uczxicj4NCisj
PGJyPg0KK01PVsKgIMKgIMKgIMKgIMKgIMKgIMKgMDAxMCAxMSAuIC4uLi4uIC4uLi7CoCDCoCDC
oCDCoCBAb3BfcmRfcnI8YnI+DQorTU9WV8KgIMKgIMKgIMKgIMKgIMKgIDAwMDAgMDAwMSAuLi4u
IC4uLi7CoCDCoCDCoCDCoCDCoCZhbXA7cmRfcnLCoCDCoCDCoCByZD0lcmRfZCBycj0lcnJfZDxi
cj4NCitMREnCoCDCoCDCoCDCoCDCoCDCoCDCoDExMTAgLi4uLiAuLi4uIC4uLi7CoCDCoCDCoCDC
oCDCoEBvcF9yZF9pbW04PGJyPg0KK0xEU8KgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDAgLi4u
Li4gMDAwMMKgIMKgIMKgIMKgIMKgQGxkc3Rfczxicj4NCitMRFgxwqAgwqAgwqAgwqAgwqAgwqAg
MTAwMSAwMDAgcmQ6NSAxMTAwPGJyPg0KK0xEWDLCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMCBy
ZDo1IDExMDE8YnI+DQorTERYM8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAwIHJkOjUgMTExMDxi
cj4NCitMRFkywqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDAgcmQ6NSAxMDAxPGJyPg0KK0xEWTPC
oCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMCByZDo1IDEwMTA8YnI+DQorTERaMsKgIMKgIMKgIMKg
IMKgIMKgIDEwMDEgMDAwIHJkOjUgMDAwMTxicj4NCitMRFozwqAgwqAgwqAgwqAgwqAgwqAgMTAw
MSAwMDAgcmQ6NSAwMDEwPGJyPg0KK0xERFnCoCDCoCDCoCDCoCDCoCDCoCAxMCAuIDAgLi4gMCAu
Li4uLiAxIC4uLsKgIMKgIMKgQGxkc3RfZDxicj4NCitMRERawqAgwqAgwqAgwqAgwqAgwqAgMTAg
LiAwIC4uIDAgLi4uLi4gMCAuLi7CoCDCoCDCoEBsZHN0X2Q8YnI+DQorU1RTwqAgwqAgwqAgwqAg
wqAgwqAgwqAxMDAxIDAwMSAuLi4uLiAwMDAwwqAgwqAgwqAgwqAgwqBAbGRzdF9zPGJyPg0KK1NU
WDHCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMSBycjo1IDExMDA8YnI+DQorU1RYMsKgIMKgIMKg
IMKgIMKgIMKgIDEwMDEgMDAxIHJyOjUgMTEwMTxicj4NCitTVFgzwqAgwqAgwqAgwqAgwqAgwqAg
MTAwMSAwMDEgcnI6NSAxMTEwPGJyPg0KK1NUWTLCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMSBy
ZDo1IDEwMDE8YnI+DQorU1RZM8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAxIHJkOjUgMTAxMDxi
cj4NCitTVFoywqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDEgcmQ6NSAwMDAxPGJyPg0KK1NUWjPC
oCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMSByZDo1IDAwMTA8YnI+DQorU1REWcKgIMKgIMKgIMKg
IMKgIMKgIDEwIC4gMCAuLiAxIC4uLi4uIDEgLi4uwqAgwqAgwqBAbGRzdF9kPGJyPg0KK1NURFrC
oCDCoCDCoCDCoCDCoCDCoCAxMCAuIDAgLi4gMSAuLi4uLiAwIC4uLsKgIMKgIMKgQGxkc3RfZDxi
cj4NCitMUE0xwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAxIDExMDAgMTAwMDxicj4NCitMUE0y
wqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDAgcmQ6NSAwMTAwPGJyPg0KK0xQTVjCoCDCoCDCoCDC
oCDCoCDCoCAxMDAxIDAwMCByZDo1IDAxMDE8YnI+DQorRUxQTTHCoCDCoCDCoCDCoCDCoCDCoDEw
MDEgMDEwMSAxMTAxIDEwMDA8YnI+DQorRUxQTTLCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDAwIHJk
OjUgMDExMDxicj4NCitFTFBNWMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDAgcmQ6NSAwMTExPGJy
Pg0KK1NQTcKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAxIDExMTAgMTAwMDxicj4NCitTUE1Y
wqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAxIDExMTEgMTAwMDxicj4NCitJTsKgIMKgIMKgIMKg
IMKgIMKgIMKgIDEwMTEgMCAuLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQGlvX3JkX2ltbTxicj4N
CitPVVTCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMTEgMSAuLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAg
QGlvX3JkX2ltbTxicj4NCitQVVNIwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDEgcmQ6NSAxMTEx
PGJyPg0KK1BPUMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDAgcmQ6NSAxMTExPGJyPg0KK1hD
SMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDEgcmQ6NSAwMTAwPGJyPg0KK0xBQ8KgIMKgIMKg
IMKgIMKgIMKgIMKgMTAwMSAwMDEgcmQ6NSAwMTEwPGJyPg0KK0xBU8KgIMKgIMKgIMKgIMKgIMKg
IMKgMTAwMSAwMDEgcmQ6NSAwMTAxPGJyPg0KK0xBVMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAw
MDEgcmQ6NSAwMTExPGJyPg0KKzxicj4NCisjPGJyPg0KKyMgQml0IGFuZCBCaXQtdGVzdCBJbnN0
cnVjdGlvbnM8YnI+DQorIzxicj4NCitMU1LCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIHJk
OjUgMDExMDxicj4NCitST1LCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIHJkOjUgMDExMTxi
cj4NCitBU1LCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIHJkOjUgMDEwMTxicj4NCitTV0FQ
wqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAgcmQ6NSAwMDEwPGJyPg0KK1NCScKgIMKgIMKgIMKg
IMKgIMKgIMKgMTAwMSAxMDEwIHJlZzo1IGJpdDozPGJyPg0KK0NCScKgIMKgIMKgIMKgIMKgIMKg
IMKgMTAwMSAxMDAwIHJlZzo1IGJpdDozPGJyPg0KK0JTVMKgIMKgIMKgIMKgIMKgIMKgIMKgMTEx
MSAxMDEgcmQ6NSAwIGJpdDozPGJyPg0KK0JMRMKgIMKgIMKgIMKgIMKgIMKgIMKgMTExMSAxMDAg
cmQ6NSAwIGJpdDozPGJyPg0KK0JTRVTCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAxMDAgMCBiaXQ6
MyAxMDAwPGJyPg0KK0JDTFLCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAxMDAgMSBiaXQ6MyAxMDAw
PGJyPg0KKzxicj4NCisjPGJyPg0KKyMgTUNVIENvbnRyb2wgSW5zdHJ1Y3Rpb25zPGJyPg0KKyM8
YnI+DQorQlJFQUvCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMSAxMDAxIDEwMDA8YnI+DQorTk9Q
wqAgwqAgwqAgwqAgwqAgwqAgwqAwMDAwIDAwMDAgMDAwMCAwMDAwPGJyPg0KK1NMRUVQwqAgwqAg
wqAgwqAgwqAgwqAxMDAxIDAxMDEgMTAwMCAxMDAwPGJyPg0KK1dEUsKgIMKgIMKgIMKgIMKgIMKg
IMKgMTAwMSAwMTAxIDEwMTAgMTAwMDxicj4NCis8YnI+DQotLSA8YnI+DQoyLjE3LjIgKEFwcGxl
IEdpdC0xMTMpPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPg0K
--000000000000bda4ad059a34f4c9--

