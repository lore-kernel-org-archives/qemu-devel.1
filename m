Received: from eggs.gnu.org ([2001:4830:134:3::10]:53109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmR-0004d2-Qk
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmQ-0001n0-Qf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:26:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:25:57 +0200
Message-Id: <20180611142611.6609-16-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 15/29] qemu-io: Exit with error when a command
 failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Currently, qemu-io basically always returns success when it gets to
interactive mode (so once the whole command line has been parsed; even
before the commands on the command line are interpreted).  That is not
very useful.

This patch makes qemu-io return failure when any of the executed
commands failed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1519617
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20180509194302.21585-4-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-io.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index ec6683803f..13829f5e21 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -400,17 +400,21 @@ static void prep_fetchline(void *opaque)
     *fetchable= 1;
 }
 
-static void command_loop(void)
+static int command_loop(void)
 {
     int i, fetchable = 0, prompted = 0;
+    int ret, last_error = 0;
     char *input;
 
     for (i = 0; !quit_qemu_io && i < ncmdline; i++) {
-        qemuio_command(qemuio_blk, cmdline[i]);
+        ret = qemuio_command(qemuio_blk, cmdline[i]);
+        if (ret < 0) {
+            last_error = ret;
+        }
     }
     if (cmdline) {
         g_free(cmdline);
-        return;
+        return last_error;
     }
 
     while (!quit_qemu_io) {
@@ -431,13 +435,19 @@ static void command_loop(void)
         if (input == NULL) {
             break;
         }
-        qemuio_command(qemuio_blk, input);
+        ret = qemuio_command(qemuio_blk, input);
         g_free(input);
 
+        if (ret < 0) {
+            last_error = ret;
+        }
+
         prompted = 0;
         fetchable = 0;
     }
     qemu_set_fd_handler(STDIN_FILENO, NULL, NULL, NULL);
+
+    return last_error;
 }
 
 static void add_user_command(char *optarg)
@@ -502,6 +512,7 @@ int main(int argc, char **argv)
     int c;
     int opt_index = 0;
     int flags = BDRV_O_UNMAP;
+    int ret;
     bool writethrough = true;
     Error *local_error = NULL;
     QDict *opts = NULL;
@@ -663,7 +674,7 @@ int main(int argc, char **argv)
             }
         }
     }
-    command_loop();
+    ret = command_loop();
 
     /*
      * Make sure all outstanding requests complete before the program exits.
@@ -672,5 +683,10 @@ int main(int argc, char **argv)
 
     blk_unref(qemuio_blk);
     g_free(readline_state);
-    return 0;
+
+    if (ret < 0) {
+        return 1;
+    } else {
+        return 0;
+    }
 }
-- 
2.17.1
