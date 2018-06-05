Received: from eggs.gnu.org ([2001:4830:134:3::10]:36208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCWl-0000hv-0M
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCWf-0002VK-3c
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46972 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQCWe-0002Uk-V8
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7809C818BAEE
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 14:01:28 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  5 Jun 2018 16:00:43 +0200
Message-Id: <1528207243-268226-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/2] vl: fix use of --daemonize with
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
Cc: berrange@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, ldoktor@redhat.com

When using --daemonize, the initial lead process will fork a child and
then wait to be notified that setup is complete via a pipe, before it
exits.  When using --preconfig there is an extra call to main_loop()
before the notification is done from os_setup_post(). Thus the parent
process won't exit until the mgmt application connects to the monitor
and tells QEMU to leave the RUN_STATE_PRECONFIG. The mgmt application
won't connect to the monitor until daemonizing has completed though.

This is a chicken and egg problem, leading to deadlock at startup.

The only viable way to fix this is to call os_setup_post() before
the early main_loop_wait() call when in RUN_STATE_PRECONFIG. This has
the downside that any errors from this point onwards won't be handled
well by the mgmt application, because it will think QEMU has started
successfully, so not be expecting an abrupt exit. The only way to
deal with that is to move as much user input validation as possible
to before the main_loop() call. This is left as an exercise for
future interested developers.

Based on:
  From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  Subject: [PATCH v2 2/2] vl: fix use of --daemonize with --preconfig
  Message-Id: <20180604120345.12955-3-berrange@redhat.com>

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  - rewrite to apply on top of 1/2
---
 os-posix.c | 6 ++++++
 vl.c       | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/os-posix.c b/os-posix.c
index 9ce6f74..ee06a8d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -309,8 +309,14 @@ void os_daemonize(void)
=20
 void os_setup_post(void)
 {
+    static bool os_setup_post_done =3D false;
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
index fa44138..d6fa67f 100644
--- a/vl.c
+++ b/vl.c
@@ -1960,6 +1960,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
         ti =3D profile_getclock();
 #endif
+        os_setup_post();
         main_loop_wait(false);
 #ifdef CONFIG_PROFILER
         dev_time +=3D profile_getclock() - ti;
@@ -4707,7 +4708,6 @@ int main(int argc, char **argv, char **envp)
     }
=20
     accel_setup_post(current_machine);
-    os_setup_post();
=20
     main_loop();
=20
--=20
2.7.4
