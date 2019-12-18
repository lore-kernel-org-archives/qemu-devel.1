Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0275AC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:54:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3C02176D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 01:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd0oQBIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3C02176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihl12-0002FQ-Iy
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 20:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihl0R-0001oN-RS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihl0P-0006WW-Vz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 20:53:35 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53492)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgUE-0000k7-Ja
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:02 -0500
Received: by mail-wm1-x343.google.com with SMTP id m24so3291157wmc.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4elmzpyjEWZ2TlxId0BYmFQrIAFgm4zvXTVXDj+S/7w=;
 b=fd0oQBIFrXiE2RefFO9A9g4+WKKdsR8G7qoO5hoepWPzJvvNU6mvTUN+90FbYAZgjd
 k/BNnSL8pSNuGrzRLqZ7XIICROLOgbV0taMOxclpeZgCFIaYJPbBA7vpngb1EiG45lQe
 SxqY6gA/v9knWY0wGiYJxIwI8HhpDOyVf2p5TYUa73+hTO1NHCNmOlkKXXcCTPZblM4W
 g41dv+QFE77QuVzu00h8XmNNfUyrJdOVqeYlkByaXq+eBWp8YvxOncq8AWSvhHV7ijMt
 kDSRlBKSFsAi0o2j7lNqH7UUy67rsCO/lwyZr71xmc4nAhkSLxWQdGtbw9aKm0K2mGxi
 VpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4elmzpyjEWZ2TlxId0BYmFQrIAFgm4zvXTVXDj+S/7w=;
 b=ODz88kb1hWRjIwtelvQBDCFe4WVvEI23WFQtLYSSa4tzHX6m3HW4EnGW09+B/qHxdM
 Uydw6YJdySD5fA/8+MYEqaYKhtXkocASETujPvvuZ3FrkG574jNOwJRJWqpPcw4IrVAz
 Y4wnyTEhOSvSj4SzxTVwmBbDHaBOKWbNDnNOy5tIPQwdsLNoQe7hQ4g1HAasX/zU1e5b
 z1DQFp+LNidlvnxdco+MSlsXmV9t1QJH2LmfEncVPgu6wZi5heg163c7pbBv204JgqSS
 q2m2IXPXTNOTNoR0GxIiq8XSD0b6J2Q5F5PCk+yq1Gs/pWqZlwRDH6a+Y+8KTrLY9GxR
 KXWw==
X-Gm-Message-State: APjAAAVYWvY5Q2AHFYDTFH0xkoavn/6s4SD9csfS94KEUFT49sQ3i6do
 gRREWBn84HsvYavcUHsoaajQhxuqHUk+xA==
X-Google-Smtp-Source: APXvYqxXd7t2XWM4uOKGy6r9rWxur2pKlFj/h5ftnFf9ku7qkTk62s/Dk7bPJQTdRLORFbvhyhEUJw==
X-Received: by 2002:a05:600c:2046:: with SMTP id
 p6mr5625357wmg.110.1576703041104; 
 Wed, 18 Dec 2019 13:04:01 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.03.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:00 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 03/22] target/avr: Add instruction decoding
Date: Wed, 18 Dec 2019 23:03:10 +0200
Message-Id: <20191218210329.1960-4-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This includes:
- encoding of all 16 bit instructions
- encoding of all 32 bit instructions

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/avr/insn.decode | 183 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100644 target/avr/insn.decode

diff --git a/target/avr/insn.decode b/target/avr/insn.decode
new file mode 100644
index 0000000000..0e4ec9ddf0
--- /dev/null
+++ b/target/avr/insn.decode
@@ -0,0 +1,183 @@
+#
+# AVR instruction decode definitions.
+#
+# Copyright (c) 2019 Michael Rolnik <mrolnik@gmail.com>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+#
+
+#
+#   regs_16_31_by_one = [16 .. 31]
+#   regs_16_23_by_one = [16 .. 23]
+#   regs_24_30_by_two = [24, 26, 28, 30]
+#   regs_00_30_by_two = [0, 2, 4, 6, 8, .. 30]
+
+%rd             4:5
+%rr             9:1 0:4
+
+%rd_a           4:4                         !function=to_regs_16_31_by_one
+%rd_b           4:3                         !function=to_regs_16_23_by_one
+%rd_c           4:2                         !function=to_regs_24_30_by_two
+%rd_d           4:4                         !function=to_regs_00_30_by_two
+%rr_a           0:4                         !function=to_regs_16_31_by_one
+%rr_b           0:3                         !function=to_regs_16_23_by_one
+%rr_d           0:4                         !function=to_regs_00_30_by_two
+
+%imm6           6:2 0:4
+%imm8           8:4 0:4
+
+%io_imm         9:2 0:4
+%ldst_d_imm     13:1 10:2 0:3
+
+# The 22-bit immediate is partially in the opcode word,
+# and partially in the next.  Use append_16 to build the
+# complete 22-bit value.
+%imm_call       4:5 0:1                     !function=append_16
+
+
+&rd_rr          rd rr
+&rd_imm         rd imm
+
+@op_rd_rr       .... .. . ..... ....        &rd_rr      rd=%rd rr=%rr
+@op_rd_imm6     .... .... .. .. ....        &rd_imm     rd=%rd_c imm=%imm6
+@op_rd_imm8     .... .... .... ....         &rd_imm     rd=%rd_a imm=%imm8
+@op_bit         .... .... . bit:3 ....
+@op_bit_imm     .... .. imm:s7 bit:3
+@fmul           .... .... . ... . ...       &rd_rr      rd=%rd_b rr=%rr_b
+@io_rd_imm      .... . .. ..... ....        &rd_imm     rd=%rd imm=%io_imm
+@ldst_d         .. . . .. . rd:5  . ...     &rd_imm     imm=%ldst_d_imm
+
+# The 16-bit immediate is completely in the next word.
+# Fields cannot be defined with no bits, so we cannot play
+# the same trick and append to a zero-bit value.
+# Defer reading the immediate until trans_{LDS,STS}.
+@ldst_s         .... ... rd:5 ....          imm=0
+
+#
+# Arithmetic Instructions
+#
+ADD             0000 11 . ..... ....        @op_rd_rr
+ADC             0001 11 . ..... ....        @op_rd_rr
+ADIW            1001 0110 .. .. ....        @op_rd_imm6
+SUB             0001 10 . ..... ....        @op_rd_rr
+SUBI            0101 .... .... ....         @op_rd_imm8
+SBC             0000 10 . ..... ....        @op_rd_rr
+SBCI            0100 .... .... ....         @op_rd_imm8
+SBIW            1001 0111 .. .. ....        @op_rd_imm6
+AND             0010 00 . ..... ....        @op_rd_rr
+ANDI            0111 .... .... ....         @op_rd_imm8
+OR              0010 10 . ..... ....        @op_rd_rr
+ORI             0110 .... .... ....         @op_rd_imm8
+EOR             0010 01 . ..... ....        @op_rd_rr
+COM             1001 010 rd:5 0000
+NEG             1001 010 rd:5 0001
+INC             1001 010 rd:5 0011
+DEC             1001 010 rd:5 1010
+MUL             1001 11 . ..... ....        @op_rd_rr
+MULS            0000 0010 .... ....         &rd_rr      rd=%rd_a rr=%rr_a
+MULSU           0000 0011 0 ... 0 ...       @fmul
+FMUL            0000 0011 0 ... 1 ...       @fmul
+FMULS           0000 0011 1 ... 0 ...       @fmul
+FMULSU          0000 0011 1 ... 1 ...       @fmul
+DES             1001 0100 imm:4 1011
+
+#
+# Branch Instructions
+#
+RJMP            1100 imm:s12
+IJMP            1001 0100 0000 1001
+EIJMP           1001 0100 0001 1001
+JMP             1001 010 ..... 110 .        imm=%imm_call
+RCALL           1101 imm:s12
+ICALL           1001 0101 0000 1001
+EICALL          1001 0101 0001 1001
+CALL            1001 010 ..... 111 .        imm=%imm_call
+RET             1001 0101 0000 1000
+RETI            1001 0101 0001 1000
+CPSE            0001 00 . ..... ....        @op_rd_rr
+CP              0001 01 . ..... ....        @op_rd_rr
+CPC             0000 01 . ..... ....        @op_rd_rr
+CPI             0011 .... .... ....         @op_rd_imm8
+SBRC            1111 110 rr:5 0 bit:3
+SBRS            1111 111 rr:5 0 bit:3
+SBIC            1001 1001 reg:5 bit:3
+SBIS            1001 1011 reg:5 bit:3
+BRBS            1111 00 ....... ...         @op_bit_imm
+BRBC            1111 01 ....... ...         @op_bit_imm
+
+#
+# Data Transfer Instructions
+#
+MOV             0010 11 . ..... ....        @op_rd_rr
+MOVW            0000 0001 .... ....         &rd_rr      rd=%rd_d rr=%rr_d
+LDI             1110 .... .... ....         @op_rd_imm8
+LDS             1001 000 ..... 0000         @ldst_s
+LDX1            1001 000 rd:5 1100
+LDX2            1001 000 rd:5 1101
+LDX3            1001 000 rd:5 1110
+LDY2            1001 000 rd:5 1001
+LDY3            1001 000 rd:5 1010
+LDZ2            1001 000 rd:5 0001
+LDZ3            1001 000 rd:5 0010
+LDDY            10 . 0 .. 0 ..... 1 ...     @ldst_d
+LDDZ            10 . 0 .. 0 ..... 0 ...     @ldst_d
+STS             1001 001 ..... 0000         @ldst_s
+STX1            1001 001 rr:5 1100
+STX2            1001 001 rr:5 1101
+STX3            1001 001 rr:5 1110
+STY2            1001 001 rd:5 1001
+STY3            1001 001 rd:5 1010
+STZ2            1001 001 rd:5 0001
+STZ3            1001 001 rd:5 0010
+STDY            10 . 0 .. 1 ..... 1 ...     @ldst_d
+STDZ            10 . 0 .. 1 ..... 0 ...     @ldst_d
+LPM1            1001 0101 1100 1000
+LPM2            1001 000 rd:5 0100
+LPMX            1001 000 rd:5 0101
+ELPM1           1001 0101 1101 1000
+ELPM2           1001 000 rd:5 0110
+ELPMX           1001 000 rd:5 0111
+SPM             1001 0101 1110 1000
+SPMX            1001 0101 1111 1000
+IN              1011 0 .. ..... ....        @io_rd_imm
+OUT             1011 1 .. ..... ....        @io_rd_imm
+PUSH            1001 001 rd:5 1111
+POP             1001 000 rd:5 1111
+XCH             1001 001 rd:5 0100
+LAC             1001 001 rd:5 0110
+LAS             1001 001 rd:5 0101
+LAT             1001 001 rd:5 0111
+
+#
+# Bit and Bit-test Instructions
+#
+LSR             1001 010 rd:5 0110
+ROR             1001 010 rd:5 0111
+ASR             1001 010 rd:5 0101
+SWAP            1001 010 rd:5 0010
+SBI             1001 1010 reg:5 bit:3
+CBI             1001 1000 reg:5 bit:3
+BST             1111 101 rd:5 0 bit:3
+BLD             1111 100 rd:5 0 bit:3
+BSET            1001 0100 0 bit:3 1000
+BCLR            1001 0100 1 bit:3 1000
+
+#
+# MCU Control Instructions
+#
+BREAK           1001 0101 1001 1000
+NOP             0000 0000 0000 0000
+SLEEP           1001 0101 1000 1000
+WDR             1001 0101 1010 1000
+
-- 
2.17.2 (Apple Git-113)


