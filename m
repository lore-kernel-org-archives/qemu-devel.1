Received: from eggs.gnu.org ([2001:4830:134:3::10]:38599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822Y-0004WY-02
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822T-0005wN-DV
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:33 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:55945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1g822T-0005SM-21
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:29 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Thu,  4 Oct 2018 13:43:10 +0200
Message-Id: <20181004114312.27346-2-d.csapak@proxmox.com>
In-Reply-To: <20181004114312.27346-1-d.csapak@proxmox.com>
References: <20181004114312.27346-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH v2 1/3] osdep: add qemu_launch_script for
 executing scripts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sw@weilnetz.de, jasowang@redhat.com, thuth@redhat.com, philmd@redhat.com

this adds a small function for launching an external script
via fork/exec (not available for windows) and is intended
for replacing 'launch_script' in net/tap.c and to provide a general
way to launch scripts

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
---
i modeled the windows error after the qemu_fork implementation,
since it does not exist for the same reason

changes since v1:
* new in v2

 include/qemu/osdep.h | 12 ++++++++++++
 util/oslib-posix.c   | 34 ++++++++++++++++++++++++++++++++++
 util/oslib-win32.c   |  8 ++++++++
 3 files changed, 54 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 4f8559e550..26c1f01d55 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -564,6 +564,18 @@ char *qemu_get_pid_name(pid_t pid);
  */
 pid_t qemu_fork(Error **errp);
 
+/**
+ * qemu_launch_script:
+ * @script: the path to the script
+ * @args: the arguments for the script
+ * @fd: a file descriptor that should not be closed
+ *
+ * fork and exec a script with the given arguments
+ * closes all file descriptors > 2 except the one given with fd
+ */
+void qemu_launch_script(const char *script, char *const args[], int fd,
+                        Error **errp);
+
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
  */
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index fbd0dc8c57..123b142591 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -698,3 +698,37 @@ void sigaction_invoke(struct sigaction *action,
     }
     action->sa_sigaction(info->ssi_signo, &si, NULL);
 }
+
+void qemu_launch_script(const char *script, char *const args[], int fd,
+                        Error **errp)
+{
+    int pid, status;
+
+    pid = fork();
+    if (pid < 0) {
+        error_setg_errno(errp, errno, "could not launch script %s",
+                         script);
+        return;
+    }
+    if (pid == 0) {
+        int open_max = sysconf(_SC_OPEN_MAX), i;
+
+        for (i = 3; i < open_max; i++) {
+            if (i != fd) {
+                close(i);
+            }
+        }
+        execv(script, args);
+        _exit(1);
+    } else {
+        while (waitpid(pid, &status, 0) != pid) {
+            /* loop */
+        }
+
+        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
+            return;
+        }
+        error_setg(errp, "script %s failed with status %d",
+                   script, status);
+    }
+}
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index b4c17f5dfa..5e14c89dc7 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -803,3 +803,11 @@ bool qemu_write_pidfile(const char *filename, Error **errp)
     }
     return true;
 }
+
+void qemu_launch_script(const char *script, char *const args[], int fd,
+                        Error **errp)
+{
+    errno = ENOSYS;
+    error_setg_errno(errp, errno,
+                     "cannot fork child process");
+}
-- 
2.11.0
