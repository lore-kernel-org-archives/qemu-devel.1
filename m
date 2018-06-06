Received: from eggs.gnu.org ([2001:4830:134:3::10]:52408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQTwz-0005jj-NH
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:37:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQTwu-0007Rw-Pt
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:37:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42608 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQTwu-0007Rj-I4
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 04:37:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6DD8C12BA
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 08:37:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  6 Jun 2018 10:37:05 +0200
Message-Id: <1528274225-90644-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20180605183001.GO7451@localhost.localdomain>
References: <20180605183001.GO7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/2] vl: fix use of --daemonize with
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
Cc: berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, ldoktor@redhat.com, eblake@redhat.com

When using --daemonize, the initial lead process will fork a child and
then wait to be notified that setup is complete via a pipe, before it
exits.  When using --preconfig there is an extra call to main_loop()
before the notification is done from os_setup_post(). Thus the parent
process won't exit until the mgmt application connects to the monitor
and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
won't connect to the monitor until daemonizing has completed though.

This is a chicken and egg problem, leading to deadlock at startup.

The only viable way to fix this is to call os_setup_post() before
the early main_loop() call when --preconfig is used. This has the
downside that any errors from this point onwards won't be handled
well by the mgmt application, because it will think QEMU has started
successfully, so not be expecting an abrupt exit. Moving as much user
input validation as possible to before the main_loop() call might help,
but mgmt application should stop assuming that QEMU has started
successfuly and use other means to collect errors from QEMU (logfile).

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v5:
  * use original Daniel's patch [1], but addapt it to apply on top of
    "[PATCH v3 1/2] cli: Don't run early event loop if no  --preconfig wa=
s specified"
    with extra comment and massage commit message a little bit.

CC: berrange@redhat.com
CC: mreitz@redhat.com
CC: pbonzini@redhat.com
CC: ehabkost@redhat.com
CC: ldoktor@redhat.com
CC: eblake@redhat.com

---
 vl.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index fa44138..ee359e6 100644
--- a/vl.c
+++ b/vl.c
@@ -3038,6 +3038,7 @@ int main(int argc, char **argv, char **envp)
     Error *err =3D NULL;
     bool list_data_dirs =3D false;
     char *dir, **dirs;
+    bool os_setup_post_done =3D false;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -4578,6 +4579,13 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     /* do monitor/qmp handling at preconfig state if requested */
+    if (!preconfig_exit_requested && is_daemonized()) {
+        /* signal parent QEMU to exit, libvirt treats it as a sign
+         * that monitor socket is ready to accept connections
+         */
+        os_setup_post();
+        os_setup_post_done =3D true;
+    }
     main_loop();
=20
     /* from here on runstate is RUN_STATE_PRELAUNCH */
@@ -4707,8 +4715,10 @@ int main(int argc, char **argv, char **envp)
     }
=20
     accel_setup_post(current_machine);
-    os_setup_post();
=20
+    if (!os_setup_post_done) {
+        os_setup_post();
+    }
     main_loop();
=20
     gdbserver_cleanup();
--=20
2.7.4
