Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DB7C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A81208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcnVKgam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A81208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoAR-00058L-8d
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56660)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2r-0004wt-SZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2q-0004W9-9O
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:01 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:41585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2q-0004Vy-5A
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:00 -0400
Received: by mail-yb1-xb43.google.com with SMTP id y67so8250828yba.8
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NSnSmOrw9Ea8XUUWI877TcBO8R8fJh/l0RPwV5CWYGg=;
 b=CcnVKgamSdLOxSbw/fqmq8vyi65fO7bnxoJAmQuSTc81wXZCMp4FiGhIfpGrquQVPb
 vDALGVk2k4PkzdJ3rbvz9jB5oLkAfadV0q26R5YEX0lvlk2iAyElwmY9E9+x5Dn6KuVy
 Hmr1Y/tI2zkwud0QkMPaJm0k34pzhimarBT8rX66Q82FU9b7J+I7ZWy6DMbt5Aeb7ere
 BsJFGAfrGsVAs86qowdhjIbtsib/e+B/oA8e4otZ7JYu18QcVGGqTBRhr0+MzKsuyHFu
 pTjuT0uldgwAPbKzxD3U30OC1+A80t76o14M67MGBxNMEvv9xt6zC8Gz0xU33vKMyyG9
 XbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NSnSmOrw9Ea8XUUWI877TcBO8R8fJh/l0RPwV5CWYGg=;
 b=KAz3WwD2QrIeepG/OLNlFcCmwogVzGn2YOWhw2DZW7w/2XfcaW+rD2oTB+hcGu0f8u
 plcvSC+VpNsxdEr2k3+bw0nWlwec0m/NYKDDBUImTiAr57zsRHBwDw5byxjd9BIrcUAw
 7PnIFABLRRWhCDKcyuL8f+TYtF37wxKBXDKRxjuFHAFKbg4S1UYR9LFOjm5CPi6+8CV/
 Ts3piY2VmOGksPNqkSYMYAAUDzhVvey7NF2f7lXSl9eKI8D5Ros44TE97yKXoJlmcaO0
 JMwnbl1EXmE+/aaXHGNyIlS/61ExZzxTBvZ6WM5t7I0MQs791r88+8LmAsYtlueklWpN
 Vd4w==
X-Gm-Message-State: APjAAAVRhjjpmcnWYZ9RmSxybqWpREqf4epxRwVcPFi9ftQWSUg+GCYC
 nywY/Fpa3ASAqFy4zYa/PpyPsrkX
X-Google-Smtp-Source: APXvYqx72eZA/Ehp1RfLwtYm9diLUv1RU4n7Dsn7DhX5gdR4PatSdvDlwblr/KYWDmU2lQd4lLmvfA==
X-Received: by 2002:a25:bad0:: with SMTP id a16mr14113501ybk.140.1561955759528; 
 Sun, 30 Jun 2019 21:35:59 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.35.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:35:58 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:28 -0400
Message-Id: <20190701043536.26019-7-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [RISU RFC PATCH v2 06/14] x86.risu: add MMX
 instructions
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
 x86.risu | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 x86.risu

diff --git a/x86.risu b/x86.risu
new file mode 100644
index 0000000..f2dd9b0
--- /dev/null
+++ b/x86.risu
@@ -0,0 +1,96 @@
+###############################################################################
+# Copyright (c) 2019 Linaro Limited
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
+# Data Transfer Instructions
+MOVD            MMX     00001111 011 d 1110 !emit { modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
+MOVD_mem        MMX     00001111 011 d 1110 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
+MOVQ            MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); }
+MOVQ_mem        MMX     00001111 011 d 1110 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
+MOVQ_mm         MMX     00001111 011 d 1111 !emit { modrm(); mem(size => 8); }
+
+# Arithmetic Instructions
+PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
+PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size => 8); }
+PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size => 8); }
+PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size => 8); }
+PADDSB          MMX     00001111 11101100 !emit { modrm(); mem(size => 8); }
+PADDSW          MMX     00001111 11101101 !emit { modrm(); mem(size => 8); }
+PADDUSB         MMX     00001111 11011100 !emit { modrm(); mem(size => 8); }
+PADDUSW         MMX     00001111 11011101 !emit { modrm(); mem(size => 8); }
+
+PSUBB           MMX     00001111 11111000 !emit { modrm(); mem(size => 8); }
+PSUBW           MMX     00001111 11111001 !emit { modrm(); mem(size => 8); }
+PSUBD           MMX     00001111 11111010 !emit { modrm(); mem(size => 8); }
+PSUBSB          MMX     00001111 11101000 !emit { modrm(); mem(size => 8); }
+PSUBSW          MMX     00001111 11101001 !emit { modrm(); mem(size => 8); }
+PSUBUSB         MMX     00001111 11011000 !emit { modrm(); mem(size => 8); }
+PSUBUSW         MMX     00001111 11011001 !emit { modrm(); mem(size => 8); }
+
+PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
+PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
+
+PMADDWD         MMX     00001111 11110101 !emit { modrm(); mem(size => 8); }
+
+# Comparison Instructions
+PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
+PCMPEQW         MMX     00001111 01110101 !emit { modrm(); mem(size => 8); }
+PCMPEQD         MMX     00001111 01110110 !emit { modrm(); mem(size => 8); }
+PCMPGTB         MMX     00001111 01100100 !emit { modrm(); mem(size => 8); }
+PCMPGTW         MMX     00001111 01100101 !emit { modrm(); mem(size => 8); }
+PCMPGTD         MMX     00001111 01100110 !emit { modrm(); mem(size => 8); }
+
+# Logical Instructions
+PAND            MMX     00001111 11011011 !emit { modrm(); mem(size => 8); }
+PANDN           MMX     00001111 11011111 !emit { modrm(); mem(size => 8); }
+POR             MMX     00001111 11101011 !emit { modrm(); mem(size => 8); }
+PXOR            MMX     00001111 11101111 !emit { modrm(); mem(size => 8); }
+
+# Shift and Rotate Instructions
+PSLLW           MMX     00001111 11110001 !emit { modrm(); mem(size => 8); }
+PSLLD           MMX     00001111 11110010 !emit { modrm(); mem(size => 8); }
+PSLLQ           MMX     00001111 11110011 !emit { modrm(); mem(size => 8); }
+
+PSLLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+PSLLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+
+PSRLW           MMX     00001111 11010001 !emit { modrm(); mem(size => 8); }
+PSRLD           MMX     00001111 11010010 !emit { modrm(); mem(size => 8); }
+PSRLQ           MMX     00001111 11010011 !emit { modrm(); mem(size => 8); }
+
+PSRLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+PSRLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+
+PSRAW           MMX     00001111 11100001 !emit { modrm(); mem(size => 8); }
+PSRAD           MMX     00001111 11100010 !emit { modrm(); mem(size => 8); }
+
+PSRAW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+PSRAD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+
+# Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Scatter Instructions
+PACKSSWB        MMX     00001111 01100011 !emit { modrm(); mem(size => 8); }
+PACKSSDW        MMX     00001111 01101011 !emit { modrm(); mem(size => 8); }
+PACKUSWB        MMX     00001111 01100111 !emit { modrm(); mem(size => 8); }
+
+PUNPCKHBW       MMX     00001111 01101000 !emit { modrm(); mem(size => 8); }
+PUNPCKHWD       MMX     00001111 01101001 !emit { modrm(); mem(size => 8); }
+PUNPCKHDQ       MMX     00001111 01101010 !emit { modrm(); mem(size => 8); }
+
+PUNPCKLBW       MMX     00001111 01100000 !emit { modrm(); mem(size => 4); }
+PUNPCKLWD       MMX     00001111 01100001 !emit { modrm(); mem(size => 4); }
+PUNPCKLDQ       MMX     00001111 01100010 !emit { modrm(); mem(size => 4); }
+
+# State Management Instructions
+EMMS            MMX     00001111 01110111 !emit { }
-- 
2.20.1


