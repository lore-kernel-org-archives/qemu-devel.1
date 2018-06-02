Received: from eggs.gnu.org ([2001:4830:134:3::10]:56777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fP3sJ-0003Do-JX
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 06:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fP3sG-00074y-GB
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 06:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56204 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fP3sG-00072O-By
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 06:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4781401EF23
	for <qemu-devel@nongnu.org>; Sat,  2 Jun 2018 10:35:02 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Sat,  2 Jun 2018 12:34:52 +0200
Message-Id: <ad910973c593c5ac2fed3a10ea958f7e9c12f82c.1527935663.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH] cli: Don't run early event loop if no
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
Cc: imammedo@redhat.com, ehabkost@redhat.com, eblake@redhat.com, pbonzini@redhat.com

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

The solution is to not call main_loop() unless --preconfig was
specified (in which case caller knows they must connect to the
socket before exec() finishes).

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 vl.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 70f090c823..cde2934c40 100644
--- a/vl.c
+++ b/vl.c
@@ -4469,8 +4469,13 @@ int main(int argc, char **argv, char **envp)
     }
     parse_numa_opts(current_machine);
 
-    /* do monitor/qmp handling at preconfig state if requested */
-    main_loop();
+    if (preconfig_exit_requested) {
+        runstate_set(RUN_STATE_PRELAUNCH);
+        preconfig_exit_requested = false;
+    } else {
+        /* do monitor/qmp handling at preconfig state if requested */
+        main_loop();
+    }
 
     /* from here on runstate is RUN_STATE_PRELAUNCH */
     machine_run_board_init(current_machine);
-- 
2.16.4
