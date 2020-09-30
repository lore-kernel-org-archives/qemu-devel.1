Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A8FC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1642085B
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 16:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke7CGG2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1642085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfPb-0005Ts-AI
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 12:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJe-0006hw-DO
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNfJc-0007DM-2z
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 12:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601484651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FD/Sn/zEqk9dQKIbQoXOYve2d137UlETatSPRZNX5Dk=;
 b=Ke7CGG2vYGwFU++kOcUQFupNS04LiXxSNToHXdgKrap/M2BkrwiJ9gYuz4lNhmFmkpUwa9
 lb7fg7YN+DbaFXffapCftSS2BNabbAHXDnu5J2xFV53XpBUyQL9vtk287MbwdqDst+wHZv
 qqScLfCfOOa7hYduWZNAGTbn2jqnoZw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-RfyEOMMwMe6aIsvPEQ3K5g-1; Wed, 30 Sep 2020 12:50:48 -0400
X-MC-Unique: RfyEOMMwMe6aIsvPEQ3K5g-1
Received: by mail-wm1-f72.google.com with SMTP id a7so68180wmc.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 09:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FD/Sn/zEqk9dQKIbQoXOYve2d137UlETatSPRZNX5Dk=;
 b=BO7xx8sFtPsNkoga0ZZT0hZKhhsMqOWxx7Oy9tT3cppa60OjrcrkTMhmfIpOkXYsPu
 q1/qi162l1xTewOVefFc0Dmnul5bBnOQ3RJbeGAOk2Pwja8uVwkyIrWKHsH9jK2D8Ux5
 lAq0FYjAxfVbuM82Nwt6RsfrPt2iBZvK7g6cCDrjWjRDTWyUHKxLv0pTwOcQoCe0gySI
 ushZrDdkQRtVBrLhTKdcg8P64WUxjlvG34F2vmZS2vvp9nKn34mSrcSYzpBKBjwzggAr
 GsPy9MCbVTR47givbvzkGFuz4BszGIYS6s/BBZecNcZGBI4iQlIUc6HDMNpNmodgeLd+
 jS8A==
X-Gm-Message-State: AOAM533dAmjU0yJZxntmgKeqBzbNp6lLWYaQq5Nrp194kLKQmDxQoFqz
 IlcuZsS9+Hn0cCoNRWR2+BgDnLvwSZsKVpWaQjg0RrX6dmOlL/81djn78C3qEmpogaMMBk1/uUM
 mpmj1ZKLFNtPtFMo=
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr4010760wro.315.1601484646501; 
 Wed, 30 Sep 2020 09:50:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHoKmzKfrCAZuzq+wwimEabmMc7cpUzoabhj+YUeLa5g0x+0zXj3Wn0hpiCmUIECSRiZA1DA==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr4010725wro.315.1601484646259; 
 Wed, 30 Sep 2020 09:50:46 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id o16sm3781269wrp.52.2020.09.30.09.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:50:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 10/11] target/i386: Restrict X86CPUFeatureWord to X86
 targets
Date: Wed, 30 Sep 2020 18:49:48 +0200
Message-Id: <20200930164949.1425294-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Peter Lieven <pl@kamp.de>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only qemu-system-FOO and qemu-storage-daemon provide QMP
monitors, therefore such declarations and definitions are
irrelevant for user-mode emulation.

Restricting the x86-specific commands to machine-target.json
pulls less QAPI-generated code into user-mode.

Add a stub to satisfy linking in user-mode:

  /usr/bin/ld: libqemu-i386-linux-user.fa.p/target_i386_cpu.c.o: in function `x86_cpu_get_feature_words':
  target/i386/cpu.c:4643: undefined reference to `visit_type_X86CPUFeatureWordInfoList'
  collect2: error: ld returned 1 exit status
  make: *** [Makefile.ninja:1125: qemu-i386] Error 1

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v3: Reworded + Meson rebase
---
 qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 42 -----------------------------------
 target/i386/cpu.c          |  2 +-
 target/i386/feature-stub.c | 23 +++++++++++++++++++
 target/i386/meson.build    |  1 +
 5 files changed, 70 insertions(+), 43 deletions(-)
 create mode 100644 target/i386/feature-stub.c

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 698850cc78..b4d769a53b 100644
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
index 72f014bb5b..cb878acdac 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -544,48 +544,6 @@
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
index 3ffd877dd5..d45fa217cc 100644
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
diff --git a/target/i386/feature-stub.c b/target/i386/feature-stub.c
new file mode 100644
index 0000000000..787c3c7fa1
--- /dev/null
+++ b/target/i386/feature-stub.c
@@ -0,0 +1,23 @@
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
+ * SPDX-License-Identifier: GPL-2.0-or-later
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
index e0b71ade56..0c5d9e6caf 100644
--- a/target/i386/meson.build
+++ b/target/i386/meson.build
@@ -5,6 +5,7 @@ i386_ss.add(files(
   'helper.c',
   'xsave_helper.c',
 ))
+i386_ss.add(when: 'CONFIG_SOFTMMU', if_false: files('feature-stub.c'))
 i386_ss.add(when: 'CONFIG_TCG', if_true: files(
   'bpt_helper.c',
   'cc_helper.c',
-- 
2.26.2


