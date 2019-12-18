Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CB2C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A45D2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 21:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0sirjtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A45D2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihgdo-0005lh-2v
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 16:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUw-0002Hg-A5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ihgUu-0001Gd-Rf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:46 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38455)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ihgUu-0001Fr-LW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 16:04:44 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so3811936wrh.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 13:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hG9yLpMv8x5JNCD55FMtjlk9oGFGwOQ+hU3EbJamgHk=;
 b=s0sirjtAhn6pudAxqnA2Lbb9fOs5wfsfwPvDtT0uWzRjt0F427hzpaKABk5Vzy16gW
 XvG8ay+5zXFqRZWj+U5slKb7X7TAxD+A6aKjSlipw072QzpnsF8PaZd3raHMizYzUij2
 gJJkr0KkPqkdu8G+RamZj0s+dYcgOGYHlX4y/RIDBxys+xGRpbto/9Ayk9c2XDVhD2aH
 89H+SylxuGEifsXgXQyIGDtUxcYbclm87u6kA7u6uu7wUL41IAG97ly1zes3mSc27FHU
 Bid1gWZVUNfY/LEEYCjA9LK1xX4wrmt1B/rFMw18H/+wBUcdUQPmVXClvdu5zqpEF2NW
 6qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hG9yLpMv8x5JNCD55FMtjlk9oGFGwOQ+hU3EbJamgHk=;
 b=iDstz6NQSyU0615lUuLjcRMRwqnIffeiX6LQhb4xsLdmdRCMwurC3qFmQRixjKhsuu
 EJAyuiGeHuo5jNPYwO/Ek/qYcsWYv1AchfqEzk480XG7+ty5x8r8Y/R4IGzsrUd3OyjP
 cqLg6bLHtp2mq0BoT89+sQd38Hwm7vWsT7heW7Gp0nbI1K3lPhd8tHr27jUCIWTFIZsg
 pyuj7taR/XR/GK5RdublkqlCXUzmgDKk+BdCCNr6CMMAqqGgnPxI6VZ8tOWEqg6jjuRE
 Mor7ZlQih9R/aauPKG6Jkb3bl1Mt326E7pKGqQELi+VQIHY+aVzeeGXeU22jtkAiTSlO
 OX7g==
X-Gm-Message-State: APjAAAXtJ7oAIfLn7EYZvziYLFw9Ngs8JDhD42Um22Y7Y1bn3Xu4XO1C
 gQrilYN7ZHpMtMha2M9JlBfzjlBMA39AQA==
X-Google-Smtp-Source: APXvYqxyr2Tm8Q6ELX0tkZodCYSqG/AaEGzIadiqAmOjwJHMaZlkR1KGBRhUHKP+qIkOv9h3CBJ/WA==
X-Received: by 2002:a05:6000:1142:: with SMTP id
 d2mr4755270wrx.253.1576703083323; 
 Wed, 18 Dec 2019 13:04:43 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-109-65-2-109.red.bezeqint.net. [109.65.2.109])
 by smtp.gmail.com with ESMTPSA id a133sm3808933wme.29.2019.12.18.13.04.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 18 Dec 2019 13:04:42 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v39 19/22] target/avr: Update build system
Date: Wed, 18 Dec 2019 23:03:26 +0200
Message-Id: <20191218210329.1960-20-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191218210329.1960-1-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
index 84b413dbfc..fb1823208f 100755
--- a/configure
+++ b/configure
@@ -7602,6 +7602,10 @@ case "$target_name" in
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
@@ -7821,6 +7825,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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


