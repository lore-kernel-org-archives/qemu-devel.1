Received: from eggs.gnu.org ([2001:4830:134:3::10]:34137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlJ-0001VM-C1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlG-0007Lm-2S
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:21 +0100
Message-Id: <20180309161933.8168-45-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 44/56] ssh: Use QAPI BlockdevOptionsSsh object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Create a BlockdevOptionsSsh object in connect_to_ssh() and take the
options from there. 'host_key_check' is still processed separately
because it's not in the schema yet.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/ssh.c | 137 +++++++++++++++++++++++++++---------------------------------
 1 file changed, 62 insertions(+), 75 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index ff9929497d..8b646c0ede 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -35,6 +35,7 @@
 #include "qemu/sockets.h"
 #include "qemu/uri.h"
 #include "qapi/qapi-visit-sockets.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qobject-input-visitor.h"
@@ -543,21 +544,6 @@ static QemuOptsList ssh_runtime_opts = {
             .type = QEMU_OPT_NUMBER,
             .help = "Port to connect to",
         },
-        {
-            .name = "path",
-            .type = QEMU_OPT_STRING,
-            .help = "Path of the image on the host",
-        },
-        {
-            .name = "user",
-            .type = QEMU_OPT_STRING,
-            .help = "User as which to connect",
-        },
-        {
-            .name = "host_key_check",
-            .type = QEMU_OPT_STRING,
-            .help = "Defines how and what to check the host key against",
-        },
         { /* end of list */ }
     },
 };
@@ -582,23 +568,31 @@ static bool ssh_process_legacy_socket_options(QDict *output_opts,
     return true;
 }
 
-static InetSocketAddress *ssh_config(QDict *options, Error **errp)
+static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
 {
-    InetSocketAddress *inet = NULL;
-    QDict *addr = NULL;
-    QObject *crumpled_addr = NULL;
-    Visitor *iv = NULL;
-    Error *local_error = NULL;
-
-    qdict_extract_subqdict(options, &addr, "server.");
-    if (!qdict_size(addr)) {
-        error_setg(errp, "SSH server address missing");
-        goto out;
+    BlockdevOptionsSsh *result = NULL;
+    QemuOpts *opts = NULL;
+    Error *local_err = NULL;
+    QObject *crumpled;
+    const QDictEntry *e;
+    Visitor *v;
+
+    /* Translate legacy options */
+    opts = qemu_opts_create(&ssh_runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
     }
 
-    crumpled_addr = qdict_crumple(addr, errp);
-    if (!crumpled_addr) {
-        goto out;
+    if (!ssh_process_legacy_socket_options(options, opts, errp)) {
+        goto fail;
+    }
+
+    /* Create the QAPI object */
+    crumpled = qdict_crumple(options, errp);
+    if (crumpled == NULL) {
+        goto fail;
     }
 
     /*
@@ -609,51 +603,50 @@ static InetSocketAddress *ssh_config(QDict *options, Error **errp)
      * but when they come from -drive, they're all QString.  The
      * visitor expects the former.
      */
-    iv = qobject_input_visitor_new(crumpled_addr);
-    visit_type_InetSocketAddress(iv, NULL, &inet, &local_error);
-    if (local_error) {
-        error_propagate(errp, local_error);
-        goto out;
+    v = qobject_input_visitor_new(crumpled);
+    visit_type_BlockdevOptionsSsh(v, NULL, &result, &local_err);
+    visit_free(v);
+    qobject_decref(crumpled);
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto fail;
     }
 
-out:
-    QDECREF(addr);
-    qobject_decref(crumpled_addr);
-    visit_free(iv);
-    return inet;
+    /* Remove the processed options from the QDict (the visitor processes
+     * _all_ options in the QDict) */
+    while ((e = qdict_first(options))) {
+        qdict_del(options, e->key);
+    }
+
+fail:
+    qemu_opts_del(opts);
+    return result;
 }
 
 static int connect_to_ssh(BDRVSSHState *s, QDict *options,
                           int ssh_flags, int creat_mode, Error **errp)
 {
+    BlockdevOptionsSsh *opts;
     int r, ret;
-    QemuOpts *opts = NULL;
-    Error *local_err = NULL;
-    const char *user, *path, *host_key_check;
+    const char *user, *host_key_check;
     long port = 0;
 
-    opts = qemu_opts_create(&ssh_runtime_opts, NULL, 0, &error_abort);
-    qemu_opts_absorb_qdict(opts, options, &local_err);
-    if (local_err) {
-        ret = -EINVAL;
-        error_propagate(errp, local_err);
-        goto err;
-    }
-
-    if (!ssh_process_legacy_socket_options(options, opts, errp)) {
-        ret = -EINVAL;
-        goto err;
+    host_key_check = qdict_get_try_str(options, "host_key_check");
+    if (!host_key_check) {
+        host_key_check = "yes";
+    } else {
+        qdict_del(options, "host_key_check");
     }
 
-    path = qemu_opt_get(opts, "path");
-    if (!path) {
-        ret = -EINVAL;
-        error_setg(errp, "No path was specified");
-        goto err;
+    opts = ssh_parse_options(options, errp);
+    if (opts == NULL) {
+        return -EINVAL;
     }
 
-    user = qemu_opt_get(opts, "user");
-    if (!user) {
+    if (opts->has_user) {
+        user = opts->user;
+    } else {
         user = g_get_user_name();
         if (!user) {
             error_setg_errno(errp, errno, "Can't get user name");
@@ -662,17 +655,9 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
         }
     }
 
-    host_key_check = qemu_opt_get(opts, "host_key_check");
-    if (!host_key_check) {
-        host_key_check = "yes";
-    }
-
     /* Pop the config into our state object, Exit if invalid */
-    s->inet = ssh_config(options, errp);
-    if (!s->inet) {
-        ret = -EINVAL;
-        goto err;
-    }
+    s->inet = opts->server;
+    opts->server = NULL;
 
     if (qemu_strtol(s->inet->port, NULL, 10, &port) < 0) {
         error_setg(errp, "Use only numeric port value");
@@ -729,15 +714,17 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
 
     /* Open the remote file. */
     DPRINTF("opening file %s flags=0x%x creat_mode=0%o",
-            path, ssh_flags, creat_mode);
-    s->sftp_handle = libssh2_sftp_open(s->sftp, path, ssh_flags, creat_mode);
+            opts->path, ssh_flags, creat_mode);
+    s->sftp_handle = libssh2_sftp_open(s->sftp, opts->path, ssh_flags,
+                                       creat_mode);
     if (!s->sftp_handle) {
-        session_error_setg(errp, s, "failed to open remote file '%s'", path);
+        session_error_setg(errp, s, "failed to open remote file '%s'",
+                           opts->path);
         ret = -EINVAL;
         goto err;
     }
 
-    qemu_opts_del(opts);
+    qapi_free_BlockdevOptionsSsh(opts);
 
     r = libssh2_sftp_fstat(s->sftp_handle, &s->attrs);
     if (r < 0) {
@@ -764,7 +751,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
     s->session = NULL;
 
-    qemu_opts_del(opts);
+    qapi_free_BlockdevOptionsSsh(opts);
 
     return ret;
 }
-- 
2.13.6
