Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0506C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:28:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A742067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHy1lIcn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A742067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutp1-0000LG-P1
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutmf-0004c5-8B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:25:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1jutmd-0006sX-BQ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594628754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tBsau8jOfwRZQzzDPU2wnY6HOyNPZwnSDlheVxVne2k=;
 b=OHy1lIcnKmBWlCl5ikbeQu/PPpvD22kzE2IolNebm3fq9b/nc9K2zJmjU+VzZUblPXpzr1
 60BgVvknWL7aW+2JwfuzrJPzJ+Ko0qAdonO5MxXqfHSCicscH4r5DXKvLeOBeyldjg7KJh
 T7Q44QwDVC8wfIvFOomxgV8FssAaHAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-_LB_Mp3aO-2fmQU-_5DLYg-1; Mon, 13 Jul 2020 04:25:37 -0400
X-MC-Unique: _LB_Mp3aO-2fmQU-_5DLYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 853A5E91A
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:25:36 +0000 (UTC)
Received: from localhost (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8125E60BF3;
 Mon, 13 Jul 2020 08:25:32 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] chardev: Extract system emulation specific code
Date: Mon, 13 Jul 2020 12:24:24 +0400
Message-Id: <20200713082424.2947383-9-marcandre.lureau@redhat.com>
In-Reply-To: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
References: <20200713082424.2947383-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Split out code only used during system emulation,
to reduce code pulled in user emulation and tools.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200423202112.644-6-philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/chardev-internal.h |  3 ++
 chardev/char.c             | 35 +------------------
 chardev/chardev-sysemu.c   | 69 ++++++++++++++++++++++++++++++++++++++
 chardev/Makefile.objs      |  1 +
 4 files changed, 74 insertions(+), 34 deletions(-)
 create mode 100644 chardev/chardev-sysemu.c

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index e0264ac3498..f4d0429763b 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -26,6 +26,7 @@
 
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
+#include "qom/object.h"
 
 #define MAX_MUX 4
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
@@ -59,4 +60,6 @@ typedef struct MuxChardev {
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
+Object *get_chardevs_root(void);
+
 #endif /* CHAR_MUX_H */
diff --git a/chardev/char.c b/chardev/char.c
index 807be52300e..77e7ec814f2 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -45,7 +45,7 @@
 /***********************************************************/
 /* character device */
 
-static Object *get_chardevs_root(void)
+Object *get_chardevs_root(void)
 {
     return container_get(object_get_root(), "/chardevs");
 }
@@ -305,33 +305,6 @@ static const TypeInfo char_type_info = {
     .class_init = char_class_init,
 };
 
-static int chardev_machine_done_notify_one(Object *child, void *opaque)
-{
-    Chardev *chr = (Chardev *)child;
-    ChardevClass *class = CHARDEV_GET_CLASS(chr);
-
-    if (class->chr_machine_done) {
-        return class->chr_machine_done(chr);
-    }
-
-    return 0;
-}
-
-static void chardev_machine_done_hook(Notifier *notifier, void *unused)
-{
-    int ret = object_child_foreach(get_chardevs_root(),
-                                   chardev_machine_done_notify_one, NULL);
-
-    if (ret) {
-        error_report("Failed to call chardev machine_done hooks");
-        exit(1);
-    }
-}
-
-static Notifier chardev_machine_done_notify = {
-    .notify = chardev_machine_done_hook,
-};
-
 static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
@@ -1198,12 +1171,6 @@ void qemu_chr_cleanup(void)
 static void register_types(void)
 {
     type_register_static(&char_type_info);
-
-    /* this must be done after machine init, since we register FEs with muxes
-     * as part of realize functions like serial_isa_realizefn when -nographic
-     * is specified
-     */
-    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
 }
 
 type_init(register_types);
diff --git a/chardev/chardev-sysemu.c b/chardev/chardev-sysemu.c
new file mode 100644
index 00000000000..eecdc615ee1
--- /dev/null
+++ b/chardev/chardev-sysemu.c
@@ -0,0 +1,69 @@
+/*
+ * QEMU System Emulator
+ *
+ * Copyright (c) 2003-2008 Fabrice Bellard
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "chardev/char.h"
+#include "qemu/error-report.h"
+#include "chardev-internal.h"
+
+static int chardev_machine_done_notify_one(Object *child, void *opaque)
+{
+    Chardev *chr = (Chardev *)child;
+    ChardevClass *class = CHARDEV_GET_CLASS(chr);
+
+    if (class->chr_machine_done) {
+        return class->chr_machine_done(chr);
+    }
+
+    return 0;
+}
+
+static void chardev_machine_done_hook(Notifier *notifier, void *unused)
+{
+    int ret = object_child_foreach(get_chardevs_root(),
+                                   chardev_machine_done_notify_one, NULL);
+
+    if (ret) {
+        error_report("Failed to call chardev machine_done hooks");
+        exit(1);
+    }
+}
+
+
+static Notifier chardev_machine_done_notify = {
+    .notify = chardev_machine_done_hook,
+};
+
+static void register_types(void)
+{
+    /*
+     * This must be done after machine init, since we register FEs with muxes
+     * as part of realize functions like serial_isa_realizefn when -nographic
+     * is specified.
+     */
+    qemu_add_machine_init_done_notifier(&chardev_machine_done_notify);
+}
+
+type_init(register_types);
diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
index 62ec0a33235..3783dadc4c7 100644
--- a/chardev/Makefile.objs
+++ b/chardev/Makefile.objs
@@ -1,4 +1,5 @@
 chardev-obj-y += char.o
+chardev-obj-$(CONFIG_SOFTMMU) += chardev-sysemu.o
 chardev-obj-$(CONFIG_WIN32) += char-console.o
 chardev-obj-$(CONFIG_POSIX) += char-fd.o
 chardev-obj-y += char-fe.o
-- 
2.27.0.221.ga08a83db2b


