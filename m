Received: from eggs.gnu.org ([2001:4830:134:3::10]:47130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ews8l-00036J-1J
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1ews8h-0007b8-QA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:23:35 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:50209
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1ews8h-0007Yc-Jb
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:23:31 -0400
From: KONRAD Frederic <frederic.konrad@adacore.com>
Date: Fri, 16 Mar 2018 17:23:13 +0100
Message-Id: <1521217393-8162-1-git-send-email-frederic.konrad@adacore.com>
Subject: [Qemu-devel] [PATCH] gdbstub: send a terminaison packet instead of
 crashing gdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, famz@redhat.com, frederic.konrad@adacore.com

Since the commit:
commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Wed Mar 7 14:42:05 2018 +0000

    vl: introduce vm_shutdown()

GDB crash when qemu exits (at least on sparc-softmmu):
Remote communication error.  Target disconnected.: Connection reset by peer.
Quitting: putpkt: write failed: Broken pipe.

So send a packet to kill GDB before we exit QEMU:
[Inferior 1 (Thread 0) exited normally]

Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 gdbstub.c              | 7 +++++++
 include/exec/gdbstub.h | 2 ++
 vl.c                   | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/gdbstub.c b/gdbstub.c
index f1d5148..a76b2fa 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2052,6 +2052,13 @@ int gdbserver_start(const char *device)
     return 0;
 }
 
+void gdbserver_cleanup(void)
+{
+    if (gdbserver_state) {
+        put_packet(gdbserver_state, "W00");
+    }
+}
+
 static void register_types(void)
 {
     type_register_static(&char_gdb_type_info);
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 9aa7756..2e8a4b8 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -103,6 +103,8 @@ int gdbserver_start(int);
 int gdbserver_start(const char *port);
 #endif
 
+void gdbserver_cleanup(void);
+
 /**
  * gdb_has_xml:
  * This is an ugly hack to cope with both new and old gdb.
diff --git a/vl.c b/vl.c
index 3ef04ce..0427b15 100644
--- a/vl.c
+++ b/vl.c
@@ -4723,6 +4723,8 @@ int main(int argc, char **argv, char **envp)
 
     main_loop();
 
+    gdbserver_cleanup();
+
     /* No more vcpu or device emulation activity beyond this point */
     vm_shutdown();
 
-- 
1.8.3.1
