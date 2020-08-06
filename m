Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FFAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33D8204FD
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RKHqI6Vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C33D8204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dxy-0007Ma-Nv
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTP-0004yy-8N
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:11 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:45107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dTN-00088B-BD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:50:10 -0400
Received: by mail-pg1-x52c.google.com with SMTP id x6so11304728pgx.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IIDpnVDv9+trjyRRch9JAqW8+nRxIqRgOoCbDIBNhSI=;
 b=RKHqI6VwLczu40Mzi4tovT6whrhzMPKSu3I0BZKU7GV7L/WgGOggJklnIg4nC6HiKI
 x+5jDKBhtcvtPxGCkGzVstkxlCc/Jl9fwFCqgOQYM4PfW/arSaLyxGH3v57lIbKlwoI1
 0PkkhrT0tHf3RPk6E/+0Z+XtKuqo3ppMWLgLWejvBPZMeiF1BU/6p6NL2W/LdD5t04Sq
 RFGVddN6QFbcuex4J8EWClc1jaJ0myDPNbxiFYT8Gm9yI5whqwnwCdxXUzSE3zgpIN/h
 +lCR1mVgyCLDHOZqc+8M65kc3Ahju+8jWXeYVUDtDqI0RlDeqMjqw661B2Iq4YkPBK9U
 PNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IIDpnVDv9+trjyRRch9JAqW8+nRxIqRgOoCbDIBNhSI=;
 b=tLOHT1mxbd2qHjmZCTwOHShq25V1/NLDjmZzQ5htjEpTi/AXtHKsB4G9cEO97zMgAV
 kGJExE2VYvWTHH6K+/CaA7ihpd9UkLRN3/ssQsqChYBEoIpBlBU2oiqQlNiYdzBqPvYn
 bxuvWbm5OeEI4Sl3F4d0mcGhYAR0jXohCHze5OQj0S3GwDyhREzQueN5YU5BG8AXxJm4
 I1UvTvc/XZqJDtTw2isysgLGzlO4U0uZhJhVVvoUxvgYBTpY4peZaEgmZFVER6lJrg83
 /KNQH8MinPOHUNcOljOGOb8Abs05SfAGpNuEKLUhHGBEO3JtOcaRj0k13V5xLFklkfwc
 90Tg==
X-Gm-Message-State: AOAM532t9qWEapgJnbr4xUbFJ3J3VGM2R8iwth1mOe8yivn77j21J+Jw
 K71jUe/aj4jPAMDiK0uuYkWHk6QL7WU=
X-Google-Smtp-Source: ABdhPJzhrMYrvQvPv63/LNaS30whVMcFUFUEYzig5CvqFVXlvdzsvn4GgE78fl/n0nIeLRtP21B/Qw==
X-Received: by 2002:a62:1d0a:: with SMTP id d10mr7574400pfd.270.1596711007847; 
 Thu, 06 Aug 2020 03:50:07 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:50:07 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 69/71] target/riscv: gdb: modify gdb csr xml file to align
 with csr register map
Date: Thu,  6 Aug 2020 18:47:06 +0800
Message-Id: <20200806104709.13235-70-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hsiangkai Wang <kai.wang@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hsiangkai Wang <kai.wang@sifive.com>

Signed-off-by: Hsiangkai Wang <kai.wang@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 gdb-xml/riscv-32bit-csr.xml | 11 ++++++-----
 gdb-xml/riscv-64bit-csr.xml | 11 ++++++-----
 target/riscv/gdbstub.c      |  4 ++--
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/gdb-xml/riscv-32bit-csr.xml b/gdb-xml/riscv-32bit-csr.xml
index da1bf19e2f4..3d2031da7dc 100644
--- a/gdb-xml/riscv-32bit-csr.xml
+++ b/gdb-xml/riscv-32bit-csr.xml
@@ -110,6 +110,8 @@
   <reg name="mcause" bitsize="32"/>
   <reg name="mtval" bitsize="32"/>
   <reg name="mip" bitsize="32"/>
+  <reg name="mtinst" bitsize="32"/>
+  <reg name="mtval2" bitsize="32"/>
   <reg name="pmpcfg0" bitsize="32"/>
   <reg name="pmpcfg1" bitsize="32"/>
   <reg name="pmpcfg2" bitsize="32"/>
@@ -232,12 +234,11 @@
   <reg name="hedeleg" bitsize="32"/>
   <reg name="hideleg" bitsize="32"/>
   <reg name="hie" bitsize="32"/>
-  <reg name="htvec" bitsize="32"/>
-  <reg name="hscratch" bitsize="32"/>
-  <reg name="hepc" bitsize="32"/>
-  <reg name="hcause" bitsize="32"/>
-  <reg name="hbadaddr" bitsize="32"/>
+  <reg name="hcounteren" bitsize="32"/>
+  <reg name="htval" bitsize="32"/>
   <reg name="hip" bitsize="32"/>
+  <reg name="htinst" bitsize="32"/>
+  <reg name="hgatp" bitsize="32"/>
   <reg name="mbase" bitsize="32"/>
   <reg name="mbound" bitsize="32"/>
   <reg name="mibase" bitsize="32"/>
diff --git a/gdb-xml/riscv-64bit-csr.xml b/gdb-xml/riscv-64bit-csr.xml
index 6aa4bed9f50..90394562930 100644
--- a/gdb-xml/riscv-64bit-csr.xml
+++ b/gdb-xml/riscv-64bit-csr.xml
@@ -110,6 +110,8 @@
   <reg name="mcause" bitsize="64"/>
   <reg name="mtval" bitsize="64"/>
   <reg name="mip" bitsize="64"/>
+  <reg name="mtinst" bitsize="64"/>
+  <reg name="mtval2" bitsize="64"/>
   <reg name="pmpcfg0" bitsize="64"/>
   <reg name="pmpcfg1" bitsize="64"/>
   <reg name="pmpcfg2" bitsize="64"/>
@@ -232,12 +234,11 @@
   <reg name="hedeleg" bitsize="64"/>
   <reg name="hideleg" bitsize="64"/>
   <reg name="hie" bitsize="64"/>
-  <reg name="htvec" bitsize="64"/>
-  <reg name="hscratch" bitsize="64"/>
-  <reg name="hepc" bitsize="64"/>
-  <reg name="hcause" bitsize="64"/>
-  <reg name="hbadaddr" bitsize="64"/>
+  <reg name="hcounteren" bitsize="64"/>
+  <reg name="htval" bitsize="64"/>
   <reg name="hip" bitsize="64"/>
+  <reg name="htinst" bitsize="64"/>
+  <reg name="hgatp" bitsize="64"/>
   <reg name="mbase" bitsize="64"/>
   <reg name="mbound" bitsize="64"/>
   <reg name="mibase" bitsize="64"/>
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index eba12a86f2e..f7c5212e274 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -418,13 +418,13 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
     }
 #if defined(TARGET_RISCV32)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             240, "riscv-32bit-csr.xml", 0);
+                             241, "riscv-32bit-csr.xml", 0);
 
     gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
                              1, "riscv-32bit-virtual.xml", 0);
 #elif defined(TARGET_RISCV64)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             240, "riscv-64bit-csr.xml", 0);
+                             241, "riscv-64bit-csr.xml", 0);
 
     gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
                              1, "riscv-64bit-virtual.xml", 0);
-- 
2.17.1


