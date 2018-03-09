Received: from eggs.gnu.org ([2001:4830:134:3::10]:34134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlJ-0001VL-AY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKlG-0007Lv-2v
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:53 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:22 +0100
Message-Id: <20180309161933.8168-46-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 45/56] ssh: QAPIfy host-key-check option
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

This makes the host-key-check option available in blockdev-add.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 63 +++++++++++++++++++++++++++++++++++--
 block/ssh.c          | 88 +++++++++++++++++++++++++++++++++-------------------
 2 files changed, 117 insertions(+), 34 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index fd444421fc..4814bb7db7 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2553,6 +2553,63 @@
             '*encrypt': 'BlockdevQcow2Encryption' } }
 
 ##
+# @SshHostKeyCheckMode:
+#
+# @none             Don't check the host key at all
+# @hash             Compare the host key with a given hash
+# @known_hosts      Check the host key against the known_hosts file
+#
+# Since: 2.12
+##
+{ 'enum': 'SshHostKeyCheckMode',
+  'data': [ 'none', 'hash', 'known_hosts' ] }
+
+##
+# @SshHostKeyCheckHashType:
+#
+# @md5              The given hash is an md5 hash
+# @sha1             The given hash is an sha1 hash
+#
+# Since: 2.12
+##
+{ 'enum': 'SshHostKeyCheckHashType',
+  'data': [ 'md5', 'sha1' ] }
+
+##
+# @SshHostKeyHash:
+#
+# @type             The hash algorithm used for the hash
+# @hash             The expected hash value
+#
+# Since: 2.12
+##
+{ 'struct': 'SshHostKeyHash',
+  'data': { 'type': 'SshHostKeyCheckHashType',
+            'hash': 'str' }}
+
+##
+# @SshHostKeyDummy:
+#
+# For those union branches that don't need additional fields.
+#
+# Since: 2.12
+##
+{ 'struct': 'SshHostKeyDummy',
+  'data': {} }
+
+##
+# @SshHostKeyCheck:
+#
+# Since: 2.12
+##
+{ 'union': 'SshHostKeyCheck',
+  'base': { 'mode': 'SshHostKeyCheckMode' },
+  'discriminator': 'mode',
+  'data': { 'none': 'SshHostKeyDummy',
+            'hash': 'SshHostKeyHash',
+            'known_hosts': 'SshHostKeyDummy' } }
+
+##
 # @BlockdevOptionsSsh:
 #
 # @server:              host address
@@ -2562,14 +2619,16 @@
 # @user:                user as which to connect, defaults to current
 #                       local user name
 #
-# TODO: Expose the host_key_check option in QMP
+# @host-key-check:      Defines how and what to check the host key against
+#                       (default: known_hosts)
 #
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsSsh',
   'data': { 'server': 'InetSocketAddress',
             'path': 'str',
-            '*user': 'str' } }
+            '*user': 'str',
+            '*host-key-check': 'SshHostKeyCheck' } }
 
 
 ##
diff --git a/block/ssh.c b/block/ssh.c
index 8b646c0ede..30cdf9a99f 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -431,31 +431,35 @@ check_host_key_hash(BDRVSSHState *s, const char *hash,
 }
 
 static int check_host_key(BDRVSSHState *s, const char *host, int port,
-                          const char *host_key_check, Error **errp)
+                          SshHostKeyCheck *hkc, Error **errp)
 {
-    /* host_key_check=no */
-    if (strcmp(host_key_check, "no") == 0) {
-        return 0;
-    }
+    SshHostKeyCheckMode mode;
 
-    /* host_key_check=md5:xx:yy:zz:... */
-    if (strncmp(host_key_check, "md5:", 4) == 0) {
-        return check_host_key_hash(s, &host_key_check[4],
-                                   LIBSSH2_HOSTKEY_HASH_MD5, 16, errp);
-    }
-
-    /* host_key_check=sha1:xx:yy:zz:... */
-    if (strncmp(host_key_check, "sha1:", 5) == 0) {
-        return check_host_key_hash(s, &host_key_check[5],
-                                   LIBSSH2_HOSTKEY_HASH_SHA1, 20, errp);
+    if (hkc) {
+        mode = hkc->mode;
+    } else {
+        mode = SSH_HOST_KEY_CHECK_MODE_KNOWN_HOSTS;
     }
 
-    /* host_key_check=yes */
-    if (strcmp(host_key_check, "yes") == 0) {
+    switch (mode) {
+    case SSH_HOST_KEY_CHECK_MODE_NONE:
+        return 0;
+    case SSH_HOST_KEY_CHECK_MODE_HASH:
+        if (hkc->u.hash.type == SSH_HOST_KEY_CHECK_HASH_TYPE_MD5) {
+            return check_host_key_hash(s, hkc->u.hash.hash,
+                                       LIBSSH2_HOSTKEY_HASH_MD5, 16, errp);
+        } else if (hkc->u.hash.type == SSH_HOST_KEY_CHECK_HASH_TYPE_SHA1) {
+            return check_host_key_hash(s, hkc->u.hash.hash,
+                                       LIBSSH2_HOSTKEY_HASH_SHA1, 20, errp);
+        }
+        g_assert_not_reached();
+        break;
+    case SSH_HOST_KEY_CHECK_MODE_KNOWN_HOSTS:
         return check_host_key_knownhosts(s, host, port, errp);
+    default:
+        g_assert_not_reached();
     }
 
-    error_setg(errp, "unknown host_key_check setting (%s)", host_key_check);
     return -EINVAL;
 }
 
@@ -544,16 +548,22 @@ static QemuOptsList ssh_runtime_opts = {
             .type = QEMU_OPT_NUMBER,
             .help = "Port to connect to",
         },
+        {
+            .name = "host_key_check",
+            .type = QEMU_OPT_STRING,
+            .help = "Defines how and what to check the host key against",
+        },
         { /* end of list */ }
     },
 };
 
-static bool ssh_process_legacy_socket_options(QDict *output_opts,
-                                              QemuOpts *legacy_opts,
-                                              Error **errp)
+static bool ssh_process_legacy_options(QDict *output_opts,
+                                       QemuOpts *legacy_opts,
+                                       Error **errp)
 {
     const char *host = qemu_opt_get(legacy_opts, "host");
     const char *port = qemu_opt_get(legacy_opts, "port");
+    const char *host_key_check = qemu_opt_get(legacy_opts, "host_key_check");
 
     if (!host && port) {
         error_setg(errp, "port may not be used without host");
@@ -565,6 +575,28 @@ static bool ssh_process_legacy_socket_options(QDict *output_opts,
         qdict_put_str(output_opts, "server.port", port ?: stringify(22));
     }
 
+    if (host_key_check) {
+        if (strcmp(host_key_check, "no") == 0) {
+            qdict_put_str(output_opts, "host-key-check.mode", "none");
+        } else if (strncmp(host_key_check, "md5:", 4) == 0) {
+            qdict_put_str(output_opts, "host-key-check.mode", "hash");
+            qdict_put_str(output_opts, "host-key-check.type", "md5");
+            qdict_put_str(output_opts, "host-key-check.hash",
+                          &host_key_check[4]);
+        } else if (strncmp(host_key_check, "sha1:", 5) == 0) {
+            qdict_put_str(output_opts, "host-key-check.mode", "hash");
+            qdict_put_str(output_opts, "host-key-check.type", "sha1");
+            qdict_put_str(output_opts, "host-key-check.hash",
+                          &host_key_check[5]);
+        } else if (strcmp(host_key_check, "yes") == 0) {
+            qdict_put_str(output_opts, "host-key-check.mode", "known_hosts");
+        } else {
+            error_setg(errp, "unknown host_key_check setting (%s)",
+                       host_key_check);
+            return false;
+        }
+    }
+
     return true;
 }
 
@@ -585,7 +617,7 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
         goto fail;
     }
 
-    if (!ssh_process_legacy_socket_options(options, opts, errp)) {
+    if (!ssh_process_legacy_options(options, opts, errp)) {
         goto fail;
     }
 
@@ -629,16 +661,9 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
 {
     BlockdevOptionsSsh *opts;
     int r, ret;
-    const char *user, *host_key_check;
+    const char *user;
     long port = 0;
 
-    host_key_check = qdict_get_try_str(options, "host_key_check");
-    if (!host_key_check) {
-        host_key_check = "yes";
-    } else {
-        qdict_del(options, "host_key_check");
-    }
-
     opts = ssh_parse_options(options, errp);
     if (opts == NULL) {
         return -EINVAL;
@@ -692,8 +717,7 @@ static int connect_to_ssh(BDRVSSHState *s, QDict *options,
     }
 
     /* Check the remote host's key against known_hosts. */
-    ret = check_host_key(s, s->inet->host, port, host_key_check,
-                         errp);
+    ret = check_host_key(s, s->inet->host, port, opts->host_key_check, errp);
     if (ret < 0) {
         goto err;
     }
-- 
2.13.6
