Received: from eggs.gnu.org ([2001:4830:134:3::10]:41439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EK-0000rs-Pp
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1et5EH-0006hC-Nj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1et5EH-0006gn-JD
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 00:33:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 470B64023B98
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 05:33:36 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue,  6 Mar 2018 13:33:12 +0800
Message-Id: <20180306053320.15401-2-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-1-peterx@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/9] vl: export machine_init_done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

We have that variable but not exported.  Export that so modules can have
a way to poke on whether machine init has finished.

Meanwhile, set that up even before calling the notifiers, so that
notifiers who may depend on this field will get a correct answer.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/sysemu.h   | 2 ++
 stubs/machine-init-done.c | 2 ++
 vl.c                      | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 77bb3da582..3f0f35610b 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -86,6 +86,8 @@ void qemu_system_guest_panicked(GuestPanicInformation *=
info);
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
=20
+extern bool machine_init_done;
+
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
=20
diff --git a/stubs/machine-init-done.c b/stubs/machine-init-done.c
index 9a0d62514f..4121f1709b 100644
--- a/stubs/machine-init-done.c
+++ b/stubs/machine-init-done.c
@@ -2,6 +2,8 @@
 #include "qemu-common.h"
 #include "sysemu/sysemu.h"
=20
+bool machine_init_done =3D true;
+
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
 }
diff --git a/vl.c b/vl.c
index a33ac008fb..57777e8d47 100644
--- a/vl.c
+++ b/vl.c
@@ -2712,7 +2712,7 @@ static void qemu_run_exit_notifiers(void)
     notifier_list_notify(&exit_notifiers, NULL);
 }
=20
-static bool machine_init_done;
+bool machine_init_done;
=20
 void qemu_add_machine_init_done_notifier(Notifier *notify)
 {
@@ -2729,8 +2729,8 @@ void qemu_remove_machine_init_done_notifier(Notifie=
r *notify)
=20
 static void qemu_run_machine_init_done_notifiers(void)
 {
-    notifier_list_notify(&machine_init_done_notifiers, NULL);
     machine_init_done =3D true;
+    notifier_list_notify(&machine_init_done_notifiers, NULL);
 }
=20
 static const QEMUOption *lookup_opt(int argc, char **argv,
--=20
2.14.3
