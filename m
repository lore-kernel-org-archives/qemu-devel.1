Received: from eggs.gnu.org ([2001:4830:134:3::10]:60647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvko7-0002iQ-Eo
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvko6-0005ZM-NG
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:53:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 16:53:14 +0200
Message-Id: <20180831145314.14736-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180831145314.14736-1-marcandre.lureau@redhat.com>
References: <20180831145314.14736-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/3] RFC: delete PID file on exit
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

Register an exit handler to remove the PID file. By the time atexit()
is called, qemu_write_pidfile() guarantees QEMU owns the PID file,
thus we could safely remove it when exiting.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 vl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 0eaf948d32..743679ddb7 100644
--- a/vl.c
+++ b/vl.c
@@ -2603,6 +2603,15 @@ static void qemu_run_exit_notifiers(void)
     notifier_list_notify(&exit_notifiers, NULL);
 }
=20
+static const char *pid_file;
+
+static void qemu_unlink_pidfile(void)
+{
+    if (pid_file) {
+        unlink(pid_file);
+    }
+}
+
 bool machine_init_done;
=20
 void qemu_add_machine_init_done_notifier(Notifier *notify)
@@ -2927,7 +2936,6 @@ int main(int argc, char **argv, char **envp)
     const char *vga_model =3D NULL;
     const char *qtest_chrdev =3D NULL;
     const char *qtest_log =3D NULL;
-    const char *pid_file =3D NULL;
     const char *incoming =3D NULL;
     bool userconfig =3D true;
     bool nographic =3D false;
@@ -4000,6 +4008,7 @@ int main(int argc, char **argv, char **envp)
         error_reportf_err(err, "cannot create PID file: ");
         exit(1);
     }
+    atexit(qemu_unlink_pidfile);
=20
     if (qemu_init_main_loop(&main_loop_err)) {
         error_report_err(main_loop_err);
--=20
2.19.0.rc1
