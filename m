Received: from eggs.gnu.org ([2001:4830:134:3::10]:38869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bf-00080k-U1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bd-0007zT-H4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bd-0007yg-6m
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:52 +0200
Message-Id: <20171002152552.27999-33-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 32/32] qapi/options: QAPIfy --add-fd
 argument type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/options.json |  2 +-
 vl.c              | 70 +++++++++++++------------------------------------------
 2 files changed, 17 insertions(+), 55 deletions(-)

diff --git a/qapi/options.json b/qapi/options.json
index d55c6bfa81..c46c3deb10 100644
--- a/qapi/options.json
+++ b/qapi/options.json
@@ -285,7 +285,7 @@
 # !end texinfo
 ##
 { 'option': '--add-fd',
-  'data': 'str',                # FIXME QAPIfy qemu_add_fd_opts
+  'data': { 'fd': 'int', 'set': 'int', '*opaque': 'str' },
   'help': [
 "-add-fd fd=fd,set=set[,opaque=opaque]",
 "                Add 'fd' to fd 'set'"] }
diff --git a/vl.c b/vl.c
index 32f4b5fef3..e769796c11 100644
--- a/vl.c
+++ b/vl.c
@@ -371,27 +371,6 @@ static QemuOptsList qemu_boot_opts = {
     },
 };
 
-static QemuOptsList qemu_add_fd_opts = {
-    .name = "add-fd",
-    .head = QTAILQ_HEAD_INITIALIZER(qemu_add_fd_opts.head),
-    .desc = {
-        {
-            .name = "fd",
-            .type = QEMU_OPT_NUMBER,
-            .help = "file descriptor of which a duplicate is added to fd set",
-        },{
-            .name = "set",
-            .type = QEMU_OPT_NUMBER,
-            .help = "ID of the fd set to add fd to",
-        },{
-            .name = "opaque",
-            .type = QEMU_OPT_STRING,
-            .help = "free-form string used to describe fd",
-        },
-        { /* end of list */ }
-    },
-};
-
 static QemuOptsList qemu_object_opts = {
     .name = "object",
     .implied_opt_name = "qom-type",
@@ -1148,19 +1127,13 @@ bool defaults_enabled(void)
 }
 
 #ifndef _WIN32
-static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
+static int do_add_fd(int fd, int64_t fdset_id, const char *fd_opaque)
 {
-    int fd, dupfd, flags;
-    int64_t fdset_id;
-    const char *fd_opaque = NULL;
+    int dupfd, flags;
     AddfdInfo *fdinfo;
 
-    fd = qemu_opt_get_number(opts, "fd", -1);
-    fdset_id = qemu_opt_get_number(opts, "set", -1);
-    fd_opaque = qemu_opt_get(opts, "opaque");
-
     if (fd < 0) {
-        error_report("fd option is required and must be non-negative");
+        error_report("fd option must be non-negative");
         return -1;
     }
 
@@ -1180,7 +1153,7 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
     }
 
     if (fdset_id < 0) {
-        error_report("set option is required and must be non-negative");
+        error_report("set option must be non-negative");
         return -1;
     }
 
@@ -1204,16 +1177,6 @@ static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
 
     return 0;
 }
-
-static int cleanup_add_fd(void *opaque, QemuOpts *opts, Error **errp)
-{
-    int fd;
-
-    fd = qemu_opt_get_number(opts, "fd", -1);
-    close(fd);
-
-    return 0;
-}
 #endif
 
 /***********************************************************/
@@ -3120,7 +3083,6 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_smp_opts);
     qemu_add_opts(&qemu_boot_opts);
     qemu_add_opts(&qemu_sandbox_opts);
-    qemu_add_opts(&qemu_add_fd_opts);
     qemu_add_opts(&qemu_object_opts);
     qemu_add_opts(&qemu_tpmdev_opts);
     qemu_add_opts(&qemu_realtime_opts);
@@ -4126,11 +4088,7 @@ int main(int argc, char **argv, char **envp)
                 break;
             case QAPI_OPTION_KIND_ADD_FD:
 #ifndef _WIN32
-                opts = qemu_opts_parse_noisily(qemu_find_opts("add-fd"),
-                                               qopt[i].u.add_fd.data, false);
-                if (!opts) {
-                    exit(1);
-                }
+                /* nothing to do */
 #else
                 error_report("File descriptor passing is disabled on this "
                              "platform");
@@ -4219,14 +4177,18 @@ int main(int argc, char **argv, char **envp)
     }
 
 #ifndef _WIN32
-    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          parse_add_fd, NULL, NULL)) {
-        exit(1);
+    for (i = 0; qopt[i].cnt; i++) {
+        if (qopt[i].type == QAPI_OPTION_KIND_ADD_FD) {
+            if (do_add_fd(qopt[i].u.add_fd.fd, qopt[i].u.add_fd.set,
+                          qopt[i].u.add_fd.opaque) < 0) {
+                exit(1);
+            }
+        }
     }
-
-    if (qemu_opts_foreach(qemu_find_opts("add-fd"),
-                          cleanup_add_fd, NULL, NULL)) {
-        exit(1);
+    for (i = 0; qopt[i].cnt; i++) {
+        if (qopt[i].type == QAPI_OPTION_KIND_ADD_FD) {
+            close(qopt[i].u.add_fd.fd);
+        }
     }
 #endif
 
-- 
2.13.6
