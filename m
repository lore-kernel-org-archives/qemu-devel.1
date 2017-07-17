Received: from eggs.gnu.org ([2001:4830:134:3::10]:39424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dX5xd-0001qs-Bo
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dX5xc-0000Qt-HB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:21:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1dX5xc-0000Qn-AO
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:21:16 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon, 17 Jul 2017 15:21:10 +0200
Message-Id: <20170717132110.29962-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] accel: cleanup error output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Ben Warren <ben@skyportsystems.com>, "Daniel P . Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>

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
---
 accel/accel.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index fa85844..ababeb8 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -69,19 +69,20 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
 
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
@@ -89,7 +90,6 @@ void configure_accelerator(MachineState *ms)
         p = get_opt_name(buf, sizeof(buf), p, ':');
         acc = accel_find(buf);
         if (!acc) {
-            fprintf(stderr, "\"%s\" accelerator not found.\n", buf);
             continue;
         }
         if (acc->available && !acc->available()) {
@@ -110,7 +110,8 @@ void configure_accelerator(MachineState *ms)
 
     if (!accel_initialised) {
         if (!init_failed) {
-            fprintf(stderr, "No accelerator found!\n");
+            fprintf(stderr, "-machine accel=%s: No accelerator found!\n",
+                    accel);
         }
         exit(1);
     }
-- 
2.9.4
