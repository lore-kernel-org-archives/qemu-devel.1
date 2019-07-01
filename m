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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521E8C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E738C208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 04:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJqAvyqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E738C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hho9A-0003Z6-2i
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 00:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.bobek@gmail.com>) id 1hho3B-0005Oh-AA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1hho32-0004cd-EM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:21 -0400
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:44345)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1hho32-0004cK-4E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 00:36:12 -0400
Received: by mail-yw1-xc43.google.com with SMTP id l79so7842467ywe.11
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 21:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=87BBOQgDA0ss9OHTsYsq6gFoOhRXz3hd+pluH/iPg0Y=;
 b=qJqAvyqLrbbpsHNkXeVZUexY9ewjY+MLwq+0B5XuCF9wOSVaB6SqSQQH4WVmAajd69
 vfXnadhxjElHsHKB68AT0bNX0Th/RKa84kPJAh+YTKubdfGAynoWk1PT8LXTekSuOlhM
 5NR09lsTy/odVIuDG1KxAK9RHv5FPkKXUg6RvVJrKWtI2ZXFI7/SnCu3/iLl7v1x516b
 jV/G2Ggo7/HhOMY9VHXRSndF8rf2mAWNX/z+2W7gvnJmSP3EIJyLfzl9MhidPtE1s5hH
 H3EMIj19DajR5zBnF5qKrpVs0DA6or5FjGqMMP5FlW5MTenZokLqHlObFVhaUgYKBH2V
 C+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=87BBOQgDA0ss9OHTsYsq6gFoOhRXz3hd+pluH/iPg0Y=;
 b=OhbKerxzMavLJeK9pFGxDVdqHNiwmwlgVJSbJ6VN29KsahaJYNzCS7Uyw3+wzED6s7
 xLzuwzu5Bamx1v+vBpV6+D/8J/9G/bXSBtkp7nhVz2CMYuU+i9EedizLmZkGcot00U/6
 ze+wc4DFifsJLWjU7HWY/AjIluv3zpkF7FtR4R1SJV7Y1YFqcVbkl0qHCpPl+vnsTrjy
 f1xumDZG6QvEmeRkeEDl2cgNvqS33gRoPHJeWkf5NMTDIT3QDPoNbbsTnkVqHAURLsc0
 gJrzrHxEI031RnH2RjEL+Tn5sxQTFsKh01H7qyQYyDo57vZRmIdP6H1+KPg84Ptg0CJQ
 9DFg==
X-Gm-Message-State: APjAAAUnEQUq4Uital9xjIOmXwYSJQ/ApPb51d/wjzW/dfvIFikWQjql
 7QZSj3tXp+pyDWIjQxbvXRhpaMZ9
X-Google-Smtp-Source: APXvYqz3ko0M9SfBSEt2UclS0+Bx92g79KtkO2KAhnFVBqIWVVsgc7NummyWNoFmEUpBgQxUl7mJbg==
X-Received: by 2002:a81:6f84:: with SMTP id
 k126mr13295044ywc.154.1561955769731; 
 Sun, 30 Jun 2019 21:36:09 -0700 (PDT)
Received: from dionysus.attlocal.net
 (69-222-133-165.lightspeed.tukrga.sbcglobal.net. [69.222.133.165])
 by smtp.gmail.com with ESMTPSA id k126sm1108564ywf.36.2019.06.30.21.36.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 30 Jun 2019 21:36:09 -0700 (PDT)
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 00:35:36 -0400
Message-Id: <20190701043536.26019-15-jan.bobek@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701043536.26019-1-jan.bobek@gmail.com>
References: <20190701043536.26019-1-jan.bobek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c43
Subject: [Qemu-devel] [RISU RFC PATCH v2 14/14] x86.risu: add AVX2
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

Add AVX2 instructions to the configuration file.

Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
---
 x86.risu | 257 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)

diff --git a/x86.risu b/x86.risu
index d3115ac..74c4ce8 100644
--- a/x86.risu
+++ b/x86.risu
@@ -33,16 +33,22 @@ VMOVQ_xmm2      AVX              11010110 !emit { vex(l => VEX_L_128, p => VEX_P
 
 MOVAPS          SSE     00001111 0010100 d !emit { modrm(); mem(size => 16, align => 16); }
 VMOVAPS         AVX              0010100 d !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16, align => 16); }
+VMOVAPS         AVX2             0010100 d !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32, align => 32); }
 MOVAPD          SSE2    00001111 0010100 d !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VMOVAPD         AVX              0010100 d !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16, align => 16); }
+VMOVAPD         AVX2             0010100 d !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32, align => 32); }
 MOVDQA          SSE2    00001111 011 d 1111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VMOVDQA         AVX              011 d 1111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16, align => 16); }
+VMOVDQA         AVX2             011 d 1111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32, align => 32); }
 MOVUPS          SSE     00001111 0001000 d !emit { modrm(); mem(size => 16); }
 VMOVUPS         AVX              0001000 d !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VMOVUPS         AVX2             0001000 d !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 MOVUPD          SSE2    00001111 0001000 d !emit { data16(); modrm(); mem(size => 16); }
 VMOVUPD         AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VMOVUPD         AVX2             0001000 d !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 MOVDQU          SSE2    00001111 011 d 1111 !emit { rep(); modrm(); mem(size => 16); }
 VMOVDQU         AVX              011 d 1111 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VMOVDQU         AVX2             011 d 1111 !emit { vex(l => VEX_L_256, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 MOVSS           SSE     00001111 0001000 d !emit { rep(); modrm(); mem(size => 4); }
 VMOVSS          AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F); modrm(mod => MOD_DIRECT); }
 VMOVSS_mem      AVX              0001000 d !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 4); }
@@ -73,50 +79,67 @@ VMOVHLPS        AVX              00010010  !emit { vex(l => VEX_L_128, m => VEX_
 PMOVMSKB        SSE     00001111 11010111 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 PMOVMSKB        SSE2    00001111 11010111 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 VPMOVMSKB       AVX              11010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+VPMOVMSKB       AVX2             11010111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 MOVMSKPS        SSE     00001111 01010000 !emit { modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 VMOVMSKPS       AVX              01010000 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+VMOVMSKPS       AVX2             01010000 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 MOVMKSPD        SSE2    00001111 01010000 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 VMOVMSKPD       AVX              01010000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
+VMOVMSKPD       AVX2             01010000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); }
 
 LDDQU           SSE3    00001111 11110000 !emit { repne(); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
 VLDDQU          AVX              11110000 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VLDDQU          AVX2             11110000 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 32); }
 MOVSHDUP        SSE3    00001111 00010110 !emit { rep(); modrm(); mem(size => 16, align => 16); }
 VMOVSHDUP       AVX              00010110 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VMOVSHDUP       AVX2             00010110 !emit { vex(l => VEX_L_256, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 MOVSLDUP        SSE3    00001111 00010010 !emit { rep(); modrm(); mem(size => 16, align => 16); }
 VMOVSLDUP       AVX              00010010 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VMOVSLDUP       AVX2             00010010 !emit { vex(l => VEX_L_256, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 MOVDDUP         SSE3    00001111 00010010 !emit { repne(); modrm(); mem(size => 8); }
 VMOVDDUP        AVX              00010010 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VMOVDDUP        AVX2             00010010 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 
 # Arithmetic Instructions
 PADDB           MMX     00001111 11111100 !emit { modrm(); mem(size => 8); }
 PADDB           SSE2    00001111 11111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDB          AVX              11111100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDB          AVX2             11111100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDW           MMX     00001111 11111101 !emit { modrm(); mem(size => 8); }
 PADDW           SSE2    00001111 11111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDW          AVX              11111101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDW          AVX2             11111101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDD           MMX     00001111 11111110 !emit { modrm(); mem(size => 8); }
 PADDD           SSE2    00001111 11111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDD          AVX              11111110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDD          AVX2             11111110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDQ           MMX     00001111 11010100 !emit { modrm(); mem(size => 8); }
 PADDQ           SSE2    00001111 11010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDQ          AVX              11010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDQ          AVX2             11010100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDSB          MMX     00001111 11101100 !emit { modrm(); mem(size => 8); }
 PADDSB          SSE2    00001111 11101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDSB         AVX              11101100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDSB         AVX2             11101100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDSW          MMX     00001111 11101101 !emit { modrm(); mem(size => 8); }
 PADDSW          SSE2    00001111 11101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDSW         AVX              11101101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDSW         AVX2             11101101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDUSB         MMX     00001111 11011100 !emit { modrm(); mem(size => 8); }
 PADDUSB         SSE2    00001111 11011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDUSB        AVX              11011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDUSB        AVX2             11011100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PADDUSW         MMX     00001111 11011101 !emit { modrm(); mem(size => 8); }
 PADDUSW         SSE2    00001111 11011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPADDUSW        AVX              11011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPADDUSW        AVX2             11011101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 ADDPS           SSE     00001111 01011000 !emit { modrm(); mem(size => 16, align => 16); }
 VADDPS          AVX              01011000 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VADDPS          AVX2             01011000 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 ADDPD           SSE2    00001111 01011000 !emit { data16(); modrm(); mem(size => 16, align => 16) }
 VADDPD          AVX              01011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VADDPD          AVX2             01011000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 ADDSS           SSE     00001111 01011000 !emit { rep(); modrm(); mem(size => 4); }
 VADDSS          AVX              01011000 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 ADDSD           SSE2    00001111 01011000 !emit { repne(); modrm(); mem(size => 8); }
@@ -125,47 +148,62 @@ VADDSD          AVX              01011000 !emit { vex(l => 0, p => VEX_P_REPNE,
 PHADDW_64       SSSE3   00001111 00111000 00000001 !emit { modrm(); mem(size => 8); }
 PHADDW          SSSE3   00001111 00111000 00000001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPHADDW         AVX                       00000001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPHADDW         AVX2                      00000001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PHADDD_64       SSSE3   00001111 00111000 00000010 !emit { modrm(); mem(size => 8); }
 PHADDD          SSSE3   00001111 00111000 00000010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPHADDD         AVX                       00000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPHADDD         AVX2                      00000010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PHADDSW_64      SSSE3   00001111 00111000 00000011 !emit { modrm(); mem(size => 8); }
 PHADDSW         SSSE3   00001111 00111000 00000011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPHADDSW        AVX                       00000011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPHADDSW        AVX2                      00000011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 HADDPS          SSE3    00001111 01111100 !emit { repne(); modrm(); mem(size => 16, align => 16); }
 VHADDPS         AVX              01111100 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 16); }
+VHADDPS         AVX2             01111100 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 32); }
 HADDPD          SSE3    00001111 01111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VHADDPD         AVX              01111100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VHADDPD         AVX2             01111100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PSUBB           MMX     00001111 11111000 !emit { modrm(); mem(size => 8); }
 PSUBB           SSE2    00001111 11111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBB          AVX              11111000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBB          AVX2             11111000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBW           MMX     00001111 11111001 !emit { modrm(); mem(size => 8); }
 PSUBW           SSE2    00001111 11111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBW          AVX              11111001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBW          AVX2             11111001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBD           MMX     00001111 11111010 !emit { modrm(); mem(size => 8); }
 PSUBD           SSE2    00001111 11111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBD          AVX              11111010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBD          AVX2             11111010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBQ_64        SSE2    00001111 11111011 !emit { modrm(); mem(size => 8); }
 PSUBQ           SSE2    00001111 11111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBQ          AVX              11111011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBQ          AVX2             11111011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBSB          MMX     00001111 11101000 !emit { modrm(); mem(size => 8); }
 PSUBSB          SSE2    00001111 11101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBSB         AVX              11101000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBSB         AVX2             11101000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBSW          MMX     00001111 11101001 !emit { modrm(); mem(size => 8); }
 PSUBSW          SSE2    00001111 11101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBSW         AVX              11101001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBSW         AVX2             11101001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBUSB         MMX     00001111 11011000 !emit { modrm(); mem(size => 8); }
 PSUBUSB         SSE2    00001111 11011000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBUSB        AVX              11011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBUSB        AVX2             11011000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PSUBUSW         MMX     00001111 11011001 !emit { modrm(); mem(size => 8); }
 PSUBUSW         SSE2    00001111 11011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSUBUSW        AVX              11011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSUBUSW        AVX2             11011000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 SUBPS           SSE     00001111 01011100 !emit { modrm(); mem(size => 16, align => 16); }
 VSUBPS          AVX              01011100 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VSUBPS          AVX2             01011100 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 SUBPD           SSE2    00001111 01011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VSUBPD          AVX              01011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VSUBPD          AVX2             01011100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 SUBSS           SSE     00001111 01011100 !emit { rep(); modrm(); mem(size => 4); }
 VSUBSS          AVX              01011100 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 SUBSD           SSE2    00001111 01011100 !emit { repne(); modrm(); mem(size => 8); }
@@ -174,48 +212,64 @@ VSUBSD          AVX              01011100 !emit { vex(l => 0, p => VEX_P_REPNE,
 PHSUBW_64       SSSE3   00001111 00111000 00000101 !emit { modrm(); mem(size => 8); }
 PHSUBW          SSSE3   00001111 00111000 00000101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPHSUBW         AVX                       00000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPHSUBW         AVX2                      00000101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PHSUBD_64       SSSE3   00001111 00111000 00000110 !emit { modrm(); mem(size => 8); }
 PHSUBD          SSSE3   00001111 00111000 00000110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPHSUBD         AVX                       00000110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPHSUBD         AVX2                      00000110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PHSUBSW_64      SSSE3   00001111 00111000 00000111 !emit { modrm(); mem(size => 8); }
 PHSUBSW         SSSE3   00001111 00111000 00000111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPHSUBSW        AVX                       00000111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPHSUBSW        AVX2                      00000111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 HSUBPS          SSE3    00001111 01111101 !emit { repne(); modrm(); mem(size => 16, align => 16); }
 VHSUBPS         AVX              01111101 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 16); }
+VHSUBPS         AVX2             01111101 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 32); }
 HSUBPD          SSE3    00001111 01111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VHSUBPD         AVX              01111101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VHSUBPD         AVX2             01111101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 ADDSUBPS        SSE3    00001111 11010000 !emit { repne(); modrm(); mem(size => 16, align => 16); }
 VADDSUBPS       AVX              11010000 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 16); }
+VADDSUBPS       AVX2             11010000 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F); modrm(); mem(size => 32); }
 ADDSUBPD        SSE3    00001111 11010000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VADDSUBPD       AVX              11010000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VADDSUBPD       AVX2             11010000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PMULLW          MMX     00001111 11010101 !emit { modrm(); mem(size => 8); }
 PMULLW          SSE2    00001111 11010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULLW         AVX              11010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMULLW         AVX2             11010101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMULLD          SSE4_1  00001111 00111000 01000000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULLD         AVX                       01000000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMULLD         AVX2                      01000000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMULHW          MMX     00001111 11100101 !emit { modrm(); mem(size => 8); }
 PMULHW          SSE2    00001111 11100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULHW         AVX              11100101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMULHW         AVX2             11100101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMULHUW         SSE     00001111 11100100 !emit { modrm(); mem(size => 8); }
 PMULHUW         SSE2    00001111 11100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULHUW        AVX              11100100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMULHUW        AVX2             11100100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMULDQ          SSE4_1  00001111 00111000 00101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULDQ         AVX                       00101000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMULDQ         AVX2                      00101000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMULUDQ_64      SSE2    00001111 11110100 !emit { modrm(); mem(size => 8); }
 PMULUDQ         SSE2    00001111 11110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULUDQ        AVX              11110100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMULUDQ        AVX2             11110100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PMULHRSW_64     SSSE3   00001111 00111000 00001011 !emit { modrm(); mem(size => 8); }
 PMULHRSW        SSSE3   00001111 00111000 00001011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMULHRSW       AVX                       00001011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMULHRSW       AVX2                      00001011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 MULPS           SSE     00001111 01011001 !emit { modrm(); mem(size => 16, align => 16); }
 VMULPS          AVX              01011001 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VMULPS          AVX2             01011001 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 MULPD           SSE2    00001111 01011001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VMULPD          AVX              01011001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VMULPD          AVX2             01011001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 MULSS           SSE     00001111 01011001 !emit { rep(); modrm(); mem(size => 4); }
 VMULSS          AVX              01011001 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 MULSD           SSE2    00001111 01011001 !emit { repne(); modrm(); mem(size => 8); }
@@ -224,14 +278,18 @@ VMULSD          AVX              01011001 !emit { vex(l => VEX_L_128, p => VEX_P
 PMADDWD         MMX     00001111 11110101 !emit { modrm(); mem(size => 8); }
 PMADDWD         SSE2    00001111 11110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMADDWD        AVX              11110101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMADDWD        AVX2             11110101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMADDUBSW_64    SSSE3   00001111 00111000 00000100 !emit { modrm(); mem(size => 8); }
 PMADDUBSW       SSSE3   00001111 00111000 00000100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMADDUBSW      AVX                       00000100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMADDUBSW      AVX2                      00000100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 DIVPS           SSE     00001111 01011110 !emit { modrm(); mem(size => 16, align => 16); }
 VDIVPS          AVX              01011110 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VDIVPS          AVX2             01011110 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 DIVPD           SSE2    00001111 01011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VDIVPD          AVX              01011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VDIVPD          AVX2             01011110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 DIVSS           SSE     00001111 01011110 !emit { rep(); modrm(); mem(size => 4); }
 VDIVSS          AVX              01011110 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 DIVSD           SSE2    00001111 01011110 !emit { repne(); modrm(); mem(size => 8); }
@@ -239,13 +297,16 @@ VDIVSD          AVX              01011110 !emit { vex(l => 0, p => VEX_P_REPNE,
 
 RCPPS           SSE     00001111 01010011 !emit { modrm(); mem(size => 16, align => 16); }
 VRCPPS          AVX              01010011 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VRCPPS          AVX2             01010011 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 RCPSS           SSE     00001111 01010011 !emit { rep(); modrm(); mem(size => 4); }
 VRCPSS          AVX              01010011 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 
 SQRTPS          SSE     00001111 01010001 !emit { modrm(); mem(size => 16, align => 16); }
 VSQRTPS         AVX              01010001 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VSQRTPS         AVX2             01010001 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 SQRTPD          SSE2    00001111 01010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VSQRTPD         AVX              01010001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VSQRTPD         AVX2             01010001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 SQRTSS          SSE     00001111 01010001 !emit { rep(); modrm(); mem(size => 4); }
 VSQRTSS         AVX              01010001 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 SQRTSD          SSE2    00001111 01010001 !emit { repne(); modrm(); mem(size => 8); }
@@ -253,28 +314,37 @@ VSQRTSD         AVX              01010001 !emit { vex(l => 0, p => VEX_P_REPNE,
 
 RSQRTPS         SSE     00001111 01010010 !emit { modrm(); mem(size => 16, align => 16); }
 VRSQRTPS        AVX              01010010 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VRSQRTPS        AVX2             01010010 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 RSQRTSS         SSE     00001111 01010010 !emit { rep(); modrm(); mem(size => 4); }
 VRSQRTSS        AVX              01010010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 
 PMINUB          SSE     00001111 11011010 !emit { modrm(); mem(size => 8); }
 PMINUB          SSE2    00001111 11011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMINUB         AVX              11011010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMINUB         AVX2             11011010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMINUW          SSE4_1  00001111 00111000 00111010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMINUW         AVX                       00111010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMINUW         AVX2                      00111010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMINUD          SSE4_1  00001111 00111000 00111011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMINUD         AVX                       00111011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMINUD         AVX2                      00111011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMINSB          SSE4_1  00001111 00111000 00111000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMINSB         AVX                       00111000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMINSB         AVX2                      00111000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMINSW          SSE     00001111 11101010 !emit { modrm(); mem(size => 8); }
 PMINSW          SSE2    00001111 11101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMINSW         AVX              11101010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMINSW         AVX2             11101010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMINSD          SSE4_1  00001111 00111000 00111001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMINSD         AVX                       00111001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMINSD         AVX2                      00111001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 MINPS           SSE     00001111 01011101 !emit { modrm(); mem(size => 16, align => 16); }
 VMINPS          AVX              01011101 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VMINPS          AVX2             01011101 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 MINPD           SSE2    00001111 01011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VMINPD          AVX              01011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VMINPD          AVX2             01011101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 MINSS           SSE     00001111 01011101 !emit { rep(); modrm(); mem(size => 4); }
 VMINSS          AVX              01011101 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 MINSD           SSE2    00001111 01011101 !emit { repne(); modrm(); mem(size => 8); }
@@ -286,22 +356,30 @@ VPHMINPOSUW     AVX                       01000001 !emit { vex(l => VEX_L_128, p
 PMAXUB          SSE     00001111 11011110 !emit { modrm(); mem(size => 8); }
 PMAXUB          SSE2    00001111 11011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMAXUB         AVX              11011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMAXUB         AVX2             11011110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMAXUW          SSE4_1  00001111 00111000 00111110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMAXUW         AVX                       00111110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMAXUW         AVX2                      00111110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMAXUD          SSE4_1  00001111 00111000 00111111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMAXUD         AVX                       00111111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMAXUD         AVX2                      00111111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMAXSB          SSE4_1  00001111 00111000 00111100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMAXSB         AVX                       00111100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMAXSB         AVX2                      00111100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PMAXSW          SSE     00001111 11101110 !emit { modrm(); mem(size => 8); }
 PMAXSW          SSE2    00001111 11101110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMAXSW         AVX              11101110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPMAXSW         AVX2             11101110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PMAXSD          SSE4_1  00001111 00111000 00111101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPMAXSD         AVX                       00111101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPMAXSD         AVX2                      00111101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 MAXPS           SSE     00001111 01011111 !emit { modrm(); mem(size => 16, align => 16); }
 VMAXPS          AVX              01011111 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VMAXPS          AVX2             01011111 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 MAXPD           SSE2    00001111 01011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VMAXPD          AVX              01011111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VMAXPD          AVX2             01011111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 MAXSS           SSE     00001111 01011111 !emit { rep(); modrm(); mem(size => 4); }
 VMAXSS          AVX              01011111 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 MAXSD           SSE2    00001111 01011111 !emit { repne(); modrm(); mem(size => 8); }
@@ -310,45 +388,58 @@ VMAXSD          AVX              01011111 !emit { vex(l => 0, p => VEX_P_REPNE,
 PAVGB           SSE     00001111 11100000 !emit { modrm(); mem(size => 8); }
 PAVGB           SSE2    00001111 11100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPAVGB          AVX              11100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPAVGB          AVX2             11100000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PAVGW           SSE     00001111 11100011 !emit { modrm(); mem(size => 8); }
 PAVGW           SSE2    00001111 11100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPAVGW          AVX              11100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPAVGW          AVX2             11100011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PSADBW          SSE     00001111 11110110 !emit { modrm(); mem(size => 8); }
 PSADBW          SSE2    00001111 11110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSADBW         AVX              11110110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSADBW         AVX2             11110110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 MPSADBW         SSE4_1  00001111 00111010 01000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VMPSADBW        AVX                       01000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
+VMPSADBW        AVX2                      01000010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 32); imm(size => 1); }
 
 PABSB_64        SSSE3   00001111 00111000 00011100 !emit { modrm(); mem(size => 8); }
 PABSB           SSSE3   00001111 00111000 00011100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPABSB          AVX                       00011100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VPABSB          AVX2                      00011100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 PABSW_64        SSSE3   00001111 00111000 00011101 !emit { modrm(); mem(size => 8); }
 PABSW           SSSE3   00001111 00111000 00011101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPABSW          AVX                       00011101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VPABSW          AVX2                      00011101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 PABSD_64        SSSE3   00001111 00111000 00011110 !emit { modrm(); mem(size => 8); }
 PABSD           SSSE3   00001111 00111000 00011110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPABSD          AVX                       00011110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VPABSD          AVX2                      00011110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 
 PSIGNB_64       SSSE3   00001111 00111000 00001000 !emit { modrm(); mem(size => 8); }
 PSIGNB          SSSE3   00001111 00111000 00001000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSIGNB         AVX                       00001000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPSIGNB         AVX2                      00001000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PSIGNW_64       SSSE3   00001111 00111000 00001001 !emit { modrm(); mem(size => 8); }
 PSIGNW          SSSE3   00001111 00111000 00001001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSIGNW         AVX                       00001001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPSIGNW         AVX2                      00001001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PSIGND_64       SSSE3   00001111 00111000 00001010 !emit { modrm(); mem(size => 8); }
 PSIGND          SSSE3   00001111 00111000 00001010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSIGND         AVX                       00001010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPSIGND         AVX2                      00001010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 DPPS            SSE4_1  00001111 00111010 01000000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VDPPS           AVX                       01000000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
+VDPPS           AVX2                      01000000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 32); imm(size => 1); }
 DPPD            SSE4_1  00001111 00111010 01000001 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VDPPD           AVX                       01000001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
 
 ROUNDPS         SSE4_1  00001111 00111010 00001000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VROUNDPS        AVX                       00001000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VROUNDPS        AVX2                      00001000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
 ROUNDPD         SSE4_1  00001111 00111010 00001001 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VROUNDPD        AVX                       00001001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VROUNDPD        AVX2                      00001001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
 ROUNDSS         SSE4_1  00001111 00111010 00001010 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
 VROUNDSS        AVX                       00001010 !emit { vex(l => 0, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 4); imm(size => 1); }
 ROUNDSD         SSE4_1  00001111 00111010 00001011 !emit { data16(); modrm(); mem(size => 8); imm(size => 1); }
@@ -376,25 +467,33 @@ VPCLMULQDQ      PCLMULQDQ_AVX                    01000100 !emit { vex(l => VEX_L
 PCMPEQB         MMX     00001111 01110100 !emit { modrm(); mem(size => 8); }
 PCMPEQB         SSE2    00001111 01110100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPEQB        AVX              01110100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPCMPEQB        AVX2             01110100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PCMPEQW         MMX     00001111 01110101 !emit { modrm(); mem(size => 8); }
 PCMPEQW         SSE2    00001111 01110101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPEQW        AVX              01110101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPCMPEQW        AVX2             01110101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PCMPEQD         MMX     00001111 01110110 !emit { modrm(); mem(size => 8); }
 PCMPEQD         SSE2    00001111 01110110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPEQD        AVX              01110110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPCMPEQD        AVX2             01110110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PCMPEQQ         SSE4_1  00001111 00111000 00101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPEQQ        AVX                       00101001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPCMPEQQ        AVX2                      00101001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PCMPGTB         MMX     00001111 01100100 !emit { modrm(); mem(size => 8); }
 PCMPGTB         SSE2    00001111 01100100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPGTB        AVX              01100100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPCMPGTB        AVX2             01100100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PCMPGTW         MMX     00001111 01100101 !emit { modrm(); mem(size => 8); }
 PCMPGTW         SSE2    00001111 01100101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPGTW        AVX              01100101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPCMPGTW        AVX2             01100101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PCMPGTD         MMX     00001111 01100110 !emit { modrm(); mem(size => 8); }
 PCMPGTD         SSE2    00001111 01100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPGTD        AVX              01100110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPCMPGTD        AVX2             01100110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PCMPGTQ         SSE4_2  00001111 00111000 00110111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPCMPGTQ        AVX                       00110111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPCMPGTQ        AVX2                      00110111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 PCMPESTRM       SSE4_2  00001111 00111010 01100000 !emit { data16(); modrm(); mem(size => 16); imm(size => 1); }
 VPCMPESTRM      AVX                       01100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
@@ -407,14 +506,19 @@ VPCMPISTRI      AVX                       01100011 !emit { vex(l => VEX_L_128, p
 
 PTEST           SSE4_1  00001111 00111000 00010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPTEST          AVX                       00010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VPTEST          AVX2                      00010111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 
 VTESTPS         AVX     00001110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VTESTPS         AVX2    00001110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 VTESTPD         AVX     00001111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VTESTPD         AVX2    00001111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 
 CMPPS           SSE     00001111 11000010 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VCMPPS          AVX              11000010 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
+VCMPPS          AVX2             11000010 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); imm(size => 1); }
 CMPPD           SSE2    00001111 11000010 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VCMPPD          AVX              11000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
+VCMPPD          AVX2             11000010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); imm(size => 1); }
 CMPSS           SSE     00001111 11000010 !emit { rep(); modrm(); mem(size => 4); imm(size => 1); }
 VCMPSS          AVX              11000010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); imm(size => 1); }
 CMPSD           SSE2    00001111 11000010 !emit { repne(); modrm(); mem(size => 8); imm(size => 1); }
@@ -434,172 +538,246 @@ VCOMISD         AVX              00101111 !emit { vex(l => 0, p => VEX_P_DATA16,
 PAND            MMX     00001111 11011011 !emit { modrm(); mem(size => 8); }
 PAND            SSE2    00001111 11011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPAND           AVX              11011011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPAND           AVX2             11011011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 ANDPS           SSE     00001111 01010100 !emit { modrm(); mem(size => 16, align => 16); }
 VANDPS          AVX              01010100 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VANDPS          AVX2             01010100 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 ANDPD           SSE2    00001111 01010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VANDPD          AVX              01010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VANDPD          AVX2             01010100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PANDN           MMX     00001111 11011111 !emit { modrm(); mem(size => 8); }
 PANDN           SSE2    00001111 11011111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPANDN          AVX              11011111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPANDN          AVX2             11011111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 ANDNPS          SSE     00001111 01010101 !emit { modrm(); mem(size => 16, align => 16); }
 VANDNPS         AVX              01010101 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VANDNPS         AVX2             01010101 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 ANDNPD          SSE2    00001111 01010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VANDNPD         AVX              01010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VANDNPD         AVX2             01010101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 POR             MMX     00001111 11101011 !emit { modrm(); mem(size => 8); }
 POR             SSE2    00001111 11101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPOR            AVX              11101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPOR            AVX2             11101011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 ORPS            SSE     00001111 01010110 !emit { modrm(); mem(size => 16, align => 16); }
 VORPS           AVX              01010110 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VORPS           AVX2             01010110 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 ORPD            SSE2    00001111 01010110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VORPD           AVX              01010110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VORPD           AVX2             01010110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PXOR            MMX     00001111 11101111 !emit { modrm(); mem(size => 8); }
 PXOR            SSE2    00001111 11101111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPXOR           AVX              11101111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPXOR           AVX2             11101111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 XORPS           SSE     00001111 01010111 !emit { modrm(); mem(size => 16, align => 16); }
 VXORPS          AVX              01010111 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VXORPS          AVX2             01010111 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 XORPD           SSE2    00001111 01010111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VXORPD          AVX              01010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VXORPD          AVX2             01010111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 # Shift and Rotate Instructions
 PSLLW           MMX     00001111 11110001 !emit { modrm(); mem(size => 8); }
 PSLLW           SSE2    00001111 11110001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSLLW          AVX              11110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSLLW          AVX2             11110001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSLLD           MMX     00001111 11110010 !emit { modrm(); mem(size => 8); }
 PSLLD           SSE2    00001111 11110010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSLLD          AVX              11110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSLLD          AVX2             11110010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSLLQ           MMX     00001111 11110011 !emit { modrm(); mem(size => 8); }
 PSLLQ           SSE2    00001111 11110011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSLLQ          AVX              11110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSLLQ          AVX2             11110011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSLLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
 VPSLLDQ         AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
+VPSLLDQ         AVX2             01110011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 7); imm(size => 1); }
 
 PSLLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 VPSLLW_imm      AVX              01110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+VPSLLW_imm      AVX2             01110001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 VPSLLD_imm      AVX              01110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+VPSLLD_imm      AVX2             01110010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 PSLLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
 VPSLLQ_imm      AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+VPSLLQ_imm      AVX2             01110011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 6); imm(size => 1); }
+
+VPSLLVD_xmm     AVX2    01000111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPSLLVD         AVX2    01000111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 32); }
+VPSLLVQ_xmm     AVX2    01000111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(); mem(size => 16); }
+VPSLLVQ         AVX2    01000111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(); mem(size => 32); }
 
 PSRLW           MMX     00001111 11010001 !emit { modrm(); mem(size => 8); }
 PSRLW           SSE2    00001111 11010001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSRLW          AVX              11010001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSRLW          AVX2             11010001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRLD           MMX     00001111 11010010 !emit { modrm(); mem(size => 8); }
 PSRLD           SSE2    00001111 11010010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSRLD          AVX              11010010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSRLD          AVX2             11010010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRLQ           MMX     00001111 11010011 !emit { modrm(); mem(size => 8); }
 PSRLQ           SSE2    00001111 11010011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSRLQ          AVX              11010011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSRLQ          AVX2             11010011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRLDQ          SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
 VPSRLDQ         AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
+VPSRLDQ         AVX2             01110011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 3); imm(size => 1); }
 
 PSRLW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 VPSRLW_imm      AVX              01110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+VPSRLW_imm      AVX2             01110001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 VPSRLD_imm      AVX              01110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+VPSRLD_imm      AVX2             01110010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLQ_imm       MMX     00001111 01110011 !emit { modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 PSRLQ_imm       SSE2    00001111 01110011 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
 VPSRLQ_imm      AVX              01110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+VPSRLQ_imm      AVX2             01110011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 2); imm(size => 1); }
+
+VPSRLVD_xmm     AVX2    01000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPSRLVD         AVX2    01000101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 32); }
+VPSRLVQ_xmm     AVX2    01000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(); mem(size => 16); }
+VPSRLVQ         AVX2    01000101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(); mem(size => 32); }
 
 PSRAW           MMX     00001111 11100001 !emit { modrm(); mem(size => 8); }
 PSRAW           SSE2    00001111 11100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSRAW          AVX              11100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSRAW          AVX2             11100001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 PSRAD           MMX     00001111 11100010 !emit { modrm(); mem(size => 8); }
 PSRAD           SSE2    00001111 11100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSRAD          AVX              11100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPSRAD          AVX2             11100010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
 
 PSRAW_imm       MMX     00001111 01110001 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAW_imm       SSE2    00001111 01110001 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 VPSRAW_imm      AVX              01110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+VPSRAW_imm      AVX2             01110001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAD_imm       MMX     00001111 01110010 !emit { modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 PSRAD_imm       SSE2    00001111 01110010 !emit { data16(); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
 VPSRAD_imm      AVX              01110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+VPSRAD_imm      AVX2             01110010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(mod => MOD_DIRECT, reg => 4); imm(size => 1); }
+
+VPSRAVD_xmm     AVX2    01000110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPSRAVD         AVX2    01000110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 32); }
 
 PALIGNR_64      SSSE3   00001111 00111010 00001111 !emit { modrm(); mem(size => 8); imm(size => 1); }
 PALIGNR         SSSE3   00001111 00111010 00001111 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VPALIGNR        AVX                       00001111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
+VPALIGNR        AVX2                      00001111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 32); imm(size => 1); }
 
 # Shuffle, Unpack, Blend, Insert, Extract, Broadcast, Permute, Scatter Instructions
 PACKSSWB        MMX     00001111 01100011 !emit { modrm(); mem(size => 8); }
 PACKSSWB        SSE2    00001111 01100011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPACKSSWB       AVX              01100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPACKSSWB       AVX2             01100011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PACKSSDW        MMX     00001111 01101011 !emit { modrm(); mem(size => 8); }
 PACKSSDW        SSE2    00001111 01101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPACKSSDW       AVX              01101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPACKSSDW       AVX2             01101011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PACKUSWB        MMX     00001111 01100111 !emit { modrm(); mem(size => 8); }
 PACKUSWB        SSE2    00001111 01100111 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPACKUSWB       AVX              01100111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPACKUSWB       AVX2             01100111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PACKUSDW        SSE4_1  00001111 00111000 00101011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPACKUSDW       AVX                       00101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPACKUSDW       AVX2                      00101011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 
 PUNPCKHBW       MMX     00001111 01101000 !emit { modrm(); mem(size => 8); }
 PUNPCKHBW       SSE2    00001111 01101000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKHBW      AVX              01101000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKHBW      AVX2             01101000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PUNPCKHWD       MMX     00001111 01101001 !emit { modrm(); mem(size => 8); }
 PUNPCKHWD       SSE2    00001111 01101001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKHWD      AVX              01101001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKHWD      AVX2             01101001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PUNPCKHDQ       MMX     00001111 01101010 !emit { modrm(); mem(size => 8); }
 PUNPCKHDQ       SSE2    00001111 01101010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKHDQ      AVX              01101010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKHDQ      AVX2             01101010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PUNPCKHQDQ      SSE2    00001111 01101101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKHQDQ     AVX              01101101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKHQDQ     AVX2             01101101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PUNPCKLBW       MMX     00001111 01100000 !emit { modrm(); mem(size => 4); }
 PUNPCKLBW       SSE2    00001111 01100000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKLBW      AVX              01100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKLBW      AVX2             01100000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PUNPCKLWD       MMX     00001111 01100001 !emit { modrm(); mem(size => 4); }
 PUNPCKLWD       SSE2    00001111 01100001 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKLWD      AVX              01100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKLWD      AVX2             01100001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PUNPCKLDQ       MMX     00001111 01100010 !emit { modrm(); mem(size => 4); }
 PUNPCKLDQ       SSE2    00001111 01100010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKLDQ      AVX              01100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKLDQ      AVX2             01100010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 PUNPCKLQDQ      SSE2    00001111 01101100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPUNPCKLQDQ     AVX              01101100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VPUNPCKLQDQ     AVX2             01101100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 UNPCKLPS        SSE     00001111 00010100 !emit { modrm(); mem(size => 16, align => 16); }
 VUNPCKLPS       AVX              00010100 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VUNPCKLPS       AVX2             00010100 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 UNPCKLPD        SSE2    00001111 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VUNPCKLPD       AVX              00010100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VUNPCKLPD       AVX2             00010100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 UNPCKHPS        SSE     00001111 00010101 !emit { modrm(); mem(size => 16, align => 16); }
 VUNPCKHPS       AVX              00010101 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); }
+VUNPCKHPS       AVX2             00010101 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); }
 UNPCKHPD        SSE2    00001111 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VUNPCKHPD       AVX              00010101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); }
+VUNPCKHPD       AVX2             00010101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); }
 
 PSHUFB_64       SSSE3   00001111 00111000 00000000 !emit { modrm(); mem(size => 8); }
 PSHUFB          SSSE3   00001111 00111000 00000000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPSHUFB         AVX                       00000000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 16); }
+VPSHUFB         AVX2                      00000000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38); modrm(); mem(size => 32); }
 PSHUFW          SSE     00001111 01110000 !emit { modrm(); mem(size => 8); imm(size => 1); }
 PSHUFLW         SSE2    00001111 01110000 !emit { repne(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VPSHUFLW        AVX              01110000 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VPSHUFLW        AVX2             01110000 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
 PSHUFHW         SSE2    00001111 01110000 !emit { rep(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VPSHUFHW        AVX              01110000 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VPSHUFHW        AVX2             01110000 !emit { vex(l => VEX_L_256, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
 PSHUFD          SSE2    00001111 01110000 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VPSHUFD         AVX              01110000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VPSHUFD         AVX2             01110000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
 
 SHUFPS          SSE     00001111 11000110 !emit { modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VSHUFPS         AVX              11000110 !emit { vex(l => VEX_L_128, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
+VSHUFPS         AVX2             11000110 !emit { vex(l => VEX_L_256, m => VEX_M_0F); modrm(); mem(size => 32); imm(size => 1); }
 SHUFPD          SSE2    00001111 11000110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VSHUFPD         AVX              11000110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 16); imm(size => 1); }
+VSHUFPD         AVX2             11000110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F); modrm(); mem(size => 32); imm(size => 1); }
 
 BLENDPS         SSE4_1  00001111 00111010 00001100 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VBLENDPS        AVX                       00001100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
+VBLENDPS        AVX2                      00001100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 32); imm(size => 1); }
 BLENDPD         SSE4_1  00001111 00111010 00001101 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VBLENDPD        AVX                       00001101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
+VBLENDPD        AVX2                      00001101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 32); imm(size => 1); }
 BLENDVPS        SSE4_1  00001111 00111000 00010100 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VBLENDVPS       AVX                       01001010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
+VBLENDVPS       AVX2                      01001010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 32); imm(size => 1); }
 BLENDVPD        SSE4_1  00001111 00111000 00010101 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VBLENDVPD       AVX                       01001011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
+VBLENDVPD       AVX2                      01001011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 32); imm(size => 1); }
 PBLENDVB        SSE4_1  00001111 00111000 00010000 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VPBLENDVB       AVX                       01001100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
+VPBLENDVB       AVX2                      01001100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 32); imm(size => 1); }
 PBLENDW         SSE4_1  00001111 00111010 00001110 !emit { data16(); modrm(); mem(size => 16, align => 16); imm(size => 1); }
 VPBLENDW        AVX                       00001110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 16); imm(size => 1); }
+VPBLENDW        AVX2                      00001110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 32); imm(size => 1); }
+VPBLENDD_xmm    AVX2                      00000010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
+VPBLENDD        AVX2                      00000010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 32); imm(size => 1); }
 
 INSERTPS        SSE4_1  00001111 00111010 00100001 !emit { data16(); modrm(); mem(size => 4); imm(size => 1); }
 VINSERTPS       AVX                       00100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A); modrm(); mem(size => 4); imm(size => 1); }
@@ -613,6 +791,9 @@ VPINSRD         AVX                       00100010 !emit { vex(l => VEX_L_128, p
 PINSRQ          SSE4_1  00001111 00111010 00100010 !emit { data16(); rex(w => 1); modrm(); mem(size => 8); imm(size => 1); }
 VPINSRQ         AVX                       00100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 1); modrm(); mem(size => 8); imm(size => 1); }
 
+VINSERTF128     AVX2    00011000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
+VINSERTI128     AVX2    00111000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 16); imm(size => 1); }
+
 EXTRACTPS       SSE4_1  00001111 00111010 00010111 !emit { data16(); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
 EXTRACTPS_mem   SSE4_1  00001111 00111010 00010111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 4); imm(size => 1); }
 VEXTRACTPS      AVX                       00010111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, rm => ~REG_ESP); imm(size => 1); }
@@ -639,37 +820,94 @@ PEXTRW_reg      SSE     00001111 11000101 !emit { modrm(mod => MOD_DIRECT, reg =
 PEXTRW_reg      SSE2    00001111 11000101 !emit { data16(); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
 VPEXTRW_reg     AVX              11000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, w => 0, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT, reg => ~REG_ESP); imm(size => 1); }
 
+VEXTRACTF128    AVX2    00011001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VEXTRACTI128    AVX2    00111001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+
+VPBROADCASTB_xmm AVX2   01111000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 1); }
+VPBROADCASTB    AVX2    01111000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 1); }
+VPBROADCASTW_xmm AVX2   01111001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 2); }
+VPBROADCASTW    AVX2    01111001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 2); }
+VPBROADCASTD_xmm AVX2   01011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VPBROADCASTD    AVX2    01011000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VPBROADCASTQ_xmm AVX2   01011001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPBROADCASTQ    AVX2    01011001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VBROADCASTSS_xmm AVX2   00011000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VBROADCASTSS    AVX2    00011000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VBROADCASTSD    AVX2    00011001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VBROADCASTF128  AVX2    00011010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VBROADCASTI128  AVX2    01011010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+
+VPERM2F128      AVX2    00000110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 32); imm(size => 1); }
+VPERM2I128      AVX2    01000110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0); modrm(); mem(size => 32); imm(size => 1); }
+VPERMD          AVX2    00110110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 32); }
+VPERMPS         AVX2    00010110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 VPERMILPS       AVX     00001100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPERMILPS       AVX2    00001100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 32); }
 VPERMILPS_imm   AVX     00000100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VPERMILPS_imm   AVX2    00000100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
 VPERMILPD       AVX     00001101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 16); }
+VPERMILPD       AVX2    00001101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(); mem(size => 32); }
 VPERMILPD_imm   AVX     00000101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 16); imm(size => 1); }
+VPERMILPD_imm   AVX2    00000101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 0, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
+VPERMQ          AVX2    00000000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 1, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
+VPERMPD         AVX2    00000001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F3A, w => 1, v => VEX_V_UNUSED); modrm(); mem(size => 32); imm(size => 1); }
+
+# TODO These instructions use VSIB byte, which is not implemented yet
+# VGATHERDPS      AVX2    10010010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VGATHERDPS      AVX2    10010010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VGATHERDPD      AVX2    10010010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VGATHERDPD      AVX2    10010010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VGATHERQPS      AVX2    10010011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VGATHERQPS      AVX2    10010011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VGATHERQPD      AVX2    10010011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VGATHERQPD      AVX2    10010011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERDD      AVX2    10010000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERDD      AVX2    10010000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERDQ      AVX2    10010000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERDQ      AVX2    10010000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERQD      AVX2    10010001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERQD      AVX2    10010001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERQQ      AVX2    10010001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
+# VPGATHERQQ      AVX2    10010001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); }
 
 # Conversion Instructions
 PMOVSXBW        SSE4_1  00001111 00111000 00100000 !emit { data16(); modrm(); mem(size => 8); }
 VPMOVSXBW       AVX                       00100000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPMOVSXBW       AVX2                      00100000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 PMOVSXBD        SSE4_1  00001111 00111000 00100001 !emit { data16(); modrm(); mem(size => 4); }
 VPMOVSXBD       AVX                       00100001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VPMOVSXBD       AVX2                      00100001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVSXBQ        SSE4_1  00001111 00111000 00100010 !emit { data16(); modrm(); mem(size => 2); }
 VPMOVSXBQ       AVX                       00100010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 2); }
+VPMOVSXBQ       AVX2                      00100010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 PMOVSXWD        SSE4_1  00001111 00111000 00100011 !emit { data16(); modrm(); mem(size => 8); }
 VPMOVSXWD       AVX                       00100011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPMOVSXWD       AVX2                      00100011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 PMOVSXWQ        SSE4_1  00001111 00111000 00100100 !emit { data16(); modrm(); mem(size => 4); }
 VPMOVSXWQ       AVX                       00100100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VPMOVSXWQ       AVX2                      00100100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVSXDQ        SSE4_1  00001111 00111000 00100101 !emit { data16(); modrm(); mem(size => 8); }
 VPMOVSXDQ       AVX                       00100101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPMOVSXDQ       AVX2                      00100101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 PMOVZXBW        SSE4_1  00001111 00111000 00110000 !emit { data16(); modrm(); mem(size => 8); }
 VPMOVZXBW       AVX                       00110000 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPMOVZXBW       AVX2                      00110000 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 PMOVZXBD        SSE4_1  00001111 00111000 00110001 !emit { data16(); modrm(); mem(size => 4); }
 VPMOVZXBD       AVX                       00110001 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VPMOVZXBD       AVX2                      00110001 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVZXBQ        SSE4_1  00001111 00111000 00110010 !emit { data16(); modrm(); mem(size => 2); }
 VPMOVZXBQ       AVX                       00110010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 2); }
+VPMOVZXBQ       AVX2                      00110010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
 PMOVZXWD        SSE4_1  00001111 00111000 00110011 !emit { data16(); modrm(); mem(size => 8); }
 VPMOVZXWD       AVX                       00110011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPMOVZXWD       AVX2                      00110011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 PMOVZXWQ        SSE4_1  00001111 00111000 00110100 !emit { data16(); modrm(); mem(size => 4); }
 VPMOVZXWQ       AVX                       00110100 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 4); }
+VPMOVZXWQ       AVX2                      00110100 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
 PMOVZXDQ        SSE4_1  00001111 00111000 00110101 !emit { data16(); modrm(); mem(size => 8); }
 VPMOVZXDQ       AVX                       00110101 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VPMOVZXDQ       AVX2                      00110101 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 CVTPI2PS        SSE     00001111 00101010 !emit { modrm(); mem(size => 8); }
 CVTSI2SS        SSE     00001111 00101010 !emit { rep(); modrm(); mem(size => 4); }
@@ -706,15 +944,20 @@ VCVTTSD2SI_64   AVX              00101100 !emit { vex(l => 0, p => VEX_P_REPNE,
 
 CVTPD2DQ        SSE2    00001111 11100110 !emit { repne(); modrm(); mem(size => 16, align => 16); }
 VCVTPD2DQ       AVX              11100110 !emit { vex(l => VEX_L_128, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VCVTPD2DQ       AVX2             11100110 !emit { vex(l => VEX_L_256, p => VEX_P_REPNE, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 CVTTPD2DQ       SSE2    00001111 11100110 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VCVTTPD2DQ      AVX              11100110 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VCVTTPD2DQ      AVX2             11100110 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 CVTDQ2PD        SSE2    00001111 11100110 !emit { rep(); modrm(); mem(size => 8); }
 VCVTDQ2PD       AVX              11100110 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VCVTDQ2PD       AVX2             11100110 !emit { vex(l => VEX_L_256, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 
 CVTPS2PD        SSE2    00001111 01011010 !emit { modrm(); mem(size => 8); }
 VCVTPS2PD       AVX              01011010 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 8); }
+VCVTPS2PD       AVX2             01011010 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
 CVTPD2PS        SSE2    00001111 01011010 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VCVTPD2PS       AVX              01011010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VCVTPD2PS       AVX2             01011010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 CVTSS2SD        SSE2    00001111 01011010 !emit { rep(); modrm(); mem(size => 4); }
 VCVTSS2SD       AVX              01011010 !emit { vex(l => 0, p => VEX_P_REP, m => VEX_M_0F); modrm(); mem(size => 4); }
 CVTSD2SS        SSE2    00001111 01011010 !emit { repne(); modrm(); mem(size => 8); }
@@ -722,10 +965,13 @@ VCVTSD2SS       AVX              01011010 !emit { vex(l => 0, p => VEX_P_REPNE,
 
 CVTDQ2PS        SSE2    00001111 01011011 !emit { modrm(); mem(size => 16, align => 16); }
 VCVTDQ2PS       AVX              01011011 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VCVTDQ2PS       AVX2             01011011 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 CVTPS2DQ        SSE2    00001111 01011011 !emit { data16(); modrm(); mem(size => 16, align => 16); }
 VCVTPS2DQ       AVX              01011011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VCVTPS2DQ       AVX2             01011011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 CVTTPS2DQ       SSE2    00001111 01011011 !emit { rep(); modrm(); mem(size => 16, align => 16); }
 VCVTTPS2DQ      AVX              01011011 !emit { vex(l => VEX_L_128, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 16); }
+VCVTTPS2DQ      AVX2             01011011 !emit { vex(l => VEX_L_256, p => VEX_P_REP, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(); mem(size => 32); }
 
 # Cacheability Control, Prefetch, and Instruction Ordering Instructions
 MASKMOVQ        SSE     00001111 11110111 !emit { modrm(mod => MOD_DIRECT); mem(size => 8, base => REG_EDI); }
@@ -733,20 +979,31 @@ MASKMOVDQU      SSE2    00001111 11110111 !emit { data16(); modrm(mod => MOD_DIR
 VMASKMOVDQU     AVX              11110111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => MOD_DIRECT); mem(size => 16, base => REG_EDI); }
 
 VMASKMOVPS      AVX     001011 d 0 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VMASKMOVPS      AVX2    001011 d 0 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 32); }
 VMASKMOVPD      AVX     001011 d 1 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VMASKMOVPD      AVX2    001011 d 1 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 32); }
+
+VPMASKMOVD_xmm  AVX2    100011 d 0 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VPMASKMOVD      AVX2    100011 d 0 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 0); modrm(mod => ~MOD_DIRECT); mem(size => 32); }
+VPMASKMOVQ_xmm  AVX2    100011 d 0 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 16); }
+VPMASKMOVQ      AVX2    100011 d 0 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 32); }
 
 MOVNTPS         SSE     00001111 00101011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 VMOVNTPS        AVX              00101011 !emit { vex(l => VEX_L_128, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTPS        AVX2             00101011 !emit { vex(l => VEX_L_256, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 32, align => 32); }
 MOVNTPD         SSE2    00001111 00101011 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 VMOVNTPD        AVX              00101011 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTPD        AVX2             00101011 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 32, align => 32); }
 
 MOVNTI          SSE2    00001111 11000011 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 4); }
 MOVNTI_64       SSE2    00001111 11000011 !emit { rex(w => 1); modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTQ          SSE     00001111 11100111 !emit { modrm(mod => ~MOD_DIRECT); mem(size => 8); }
 MOVNTDQ         SSE2    00001111 11100111 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 VMOVNTDQ        AVX              11100111 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTDQ        AVX2             11100111 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 32, align => 32); }
 MOVNTDQA        SSE4_1  00001111 00111000 00101010 !emit { data16(); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
 VMOVNTDQA       AVX                       00101010 !emit { vex(l => VEX_L_128, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 16, align => 16); }
+VMOVNTDQA       AVX2                      00101010 !emit { vex(l => VEX_L_256, p => VEX_P_DATA16, m => VEX_M_0F38, v => VEX_V_UNUSED); modrm(mod => ~MOD_DIRECT); mem(size => 32, align => 32); }
 
 PREFETCHT0      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 1); mem(size => 1); }
 PREFETCHT1      SSE     00001111 00011000 !emit { modrm(mod => ~MOD_DIRECT, reg => 2); mem(size => 1); }
-- 
2.20.1


