Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B03EC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37FF20724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37FF20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5HW-0004Ai-4g
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5F1-00078M-K2
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:35 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51]:38328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5Ez-0008IA-Rj
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:35 -0400
Received: by mail-ej1-f51.google.com with SMTP id w16so39667693ejj.5
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jkC0aolhlj6RcBhlvFE2t0bB5Yx6UH76eFCh011rLYA=;
 b=GBHJTy2djowMvBrxecy2w64DCX+z/pvo/jO+/UPcL6moSloMj6ZlRqMnPQ8IoPUrCX
 ibxEg0ofgVA3IIi3F/pSCt9HE3X902gbHqoVhQO1YguecvJOYqkDhzj4nkLEs64NxDK0
 bng3xuPlYCaEd5W1kx4AG2270Q1FaSW9JSWo7RWfJMlsSSr0hCb8dwOyguKz8g05iWSj
 gCotcl7atlUBhVqY6uTnp5JxizAKX+YLWcWzPJijd5IMHOSkhNzsIG5tLh8hBicfjGhq
 6vOsn4/zpoFtEEYWcuAGkXmFJUp3RG7lSpnbgqWrwi+b95iOakRXLFUNzkTJYk6x5DZ5
 +BJA==
X-Gm-Message-State: AOAM531Q6IYxQqb7/bukwNDMGXsWN3l9ZBjdDixUJ3yp1IuLn+vBbuLr
 hA00rGdUR+yNyrobrb+X4eGKtWtP
X-Google-Smtp-Source: ABdhPJwiH7tkO/RIWTy2nMophv9qlKkACO37EyOVyxU86bFk0rwm8Ea+xaLRz/s+LKvvtN8VMmggyw==
X-Received: by 2002:a17:906:f202:: with SMTP id
 gt2mr39443768ejb.70.1593957812297; 
 Sun, 05 Jul 2020 07:03:32 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:31 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 05/30] target/avr: CPU class: Add migration support
Date: Sun,  5 Jul 2020 16:02:50 +0200
Message-Id: <20200705140315.260514-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:32
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

Add migration-related functions of AVR CPU class object.

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
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 target/avr/cpu.c     |   1 +
 target/avr/cpu.h     |   2 +
 target/avr/machine.c | 121 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)
 create mode 100644 target/avr/machine.c

diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index a1d5f3c1eb..ced1107824 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -206,6 +206,7 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
     cc->memory_rw_debug = avr_cpu_memory_rw_debug;
     cc->get_phys_page_debug = avr_cpu_get_phys_page_debug;
     cc->tlb_fill = avr_cpu_tlb_fill;
+    cc->vmsd = &vms_avr_cpu;
     cc->disas_set_info = avr_cpu_disas_set_info;
     cc->tcg_initialize = avr_cpu_tcg_init;
     cc->synchronize_from_tb = avr_cpu_synchronize_from_tb;
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index ac14e642bf..d3003f8e25 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -118,6 +118,8 @@ typedef struct AVRCPU {
     CPUAVRState env;
 } AVRCPU;
 
+extern const struct VMStateDescription vms_avr_cpu;
+
 void avr_cpu_do_interrupt(CPUState *cpu);
 bool avr_cpu_exec_interrupt(CPUState *cpu, int int_req);
 hwaddr avr_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
diff --git a/target/avr/machine.c b/target/avr/machine.c
new file mode 100644
index 0000000000..ba44bd042b
--- /dev/null
+++ b/target/avr/machine.c
@@ -0,0 +1,121 @@
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
+#include "cpu.h"
+#include "migration/cpu.h"
+
+static int get_sreg(QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg;
+
+    sreg = qemu_get_byte(f);
+    cpu_set_sreg(env, sreg);
+    return 0;
+}
+
+static int put_sreg(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    CPUAVRState *env = opaque;
+    uint8_t sreg = cpu_get_sreg(env);
+
+    qemu_put_byte(f, sreg);
+    return 0;
+}
+
+static const VMStateInfo vms_sreg = {
+    .name = "sreg",
+    .get = get_sreg,
+    .put = put_sreg,
+};
+
+static int get_segment(
+    QEMUFile *f, void *opaque, size_t size, const VMStateField *field)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp;
+
+    temp = qemu_get_byte(f);
+    *ramp = ((uint32_t)temp) << 16;
+    return 0;
+}
+
+static int put_segment(
+    QEMUFile *f, void *opaque, size_t size,
+    const VMStateField *field, QJSON *vmdesc)
+{
+    uint32_t *ramp = opaque;
+    uint8_t temp = *ramp >> 16;
+
+    qemu_put_byte(f, temp);
+    return 0;
+}
+
+static const VMStateInfo vms_rampD = {
+    .name = "rampD",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampX = {
+    .name = "rampX",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampY = {
+    .name = "rampY",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_rampZ = {
+    .name = "rampZ",
+    .get = get_segment,
+    .put = put_segment,
+};
+static const VMStateInfo vms_eind = {
+    .name = "eind",
+    .get = get_segment,
+    .put = put_segment,
+};
+
+const VMStateDescription vms_avr_cpu = {
+    .name = "cpu",
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(env.pc_w, AVRCPU),
+        VMSTATE_UINT32(env.sp, AVRCPU),
+        VMSTATE_UINT32(env.skip, AVRCPU),
+
+        VMSTATE_UINT32_ARRAY(env.r, AVRCPU, NUMBER_OF_CPU_REGISTERS),
+
+        VMSTATE_SINGLE(env, AVRCPU, 0, vms_sreg, CPUAVRState),
+        VMSTATE_SINGLE(env.rampD, AVRCPU, 0, vms_rampD, uint32_t),
+        VMSTATE_SINGLE(env.rampX, AVRCPU, 0, vms_rampX, uint32_t),
+        VMSTATE_SINGLE(env.rampY, AVRCPU, 0, vms_rampY, uint32_t),
+        VMSTATE_SINGLE(env.rampZ, AVRCPU, 0, vms_rampZ, uint32_t),
+        VMSTATE_SINGLE(env.eind, AVRCPU, 0, vms_eind, uint32_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
-- 
2.26.2


