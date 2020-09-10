Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E57CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C21B20BED
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENSEofax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C21B20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGOQg-00059C-7N
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPJ-0003U0-V7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGOPH-000806-Pu
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 11:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599751359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WQL5Rg0KO1wW/kUeTHF0qQvQcG9izqh3L6F3in2qLBw=;
 b=ENSEofaxE97BmUUdaX3FmmUPSP4czy70R+MYAe8LiIwQHXzfQ/Y7/kdCvQsYICUOiVcBFD
 73oFKeY6FbUNMCucPwKvuYiu0cE0dAfr0eZr5Z46YoXVgj26XXbgc6ofF0ALPSHKSybADw
 fddgGNditSy77KEtgMxda34gKZsrlvI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-5c8VhbzqPWOsA7BtTEfXXA-1; Thu, 10 Sep 2020 11:22:35 -0400
X-MC-Unique: 5c8VhbzqPWOsA7BtTEfXXA-1
Received: by mail-wr1-f70.google.com with SMTP id a12so2381951wrg.13
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 08:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WQL5Rg0KO1wW/kUeTHF0qQvQcG9izqh3L6F3in2qLBw=;
 b=SbQqw9l2r5VkIwib+vGjziMWg34ufW71dutaDu/EnB8pHIEuuy52OjxRHHAB1ZPhf1
 XxRRbQ5pycqQbr3HlhRxO+o1zXPeNPJOV81xsq4mxXfkUyRIaFFlhAnHefNmbfSXW4vn
 CmFLaLmu80oXud6mmNWxFb3pIcYwoMFVmX7jsu2nvjJHkqF9Hd411DFKVx2qs0ahqekV
 G3tPVDD2cH1tCfld2Sd8CUYbz00CzsTNl+K8I7WDxEx8gdYnBBnrWkWkRSLagXOAUHlX
 ag4iCY6mkrDrFCRkWy0Fo4GIzadjCG6ClzMK+rfOVUn0We3e1MG/qT4JhP9d6VdXZDpf
 TuDA==
X-Gm-Message-State: AOAM5316aBo71aDy2ppedaRz4RgScCUxZlQAV/9cPXG5sLzX8YDwaGQ8
 W9wETTNk3//qZr5fzBx2rKCQC/8JNPSBYm3HmPXLKg2qbJKlWI9HcuulfFvUchDyJVHds2BJI3h
 HGS5R6159QRsmQIE=
X-Received: by 2002:a1c:3985:: with SMTP id g127mr582396wma.32.1599751353636; 
 Thu, 10 Sep 2020 08:22:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbA65CJmofD2HTYhw+7G6UuY8GCIrI5AUxWnCBdEt4L6aLWJz97r6imNh8FPnyTvSK1u67bA==
X-Received: by 2002:a1c:3985:: with SMTP id g127mr582356wma.32.1599751353395; 
 Thu, 10 Sep 2020 08:22:33 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z19sm3920246wmi.3.2020.09.10.08.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 08:22:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/9] target/i386: Restrict X86CPUFeatureWord to X86 targets
Date: Thu, 10 Sep 2020 17:22:17 +0200
Message-Id: <20200910152225.524322-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910152225.524322-1-philmd@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:38:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Lieven <pl@kamp.de>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move out x86-specific structures from generic machine code.

Since x86_cpu_initfn() register various CPU properties that
should not be available in user-mode (tsc/stepping/kvm/...),
add a stub to satisfy the linker.
Since only qemu-system-FOO and qemu-storage-daemon provide
QMP monitors, assert the stub function is never called.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 42 -----------------------------------
 target/i386/cpu.c          |  2 +-
 target/i386/machine-stub.c | 23 +++++++++++++++++++
 target/i386/meson.build    |  1 +
 5 files changed, 70 insertions(+), 43 deletions(-)
 create mode 100644 target/i386/machine-stub.c

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 698850cc78d..b4d769a53b9 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -4,6 +4,51 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
 
+##
+# @X86CPURegister32:
+#
+# A X86 32-bit register
+#
+# Since: 1.5
+##
+{ 'enum': 'X86CPURegister32',
+  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ],
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @X86CPUFeatureWordInfo:
+#
+# Information about a X86 CPU feature word
+#
+# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
+#
+# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
+#                   feature word
+#
+# @cpuid-register: Output register containing the feature bits
+#
+# @features: value of output register, containing the feature bits
+#
+# Since: 1.5
+##
+{ 'struct': 'X86CPUFeatureWordInfo',
+  'data': { 'cpuid-input-eax': 'int',
+            '*cpuid-input-ecx': 'int',
+            'cpuid-register': 'X86CPURegister32',
+            'features': 'int' },
+  'if': 'defined(TARGET_I386)' }
+
+##
+# @DummyForceArrays:
+#
+# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
+#
+# Since: 2.5
+##
+{ 'struct': 'DummyForceArrays',
+  'data': { 'unused': ['X86CPUFeatureWordInfo'] },
+  'if': 'defined(TARGET_I386)' }
+
 ##
 # @CpuModelInfo:
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 0ac1880e4a4..47e9c0b1831 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -516,48 +516,6 @@
    'dst': 'uint16',
    'val': 'uint8' }}
 
-##
-# @X86CPURegister32:
-#
-# A X86 32-bit register
-#
-# Since: 1.5
-##
-{ 'enum': 'X86CPURegister32',
-  'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
-
-##
-# @X86CPUFeatureWordInfo:
-#
-# Information about a X86 CPU feature word
-#
-# @cpuid-input-eax: Input EAX value for CPUID instruction for that feature word
-#
-# @cpuid-input-ecx: Input ECX value for CPUID instruction for that
-#                   feature word
-#
-# @cpuid-register: Output register containing the feature bits
-#
-# @features: value of output register, containing the feature bits
-#
-# Since: 1.5
-##
-{ 'struct': 'X86CPUFeatureWordInfo',
-  'data': { 'cpuid-input-eax': 'int',
-            '*cpuid-input-ecx': 'int',
-            'cpuid-register': 'X86CPURegister32',
-            'features': 'int' } }
-
-##
-# @DummyForceArrays:
-#
-# Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internally
-#
-# Since: 2.5
-##
-{ 'struct': 'DummyForceArrays',
-  'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
-
 ##
 # @NumaCpuOptions:
 #
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49d89585288..7ea1302734f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -38,7 +38,7 @@
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
-#include "qapi/qapi-visit-machine.h"
+#include "qapi/qapi-visit-machine-target.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/target/i386/machine-stub.c b/target/i386/machine-stub.c
new file mode 100644
index 00000000000..683916b5d55
--- /dev/null
+++ b/target/i386/machine-stub.c
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QAPI x86 CPU features stub
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * Author:
+ *   Philippe Mathieu-Daudé <philmd@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-machine-target.h"
+
+bool visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
+                                          X86CPUFeatureWordInfoList **obj,
+                                          Error **errp)
+{
+    g_assert_not_reached();
+}
diff --git a/target/i386/meson.build b/target/i386/meson.build
index e0b71ade56c..07d4e8c2109 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -20,6 +20,7 @@ i386_ss.add(when: 'CONFIG_TCG', if_true: files(
   'translate.c'), if_false: files('tcg-stub.c'))
 i386_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 i386_ss.add(when: 'CONFIG_SEV', if_true: files('sev.c'), if_false: files('sev-stub.c'))
+i386_ss.add(when: 'CONFIG_SOFTMMU', if_false: files('machine-stub.c'))
 
 i386_softmmu_ss = ss.source_set()
 i386_softmmu_ss.add(files(
-- 
2.26.2


