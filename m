Received: from eggs.gnu.org ([2001:4830:134:3::10]:37905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cF800-0002mB-LT
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 18:21:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cF7zx-000361-FH
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 18:21:12 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:58085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cF7zx-00034L-4J
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 18:21:09 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  9 Dec 2016 00:21:00 +0100
Message-Id: <1481239260-21595-1-git-send-email-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH risu] A script to run concurrently the master
 and the apprentice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

This expect script will generate the .out file and then
start the apprentice in a chroot and the master on the reference
hardware. The list of patterns is given on the command line.

As my reference system is very slow, ssh can take more than 2 minutes,
this script starts a ssh and a chroot once, and interacts with
them to run the list of instruction patterns given on the command line.

Some environment variables define the test environment:
- RISU_ARCH: the pattern file used will be $RISU_ARCH.risu
- RISU_MASTER: the IP address or name of the reference hardware (for ssh)
- RISU_CHROOT: the path of the QEMU chroot to start the apprentice
- RISU_PATH: the path, common to master and apprentice (you can use NFS),
             where the risu files are stored (binaries and data).

Example:

$ RISU_ARCH=m68k RISU_MASTER=q800 \
  RISU_CHROOT=/var/lib/lxc/virtm68k-etch-m68k/rootfs \
  RISU_PATH=/nfs/home/laurent/q800/risu \
  ./automatic-run ASx ADD AND OR EOR

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 automatic-run | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100755 automatic-run

diff --git a/automatic-run b/automatic-run
new file mode 100755
index 0000000..3517f37
--- /dev/null
+++ b/automatic-run
@@ -0,0 +1,84 @@
+#!/usr/bin/expect -f
+#
+# This script generates the risugen output for a given
+# list of instructions
+# Then it runs concurrently the master and the apprentice:
+# - the master is started on remote host provided by the
+#   environment variable RISU_MASTER
+# - the apprentice is started in a chroot provided by the
+#   environment variable RISU_CHROOT
+# Master and apprentice must share a directory, the path
+# of this directory is given by RISU_PATH. The risu files
+# will be searched in this directory.
+# The RISU_ARCH gives the name of the risu patterns file
+# to use.
+#
+# Example:
+#
+#    RISU_ARCH=m68k RISU_MASTER=192.168.100.3 \
+#    RISU_CHROOT=/chroot/m68k \
+#    RISU_PATH=/nfs/risu ./automatic-run ASx ADD AND
+#
+set arch $env(RISU_ARCH)
+set master $env(RISU_MASTER)
+set chroot $env(RISU_CHROOT)
+set risupath $env(RISU_PATH)
+set numinsns 10000
+
+set prompt "(%|#|\\$) $"
+
+set timeout 1
+spawn sudo -S chroot $chroot
+expect {
+    -re ":" {
+        set timeout 300
+        stty -echo
+        expect_user -re "(.*)\n"
+        send "$expect_out(1,string)\r"
+        stty echo
+        expect -r $prompt
+    }
+}
+send "ls $risupath > /dev/null; echo RESULT:$?\n"
+expect {
+   "RESULT:2" { exit 1 }
+   -re $prompt
+}
+
+set timeout 1
+set retry 0
+expect {
+    timeout { if { $retry == 5 } { exit 2}
+              incr retry 1
+              send "\r"
+              exp_continue;
+            }
+    -re $prompt
+}
+
+set chroot_id $spawn_id
+spawn ssh $master
+
+set timeout 600
+expect {
+    timeout { send "\r"; exp_continue; }
+    -re $prompt
+}
+
+for { set arg 0 } { $arg < $argc } { incr arg 1 } {
+    set insn  [lindex $argv $arg]
+
+    system $risupath/risugen --numinsns $numinsns --pattern $insn $risupath/$arch.risu $risupath/$insn.out
+
+    send "$risupath/risu --master $risupath/$insn.out\n"
+
+    expect "master: waiting for connection on port 9191..."
+
+    send -i $chroot_id "$risupath/risu --host $master $risupath/$insn.out\n"
+
+    expect {
+        "mismatch!" { exit 3 }
+        "match!";
+    }
+    expect -re $prompt
+}
-- 
2.7.4
