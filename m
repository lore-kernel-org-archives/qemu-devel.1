Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965D8C432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 15:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D8C20748
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 15:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCcq27s8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D8C20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYtj9-0002jW-CB
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 10:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYtiI-0002JR-BD
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 10:22:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYtiG-0002VP-Cn
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 10:22:14 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:36015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYtiG-0002T5-5X
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 10:22:12 -0500
Received: by mail-ot1-x344.google.com with SMTP id f10so10411076oto.3
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2019 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AQCJr9BO0Foc/q8+ti8uDH5tRnRKyusa3SX2C1GkvJ4=;
 b=QCcq27s8axQAiu/qJ1yf/+g9OsYPE5Xn7WoOGWh/bf9E34RWpHSZhJmKCoiU9r9ijV
 cmEDOmzeUKyzIdFErOzLnphZJt0VCvhxaWs5GTecwBT0u/W0/Ul66ReuX46IVb4CUSBz
 heR1RsUjn85QJXY2403BvKTDZ0pSCwgMdwbRZSXIwt5vbb735xR6gXtsqGenGofAOKLM
 hPMhzH8WuVIBaSBtrOJf8rqIrV2PmpHzpGfSlWaOpXW5NStQ4jF8hG3rV5t7mTsrdqpK
 PQF3zU2MlXJfoU0i9tivOpBYt2MM3vgPZ1g+JTv9EM1UP8i0rXbA8Jua6qFkw5hb4VaY
 xhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AQCJr9BO0Foc/q8+ti8uDH5tRnRKyusa3SX2C1GkvJ4=;
 b=bAU3nNWVhqkcVcSAHOQsAFiNZYmxK3wG+WXR5gYW2mFHDdUl9WeYj2Zz7hbCfgp6zN
 /ZQ0K4MDGLCnby2M3Etg82Q4CNXjTXawkPS21nA4HJmM+He/9rgqptlhX4CBgktjEqka
 B9TEdy+BURVXbOnKt53ANDxuBIFG7obExku1bpq9Kpmao3puQHKV9I7h06+xghVRTrqZ
 JqXYxwm4O9WYK20VkmMq1KKg2RUbOkz/yyOFGj2oEWLvcisgeqVHc5sT2bBsTJHF0myN
 IaFVvOmCbWFfza8xggVEFLoL1GKczui1A9m9CAVeWbFk1vjPCBvuq//uhTMwbSK4eG2e
 fvug==
X-Gm-Message-State: APjAAAVkGJASeuvVvQbqBApp7xdgc48DdPzVnFB2bJNjveR+44nenTOG
 qmik/op6H8dpREDbOrppbH52e/I/YIjNJjw/DGs=
X-Google-Smtp-Source: APXvYqwb+/9kJhysZQS6mani+Y9UR7o31vO7DdDDhq4DdWVHyeGVTKNv+/hvMmvxY5BenrWI/fPfgisDzHlleFt9bx8=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr16426865otc.121.1574608931093; 
 Sun, 24 Nov 2019 07:22:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Sun, 24 Nov 2019 07:22:10
 -0800 (PST)
In-Reply-To: <20191124050225.30351-4-mrolnik@gmail.com>
References: <20191124050225.30351-1-mrolnik@gmail.com>
 <20191124050225.30351-4-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 24 Nov 2019 16:22:10 +0100
Message-ID: <CAL1e-=gco88L85c=SAfDu_BaEQp_6nJn_6HXXtLM+ebyF_dEQw@mail.gmail.com>
Subject: Re: [PATCH v36 03/17] target/avr: Add instruction decoding
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000ff82f40598193567"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ff82f40598193567
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sunday, November 24, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> This includes:
> - encoding of all 16 bit instructions
> - encoding of all 32 bit instructions
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---


License preamble missing.



>  target/avr/insn.decode | 175 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 target/avr/insn.decode
>
> diff --git a/target/avr/insn.decode b/target/avr/insn.decode
> new file mode 100644
> index 0000000000..6b387762c6
> --- /dev/null
> +++ b/target/avr/insn.decode
> @@ -0,0 +1,175 @@
> +#
> +#   A =3D [16 .. 31]
> +#   B =3D [16 .. 23]
> +#   C =3D [24, 26, 28, 30]
> +#   D =3D [0, 2, 4, 6, 8, .. 30]
> +
> +%rd             4:5
> +%rr             9:1 0:4
> +
> +&rd_rr          rd rr
> +&rd_imm         rd imm
> +
> +@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=3D%rd rr=3D%r=
r
> +ADD             0000 11 . ..... ....        @op_rd_rr
> +ADC             0001 11 . ..... ....        @op_rd_rr
> +AND             0010 00 . ..... ....        @op_rd_rr
> +CP              0001 01 . ..... ....        @op_rd_rr
> +CPC             0000 01 . ..... ....        @op_rd_rr
> +CPSE            0001 00 . ..... ....        @op_rd_rr
> +EOR             0010 01 . ..... ....        @op_rd_rr
> +MOV             0010 11 . ..... ....        @op_rd_rr
> +MUL             1001 11 . ..... ....        @op_rd_rr
> +OR              0010 10 . ..... ....        @op_rd_rr
> +SBC             0000 10 . ..... ....        @op_rd_rr
> +SUB             0001 10 . ..... ....        @op_rd_rr
> +
> +
> +%rd_c           4:2                         !function=3Dto_C
> +%imm6           6:2 0:4
> +
> +@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=3D%rd_c imm=
=3D%imm6
> +ADIW            1001 0110 .. .. ....        @op_rd_imm6
> +SBIW            1001 0111 .. .. ....        @op_rd_imm6
> +
> +
> +%rd_a           4:4                         !function=3Dto_A
> +%rr_a           0:4                         !function=3Dto_A
> +%rd_d           4:4                         !function=3Dto_D
> +%rr_d           0:4                         !function=3Dto_D
> +%imm8           8:4 0:4
> +
> +@op_rd_imm8     .... .... .... ....         &rd_imm     rd=3D%rd_a imm=
=3D%imm8
> +ANDI            0111 .... .... ....         @op_rd_imm8
> +CPI             0011 .... .... ....         @op_rd_imm8
> +LDI             1110 .... .... ....         @op_rd_imm8
> +ORI             0110 .... .... ....         @op_rd_imm8
> +SBCI            0100 .... .... ....         @op_rd_imm8
> +SUBI            0101 .... .... ....         @op_rd_imm8
> +
> +
> +@op_rd          .... ... rd:5 ....
> +ASR             1001 010 ..... 0101         @op_rd
> +COM             1001 010 ..... 0000         @op_rd
> +DEC             1001 010 ..... 1010         @op_rd
> +ELPM2           1001 000 ..... 0110         @op_rd
> +ELPMX           1001 000 ..... 0111         @op_rd
> +INC             1001 010 ..... 0011         @op_rd
> +LDX1            1001 000 ..... 1100         @op_rd
> +LDX2            1001 000 ..... 1101         @op_rd
> +LDX3            1001 000 ..... 1110         @op_rd
> +LDY2            1001 000 ..... 1001         @op_rd
> +LDY3            1001 000 ..... 1010         @op_rd
> +LDZ2            1001 000 ..... 0001         @op_rd
> +LDZ3            1001 000 ..... 0010         @op_rd
> +LPM2            1001 000 ..... 0100         @op_rd
> +LPMX            1001 000 ..... 0101         @op_rd
> +LSR             1001 010 ..... 0110         @op_rd
> +NEG             1001 010 ..... 0001         @op_rd
> +POP             1001 000 ..... 1111         @op_rd
> +PUSH            1001 001 ..... 1111         @op_rd
> +ROR             1001 010 ..... 0111         @op_rd
> +STY2            1001 001 ..... 1001         @op_rd
> +STY3            1001 001 ..... 1010         @op_rd
> +STZ2            1001 001 ..... 0001         @op_rd
> +STZ3            1001 001 ..... 0010         @op_rd
> +SWAP            1001 010 ..... 0010         @op_rd
> +
> +
> +@op_bit         .... .... . bit:3 ....
> +BCLR            1001 0100 1 ... 1000        @op_bit
> +BSET            1001 0100 0 ... 1000        @op_bit
> +
> +
> +@op_rd_bit      .... ... rd:5 . bit:3
> +BLD             1111 100 ..... 0 ...        @op_rd_bit
> +BST             1111 101 ..... 0 ...        @op_rd_bit
> +
> +
> +@op_bit_imm     .... .. imm:s7 bit:3
> +BRBC            1111 01 ....... ...         @op_bit_imm
> +BRBS            1111 00 ....... ...         @op_bit_imm
> +
> +
> +BREAK           1001 0101 1001 1000
> +EICALL          1001 0101 0001 1001
> +EIJMP           1001 0100 0001 1001
> +ELPM1           1001 0101 1101 1000
> +ICALL           1001 0101 0000 1001
> +IJMP            1001 0100 0000 1001
> +LPM1            1001 0101 1100 1000
> +NOP             0000 0000 0000 0000
> +RET             1001 0101 0000 1000
> +RETI            1001 0101 0001 1000
> +SLEEP           1001 0101 1000 1000
> +SPM             1001 0101 1110 1000
> +SPMX            1001 0101 1111 1000
> +WDR             1001 0101 1010 1000
> +
> +
> +@op_reg_bit     .... .... reg:5 bit:3
> +CBI             1001 1000 ..... ...         @op_reg_bit
> +SBI             1001 1010 ..... ...         @op_reg_bit
> +SBIC            1001 1001 ..... ...         @op_reg_bit
> +SBIS            1001 1011 ..... ...         @op_reg_bit
> +
> +
> +DES             1001 0100 imm:4 1011
> +
> +
> +%rd_b           4:3                         !function=3Dto_B
> +%rr_b           0:3                         !function=3Dto_B
> +@fmul           .... .... . ... . ...       &rd_rr      rd=3D%rd_b rr=3D=
%rr_b
> +FMUL            0000 0011 0 ... 1 ...       @fmul
> +FMULS           0000 0011 1 ... 0 ...       @fmul
> +FMULSU          0000 0011 1 ... 1 ...       @fmul
> +MULSU           0000 0011 0 ... 0 ...       @fmul
> +
> +
> +%io_imm         9:2 0:4
> +@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=3D%rd imm=3D%=
io_imm
> +IN              1011 0 .. ..... ....        @io_rd_imm
> +OUT             1011 1 .. ..... ....        @io_rd_imm
> +
> +
> +XCH             1001 001 rd:5 0100
> +LAC             1001 001 rd:5 0110
> +LAS             1001 001 rd:5 0101
> +LAT             1001 001 rd:5 0111
> +STX1            1001 001 rr:5 1100
> +STX2            1001 001 rr:5 1101
> +STX3            1001 001 rr:5 1110
> +
> +
> +%ldst_d_imm     13:1 10:2 0:3
> +@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=3D%ldst_d_im=
m
> +LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
> +LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
> +STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
> +STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
> +
> +
> +MOVW            0000 0001 .... ....         &rd_rr      rd=3D%rd_d rr=3D=
%rr_d
> +MULS            0000 0010 .... ....         &rd_rr      rd=3D%rd_a rr=3D=
%rr_a
> +
> +RCALL           1101 imm:s12
> +RJMP            1100 imm:s12
> +
> +SBRC            1111 110 rr:5 0 bit:3
> +SBRS            1111 111 rr:5 0 bit:3
> +
> +# The 22-bit immediate is partially in the opcode word,
> +# and partially in the next.  Use append_16 to build the
> +# complete 22-bit value.
> +%imm_call       4:5 0:1                     !function=3Dappend_16
> +CALL            1001 010 ..... 111 .        imm=3D%imm_call
> +JMP             1001 010 ..... 110 .        imm=3D%imm_call
> +
> +
> +# The 16-bit immediate is completely in the next word.
> +# Fields cannot be defined with no bits, so we cannot play
> +# the same trick and append to a zero-bit value.
> +# Defer reading the immediate until trans_{LDS,STS}.
> +@ldst_s         .... ... rd:5 ....          imm=3D0
> +LDS             1001 000 ..... 0000         @ldst_s
> +STS             1001 001 ..... 0000         @ldst_s
> --
> 2.17.2 (Apple Git-113)
>
>

--000000000000ff82f40598193567
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGJyPjxicj5PbiBTdW5kYXksIE5vdmVtYmVyIDI0LCAyMDE5LCBNaWNoYWVsIFJvbG5payAmbHQ7
PGEgaHJlZj0ibWFpbHRvOm1yb2xuaWtAZ21haWwuY29tIj5tcm9sbmlrQGdtYWlsLmNvbTwvYT4m
Z3Q7IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJn
aW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4
Ij5UaGlzIGluY2x1ZGVzOjxicj4NCi0gZW5jb2Rpbmcgb2YgYWxsIDE2IGJpdCBpbnN0cnVjdGlv
bnM8YnI+DQotIGVuY29kaW5nIG9mIGFsbCAzMiBiaXQgaW5zdHJ1Y3Rpb25zPGJyPg0KPGJyPg0K
U2lnbmVkLW9mZi1ieTogTWljaGFlbCBSb2xuaWsgJmx0OzxhIGhyZWY9Im1haWx0bzptcm9sbmlr
QGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+Jmd0Ozxicj4NClRlc3RlZC1ieTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgJmx0OzxhIGhyZWY9Im1haWx0bzpwaGlsbWRAcmVkaGF0LmNv
bSI+cGhpbG1kQHJlZGhhdC5jb208L2E+Jmd0Ozxicj4NCi0tLTwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PjxkaXY+TGljZW5zZSBwcmVhbWJsZSBtaXNzaW5nLjwvZGl2PjxkaXY+wqA8
L2Rpdj48L2Rpdj48ZGl2PsKgPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+DQrCoHRhcmdldC9hdnIvaW5zbi5kZWNvZGUgfCAxNzUgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrPHdicj4rKysrKysrKysrKzxicj4NCsKgMSBmaWxlIGNoYW5nZWQs
IDE3NSBpbnNlcnRpb25zKCspPGJyPg0KwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2F2ci9p
bnNuLmRlY29kZTxicj4NCjxicj4NCmRpZmYgLS1naXQgYS90YXJnZXQvYXZyL2luc24uZGVjb2Rl
IGIvdGFyZ2V0L2F2ci9pbnNuLmRlY29kZTxicj4NCm5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJyPg0K
aW5kZXggMDAwMDAwMDAwMC4uNmIzODc3NjJjNjxicj4NCi0tLSAvZGV2L251bGw8YnI+DQorKysg
Yi90YXJnZXQvYXZyL2luc24uZGVjb2RlPGJyPg0KQEAgLTAsMCArMSwxNzUgQEA8YnI+DQorIzxi
cj4NCisjwqAgwqBBID0gWzE2IC4uIDMxXTxicj4NCisjwqAgwqBCID0gWzE2IC4uIDIzXTxicj4N
CisjwqAgwqBDID0gWzI0LCAyNiwgMjgsIDMwXTxicj4NCisjwqAgwqBEID0gWzAsIDIsIDQsIDYs
IDgsIC4uIDMwXTxicj4NCis8YnI+DQorJXJkwqAgwqAgwqAgwqAgwqAgwqAgwqA0OjU8YnI+DQor
JXJywqAgwqAgwqAgwqAgwqAgwqAgwqA5OjEgMDo0PGJyPg0KKzxicj4NCismYW1wO3JkX3JywqAg
wqAgwqAgwqAgwqAgcmQgcnI8YnI+DQorJmFtcDtyZF9pbW3CoCDCoCDCoCDCoCDCoHJkIGltbTxi
cj4NCis8YnI+DQorQG9wX3JkX3JywqAgwqAgwqAgwqAuLi4uIC4uIC4gLi4uLi4gLi4uLsKgIMKg
IMKgIMKgICZhbXA7cmRfcnLCoCDCoCDCoCByZD0lcmQgcnI9JXJyPGJyPg0KK0FERMKgIMKgIMKg
IMKgIMKgIMKgIMKgMDAwMCAxMSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+
DQorQURDwqAgwqAgwqAgwqAgwqAgwqAgwqAwMDAxIDExIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKg
IEBvcF9yZF9ycjxicj4NCitBTkTCoCDCoCDCoCDCoCDCoCDCoCDCoDAwMTAgMDAgLiAuLi4uLiAu
Li4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK0NQwqAgwqAgwqAgwqAgwqAgwqAgwqAgMDAw
MSAwMSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+DQorQ1BDwqAgwqAgwqAg
wqAgwqAgwqAgwqAwMDAwIDAxIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBvcF9yZF9ycjxicj4N
CitDUFNFwqAgwqAgwqAgwqAgwqAgwqAgMDAwMSAwMCAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBA
b3BfcmRfcnI8YnI+DQorRU9SwqAgwqAgwqAgwqAgwqAgwqAgwqAwMDEwIDAxIC4gLi4uLi4gLi4u
LsKgIMKgIMKgIMKgIEBvcF9yZF9ycjxicj4NCitNT1bCoCDCoCDCoCDCoCDCoCDCoCDCoDAwMTAg
MTEgLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK01VTMKgIMKgIMKgIMKg
IMKgIMKgIMKgMTAwMSAxMSAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+DQor
T1LCoCDCoCDCoCDCoCDCoCDCoCDCoCAwMDEwIDEwIC4gLi4uLi4gLi4uLsKgIMKgIMKgIMKgIEBv
cF9yZF9ycjxicj4NCitTQkPCoCDCoCDCoCDCoCDCoCDCoCDCoDAwMDAgMTAgLiAuLi4uLiAuLi4u
wqAgwqAgwqAgwqAgQG9wX3JkX3JyPGJyPg0KK1NVQsKgIMKgIMKgIMKgIMKgIMKgIMKgMDAwMSAx
MCAuIC4uLi4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfcnI8YnI+DQorPGJyPg0KKzxicj4NCisl
cmRfY8KgIMKgIMKgIMKgIMKgIMKgNDoywqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAhZnVuY3Rpb249dG9fQzxicj4NCislaW1tNsKgIMKgIMKgIMKgIMKgIMKgNjoyIDA6NDxi
cj4NCis8YnI+DQorQG9wX3JkX2ltbTbCoCDCoCDCoC4uLi4gLi4uLiAuLiAuLiAuLi4uwqAgwqAg
wqAgwqAgJmFtcDtyZF9pbW3CoCDCoCDCoHJkPSVyZF9jIGltbT0laW1tNjxicj4NCitBRElXwqAg
wqAgwqAgwqAgwqAgwqAgMTAwMSAwMTEwIC4uIC4uIC4uLi7CoCDCoCDCoCDCoCBAb3BfcmRfaW1t
Njxicj4NCitTQklXwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTExIC4uIC4uIC4uLi7CoCDCoCDC
oCDCoCBAb3BfcmRfaW1tNjxicj4NCis8YnI+DQorPGJyPg0KKyVyZF9hwqAgwqAgwqAgwqAgwqAg
wqA0OjTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCFmdW5jdGlvbj10b19B
PGJyPg0KKyVycl9hwqAgwqAgwqAgwqAgwqAgwqAwOjTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCFmdW5jdGlvbj10b19BPGJyPg0KKyVyZF9kwqAgwqAgwqAgwqAgwqAgwqA0
OjTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCFmdW5jdGlvbj10b19EPGJy
Pg0KKyVycl9kwqAgwqAgwqAgwqAgwqAgwqAwOjTCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCFmdW5jdGlvbj10b19EPGJyPg0KKyVpbW04wqAgwqAgwqAgwqAgwqAgwqA4OjQg
MDo0PGJyPg0KKzxicj4NCitAb3BfcmRfaW1tOMKgIMKgIMKgLi4uLiAuLi4uIC4uLi4gLi4uLsKg
IMKgIMKgIMKgIMKgJmFtcDtyZF9pbW3CoCDCoCDCoHJkPSVyZF9hIGltbT0laW1tODxicj4NCitB
TkRJwqAgwqAgwqAgwqAgwqAgwqAgMDExMSAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgQG9w
X3JkX2ltbTg8YnI+DQorQ1BJwqAgwqAgwqAgwqAgwqAgwqAgwqAwMDExIC4uLi4gLi4uLiAuLi4u
wqAgwqAgwqAgwqAgwqBAb3BfcmRfaW1tODxicj4NCitMREnCoCDCoCDCoCDCoCDCoCDCoCDCoDEx
MTAgLi4uLiAuLi4uIC4uLi7CoCDCoCDCoCDCoCDCoEBvcF9yZF9pbW04PGJyPg0KK09SScKgIMKg
IMKgIMKgIMKgIMKgIMKgMDExMCAuLi4uIC4uLi4gLi4uLsKgIMKgIMKgIMKgIMKgQG9wX3JkX2lt
bTg8YnI+DQorU0JDScKgIMKgIMKgIMKgIMKgIMKgIDAxMDAgLi4uLiAuLi4uIC4uLi7CoCDCoCDC
oCDCoCDCoEBvcF9yZF9pbW04PGJyPg0KK1NVQknCoCDCoCDCoCDCoCDCoCDCoCAwMTAxIC4uLi4g
Li4uLiAuLi4uwqAgwqAgwqAgwqAgwqBAb3BfcmRfaW1tODxicj4NCis8YnI+DQorPGJyPg0KK0Bv
cF9yZMKgIMKgIMKgIMKgIMKgIC4uLi4gLi4uIHJkOjUgLi4uLjxicj4NCitBU1LCoCDCoCDCoCDC
oCDCoCDCoCDCoDEwMDEgMDEwIC4uLi4uIDAxMDHCoCDCoCDCoCDCoCDCoEBvcF9yZDxicj4NCitD
T03CoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIC4uLi4uIDAwMDDCoCDCoCDCoCDCoCDCoEBv
cF9yZDxicj4NCitERUPCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwIC4uLi4uIDEwMTDCoCDC
oCDCoCDCoCDCoEBvcF9yZDxicj4NCitFTFBNMsKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDAgLi4u
Li4gMDExMMKgIMKgIMKgIMKgIMKgQG9wX3JkPGJyPg0KK0VMUE1YwqAgwqAgwqAgwqAgwqAgwqAx
MDAxIDAwMCAuLi4uLiAwMTExwqAgwqAgwqAgwqAgwqBAb3BfcmQ8YnI+DQorSU5DwqAgwqAgwqAg
wqAgwqAgwqAgwqAxMDAxIDAxMCAuLi4uLiAwMDExwqAgwqAgwqAgwqAgwqBAb3BfcmQ8YnI+DQor
TERYMcKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAwIC4uLi4uIDExMDDCoCDCoCDCoCDCoCDCoEBv
cF9yZDxicj4NCitMRFgywqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDAgLi4uLi4gMTEwMcKgIMKg
IMKgIMKgIMKgQG9wX3JkPGJyPg0KK0xEWDPCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMCAuLi4u
LiAxMTEwwqAgwqAgwqAgwqAgwqBAb3BfcmQ8YnI+DQorTERZMsKgIMKgIMKgIMKgIMKgIMKgIDEw
MDEgMDAwIC4uLi4uIDEwMDHCoCDCoCDCoCDCoCDCoEBvcF9yZDxicj4NCitMRFkzwqAgwqAgwqAg
wqAgwqAgwqAgMTAwMSAwMDAgLi4uLi4gMTAxMMKgIMKgIMKgIMKgIMKgQG9wX3JkPGJyPg0KK0xE
WjLCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMCAuLi4uLiAwMDAxwqAgwqAgwqAgwqAgwqBAb3Bf
cmQ8YnI+DQorTERaM8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAwIC4uLi4uIDAwMTDCoCDCoCDC
oCDCoCDCoEBvcF9yZDxicj4NCitMUE0ywqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDAgLi4uLi4g
MDEwMMKgIMKgIMKgIMKgIMKgQG9wX3JkPGJyPg0KK0xQTVjCoCDCoCDCoCDCoCDCoCDCoCAxMDAx
IDAwMCAuLi4uLiAwMTAxwqAgwqAgwqAgwqAgwqBAb3BfcmQ8YnI+DQorTFNSwqAgwqAgwqAgwqAg
wqAgwqAgwqAxMDAxIDAxMCAuLi4uLiAwMTEwwqAgwqAgwqAgwqAgwqBAb3BfcmQ8YnI+DQorTkVH
wqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAxMCAuLi4uLiAwMDAxwqAgwqAgwqAgwqAgwqBAb3Bf
cmQ8YnI+DQorUE9QwqAgwqAgwqAgwqAgwqAgwqAgwqAxMDAxIDAwMCAuLi4uLiAxMTExwqAgwqAg
wqAgwqAgwqBAb3BfcmQ8YnI+DQorUFVTSMKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAxIC4uLi4u
IDExMTHCoCDCoCDCoCDCoCDCoEBvcF9yZDxicj4NCitST1LCoCDCoCDCoCDCoCDCoCDCoCDCoDEw
MDEgMDEwIC4uLi4uIDAxMTHCoCDCoCDCoCDCoCDCoEBvcF9yZDxicj4NCitTVFkywqAgwqAgwqAg
wqAgwqAgwqAgMTAwMSAwMDEgLi4uLi4gMTAwMcKgIMKgIMKgIMKgIMKgQG9wX3JkPGJyPg0KK1NU
WTPCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMSAuLi4uLiAxMDEwwqAgwqAgwqAgwqAgwqBAb3Bf
cmQ8YnI+DQorU1RaMsKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAxIC4uLi4uIDAwMDHCoCDCoCDC
oCDCoCDCoEBvcF9yZDxicj4NCitTVFozwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMDEgLi4uLi4g
MDAxMMKgIMKgIMKgIMKgIMKgQG9wX3JkPGJyPg0KK1NXQVDCoCDCoCDCoCDCoCDCoCDCoCAxMDAx
IDAxMCAuLi4uLiAwMDEwwqAgwqAgwqAgwqAgwqBAb3BfcmQ8YnI+DQorPGJyPg0KKzxicj4NCitA
b3BfYml0wqAgwqAgwqAgwqAgwqAuLi4uIC4uLi4gLiBiaXQ6MyAuLi4uPGJyPg0KK0JDTFLCoCDC
oCDCoCDCoCDCoCDCoCAxMDAxIDAxMDAgMSAuLi4gMTAwMMKgIMKgIMKgIMKgIEBvcF9iaXQ8YnI+
DQorQlNFVMKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDEwMCAwIC4uLiAxMDAwwqAgwqAgwqAgwqAg
QG9wX2JpdDxicj4NCis8YnI+DQorPGJyPg0KK0BvcF9yZF9iaXTCoCDCoCDCoCAuLi4uIC4uLiBy
ZDo1IC4gYml0OjM8YnI+DQorQkxEwqAgwqAgwqAgwqAgwqAgwqAgwqAxMTExIDEwMCAuLi4uLiAw
IC4uLsKgIMKgIMKgIMKgIEBvcF9yZF9iaXQ8YnI+DQorQlNUwqAgwqAgwqAgwqAgwqAgwqAgwqAx
MTExIDEwMSAuLi4uLiAwIC4uLsKgIMKgIMKgIMKgIEBvcF9yZF9iaXQ8YnI+DQorPGJyPg0KKzxi
cj4NCitAb3BfYml0X2ltbcKgIMKgIMKgLi4uLiAuLiBpbW06czcgYml0OjM8YnI+DQorQlJCQ8Kg
IMKgIMKgIMKgIMKgIMKgIDExMTEgMDEgLi4uLi4uLiAuLi7CoCDCoCDCoCDCoCDCoEBvcF9iaXRf
aW1tPGJyPg0KK0JSQlPCoCDCoCDCoCDCoCDCoCDCoCAxMTExIDAwIC4uLi4uLi4gLi4uwqAgwqAg
wqAgwqAgwqBAb3BfYml0X2ltbTxicj4NCis8YnI+DQorPGJyPg0KK0JSRUFLwqAgwqAgwqAgwqAg
wqAgwqAxMDAxIDAxMDEgMTAwMSAxMDAwPGJyPg0KK0VJQ0FMTMKgIMKgIMKgIMKgIMKgIDEwMDEg
MDEwMSAwMDAxIDEwMDE8YnI+DQorRUlKTVDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMCAwMDAx
IDEwMDE8YnI+DQorRUxQTTHCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMSAxMTAxIDEwMDA8YnI+
DQorSUNBTEzCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMSAwMDAwIDEwMDE8YnI+DQorSUpNUMKg
IMKgIMKgIMKgIMKgIMKgIDEwMDEgMDEwMCAwMDAwIDEwMDE8YnI+DQorTFBNMcKgIMKgIMKgIMKg
IMKgIMKgIDEwMDEgMDEwMSAxMTAwIDEwMDA8YnI+DQorTk9QwqAgwqAgwqAgwqAgwqAgwqAgwqAw
MDAwIDAwMDAgMDAwMCAwMDAwPGJyPg0KK1JFVMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAx
IDAwMDAgMTAwMDxicj4NCitSRVRJwqAgwqAgwqAgwqAgwqAgwqAgMTAwMSAwMTAxIDAwMDEgMTAw
MDxicj4NCitTTEVFUMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAxIDEwMDAgMTAwMDxicj4NCitT
UE3CoCDCoCDCoCDCoCDCoCDCoCDCoDEwMDEgMDEwMSAxMTEwIDEwMDA8YnI+DQorU1BNWMKgIMKg
IMKgIMKgIMKgIMKgIDEwMDEgMDEwMSAxMTExIDEwMDA8YnI+DQorV0RSwqAgwqAgwqAgwqAgwqAg
wqAgwqAxMDAxIDAxMDEgMTAxMCAxMDAwPGJyPg0KKzxicj4NCis8YnI+DQorQG9wX3JlZ19iaXTC
oCDCoCDCoC4uLi4gLi4uLiByZWc6NSBiaXQ6Mzxicj4NCitDQknCoCDCoCDCoCDCoCDCoCDCoCDC
oDEwMDEgMTAwMCAuLi4uLiAuLi7CoCDCoCDCoCDCoCDCoEBvcF9yZWdfYml0PGJyPg0KK1NCScKg
IMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAxMDEwIC4uLi4uIC4uLsKgIMKgIMKgIMKgIMKgQG9wX3Jl
Z19iaXQ8YnI+DQorU0JJQ8KgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMTAwMSAuLi4uLiAuLi7CoCDC
oCDCoCDCoCDCoEBvcF9yZWdfYml0PGJyPg0KK1NCSVPCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDEw
MTEgLi4uLi4gLi4uwqAgwqAgwqAgwqAgwqBAb3BfcmVnX2JpdDxicj4NCis8YnI+DQorPGJyPg0K
K0RFU8KgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMTAwIGltbTo0IDEwMTE8YnI+DQorPGJyPg0K
Kzxicj4NCislcmRfYsKgIMKgIMKgIMKgIMKgIMKgNDozwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAhZnVuY3Rpb249dG9fQjxicj4NCislcnJfYsKgIMKgIMKgIMKgIMKgIMKg
MDozwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAhZnVuY3Rpb249dG9fQjxi
cj4NCitAZm11bMKgIMKgIMKgIMKgIMKgIMKgLi4uLiAuLi4uIC4gLi4uIC4gLi4uwqAgwqAgwqAg
wqAmYW1wO3JkX3JywqAgwqAgwqAgcmQ9JXJkX2IgcnI9JXJyX2I8YnI+DQorRk1VTMKgIMKgIMKg
IMKgIMKgIMKgIDAwMDAgMDAxMSAwIC4uLiAxIC4uLsKgIMKgIMKgIMKgQGZtdWw8YnI+DQorRk1V
TFPCoCDCoCDCoCDCoCDCoCDCoDAwMDAgMDAxMSAxIC4uLiAwIC4uLsKgIMKgIMKgIMKgQGZtdWw8
YnI+DQorRk1VTFNVwqAgwqAgwqAgwqAgwqAgMDAwMCAwMDExIDEgLi4uIDEgLi4uwqAgwqAgwqAg
wqBAZm11bDxicj4NCitNVUxTVcKgIMKgIMKgIMKgIMKgIMKgMDAwMCAwMDExIDAgLi4uIDAgLi4u
wqAgwqAgwqAgwqBAZm11bDxicj4NCis8YnI+DQorPGJyPg0KKyVpb19pbW3CoCDCoCDCoCDCoCDC
oDk6MiAwOjQ8YnI+DQorQGlvX3JkX2ltbcKgIMKgIMKgIC4uLi4gLiAuLiAuLi4uLiAuLi4uwqAg
wqAgwqAgwqAgJmFtcDtyZF9pbW3CoCDCoCDCoHJkPSVyZCBpbW09JWlvX2ltbTxicj4NCitJTsKg
IMKgIMKgIMKgIMKgIMKgIMKgIDEwMTEgMCAuLiAuLi4uLiAuLi4uwqAgwqAgwqAgwqAgQGlvX3Jk
X2ltbTxicj4NCitPVVTCoCDCoCDCoCDCoCDCoCDCoCDCoDEwMTEgMSAuLiAuLi4uLiAuLi4uwqAg
wqAgwqAgwqAgQGlvX3JkX2ltbTxicj4NCis8YnI+DQorPGJyPg0KK1hDSMKgIMKgIMKgIMKgIMKg
IMKgIMKgMTAwMSAwMDEgcmQ6NSAwMTAwPGJyPg0KK0xBQ8KgIMKgIMKgIMKgIMKgIMKgIMKgMTAw
MSAwMDEgcmQ6NSAwMTEwPGJyPg0KK0xBU8KgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDEgcmQ6
NSAwMTAxPGJyPg0KK0xBVMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAwMSAwMDEgcmQ6NSAwMTExPGJy
Pg0KK1NUWDHCoCDCoCDCoCDCoCDCoCDCoCAxMDAxIDAwMSBycjo1IDExMDA8YnI+DQorU1RYMsKg
IMKgIMKgIMKgIMKgIMKgIDEwMDEgMDAxIHJyOjUgMTEwMTxicj4NCitTVFgzwqAgwqAgwqAgwqAg
wqAgwqAgMTAwMSAwMDEgcnI6NSAxMTEwPGJyPg0KKzxicj4NCis8YnI+DQorJWxkc3RfZF9pbW3C
oCDCoCDCoDEzOjEgMTA6MiAwOjM8YnI+DQorQGxkc3RfZMKgIMKgIMKgIMKgIMKgLi4gLiAuIC4u
IC4gcmQ6NcKgIC4gLi4uwqAgwqAgwqAmYW1wO3JkX2ltbcKgIMKgIMKgaW1tPSVsZHN0X2RfaW1t
PGJyPg0KK0xERFnCoCDCoCDCoCDCoCDCoCDCoCAxMCAuIDAgLi4gMCAuLi4uLiAxIC4uLsKgIMKg
IMKgQGxkc3RfZDxicj4NCitMRERawqAgwqAgwqAgwqAgwqAgwqAgMTAgLiAwIC4uIDAgLi4uLi4g
MCAuLi7CoCDCoCDCoEBsZHN0X2Q8YnI+DQorU1REWcKgIMKgIMKgIMKgIMKgIMKgIDEwIC4gMCAu
LiAxIC4uLi4uIDEgLi4uwqAgwqAgwqBAbGRzdF9kPGJyPg0KK1NURFrCoCDCoCDCoCDCoCDCoCDC
oCAxMCAuIDAgLi4gMSAuLi4uLiAwIC4uLsKgIMKgIMKgQGxkc3RfZDxicj4NCis8YnI+DQorPGJy
Pg0KK01PVlfCoCDCoCDCoCDCoCDCoCDCoCAwMDAwIDAwMDEgLi4uLiAuLi4uwqAgwqAgwqAgwqAg
wqAmYW1wO3JkX3JywqAgwqAgwqAgcmQ9JXJkX2QgcnI9JXJyX2Q8YnI+DQorTVVMU8KgIMKgIMKg
IMKgIMKgIMKgIDAwMDAgMDAxMCAuLi4uIC4uLi7CoCDCoCDCoCDCoCDCoCZhbXA7cmRfcnLCoCDC
oCDCoCByZD0lcmRfYSBycj0lcnJfYTxicj4NCis8YnI+DQorUkNBTEzCoCDCoCDCoCDCoCDCoCDC
oDExMDEgaW1tOnMxMjxicj4NCitSSk1QwqAgwqAgwqAgwqAgwqAgwqAgMTEwMCBpbW06czEyPGJy
Pg0KKzxicj4NCitTQlJDwqAgwqAgwqAgwqAgwqAgwqAgMTExMSAxMTAgcnI6NSAwIGJpdDozPGJy
Pg0KK1NCUlPCoCDCoCDCoCDCoCDCoCDCoCAxMTExIDExMSBycjo1IDAgYml0OjM8YnI+DQorPGJy
Pg0KKyMgVGhlIDIyLWJpdCBpbW1lZGlhdGUgaXMgcGFydGlhbGx5IGluIHRoZSBvcGNvZGUgd29y
ZCw8YnI+DQorIyBhbmQgcGFydGlhbGx5IGluIHRoZSBuZXh0LsKgIFVzZSBhcHBlbmRfMTYgdG8g
YnVpbGQgdGhlPGJyPg0KKyMgY29tcGxldGUgMjItYml0IHZhbHVlLjxicj4NCislaW1tX2NhbGzC
oCDCoCDCoCDCoDQ6NSAwOjHCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCFmdW5jdGlv
bj1hcHBlbmRfMTY8YnI+DQorQ0FMTMKgIMKgIMKgIMKgIMKgIMKgIDEwMDEgMDEwIC4uLi4uIDEx
MSAuwqAgwqAgwqAgwqAgaW1tPSVpbW1fY2FsbDxicj4NCitKTVDCoCDCoCDCoCDCoCDCoCDCoCDC
oDEwMDEgMDEwIC4uLi4uIDExMCAuwqAgwqAgwqAgwqAgaW1tPSVpbW1fY2FsbDxicj4NCis8YnI+
DQorPGJyPg0KKyMgVGhlIDE2LWJpdCBpbW1lZGlhdGUgaXMgY29tcGxldGVseSBpbiB0aGUgbmV4
dCB3b3JkLjxicj4NCisjIEZpZWxkcyBjYW5ub3QgYmUgZGVmaW5lZCB3aXRoIG5vIGJpdHMsIHNv
IHdlIGNhbm5vdCBwbGF5PGJyPg0KKyMgdGhlIHNhbWUgdHJpY2sgYW5kIGFwcGVuZCB0byBhIHpl
cm8tYml0IHZhbHVlLjxicj4NCisjIERlZmVyIHJlYWRpbmcgdGhlIGltbWVkaWF0ZSB1bnRpbCB0
cmFuc197TERTLFNUU30uPGJyPg0KK0BsZHN0X3PCoCDCoCDCoCDCoCDCoC4uLi4gLi4uIHJkOjUg
Li4uLsKgIMKgIMKgIMKgIMKgIGltbT0wPGJyPg0KK0xEU8KgIMKgIMKgIMKgIMKgIMKgIMKgMTAw
MSAwMDAgLi4uLi4gMDAwMMKgIMKgIMKgIMKgIMKgQGxkc3Rfczxicj4NCitTVFPCoCDCoCDCoCDC
oCDCoCDCoCDCoDEwMDEgMDAxIC4uLi4uIDAwMDDCoCDCoCDCoCDCoCDCoEBsZHN0X3M8YnI+DQot
LSA8YnI+DQoyLjE3LjIgKEFwcGxlIEdpdC0xMTMpPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPg0K
--000000000000ff82f40598193567--

