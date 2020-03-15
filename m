Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3AFC5ACBF
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB28420575
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 13:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s42pvHJ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB28420575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDTZm-0003hI-FH
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 09:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJg-00086U-As
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJW-000328-Q3
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:38469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jDTJW-0002v8-8W
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 09:28:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id t13so8745119wmi.3
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 06:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Oy70tYO5jJPBw7BuFrRb/GK9kuCzViHffnRt5fHb7y4=;
 b=s42pvHJ7zt3MzWFXi5wg+qbzL04ZUgQ8v31tMobJZTrDdd5r06gRj/Z9End0Qkahcn
 e/AXtpwzoFwIupvRKEYNRuWKfVGLUnyWle4FUGiDVMCeXv9uUAXu0Vw3GsxzDwr4n+ja
 58HpU/vTWbROnnbAv8+2P7MQvIISHMF5ZgjVTnVQTptSgQNSk+MEGTGTAmwNdGC8CRDO
 Y4iDZSUtBFLvHJ3pSaJMTLcVXnE7q2M2uEAOgsc8/Cdfj380k/sckzSxE3lZlBGlZz0e
 7WB5kaqWLlIxKeBE2iSNb1YXMNofO3jYtjmEdq1qyaiAoz400V0JoBF3ScDDdJwbcqpS
 xniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Oy70tYO5jJPBw7BuFrRb/GK9kuCzViHffnRt5fHb7y4=;
 b=pr6Ck/+fDKZx0In+e07sF3gDfuWa9QHs5/v2CjIPRK63Tk1z4AuFWrGIqRwL6vKj5l
 fXxpeTWes/T7AIj44Jpu/3Sg7A487stOgQmv0OPdDurrwqs3mYrnArqTvW4ukGhfL2uz
 343NRahX0KUOngxdpwYd+G5ZXg8HASNuH58noJTLsiUspk/Y94EX7fGg+fzotFf0AYAZ
 M3cN/ZdZJDS7N4REzXsIEZFyvleapfJLWE0LiQxnPOXNokMk8LRg7g2jrdM5dhlDvuf3
 6GgU9+O2L5d4LlbV5WwIQiIT+ExcSW9tn4jxKiG5+YhngxIQzCp0gc7ZDqPBQ8Ux9cf5
 5EXQ==
X-Gm-Message-State: ANhLgQ3jYqg2RN9XpDiv+CQj4bw5jb/kScu0PxiRY/ZFA5DKyRgyzfCM
 rXCzvbo9uKPNtO5Ko8vHwYvllonN
X-Google-Smtp-Source: ADFU+vtKbE815i1FNgeWhW5Lz4SDRUbFr0wtuD0xbkxD2QBui7AWV6eACVTfMrRqX7CG203jsnEB1Q==
X-Received: by 2002:a05:600c:2c06:: with SMTP id
 q6mr16616000wmg.52.1584278898431; 
 Sun, 15 Mar 2020 06:28:18 -0700 (PDT)
Received: from localhost.localdomain (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm87590503wrp.37.2020.03.15.06.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2020 06:28:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/13] target/rx: TCG translation
Date: Sun, 15 Mar 2020 14:27:59 +0100
Message-Id: <20200315132810.7022-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200315132810.7022-1-f4bug@amsat.org>
References: <20200315132810.7022-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

This part only supported RXv1 instructions.

Instruction manual:
  https://www.renesas.com/us/en/doc/products/mpumcu/doc/rx_family/r01us0032ej0120_rxsm.pdf

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200224141923.82118-5-ysato@users.sourceforge.jp>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/rx/insns.decode  |  621 ++++++++++
 target/rx/translate.c   | 2432 +++++++++++++++++++++++++++++++++++++++
 target/rx/Makefile.objs |   12 +
 3 files changed, 3065 insertions(+)
 create mode 100644 target/rx/insns.decode
 create mode 100644 target/rx/translate.c
 create mode 100644 target/rx/Makefile.objs

diff --git a/target/rx/insns.decode b/target/rx/insns.decode
new file mode 100644
index 0000000000..232a61fc8e
--- /dev/null
+++ b/target/rx/insns.decode
@@ -0,0 +1,621 @@
+#
+# Renesas RX instruction decode definitions.
+#
+# Copyright (c) 2019 Richard Henderson <richard.henderson@linaro.org>
+# Copyright (c) 2019 Yoshinori Sato <ysato@users.sourceforge.jp>
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2 of the License, or (at your option) any later version.
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
+&bcnd		cd dsp sz
+&jdsp		dsp sz
+&jreg		rs
+&rr		rd rs
+&ri		rd imm
+&rrr		rd rs rs2
+&rri		rd imm rs2
+&rm		rd rs ld mi
+&mi		rs ld mi imm
+&mr		rs ld mi rs2
+&mcnd		ld sz rd cd
+########
+%b1_bdsp	24:3 !function=bdsp_s
+
+@b1_bcnd_s	.... cd:1 ...			&bcnd dsp=%b1_bdsp sz=1
+@b1_bra_s	.... ....			&jdsp dsp=%b1_bdsp sz=1
+
+%b2_r_0		16:4
+%b2_li_2	18:2 !function=li
+%b2_li_8	24:2 !function=li
+%b2_dsp5_3	23:4 19:1
+
+@b2_rds		.... .... .... rd:4		&rr rs=%b2_r_0
+@b2_rds_li	.... .... .... rd:4		&rri rs2=%b2_r_0 imm=%b2_li_8
+@b2_rds_uimm4	.... .... imm:4 rd:4		&rri rs2=%b2_r_0
+@b2_rs2_uimm4	.... .... imm:4 rs2:4		&rri rd=0
+@b2_rds_imm5	.... ... imm:5 rd:4		&rri rs2=%b2_r_0
+@b2_rd_rs_li	.... .... rs2:4 rd:4		&rri imm=%b2_li_8
+@b2_rd_ld_ub	.... .. ld:2 rs:4 rd:4		&rm mi=4
+@b2_ld_imm3	.... .. ld:2 rs:4 . imm:3	&mi mi=4
+@b2_bcnd_b	.... cd:4 dsp:s8		&bcnd sz=2
+@b2_bra_b	.... .... dsp:s8		&jdsp sz=2
+
+########
+
+%b3_r_0		8:4
+%b3_li_10	18:2 !function=li
+%b3_dsp5_8	23:1 16:4
+%b3_bdsp	8:s8 16:8
+
+@b3_rd_rs	.... .... .... .... rs:4 rd:4		&rr
+@b3_rs_rd	.... .... .... .... rd:4 rs:4		&rr
+@b3_rd_li	.... .... .... .... .... rd:4 \
+		&rri rs2=%b3_r_0 imm=%b3_li_10
+@b3_rd_ld	.... .... mi:2 .... ld:2 rs:4 rd:4	&rm
+@b3_rd_ld_ub	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=4
+@b3_rd_ld_ul	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=2
+@b3_rd_rs_rs2	.... .... .... rd:4 rs:4 rs2:4		&rrr
+@b3_rds_imm5	.... .... ....... imm:5 rd:4		&rri rs2=%b3_r_0
+@b3_rd_rs_imm5	.... .... ... imm:5 rs2:4 rd:4		&rri
+@b3_bcnd_w	.... ... cd:1 .... .... .... ....	&bcnd dsp=%b3_bdsp sz=3
+@b3_bra_w	.... .... .... .... .... ....		&jdsp dsp=%b3_bdsp sz=3
+@b3_ld_rd_rs	.... .... .... .. ld:2 rs:4 rd:4	&rm mi=0
+@b3_sz_ld_rd_cd	.... .... .... sz:2 ld:2 rd:4 cd:4	&mcnd
+
+########
+
+%b4_li_18	18:2 !function=li
+%b4_dsp_16	0:s8 8:8
+%b4_bdsp	0:s8 8:8 16:8
+
+@b4_rd_ldmi	.... .... mi:2 .... ld:2 .... .... rs:4 rd:4	&rm
+@b4_bra_a	.... .... .... .... .... .... .... ....	\
+		&jdsp dsp=%b4_bdsp sz=4
+########
+# ABS rd
+ABS_rr		0111 1110 0010 ....			@b2_rds
+# ABS rs, rd
+ABS_rr		1111 1100 0000 1111 .... ....		@b3_rd_rs
+
+# ADC #imm, rd
+ADC_ir		1111 1101 0111 ..00 0010 ....		@b3_rd_li
+# ADC rs, rd
+ADC_rr		1111 1100 0000 1011 .... ....		@b3_rd_rs
+# ADC dsp[rs].l, rd
+# Note only mi==2 allowed.
+ADC_mr		0000 0110 ..10 00.. 0000 0010 .... ....	@b4_rd_ldmi
+
+# ADD #uimm4, rd
+ADD_irr		0110 0010 .... ....			@b2_rds_uimm4
+# ADD #imm, rs, rd
+ADD_irr		0111 00.. .... ....			@b2_rd_rs_li
+# ADD dsp[rs].ub, rd
+# ADD rs, rd
+ADD_mr		0100 10.. .... ....			@b2_rd_ld_ub
+# ADD dsp[rs], rd
+ADD_mr		0000 0110 ..00 10.. .... ....		@b3_rd_ld
+# ADD rs, rs2, rd
+ADD_rrr		1111 1111 0010 .... .... ....		@b3_rd_rs_rs2
+
+# AND #uimm4, rd
+AND_ir		0110 0100 .... ....			@b2_rds_uimm4
+# AND #imm, rd
+AND_ir		0111 01.. 0010 ....			@b2_rds_li
+# AND dsp[rs].ub, rd
+# AND rs, rd
+AND_mr		0101 00.. .... ....			@b2_rd_ld_ub
+# AND dsp[rs], rd
+AND_mr		0000 0110 ..01 00.. .... ....		@b3_rd_ld
+# AND rs, rs2, rd
+AND_rrr		1111 1111 0100 .... .... ....		@b3_rd_rs_rs2
+
+# BCLR #imm, dsp[rd]
+BCLR_im		1111 00.. .... 1...			@b2_ld_imm3
+# BCLR #imm, rs
+BCLR_ir		0111 101. .... ....			@b2_rds_imm5
+# BCLR rs, rd
+# BCLR rs, dsp[rd]
+{
+  BCLR_rr	1111 1100 0110 0111 .... ....		@b3_rs_rd
+  BCLR_rm	1111 1100 0110 01.. .... ....		@b3_rd_ld_ub
+}
+
+# BCnd.s dsp
+BCnd		0001 ....				@b1_bcnd_s
+# BRA.b dsp
+# BCnd.b dsp
+{
+  BRA		0010 1110 .... ....			@b2_bra_b
+  BCnd		0010 .... .... ....			@b2_bcnd_b
+}
+
+# BCnd.w dsp
+BCnd		0011 101 . .... .... .... ....		@b3_bcnd_w
+
+# BNOT #imm, dsp[rd]
+# BMCnd #imm, dsp[rd]
+{
+  BNOT_im	1111 1100 111 imm:3 ld:2 rs:4 1111
+  BMCnd_im	1111 1100 111 imm:3 ld:2 rd:4 cd:4
+}
+
+# BNOT #imm, rd
+# BMCnd #imm, rd
+{
+  BNOT_ir	1111 1101 111 imm:5 1111 rd:4
+  BMCnd_ir	1111 1101 111 imm:5 cd:4 rd:4
+}
+
+# BNOT rs, rd
+# BNOT rs, dsp[rd]
+{
+  BNOT_rr	1111 1100 0110 1111 .... ....		@b3_rs_rd
+  BNOT_rm	1111 1100 0110 11.. .... ....		@b3_rd_ld_ub
+}
+
+# BRA.s dsp
+BRA		0000 1 ...				@b1_bra_s
+# BRA.w dsp
+BRA		0011 1000 .... .... .... ....		@b3_bra_w
+# BRA.a dsp
+BRA		0000 0100 .... .... .... .... .... ....		@b4_bra_a
+# BRA.l rs
+BRA_l		0111 1111 0100 rd:4
+
+BRK		0000 0000
+
+# BSET #imm, dsp[rd]
+BSET_im		1111 00.. .... 0...			@b2_ld_imm3
+# BSET #imm, rd
+BSET_ir		0111 100. .... ....			@b2_rds_imm5
+# BSET rs, rd
+# BSET rs, dsp[rd]
+{
+  BSET_rr	1111 1100 0110 0011 .... ....		@b3_rs_rd
+  BSET_rm	1111 1100 0110 00.. .... ....		@b3_rd_ld_ub
+}
+
+# BSR.w dsp
+BSR		0011 1001 .... .... .... ....		@b3_bra_w
+# BSR.a dsp
+BSR		0000 0101 .... .... .... .... .... ....		@b4_bra_a
+# BSR.l rs
+BSR_l		0111 1111 0101 rd:4
+
+# BSET #imm, dsp[rd]
+BTST_im		1111 01.. .... 0...			@b2_ld_imm3
+# BSET #imm, rd
+BTST_ir		0111 110. .... ....			@b2_rds_imm5
+# BSET rs, rd
+# BSET rs, dsp[rd]
+{
+  BTST_rr	1111 1100 0110 1011 .... ....		@b3_rs_rd
+  BTST_rm	1111 1100 0110 10.. .... ....		@b3_rd_ld_ub
+}
+
+# CLRSPW psw
+CLRPSW		0111 1111 1011 cb:4
+
+# CMP #uimm4, rs2
+CMP_ir		0110 0001 .... ....			@b2_rs2_uimm4
+# CMP #uimm8, rs2
+CMP_ir		0111 0101 0101 rs2:4 imm:8		&rri rd=0
+# CMP #imm, rs2
+CMP_ir		0111 01.. 0000 rs2:4			&rri imm=%b2_li_8 rd=0
+# CMP dsp[rs].ub, rs2
+# CMP rs, rs2
+CMP_mr		0100 01.. .... ....			@b2_rd_ld_ub
+# CMP dsp[rs], rs2
+CMP_mr		0000 0110 ..00 01.. .... ....		@b3_rd_ld
+
+# DIV #imm, rd
+DIV_ir		1111 1101 0111 ..00 1000 ....		@b3_rd_li
+# DIV dsp[rs].ub, rd
+# DIV rs, rd
+DIV_mr		1111 1100 0010 00.. .... ....		@b3_rd_ld_ub
+# DIV dsp[rs], rd
+DIV_mr		0000 0110 ..10 00.. 0000 1000 .... ....	@b4_rd_ldmi
+
+# DIVU #imm, rd
+DIVU_ir		1111 1101 0111 ..00 1001 ....		@b3_rd_li
+# DIVU dsp[rs].ub, rd
+# DIVU rs, rd
+DIVU_mr		1111 1100 0010 01.. .... ....		@b3_rd_ld_ub
+# DIVU dsp[rs], rd
+DIVU_mr		0000 0110 ..10 00.. 0000 1001 .... ....	@b4_rd_ldmi
+
+# EMUL #imm, rd
+EMUL_ir		1111 1101 0111 ..00 0110 ....		@b3_rd_li
+# EMUL dsp[rs].ub, rd
+# EMUL rs, rd
+EMUL_mr		1111 1100 0001 10.. .... ....		@b3_rd_ld_ub
+# EMUL dsp[rs], rd
+EMUL_mr		0000 0110 ..10 00.. 0000 0110 .... ....	@b4_rd_ldmi
+
+# EMULU #imm, rd
+EMULU_ir	1111 1101 0111 ..00 0111 ....		@b3_rd_li
+# EMULU dsp[rs].ub, rd
+# EMULU rs, rd
+EMULU_mr	1111 1100 0001 11.. .... ....		@b3_rd_ld_ub
+# EMULU dsp[rs], rd
+EMULU_mr	0000 0110 ..10 00.. 0000 0111 .... ....	@b4_rd_ldmi
+
+# FADD #imm, rd
+FADD_ir		1111 1101 0111 0010 0010 rd:4
+# FADD rs, rd
+# FADD dsp[rs], rd
+FADD_mr		1111 1100 1000 10.. .... ....		@b3_rd_ld_ul
+
+# FCMP #imm, rd
+FCMP_ir		1111 1101 0111 0010 0001 rd:4
+# FCMP rs, rd
+# FCMP dsp[rs], rd
+FCMP_mr		1111 1100 1000 01.. .... ....		@b3_rd_ld_ul
+
+# FDIV #imm, rd
+FDIV_ir		1111 1101 0111 0010 0100 rd:4
+# FDIV rs, rd
+# FDIV dsp[rs], rd
+FDIV_mr		1111 1100 1001 00.. .... ....		@b3_rd_ld_ul
+
+# FMUL #imm, rd
+FMUL_ir		1111 1101 0111 0010 0011 rd:4
+# FMUL rs, rd
+# FMUL dsp[rs], rd
+FMUL_mr		1111 1100 1000 11.. .... ....		@b3_rd_ld_ul
+
+# FSUB #imm, rd
+FSUB_ir		1111 1101 0111 0010 0000 rd:4
+# FSUB rs, rd
+# FSUB dsp[rs], rd
+FSUB_mr		1111 1100 1000 00.. .... ....		@b3_rd_ld_ul
+
+# FTOI rs, rd
+# FTOI dsp[rs], rd
+FTOI		1111 1100 1001 01.. .... ....		@b3_rd_ld_ul
+
+# INT #uimm8
+INT		0111 0101 0110 0000 imm:8
+
+# ITOF dsp[rs].ub, rd
+# ITOF rs, rd
+ITOF		1111 1100 0100 01.. .... ....		@b3_rd_ld_ub
+# ITOF dsp[rs], rd
+ITOF		0000 0110 ..10 00.. 0001 0001 .... ....	@b4_rd_ldmi
+
+# JMP rs
+JMP		0111 1111 0000 rs:4			&jreg
+# JSR rs
+JSR		0111 1111 0001 rs:4			&jreg
+
+# MACHI rs, rs2
+MACHI		1111 1101 0000 0100 rs:4 rs2:4
+# MACLO rs, rs2
+MACLO		1111 1101 0000 0101 rs:4 rs2:4
+
+# MAX #imm, rd
+MAX_ir		1111 1101 0111 ..00 0100 ....		@b3_rd_li
+# MAX dsp[rs].ub, rd
+# MAX rs, rd
+MAX_mr		1111 1100 0001 00.. .... ....		@b3_rd_ld_ub
+# MAX dsp[rs], rd
+MAX_mr		0000 0110 ..10 00.. 0000 0100 .... ....	@b4_rd_ldmi
+
+# MIN #imm, rd
+MIN_ir		1111 1101 0111 ..00 0101 ....		@b3_rd_li
+# MIN dsp[rs].ub, rd
+# MIN rs, rd
+MIN_mr		1111 1100 0001 01.. .... ....		@b3_rd_ld_ub
+# MIN dsp[rs], rd
+MIN_mr		0000 0110 ..10 00.. 0000 0101 .... ....	@b4_rd_ldmi
+
+# MOV.b rs, dsp5[rd]
+MOV_rm		1000 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 sz=0
+# MOV.w rs, dsp5[rd]
+MOV_rm		1001 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 sz=1
+# MOV.l rs, dsp5[rd]
+MOV_rm		1010 0 .... rd:3 . rs:3			dsp=%b2_dsp5_3 sz=2
+# MOV.b dsp5[rs], rd
+MOV_mr		1000 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 sz=0
+# MOV.w dsp5[rs], rd
+MOV_mr		1001 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 sz=1
+# MOV.l dsp5[rs], rd
+MOV_mr		1010 1 .... rs:3 . rd:3			dsp=%b2_dsp5_3 sz=2
+# MOV.l #uimm4, rd
+MOV_ir		0110 0110 imm:4 rd:4
+# MOV.b #imm8, dsp5[rd]
+MOV_im		0011 1100 . rd:3 .... imm:8		sz=0 dsp=%b3_dsp5_8
+# MOV.w #imm8, dsp5[rd]
+MOV_im		0011 1101 . rd:3 .... imm:8		sz=1 dsp=%b3_dsp5_8
+# MOV.l #imm8, dsp5[rd]
+MOV_im		0011 1110 . rd:3 .... imm:8		sz=2 dsp=%b3_dsp5_8
+# MOV.l #imm8, rd
+MOV_ir		0111 0101 0100 rd:4 imm:8
+# MOV.l #mm8, rd
+MOV_ir		1111 1011 rd:4 .. 10			imm=%b2_li_2
+# MOV.<bwl> #imm, [rd]
+MOV_im		1111 1000 rd:4 .. sz:2			dsp=0 imm=%b2_li_2
+# MOV.<bwl> #imm, dsp8[rd]
+MOV_im		1111 1001 rd:4 .. sz:2 dsp:8		imm=%b3_li_10
+# MOV.<bwl> #imm, dsp16[rd]
+MOV_im		1111 1010 rd:4 .. sz:2 .... .... .... .... \
+		imm=%b4_li_18 dsp=%b4_dsp_16
+# MOV.<bwl> [ri,rb], rd
+MOV_ar		1111 1110 01 sz:2 ri:4 rb:4 rd:4
+# MOV.<bwl> rs, [ri,rb]
+MOV_ra		1111 1110 00 sz:2 ri:4 rb:4 rs:4
+# Note ldd=3 and lds=3 indicate register src or dst
+# MOV.b rs, rd
+# MOV.b rs, dsp[rd]
+# MOV.b dsp[rs], rd
+# MOV.b dsp[rs], dsp[rd]
+MOV_mm		1100 ldd:2 lds:2 rs:4 rd:4		sz=0
+# MOV.w rs, rd
+# MOV.w rs, dsp[rd]
+# MOV.w dsp[rs], rd
+# MOV.w dsp[rs], dsp[rd]
+MOV_mm		1101 ldd:2 lds:2 rs:4 rd:4		sz=1
+# MOV.l rs, rd
+# MOV.l rs, dsp[rd]
+# MOV.l dsp[rs], rd
+# MOV.l dsp[rs], dsp[rd]
+MOV_mm		1110 ldd:2 lds:2 rs:4 rd:4		sz=2
+# MOV.l rs, [rd+]
+# MOV.l rs, [-rd]
+MOV_rp		1111 1101 0010 0 ad:1 sz:2 rd:4 rs:4
+# MOV.l [rs+], rd
+# MOV.l [-rs], rd
+MOV_pr		1111 1101 0010 1 ad:1 sz:2 rd:4 rs:4
+
+# MOVU.<bw> dsp5[rs], rd
+MOVU_mr		1011 sz:1 ... . rs:3 . rd:3		dsp=%b2_dsp5_3
+# MOVU.<bw> [rs], rd
+MOVU_mr		0101 1 sz:1 00 rs:4 rd:4		dsp=0
+# MOVU.<bw> dsp8[rs], rd
+MOVU_mr		0101 1 sz:1 01 rs:4 rd:4 dsp:8
+# MOVU.<bw> dsp16[rs], rd
+MOVU_mr		0101 1 sz:1 10 rs:4 rd:4 .... .... .... .... dsp=%b4_dsp_16
+# MOVU.<bw> rs, rd
+MOVU_rr		0101 1 sz:1 11 rs:4 rd:4
+# MOVU.<bw> [ri, rb], rd
+MOVU_ar		1111 1110 110 sz:1 ri:4 rb:4 rd:4
+# MOVU.<bw> [rs+], rd
+MOVU_pr		1111 1101 0011 1 ad:1 0 sz:1 rd:4 rs:4
+
+# MUL #uimm4, rd
+MUL_ir		0110 0011 .... ....			@b2_rds_uimm4
+# MUL #imm4, rd
+MUL_ir		0111 01.. 0001 ....			@b2_rds_li
+# MUL dsp[rs].ub, rd
+# MUL rs, rd
+MUL_mr		0100 11.. .... ....			@b2_rd_ld_ub
+# MUL dsp[rs], rd
+MUL_mr		0000 0110 ..00 11.. .... ....		@b3_rd_ld
+# MOV rs, rs2, rd
+MUL_rrr		1111 1111 0011 .... .... ....		@b3_rd_rs_rs2
+
+# MULHI rs, rs2
+MULHI		1111 1101 0000 0000 rs:4 rs2:4
+# MULLO rs, rs2
+MULLO		1111 1101 0000 0001 rs:4 rs2:4
+
+# MVFACHI rd
+MVFACHI		1111 1101 0001 1111 0000 rd:4
+# MVFACMI rd
+MVFACMI		1111 1101 0001 1111 0010 rd:4
+
+# MVFC cr, rd
+MVFC		1111 1101 0110 1010 cr:4 rd:4
+
+# MVTACHI rs
+MVTACHI		1111 1101 0001 0111 0000 rs:4
+# MVTACLO rs
+MVTACLO		1111 1101 0001 0111 0001 rs:4
+
+# MVTC #imm, cr
+MVTC_i		1111 1101 0111 ..11 0000 cr:4		imm=%b3_li_10
+# MVTC rs, cr
+MVTC_r		1111 1101 0110 1000 rs:4 cr:4
+
+# MVTIPL #imm
+MVTIPL		0111 0101 0111 0000 0000 imm:4
+
+# NEG rd
+NEG_rr		0111 1110 0001 ....			@b2_rds
+# NEG rs, rd
+NEG_rr		1111 1100 0000 0111 .... ....		@b3_rd_rs
+
+NOP		0000 0011
+
+# NOT rd
+NOT_rr		0111 1110 0000 ....			@b2_rds
+# NOT rs, rd
+NOT_rr		1111 1100 0011 1011 .... ....		@b3_rd_rs
+
+# OR #uimm4, rd
+OR_ir		0110 0101 .... ....			@b2_rds_uimm4
+# OR #imm, rd
+OR_ir		0111 01.. 0011 ....			@b2_rds_li
+# OR dsp[rs].ub, rd
+# OR rs, rd
+OR_mr		0101 01.. .... ....			@b2_rd_ld_ub
+# OR dsp[rs], rd
+OR_mr		0000 0110 .. 0101 .. .... ....		@b3_rd_ld
+# OR rs, rs2, rd
+OR_rrr		1111 1111 0101 .... .... ....		@b3_rd_rs_rs2
+
+# POP cr
+POPC		0111 1110 1110 cr:4
+# POP rd-rd2
+POPM		0110 1111 rd:4 rd2:4
+
+# POP rd
+# PUSH.<bwl> rs
+{
+  POP		0111 1110 1011 rd:4
+  PUSH_r	0111 1110 10 sz:2 rs:4
+}
+# PUSH.<bwl> dsp[rs]
+PUSH_m		1111 01 ld:2 rs:4 10 sz:2
+# PUSH cr
+PUSHC		0111 1110 1100 cr:4
+# PUSHM rs-rs2
+PUSHM		0110 1110 rs:4 rs2:4
+
+# RACW #imm
+RACW		1111 1101 0001 1000 000 imm:1 0000
+
+# REVL rs,rd
+REVL		1111 1101 0110 0111 .... ....		@b3_rd_rs
+# REVW rs,rd
+REVW		1111 1101 0110 0101 .... ....		@b3_rd_rs
+
+# SMOVF
+# RPMA.<bwl>
+{
+  SMOVF		0111 1111 1000 1111
+  RMPA		0111 1111 1000 11 sz:2
+}
+
+# ROLC rd
+ROLC		0111 1110 0101 ....			@b2_rds
+# RORC rd
+RORC		0111 1110 0100 ....			@b2_rds
+
+# ROTL #imm, rd
+ROTL_ir		1111 1101 0110 111. .... ....		@b3_rds_imm5
+# ROTL rs, rd
+ROTL_rr		1111 1101 0110 0110 .... ....		@b3_rd_rs
+
+# ROTR #imm, rd
+ROTR_ir		1111 1101 0110 110. .... ....		@b3_rds_imm5
+# ROTR #imm, rd
+ROTR_rr		1111 1101 0110 0100 .... ....		@b3_rd_rs
+
+# ROUND rs,rd
+# ROUND dsp[rs],rd
+ROUND		1111 1100 1001 10 .. .... ....		@b3_ld_rd_rs
+
+RTE		0111 1111 1001 0101
+
+RTFI		0111 1111 1001 0100
+
+RTS		0000 0010
+
+# RTSD #imm
+RTSD_i		0110 0111 imm:8
+# RTSD #imm, rd-rd2
+RTSD_irr	0011 1111 rd:4 rd2:4 imm:8
+
+# SAT rd
+SAT		0111 1110 0011 ....			@b2_rds
+# SATR
+SATR		0111 1111 1001 0011
+
+# SBB rs, rd
+SBB_rr		1111 1100 0000 0011 .... ....		@b3_rd_rs
+# SBB dsp[rs].l, rd
+# Note only mi==2 allowed.
+SBB_mr		0000 0110 ..10 00.. 0000 0000 .... ....	@b4_rd_ldmi
+
+# SCCnd dsp[rd]
+# SCCnd rd
+SCCnd		1111 1100 1101 .... .... ....		@b3_sz_ld_rd_cd
+
+# SETPSW psw
+SETPSW		0111 1111 1010 cb:4
+
+# SHAR #imm, rd
+SHAR_irr	0110 101. .... ....			@b2_rds_imm5
+# SHAR #imm, rs, rd
+SHAR_irr	1111 1101 101. .... .... ....		@b3_rd_rs_imm5
+# SHAR rs, rd
+SHAR_rr		1111 1101 0110 0001 .... ....		@b3_rd_rs
+
+# SHLL #imm, rd
+SHLL_irr	0110 110. .... ....			@b2_rds_imm5
+# SHLL #imm, rs, rd
+SHLL_irr	1111 1101 110. .... .... ....		@b3_rd_rs_imm5
+# SHLL rs, rd
+SHLL_rr		1111 1101 0110 0010 .... ....		@b3_rd_rs
+
+# SHLR #imm, rd
+SHLR_irr	0110 100. .... ....			@b2_rds_imm5
+# SHLR #imm, rs, rd
+SHLR_irr	1111 1101 100. .... .... ....		@b3_rd_rs_imm5
+# SHLR rs, rd
+SHLR_rr		1111 1101 0110 0000 .... ....		@b3_rd_rs
+
+# SMOVB
+# SSTR.<bwl>
+{
+  SMOVB		0111 1111 1000 1011
+  SSTR		0111 1111 1000 10 sz:2
+}
+
+# STNZ #imm, rd
+STNZ		1111 1101 0111 ..00 1111 ....		@b3_rd_li
+# STZ #imm, rd
+STZ		1111 1101 0111 ..00 1110 ....		@b3_rd_li
+
+# SUB #uimm4, rd
+SUB_ir		0110 0000 .... ....			@b2_rds_uimm4
+# SUB dsp[rs].ub, rd
+# SUB rs, rd
+SUB_mr		0100 00.. .... ....			@b2_rd_ld_ub
+# SUB dsp[rs], rd
+SUB_mr		0000 0110 ..00 00.. .... ....		@b3_rd_ld
+# SUB rs, rs2, rd
+SUB_rrr		1111 1111 0000 .... .... ....		@b3_rd_rs_rs2
+
+# SCMPU
+# SUNTIL.<bwl>
+{
+  SCMPU		0111 1111 1000 0011
+  SUNTIL	0111 1111 1000 00 sz:2
+}
+
+# SMOVU
+# SWHILE.<bwl>
+{
+  SMOVU		0111 1111 1000 0111
+  SWHILE	0111 1111 1000 01 sz:2
+}
+
+# TST #imm, rd
+TST_ir		1111 1101 0111 ..00 1100 ....		@b3_rd_li
+# TST dsp[rs].ub, rd
+# TST rs, rd
+TST_mr		1111 1100 0011 00.. .... ....		@b3_rd_ld_ub
+# TST dsp[rs], rd
+TST_mr		0000 0110 ..10 00.. 0000 1100 .... .... @b4_rd_ldmi
+
+WAIT		0111 1111 1001 0110
+
+# XCHG rs, rd
+# XCHG dsp[rs].ub, rd
+{
+  XCHG_rr		1111 1100 0100 0011 .... ....		@b3_rd_rs
+  XCHG_mr		1111 1100 0100 00.. .... ....		@b3_rd_ld_ub
+}
+# XCHG dsp[rs], rd
+XCHG_mr		0000 0110 ..10 00.. 0001 0000 .... ....	@b4_rd_ldmi
+
+# XOR #imm, rd
+XOR_ir		1111 1101 0111 ..00 1101 ....		@b3_rd_li
+# XOR dsp[rs].ub, rd
+# XOR rs, rd
+XOR_mr		1111 1100 0011 01.. .... ....		@b3_rd_ld_ub
+# XOR dsp[rs], rd
+XOR_mr		0000 0110 ..10 00.. 0000 1101 .... ....	@b4_rd_ldmi
diff --git a/target/rx/translate.c b/target/rx/translate.c
new file mode 100644
index 0000000000..6b52424d0f
--- /dev/null
+++ b/target/rx/translate.c
@@ -0,0 +1,2432 @@
+/*
+ *  RX translation
+ *
+ *  Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "qemu/qemu-print.h"
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "tcg/tcg-op.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "exec/helper-gen.h"
+#include "exec/translator.h"
+#include "trace-tcg.h"
+#include "exec/log.h"
+
+typedef struct DisasContext {
+    DisasContextBase base;
+    CPURXState *env;
+    uint32_t pc;
+} DisasContext;
+
+typedef struct DisasCompare {
+    TCGv value;
+    TCGv temp;
+    TCGCond cond;
+} DisasCompare;
+
+const char rx_crname[][6] = {
+    "psw", "pc", "usp", "fpsw", "", "", "", "",
+    "bpsw", "bpc", "isp", "fintv", "intb", "", "", "",
+};
+
+/* Target-specific values for dc->base.is_jmp.  */
+#define DISAS_JUMP    DISAS_TARGET_0
+#define DISAS_UPDATE  DISAS_TARGET_1
+#define DISAS_EXIT    DISAS_TARGET_2
+
+/* global register indexes */
+static TCGv cpu_regs[16];
+static TCGv cpu_psw_o, cpu_psw_s, cpu_psw_z, cpu_psw_c;
+static TCGv cpu_psw_i, cpu_psw_pm, cpu_psw_u, cpu_psw_ipl;
+static TCGv cpu_usp, cpu_fpsw, cpu_bpsw, cpu_bpc, cpu_isp;
+static TCGv cpu_fintv, cpu_intb, cpu_pc;
+static TCGv_i64 cpu_acc;
+
+#define cpu_sp cpu_regs[0]
+
+#include "exec/gen-icount.h"
+
+/* decoder helper */
+static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
+                           int i, int n)
+{
+    while (++i <= n) {
+        uint8_t b = cpu_ldub_code(ctx->env, ctx->base.pc_next++);
+        insn |= b << (32 - i * 8);
+    }
+    return insn;
+}
+
+static uint32_t li(DisasContext *ctx, int sz)
+{
+    int32_t tmp, addr;
+    CPURXState *env = ctx->env;
+    addr = ctx->base.pc_next;
+
+    tcg_debug_assert(sz < 4);
+    switch (sz) {
+    case 1:
+        ctx->base.pc_next += 1;
+        return cpu_ldsb_code(env, addr);
+    case 2:
+        ctx->base.pc_next += 2;
+        return cpu_ldsw_code(env, addr);
+    case 3:
+        ctx->base.pc_next += 3;
+        tmp = cpu_ldsb_code(env, addr + 2) << 16;
+        tmp |= cpu_lduw_code(env, addr) & 0xffff;
+        return tmp;
+    case 0:
+        ctx->base.pc_next += 4;
+        return cpu_ldl_code(env, addr);
+    }
+    return 0;
+}
+
+static int bdsp_s(DisasContext *ctx, int d)
+{
+    /*
+     * 0 -> 8
+     * 1 -> 9
+     * 2 -> 10
+     * 3 -> 3
+     * :
+     * 7 -> 7
+     */
+    if (d < 3) {
+        d += 8;
+    }
+    return d;
+}
+
+/* Include the auto-generated decoder. */
+#include "decode.inc.c"
+
+void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
+{
+    RXCPU *cpu = RXCPU(cs);
+    CPURXState *env = &cpu->env;
+    int i;
+    uint32_t psw;
+
+    psw = rx_cpu_pack_psw(env);
+    qemu_fprintf(f, "pc=0x%08x psw=0x%08x\n",
+                 env->pc, psw);
+    for (i = 0; i < 16; i += 4) {
+        qemu_fprintf(f, "r%d=0x%08x r%d=0x%08x r%d=0x%08x r%d=0x%08x\n",
+                     i, env->regs[i], i + 1, env->regs[i + 1],
+                     i + 2, env->regs[i + 2], i + 3, env->regs[i + 3]);
+    }
+}
+
+static bool use_goto_tb(DisasContext *dc, target_ulong dest)
+{
+    if (unlikely(dc->base.singlestep_enabled)) {
+        return false;
+    } else {
+        return true;
+    }
+}
+
+static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
+{
+    if (use_goto_tb(dc, dest)) {
+        tcg_gen_goto_tb(n);
+        tcg_gen_movi_i32(cpu_pc, dest);
+        tcg_gen_exit_tb(dc->base.tb, n);
+    } else {
+        tcg_gen_movi_i32(cpu_pc, dest);
+        if (dc->base.singlestep_enabled) {
+            gen_helper_debug(cpu_env);
+        } else {
+            tcg_gen_lookup_and_goto_ptr();
+        }
+    }
+    dc->base.is_jmp = DISAS_NORETURN;
+}
+
+/* generic load wrapper */
+static inline void rx_gen_ld(unsigned int size, TCGv reg, TCGv mem)
+{
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_SIGN | MO_TE);
+}
+
+/* unsigned load wrapper */
+static inline void rx_gen_ldu(unsigned int size, TCGv reg, TCGv mem)
+{
+    tcg_gen_qemu_ld_i32(reg, mem, 0, size | MO_TE);
+}
+
+/* generic store wrapper */
+static inline void rx_gen_st(unsigned int size, TCGv reg, TCGv mem)
+{
+    tcg_gen_qemu_st_i32(reg, mem, 0, size | MO_TE);
+}
+
+/* [ri, rb] */
+static inline void rx_gen_regindex(DisasContext *ctx, TCGv mem,
+                                   int size, int ri, int rb)
+{
+    tcg_gen_shli_i32(mem, cpu_regs[ri], size);
+    tcg_gen_add_i32(mem, mem, cpu_regs[rb]);
+}
+
+/* dsp[reg] */
+static inline TCGv rx_index_addr(DisasContext *ctx, TCGv mem,
+                                 int ld, int size, int reg)
+{
+    uint32_t dsp;
+
+    tcg_debug_assert(ld < 3);
+    switch (ld) {
+    case 0:
+        return cpu_regs[reg];
+    case 1:
+        dsp = cpu_ldub_code(ctx->env, ctx->base.pc_next) << size;
+        tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
+        ctx->base.pc_next += 1;
+        return mem;
+    case 2:
+        dsp = cpu_lduw_code(ctx->env, ctx->base.pc_next) << size;
+        tcg_gen_addi_i32(mem, cpu_regs[reg], dsp);
+        ctx->base.pc_next += 2;
+        return mem;
+    }
+    return NULL;
+}
+
+static inline MemOp mi_to_mop(unsigned mi)
+{
+    static const MemOp mop[5] = { MO_SB, MO_SW, MO_UL, MO_UW, MO_UB };
+    tcg_debug_assert(mi < 5);
+    return mop[mi];
+}
+
+/* load source operand */
+static inline TCGv rx_load_source(DisasContext *ctx, TCGv mem,
+                                  int ld, int mi, int rs)
+{
+    TCGv addr;
+    MemOp mop;
+    if (ld < 3) {
+        mop = mi_to_mop(mi);
+        addr = rx_index_addr(ctx, mem, ld, mop & MO_SIZE, rs);
+        tcg_gen_qemu_ld_i32(mem, addr, 0, mop | MO_TE);
+        return mem;
+    } else {
+        return cpu_regs[rs];
+    }
+}
+
+/* Processor mode check */
+static int is_privileged(DisasContext *ctx, int is_exception)
+{
+    if (FIELD_EX32(ctx->base.tb->flags, PSW, PM)) {
+        if (is_exception) {
+            gen_helper_raise_privilege_violation(cpu_env);
+        }
+        return 0;
+    } else {
+        return 1;
+    }
+}
+
+/* generate QEMU condition */
+static void psw_cond(DisasCompare *dc, uint32_t cond)
+{
+    tcg_debug_assert(cond < 16);
+    switch (cond) {
+    case 0: /* z */
+        dc->cond = TCG_COND_EQ;
+        dc->value = cpu_psw_z;
+        break;
+    case 1: /* nz */
+        dc->cond = TCG_COND_NE;
+        dc->value = cpu_psw_z;
+        break;
+    case 2: /* c */
+        dc->cond = TCG_COND_NE;
+        dc->value = cpu_psw_c;
+        break;
+    case 3: /* nc */
+        dc->cond = TCG_COND_EQ;
+        dc->value = cpu_psw_c;
+        break;
+    case 4: /* gtu (C& ~Z) == 1 */
+    case 5: /* leu (C& ~Z) == 0 */
+        tcg_gen_setcondi_i32(TCG_COND_NE, dc->temp, cpu_psw_z, 0);
+        tcg_gen_and_i32(dc->temp, dc->temp, cpu_psw_c);
+        dc->cond = (cond == 4) ? TCG_COND_NE : TCG_COND_EQ;
+        dc->value = dc->temp;
+        break;
+    case 6: /* pz (S == 0) */
+        dc->cond = TCG_COND_GE;
+        dc->value = cpu_psw_s;
+        break;
+    case 7: /* n (S == 1) */
+        dc->cond = TCG_COND_LT;
+        dc->value = cpu_psw_s;
+        break;
+    case 8: /* ge (S^O)==0 */
+    case 9: /* lt (S^O)==1 */
+        tcg_gen_xor_i32(dc->temp, cpu_psw_o, cpu_psw_s);
+        dc->cond = (cond == 8) ? TCG_COND_GE : TCG_COND_LT;
+        dc->value = dc->temp;
+        break;
+    case 10: /* gt ((S^O)|Z)==0 */
+    case 11: /* le ((S^O)|Z)==1 */
+        tcg_gen_xor_i32(dc->temp, cpu_psw_o, cpu_psw_s);
+        tcg_gen_sari_i32(dc->temp, dc->temp, 31);
+        tcg_gen_andc_i32(dc->temp, cpu_psw_z, dc->temp);
+        dc->cond = (cond == 10) ? TCG_COND_NE : TCG_COND_EQ;
+        dc->value = dc->temp;
+        break;
+    case 12: /* o */
+        dc->cond = TCG_COND_LT;
+        dc->value = cpu_psw_o;
+        break;
+    case 13: /* no */
+        dc->cond = TCG_COND_GE;
+        dc->value = cpu_psw_o;
+        break;
+    case 14: /* always true */
+        dc->cond = TCG_COND_ALWAYS;
+        dc->value = dc->temp;
+        break;
+    case 15: /* always false */
+        dc->cond = TCG_COND_NEVER;
+        dc->value = dc->temp;
+        break;
+    }
+}
+
+static void move_from_cr(TCGv ret, int cr, uint32_t pc)
+{
+    TCGv z = tcg_const_i32(0);
+    switch (cr) {
+    case 0:     /* PSW */
+        gen_helper_pack_psw(ret, cpu_env);
+        break;
+    case 1:     /* PC */
+        tcg_gen_movi_i32(ret, pc);
+        break;
+    case 2:     /* USP */
+        tcg_gen_movcond_i32(TCG_COND_NE, ret,
+                            cpu_psw_u, z, cpu_sp, cpu_usp);
+        break;
+    case 3:     /* FPSW */
+        tcg_gen_mov_i32(ret, cpu_fpsw);
+        break;
+    case 8:     /* BPSW */
+        tcg_gen_mov_i32(ret, cpu_bpsw);
+        break;
+    case 9:     /* BPC */
+        tcg_gen_mov_i32(ret, cpu_bpc);
+        break;
+    case 10:    /* ISP */
+        tcg_gen_movcond_i32(TCG_COND_EQ, ret,
+                            cpu_psw_u, z, cpu_sp, cpu_isp);
+        break;
+    case 11:    /* FINTV */
+        tcg_gen_mov_i32(ret, cpu_fintv);
+        break;
+    case 12:    /* INTB */
+        tcg_gen_mov_i32(ret, cpu_intb);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "Unimplement control register %d", cr);
+        /* Unimplement registers return 0 */
+        tcg_gen_movi_i32(ret, 0);
+        break;
+    }
+    tcg_temp_free(z);
+}
+
+static void move_to_cr(DisasContext *ctx, TCGv val, int cr)
+{
+    TCGv z;
+    if (cr >= 8 && !is_privileged(ctx, 0)) {
+        /* Some control registers can only be written in privileged mode. */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "disallow control register write %s", rx_crname[cr]);
+        return;
+    }
+    z = tcg_const_i32(0);
+    switch (cr) {
+    case 0:     /* PSW */
+        gen_helper_set_psw(cpu_env, val);
+        break;
+    /* case 1: to PC not supported */
+    case 2:     /* USP */
+        tcg_gen_mov_i32(cpu_usp, val);
+        tcg_gen_movcond_i32(TCG_COND_NE, cpu_sp,
+                            cpu_psw_u, z,  cpu_usp, cpu_sp);
+        break;
+    case 3:     /* FPSW */
+        gen_helper_set_fpsw(cpu_env, val);
+        break;
+    case 8:     /* BPSW */
+        tcg_gen_mov_i32(cpu_bpsw, val);
+        break;
+    case 9:     /* BPC */
+        tcg_gen_mov_i32(cpu_bpc, val);
+        break;
+    case 10:    /* ISP */
+        tcg_gen_mov_i32(cpu_isp, val);
+        /* if PSW.U is 0, copy isp to r0 */
+        tcg_gen_movcond_i32(TCG_COND_EQ, cpu_sp,
+                            cpu_psw_u, z,  cpu_isp, cpu_sp);
+        break;
+    case 11:    /* FINTV */
+        tcg_gen_mov_i32(cpu_fintv, val);
+        break;
+    case 12:    /* INTB */
+        tcg_gen_mov_i32(cpu_intb, val);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Unimplement control register %d", cr);
+        break;
+    }
+    tcg_temp_free(z);
+}
+
+static void push(TCGv val)
+{
+    tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+    rx_gen_st(MO_32, val, cpu_sp);
+}
+
+static void pop(TCGv ret)
+{
+    rx_gen_ld(MO_32, ret, cpu_sp);
+    tcg_gen_addi_i32(cpu_sp, cpu_sp, 4);
+}
+
+/* mov.<bwl> rs,dsp5[rd] */
+static bool trans_MOV_rm(DisasContext *ctx, arg_MOV_rm *a)
+{
+    TCGv mem;
+    mem = tcg_temp_new();
+    tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
+    rx_gen_st(a->sz, cpu_regs[a->rs], mem);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* mov.<bwl> dsp5[rs],rd */
+static bool trans_MOV_mr(DisasContext *ctx, arg_MOV_mr *a)
+{
+    TCGv mem;
+    mem = tcg_temp_new();
+    tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
+    rx_gen_ld(a->sz, cpu_regs[a->rd], mem);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* mov.l #uimm4,rd */
+/* mov.l #uimm8,rd */
+/* mov.l #imm,rd */
+static bool trans_MOV_ir(DisasContext *ctx, arg_MOV_ir *a)
+{
+    tcg_gen_movi_i32(cpu_regs[a->rd], a->imm);
+    return true;
+}
+
+/* mov.<bwl> #uimm8,dsp[rd] */
+/* mov.<bwl> #imm, dsp[rd] */
+static bool trans_MOV_im(DisasContext *ctx, arg_MOV_im *a)
+{
+    TCGv imm, mem;
+    imm = tcg_const_i32(a->imm);
+    mem = tcg_temp_new();
+    tcg_gen_addi_i32(mem, cpu_regs[a->rd], a->dsp << a->sz);
+    rx_gen_st(a->sz, imm, mem);
+    tcg_temp_free(imm);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* mov.<bwl> [ri,rb],rd */
+static bool trans_MOV_ar(DisasContext *ctx, arg_MOV_ar *a)
+{
+    TCGv mem;
+    mem = tcg_temp_new();
+    rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
+    rx_gen_ld(a->sz, cpu_regs[a->rd], mem);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* mov.<bwl> rd,[ri,rb] */
+static bool trans_MOV_ra(DisasContext *ctx, arg_MOV_ra *a)
+{
+    TCGv mem;
+    mem = tcg_temp_new();
+    rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
+    rx_gen_st(a->sz, cpu_regs[a->rs], mem);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* mov.<bwl> dsp[rs],dsp[rd] */
+/* mov.<bwl> rs,dsp[rd] */
+/* mov.<bwl> dsp[rs],rd */
+/* mov.<bwl> rs,rd */
+static bool trans_MOV_mm(DisasContext *ctx, arg_MOV_mm *a)
+{
+    static void (* const mov[])(TCGv ret, TCGv arg) = {
+        tcg_gen_ext8s_i32, tcg_gen_ext16s_i32, tcg_gen_mov_i32,
+    };
+    TCGv tmp, mem, addr;
+    if (a->lds == 3 && a->ldd == 3) {
+        /* mov.<bwl> rs,rd */
+        mov[a->sz](cpu_regs[a->rd], cpu_regs[a->rs]);
+        return true;
+    }
+
+    mem = tcg_temp_new();
+    if (a->lds == 3) {
+        /* mov.<bwl> rs,dsp[rd] */
+        addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rs);
+        rx_gen_st(a->sz, cpu_regs[a->rd], addr);
+    } else if (a->ldd == 3) {
+        /* mov.<bwl> dsp[rs],rd */
+        addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
+        rx_gen_ld(a->sz, cpu_regs[a->rd], addr);
+    } else {
+        /* mov.<bwl> dsp[rs],dsp[rd] */
+        tmp = tcg_temp_new();
+        addr = rx_index_addr(ctx, mem, a->lds, a->sz, a->rs);
+        rx_gen_ld(a->sz, tmp, addr);
+        addr = rx_index_addr(ctx, mem, a->ldd, a->sz, a->rd);
+        rx_gen_st(a->sz, tmp, addr);
+        tcg_temp_free(tmp);
+    }
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* mov.<bwl> rs,[rd+] */
+/* mov.<bwl> rs,[-rd] */
+static bool trans_MOV_rp(DisasContext *ctx, arg_MOV_rp *a)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    tcg_gen_mov_i32(val, cpu_regs[a->rs]);
+    if (a->ad == 1) {
+        tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
+    }
+    rx_gen_st(a->sz, val, cpu_regs[a->rd]);
+    if (a->ad == 0) {
+        tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
+    }
+    tcg_temp_free(val);
+    return true;
+}
+
+/* mov.<bwl> [rd+],rs */
+/* mov.<bwl> [-rd],rs */
+static bool trans_MOV_pr(DisasContext *ctx, arg_MOV_pr *a)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    if (a->ad == 1) {
+        tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
+    }
+    rx_gen_ld(a->sz, val, cpu_regs[a->rd]);
+    if (a->ad == 0) {
+        tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
+    }
+    tcg_gen_mov_i32(cpu_regs[a->rs], val);
+    tcg_temp_free(val);
+    return true;
+}
+
+/* movu.<bw> dsp5[rs],rd */
+/* movu.<bw> dsp[rs],rd */
+static bool trans_MOVU_mr(DisasContext *ctx, arg_MOVU_mr *a)
+{
+    TCGv mem;
+    mem = tcg_temp_new();
+    tcg_gen_addi_i32(mem, cpu_regs[a->rs], a->dsp << a->sz);
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], mem);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* movu.<bw> rs,rd */
+static bool trans_MOVU_rr(DisasContext *ctx, arg_MOVU_rr *a)
+{
+    static void (* const ext[])(TCGv ret, TCGv arg) = {
+        tcg_gen_ext8u_i32, tcg_gen_ext16u_i32,
+    };
+    ext[a->sz](cpu_regs[a->rd], cpu_regs[a->rs]);
+    return true;
+}
+
+/* movu.<bw> [ri,rb],rd */
+static bool trans_MOVU_ar(DisasContext *ctx, arg_MOVU_ar *a)
+{
+    TCGv mem;
+    mem = tcg_temp_new();
+    rx_gen_regindex(ctx, mem, a->sz, a->ri, a->rb);
+    rx_gen_ldu(a->sz, cpu_regs[a->rd], mem);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* movu.<bw> [rd+],rs */
+/* mov.<bw> [-rd],rs */
+static bool trans_MOVU_pr(DisasContext *ctx, arg_MOVU_pr *a)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    if (a->ad == 1) {
+        tcg_gen_subi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
+    }
+    rx_gen_ldu(a->sz, val, cpu_regs[a->rd]);
+    if (a->ad == 0) {
+        tcg_gen_addi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1 << a->sz);
+    }
+    tcg_gen_mov_i32(cpu_regs[a->rs], val);
+    tcg_temp_free(val);
+    return true;
+}
+
+
+/* pop rd */
+static bool trans_POP(DisasContext *ctx, arg_POP *a)
+{
+    /* mov.l [r0+], rd */
+    arg_MOV_rp mov_a;
+    mov_a.rd = 0;
+    mov_a.rs = a->rd;
+    mov_a.ad = 0;
+    mov_a.sz = MO_32;
+    trans_MOV_pr(ctx, &mov_a);
+    return true;
+}
+
+/* popc cr */
+static bool trans_POPC(DisasContext *ctx, arg_POPC *a)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    pop(val);
+    move_to_cr(ctx, val, a->cr);
+    if (a->cr == 0 && is_privileged(ctx, 0)) {
+        /* PSW.I may be updated here. exit TB. */
+        ctx->base.is_jmp = DISAS_UPDATE;
+    }
+    tcg_temp_free(val);
+    return true;
+}
+
+/* popm rd-rd2 */
+static bool trans_POPM(DisasContext *ctx, arg_POPM *a)
+{
+    int r;
+    if (a->rd == 0 || a->rd >= a->rd2) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid  register ranges r%d-r%d", a->rd, a->rd2);
+    }
+    r = a->rd;
+    while (r <= a->rd2 && r < 16) {
+        pop(cpu_regs[r++]);
+    }
+    return true;
+}
+
+
+/* push.<bwl> rs */
+static bool trans_PUSH_r(DisasContext *ctx, arg_PUSH_r *a)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    tcg_gen_mov_i32(val, cpu_regs[a->rs]);
+    tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+    rx_gen_st(a->sz, val, cpu_sp);
+    tcg_temp_free(val);
+    return true;
+}
+
+/* push.<bwl> dsp[rs] */
+static bool trans_PUSH_m(DisasContext *ctx, arg_PUSH_m *a)
+{
+    TCGv mem, val, addr;
+    mem = tcg_temp_new();
+    val = tcg_temp_new();
+    addr = rx_index_addr(ctx, mem, a->ld, a->sz, a->rs);
+    rx_gen_ld(a->sz, val, addr);
+    tcg_gen_subi_i32(cpu_sp, cpu_sp, 4);
+    rx_gen_st(a->sz, val, cpu_sp);
+    tcg_temp_free(mem);
+    tcg_temp_free(val);
+    return true;
+}
+
+/* pushc rx */
+static bool trans_PUSHC(DisasContext *ctx, arg_PUSHC *a)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    move_from_cr(val, a->cr, ctx->pc);
+    push(val);
+    tcg_temp_free(val);
+    return true;
+}
+
+/* pushm rs-rs2 */
+static bool trans_PUSHM(DisasContext *ctx, arg_PUSHM *a)
+{
+    int r;
+
+    if (a->rs == 0 || a->rs >= a->rs2) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid  register ranges r%d-r%d", a->rs, a->rs2);
+    }
+    r = a->rs2;
+    while (r >= a->rs && r >= 0) {
+        push(cpu_regs[r--]);
+    }
+    return true;
+}
+
+/* xchg rs,rd */
+static bool trans_XCHG_rr(DisasContext *ctx, arg_XCHG_rr *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_mov_i32(tmp, cpu_regs[a->rs]);
+    tcg_gen_mov_i32(cpu_regs[a->rs], cpu_regs[a->rd]);
+    tcg_gen_mov_i32(cpu_regs[a->rd], tmp);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* xchg dsp[rs].<mi>,rd */
+static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
+{
+    TCGv mem, addr;
+    mem = tcg_temp_new();
+    switch (a->mi) {
+    case 0: /* dsp[rs].b */
+    case 1: /* dsp[rs].w */
+    case 2: /* dsp[rs].l */
+        addr = rx_index_addr(ctx, mem, a->ld, a->mi, a->rs);
+        break;
+    case 3: /* dsp[rs].uw */
+    case 4: /* dsp[rs].ub */
+        addr = rx_index_addr(ctx, mem, a->ld, 4 - a->mi, a->rs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_atomic_xchg_i32(cpu_regs[a->rd], addr, cpu_regs[a->rd],
+                            0, mi_to_mop(a->mi));
+    tcg_temp_free(mem);
+    return true;
+}
+
+static inline void stcond(TCGCond cond, int rd, int imm)
+{
+    TCGv z;
+    TCGv _imm;
+    z = tcg_const_i32(0);
+    _imm = tcg_const_i32(imm);
+    tcg_gen_movcond_i32(cond, cpu_regs[rd], cpu_psw_z, z,
+                        _imm, cpu_regs[rd]);
+    tcg_temp_free(z);
+    tcg_temp_free(_imm);
+}
+
+/* stz #imm,rd */
+static bool trans_STZ(DisasContext *ctx, arg_STZ *a)
+{
+    stcond(TCG_COND_EQ, a->rd, a->imm);
+    return true;
+}
+
+/* stnz #imm,rd */
+static bool trans_STNZ(DisasContext *ctx, arg_STNZ *a)
+{
+    stcond(TCG_COND_NE, a->rd, a->imm);
+    return true;
+}
+
+/* sccnd.<bwl> rd */
+/* sccnd.<bwl> dsp:[rd] */
+static bool trans_SCCnd(DisasContext *ctx, arg_SCCnd *a)
+{
+    DisasCompare dc;
+    TCGv val, mem, addr;
+    dc.temp = tcg_temp_new();
+    psw_cond(&dc, a->cd);
+    if (a->ld < 3) {
+        val = tcg_temp_new();
+        mem = tcg_temp_new();
+        tcg_gen_setcondi_i32(dc.cond, val, dc.value, 0);
+        addr = rx_index_addr(ctx, mem, a->sz, a->ld, a->rd);
+        rx_gen_st(a->sz, val, addr);
+        tcg_temp_free(val);
+        tcg_temp_free(mem);
+    } else {
+        tcg_gen_setcondi_i32(dc.cond, cpu_regs[a->rd], dc.value, 0);
+    }
+    tcg_temp_free(dc.temp);
+    return true;
+}
+
+/* rtsd #imm */
+static bool trans_RTSD_i(DisasContext *ctx, arg_RTSD_i *a)
+{
+    tcg_gen_addi_i32(cpu_sp, cpu_sp, a->imm  << 2);
+    pop(cpu_pc);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* rtsd #imm, rd-rd2 */
+static bool trans_RTSD_irr(DisasContext *ctx, arg_RTSD_irr *a)
+{
+    int dst;
+    int adj;
+
+    if (a->rd2 >= a->rd) {
+        adj = a->imm - (a->rd2 - a->rd + 1);
+    } else {
+        adj = a->imm - (15 - a->rd + 1);
+    }
+
+    tcg_gen_addi_i32(cpu_sp, cpu_sp, adj << 2);
+    dst = a->rd;
+    while (dst <= a->rd2 && dst < 16) {
+        pop(cpu_regs[dst++]);
+    }
+    pop(cpu_pc);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+typedef void (*op2fn)(TCGv ret, TCGv arg1);
+typedef void (*op3fn)(TCGv ret, TCGv arg1, TCGv arg2);
+
+static inline void rx_gen_op_rr(op2fn opr, int dst, int src)
+{
+    opr(cpu_regs[dst], cpu_regs[src]);
+}
+
+static inline void rx_gen_op_rrr(op3fn opr, int dst, int src, int src2)
+{
+    opr(cpu_regs[dst], cpu_regs[src], cpu_regs[src2]);
+}
+
+static inline void rx_gen_op_irr(op3fn opr, int dst, int src, uint32_t src2)
+{
+    TCGv imm = tcg_const_i32(src2);
+    opr(cpu_regs[dst], cpu_regs[src], imm);
+    tcg_temp_free(imm);
+}
+
+static inline void rx_gen_op_mr(op3fn opr, DisasContext *ctx,
+                                int dst, int src, int ld, int mi)
+{
+    TCGv val, mem;
+    mem = tcg_temp_new();
+    val = rx_load_source(ctx, mem, ld, mi, src);
+    opr(cpu_regs[dst], cpu_regs[dst], val);
+    tcg_temp_free(mem);
+}
+
+static void rx_and(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    tcg_gen_and_i32(cpu_psw_s, arg1, arg2);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+    tcg_gen_mov_i32(ret, cpu_psw_s);
+}
+
+/* and #uimm:4, rd */
+/* and #imm, rd */
+static bool trans_AND_ir(DisasContext *ctx, arg_AND_ir *a)
+{
+    rx_gen_op_irr(rx_and, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* and dsp[rs], rd */
+/* and rs,rd */
+static bool trans_AND_mr(DisasContext *ctx, arg_AND_mr *a)
+{
+    rx_gen_op_mr(rx_and, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* and rs,rs2,rd */
+static bool trans_AND_rrr(DisasContext *ctx, arg_AND_rrr *a)
+{
+    rx_gen_op_rrr(rx_and, a->rd, a->rs, a->rs2);
+    return true;
+}
+
+static void rx_or(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    tcg_gen_or_i32(cpu_psw_s, arg1, arg2);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+    tcg_gen_mov_i32(ret, cpu_psw_s);
+}
+
+/* or #uimm:4, rd */
+/* or #imm, rd */
+static bool trans_OR_ir(DisasContext *ctx, arg_OR_ir *a)
+{
+    rx_gen_op_irr(rx_or, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* or dsp[rs], rd */
+/* or rs,rd */
+static bool trans_OR_mr(DisasContext *ctx, arg_OR_mr *a)
+{
+    rx_gen_op_mr(rx_or, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* or rs,rs2,rd */
+static bool trans_OR_rrr(DisasContext *ctx, arg_OR_rrr *a)
+{
+    rx_gen_op_rrr(rx_or, a->rd, a->rs, a->rs2);
+    return true;
+}
+
+static void rx_xor(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    tcg_gen_xor_i32(cpu_psw_s, arg1, arg2);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+    tcg_gen_mov_i32(ret, cpu_psw_s);
+}
+
+/* xor #imm, rd */
+static bool trans_XOR_ir(DisasContext *ctx, arg_XOR_ir *a)
+{
+    rx_gen_op_irr(rx_xor, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* xor dsp[rs], rd */
+/* xor rs,rd */
+static bool trans_XOR_mr(DisasContext *ctx, arg_XOR_mr *a)
+{
+    rx_gen_op_mr(rx_xor, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+static void rx_tst(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    tcg_gen_and_i32(cpu_psw_s, arg1, arg2);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+}
+
+/* tst #imm, rd */
+static bool trans_TST_ir(DisasContext *ctx, arg_TST_ir *a)
+{
+    rx_gen_op_irr(rx_tst, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* tst dsp[rs], rd */
+/* tst rs, rd */
+static bool trans_TST_mr(DisasContext *ctx, arg_TST_mr *a)
+{
+    rx_gen_op_mr(rx_tst, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+static void rx_not(TCGv ret, TCGv arg1)
+{
+    tcg_gen_not_i32(ret, arg1);
+    tcg_gen_mov_i32(cpu_psw_z, ret);
+    tcg_gen_mov_i32(cpu_psw_s, ret);
+}
+
+/* not rd */
+/* not rs, rd */
+static bool trans_NOT_rr(DisasContext *ctx, arg_NOT_rr *a)
+{
+    rx_gen_op_rr(rx_not, a->rd, a->rs);
+    return true;
+}
+
+static void rx_neg(TCGv ret, TCGv arg1)
+{
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_o, arg1, 0x80000000);
+    tcg_gen_neg_i32(ret, arg1);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_c, ret, 0);
+    tcg_gen_mov_i32(cpu_psw_z, ret);
+    tcg_gen_mov_i32(cpu_psw_s, ret);
+}
+
+
+/* neg rd */
+/* neg rs, rd */
+static bool trans_NEG_rr(DisasContext *ctx, arg_NEG_rr *a)
+{
+    rx_gen_op_rr(rx_neg, a->rd, a->rs);
+    return true;
+}
+
+/* ret = arg1 + arg2 + psw_c */
+static void rx_adc(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv z;
+    z = tcg_const_i32(0);
+    tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, arg1, z, cpu_psw_c, z);
+    tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, cpu_psw_s, cpu_psw_c, arg2, z);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+    tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
+    tcg_gen_xor_i32(z, arg1, arg2);
+    tcg_gen_andc_i32(cpu_psw_o, cpu_psw_o, z);
+    tcg_gen_mov_i32(ret, cpu_psw_s);
+    tcg_temp_free(z);
+}
+
+/* adc #imm, rd */
+static bool trans_ADC_ir(DisasContext *ctx, arg_ADC_ir *a)
+{
+    rx_gen_op_irr(rx_adc, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* adc rs, rd */
+static bool trans_ADC_rr(DisasContext *ctx, arg_ADC_rr *a)
+{
+    rx_gen_op_rrr(rx_adc, a->rd, a->rd, a->rs);
+    return true;
+}
+
+/* adc dsp[rs], rd */
+static bool trans_ADC_mr(DisasContext *ctx, arg_ADC_mr *a)
+{
+    /* mi only 2 */
+    if (a->mi != 2) {
+        return false;
+    }
+    rx_gen_op_mr(rx_adc, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* ret = arg1 + arg2 */
+static void rx_add(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv z;
+    z = tcg_const_i32(0);
+    tcg_gen_add2_i32(cpu_psw_s, cpu_psw_c, arg1, z, arg2, z);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+    tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
+    tcg_gen_xor_i32(z, arg1, arg2);
+    tcg_gen_andc_i32(cpu_psw_o, cpu_psw_o, z);
+    tcg_gen_mov_i32(ret, cpu_psw_s);
+    tcg_temp_free(z);
+}
+
+/* add #uimm4, rd */
+/* add #imm, rs, rd */
+static bool trans_ADD_irr(DisasContext *ctx, arg_ADD_irr *a)
+{
+    rx_gen_op_irr(rx_add, a->rd, a->rs2, a->imm);
+    return true;
+}
+
+/* add rs, rd */
+/* add dsp[rs], rd */
+static bool trans_ADD_mr(DisasContext *ctx, arg_ADD_mr *a)
+{
+    rx_gen_op_mr(rx_add, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* add rs, rs2, rd */
+static bool trans_ADD_rrr(DisasContext *ctx, arg_ADD_rrr *a)
+{
+    rx_gen_op_rrr(rx_add, a->rd, a->rs, a->rs2);
+    return true;
+}
+
+/* ret = arg1 - arg2 */
+static void rx_sub(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv temp;
+    tcg_gen_sub_i32(cpu_psw_s, arg1, arg2);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_s);
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_psw_c, arg1, arg2);
+    tcg_gen_xor_i32(cpu_psw_o, cpu_psw_s, arg1);
+    temp = tcg_temp_new_i32();
+    tcg_gen_xor_i32(temp, arg1, arg2);
+    tcg_gen_and_i32(cpu_psw_o, cpu_psw_o, temp);
+    tcg_temp_free_i32(temp);
+    /* CMP not requred return */
+    if (ret) {
+        tcg_gen_mov_i32(ret, cpu_psw_s);
+    }
+}
+static void rx_cmp(TCGv dummy, TCGv arg1, TCGv arg2)
+{
+    rx_sub(NULL, arg1, arg2);
+}
+/* ret = arg1 - arg2 - !psw_c */
+/* -> ret = arg1 + ~arg2 + psw_c */
+static void rx_sbb(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    TCGv temp;
+    temp = tcg_temp_new();
+    tcg_gen_not_i32(temp, arg2);
+    rx_adc(ret, arg1, temp);
+    tcg_temp_free(temp);
+}
+
+/* cmp #imm4, rs2 */
+/* cmp #imm8, rs2 */
+/* cmp #imm, rs2 */
+static bool trans_CMP_ir(DisasContext *ctx, arg_CMP_ir *a)
+{
+    rx_gen_op_irr(rx_cmp, 0, a->rs2, a->imm);
+    return true;
+}
+
+/* cmp rs, rs2 */
+/* cmp dsp[rs], rs2 */
+static bool trans_CMP_mr(DisasContext *ctx, arg_CMP_mr *a)
+{
+    rx_gen_op_mr(rx_cmp, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* sub #imm4, rd */
+static bool trans_SUB_ir(DisasContext *ctx, arg_SUB_ir *a)
+{
+    rx_gen_op_irr(rx_sub, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* sub rs, rd */
+/* sub dsp[rs], rd */
+static bool trans_SUB_mr(DisasContext *ctx, arg_SUB_mr *a)
+{
+    rx_gen_op_mr(rx_sub, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* sub rs2, rs, rd */
+static bool trans_SUB_rrr(DisasContext *ctx, arg_SUB_rrr *a)
+{
+    rx_gen_op_rrr(rx_sub, a->rd, a->rs2, a->rs);
+    return true;
+}
+
+/* sbb rs, rd */
+static bool trans_SBB_rr(DisasContext *ctx, arg_SBB_rr *a)
+{
+    rx_gen_op_rrr(rx_sbb, a->rd, a->rd, a->rs);
+    return true;
+}
+
+/* sbb dsp[rs], rd */
+static bool trans_SBB_mr(DisasContext *ctx, arg_SBB_mr *a)
+{
+    /* mi only 2 */
+    if (a->mi != 2) {
+        return false;
+    }
+    rx_gen_op_mr(rx_sbb, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+static void rx_abs(TCGv ret, TCGv arg1)
+{
+    TCGv neg;
+    TCGv zero;
+    neg = tcg_temp_new();
+    zero = tcg_const_i32(0);
+    tcg_gen_neg_i32(neg, arg1);
+    tcg_gen_movcond_i32(TCG_COND_LT, ret, arg1, zero, neg, arg1);
+    tcg_temp_free(neg);
+    tcg_temp_free(zero);
+}
+
+/* abs rd */
+/* abs rs, rd */
+static bool trans_ABS_rr(DisasContext *ctx, arg_ABS_rr *a)
+{
+    rx_gen_op_rr(rx_abs, a->rd, a->rs);
+    return true;
+}
+
+/* max #imm, rd */
+static bool trans_MAX_ir(DisasContext *ctx, arg_MAX_ir *a)
+{
+    rx_gen_op_irr(tcg_gen_smax_i32, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* max rs, rd */
+/* max dsp[rs], rd */
+static bool trans_MAX_mr(DisasContext *ctx, arg_MAX_mr *a)
+{
+    rx_gen_op_mr(tcg_gen_smax_i32, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* min #imm, rd */
+static bool trans_MIN_ir(DisasContext *ctx, arg_MIN_ir *a)
+{
+    rx_gen_op_irr(tcg_gen_smin_i32, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* min rs, rd */
+/* min dsp[rs], rd */
+static bool trans_MIN_mr(DisasContext *ctx, arg_MIN_mr *a)
+{
+    rx_gen_op_mr(tcg_gen_smin_i32, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* mul #uimm4, rd */
+/* mul #imm, rd */
+static bool trans_MUL_ir(DisasContext *ctx, arg_MUL_ir *a)
+{
+    rx_gen_op_irr(tcg_gen_mul_i32, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* mul rs, rd */
+/* mul dsp[rs], rd */
+static bool trans_MUL_mr(DisasContext *ctx, arg_MUL_mr *a)
+{
+    rx_gen_op_mr(tcg_gen_mul_i32, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* mul rs, rs2, rd */
+static bool trans_MUL_rrr(DisasContext *ctx, arg_MUL_rrr *a)
+{
+    rx_gen_op_rrr(tcg_gen_mul_i32, a->rd, a->rs, a->rs2);
+    return true;
+}
+
+/* emul #imm, rd */
+static bool trans_EMUL_ir(DisasContext *ctx, arg_EMUL_ir *a)
+{
+    TCGv imm = tcg_const_i32(a->imm);
+    if (a->rd > 14) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
+    }
+    tcg_gen_muls2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
+                      cpu_regs[a->rd], imm);
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* emul rs, rd */
+/* emul dsp[rs], rd */
+static bool trans_EMUL_mr(DisasContext *ctx, arg_EMUL_mr *a)
+{
+    TCGv val, mem;
+    if (a->rd > 14) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
+    }
+    mem = tcg_temp_new();
+    val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
+    tcg_gen_muls2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
+                      cpu_regs[a->rd], val);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* emulu #imm, rd */
+static bool trans_EMULU_ir(DisasContext *ctx, arg_EMULU_ir *a)
+{
+    TCGv imm = tcg_const_i32(a->imm);
+    if (a->rd > 14) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
+    }
+    tcg_gen_mulu2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
+                      cpu_regs[a->rd], imm);
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* emulu rs, rd */
+/* emulu dsp[rs], rd */
+static bool trans_EMULU_mr(DisasContext *ctx, arg_EMULU_mr *a)
+{
+    TCGv val, mem;
+    if (a->rd > 14) {
+        qemu_log_mask(LOG_GUEST_ERROR, "rd too large %d", a->rd);
+    }
+    mem = tcg_temp_new();
+    val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
+    tcg_gen_mulu2_i32(cpu_regs[a->rd], cpu_regs[(a->rd + 1) & 15],
+                      cpu_regs[a->rd], val);
+    tcg_temp_free(mem);
+    return true;
+}
+
+static void rx_div(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    gen_helper_div(ret, cpu_env, arg1, arg2);
+}
+
+static void rx_divu(TCGv ret, TCGv arg1, TCGv arg2)
+{
+    gen_helper_divu(ret, cpu_env, arg1, arg2);
+}
+
+/* div #imm, rd */
+static bool trans_DIV_ir(DisasContext *ctx, arg_DIV_ir *a)
+{
+    rx_gen_op_irr(rx_div, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* div rs, rd */
+/* div dsp[rs], rd */
+static bool trans_DIV_mr(DisasContext *ctx, arg_DIV_mr *a)
+{
+    rx_gen_op_mr(rx_div, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+/* divu #imm, rd */
+static bool trans_DIVU_ir(DisasContext *ctx, arg_DIVU_ir *a)
+{
+    rx_gen_op_irr(rx_divu, a->rd, a->rd, a->imm);
+    return true;
+}
+
+/* divu rs, rd */
+/* divu dsp[rs], rd */
+static bool trans_DIVU_mr(DisasContext *ctx, arg_DIVU_mr *a)
+{
+    rx_gen_op_mr(rx_divu, ctx, a->rd, a->rs, a->ld, a->mi);
+    return true;
+}
+
+
+/* shll #imm:5, rd */
+/* shll #imm:5, rs2, rd */
+static bool trans_SHLL_irr(DisasContext *ctx, arg_SHLL_irr *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    if (a->imm) {
+        tcg_gen_sari_i32(cpu_psw_c, cpu_regs[a->rs2], 32 - a->imm);
+        tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rs2], a->imm);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_o, cpu_psw_c, 0);
+        tcg_gen_setcondi_i32(TCG_COND_EQ, tmp, cpu_psw_c, 0xffffffff);
+        tcg_gen_or_i32(cpu_psw_o, cpu_psw_o, tmp);
+        tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, cpu_psw_c, 0);
+    } else {
+        tcg_gen_mov_i32(cpu_regs[a->rd], cpu_regs[a->rs2]);
+        tcg_gen_movi_i32(cpu_psw_c, 0);
+        tcg_gen_movi_i32(cpu_psw_o, 0);
+    }
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[a->rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[a->rd]);
+    return true;
+}
+
+/* shll rs, rd */
+static bool trans_SHLL_rr(DisasContext *ctx, arg_SHLL_rr *a)
+{
+    TCGLabel *noshift, *done;
+    TCGv count, tmp;
+
+    noshift = gen_new_label();
+    done = gen_new_label();
+    /* if (cpu_regs[a->rs]) { */
+    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[a->rs], 0, noshift);
+    count = tcg_const_i32(32);
+    tmp = tcg_temp_new();
+    tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 31);
+    tcg_gen_sub_i32(count, count, tmp);
+    tcg_gen_sar_i32(cpu_psw_c, cpu_regs[a->rd], count);
+    tcg_gen_shl_i32(cpu_regs[a->rd], cpu_regs[a->rd], tmp);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, cpu_psw_o, cpu_psw_c, 0);
+    tcg_gen_setcondi_i32(TCG_COND_EQ, tmp, cpu_psw_c, 0xffffffff);
+    tcg_gen_or_i32(cpu_psw_o, cpu_psw_o, tmp);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, cpu_psw_c, 0);
+    tcg_gen_br(done);
+    /* } else { */
+    gen_set_label(noshift);
+    tcg_gen_movi_i32(cpu_psw_c, 0);
+    tcg_gen_movi_i32(cpu_psw_o, 0);
+    /* } */
+    gen_set_label(done);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[a->rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[a->rd]);
+    tcg_temp_free(count);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+static inline void shiftr_imm(uint32_t rd, uint32_t rs, uint32_t imm,
+                              unsigned int alith)
+{
+    static void (* const gen_sXri[])(TCGv ret, TCGv arg1, int arg2) = {
+        tcg_gen_shri_i32, tcg_gen_sari_i32,
+    };
+    tcg_debug_assert(alith < 2);
+    if (imm) {
+        gen_sXri[alith](cpu_regs[rd], cpu_regs[rs], imm - 1);
+        tcg_gen_andi_i32(cpu_psw_c, cpu_regs[rd], 0x00000001);
+        gen_sXri[alith](cpu_regs[rd], cpu_regs[rd], 1);
+    } else {
+        tcg_gen_mov_i32(cpu_regs[rd], cpu_regs[rs]);
+        tcg_gen_movi_i32(cpu_psw_c, 0);
+    }
+    tcg_gen_movi_i32(cpu_psw_o, 0);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[rd]);
+}
+
+static inline void shiftr_reg(uint32_t rd, uint32_t rs, unsigned int alith)
+{
+    TCGLabel *noshift, *done;
+    TCGv count;
+    static void (* const gen_sXri[])(TCGv ret, TCGv arg1, int arg2) = {
+        tcg_gen_shri_i32, tcg_gen_sari_i32,
+    };
+    static void (* const gen_sXr[])(TCGv ret, TCGv arg1, TCGv arg2) = {
+        tcg_gen_shr_i32, tcg_gen_sar_i32,
+    };
+    tcg_debug_assert(alith < 2);
+    noshift = gen_new_label();
+    done = gen_new_label();
+    count = tcg_temp_new();
+    /* if (cpu_regs[rs]) { */
+    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_regs[rs], 0, noshift);
+    tcg_gen_andi_i32(count, cpu_regs[rs], 31);
+    tcg_gen_subi_i32(count, count, 1);
+    gen_sXr[alith](cpu_regs[rd], cpu_regs[rd], count);
+    tcg_gen_andi_i32(cpu_psw_c, cpu_regs[rd], 0x00000001);
+    gen_sXri[alith](cpu_regs[rd], cpu_regs[rd], 1);
+    tcg_gen_br(done);
+    /* } else { */
+    gen_set_label(noshift);
+    tcg_gen_movi_i32(cpu_psw_c, 0);
+    /* } */
+    gen_set_label(done);
+    tcg_gen_movi_i32(cpu_psw_o, 0);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[rd]);
+    tcg_temp_free(count);
+}
+
+/* shar #imm:5, rd */
+/* shar #imm:5, rs2, rd */
+static bool trans_SHAR_irr(DisasContext *ctx, arg_SHAR_irr *a)
+{
+    shiftr_imm(a->rd, a->rs2, a->imm, 1);
+    return true;
+}
+
+/* shar rs, rd */
+static bool trans_SHAR_rr(DisasContext *ctx, arg_SHAR_rr *a)
+{
+    shiftr_reg(a->rd, a->rs, 1);
+    return true;
+}
+
+/* shlr #imm:5, rd */
+/* shlr #imm:5, rs2, rd */
+static bool trans_SHLR_irr(DisasContext *ctx, arg_SHLR_irr *a)
+{
+    shiftr_imm(a->rd, a->rs2, a->imm, 0);
+    return true;
+}
+
+/* shlr rs, rd */
+static bool trans_SHLR_rr(DisasContext *ctx, arg_SHLR_rr *a)
+{
+    shiftr_reg(a->rd, a->rs, 0);
+    return true;
+}
+
+/* rolc rd */
+static bool trans_ROLC(DisasContext *ctx, arg_ROLC *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_shri_i32(tmp, cpu_regs[a->rd], 31);
+    tcg_gen_shli_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
+    tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_psw_c);
+    tcg_gen_mov_i32(cpu_psw_c, tmp);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[a->rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[a->rd]);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* rorc rd */
+static bool trans_RORC(DisasContext *ctx, arg_RORC *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_andi_i32(tmp, cpu_regs[a->rd], 0x00000001);
+    tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rd], 1);
+    tcg_gen_shli_i32(cpu_psw_c, cpu_psw_c, 31);
+    tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], cpu_psw_c);
+    tcg_gen_mov_i32(cpu_psw_c, tmp);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[a->rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[a->rd]);
+    return true;
+}
+
+enum {ROTR = 0, ROTL = 1};
+enum {ROT_IMM = 0, ROT_REG = 1};
+static inline void rx_rot(int ir, int dir, int rd, int src)
+{
+    switch (dir) {
+    case ROTL:
+        if (ir == ROT_IMM) {
+            tcg_gen_rotli_i32(cpu_regs[rd], cpu_regs[rd], src);
+        } else {
+            tcg_gen_rotl_i32(cpu_regs[rd], cpu_regs[rd], cpu_regs[src]);
+        }
+        tcg_gen_andi_i32(cpu_psw_c, cpu_regs[rd], 0x00000001);
+        break;
+    case ROTR:
+        if (ir == ROT_IMM) {
+            tcg_gen_rotri_i32(cpu_regs[rd], cpu_regs[rd], src);
+        } else {
+            tcg_gen_rotr_i32(cpu_regs[rd], cpu_regs[rd], cpu_regs[src]);
+        }
+        tcg_gen_shri_i32(cpu_psw_c, cpu_regs[rd], 31);
+        break;
+    }
+    tcg_gen_mov_i32(cpu_psw_z, cpu_regs[rd]);
+    tcg_gen_mov_i32(cpu_psw_s, cpu_regs[rd]);
+}
+
+/* rotl #imm, rd */
+static bool trans_ROTL_ir(DisasContext *ctx, arg_ROTL_ir *a)
+{
+    rx_rot(ROT_IMM, ROTL, a->rd, a->imm);
+    return true;
+}
+
+/* rotl rs, rd */
+static bool trans_ROTL_rr(DisasContext *ctx, arg_ROTL_rr *a)
+{
+    rx_rot(ROT_REG, ROTL, a->rd, a->rs);
+    return true;
+}
+
+/* rotr #imm, rd */
+static bool trans_ROTR_ir(DisasContext *ctx, arg_ROTR_ir *a)
+{
+    rx_rot(ROT_IMM, ROTR, a->rd, a->imm);
+    return true;
+}
+
+/* rotr rs, rd */
+static bool trans_ROTR_rr(DisasContext *ctx, arg_ROTR_rr *a)
+{
+    rx_rot(ROT_REG, ROTR, a->rd, a->rs);
+    return true;
+}
+
+/* revl rs, rd */
+static bool trans_REVL(DisasContext *ctx, arg_REVL *a)
+{
+    tcg_gen_bswap32_i32(cpu_regs[a->rd], cpu_regs[a->rs]);
+    return true;
+}
+
+/* revw rs, rd */
+static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
+{
+    TCGv tmp;
+    tmp = tcg_temp_new();
+    tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 0x00ff00ff);
+    tcg_gen_shli_i32(tmp, tmp, 8);
+    tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rs], 8);
+    tcg_gen_andi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 0x00ff00ff);
+    tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], tmp);
+    tcg_temp_free(tmp);
+    return true;
+}
+
+/* conditional branch helper */
+static void rx_bcnd_main(DisasContext *ctx, int cd, int dst)
+{
+    DisasCompare dc;
+    TCGLabel *t, *done;
+
+    switch (cd) {
+    case 0 ... 13:
+        dc.temp = tcg_temp_new();
+        psw_cond(&dc, cd);
+        t = gen_new_label();
+        done = gen_new_label();
+        tcg_gen_brcondi_i32(dc.cond, dc.value, 0, t);
+        gen_goto_tb(ctx, 0, ctx->base.pc_next);
+        tcg_gen_br(done);
+        gen_set_label(t);
+        gen_goto_tb(ctx, 1, ctx->pc + dst);
+        gen_set_label(done);
+        tcg_temp_free(dc.temp);
+        break;
+    case 14:
+        /* always true case */
+        gen_goto_tb(ctx, 0, ctx->pc + dst);
+        break;
+    case 15:
+        /* always false case */
+        /* Nothing do */
+        break;
+    }
+}
+
+/* beq dsp:3 / bne dsp:3 */
+/* beq dsp:8 / bne dsp:8 */
+/* bc dsp:8 / bnc dsp:8 */
+/* bgtu dsp:8 / bleu dsp:8 */
+/* bpz dsp:8 / bn dsp:8 */
+/* bge dsp:8 / blt dsp:8 */
+/* bgt dsp:8 / ble dsp:8 */
+/* bo dsp:8 / bno dsp:8 */
+/* beq dsp:16 / bne dsp:16 */
+static bool trans_BCnd(DisasContext *ctx, arg_BCnd *a)
+{
+    rx_bcnd_main(ctx, a->cd, a->dsp);
+    return true;
+}
+
+/* bra dsp:3 */
+/* bra dsp:8 */
+/* bra dsp:16 */
+/* bra dsp:24 */
+static bool trans_BRA(DisasContext *ctx, arg_BRA *a)
+{
+    rx_bcnd_main(ctx, 14, a->dsp);
+    return true;
+}
+
+/* bra rs */
+static bool trans_BRA_l(DisasContext *ctx, arg_BRA_l *a)
+{
+    tcg_gen_addi_i32(cpu_pc, cpu_regs[a->rd], ctx->pc);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+static inline void rx_save_pc(DisasContext *ctx)
+{
+    TCGv pc = tcg_const_i32(ctx->base.pc_next);
+    push(pc);
+    tcg_temp_free(pc);
+}
+
+/* jmp rs */
+static bool trans_JMP(DisasContext *ctx, arg_JMP *a)
+{
+    tcg_gen_mov_i32(cpu_pc, cpu_regs[a->rs]);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* jsr rs */
+static bool trans_JSR(DisasContext *ctx, arg_JSR *a)
+{
+    rx_save_pc(ctx);
+    tcg_gen_mov_i32(cpu_pc, cpu_regs[a->rs]);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* bsr dsp:16 */
+/* bsr dsp:24 */
+static bool trans_BSR(DisasContext *ctx, arg_BSR *a)
+{
+    rx_save_pc(ctx);
+    rx_bcnd_main(ctx, 14, a->dsp);
+    return true;
+}
+
+/* bsr rs */
+static bool trans_BSR_l(DisasContext *ctx, arg_BSR_l *a)
+{
+    rx_save_pc(ctx);
+    tcg_gen_addi_i32(cpu_pc, cpu_regs[a->rd], ctx->pc);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* rts */
+static bool trans_RTS(DisasContext *ctx, arg_RTS *a)
+{
+    pop(cpu_pc);
+    ctx->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+/* nop */
+static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
+{
+    return true;
+}
+
+/* scmpu */
+static bool trans_SCMPU(DisasContext *ctx, arg_SCMPU *a)
+{
+    gen_helper_scmpu(cpu_env);
+    return true;
+}
+
+/* smovu */
+static bool trans_SMOVU(DisasContext *ctx, arg_SMOVU *a)
+{
+    gen_helper_smovu(cpu_env);
+    return true;
+}
+
+/* smovf */
+static bool trans_SMOVF(DisasContext *ctx, arg_SMOVF *a)
+{
+    gen_helper_smovf(cpu_env);
+    return true;
+}
+
+/* smovb */
+static bool trans_SMOVB(DisasContext *ctx, arg_SMOVB *a)
+{
+    gen_helper_smovb(cpu_env);
+    return true;
+}
+
+#define STRING(op)                              \
+    do {                                        \
+        TCGv size = tcg_const_i32(a->sz);       \
+        gen_helper_##op(cpu_env, size);         \
+        tcg_temp_free(size);                    \
+    } while (0)
+
+/* suntile.<bwl> */
+static bool trans_SUNTIL(DisasContext *ctx, arg_SUNTIL *a)
+{
+    STRING(suntil);
+    return true;
+}
+
+/* swhile.<bwl> */
+static bool trans_SWHILE(DisasContext *ctx, arg_SWHILE *a)
+{
+    STRING(swhile);
+    return true;
+}
+/* sstr.<bwl> */
+static bool trans_SSTR(DisasContext *ctx, arg_SSTR *a)
+{
+    STRING(sstr);
+    return true;
+}
+
+/* rmpa.<bwl> */
+static bool trans_RMPA(DisasContext *ctx, arg_RMPA *a)
+{
+    STRING(rmpa);
+    return true;
+}
+
+static void rx_mul64hi(TCGv_i64 ret, int rs, int rs2)
+{
+    TCGv_i64 tmp0, tmp1;
+    tmp0 = tcg_temp_new_i64();
+    tmp1 = tcg_temp_new_i64();
+    tcg_gen_ext_i32_i64(tmp0, cpu_regs[rs]);
+    tcg_gen_sari_i64(tmp0, tmp0, 16);
+    tcg_gen_ext_i32_i64(tmp1, cpu_regs[rs2]);
+    tcg_gen_sari_i64(tmp1, tmp1, 16);
+    tcg_gen_mul_i64(ret, tmp0, tmp1);
+    tcg_gen_shli_i64(ret, ret, 16);
+    tcg_temp_free_i64(tmp0);
+    tcg_temp_free_i64(tmp1);
+}
+
+static void rx_mul64lo(TCGv_i64 ret, int rs, int rs2)
+{
+    TCGv_i64 tmp0, tmp1;
+    tmp0 = tcg_temp_new_i64();
+    tmp1 = tcg_temp_new_i64();
+    tcg_gen_ext_i32_i64(tmp0, cpu_regs[rs]);
+    tcg_gen_ext16s_i64(tmp0, tmp0);
+    tcg_gen_ext_i32_i64(tmp1, cpu_regs[rs2]);
+    tcg_gen_ext16s_i64(tmp1, tmp1);
+    tcg_gen_mul_i64(ret, tmp0, tmp1);
+    tcg_gen_shli_i64(ret, ret, 16);
+    tcg_temp_free_i64(tmp0);
+    tcg_temp_free_i64(tmp1);
+}
+
+/* mulhi rs,rs2 */
+static bool trans_MULHI(DisasContext *ctx, arg_MULHI *a)
+{
+    rx_mul64hi(cpu_acc, a->rs, a->rs2);
+    return true;
+}
+
+/* mullo rs,rs2 */
+static bool trans_MULLO(DisasContext *ctx, arg_MULLO *a)
+{
+    rx_mul64lo(cpu_acc, a->rs, a->rs2);
+    return true;
+}
+
+/* machi rs,rs2 */
+static bool trans_MACHI(DisasContext *ctx, arg_MACHI *a)
+{
+    TCGv_i64 tmp;
+    tmp = tcg_temp_new_i64();
+    rx_mul64hi(tmp, a->rs, a->rs2);
+    tcg_gen_add_i64(cpu_acc, cpu_acc, tmp);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
+
+/* maclo rs,rs2 */
+static bool trans_MACLO(DisasContext *ctx, arg_MACLO *a)
+{
+    TCGv_i64 tmp;
+    tmp = tcg_temp_new_i64();
+    rx_mul64lo(tmp, a->rs, a->rs2);
+    tcg_gen_add_i64(cpu_acc, cpu_acc, tmp);
+    tcg_temp_free_i64(tmp);
+    return true;
+}
+
+/* mvfachi rd */
+static bool trans_MVFACHI(DisasContext *ctx, arg_MVFACHI *a)
+{
+    tcg_gen_extrh_i64_i32(cpu_regs[a->rd], cpu_acc);
+    return true;
+}
+
+/* mvfacmi rd */
+static bool trans_MVFACMI(DisasContext *ctx, arg_MVFACMI *a)
+{
+    TCGv_i64 rd64;
+    rd64 = tcg_temp_new_i64();
+    tcg_gen_extract_i64(rd64, cpu_acc, 16, 32);
+    tcg_gen_extrl_i64_i32(cpu_regs[a->rd], rd64);
+    tcg_temp_free_i64(rd64);
+    return true;
+}
+
+/* mvtachi rs */
+static bool trans_MVTACHI(DisasContext *ctx, arg_MVTACHI *a)
+{
+    TCGv_i64 rs64;
+    rs64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(rs64, cpu_regs[a->rs]);
+    tcg_gen_deposit_i64(cpu_acc, cpu_acc, rs64, 32, 32);
+    tcg_temp_free_i64(rs64);
+    return true;
+}
+
+/* mvtaclo rs */
+static bool trans_MVTACLO(DisasContext *ctx, arg_MVTACLO *a)
+{
+    TCGv_i64 rs64;
+    rs64 = tcg_temp_new_i64();
+    tcg_gen_extu_i32_i64(rs64, cpu_regs[a->rs]);
+    tcg_gen_deposit_i64(cpu_acc, cpu_acc, rs64, 0, 32);
+    tcg_temp_free_i64(rs64);
+    return true;
+}
+
+/* racw #imm */
+static bool trans_RACW(DisasContext *ctx, arg_RACW *a)
+{
+    TCGv imm = tcg_const_i32(a->imm + 1);
+    gen_helper_racw(cpu_env, imm);
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* sat rd */
+static bool trans_SAT(DisasContext *ctx, arg_SAT *a)
+{
+    TCGv tmp, z;
+    tmp = tcg_temp_new();
+    z = tcg_const_i32(0);
+    /* S == 1 -> 0xffffffff / S == 0 -> 0x00000000 */
+    tcg_gen_sari_i32(tmp, cpu_psw_s, 31);
+    /* S == 1 -> 0x7fffffff / S == 0 -> 0x80000000 */
+    tcg_gen_xori_i32(tmp, tmp, 0x80000000);
+    tcg_gen_movcond_i32(TCG_COND_LT, cpu_regs[a->rd],
+                        cpu_psw_o, z, tmp, cpu_regs[a->rd]);
+    tcg_temp_free(tmp);
+    tcg_temp_free(z);
+    return true;
+}
+
+/* satr */
+static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
+{
+    gen_helper_satr(cpu_env);
+    return true;
+}
+
+#define cat3(a, b, c) a##b##c
+#define FOP(name, op)                                                   \
+    static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _ir) * a)      \
+    {                                                                   \
+        TCGv imm = tcg_const_i32(li(ctx, 0));                           \
+        gen_helper_##op(cpu_regs[a->rd], cpu_env,                       \
+                        cpu_regs[a->rd], imm);                          \
+        tcg_temp_free(imm);                                             \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _mr)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _mr) * a)      \
+    {                                                                   \
+        TCGv val, mem;                                                  \
+        mem = tcg_temp_new();                                           \
+        val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);            \
+        gen_helper_##op(cpu_regs[a->rd], cpu_env,                       \
+                        cpu_regs[a->rd], val);                          \
+        tcg_temp_free(mem);                                             \
+        return true;                                                    \
+    }
+
+#define FCONVOP(name, op)                                       \
+    static bool trans_##name(DisasContext *ctx, arg_##name * a) \
+    {                                                           \
+        TCGv val, mem;                                          \
+        mem = tcg_temp_new();                                   \
+        val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);    \
+        gen_helper_##op(cpu_regs[a->rd], cpu_env, val);         \
+        tcg_temp_free(mem);                                     \
+        return true;                                            \
+    }
+
+FOP(FADD, fadd)
+FOP(FSUB, fsub)
+FOP(FMUL, fmul)
+FOP(FDIV, fdiv)
+
+/* fcmp #imm, rd */
+static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
+{
+    TCGv imm = tcg_const_i32(li(ctx, 0));
+    gen_helper_fcmp(cpu_env, cpu_regs[a->rd], imm);
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* fcmp dsp[rs], rd */
+/* fcmp rs, rd */
+static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
+{
+    TCGv val, mem;
+    mem = tcg_temp_new();
+    val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
+    gen_helper_fcmp(cpu_env, cpu_regs[a->rd], val);
+    tcg_temp_free(mem);
+    return true;
+}
+
+FCONVOP(FTOI, ftoi)
+FCONVOP(ROUND, round)
+
+/* itof rs, rd */
+/* itof dsp[rs], rd */
+static bool trans_ITOF(DisasContext *ctx, arg_ITOF * a)
+{
+    TCGv val, mem;
+    mem = tcg_temp_new();
+    val = rx_load_source(ctx, mem, a->ld, a->mi, a->rs);
+    gen_helper_itof(cpu_regs[a->rd], cpu_env, val);
+    tcg_temp_free(mem);
+    return true;
+}
+
+static void rx_bsetm(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
+    tcg_gen_or_i32(val, val, mask);
+    rx_gen_st(MO_8, val, mem);
+    tcg_temp_free(val);
+}
+
+static void rx_bclrm(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
+    tcg_gen_andc_i32(val, val, mask);
+    rx_gen_st(MO_8, val, mem);
+    tcg_temp_free(val);
+}
+
+static void rx_btstm(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
+    tcg_gen_and_i32(val, val, mask);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, val, 0);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
+    tcg_temp_free(val);
+}
+
+static void rx_bnotm(TCGv mem, TCGv mask)
+{
+    TCGv val;
+    val = tcg_temp_new();
+    rx_gen_ld(MO_8, val, mem);
+    tcg_gen_xor_i32(val, val, mask);
+    rx_gen_st(MO_8, val, mem);
+    tcg_temp_free(val);
+}
+
+static void rx_bsetr(TCGv reg, TCGv mask)
+{
+    tcg_gen_or_i32(reg, reg, mask);
+}
+
+static void rx_bclrr(TCGv reg, TCGv mask)
+{
+    tcg_gen_andc_i32(reg, reg, mask);
+}
+
+static inline void rx_btstr(TCGv reg, TCGv mask)
+{
+    TCGv t0;
+    t0 = tcg_temp_new();
+    tcg_gen_and_i32(t0, reg, mask);
+    tcg_gen_setcondi_i32(TCG_COND_NE, cpu_psw_c, t0, 0);
+    tcg_gen_mov_i32(cpu_psw_z, cpu_psw_c);
+    tcg_temp_free(t0);
+}
+
+static inline void rx_bnotr(TCGv reg, TCGv mask)
+{
+    tcg_gen_xor_i32(reg, reg, mask);
+}
+
+#define BITOP(name, op)                                                 \
+    static bool cat3(trans_, name, _im)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _im) * a)      \
+    {                                                                   \
+        TCGv mask, mem, addr;                                           \
+        mem = tcg_temp_new();                                           \
+        mask = tcg_const_i32(1 << a->imm);                              \
+        addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
+        cat3(rx_, op, m)(addr, mask);                                   \
+        tcg_temp_free(mask);                                            \
+        tcg_temp_free(mem);                                             \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _ir)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _ir) * a)      \
+    {                                                                   \
+        TCGv mask;                                                      \
+        mask = tcg_const_i32(1 << a->imm);                              \
+        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
+        tcg_temp_free(mask);                                            \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _rr)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _rr) * a)      \
+    {                                                                   \
+        TCGv mask, b;                                                   \
+        mask = tcg_const_i32(1);                                        \
+        b = tcg_temp_new();                                             \
+        tcg_gen_andi_i32(b, cpu_regs[a->rs], 31);                       \
+        tcg_gen_shl_i32(mask, mask, b);                                 \
+        cat3(rx_, op, r)(cpu_regs[a->rd], mask);                        \
+        tcg_temp_free(mask);                                            \
+        tcg_temp_free(b);                                               \
+        return true;                                                    \
+    }                                                                   \
+    static bool cat3(trans_, name, _rm)(DisasContext *ctx,              \
+                                        cat3(arg_, name, _rm) * a)      \
+    {                                                                   \
+        TCGv mask, mem, addr, b;                                        \
+        mask = tcg_const_i32(1);                                        \
+        b = tcg_temp_new();                                             \
+        tcg_gen_andi_i32(b, cpu_regs[a->rd], 7);                        \
+        tcg_gen_shl_i32(mask, mask, b);                                 \
+        mem = tcg_temp_new();                                           \
+        addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rs);             \
+        cat3(rx_, op, m)(addr, mask);                                   \
+        tcg_temp_free(mem);                                             \
+        tcg_temp_free(mask);                                            \
+        tcg_temp_free(b);                                               \
+        return true;                                                    \
+    }
+
+BITOP(BSET, bset)
+BITOP(BCLR, bclr)
+BITOP(BTST, btst)
+BITOP(BNOT, bnot)
+
+static inline void bmcnd_op(TCGv val, TCGCond cond, int pos)
+{
+    TCGv bit;
+    DisasCompare dc;
+    dc.temp = tcg_temp_new();
+    bit = tcg_temp_new();
+    psw_cond(&dc, cond);
+    tcg_gen_andi_i32(val, val, ~(1 << pos));
+    tcg_gen_setcondi_i32(dc.cond, bit, dc.value, 0);
+    tcg_gen_deposit_i32(val, val, bit, pos, 1);
+    tcg_temp_free(bit);
+    tcg_temp_free(dc.temp);
+ }
+
+/* bmcnd #imm, dsp[rd] */
+static bool trans_BMCnd_im(DisasContext *ctx, arg_BMCnd_im *a)
+{
+    TCGv val, mem, addr;
+    val = tcg_temp_new();
+    mem = tcg_temp_new();
+    addr = rx_index_addr(ctx, mem, a->ld, MO_8, a->rd);
+    rx_gen_ld(MO_8, val, addr);
+    bmcnd_op(val, a->cd, a->imm);
+    rx_gen_st(MO_8, val, addr);
+    tcg_temp_free(val);
+    tcg_temp_free(mem);
+    return true;
+}
+
+/* bmcond #imm, rd */
+static bool trans_BMCnd_ir(DisasContext *ctx, arg_BMCnd_ir *a)
+{
+    bmcnd_op(cpu_regs[a->rd], a->cd, a->imm);
+    return true;
+}
+
+enum {
+    PSW_C = 0,
+    PSW_Z = 1,
+    PSW_S = 2,
+    PSW_O = 3,
+    PSW_I = 8,
+    PSW_U = 9,
+};
+
+static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
+{
+    if (cb < 8) {
+        switch (cb) {
+        case PSW_C:
+            tcg_gen_movi_i32(cpu_psw_c, val);
+            break;
+        case PSW_Z:
+            tcg_gen_movi_i32(cpu_psw_z, val == 0);
+            break;
+        case PSW_S:
+            tcg_gen_movi_i32(cpu_psw_s, val ? -1 : 0);
+            break;
+        case PSW_O:
+            tcg_gen_movi_i32(cpu_psw_o, val << 31);
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            break;
+        }
+    } else if (is_privileged(ctx, 0)) {
+        switch (cb) {
+        case PSW_I:
+            tcg_gen_movi_i32(cpu_psw_i, val);
+            ctx->base.is_jmp = DISAS_UPDATE;
+            break;
+        case PSW_U:
+            tcg_gen_movi_i32(cpu_psw_u, val);
+            break;
+        default:
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            break;
+        }
+    }
+}
+
+/* clrpsw psw */
+static bool trans_CLRPSW(DisasContext *ctx, arg_CLRPSW *a)
+{
+    clrsetpsw(ctx, a->cb, 0);
+    return true;
+}
+
+/* setpsw psw */
+static bool trans_SETPSW(DisasContext *ctx, arg_SETPSW *a)
+{
+    clrsetpsw(ctx, a->cb, 1);
+    return true;
+}
+
+/* mvtipl #imm */
+static bool trans_MVTIPL(DisasContext *ctx, arg_MVTIPL *a)
+{
+    if (is_privileged(ctx, 1)) {
+        tcg_gen_movi_i32(cpu_psw_ipl, a->imm);
+        ctx->base.is_jmp = DISAS_UPDATE;
+    }
+    return true;
+}
+
+/* mvtc #imm, rd */
+static bool trans_MVTC_i(DisasContext *ctx, arg_MVTC_i *a)
+{
+    TCGv imm;
+
+    imm = tcg_const_i32(a->imm);
+    move_to_cr(ctx, imm, a->cr);
+    if (a->cr == 0 && is_privileged(ctx, 0)) {
+        ctx->base.is_jmp = DISAS_UPDATE;
+    }
+    tcg_temp_free(imm);
+    return true;
+}
+
+/* mvtc rs, rd */
+static bool trans_MVTC_r(DisasContext *ctx, arg_MVTC_r *a)
+{
+    move_to_cr(ctx, cpu_regs[a->rs], a->cr);
+    if (a->cr == 0 && is_privileged(ctx, 0)) {
+        ctx->base.is_jmp = DISAS_UPDATE;
+    }
+    return true;
+}
+
+/* mvfc rs, rd */
+static bool trans_MVFC(DisasContext *ctx, arg_MVFC *a)
+{
+    move_from_cr(cpu_regs[a->rd], a->cr, ctx->pc);
+    return true;
+}
+
+/* rtfi */
+static bool trans_RTFI(DisasContext *ctx, arg_RTFI *a)
+{
+    TCGv psw;
+    if (is_privileged(ctx, 1)) {
+        psw = tcg_temp_new();
+        tcg_gen_mov_i32(cpu_pc, cpu_bpc);
+        tcg_gen_mov_i32(psw, cpu_bpsw);
+        gen_helper_set_psw_rte(cpu_env, psw);
+        ctx->base.is_jmp = DISAS_EXIT;
+        tcg_temp_free(psw);
+    }
+    return true;
+}
+
+/* rte */
+static bool trans_RTE(DisasContext *ctx, arg_RTE *a)
+{
+    TCGv psw;
+    if (is_privileged(ctx, 1)) {
+        psw = tcg_temp_new();
+        pop(cpu_pc);
+        pop(psw);
+        gen_helper_set_psw_rte(cpu_env, psw);
+        ctx->base.is_jmp = DISAS_EXIT;
+        tcg_temp_free(psw);
+    }
+    return true;
+}
+
+/* brk */
+static bool trans_BRK(DisasContext *ctx, arg_BRK *a)
+{
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_rxbrk(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+/* int #imm */
+static bool trans_INT(DisasContext *ctx, arg_INT *a)
+{
+    TCGv vec;
+
+    tcg_debug_assert(a->imm < 0x100);
+    vec = tcg_const_i32(a->imm);
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_rxint(cpu_env, vec);
+    tcg_temp_free(vec);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    return true;
+}
+
+/* wait */
+static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
+{
+    if (is_privileged(ctx, 1)) {
+        tcg_gen_addi_i32(cpu_pc, cpu_pc, 2);
+        gen_helper_wait(cpu_env);
+    }
+    return true;
+}
+
+static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
+{
+    CPURXState *env = cs->env_ptr;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    ctx->env = env;
+}
+
+static void rx_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
+{
+}
+
+static void rx_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    tcg_gen_insn_start(ctx->base.pc_next);
+}
+
+static bool rx_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
+                                    const CPUBreakpoint *bp)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    /* We have hit a breakpoint - make sure PC is up-to-date */
+    tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    gen_helper_debug(cpu_env);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    ctx->base.pc_next += 1;
+    return true;
+}
+
+static void rx_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    uint32_t insn;
+
+    ctx->pc = ctx->base.pc_next;
+    insn = decode_load(ctx);
+    if (!decode(ctx, insn)) {
+        gen_helper_raise_illegal_instruction(cpu_env);
+    }
+}
+
+static void rx_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
+{
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+
+    switch (ctx->base.is_jmp) {
+    case DISAS_NEXT:
+    case DISAS_TOO_MANY:
+        gen_goto_tb(ctx, 0, dcbase->pc_next);
+        break;
+    case DISAS_JUMP:
+        if (ctx->base.singlestep_enabled) {
+            gen_helper_debug(cpu_env);
+        } else {
+            tcg_gen_lookup_and_goto_ptr();
+        }
+        break;
+    case DISAS_UPDATE:
+        tcg_gen_movi_i32(cpu_pc, ctx->base.pc_next);
+    case DISAS_EXIT:
+        tcg_gen_exit_tb(NULL, 0);
+        break;
+    case DISAS_NORETURN:
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void rx_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
+{
+    qemu_log("IN:\n");  /* , lookup_symbol(dcbase->pc_first)); */
+    log_target_disas(cs, dcbase->pc_first, dcbase->tb->size);
+}
+
+static const TranslatorOps rx_tr_ops = {
+    .init_disas_context = rx_tr_init_disas_context,
+    .tb_start           = rx_tr_tb_start,
+    .insn_start         = rx_tr_insn_start,
+    .breakpoint_check   = rx_tr_breakpoint_check,
+    .translate_insn     = rx_tr_translate_insn,
+    .tb_stop            = rx_tr_tb_stop,
+    .disas_log          = rx_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+{
+    DisasContext dc;
+
+    translator_loop(&rx_tr_ops, &dc.base, cs, tb, max_insns);
+}
+
+void restore_state_to_opc(CPURXState *env, TranslationBlock *tb,
+                          target_ulong *data)
+{
+    env->pc = data[0];
+}
+
+#define ALLOC_REGISTER(sym, name) \
+    cpu_##sym = tcg_global_mem_new_i32(cpu_env, \
+                                       offsetof(CPURXState, sym), name)
+
+void rx_translate_init(void)
+{
+    static const char * const regnames[NUM_REGS] = {
+        "R0", "R1", "R2", "R3", "R4", "R5", "R6", "R7",
+        "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15"
+    };
+    int i;
+
+    for (i = 0; i < NUM_REGS; i++) {
+        cpu_regs[i] = tcg_global_mem_new_i32(cpu_env,
+                                              offsetof(CPURXState, regs[i]),
+                                              regnames[i]);
+    }
+    ALLOC_REGISTER(pc, "PC");
+    ALLOC_REGISTER(psw_o, "PSW(O)");
+    ALLOC_REGISTER(psw_s, "PSW(S)");
+    ALLOC_REGISTER(psw_z, "PSW(Z)");
+    ALLOC_REGISTER(psw_c, "PSW(C)");
+    ALLOC_REGISTER(psw_u, "PSW(U)");
+    ALLOC_REGISTER(psw_i, "PSW(I)");
+    ALLOC_REGISTER(psw_pm, "PSW(PM)");
+    ALLOC_REGISTER(psw_ipl, "PSW(IPL)");
+    ALLOC_REGISTER(usp, "USP");
+    ALLOC_REGISTER(fpsw, "FPSW");
+    ALLOC_REGISTER(bpsw, "BPSW");
+    ALLOC_REGISTER(bpc, "BPC");
+    ALLOC_REGISTER(isp, "ISP");
+    ALLOC_REGISTER(fintv, "FINTV");
+    ALLOC_REGISTER(intb, "INTB");
+    cpu_acc = tcg_global_mem_new_i64(cpu_env,
+                                     offsetof(CPURXState, acc), "ACC");
+}
diff --git a/target/rx/Makefile.objs b/target/rx/Makefile.objs
new file mode 100644
index 0000000000..aa6f2d2d6c
--- /dev/null
+++ b/target/rx/Makefile.objs
@@ -0,0 +1,12 @@
+obj-y += translate.o op_helper.o helper.o cpu.o gdbstub.o disas.o
+obj-$(CONFIG_SOFTMMU) += monitor.o
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+
+target/rx/decode.inc.c: \
+  $(SRC_PATH)/target/rx/insns.decode $(DECODETREE)
+	$(call quiet-command,\
+	  $(PYTHON) $(DECODETREE) --varinsnwidth 32 -o $@ $<, "GEN", $(TARGET_DIR)$@)
+
+target/rx/translate.o: target/rx/decode.inc.c
+target/rx/disas.o: target/rx/decode.inc.c
-- 
2.21.1


