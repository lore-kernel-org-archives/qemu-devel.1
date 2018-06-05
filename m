Received: from eggs.gnu.org ([2001:4830:134:3::10]:36170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCWf-0000d0-QO
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fQCWb-0002SR-9g
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fQCWb-0002S9-4n
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:01:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A13444023834
	for <qemu-devel@nongnu.org>; Tue,  5 Jun 2018 14:01:24 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Tue,  5 Jun 2018 16:00:42 +0200
Message-Id: <1528207243-268226-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
References: <1528207243-268226-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/2] cli: Don't run early event loop if no
 --preconfig was specified
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

After 047f7038f586d215 it is possible for event loop to run two
times. First time whilst parsing command line options (the idea
is to bring up monitor early so that management applications can
tweak config before machine is initialized). And the second time
is after everything is set up (this is the usual place). In both
cases the event loop is called as main_loop_wait(nonblocking =
false) which causes the event loop to block until at least one
event occurred.

Now, consider that somebody (i.e. libvirt) calls us with
-daemonize. This operation is split in two steps. The main()
calls os_daemonize() which fork()-s and then waits in read()
until child notifies it via write():

/qemu.git $ ./x86_64-softmmu/qemu-system-x86_64 -S -daemonize \
  -no-user-config -nodefaults -nographic

  main():                child:
    os_daemonize():
      read(pipe[0])

                           main_loop():
                             main_loop_wait(false)

                           os_setup_post():
                             write(pipe[1])

                           main_loop():
                             main_loop_wait(false)

Here it can be clearly seen that main() does not exit until an
event occurs, but at the same time nobody will touch the monitor
socket until their exec("qemu-system-*") finishes. So the whole
thing deadlocks.

The solution is to not call main_loop_wait() unless --preconfig was
specified (in which case caller knows they must connect to the
socket before exec() finishes).

Patch also fixes hang when -nodefaults option is used, which were
causing QEMU hang in the early main_loop_wait() indefinitely by
the same means (not calling main_loop_wait() unless --preconfig
is present on CLI)

Based on
  From: Michal Privoznik <mprivozn@redhat.com>
  Subject: [PATCH] cli: Don't run early event loop if no --preconfig was specified
  Message-Id: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  - fix iotests that involve migration,
    rewrite v1 so it would take into account -incoming use case
---
 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index c4fe255..fa44138 100644
--- a/vl.c
+++ b/vl.c
@@ -1956,7 +1956,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
-    do {
+    while (!main_loop_should_exit()) {
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
 #endif
@@ -1964,7 +1964,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
         dev_time += profile_getclock() - ti;
 #endif
-    } while (!main_loop_should_exit());
+    }
 }
 
 static void version(void)
-- 
2.7.4
