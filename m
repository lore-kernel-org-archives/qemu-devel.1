Received: from eggs.gnu.org ([2001:4830:134:3::10]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerR-00019x-Ro
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcerQ-0004mF-Vl
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcerQ-0004lr-ML
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 17:37:52 -0400
Date: Wed, 2 Aug 2017 00:37:47 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1501623438-31419-7-git-send-email-mst@redhat.com>
References: <1501623438-31419-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501623438-31419-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 06/10] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Anand J <anand.indukala@gmail.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
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
MST
