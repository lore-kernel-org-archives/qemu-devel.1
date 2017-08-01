Received: from eggs.gnu.org ([2001:4830:134:3::10]:59539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrV-0004J3-6s
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrT-0007AH-1y
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:36 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZrS-0007A0-R5
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:34 -0400
Received: by mail-wr0-x241.google.com with SMTP id y43so1805099wrd.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:11 +0200
Message-Id: <1501604245-33460-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/17] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

Only emit "XXX accelerator not found", if there are not
further accelerators listed. eg

   accel=kvm:tcg

doesn't print a "KVM accelerator not found" warning
when it falls back to tcg, but a

   accel=kvm

prints a warning, since no fallback is given.

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20170717144527.24534-1-lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index fa85844..8ae40e1 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -33,6 +33,7 @@
 #include "sysemu/qtest.h"
 #include "hw/xen/xen.h"
 #include "qom/object.h"
+#include "qemu/error-report.h"
 
 static const TypeInfo accel_type = {
     .name = TYPE_ACCEL,
@@ -69,19 +70,20 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
 
 void configure_accelerator(MachineState *ms)
 {
-    const char *p;
+    const char *accel, *p;
     char buf[10];
     int ret;
     bool accel_initialised = false;
     bool init_failed = false;
     AccelClass *acc = NULL;
 
-    p = qemu_opt_get(qemu_get_machine_opts(), "accel");
-    if (p == NULL) {
+    accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
+    if (accel == NULL) {
         /* Use the default "accelerator", tcg */
-        p = "tcg";
+        accel = "tcg";
     }
 
+    p = accel;
     while (!accel_initialised && *p != '\0') {
         if (*p == ':') {
             p++;
@@ -89,7 +91,6 @@ void configure_accelerator(MachineState *ms)
         p = get_opt_name(buf, sizeof(buf), p, ':');
         acc = accel_find(buf);
         if (!acc) {
-            fprintf(stderr, "\"%s\" accelerator not found.\n", buf);
             continue;
         }
         if (acc->available && !acc->available()) {
@@ -100,9 +101,8 @@ void configure_accelerator(MachineState *ms)
         ret = accel_init_machine(acc, ms);
         if (ret < 0) {
             init_failed = true;
-            fprintf(stderr, "failed to initialize %s: %s\n",
-                    acc->name,
-                    strerror(-ret));
+            error_report("failed to initialize %s: %s",
+                         acc->name, strerror(-ret));
         } else {
             accel_initialised = true;
         }
@@ -110,13 +110,13 @@ void configure_accelerator(MachineState *ms)
 
     if (!accel_initialised) {
         if (!init_failed) {
-            fprintf(stderr, "No accelerator found!\n");
+            error_report("-machine accel=%s: No accelerator found", accel);
         }
         exit(1);
     }
 
     if (init_failed) {
-        fprintf(stderr, "Back to %s accelerator.\n", acc->name);
+        error_report("Back to %s accelerator", acc->name);
     }
 }
 
-- 
1.8.3.1
