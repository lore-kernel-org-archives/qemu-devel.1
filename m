Received: from eggs.gnu.org ([2001:4830:134:3::10]:46624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cjHhC-0003k6-Ml
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cjHhB-0004GG-Fc
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 22:46:26 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed,  1 Mar 2017 22:46:13 -0500
Message-Id: <20170302034613.21609-6-jcody@redhat.com>
In-Reply-To: <20170302034613.21609-1-jcody@redhat.com>
References: <20170302034613.21609-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL v3 5/5] block/rbd: add support for 'mon_host',
 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

This adds support for three additional options that may be specified
by QAPI in blockdev-add:

    server: host, port
    auth method: either 'cephx' or 'none'

The "server" and "auth-supported" QAPI parameters are arrays.  To conform
with the rados API, the array items are join as a single string with a ';'
character as a delimiter when setting the configuration values.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c          | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/block-core.json |  29 +++++++++++
 2 files changed, 164 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index cc43f42..ee13f3d 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -405,6 +405,19 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Legacy rados key/value option parameters",
         },
+        {
+            .name = "host",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "port",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "auth",
+            .type = QEMU_OPT_STRING,
+            .help = "Supported authentication method, either cephx or none",
+        },
         { /* end of list */ }
     },
 };
@@ -565,6 +578,94 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     qemu_aio_unref(acb);
 }
 
+#define RBD_MON_HOST          0
+#define RBD_AUTH_SUPPORTED    1
+
+static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
+                                 Error **errp)
+{
+    int num_entries;
+    QemuOpts *opts = NULL;
+    QDict *sub_options;
+    const char *host;
+    const char *port;
+    char *str;
+    char *rados_str = NULL;
+    Error *local_err = NULL;
+    int i;
+
+    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
+
+    num_entries = qdict_array_entries(options, prefix);
+
+    if (num_entries < 0) {
+        error_setg(errp, "Parse error on RBD QDict array");
+        return NULL;
+    }
+
+    for (i = 0; i < num_entries; i++) {
+        char *strbuf = NULL;
+        const char *value;
+        char *rados_str_tmp;
+
+        str = g_strdup_printf("%s%d.", prefix, i);
+        qdict_extract_subqdict(options, &sub_options, str);
+        g_free(str);
+
+        opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+        qemu_opts_absorb_qdict(opts, sub_options, &local_err);
+        QDECREF(sub_options);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            g_free(rados_str);
+            rados_str = NULL;
+            goto exit;
+        }
+
+        if (type == RBD_MON_HOST) {
+            host = qemu_opt_get(opts, "host");
+            port = qemu_opt_get(opts, "port");
+
+            value = host;
+            if (port) {
+                /* check for ipv6 */
+                if (strchr(host, ':')) {
+                    strbuf = g_strdup_printf("[%s]:%s", host, port);
+                } else {
+                    strbuf = g_strdup_printf("%s:%s", host, port);
+                }
+                value = strbuf;
+            } else if (strchr(host, ':')) {
+                strbuf = g_strdup_printf("[%s]", host);
+                value = strbuf;
+            }
+        } else {
+            value = qemu_opt_get(opts, "auth");
+        }
+
+
+        /* each iteration in the for loop will build upon the string, and if
+         * rados_str is NULL then it is our first pass */
+        if (rados_str) {
+            /* separate options with ';', as that  is what rados_conf_set()
+             * requires */
+            rados_str_tmp = rados_str;
+            rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
+            g_free(rados_str_tmp);
+        } else {
+            rados_str = g_strdup(value);
+        }
+
+        g_free(strbuf);
+        qemu_opts_del(opts);
+        opts = NULL;
+    }
+
+exit:
+    qemu_opts_del(opts);
+    return rados_str;
+}
+
 static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
@@ -573,6 +674,8 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     const char *secretid;
     QemuOpts *opts;
     Error *local_err = NULL;
+    char *mon_host = NULL;
+    char *auth_supported = NULL;
     int r;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
@@ -583,6 +686,22 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
+    auth_supported = qemu_rbd_array_opts(options, "auth-supported.",
+                                         RBD_AUTH_SUPPORTED, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        r = -EINVAL;
+        goto failed_opts;
+    }
+
+    mon_host = qemu_rbd_array_opts(options, "server.",
+                                   RBD_MON_HOST, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        r = -EINVAL;
+        goto failed_opts;
+    }
+
     secretid = qemu_opt_get(opts, "password-secret");
 
     pool           = qemu_opt_get(opts, "pool");
@@ -615,6 +734,20 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto failed_shutdown;
     }
 
+    if (mon_host) {
+        r = rados_conf_set(s->cluster, "mon_host", mon_host);
+        if (r < 0) {
+            goto failed_shutdown;
+        }
+    }
+
+    if (auth_supported) {
+        r = rados_conf_set(s->cluster, "auth_supported", auth_supported);
+        if (r < 0) {
+            goto failed_shutdown;
+        }
+    }
+
     if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
         r = -EIO;
         goto failed_shutdown;
@@ -663,6 +796,8 @@ failed_shutdown:
     g_free(s->snap);
 failed_opts:
     qemu_opts_del(opts);
+    g_free(mon_host);
+    g_free(auth_supported);
     return r;
 }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 803edc3..2e01a95 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2666,6 +2666,28 @@
             '*header-digest': 'IscsiHeaderDigest',
             '*timeout': 'int' } }
 
+
+##
+# @RbdAuthSupport:
+#
+# An enumeration of RBD auth support
+#
+# Since: 2.9
+##
+{ 'enum': 'RbdAuthSupport',
+  'data': [ 'cephx', 'none' ] }
+
+
+##
+# @RbdAuthMethod:
+#
+# An enumeration of rados auth_supported types
+#
+# Since: 2.9
+##
+{ 'struct': 'RbdAuthMethod',
+  'data': { 'auth': 'RbdAuthSupport' } }
+
 ##
 # @BlockdevOptionsRbd:
 #
@@ -2681,6 +2703,11 @@
 #
 # @user:               #optional Ceph id name.
 #
+# @server:             #optional Monitor host address and port.  This maps
+#                      to the "mon_host" Ceph option.
+#
+# @auth-supported:     #optional Authentication supported.
+#
 # @password-secret:    #optional The ID of a QCryptoSecret object providing
 #                      the password for the login.
 #
@@ -2692,6 +2719,8 @@
             '*conf': 'str',
             '*snapshot': 'str',
             '*user': 'str',
+            '*server': ['InetSocketAddress'],
+            '*auth-supported': ['RbdAuthMethod'],
             '*password-secret': 'str' } }
 
 ##
-- 
2.9.3
