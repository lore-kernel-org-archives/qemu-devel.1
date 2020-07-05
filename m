Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B83C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DBB20724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DBB20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5NC-0006GS-5v
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F2-0007AN-JL
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:36 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:34077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F0-0008IO-Iw
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:36 -0400
Received: by mail-ej1-f41.google.com with SMTP id y10so39638393eje.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D4Jj51AkUtR5EfrbyrD5SDecvoxZsLvEPjgbdzyt5YE=;
 b=GsRjSLgQx7Had9EXebEvVAh6zURKCHuFd2+mPWO8aGRy9nrxmTtTCD8c3u+Z599KZg
 kdT/Ggn5f6fvpAmoisPZFvbSafw3HGN3pmZZeJC4acs4GwejLo5uB5XkWbatctoUx/VD
 nvmpPKX3KrJ+iDUTyyHApTdJwTIGS/dHW293X4Hl4lUh1MXsMZ3N8rDNoZYO5r0L2X0o
 LG96RmP8u5Y0eHq1m7WzH+wZGncyOPDyDiCQ94lN/PnU2N6CNNKvvSZEnMFX2LLFv+Kp
 4BEYufa9yZaDaOFmGHiTcJ3D3rty4GKfkfEM+RnoqQPf0I3oa47bKCgphGKRrZTLkQcM
 A6Pw==
X-Gm-Message-State: AOAM533283gEn5bdnSxPDqc8VrcGYUikd6UDfIkAVmHbzhlcqgBR52ca
 fYkuv98Y/ScKpV1Ou5ZkXUFP1kzZ
X-Google-Smtp-Source: ABdhPJyc2q+7Qvzt07ubrBA2ppy430olvfHekGqK3pxCtsYup/xdK9r1QTsqp5jm5Vxjgm1fYJ+y5g==
X-Received: by 2002:a17:906:a058:: with SMTP id
 bg24mr40963615ejb.370.1593957812987; 
 Sun, 05 Jul 2020 07:03:32 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:32 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 06/30] target/avr: CPU class: Add GDB support
Date: Sun,  5 Jul 2020 16:02:51 +0200
Message-Id: <20200705140315.260514-7-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.41; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f41.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

This includes GDB hooks for reading from wnd wrtiting to AVR
registers, and xml register definition file as well.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[thuth: Fixed avr_cpu_gdb_read_register() parameter]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 MAINTAINERS          |  1 +
 gdb-xml/avr-cpu.xml  | 49 ++++++++++++++++++++++++++
 target/avr/cpu.c     |  4 +++
 target/avr/cpu.h     |  2 ++
 target/avr/gdbstub.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 140 insertions(+)
 create mode 100644 gdb-xml/avr-cpu.xml
 create mode 100644 target/avr/gdbstub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ee1f35edf5..11a0611b3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -171,6 +171,7 @@ AVR TCG CPUs
 M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
+F: gdb-xml/avr-cpu.xml
 F: target/avr/
 
 CRIS TCG CPUs
diff --git a/gdb-xml/avr-cpu.xml b/gdb-xml/avr-cpu.xml
new file mode 100644
index 0000000000..c4747f5b40
--- /dev/null
+++ b/gdb-xml/avr-cpu.xml
@@ -0,0 +1,49 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.cpu">
+  <reg name="r0" bitsize="8" type="int" regnum="0"/>
+  <reg name="r1" bitsize="8" type="int"/>
+  <reg name="r2" bitsize="8" type="int"/>
+  <reg name="r3" bitsize="8" type="int"/>
+  <reg name="r4" bitsize="8" type="int"/>
+  <reg name="r5" bitsize="8" type="int"/>
+  <reg name="r6" bitsize="8" type="int"/>
+  <reg name="r7" bitsize="8" type="int"/>
+  <reg name="r8" bitsize="8" type="int"/>
+  <reg name="r9" bitsize="8" type="int"/>
+  <reg name="r10" bitsize="8" type="int"/>
+  <reg name="r11" bitsize="8" type="int"/>
+  <reg name="r12" bitsize="8" type="int"/>
+  <reg name="r13" bitsize="8" type="int"/>
+  <reg name="r14" bitsize="8" type="int"/>
+  <reg name="r15" bitsize="8" type="int"/>
+  <reg name="r16" bitsize="8" type="int"/>
+  <reg name="r17" bitsize="8" type="int"/>
+  <reg name="r18" bitsize="8" type="int"/>
+  <reg name="r19" bitsize="8" type="int"/>
+  <reg name="r20" bitsize="8" type="int"/>
+  <reg name="r21" bitsize="8" type="int"/>
+  <reg name="r22" bitsize="8" type="int"/>
+  <reg name="r23" bitsize="8" type="int"/>
+  <reg name="r24" bitsize="8" type="int"/>
+  <reg name="r25" bitsize="8" type="int"/>
+  <reg name="r26" bitsize="8" type="int"/>
+  <reg name="r27" bitsize="8" type="int"/>
+  <reg name="r28" bitsize="8" type="int"/>
+  <reg name="r29" bitsize="8" type="int"/>
+  <reg name="r30" bitsize="8" type="int"/>
+  <reg name="r31" bitsize="8" type="int"/>
+  <reg name="sreg" bitsize="8" type="int"/>
+  <reg name="sp" bitsize="8" type="int"/>
+  <reg name="pc" bitsize="8" type="int"/>
+</feature>
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index ced1107824..4802453ff9 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -210,4 +210,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->disas_set_info = avr_cpu_disas_set_info;
     cc->tcg_initialize = avr_cpu_tcg_init;
     cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
+    cc->gdb_read_register = avr_cpu_gdb_read_register;
+    cc->gdb_write_register = avr_cpu_gdb_write_register;
+    cc->gdb_num_core_regs = 35;
+    cc->gdb_core_xml_file = "avr-cpu.xml";
 }
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index d3003f8e25..675a33d17a 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -123,6 +123,8 @@ extern const struct VMStateDescription vms_avr_cpu;
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+int avr_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
+int avr_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
 
 #define cpu_list avr_cpu_list
 #define cpu_signal_handler cpu_avr_signal_handler
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
new file mode 100644
index 0000000000..3ec78cff70
--- /dev/null
+++ b/target/avr/gdbstub.c
@@ -0,0 +1,84 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#include "qemu/osdep.h"
+#include "exec/gdbstub.h"
+
+int avr_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        return gdb_get_reg8(mem_buf, env->r[n]);
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        uint8_t sreg = cpu_get_sreg(env);
+
+        return gdb_get_reg8(mem_buf, sreg);
+    }
+
+    /*  SP */
+    if (n == 33) {
+        return gdb_get_reg16(mem_buf, env->sp & 0x0000ffff);
+    }
+
+    /*  PC */
+    if (n == 34) {
+        return gdb_get_reg32(mem_buf, env->pc_w * 2);
+    }
+
+    return 0;
+}
+
+int avr_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
+{
+    AVRCPU *cpu = AVR_CPU(cs);
+    CPUAVRState *env = &cpu->env;
+
+    /*  R */
+    if (n < 32) {
+        env->r[n] = *mem_buf;
+        return 1;
+    }
+
+    /*  SREG */
+    if (n == 32) {
+        cpu_set_sreg(env, *mem_buf);
+        return 1;
+    }
+
+    /*  SP */
+    if (n == 33) {
+        env->sp = lduw_p(mem_buf);
+        return 2;
+    }
+
+    /*  PC */
+    if (n == 34) {
+        env->pc_w = ldl_p(mem_buf) / 2;
+        return 4;
+    }
+
+    return 0;
+}
-- 
2.26.2


