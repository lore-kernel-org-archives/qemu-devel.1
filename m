Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF15BC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEE1208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAwyoUoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEE1208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhoAU-0005Go-Mz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56720)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2z-0005EF-Fe
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho2y-0004a3-0U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:09 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:32954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho2x-0004Zo-RZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:07 -0400
Received: by mail-yw1-xc43.google.com with SMTP id j190so7005591ywb.0
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IH3GD3EhnM/g2dAwWSuzt1QlhenCjQklM/YkZP9RYQc=;
 b=QAwyoUoTYwlLjZGG2+7dFtCipH8Nr2kVcOujmiFnFC63rBSkRgHkcXwFxfLk6JT5HS
 4DdtcQNQxV4AGQdPyxOjs9Q6nRVvdv2HRG+7wnQ/st2UuQcf5XcqjJ9lohGcnKHggAt0
 1bS0WfZf+KVewzBCfn/54Qu0Lz+h6WNzNgBelLq73Ti0GwctJeIpEccmMDHV4XbOJTEM
 qpQ6+g3JDukxS7nGdVev0s/6GF4vPbrAZYBbtuoNTm+/PsCXUpeDHDcWHz9KKvf6xDj1
 s/NKtYP2RjQi6mEwwqkipy6T2ovVyb+hQvxvPhnDPKla5w18sGK/wAPr0gxpFcEpZ29O
 j9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IH3GD3EhnM/g2dAwWSuzt1QlhenCjQklM/YkZP9RYQc=;
 b=fi/jXYdoYSW1mV9/3ggrEHj1ADcu8CeO4JcecEHL+ytTk4SClu5eY9g9a/W3KHMsI2
 kjnAEGdBZ5tIcyDWQUwJmaqekVthJyDIolAaDZVu0TCjujhtRYF1RZrtPOVfqoZG127c
 t4rQf/NjKST5xaGT/vf3BwF0i2PDS7UH4IeNJpERA8KlN80n0Xls28gNEoHbTV6oAS2F
 crzyZdHmaXZouhsEp32EqTr4DrVrSM+G5iwdAmt1l1RYZ4wEwf+oGT0c2feYUryjyDJu
 Z7H+ChREvj1K7WH8KrSlPNxicXkrBMCWtmwzHnkflmmn6vpnDzMBuie3pDTpWc3x9ffR
 KV7g==
X-Gm-Message-State: APjAAAU7MvVPalDEffiMggdFtRHI8UPzG8FSfBTZB0rTanZqN4B07EK6
 lNngGb60AFtrspbYFp0JXb3/69XP
X-Google-Smtp-Source: APXvYqz9+ouyq5L9ykirJoTzbo+eNi51c5xNuFfQyrNcwPNZA7JcoiDT/dFEfiX1Ih+eMraAX4daqw==
X-Received: by 2002:a81:2e0a:: with SMTP id u10mr13703995ywu.479.1561955766775; 
 Sun, 30 Jun 2019 21:36:06 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.36.05
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:36:06 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:32 -0400
Message-Id: <20190701043536.26019-11-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RISU RFC PATCH v2 10/14] x86.risu: add SSSE3
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

Add SSSE3 instructions to the x86 configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/x86.risu b/x86.risu
index 01181dd..35992d6 100644
--- a/x86.risu
+++ b/x86.risu
@@ -77,6 +77,13 @@ ADDPD           SSE2    00001111 01011000 !emit { data16(); modrm(); mem(size =>
 ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
 ADDSD           SSE2    00001111 01011000 !emit { repne(); modrm(); mem(size => 8); }
 
+PHADDW_64       SSSE3   00001111 00111000 00000001 !emit { modrm(); mem(size => 8); }
+PHADDW          SSSE3   00001111 00111000 00000001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PHADDD_64       SSSE3   00001111 00111000 00000010 !emit { modrm(); mem(size => 8); }
+PHADDD          SSSE3   00001111 00111000 00000010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PHADDSW_64      SSSE3   00001111 00111000 00000011 !emit { modrm(); mem(size => 8); }
+PHADDSW         SSSE3   00001111 00111000 00000011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 HADDPS          SSE3    00001111 01111100 !emit { repne(); modrm(); mem(size => 16, align => 16); }
 HADDPD          SSE3    00001111 01111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
@@ -102,6 +109,13 @@ SUBPD           SSE2    00001111 01011100 !emit { data16(); modrm(); mem(size =>
 SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
 SUBSD           SSE2    00001111 01011100 !emit { repne(); modrm(); mem(size => 8); }
 
+PHSUBW_64       SSSE3   00001111 00111000 00000101 !emit { modrm(); mem(size => 8); }
+PHSUBW          SSSE3   00001111 00111000 00000101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PHSUBD_64       SSSE3   00001111 00111000 00000110 !emit { modrm(); mem(size => 8); }
+PHSUBD          SSSE3   00001111 00111000 00000110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PHSUBSW_64      SSSE3   00001111 00111000 00000111 !emit { modrm(); mem(size => 8); }
+PHSUBSW         SSSE3   00001111 00111000 00000111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 HSUBPS          SSE3    00001111 01111101 !emit { repne(); modrm(); mem(size => 16, align => 16); }
 HSUBPD          SSE3    00001111 01111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
@@ -117,6 +131,9 @@ PMULHUW         SSE2    00001111 11100100 !emit { data16(); modrm(); mem(size =>
 PMULUDQ_64      SSE2    00001111 11110100 !emit { modrm(); mem(size => 8); }
 PMULUDQ         SSE2    00001111 11110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
+PMULHRSW_64     SSSE3   00001111 00111000 00001011 !emit { modrm(); mem(size => 8); }
+PMULHRSW        SSSE3   00001111 00111000 00001011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
 MULPD           SSE2    00001111 01011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
@@ -124,6 +141,8 @@ MULSD           SSE2    00001111 01011001 !emit { repne(); modrm(); mem(size =>
 
 PMADDWD         MMX     00001111 11110101 !emit { modrm(); mem(size => 8); }
 PMADDWD         SSE2    00001111 11110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PMADDUBSW_64    SSSE3   00001111 00111000 00000100 !emit { modrm(); mem(size => 8); }
+PMADDUBSW       SSSE3   00001111 00111000 00000100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
 DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
 DIVPD           SSE2    00001111 01011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -169,6 +188,20 @@ PAVGW           SSE2    00001111 11100011 !emit { data16(); modrm(); mem(size =>
 PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
 PSADBW          SSE2    00001111 11110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
+PABSB_64        SSSE3   00001111 00111000 00011100 !emit { modrm(); mem(size => 8); }
+PABSB           SSSE3   00001111 00111000 00011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PABSW_64        SSSE3   00001111 00111000 00011101 !emit { modrm(); mem(size => 8); }
+PABSW           SSSE3   00001111 00111000 00011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PABSD_64        SSSE3   00001111 00111000 00011110 !emit { modrm(); mem(size => 8); }
+PABSD           SSSE3   00001111 00111000 00011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
+PSIGNB_64       SSSE3   00001111 00111000 00001000 !emit { modrm(); mem(size => 8); }
+PSIGNB          SSSE3   00001111 00111000 00001000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSIGNW_64       SSSE3   00001111 00111000 00001001 !emit { modrm(); mem(size => 8); }
+PSIGNW          SSSE3   00001111 00111000 00001001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+PSIGND_64       SSSE3   00001111 00111000 00001010 !emit { modrm(); mem(size => 8); }
+PSIGND          SSSE3   00001111 00111000 00001010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
+
 # Comparison Instructions
 PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
 PCMPEQB         SSE2    00001111 01110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -256,6 +289,9 @@ PSRAW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIR
 PSRAD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 
+PALIGNR_64      SSSE3   00001111 00111010 00001111 !emit { modrm(); mem(size => 8); imm(size => 1); }
+PALIGNR         SSSE3   00001111 00111010 00001111 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
+
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Scatter Instructions
 PACKSSWB        MMX     00001111 01100011 !emit { modrm(); mem(size => 8); }
 PACKSSWB        SSE2    00001111 01100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
@@ -285,6 +321,8 @@ UNPCKLPD        SSE2    00001111 00010100 !emit { data16(); modrm(); mem(size =>
 UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
 UNPCKHPD        SSE2    00001111 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 
+PSHUFB_64       SSSE3   00001111 00111000 00000000 !emit { modrm(); mem(size => 8); }
+PSHUFB          SSSE3   00001111 00111000 00000000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
 PSHUFLW         SSE2    00001111 01110000 !emit { repne(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 PSHUFHW         SSE2    00001111 01110000 !emit { rep(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
-- 
2.20.1


