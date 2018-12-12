Received: from eggs.gnu.org ([2001:4830:134:3::10]:51933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6MC-0000YJ-Kt
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6M7-0008K6-00
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:28 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6M5-0008HA-OT
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:22 -0500
Received: by mail-wr1-x42a.google.com with SMTP id r10so18075317wrs.10
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:19 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:22 +0100
Message-Id: <1544628195-37728-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/54] accel: Improve selection of the default
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

When compiling with "--disable-tcg", we currently still use "tcg"
as default accelerator. "kvm" should be used in this case instead.
Also, some downstream distros provide QEMU binaries which have "kvm"
in their names (e.g. "qemu-kvm" on RHEL or "kvm" on Ubuntu) that use
KVM by default - and some users might want to do something similar
with upstream binaries, too. Accomodate them by using "kvm:tcg" as
default when we detect such a binary name.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1538748792-19444-1-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/accel.c          | 18 +++++++++++++++---
 include/sysemu/accel.h |  2 +-
 vl.c                   |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/accel/accel.c b/accel/accel.c
index 3da26eb..1b1214e 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -69,7 +69,7 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms)
     return ret;
 }
 
-void configure_accelerator(MachineState *ms)
+void configure_accelerator(MachineState *ms, const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
@@ -80,8 +80,20 @@ void configure_accelerator(MachineState *ms)
 
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
index a5ae5f2..f6a6193 100644
--- a/vl.c
+++ b/vl.c
@@ -4308,7 +4308,7 @@ int main(int argc, char **argv, char **envp)
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine,
                      &error_fatal);
 
-    configure_accelerator(current_machine);
+    configure_accelerator(current_machine, argv[0]);
 
     if (!qtest_enabled() && machine_class->deprecation_reason) {
         error_report("Machine type '%s' is deprecated: %s",
-- 
1.8.3.1
