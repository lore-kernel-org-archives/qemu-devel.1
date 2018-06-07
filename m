Received: from eggs.gnu.org ([2001:4830:134:3::10]:36745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQtb2-0005AQ-3w
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQtaz-00078m-1d
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:00:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39688 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQtay-00078S-SD
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:00:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4EA7BBB422
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 12:00:48 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu,  7 Jun 2018 14:00:09 +0200
Message-Id: <1528372809-175770-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <20180606135051.GR7451@localhost.localdomain>
References: <20180606135051.GR7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 2/2] vl: fix use of --daemonize with
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
v6:
  * hide os_setup_post_done flag inside of os_setup_post() as it was in v=
4

CC: berrange@redhat.com
CC: mreitz@redhat.com
CC: pbonzini@redhat.com
CC: ehabkost@redhat.com
CC: ldoktor@redhat.com
CC: eblake@redhat.com
---
 os-posix.c | 6 ++++++
 vl.c       | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/os-posix.c b/os-posix.c
index 9ce6f74..0246195 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -309,8 +309,14 @@ void os_daemonize(void)
=20
 void os_setup_post(void)
 {
+    static bool os_setup_post_done;
     int fd =3D 0;
=20
+    if (os_setup_post_done) {
+        return;
+    }
+    os_setup_post_done =3D true;
+
     if (daemonize) {
         if (chdir("/")) {
             error_report("not able to chdir to /: %s", strerror(errno));
diff --git a/vl.c b/vl.c
index fa44138..457ff2a 100644
--- a/vl.c
+++ b/vl.c
@@ -4578,6 +4578,12 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     /* do monitor/qmp handling at preconfig state if requested */
+    if (!preconfig_exit_requested && is_daemonized()) {
+        /* signal parent QEMU to exit, libvirt treats it as a sign
+         * that monitor socket is ready to accept connections
+         */
+        os_setup_post();
+    }
     main_loop();
=20
     /* from here on runstate is RUN_STATE_PRELAUNCH */
--=20
2.7.4
