Received: from eggs.gnu.org ([2001:4830:134:3::10]:46282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPoDK-0004Y2-C6
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:03:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPoDJ-0001IB-HD
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:03:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPoDJ-0001Ha-Cg
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2A53BB40A
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 12:03:52 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  4 Jun 2018 13:03:45 +0100
Message-Id: <20180604120345.12955-3-berrange@redhat.com>
In-Reply-To: <20180604120345.12955-1-berrange@redhat.com>
References: <20180604120345.12955-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/2] vl: fix use of --daemonize with
 --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When using --daemonize, the initial lead process will fork a child and
then wait to be notified that setup is complete via a pipe, before it
exits.  When using --preconfig there is an extra call to main_loop()
before the notification is done from os_setup_post(). Thus the parent
process won't exit until the mgmt application connects to the monitor
and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
won't connect to the monitor until daemonizing has completed though.

This is a chicken and egg problem, leading to deadlock at startup.

The only viable way to fix this is to call os_setup_post() before
the early main_loop() call when in RUN_STATE_PRECONFIG. This has the
downside that any errors from this point onwards won't be handled
well by the mgmt application, because it will think QEMU has started
successfully, so not be expecting an abrupt exit. The only way to
deal with that is to move as much user input validation as possible
to before the main_loop() call. This is left as an exercise for
future interested developers.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 vl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 30d0e985f0..f4bba36d19 100644
--- a/vl.c
+++ b/vl.c
@@ -2921,6 +2921,7 @@ int main(int argc, char **argv, char **envp)
     Error *err =3D NULL;
     bool list_data_dirs =3D false;
     char *dir, **dirs;
+    bool os_setup_post_done =3D false;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -4476,6 +4477,8 @@ int main(int argc, char **argv, char **envp)
=20
     /* do monitor/qmp handling at preconfig state if requested */
     if (runstate_check(RUN_STATE_PRECONFIG)) {
+        os_setup_post();
+        os_setup_post_done =3D true;
         main_loop();
     }
=20
@@ -4606,7 +4609,9 @@ int main(int argc, char **argv, char **envp)
     }
=20
     accel_setup_post(current_machine);
-    os_setup_post();
+    if (!os_setup_post_done) {
+        os_setup_post();
+    }
=20
     main_loop();
=20
--=20
2.17.0
