Received: from eggs.gnu.org ([2001:4830:134:3::10]:42880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28K-00005U-HZ
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28I-0002Xb-N5
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28I-0002VR-F2
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA37C804FA
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:26 +0100
Message-Id: <20181217231700.24482-2-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/35] accel: Improve selection of the default
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
index 3da26eb90f..1b1214e273 100644
--- a/accel/accel.c
+++ b/accel/accel.c
@@ -69,7 +69,7 @@ static int accel_init_machine(AccelClass *acc, MachineS=
tate *ms)
     return ret;
 }
=20
-void configure_accelerator(MachineState *ms)
+void configure_accelerator(MachineState *ms, const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
@@ -80,8 +80,20 @@ void configure_accelerator(MachineState *ms)
=20
     accel =3D qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (accel =3D=3D NULL) {
-        /* Use the default "accelerator", tcg */
-        accel =3D "tcg";
+        /* Select the default accelerator */
+        int pnlen =3D strlen(progname);
+        if (pnlen >=3D 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+            /* If the program name ends with "kvm", we prefer KVM */
+            accel =3D "kvm:tcg";
+        } else {
+#if defined(CONFIG_TCG)
+            accel =3D "tcg";
+#elif defined(CONFIG_KVM)
+            accel =3D "kvm";
+#else
+#error "No default accelerator available"
+#endif
+        }
     }
=20
     accel_list =3D g_strsplit(accel, ":", 0);
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 637358f430..285899e588 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -66,7 +66,7 @@ typedef struct AccelClass {
=20
 extern unsigned long tcg_tb_size;
=20
-void configure_accelerator(MachineState *ms);
+void configure_accelerator(MachineState *ms, const char *progname);
 /* Register accelerator specific global properties */
 void accel_register_compat_props(AccelState *accel);
 /* Called just before os_setup_post (ie just before drop OS privs) */
diff --git a/vl.c b/vl.c
index 2a8b2ee16d..5f6ff43b1b 100644
--- a/vl.c
+++ b/vl.c
@@ -4303,7 +4303,7 @@ int main(int argc, char **argv, char **envp)
     qemu_opt_foreach(machine_opts, machine_set_property, current_machine=
,
                      &error_fatal);
=20
-    configure_accelerator(current_machine);
+    configure_accelerator(current_machine, argv[0]);
=20
     if (!qtest_enabled() && machine_class->deprecation_reason) {
         error_report("Machine type '%s' is deprecated: %s",
--=20
2.20.1
