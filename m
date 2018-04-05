Received: from eggs.gnu.org ([2001:4830:134:3::10]:59875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f48LN-0004Ss-KE
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f48LL-0001lj-L9
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:06:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Apr 2018 19:06:19 +0200
Message-Id: <20180405170619.20480-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jdurgin@redhat.com, jcody@redhat.com, eblake@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

The legacy command line syntax supports a "password-secret" option that
allows to pass an authentication key to Ceph. This was not supported in
QMP so far.

This patch introduces authentication options in the QAPI schema, makes
them do the corresponding rados_conf_set() calls and adds compatibility
code that translates the old "password-secret" option both for opening
and creating images to the new set of options.

Note that the old option didn't allow to explicitly specify the set of
allowed authentication schemes. The compatibility code assumes that if
"password-secret" is given, only the cephx scheme is allowed. If it's
missing, both none and cephx are allowed because the configuration file
could still provide a key.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---

This doesn't actually work correctly yet because the way that options
are passed through the block layer (QAPI -> QemuOpts -> QDict). Before
we fix or hack around this, let's make sure this is the schema that we
want.

The two known problems are:

1. QDict *options in qemu_rbd_open() may contain options either in their
   proper QObject types (if passed from blockdev-add) or as strings
   (-drive). Both forms can be mixed in the same options QDict.

   rbd uses the keyval visitor to convert the options into a QAPI
   object. This means that it requires all options to be strings. This
   patch, however, introduces a bool property, so the visitor breaks
   when it gets its input from blockdev-add.

   Options to hack around the problem:

   a. Do an extra conversion step or two and go through QemuOpts like
      some other block drivers. When I offered something like this to
      Markus a while ago in a similar case, he rejected the idea.

   b. Introduce a qdict_stringify_entries() that just does what its name
      says. It would be called before the running keyval visitor so that
      only strings will be present in the QDict.

   c. Do a local one-off hack that checks if the entry with the key
      "auth-none" is a QBool, and if so, overwrite it with a string. The
      problem will reappear with the next non-string option.

   (d. Get rid of the QDict detour and work only with QAPI objects
       everywhere. Support rbd authentication only in QEMU 4.0.)

2. The proposed schema allows 'auth-cephx': {} as a valid option with
   the meaning that the cephx authentication scheme is enabled, but no
   key is given (e.g. it is taken from the config file).

   However, an empty dict cannot currently be represented by flattened
   QDicts. We need to find a way to enable this. I think this will be
   externally visible because it directly translates into the dotted
   syntax of -blockdev, so we may want to be careful.

Any thoughts on the proposed QAPI schema or the two implementation
problems are welcome.

 qapi/block-core.json |  22 +++++++++++
 block/rbd.c          | 102 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 99 insertions(+), 25 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c50517bff3..d5ce588add 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3170,6 +3170,19 @@
 
 
 ##
+# @RbdAuthCephx:
+#
+# @key-secret:         ID of a QCryptoSecret object providing a key for cephx
+#                      authentication. If not specified, a key from the
+#                      specified configuration file, or the system default
+#                      configuration is used, if present.
+#
+# Since: 2.13
+##
+{ 'struct': 'RbdAuthCephx',
+  'data': { '*key-secret': 'str' } }
+
+##
 # @BlockdevOptionsRbd:
 #
 # @pool:               Ceph pool name.
@@ -3184,6 +3197,13 @@
 #
 # @user:               Ceph id name.
 #
+# @auth-none:          true if connecting to a server without authentication
+#                      should be allowed (default: false; since 2.13)
+#
+# @auth-cephx:         Configuration for cephx authentication if specified. If
+#                      not specified, cephx authentication is not allowed.
+#                      (since 2.13)
+#
 # @server:             Monitor host address and port.  This maps
 #                      to the "mon_host" Ceph option.
 #
@@ -3195,6 +3215,8 @@
             '*conf': 'str',
             '*snapshot': 'str',
             '*user': 'str',
+            '*auth-none': 'bool',
+            '*auth-cephx': 'RbdAuthCephx',
             '*server': ['InetSocketAddressBase'] } }
 
 ##
diff --git a/block/rbd.c b/block/rbd.c
index 5b64849dc6..c2a9a92dd5 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -105,8 +105,7 @@ typedef struct BDRVRBDState {
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
                             BlockdevOptionsRbd *opts, bool cache,
-                            const char *keypairs, const char *secretid,
-                            Error **errp);
+                            const char *keypairs, Error **errp);
 
 static char *qemu_rbd_next_tok(char *src, char delim, char **p)
 {
@@ -231,21 +230,40 @@ done:
 }
 
 
-static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
+static int qemu_rbd_set_auth(rados_t cluster, BlockdevOptionsRbd *opts,
                              Error **errp)
 {
-    if (secretid == 0) {
-        return 0;
-    }
+    int r;
 
-    gchar *secret = qcrypto_secret_lookup_as_base64(secretid,
-                                                    errp);
-    if (!secret) {
-        return -1;
+    if (opts->auth_none && opts->has_auth_cephx) {
+        r = rados_conf_set(cluster, "auth_client_required", "none;cephx");
+    } else if (opts->auth_none) {
+        r = rados_conf_set(cluster, "auth_client_required", "none");
+    } else if (opts->has_auth_cephx) {
+        r = rados_conf_set(cluster, "auth_client_required", "cephx");
+    } else {
+        error_setg(errp, "No authentication scheme allowed");
+        return -EINVAL;
+    }
+    if (r < 0) {
+        error_setg_errno(errp, -r, "Could not set 'auth_client_required'");
+        return r;
     }
 
-    rados_conf_set(cluster, "key", secret);
-    g_free(secret);
+    if (opts->has_auth_cephx && opts->auth_cephx->has_key_secret) {
+        gchar *secret =
+            qcrypto_secret_lookup_as_base64(opts->auth_cephx->key_secret, errp);
+        if (!secret) {
+            return -EIO;
+        }
+
+        r = rados_conf_set(cluster, "key", secret);
+        g_free(secret);
+        if (r < 0) {
+            error_setg_errno(errp, -r, "Could not set 'key'");
+            return r;
+        }
+    }
 
     return 0;
 }
@@ -337,12 +355,9 @@ static QemuOptsList runtime_opts = {
     },
 };
 
-/* FIXME Deprecate and remove keypairs or make it available in QMP.
- * password_secret should eventually be configurable in opts->location. Support
- * for it in .bdrv_open will make it work here as well. */
+/* FIXME Deprecate and remove keypairs or make it available in QMP. */
 static int qemu_rbd_do_create(BlockdevCreateOptions *options,
-                              const char *keypairs, const char *password_secret,
-                              Error **errp)
+                              const char *keypairs, Error **errp)
 {
     BlockdevCreateOptionsRbd *opts = &options->u.rbd;
     rados_t cluster;
@@ -370,7 +385,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *options,
     }
 
     ret = qemu_rbd_connect(&cluster, &io_ctx, opts->location, false, keypairs,
-                           password_secret, errp);
+                           errp);
     if (ret < 0) {
         return ret;
     }
@@ -390,7 +405,7 @@ out:
 
 static int qemu_rbd_co_create(BlockdevCreateOptions *options, Error **errp)
 {
-    return qemu_rbd_do_create(options, NULL, NULL, errp);
+    return qemu_rbd_do_create(options, NULL, errp);
 }
 
 static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
@@ -443,7 +458,21 @@ static int coroutine_fn qemu_rbd_co_create_opts(const char *filename,
     loc->image    = g_strdup(qdict_get_try_str(options, "image"));
     keypairs      = qdict_get_try_str(options, "=keyvalue-pairs");
 
-    ret = qemu_rbd_do_create(create_options, keypairs, password_secret, errp);
+    /* Always allow the cephx authentication scheme, even if no password-secret
+     * is given; the key might come from the config file. Without password-secret,
+     * also allow none. */
+    loc->has_auth_cephx = true;
+    loc->auth_cephx = g_new0(RbdAuthCephx, 1);
+
+    if (password_secret) {
+        loc->auth_cephx->has_key_secret = true;
+        loc->auth_cephx->key_secret = g_strdup(password_secret);
+    } else {
+        loc->has_auth_none = true;
+        loc->auth_none = true;
+    }
+
+    ret = qemu_rbd_do_create(create_options, keypairs, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -538,8 +567,7 @@ static char *qemu_rbd_mon_host(BlockdevOptionsRbd *opts, Error **errp)
 
 static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
                             BlockdevOptionsRbd *opts, bool cache,
-                            const char *keypairs, const char *secretid,
-                            Error **errp)
+                            const char *keypairs, Error **errp)
 {
     char *mon_host = NULL;
     Error *local_err = NULL;
@@ -577,8 +605,8 @@ static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
         }
     }
 
-    if (qemu_rbd_set_auth(*cluster, secretid, errp) < 0) {
-        r = -EIO;
+    r = qemu_rbd_set_auth(*cluster, opts, errp);
+    if (r < 0) {
         goto failed_shutdown;
     }
 
@@ -671,8 +699,32 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
+    /* Always allow the cephx authentication scheme, even if no password-secret
+     * is given; the key might come from the config file. Without password-secret,
+     * also allow none. If the new QAPI-style options are given, don't override
+     * them, though. */
+    if (opts->auth_cephx == NULL) {
+        opts->has_auth_cephx = true;
+        opts->auth_cephx = g_new0(RbdAuthCephx, 1);
+    }
+
+    if (secretid) {
+        if (opts->auth_cephx->has_key_secret) {
+            error_setg(errp, "'auth-ceph.key-secret' and its alias "
+                             "'password-secret' can't be used at the "
+                             "same time");
+            r = -EINVAL;
+            goto out;
+        }
+        opts->auth_cephx->has_key_secret = true;
+        opts->auth_cephx->key_secret = g_strdup(secretid);
+    } else if (!opts->has_auth_none) {
+        opts->has_auth_none = true;
+        opts->auth_none = true;
+    }
+
     r = qemu_rbd_connect(&s->cluster, &s->io_ctx, opts,
-                         !(flags & BDRV_O_NOCACHE), keypairs, secretid, errp);
+                         !(flags & BDRV_O_NOCACHE), keypairs, errp);
     if (r < 0) {
         goto out;
     }
-- 
2.13.6
