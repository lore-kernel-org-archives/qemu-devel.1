Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057A9C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C977920835
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0b8fhNq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C977920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia1wX-0001ej-LW
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 13:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vv-0002J2-J4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ia1Vt-0006oo-Lx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ia1Vs-0006lQ-Hd
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 12:54:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id n5so8607322wmc.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lmKu0nadoIAF5aXT323Ji4zM6wR9fpqsiNsQ/AlTLlc=;
 b=p0b8fhNqoOmxcFpwlbmB+5KPzVkD6kpFjmHNTJYYHiv4LP9c5pEkIVaXfh/2slDndp
 bV8/qLAzJFv7D339Xb58EaqAXnakY/R9klsKJMt30swDGYLu21Wf2nuXncoGLMUfr00r
 C8q9n6H0Wr1rsgh++skH2q8IK97O7f+DkPczLwhAjsOnTRqjqtSWN/0Jm2ElhGKRUxsR
 Scb5Pw396T+Ltvf1/Lh14ViVGF8+WKjJRBMynZbj/i5SDox/5lwU7f6KIFCgVmhBA7nK
 C43CK4nZgOOr5zRjOwmfGqAHTTmrb6BxpYrRFDFlrNk5sjYsSxDEJVj4wImmX25Ayv60
 yuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lmKu0nadoIAF5aXT323Ji4zM6wR9fpqsiNsQ/AlTLlc=;
 b=VFcElHCzTGiFDH/gwXAp//y0Zb8x/AfryeF5tAC6SNN3e6s91ktobMUnQF3xLebPlz
 0dmQSw+C+fadfKvWufC9PEEUXu9QaHrlDPTuCLpbPtrq6BkGg0Yen5X85drNpSDrB/Ty
 WGkNt4rJhHvlbwf71Z67BLW8wtbbEUMjfraburSCL3DO46Ud3pZ/qFibh3oNxzvLbK7l
 jdTXVLS7Ouiv1X8whdrxpHMzdX5Fv9Xn9DRzHrC7aUKcE1TZK2QmsaTmxpw1MfIJqj+A
 lVv+hhAr6d1q+BxY3flZRtzKFRhuUv2pbabIXKVSzAqx/r80pfQYmWu1ulgbnm8b/ASF
 jH/Q==
X-Gm-Message-State: APjAAAWUPvNh+k3aODiBGAuQS771a9Jy5XBnl6R6229TV5r2J6dHFkWZ
 yyL2ntDWW3q/svzFvCN+3yLnLv24sk+4BVt0
X-Google-Smtp-Source: APXvYqzY5DpwX+xzCZ+oHfdr69oaZuiT9Z0xiEetEkp0WyCo6ykKVvp8ulRQqiEmG3Pyaq8Y5+RPGw==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr2147936wmc.54.1574877238894;
 Wed, 27 Nov 2019 09:53:58 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-178-2-87.red.bezeqint.net. [79.178.2.87])
 by smtp.gmail.com with ESMTPSA id b2sm20238295wrr.76.2019.11.27.09.53.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 27 Nov 2019 09:53:58 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v37 14/17] target/avr: Update build system
Date: Wed, 27 Nov 2019 19:52:54 +0200
Message-Id: <20191127175257.23480-15-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191127175257.23480-1-mrolnik@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
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

Make AVR support buildable

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 configure                       |  7 +++++++
 default-configs/avr-softmmu.mak |  5 +++++
 target/avr/Makefile.objs        | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/configure b/configure
index 6099be1d84..e9dab313d5 100755
--- a/configure
+++ b/configure
@@ -7649,6 +7649,10 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
   ;;
+  avr)
+    gdb_xml_files="avr-cpu.xml"
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
   ;;
   hppa)
@@ -7868,6 +7872,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
       disas_config "ARM_A64"
     fi
   ;;
+  avr)
+    disas_config "AVR"
+  ;;
   cris)
     disas_config "CRIS"
   ;;
diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
new file mode 100644
index 0000000000..d1e1c28118
--- /dev/null
+++ b/default-configs/avr-softmmu.mak
@@ -0,0 +1,5 @@
+# Default configuration for avr-softmmu
+
+# Boards:
+#
+CONFIG_AVR_SAMPLE=y
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
new file mode 100644
index 0000000000..7523e0c6e2
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,34 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2019 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+decode-y = $(SRC_PATH)/target/avr/insn.decode
+
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/translate.o: target/avr/decode_insn.inc.c
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-y += disas.o
+obj-$(CONFIG_SOFTMMU) += machine.o
-- 
2.17.2 (Apple Git-113)


