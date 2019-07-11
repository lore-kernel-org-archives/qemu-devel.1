Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126ABC742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17FF20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 22:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeMju+EU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17FF20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlhe0-0004Rr-Dy
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40423)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhdB-0001Ah-At
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hlhcy-0003nV-8E
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:29 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:34184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hlhcv-0003gG-Sw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 18:33:22 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x32so3207886ybh.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 15:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rzauXOUWfHOgOeAxCC/Wnlg/S4RkPUiYjkZ8KMHt7wk=;
 b=eeMju+EULnFJRSt33EsxDvdkpLtBivcbhVV1DSs2c6d7PUHDEIqDbSbtJl0xPks/8B
 ZES0LATS2NHQwQ4mErsIqhmBYu6p5M0jz0SAG8E78H+4eH7sadvf1z7iGydHcOx6pM9E
 tf5BeCJuCFSIfRCzwme3uSSUqnbsRIZWjGytcZ9IWBnHhC1U69s4rLFvQ17WCmUpMnDS
 Jw16H5VMiAK4jmvN9bs/2NK8yGHs4LMD/6S7LT20MbOgKjQ8OdTZecgQaSdugjWAQu9F
 xags4QEBfvuhUv1dfluh2yn6Rd8wZTbnHr9ixeoJ1yov44O/QAU7kBlYRc1n6YpVLhwG
 CkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rzauXOUWfHOgOeAxCC/Wnlg/S4RkPUiYjkZ8KMHt7wk=;
 b=Jc8NcXNSryQ176jUsmJ3WyBT5SFXVfgOG0wnp+5kw+sa7TVQMteFE/gxGszx7UbUvm
 UJIiGn4OA8lMDXkEfX9/3/MmjKwMirYUlzAFZSv6GbrGlC0x+8dM8KdruoyRpAYRyzf2
 nkJ6rQsUvh77hjS8mAfjXzxSAJnhg2IgoR3WUnYgagXXoKjHbTHv1+mf3FFN8mull9Ye
 4DgoyPoGb5WEjwpAuhmSKdc2RCSupnzM1DHB4MhKF1MmPYGZvTdh2gTq/KV2Tq2YYezv
 awII+51O/TUfvQTVeJrgD6XD0QtoKM+zDrbFPBSlEDcMMbomSviiFi60kNwS7jklNJwS
 OYiw==
X-Gm-Message-State: APjAAAWRc/zUiRo/6uGK7uGL+U98YhQdiyJiUNYdfhofaPW1qNiXYq+w
 6gquZS9CK0uIE+Z+6pfFZ3WChzPB
X-Google-Smtp-Source: APXvYqzcYutha7WP1TbE7Ybb5w9AJ0K92n2nU0RAsAXYgeAk+QyBuRnM3yQDi25ybV1L95nY79N9fQ==
X-Received: by 2002:a25:560a:: with SMTP id k10mr4150442ybb.378.1562884399490; 
 Thu, 11 Jul 2019 15:33:19 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id z191sm1676728ywa.31.2019.07.11.15.33.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 11 Jul 2019 15:33:18 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jul 2019 18:32:52 -0400
Message-Id: <20190711223300.6061-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711223300.6061-1-jan.bobek@gmail.com>
References: <20190711223300.6061-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: [Qemu-devel] [RISU PATCH v3 10/18] x86.risu: add MMX instructions
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
Cc: Jan Bobek <jan.bobek@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an x86 configuration file with all MMX instructions.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 321 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 321 insertions(+)
 create mode 100644 x86.risu

diff --git a/x86.risu b/x86.risu
new file mode 100644
index 0000000..208ac16
--- /dev/null
+++ b/x86.risu
@@ -0,0 +1,321 @@
+###############################################################################
+# Copyright (c) 2019 Jan Bobek
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Jan Bobek - initial implementation
+###############################################################################
+
+# Input file for risugen defining x86 instructions
+.mode x86
+
+#
+# Data Transfer Instructions
+# --------------------------
+#
+
+# NP 0F 6E /r: MOVD mm,r/m32
+# NP 0F 7E /r: MOVD r/m32,mm
+MOVD MMX 00001111 011 d 1110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { $d ? store(size => 4) : load(size => 4); }
+
+# NP REX.W + 0F 6E /r: MOVQ mm,r/m64
+# NP REX.W + 0F 7E /r: MOVQ r/m64,mm
+MOVQ MMX 00001111 011 d 1110 \
+  !constraints { rex($_, w => 1); modrm($_); $_->{modrm}{reg} &= 0b111; !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
+# NP 0F 6F /r: MOVQ mm, mm/m64
+# NP 0F 7F /r: MOVQ mm/m64, mm
+MOVQ_mm MMX 00001111 011 d 1111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { $d ? store(size => 8) : load(size => 8); }
+
+#
+# Arithmetic Instructions
+# -----------------------
+#
+
+# NP 0F FC /r: PADDB mm, mm/m64
+PADDB MMX 00001111 11111100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F FD /r: PADDW mm, mm/m64
+PADDW MMX 00001111 11111101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F FE /r: PADDD mm, mm/m64
+PADDD MMX 00001111 11111110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F EC /r: PADDSB mm, mm/m64
+PADDSB MMX 00001111 11101100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F ED /r: PADDSW mm, mm/m64
+PADDSW MMX 00001111 11101101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F DC /r: PADDUSB mm,mm/m64
+PADDUSB MMX 00001111 11011100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F DD /r: PADDUSW mm,mm/m64
+PADDUSW MMX 00001111 11011101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F F8 /r: PSUBB mm, mm/m64
+PSUBB MMX 00001111 11111000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F F9 /r: PSUBW mm, mm/m64
+PSUBW MMX 00001111 11111001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F FA /r: PSUBD mm, mm/m64
+PSUBD MMX 00001111 11111010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F E8 /r: PSUBSB mm, mm/m64
+PSUBSB MMX 00001111 11101000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F E9 /r: PSUBSW mm, mm/m64
+PSUBSW MMX 00001111 11101001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F D8 /r: PSUBUSB mm, mm/m64
+PSUBUSB MMX 00001111 11011000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F D9 /r: PSUBUSW mm, mm/m64
+PSUBUSW MMX 00001111 11011001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F D5 /r: PMULLW mm, mm/m64
+PMULLW MMX 00001111 11010101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F E5 /r: PMULHW mm, mm/m64
+PMULHW MMX 00001111 11100101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F F5 /r: PMADDWD mm, mm/m64
+PMADDWD MMX 00001111 11110101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+#
+# Comparison Instructions
+# -----------------------
+#
+
+# NP 0F 74 /r: PCMPEQB mm,mm/m64
+PCMPEQB MMX 00001111 01110100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 75 /r: PCMPEQW mm,mm/m64
+PCMPEQW MMX 00001111 01110101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 76 /r: PCMPEQD mm,mm/m64
+PCMPEQD MMX 00001111 01110110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 64 /r: PCMPGTB mm,mm/m64
+PCMPGTB MMX 00001111 01100100 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 65 /r: PCMPGTW mm,mm/m64
+PCMPGTW MMX 00001111 01100101 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 66 /r: PCMPGTD mm,mm/m64
+PCMPGTD MMX 00001111 01100110 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+#
+# Logical Instructions
+# --------------------
+#
+
+# NP 0F DB /r: PAND mm, mm/m64
+PAND MMX 00001111 11011011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F DF /r: PANDN mm, mm/m64
+PANDN MMX 00001111 11011111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F EB /r: POR mm, mm/m64
+POR MMX 00001111 11101011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F EF /r: PXOR mm, mm/m64
+PXOR MMX 00001111 11101111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+#
+# Shift and Rotate Instructions
+# -----------------------------
+#
+
+# NP 0F F1 /r: PSLLW mm, mm/m64
+PSLLW MMX 00001111 11110001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F F2 /r: PSLLD mm, mm/m64
+PSLLD MMX 00001111 11110010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F F3 /r: PSLLQ mm, mm/m64
+PSLLQ MMX 00001111 11110011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 71 /6 ib: PSLLW mm1, imm8
+PSLLW_imm MMX 00001111 01110001 \
+  !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F 72 /6 ib: PSLLD mm, imm8
+PSLLD_imm MMX 00001111 01110010 \
+  !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F 73 /6 ib: PSLLQ mm, imm8
+PSLLQ_imm MMX 00001111 01110011 \
+  !constraints { modrm($_, reg => 6); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F D1 /r: PSRLW mm, mm/m64
+PSRLW MMX 00001111 11010001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F D2 /r: PSRLD mm, mm/m64
+PSRLD MMX 00001111 11010010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F D3 /r: PSRLQ mm, mm/m64
+PSRLQ MMX 00001111 11010011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 71 /2 ib: PSRLW mm, imm8
+PSRLW_imm MMX 00001111 01110001 \
+  !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F 72 /2 ib: PSRLD mm, imm8
+PSRLD_imm MMX 00001111 01110010 \
+  !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F 73 /2 ib: PSRLQ mm, imm8
+PSRLQ_imm MMX 00001111 01110011 \
+  !constraints { modrm($_, reg => 2); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F E1 /r: PSRAW mm,mm/m64
+PSRAW MMX 00001111 11100001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F E2 /r: PSRAD mm,mm/m64
+PSRAD MMX 00001111 11100010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 71 /4 ib: PSRAW mm,imm8
+PSRAW_imm MMX 00001111 01110001 \
+  !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+# NP 0F 72 /4 ib: PSRAD mm,imm8
+PSRAD_imm MMX 00001111 01110010 \
+  !constraints { modrm($_, reg => 4); imm($_, width => 8); $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; defined $_->{modrm}{reg2} }
+
+#
+# Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Gather Instructions
+# --------------------------------------------------------------------------------
+#
+
+# NP 0F 63 /r: PACKSSWB mm1, mm2/m64
+PACKSSWB MMX 00001111 01100011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 6B /r: PACKSSDW mm1, mm2/m64
+PACKSSDW MMX 00001111 01101011 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 67 /r: PACKUSWB mm, mm/m64
+PACKUSWB MMX 00001111 01100111 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 68 /r: PUNPCKHBW mm, mm/m64
+PUNPCKHBW MMX 00001111 01101000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8, align => 8); }
+
+# NP 0F 69 /r: PUNPCKHWD mm, mm/m64
+PUNPCKHWD MMX 00001111 01101001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 6A /r: PUNPCKHDQ mm, mm/m64
+PUNPCKHDQ MMX 00001111 01101010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 8); }
+
+# NP 0F 60 /r: PUNPCKLBW mm, mm/m32
+PUNPCKLBW MMX 00001111 01100000 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 61 /r: PUNPCKLWD mm, mm/m32
+PUNPCKLWD MMX 00001111 01100001 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 4); }
+
+# NP 0F 62 /r: PUNPCKLDQ mm, mm/m32
+PUNPCKLDQ MMX 00001111 01100010 \
+  !constraints { modrm($_); $_->{modrm}{reg} &= 0b111; $_->{modrm}{reg2} &= 0b111 if defined $_->{modrm}{reg2}; 1 } \
+  !memory { load(size => 4); }
+
+#
+# State Management Instructions
+# -----------------------------
+#
+
+# NP 0F 77: EMMS
+EMMS MMX 00001111 01110111
-- 
2.20.1


