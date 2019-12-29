Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96181C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCD22071E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 22:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1YQULEB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCD22071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilgdS-0001EU-V0
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 17:02:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV3-0007o7-QO
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ilgV1-0004Dn-T6
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:25 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:32978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ilgV1-0004Bs-Ju
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 16:53:23 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so31240829wrq.0
 for <qemu-devel@nongnu.org>; Sun, 29 Dec 2019 13:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lzx4vdME8QKLOZhLH72I3WrcGfyYxGL/++CznTTPzp4=;
 b=X1YQULEBSNL4VkFd3L87P3dgK0Hsj9JpUbgWnkWyaQdzDrWd1AAMu2247H/pVC44r1
 ovZQaawFSYRHeloo/3rk43U48vl3aeSHwpLoOWh+Eo4Sb74AuR9XFp8BSa8rlj1yoHXp
 p1zhx9pFT2vunggBgvQdB/xGBMSSgq7XlDWBu5HtBqmnVHiBlRKYeSpWLwo4w90Ec/th
 n1p5dQ6ZQ66VOm5HUF6+n4IdaqD+x0zMVBv9uXLZEwlIw9Fo/Vq1H3kUy0PFfw35SbfT
 1sIo3ZmtXEQvZGsLWlZDlFjusYQGvD3Dga6VENInJ7d960E4ejj9/nj8YIbrUd8+RAHA
 PBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lzx4vdME8QKLOZhLH72I3WrcGfyYxGL/++CznTTPzp4=;
 b=tcJB4W+ZlKfSxRIDpdEOFkUQo+FgKrY/XSCoHuNvxCSX3UNwnvjh4wONXUsqjDcBjX
 2YA+iifs7TVIFH9pLcnVG+JmPD3q+BjF5Yche0IvTnsyiJct1+2cXzJnv5eCBtTnZF7X
 YpDmTLzGO7Q5+KleT/YYfmGwOzZr8Ze15bXyUC4kEtEYqFbYOsNn+kQBKEK5ntp5+kMd
 2tGPoTIxxbJuzZ93YynrOJShD9AH6kHo+UKMjiClMnGdhWQPQgD9fYbOo2nhjzluGuCo
 yKSFANOU195tM8dEikcyET4DGFPI5otaXMqds+TdvF1HwlEwA6CX1EhBkrulGuhF7OLD
 EQ5w==
X-Gm-Message-State: APjAAAVXDYJAq2/XAJC4HNcRXEJtTAcRoSuVX0CVBXNtymCQR3tKsvTp
 zTrvwZ+GZdfCtRlGBAoDrze17zxt+j4NVA==
X-Google-Smtp-Source: APXvYqz4jT8x8zPFNJqLtqUme855sQikjwoPXHYUio8Uu304lCXC4ly2K7b3Celvf2KFDhp5w9HjcQ==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr62247194wru.398.1577656401799; 
 Sun, 29 Dec 2019 13:53:21 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-183-93-3.red.bezeqint.net. [79.183.93.3])
 by smtp.gmail.com with ESMTPSA id 25sm18182850wmi.32.2019.12.29.13.53.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 29 Dec 2019 13:53:21 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v40 18/21] target/avr: Update build system
Date: Sun, 29 Dec 2019 23:51:55 +0200
Message-Id: <20191229215158.5788-19-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191229215158.5788-1-mrolnik@gmail.com>
References: <20191229215158.5788-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
index 940bf9e87a..249b7adff0 100755
--- a/configure
+++ b/configure
@@ -7613,6 +7613,10 @@ case "$target_name" in
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
@@ -7832,6 +7836,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
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


