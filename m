Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97982C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472982074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 08:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua4UokBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472982074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl7R7-0007a5-Ld
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 04:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QI-0006hM-JU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jl7QF-00028U-UM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 04:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592297903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NINe4GSiPi1sNJvh9oUdQz7mUxLL3M2cbdy5VvfOGMI=;
 b=Ua4UokBx70zJWDGFKVh5Vb+1JCefqko4f1NqJ5KAgrUbNZfc6KvOB3AomCnEw1uA0Cjo0W
 BbCe4+OO426tXGH3LC4QwhYTKa3uxrc0nBRLKeVjZZR6v6+J4Xi35cqwlX6BZNwJ/xQjK9
 NUZGVq7jm6MzosYfp0Krzetm75vv6Wo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-KHLsOEuNPKy1xk-2-4kRkw-1; Tue, 16 Jun 2020 04:58:21 -0400
X-MC-Unique: KHLsOEuNPKy1xk-2-4kRkw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05E7D1009445;
 Tue, 16 Jun 2020 08:58:20 +0000 (UTC)
Received: from thuth.com (ovpn-114-128.ams2.redhat.com [10.36.114.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE11F6ED96;
 Tue, 16 Jun 2020 08:58:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 2/7] fuzz: skip QTest serialization
Date: Tue, 16 Jun 2020 10:58:08 +0200
Message-Id: <20200616085813.29296-3-thuth@redhat.com>
In-Reply-To: <20200616085813.29296-1-thuth@redhat.com>
References: <20200616085813.29296-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

The QTest server usually parses ASCII commands from clients. Since we
fuzz within the QEMU process, skip the QTest serialization and server
for most QTest commands. Leave the option to use the ASCII protocol, to
generate readable traces for crash reproducers.

Inspired-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20200529221450.26673-2-alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/Makefile.include |  21 +++
 tests/qtest/fuzz/fuzz.c           |  13 +-
 tests/qtest/fuzz/fuzz.h           |   3 +
 tests/qtest/fuzz/qtest_wrappers.c | 252 ++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/fuzz/qtest_wrappers.c

diff --git a/tests/qtest/fuzz/Makefile.include b/tests/qtest/fuzz/Makefile.include
index f259d866c9..5bde793bf2 100644
--- a/tests/qtest/fuzz/Makefile.include
+++ b/tests/qtest/fuzz/Makefile.include
@@ -5,6 +5,7 @@ fuzz-obj-y += $(libqos-obj-y)
 fuzz-obj-y += tests/qtest/fuzz/fuzz.o # Fuzzer skeleton
 fuzz-obj-y += tests/qtest/fuzz/fork_fuzz.o
 fuzz-obj-y += tests/qtest/fuzz/qos_fuzz.o
+fuzz-obj-y += tests/qtest/fuzz/qtest_wrappers.o
 
 # Targets
 fuzz-obj-$(CONFIG_PCI_I440FX) += tests/qtest/fuzz/i440fx_fuzz.o
@@ -16,3 +17,23 @@ FUZZ_CFLAGS += -I$(SRC_PATH)/tests -I$(SRC_PATH)/tests/qtest
 # Linker Script to force coverage-counters into known regions which we can mark
 # shared
 FUZZ_LDFLAGS += -Xlinker -T$(SRC_PATH)/tests/qtest/fuzz/fork_fuzz.ld
+
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_inb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_inw
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_inl
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_outb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_outw
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_outl
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readw
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readl
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_readq
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeb
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writew
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writel
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_writeq
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_memread
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufread
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_memwrite
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_bufwrite
+FUZZ_LDFLAGS += -Wl,-wrap,qtest_memset
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 33365c3782..ea630ddb9b 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -91,7 +91,10 @@ static void usage(char *path)
         printf(" * %s  : %s\n", tmp->target->name,
                 tmp->target->description);
     }
-    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n");
+    printf("Alternatively, add -target-FUZZ_TARGET to the executable name\n\n"
+           "Set the environment variable FUZZ_SERIALIZE_QTEST=1 to serialize\n"
+           "QTest commands into an ASCII protocol. Useful for building crash\n"
+           "reproducers, but slows down execution.\n");
     exit(0);
 }
 
@@ -138,6 +141,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
 
     char *target_name;
     char *dir;
+    bool serialize = false;
 
     /* Initialize qgraph and modules */
     qos_graph_init();
@@ -172,6 +176,13 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
         usage(**argv);
     }
 
+    /* Should we always serialize qtest commands? */
+    if (getenv("FUZZ_SERIALIZE_QTEST")) {
+        serialize = true;
+    }
+
+    fuzz_qtest_set_serialize(serialize);
+
     /* Identify the fuzz target */
     fuzz_target = fuzz_get_target(target_name);
     if (!fuzz_target) {
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 03901d414e..72d5710f6c 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -82,6 +82,9 @@ typedef struct FuzzTarget {
 void flush_events(QTestState *);
 void reboot(QTestState *);
 
+/* Use the QTest ASCII protocol or call address_space API directly?*/
+void fuzz_qtest_set_serialize(bool option);
+
 /*
  * makes a copy of *target and adds it to the target-list.
  * i.e. fine to set up target on the caller's stack
diff --git a/tests/qtest/fuzz/qtest_wrappers.c b/tests/qtest/fuzz/qtest_wrappers.c
new file mode 100644
index 0000000000..713c830cdb
--- /dev/null
+++ b/tests/qtest/fuzz/qtest_wrappers.c
@@ -0,0 +1,252 @@
+/*
+ * qtest function wrappers
+ *
+ * Copyright Red Hat Inc., 2019
+ *
+ * Authors:
+ *  Alexander Bulekov   <alxndr@bu.edu>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/ioport.h"
+
+#include "fuzz.h"
+
+static bool serialize = true;
+
+#define WRAP(RET_TYPE, NAME_AND_ARGS)\
+    RET_TYPE __wrap_##NAME_AND_ARGS;\
+    RET_TYPE __real_##NAME_AND_ARGS;
+
+WRAP(uint8_t  , qtest_inb(QTestState *s, uint16_t addr))
+WRAP(uint16_t , qtest_inw(QTestState *s, uint16_t addr))
+WRAP(uint32_t , qtest_inl(QTestState *s, uint16_t addr))
+WRAP(void     , qtest_outb(QTestState *s, uint16_t addr, uint8_t value))
+WRAP(void     , qtest_outw(QTestState *s, uint16_t addr, uint16_t value))
+WRAP(void     , qtest_outl(QTestState *s, uint16_t addr, uint32_t value))
+WRAP(uint8_t  , qtest_readb(QTestState *s, uint64_t addr))
+WRAP(uint16_t , qtest_readw(QTestState *s, uint64_t addr))
+WRAP(uint32_t , qtest_readl(QTestState *s, uint64_t addr))
+WRAP(uint64_t , qtest_readq(QTestState *s, uint64_t addr))
+WRAP(void     , qtest_writeb(QTestState *s, uint64_t addr, uint8_t value))
+WRAP(void     , qtest_writew(QTestState *s, uint64_t addr, uint16_t value))
+WRAP(void     , qtest_writel(QTestState *s, uint64_t addr, uint32_t value))
+WRAP(void     , qtest_writeq(QTestState *s, uint64_t addr, uint64_t value))
+WRAP(void     , qtest_memread(QTestState *s, uint64_t addr,
+                              void *data, size_t size))
+WRAP(void     , qtest_bufread(QTestState *s, uint64_t addr, void *data,
+                              size_t size))
+WRAP(void     , qtest_memwrite(QTestState *s, uint64_t addr, const void *data,
+                               size_t size))
+WRAP(void,      qtest_bufwrite(QTestState *s, uint64_t addr,
+                               const void *data, size_t size))
+WRAP(void,      qtest_memset(QTestState *s, uint64_t addr,
+                             uint8_t patt, size_t size))
+
+
+uint8_t __wrap_qtest_inb(QTestState *s, uint16_t addr)
+{
+    if (!serialize) {
+        return cpu_inb(addr);
+    } else {
+        return __real_qtest_inb(s, addr);
+    }
+}
+
+uint16_t __wrap_qtest_inw(QTestState *s, uint16_t addr)
+{
+    if (!serialize) {
+        return cpu_inw(addr);
+    } else {
+        return __real_qtest_inw(s, addr);
+    }
+}
+
+uint32_t __wrap_qtest_inl(QTestState *s, uint16_t addr)
+{
+    if (!serialize) {
+        return cpu_inl(addr);
+    } else {
+        return __real_qtest_inl(s, addr);
+    }
+}
+
+void __wrap_qtest_outb(QTestState *s, uint16_t addr, uint8_t value)
+{
+    if (!serialize) {
+        cpu_outb(addr, value);
+    } else {
+        __real_qtest_outb(s, addr, value);
+    }
+}
+
+void __wrap_qtest_outw(QTestState *s, uint16_t addr, uint16_t value)
+{
+    if (!serialize) {
+        cpu_outw(addr, value);
+    } else {
+        __real_qtest_outw(s, addr, value);
+    }
+}
+
+void __wrap_qtest_outl(QTestState *s, uint16_t addr, uint32_t value)
+{
+    if (!serialize) {
+        cpu_outl(addr, value);
+    } else {
+        __real_qtest_outl(s, addr, value);
+    }
+}
+
+uint8_t __wrap_qtest_readb(QTestState *s, uint64_t addr)
+{
+    uint8_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 1);
+        return value;
+    } else {
+        return __real_qtest_readb(s, addr);
+    }
+}
+
+uint16_t __wrap_qtest_readw(QTestState *s, uint64_t addr)
+{
+    uint16_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 2);
+        return value;
+    } else {
+        return __real_qtest_readw(s, addr);
+    }
+}
+
+uint32_t __wrap_qtest_readl(QTestState *s, uint64_t addr)
+{
+    uint32_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 4);
+        return value;
+    } else {
+        return __real_qtest_readl(s, addr);
+    }
+}
+
+uint64_t __wrap_qtest_readq(QTestState *s, uint64_t addr)
+{
+    uint64_t value;
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 8);
+        return value;
+    } else {
+        return __real_qtest_readq(s, addr);
+    }
+}
+
+void __wrap_qtest_writeb(QTestState *s, uint64_t addr, uint8_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 1);
+    } else {
+        __real_qtest_writeb(s, addr, value);
+    }
+}
+
+void __wrap_qtest_writew(QTestState *s, uint64_t addr, uint16_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 2);
+    } else {
+        __real_qtest_writew(s, addr, value);
+    }
+}
+
+void __wrap_qtest_writel(QTestState *s, uint64_t addr, uint32_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 4);
+    } else {
+        __real_qtest_writel(s, addr, value);
+    }
+}
+
+void __wrap_qtest_writeq(QTestState *s, uint64_t addr, uint64_t value)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            &value, 8);
+    } else {
+        __real_qtest_writeq(s, addr, value);
+    }
+}
+
+void __wrap_qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
+{
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           size);
+    } else {
+        __real_qtest_memread(s, addr, data, size);
+    }
+}
+
+void __wrap_qtest_bufread(QTestState *s, uint64_t addr, void *data, size_t size)
+{
+    if (!serialize) {
+        address_space_read(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED, data,
+                           size);
+    } else {
+        __real_qtest_bufread(s, addr, data, size);
+    }
+}
+
+void __wrap_qtest_memwrite(QTestState *s, uint64_t addr, const void *data,
+                           size_t size)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            data, size);
+    } else {
+        __real_qtest_memwrite(s, addr, data, size);
+    }
+}
+
+void __wrap_qtest_bufwrite(QTestState *s, uint64_t addr,
+                    const void *data, size_t size)
+{
+    if (!serialize) {
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            data, size);
+    } else {
+        __real_qtest_bufwrite(s, addr, data, size);
+    }
+}
+void __wrap_qtest_memset(QTestState *s, uint64_t addr,
+                         uint8_t patt, size_t size)
+{
+    void *data;
+    if (!serialize) {
+        data = malloc(size);
+        memset(data, patt, size);
+        address_space_write(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                            data, size);
+    } else {
+        __real_qtest_memset(s, addr, patt, size);
+    }
+}
+
+void fuzz_qtest_set_serialize(bool option)
+{
+    serialize = option;
+}
-- 
2.18.1


