Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8QrH-0001qv-7j
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g8QrD-0005th-Nw
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:13:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1g8Qr4-0005i4-If
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:13:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA40830820DB
	for <qemu-devel@nongnu.org>; Fri,  5 Oct 2018 14:13:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  5 Oct 2018 16:13:12 +0200
Message-Id: <1538748792-19444-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

When compiling with "--disable-tcg", we currently still use "tcg"
as default accelerator. "kvm" should be used in this case instead.
Also, some downstream distros provide QEMU binaries which have "kvm"
in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
KVM by default - and some users might want to do something similar
with upstream binaries, too. Accomodate them by using "kvm:tcg" as
default when we detect such a binary name.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 accel/accel.c          | 18 +++++++++++++++---
 include/sysemu/accel.h |  2 +-
 vl.c                   |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 966b2d8..9be195c 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -68,7 +68,7 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
     return ret;
 }
 
-void configure_accelerator(MachineState *ms)
+void configure_accelerator(MachineState *ms, const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
@@ -79,8 +79,20 @@ void configure_accelerator(MachineState *ms)
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (accel == NULL) {
-        /* Use the default "accelerator", tcg */
-        accel = "tcg";
+        /* Select the default accelerator */
+        int pnlen = strlen(progname);
+        if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+            /* If the program name ends with "kvm", we prefer KVM */
+            accel = "kvm:tcg";
+        } else {
+#if defined(CONFIG_TCG)
+            accel = "tcg";
+#elif defined(CONFIG_KVM)
+            accel = "kvm";
+#else
+#error "No default accelerator available"
+#endif
+        }
     }
 
     accel_list = g_strsplit(accel, ":", 0);
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 637358f..285899e 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -66,7 +66,7 @@ typedef struct AccelClass {
 
 extern unsigned long tcg_tb_size;
 
-void configure_accelerator(MachineState *ms);
+void configure_accelerator(MachineState *ms, const char *progname);
 /* Register accelerator specific global properties */
 void accel_register_compat_props(AccelState *accel);
 /* Called just before os_setup_post (ie just before drop OS privs) */
diff --git a/vl.c b/vl.c
index 0388852..757246a 100644
--- a/vl.c
+++ b/vl.c
@@ -4220,7 +4220,7 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
-    configure_accelerator(current_machine);
+    configure_accelerator(current_machine, argv[0]);
 
     if (!qtest_enabled() && machine_class->deprecation_reason) {
         error_report("Machine type '%s' is deprecated: %s",
-- 
1.8.3.1
