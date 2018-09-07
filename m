Received: from eggs.gnu.org ([2001:4830:134:3::10]:46331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyFe4-00077A-Ta
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fyFe2-0004sr-3e
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 08:13:52 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  7 Sep 2018 16:13:19 +0400
Message-Id: <20180907121319.8607-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180907121319.8607-1-marcandre.lureau@redhat.com>
References: <20180907121319.8607-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/3] Delete PID file on exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Fam Zheng <famz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Register an exit notifier to remove the PID file. By the time atexit()
is called, qemu_write_pidfile() guarantees QEMU owns the PID file,
thus we could safely remove it when exiting.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 0eaf948d32..51af016602 100644
--- a/vl.c
+++ b/vl.c
@@ -2603,6 +2603,16 @@ static void qemu_run_exit_notifiers(void)
     notifier_list_notify(&exit_notifiers, NULL);
 }
=20
+static const char *pid_file;
+static Notifier qemu_unlink_pidfile_notifier;
+
+static void qemu_unlink_pidfile(Notifier *n, void *data)
+{
+    if (pid_file) {
+        unlink(pid_file);
+    }
+}
+
 bool machine_init_done;
=20
 void qemu_add_machine_init_done_notifier(Notifier *notify)
@@ -2927,7 +2937,6 @@ int main(int argc, char **argv, char **envp)
     const char *vga_model =3D NULL;
     const char *qtest_chrdev =3D NULL;
     const char *qtest_log =3D NULL;
-    const char *pid_file =3D NULL;
     const char *incoming =3D NULL;
     bool userconfig =3D true;
     bool nographic =3D false;
@@ -4001,6 +4010,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
=20
+    qemu_unlink_pidfile_notifier.notify =3D qemu_unlink_pidfile;
+    qemu_add_exit_notifier(&qemu_unlink_pidfile_notifier);
+
     if (qemu_init_main_loop(&main_loop_err)) {
         error_report_err(main_loop_err);
         exit(1);
--=20
2.19.0.rc1
