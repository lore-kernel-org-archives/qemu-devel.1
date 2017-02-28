Received: from eggs.gnu.org ([2001:4830:134:3::10]:47896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikRc-0004yy-Ux
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cikRY-0001py-TG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:16:08 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 28 Feb 2017 11:15:51 -0500
Message-Id: <20170228161553.28142-4-jcody@redhat.com>
In-Reply-To: <20170228161553.28142-1-jcody@redhat.com>
References: <20170228161553.28142-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] block/rbd: parse all options via
 bdrv_parse_filename
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

Get rid of qemu_rbd_parsename in favor of bdrv_parse_filename.
This simplifies a lot of the parsing as well, as we can treat everything
a bit simpler since nonexistent options are simply NULL pointers instead
of empty strings.

An important item to note:

Ceph has many extra option values that can be specified as key/value
pairs.  This was handled previously in the driver by extracting the
values that the QEMU driver cared about, and then blindly passing all
extra options to rbd after splitting them into key/value pairs, and
cleaning up any special character escaping.

The practice is continued in this patch; there is an option
"keyvalue-pairs" that is populated with all the key/value pairs that the
QEMU driver does not care about.  These key/value pairs will override
any settings in the 'conf' configuration file, just as they did before.

Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/rbd.c | 303 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 153 insertions(+), 150 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 67d680c..cc43f42 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -18,6 +18,7 @@
 #include "block/block_int.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
+#include "qapi/qmp/qstring.h"
 
 #include <rbd/librbd.h>
 
@@ -151,113 +152,134 @@ static void qemu_rbd_unescape(char *src)
     *p = '\0';
 }
 
-static int qemu_rbd_parsename(const char *filename,
-                              char *pool, int pool_len,
-                              char *snap, int snap_len,
-                              char *name, int name_len,
-                              char *conf, int conf_len,
-                              Error **errp)
+static void qemu_rbd_parse_filename(const char *filename, QDict *options,
+                                    Error **errp)
 {
     const char *start;
-    char *p, *buf;
-    int ret = 0;
+    char *p, *buf, *keypairs;
     char *found_str;
+    size_t max_keypair_size;
     Error *local_err = NULL;
 
     if (!strstart(filename, "rbd:", &start)) {
         error_setg(errp, "File name must start with 'rbd:'");
-        return -EINVAL;
+        return;
     }
 
+    max_keypair_size = strlen(start) + 1;
     buf = g_strdup(start);
+    keypairs = g_malloc0(max_keypair_size);
     p = buf;
-    *snap = '\0';
-    *conf = '\0';
 
-    found_str = qemu_rbd_next_tok(pool_len, p,
+    found_str = qemu_rbd_next_tok(RBD_MAX_POOL_NAME_SIZE, p,
                                   '/', "pool name", &p, &local_err);
     if (local_err) {
         goto done;
     }
     if (!p) {
-        ret = -EINVAL;
         error_setg(errp, "Pool name is required");
         goto done;
     }
     qemu_rbd_unescape(found_str);
-    g_strlcpy(pool, found_str, pool_len);
+    qdict_put(options, "pool", qstring_from_str(found_str));
 
     if (strchr(p, '@')) {
-        found_str = qemu_rbd_next_tok(name_len, p,
+        found_str = qemu_rbd_next_tok(RBD_MAX_IMAGE_NAME_SIZE, p,
                                       '@', "object name", &p, &local_err);
         if (local_err) {
             goto done;
         }
         qemu_rbd_unescape(found_str);
-        g_strlcpy(name, found_str, name_len);
+        qdict_put(options, "image", qstring_from_str(found_str));
 
-        found_str = qemu_rbd_next_tok(snap_len, p,
+        found_str = qemu_rbd_next_tok(RBD_MAX_SNAP_NAME_SIZE, p,
                                       ':', "snap name", &p, &local_err);
         if (local_err) {
             goto done;
         }
         qemu_rbd_unescape(found_str);
-        g_strlcpy(snap, found_str, snap_len);
+        qdict_put(options, "snapshot", qstring_from_str(found_str));
     } else {
-        found_str = qemu_rbd_next_tok(name_len, p,
+        found_str = qemu_rbd_next_tok(RBD_MAX_IMAGE_NAME_SIZE, p,
                                       ':', "object name", &p, &local_err);
         if (local_err) {
             goto done;
         }
         qemu_rbd_unescape(found_str);
-        g_strlcpy(name, found_str, name_len);
+        qdict_put(options, "image", qstring_from_str(found_str));
     }
     if (!p) {
         goto done;
     }
 
-    found_str = qemu_rbd_next_tok(conf_len, p,
+    found_str = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
                                   '\0', "configuration", &p, &local_err);
     if (local_err) {
         goto done;
     }
-    g_strlcpy(conf, found_str, conf_len);
+
+    p = found_str;
+
+    /* The following are essentially all key/value pairs, and we treat
+     * 'id' and 'conf' a bit special.  Key/value pairs may be in any order. */
+    while (p) {
+        char *name, *value;
+        name = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
+                                 '=', "conf option name", &p, &local_err);
+        if (local_err) {
+            break;
+        }
+
+        if (!p) {
+            error_setg(errp, "conf option %s has no value", name);
+            break;
+        }
+
+        qemu_rbd_unescape(name);
+
+        value = qemu_rbd_next_tok(RBD_MAX_CONF_VAL_SIZE, p,
+                                  ':', "conf option value", &p, &local_err);
+        if (local_err) {
+            break;
+        }
+        qemu_rbd_unescape(value);
+
+        if (!strcmp(name, "conf")) {
+            qdict_put(options, "conf", qstring_from_str(value));
+        } else if (!strcmp(name, "id")) {
+            qdict_put(options, "user" , qstring_from_str(value));
+        } else {
+            /* FIXME: This is pretty ugly, and not the right way to do this.
+             *        These should be contained in a structure, and then
+             *        passed explicitly as individual key/value pairs to
+             *        rados.  Consider this legacy code that needs to be
+             *        updated. */
+            char *tmp = g_malloc0(max_keypair_size);
+            /* only use a delimiter if it is not the first keypair found */
+            /* These are sets of unknown key/value pairs we'll pass along
+             * to ceph */
+            if (keypairs[0]) {
+                snprintf(tmp, max_keypair_size, ":%s=%s", name, value);
+                pstrcat(keypairs, max_keypair_size, tmp);
+            } else {
+                snprintf(keypairs, max_keypair_size, "%s=%s", name, value);
+            }
+            g_free(tmp);
+        }
+    }
+
+    if (keypairs[0]) {
+        qdict_put(options, "keyvalue-pairs", qstring_from_str(keypairs));
+    }
+
 
 done:
     if (local_err) {
-        ret = -EINVAL;
         error_propagate(errp, local_err);
     }
     g_free(buf);
-    return ret;
-}
-
-static char *qemu_rbd_parse_clientname(const char *conf, char *clientname)
-{
-    const char *p = conf;
-
-    while (*p) {
-        int len;
-        const char *end = strchr(p, ':');
-
-        if (end) {
-            len = end - p;
-        } else {
-            len = strlen(p);
-        }
-
-        if (strncmp(p, "id=", 3) == 0) {
-            len -= 3;
-            strncpy(clientname, p + 3, len);
-            clientname[len] = '\0';
-            return clientname;
-        }
-        if (end == NULL) {
-            break;
-        }
-        p = end + 1;
-    }
-    return NULL;
+    g_free(keypairs);
+    return;
 }
 
 
@@ -280,10 +302,8 @@ static int qemu_rbd_set_auth(rados_t cluster, const char *secretid,
     return 0;
 }
 
-
-static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
-                             bool only_read_conf_file,
-                             Error **errp)
+static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs,
+                                 Error **errp)
 {
     char *p, *buf;
     char *name;
@@ -291,7 +311,7 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
     Error *local_err = NULL;
     int ret = 0;
 
-    buf = g_strdup(conf);
+    buf = g_strdup(keypairs);
     p = buf;
 
     while (p) {
@@ -300,7 +320,6 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
         if (local_err) {
             break;
         }
-        qemu_rbd_unescape(name);
 
         if (!p) {
             error_setg(errp, "conf option %s has no value", name);
@@ -313,28 +332,12 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
         if (local_err) {
             break;
         }
-        qemu_rbd_unescape(value);
 
-        if (strcmp(name, "conf") == 0) {
-            /* read the conf file alone, so it doesn't override more
-               specific settings for a particular device */
-            if (only_read_conf_file) {
-                ret = rados_conf_read_file(cluster, value);
-                if (ret < 0) {
-                    error_setg_errno(errp, -ret, "error reading conf file %s",
-                                     value);
-                    break;
-                }
-            }
-        } else if (strcmp(name, "id") == 0) {
-            /* ignore, this is parsed by qemu_rbd_parse_clientname() */
-        } else if (!only_read_conf_file) {
-            ret = rados_conf_set(cluster, name, value);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret, "invalid conf option %s", name);
-                ret = -EINVAL;
-                break;
-            }
+        ret = rados_conf_set(cluster, name, value);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "invalid conf option %s", name);
+            ret = -EINVAL;
+            break;
         }
     }
 
@@ -412,27 +415,16 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     int64_t bytes = 0;
     int64_t objsize;
     int obj_order = 0;
-    char pool[RBD_MAX_POOL_NAME_SIZE];
-    char name[RBD_MAX_IMAGE_NAME_SIZE];
-    char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
-    char conf[RBD_MAX_CONF_SIZE];
-    char clientname_buf[RBD_MAX_CONF_SIZE];
-    char *clientname;
+    const char *pool, *name, *conf, *clientname, *keypairs;
     const char *secretid;
     rados_t cluster;
     rados_ioctx_t io_ctx;
-    int ret;
+    QDict *options = NULL;
+    QemuOpts *rbd_opts = NULL;
+    int ret = 0;
 
     secretid = qemu_opt_get(opts, "password-secret");
 
-    if (qemu_rbd_parsename(filename, pool, sizeof(pool),
-                           snap_buf, sizeof(snap_buf),
-                           name, sizeof(name),
-                           conf, sizeof(conf), &local_err) < 0) {
-        error_propagate(errp, local_err);
-        return -EINVAL;
-    }
-
     /* Read out options */
     bytes = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                      BDRV_SECTOR_SIZE);
@@ -440,35 +432,55 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
     if (objsize) {
         if ((objsize - 1) & objsize) {    /* not a power of 2? */
             error_setg(errp, "obj size needs to be power of 2");
-            return -EINVAL;
+            ret = -EINVAL;
+            goto exit;
         }
         if (objsize < 4096) {
             error_setg(errp, "obj size too small");
-            return -EINVAL;
+            ret = -EINVAL;
+            goto exit;
         }
         obj_order = ctz32(objsize);
     }
 
-    clientname = qemu_rbd_parse_clientname(conf, clientname_buf);
+    options = qdict_new();
+    qemu_rbd_parse_filename(filename, options, &local_err);
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+        goto exit;
+    }
+
+    rbd_opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(rbd_opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto exit;
+    }
+
+    pool       = qemu_opt_get(rbd_opts, "pool");
+    conf       = qemu_opt_get(rbd_opts, "conf");
+    clientname = qemu_opt_get(rbd_opts, "user");
+    name       = qemu_opt_get(rbd_opts, "image");
+    keypairs   = qemu_opt_get(rbd_opts, "keyvalue-pairs");
+
     ret = rados_create(&cluster, clientname);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error initializing");
-        return ret;
+        goto exit;
     }
 
-    if (strstr(conf, "conf=") == NULL) {
-        /* try default location, but ignore failure */
-        rados_conf_read_file(cluster, NULL);
-    } else if (conf[0] != '\0' &&
-               qemu_rbd_set_conf(cluster, conf, true, &local_err) < 0) {
-        error_propagate(errp, local_err);
+    /* try default location when conf=NULL, but ignore failure */
+    ret = rados_conf_read_file(cluster, conf);
+    if (conf && ret < 0) {
+        error_setg_errno(errp, -ret, "error reading conf file %s", conf);
         ret = -EIO;
         goto shutdown;
     }
 
-    if (conf[0] != '\0' &&
-        qemu_rbd_set_conf(cluster, conf, false, &local_err) < 0) {
-        error_propagate(errp, local_err);
+    ret = qemu_rbd_set_keypairs(cluster, keypairs, errp);
+    if (ret < 0) {
         ret = -EIO;
         goto shutdown;
     }
@@ -499,6 +511,10 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
 
 shutdown:
     rados_shutdown(cluster);
+
+exit:
+    QDECREF(options);
+    qemu_opts_del(rbd_opts);
     return ret;
 }
 
@@ -553,15 +569,10 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
                          Error **errp)
 {
     BDRVRBDState *s = bs->opaque;
-    char pool[RBD_MAX_POOL_NAME_SIZE];
-    char snap_buf[RBD_MAX_SNAP_NAME_SIZE];
-    char conf[RBD_MAX_CONF_SIZE];
-    char clientname_buf[RBD_MAX_CONF_SIZE];
-    char *clientname;
+    const char *pool, *snap, *conf, *clientname, *name, *keypairs;
     const char *secretid;
     QemuOpts *opts;
     Error *local_err = NULL;
-    const char *filename;
     int r;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
@@ -572,44 +583,36 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
         return -EINVAL;
     }
 
-    filename = qemu_opt_get(opts, "filename");
     secretid = qemu_opt_get(opts, "password-secret");
 
-    if (qemu_rbd_parsename(filename, pool, sizeof(pool),
-                           snap_buf, sizeof(snap_buf),
-                           s->name, sizeof(s->name),
-                           conf, sizeof(conf), errp) < 0) {
-        r = -EINVAL;
-        goto failed_opts;
-    }
+    pool           = qemu_opt_get(opts, "pool");
+    conf           = qemu_opt_get(opts, "conf");
+    snap           = qemu_opt_get(opts, "snapshot");
+    clientname     = qemu_opt_get(opts, "user");
+    name           = qemu_opt_get(opts, "image");
+    keypairs       = qemu_opt_get(opts, "keyvalue-pairs");
 
-    clientname = qemu_rbd_parse_clientname(conf, clientname_buf);
     r = rados_create(&s->cluster, clientname);
     if (r < 0) {
         error_setg_errno(errp, -r, "error initializing");
         goto failed_opts;
     }
 
-    s->snap = NULL;
-    if (snap_buf[0] != '\0') {
-        s->snap = g_strdup(snap_buf);
+    s->snap = g_strdup(snap);
+    if (name) {
+        pstrcpy(s->name, RBD_MAX_IMAGE_NAME_SIZE, name);
     }
 
-    if (strstr(conf, "conf=") == NULL) {
-        /* try default location, but ignore failure */
-        rados_conf_read_file(s->cluster, NULL);
-    } else if (conf[0] != '\0') {
-        r = qemu_rbd_set_conf(s->cluster, conf, true, errp);
-        if (r < 0) {
-            goto failed_shutdown;
-        }
+    /* try default location when conf=NULL, but ignore failure */
+    r = rados_conf_read_file(s->cluster, conf);
+    if (conf && r < 0) {
+        error_setg_errno(errp, -r, "error reading conf file %s", conf);
+        goto failed_shutdown;
     }
 
-    if (conf[0] != '\0') {
-        r = qemu_rbd_set_conf(s->cluster, conf, false, errp);
-        if (r < 0) {
-            goto failed_shutdown;
-        }
+    r = qemu_rbd_set_keypairs(s->cluster, keypairs, errp);
+    if (r < 0) {
+        goto failed_shutdown;
     }
 
     if (qemu_rbd_set_auth(s->cluster, secretid, errp) < 0) {
@@ -1063,18 +1066,18 @@ static QemuOptsList qemu_rbd_create_opts = {
 };
 
 static BlockDriver bdrv_rbd = {
-    .format_name        = "rbd",
-    .instance_size      = sizeof(BDRVRBDState),
-    .bdrv_needs_filename = true,
-    .bdrv_file_open     = qemu_rbd_open,
-    .bdrv_close         = qemu_rbd_close,
-    .bdrv_create        = qemu_rbd_create,
-    .bdrv_has_zero_init = bdrv_has_zero_init_1,
-    .bdrv_get_info      = qemu_rbd_getinfo,
-    .create_opts        = &qemu_rbd_create_opts,
-    .bdrv_getlength     = qemu_rbd_getlength,
-    .bdrv_truncate      = qemu_rbd_truncate,
-    .protocol_name      = "rbd",
+    .format_name            = "rbd",
+    .instance_size          = sizeof(BDRVRBDState),
+    .bdrv_parse_filename    = qemu_rbd_parse_filename,
+    .bdrv_file_open         = qemu_rbd_open,
+    .bdrv_close             = qemu_rbd_close,
+    .bdrv_create            = qemu_rbd_create,
+    .bdrv_has_zero_init     = bdrv_has_zero_init_1,
+    .bdrv_get_info          = qemu_rbd_getinfo,
+    .create_opts            = &qemu_rbd_create_opts,
+    .bdrv_getlength         = qemu_rbd_getlength,
+    .bdrv_truncate          = qemu_rbd_truncate,
+    .protocol_name          = "rbd",
 
     .bdrv_aio_readv         = qemu_rbd_aio_readv,
     .bdrv_aio_writev        = qemu_rbd_aio_writev,
-- 
2.9.3
