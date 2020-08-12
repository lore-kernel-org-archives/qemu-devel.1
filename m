Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909D7208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 12:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909D7208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weckbecker.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5pik-0006al-U1
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 08:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthias@weckbecker.name>)
 id 1k5ph9-0005Qx-Ua
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:17:27 -0400
Received: from weckbecker.name ([87.118.122.104]:64220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthias@weckbecker.name>)
 id 1k5ph5-0002ON-Ut
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 08:17:27 -0400
Received: by weckbecker.name (Postfix, from userid 1000)
 id 654441A83AC; Wed, 12 Aug 2020 13:59:14 +0200 (CEST)
From: Matthias Weckbecker <matthias@weckbecker.name>
To: qemu-devel@nongnu.org
Subject: [PATCH] plugins: new syscalls plugin
Date: Wed, 12 Aug 2020 13:58:17 +0200
Message-Id: <20200812115816.4454-1-matthias@weckbecker.name>
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=87.118.122.104;
 envelope-from=matthias@weckbecker.name; helo=weckbecker.name
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 08:17:14
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Cc: Matthias Weckbecker <matthias@weckbecker.name>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit adds a new syscalls plugin that displays the syscalls
as they are executed and returned. This plugin outputs the number
of the syscall as well as the syscall return value.

Works in *-user only.

Essentially, this commit restores:

  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg00846.html

by using the new QEMU plugin API.

Signed-off-by: Matthias Weckbecker <matthias@weckbecker.name>
---
 tests/plugin/Makefile  |  1 +
 tests/plugin/syscall.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/plugin/syscall.c

diff --git a/tests/plugin/Makefile b/tests/plugin/Makefile
index e9348fde4a..fc176909e9 100644
--- a/tests/plugin/Makefile
+++ b/tests/plugin/Makefile
@@ -21,6 +21,7 @@ NAMES += hotblocks
 NAMES += howvec
 NAMES += hotpages
 NAMES += lockstep
+NAMES += syscall
 
 SONAMES := $(addsuffix .so,$(addprefix lib,$(NAMES)))
 
diff --git a/tests/plugin/syscall.c b/tests/plugin/syscall.c
new file mode 100644
index 0000000000..53ee2ab6c4
--- /dev/null
+++ b/tests/plugin/syscall.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2020, Matthias Weckbecker <matthias@weckbecker.name>
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+#include <inttypes.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <glib.h>
+
+#include <qemu-plugin.h>
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
+                         int64_t num, uint64_t a1, uint64_t a2,
+                         uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8)
+{
+    g_autofree gchar *out = g_strdup_printf("syscall #%" PRIi64 "\n", num);
+    qemu_plugin_outs(out);
+}
+
+static void vcpu_syscall_ret(qemu_plugin_id_t id, unsigned int vcpu_idx,
+                             int64_t num, int64_t ret)
+{
+    g_autofree gchar *out;
+    out = g_strdup_printf("syscall #%" PRIi64 " returned -> %" PRIi64 "\n",
+            num, ret);
+    qemu_plugin_outs(out);
+}
+
+/* ************************************************************************* */
+
+static void plugin_exit(qemu_plugin_id_t id, void *p) {}
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
+                                           const qemu_info_t *info,
+                                           int argc, char **argv)
+{
+    qemu_plugin_register_vcpu_syscall_cb(id, vcpu_syscall);
+    qemu_plugin_register_vcpu_syscall_ret_cb(id, vcpu_syscall_ret);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+    return 0;
+}
-- 
2.23.0


