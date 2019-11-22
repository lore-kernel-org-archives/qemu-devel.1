Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB1D20714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TPd1rdXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB1D20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7RB-0007De-UF
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:49:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41970)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7OS-0005g1-Mb
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:46:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7OQ-0002P2-Nz
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:46:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32888
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7OQ-0002Nj-Jr
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574423190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kpblCqHG+HhmvUzOs4vgsTOkd3JxBPPcNtkBxWZGFuI=;
 b=TPd1rdXOF6eKLI0BIzl0uC0SiveOAURJYWlUUxLJI6yji5YzjMtG6txGFr3aO09ldDuiD3
 QWxgrtNO1i06gmww3XYFj22LH0g9j5R/4AtvY4aq/GY9U61seO3QmHcsQWXLXU6QrbS6O1
 O4lodSVYJ9xREX+0ERjfWdPszzloSQg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-0F62LCvMMw-YAnuU_afSig-1; Fri, 22 Nov 2019 06:46:26 -0500
Received: by mail-wm1-f70.google.com with SMTP id g14so3263164wmk.9
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gzars9XQVLu75S7Dd4jqFCb/6b3J2Dx3jFQPwOb3GBY=;
 b=mHzLczGmFn+fzcmp3Rfrg+okGNtWP5kGDkXjfFKJqQaLfP8hkx9SVHf9RKfwGG8FYY
 onoiy61lj+6W0BS5Vs74E2WROWcumAGO79ZkqLOGX13flaQ1s4tNouCQgV0T5LTsIhBT
 QA9vGVsFiucxaW7BC8DX9w8d+SqpilL8l9T2o7ZY5J5lY6NqyUyq1crFQZ5CE1dcV4In
 68V3f71NUTo2gdyrM1l7cGJTXC7pdbYE3tQteU2COiMDPUvmfr62grLVba4aPVHymtPJ
 prpyOK7tYdr+RHrvoMUqLwPw/K9b9mtal92Jn1aU4tI0e7x2buvLkbpghGDV6nmTd5Jf
 L6+g==
X-Gm-Message-State: APjAAAVgePD0e58uY4hq1drksEpw4PzJSkwjFMfwMO/GGQhq9WIQ4FXR
 GGi+eLuynwAPZ2SMJzeQWBdzR+xbi2YMrng/ZMxs/rlJhaRDJKNxYPUOK1GtSH0FC5qTcHdzmvg
 t7OR7I4YwKBX/2E4=
X-Received: by 2002:adf:ef51:: with SMTP id c17mr18487133wrp.266.1574423185594; 
 Fri, 22 Nov 2019 03:46:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDTO5OBU/8wZcEDo6GrhF4I4hmiOhIjcMjtvZTohBKMTUkdmId76IJvLvdDoa45v/Xso5DmQ==
X-Received: by 2002:adf:ef51:: with SMTP id c17mr18487110wrp.266.1574423185324; 
 Fri, 22 Nov 2019 03:46:25 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id h97sm4466649wrh.56.2019.11.22.03.46.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:46:24 -0800 (PST)
Subject: Re: [PATCH v35 03/13] target/avr: Add instruction decoding
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-4-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2f750d23-2413-5596-0b6d-b91bc1adc521@redhat.com>
Date: Fri, 22 Nov 2019 12:46:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-4-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: 0F62LCvMMw-YAnuU_afSig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: thuth@redhat.com, Joaquin de Andres <me@xcancerberox.com.ar>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> This includes:
> - encoding of all 16 bit instructions
> - encoding of all 32 bit instructions
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/avr/insn.decode | 175 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 175 insertions(+)
>   create mode 100644 target/avr/insn.decode
>=20
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
>=20


