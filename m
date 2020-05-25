Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97776C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672172073B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 15:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ1W75TS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672172073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdEiZ-0006lc-IN
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 11:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEgp-00059I-DD
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:06:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jdEgo-0006e9-4P
 for qemu-devel@nongnu.org; Mon, 25 May 2020 11:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590419213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tb28TaMe2UAwfHSd9/zVdbHeMkOyBwbsrrxB9W155y4=;
 b=aQ1W75TSEcEkEjOYL7qEQ2r1LnCXu8fpcVCQq5paQw4ygWyE+nUG5USW2lpJJaULRmJ+Bi
 F2daoabON3YBsBU8Get13w7gkXELuf6+LgVdAekYU7qme2ElRJ9GUmnw9gm+KIY1gufc5F
 jnrZUhj5jrW+2PcfObsmjDl/ObRBfOc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-8M35ZbWZP8uyWSA2Bkn0Zg-1; Mon, 25 May 2020 11:06:52 -0400
X-MC-Unique: 8M35ZbWZP8uyWSA2Bkn0Zg-1
Received: by mail-ej1-f69.google.com with SMTP id f17so6418191ejc.7
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 08:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tb28TaMe2UAwfHSd9/zVdbHeMkOyBwbsrrxB9W155y4=;
 b=NnlWkmW18hTqU7WXwzopzJS5WFZxmsqKmMHhPOS90yRmsH60hSMU+QOF5UNE8YJ7rx
 Hx7Zewq71IeR/6gVbigWOXaIbcuYRW+W1GZhGnaiHM55Kh4QNEVhUk1UDrlqptfyuELT
 iygdolKUSA2ktLaC9sOOPzOHD83BmPrA7iqCHx0OFS1jYfXR58GPDHpxWGIF+L4Oj6so
 GdfUY4CTaCnN8fp8jo2t+drrJlENVoQSq41UTEcmc95/P4pGPkiVRgC8CjMKDt5HH/gr
 TTdK0BEDt7Tx34So38CyeroD7umk+SMMRZv5FGTTstD2Yx24R8pV2n8fNzD7pbtR4rqL
 6cYg==
X-Gm-Message-State: AOAM533vPhHrpfyCtYLuBXPfftrMiGzDdC4SWm6szZL1TiMcI1rxtkDC
 PXoI2mMEc5NUewVDjSADrQrms9gf2IQGGVGB84OJzIu9VMC0V6QLifeE5eDzUB3O/l57jKq774x
 nKghgKV2f3KyMTlw=
X-Received: by 2002:a17:906:379b:: with SMTP id
 n27mr18639528ejc.432.1590419210430; 
 Mon, 25 May 2020 08:06:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWkHNG++T3Jx8Ry6IMruCGNIeXnCrZPXBckZZRoes0Du5j+ZwaTMDMrTAG6ilGYJ21T6GP2A==
X-Received: by 2002:a17:906:379b:: with SMTP id
 n27mr18639485ejc.432.1590419210083; 
 Mon, 25 May 2020 08:06:50 -0700 (PDT)
Received: from x1w.redhat.com (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id g13sm13999111ejh.119.2020.05.25.08.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 08:06:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/9] target/i386: Restrict X86CPUFeatureWord to X86 targets
Date: Mon, 25 May 2020 17:06:32 +0200
Message-Id: <20200525150640.30879-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525150640.30879-1-philmd@redhat.com>
References: <20200525150640.30879-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 08:28:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Ben Warren <ben@skyportsystems.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move out x86-specific structures from generic machine code.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 qapi/machine-target.json   | 45 ++++++++++++++++++++++++++++++++++++++
 qapi/machine.json          | 42 -----------------------------------
 target/i386/cpu.c          |  2 +-
 target/i386/machine-stub.c | 22 +++++++++++++++++++
 target/i386/Makefile.objs  |  3 ++-
 5 files changed, 70 insertions(+), 44 deletions(-)
 create mode 100644 target/i386/machine-stub.c

diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f2c82949d8..fb7a4b7850 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -3,6 +3,51 @@
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
index ff7b5032e3..1fe31d374c 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -511,48 +511,6 @@
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
index 7a4a8e3847..832498c723 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -37,7 +37,7 @@
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
index 0000000000..cb301af057
--- /dev/null
+++ b/target/i386/machine-stub.c
@@ -0,0 +1,22 @@
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
+void visit_type_X86CPUFeatureWordInfoList(Visitor *v, const char *name,
+                                      X86CPUFeatureWordInfoList **obj,
+                                      Error **errp)
+{
+}
diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 48e0c28434..1cdfc9f50c 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_HAX) += hax-all.o hax-mem.o hax-posix.o
 endif
 obj-$(CONFIG_HVF) += hvf/
 obj-$(CONFIG_WHPX) += whpx-all.o
-endif
+endif # CONFIG_SOFTMMU
 obj-$(CONFIG_SEV) += sev.o
 obj-$(call lnot,$(CONFIG_SEV)) += sev-stub.o
+obj-$(call lnot,$(CONFIG_SOFTMMU)) += machine-stub.o
-- 
2.21.3


