Received: from eggs.gnu.org ([2001:4830:134:3::10]:58833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQiX-0004jB-MF
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSQiW-0005Pu-Mf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSQiW-0005Pc-Ed
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:34:56 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 11 Jun 2018 14:34:52 -0300
Message-Id: <20180611173452.28087-2-ehabkost@redhat.com>
In-Reply-To: <20180611173452.28087-1-ehabkost@redhat.com>
References: <20180611173452.28087-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] cli: Don't run early event loop if no
 --preconfig was specified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

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
Fixes: 047f7038f586d215
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <1528207243-268226-2-git-send-email-imammedo@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 06031715ac..6e34fb348d 100644
--- a/vl.c
+++ b/vl.c
@@ -1841,7 +1841,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
     int64_t ti;
 #endif
-    do {
+    while (!main_loop_should_exit()) {
 #ifdef CONFIG_PROFILER
         ti = profile_getclock();
 #endif
@@ -1849,7 +1849,7 @@ static void main_loop(void)
 #ifdef CONFIG_PROFILER
         dev_time += profile_getclock() - ti;
 #endif
-    } while (!main_loop_should_exit());
+    }
 }
 
 static void version(void)
-- 
2.18.0.rc1.1.g3f1ff2140
