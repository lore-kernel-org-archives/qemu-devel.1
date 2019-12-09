Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702ADC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29F542077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGpl+q4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29F542077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKdv-0001C3-Uv
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXt-0003PP-Ok
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXo-0001EA-Ad
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:57 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXo-0001D9-3T
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:52 -0500
Received: by mail-wm1-x32c.google.com with SMTP id p9so15826795wmc.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J6kmay0/CICTcqz3JkZsoWunBp9NRsOcVHRaHxwN+QQ=;
 b=hGpl+q4/RP7Dqc4ZLKQ5/xAUtOtpQ4J3RLW/TAW0z2imj9oIwRED58EVuXVlUlINfE
 YN1w1Yul/1Sx/WPOAIGAk4afQpvxugbXeb3LnHvq/rLNm/bY/p80sNWAf9Kmf1rb3huR
 qj4lu2wGLTOwdr7RCPwd6tBZNYZ+RkB8YuUHp6QQyZFlYCg04+Ot+OG8EfzsYF0kOA0R
 9f2kw+TjUjwVCjuu4AFI0xjpPICzG8VOP6WN3IJje+ASWkwuLpx2c3pl93gTh9pW8hWW
 2cCOZREd/9Rglu28i+MAKPByhNrsNldADRxC3SRqVjXVL6dj9f/DCkeSM4WDya4o1jHk
 vc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=J6kmay0/CICTcqz3JkZsoWunBp9NRsOcVHRaHxwN+QQ=;
 b=UhXqrxOA9Y3ntLLtHEAh6MzerfECrm+a/k7AvQdVMGQ+6xBEubtvn99EOEh9Hf9o7y
 +BRlwZ6AGbEAMj+XA1WBzkDJoIUspNeuCQtf3XegGjHqMM4fcSmhep9xg2MC/k7Vq+AL
 88lLP3OXlYBhD0O5LeyPZiK4gPOBsCXsgTaecHwWnhAGBwxmox+xk6JV9lXF3A+M1mZ3
 k6pYmVYKIBPQ3M1XPiTKolcjosfiOV03wlrb85+JOXTU3XCtbLjiWJdeJuolhrOUO2fn
 GchTakwyWwbXTDlGqCJdWPk0yGT3C91iRjsaEiiFbbYO3B/Vni9G8DLW/hMOEFS+JAC9
 4/Kg==
X-Gm-Message-State: APjAAAUEpQf/RtcwbXsEhbKNdKbZSl7tIfpSl1nEhDWAxF6xrQf6XenZ
 on7K+/o/cr16Yx+A02G0Mjtlvv8g
X-Google-Smtp-Source: APXvYqxIpDxn8fvpDsaqLTXTZE5YNnbVqWFc4rKrIq8k7OSM9Ux6CZcHkRGcfuLGp2NE937IYCaHUA==
X-Received: by 2002:a05:600c:2509:: with SMTP id
 d9mr25863441wma.148.1575903710677; 
 Mon, 09 Dec 2019 07:01:50 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/18] tcg: move qemu_tcg_configure to accel/tcg/tcg-all.c
Date: Mon,  9 Dec 2019 16:01:30 +0100
Message-Id: <1575903705-12925-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move everything related to mttcg_enabled in accel/tcg/tcg-all.c,
which will make even more sense when "thread" becomes a QOM property.

For now, initializing mttcg_enabled in the instance_init function
prepares for the next patch, which will only invoke qemu_tcg_configure
when the command line includes a -accel option.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/tcg-all.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 cpus.c              | 72 ---------------------------------------------
 2 files changed, 85 insertions(+), 72 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c59d5b0..78a0ab5 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -30,6 +30,11 @@
 #include "cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
+#include "tcg/tcg.h"
+#include "include/qapi/error.h"
+#include "include/qemu/error-report.h"
+#include "include/hw/boards.h"
+#include "qemu/option.h"
 
 unsigned long tcg_tb_size;
 
@@ -58,6 +63,55 @@ static void tcg_handle_interrupt(CPUState *cpu, int mask)
     }
 }
 
+/*
+ * We default to false if we know other options have been enabled
+ * which are currently incompatible with MTTCG. Otherwise when each
+ * guest (target) has been updated to support:
+ *   - atomic instructions
+ *   - memory ordering primitives (barriers)
+ * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
+ *
+ * Once a guest architecture has been converted to the new primitives
+ * there are two remaining limitations to check.
+ *
+ * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
+ * - The host must have a stronger memory order than the guest
+ *
+ * It may be possible in future to support strong guests on weak hosts
+ * but that will require tagging all load/stores in a guest with their
+ * implicit memory order requirements which would likely slow things
+ * down a lot.
+ */
+
+static bool check_tcg_memory_orders_compatible(void)
+{
+#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
+    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
+#else
+    return false;
+#endif
+}
+
+static bool default_mttcg_enabled(void)
+{
+    if (use_icount || TCG_OVERSIZED_GUEST) {
+        return false;
+    } else {
+#ifdef TARGET_SUPPORTS_MTTCG
+        return check_tcg_memory_orders_compatible();
+#else
+        return false;
+#endif
+    }
+}
+
+static void tcg_accel_instance_init(Object *obj)
+{
+    TCGState *s = TCG_STATE(obj);
+
+    mttcg_enabled = default_mttcg_enabled();
+}
+
 static int tcg_init(MachineState *ms)
 {
     tcg_exec_init(tcg_tb_size * 1024 * 1024);
@@ -65,6 +119,36 @@ static int tcg_init(MachineState *ms)
     return 0;
 }
 
+void qemu_tcg_configure(QemuOpts *opts, Error **errp)
+{
+    const char *t = qemu_opt_get(opts, "thread");
+    if (!t) {
+        return;
+    }
+    if (strcmp(t, "multi") == 0) {
+        if (TCG_OVERSIZED_GUEST) {
+            error_setg(errp, "No MTTCG when guest word size > hosts");
+        } else if (use_icount) {
+            error_setg(errp, "No MTTCG when icount is enabled");
+        } else {
+#ifndef TARGET_SUPPORTS_MTTCG
+            warn_report("Guest not yet converted to MTTCG - "
+                        "you may get unexpected results");
+#endif
+            if (!check_tcg_memory_orders_compatible()) {
+                warn_report("Guest expects a stronger memory ordering "
+                            "than the host provides");
+                error_printf("This may cause strange/hard to debug errors\n");
+            }
+            mttcg_enabled = true;
+        }
+    } else if (strcmp(t, "single") == 0) {
+        mttcg_enabled = false;
+    } else {
+        error_setg(errp, "Invalid 'thread' setting %s", t);
+    }
+}
+
 static void tcg_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
@@ -78,6 +162,7 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
 static const TypeInfo tcg_accel_type = {
     .name = TYPE_TCG_ACCEL,
     .parent = TYPE_ACCEL,
+    .instance_init = tcg_accel_instance_init,
     .class_init = tcg_accel_class_init,
 };
 
diff --git a/cpus.c b/cpus.c
index 63bda15..b472378 100644
--- a/cpus.c
+++ b/cpus.c
@@ -166,78 +166,6 @@ typedef struct TimersState {
 static TimersState timers_state;
 bool mttcg_enabled;
 
-/*
- * We default to false if we know other options have been enabled
- * which are currently incompatible with MTTCG. Otherwise when each
- * guest (target) has been updated to support:
- *   - atomic instructions
- *   - memory ordering primitives (barriers)
- * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
- *
- * Once a guest architecture has been converted to the new primitives
- * there are two remaining limitations to check.
- *
- * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
- * - The host must have a stronger memory order than the guest
- *
- * It may be possible in future to support strong guests on weak hosts
- * but that will require tagging all load/stores in a guest with their
- * implicit memory order requirements which would likely slow things
- * down a lot.
- */
-
-static bool check_tcg_memory_orders_compatible(void)
-{
-#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
-    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
-#else
-    return false;
-#endif
-}
-
-static bool default_mttcg_enabled(void)
-{
-    if (use_icount || TCG_OVERSIZED_GUEST) {
-        return false;
-    } else {
-#ifdef TARGET_SUPPORTS_MTTCG
-        return check_tcg_memory_orders_compatible();
-#else
-        return false;
-#endif
-    }
-}
-
-void qemu_tcg_configure(QemuOpts *opts, Error **errp)
-{
-    const char *t = qemu_opt_get(opts, "thread");
-    if (t) {
-        if (strcmp(t, "multi") == 0) {
-            if (TCG_OVERSIZED_GUEST) {
-                error_setg(errp, "No MTTCG when guest word size > hosts");
-            } else if (use_icount) {
-                error_setg(errp, "No MTTCG when icount is enabled");
-            } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-                warn_report("Guest not yet converted to MTTCG - "
-                            "you may get unexpected results");
-#endif
-                if (!check_tcg_memory_orders_compatible()) {
-                    warn_report("Guest expects a stronger memory ordering "
-                                "than the host provides");
-                    error_printf("This may cause strange/hard to debug errors\n");
-                }
-                mttcg_enabled = true;
-            }
-        } else if (strcmp(t, "single") == 0) {
-            mttcg_enabled = false;
-        } else {
-            error_setg(errp, "Invalid 'thread' setting %s", t);
-        }
-    } else {
-        mttcg_enabled = default_mttcg_enabled();
-    }
-}
 
 /* The current number of executed instructions is based on what we
  * originally budgeted minus the current state of the decrementing
-- 
1.8.3.1



