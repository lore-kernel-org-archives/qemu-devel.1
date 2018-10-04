Received: from eggs.gnu.org ([2001:4830:134:3::10]:38593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822X-0004WL-O4
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dcsapak@zita.proxmox.com>) id 1g822S-0005ug-Rj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:33 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:4578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dcsapak@zita.proxmox.com>)
	id 1g822Q-0005SN-LO
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:43:27 -0400
From: Dominik Csapak <d.csapak@proxmox.com>
Date: Thu,  4 Oct 2018 13:43:12 +0200
Message-Id: <20181004114312.27346-4-d.csapak@proxmox.com>
In-Reply-To: <20181004114312.27346-1-d.csapak@proxmox.com>
References: <20181004114312.27346-1-d.csapak@proxmox.com>
Subject: [Qemu-devel] [PATCH v2 3/3] vl.c: call optional script when exiting
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

some users might want to call a script when qemu exits, without listening
to a qmp monitor for events when running with --daemonize
this option is only available on non windows systems,
since there is no fork there and no --daemonize option

this can be used for things like external cleanups

Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>
---
changes since v1:
* only for non WIN32
* use qemu_launch_script
* fix error in option description (@var{file} instead of $var{file})

 qemu-options.hx | 20 ++++++++++++++++++++
 vl.c            | 29 +++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index f139459e80..6a67ec76fe 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3421,6 +3421,26 @@ This allows for instance switching to monitor to commit changes to the
 disk image.
 ETEXI
 
+#ifndef _WIN32
+DEF("exit-script", HAS_ARG, QEMU_OPTION_exit_script, \
+    "-exit-script    <file>\n"
+    "                      Execute the script in file on exit.\n"
+    "                      The arguments are:\n"
+    "                       - the shutdown reason,\n"
+    "                       - if it was really a reset (if -no-reboot was set)\n"
+    "                       - the name of the guest",
+    QEMU_ARCH_ALL)
+STEXI
+@item -exit-script @var{file}
+@findex -exit-script
+Execute the script @var{file} on exit.
+The arguments are:
+ - the shutdown reason
+ - if it was really a reset (if -no-reboot was set)
+ - the name of the guest
+ETEXI
+#endif
+
 DEF("loadvm", HAS_ARG, QEMU_OPTION_loadvm, \
     "-loadvm [tag|id]\n" \
     "                start right away with a saved state (loadvm in monitor)\n",
diff --git a/vl.c b/vl.c
index 0388852deb..5adf7c80f7 100644
--- a/vl.c
+++ b/vl.c
@@ -1522,6 +1522,9 @@ void vm_state_notify(int running, RunState state)
     }
 }
 
+static ShutdownCause shutdown_reason;
+static bool shutdown_was_reset;
+
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_signal;
@@ -1681,6 +1684,7 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 void qemu_system_reset_request(ShutdownCause reason)
 {
     if (no_reboot && reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
+        shutdown_was_reset = true;
         shutdown_requested = reason;
     } else {
         reset_requested = reason;
@@ -1811,6 +1815,7 @@ static bool main_loop_should_exit(void)
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
+            shutdown_reason = request;
             return true;
         }
     }
@@ -2908,6 +2913,7 @@ int main(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool list_data_dirs = false;
     char *dir, **dirs;
+    const char *exit_script = NULL;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -3596,6 +3602,11 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_no_shutdown:
                 no_shutdown = 1;
                 break;
+#ifndef _WIN32
+            case QEMU_OPTION_exit_script:
+                exit_script = optarg;
+                break;
+#endif
             case QEMU_OPTION_show_cursor:
                 cursor_hide = 0;
                 break;
@@ -4590,5 +4601,23 @@ int main(int argc, char **argv, char **envp)
     migration_object_finalize();
     /* TODO: unref root container, check all devices are ok */
 
+    if (exit_script) {
+        char *args[5];
+        Error *local_err =  NULL;
+        args[0] = (char *)exit_script;
+        args[1] = g_strdup_printf("%d", shutdown_reason);
+        args[2] = g_strdup_printf("%d", shutdown_was_reset);
+        args[3] = (char *)qemu_get_vm_name();
+        args[4] = NULL;
+
+        qemu_launch_script(exit_script, args, -1, &local_err);
+        g_free(args[1]);
+        g_free(args[2]);
+        if (local_err) {
+            error_report_err(local_err);
+            exit(1);
+        }
+    }
+
     return 0;
 }
-- 
2.11.0
