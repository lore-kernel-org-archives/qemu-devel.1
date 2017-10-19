Received: from eggs.gnu.org ([2001:4830:134:3::10]:52089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4583d85cc=ross.lagerwall@citrix.com>)
	id 1e5DK6-0001Ft-4Z
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:05:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4583d85cc=ross.lagerwall@citrix.com>)
	id 1e5DJz-0001Y3-Jh
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:05:30 -0400
Received: from smtp.citrix.com ([66.165.176.89]:33476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4583d85cc=ross.lagerwall@citrix.com>)
	id 1e5DJz-0001WX-9y
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:05:23 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Thu, 19 Oct 2017 17:04:19 +0100
Message-ID: <20171019160419.11611-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1] os-posix: Add -unshare option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>

Add an option to allow calling unshare() just before starting guest
execution. The option allows unsharing one or more of the mount
namespace, the network namespace, and the IPC namespace. This is useful
to restrict the ability of QEMU to cause damage to the system should it
be compromised.

An example of using this would be to have QEMU open a QMP socket at
startup and unshare the network namespace. The instance of QEMU could
still be controlled by the QMP socket since that belongs in the original
namespace, but if QEMU were compromised it wouldn't be able to open any
new connections, even to other processes on the same machine.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 os-posix.c      | 34 ++++++++++++++++++++++++++++++++++
 qemu-options.hx | 14 ++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/os-posix.c b/os-posix.c
index b9c2343..cfc5c38 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -45,6 +45,7 @@ static struct passwd *user_pwd;
 static const char *chroot_dir;
 static int daemonize;
 static int daemon_pipe;
+static int unshare_flags;
 
 void os_setup_early_signal_handling(void)
 {
@@ -160,6 +161,28 @@ void os_parse_cmd_args(int index, const char *optarg)
         fips_set_state(true);
         break;
 #endif
+#ifdef CONFIG_SETNS
+    case QEMU_OPTION_unshare:
+        {
+            char *flag;
+            char *opts = g_strdup(optarg);
+
+            while ((flag = qemu_strsep(&opts, ",")) != NULL) {
+                if (!strcmp(flag, "mount")) {
+                    unshare_flags |= CLONE_NEWNS;
+                } else if (!strcmp(flag, "net")) {
+                    unshare_flags |= CLONE_NEWNET;
+                } else if (!strcmp(flag, "ipc")) {
+                    unshare_flags |= CLONE_NEWIPC;
+                } else {
+                    fprintf(stderr, "Unknown unshare option: %s\n", flag);
+                    exit(1);
+                }
+            }
+            g_free(opts);
+        }
+        break;
+#endif
     }
 }
 
@@ -201,6 +224,16 @@ static void change_root(void)
 
 }
 
+static void unshare_namespaces(void)
+{
+    if (unshare_flags) {
+        if (unshare(unshare_flags) < 0) {
+            perror("could not unshare");
+            exit(1);
+        }
+    }
+}
+
 void os_daemonize(void)
 {
     if (daemonize) {
@@ -266,6 +299,7 @@ void os_setup_post(void)
     }
 
     change_root();
+    unshare_namespaces();
     change_process_uid();
 
     if (daemonize) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 3728e9b..5cfcc51 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3972,6 +3972,20 @@ Immediately before starting guest execution, chroot to the specified
 directory.  Especially useful in combination with -runas.
 ETEXI
 
+#ifdef CONFIG_SETNS
+DEF("unshare", HAS_ARG, QEMU_OPTION_unshare, \
+    "-unshare [mount][,net][,ipc]\n" \
+    "                unshare namespaces just before starting the VM\n",
+    QEMU_ARCH_ALL)
+#endif
+STEXI
+@item -unshare @code{[mount][,net][,ipc]}
+@findex -unshare
+Immediately before starting guest execution, unshare the specified namespaces.
+The namespaces that can be unshared are the mount namespace, the network
+namespace and the IPC namespace.
+ETEXI
+
 #ifndef _WIN32
 DEF("runas", HAS_ARG, QEMU_OPTION_runas, \
     "-runas user     change to user id user just before starting the VM\n",
-- 
2.9.5
