Received: from eggs.gnu.org ([2001:4830:134:3::10]:36499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQVe-0005BB-I2
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQVc-0003Cl-VM
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:58:58 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 13:58:44 -0500
Message-Id: <963f4d61ffcef289b8030bed4be9b9849e2056fe.1488220970.git.jcody@redhat.com>
In-Reply-To: <cover.1488220970.git.jcody@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
In-Reply-To: <cover.1488220970.git.jcody@redhat.com>
References: <cover.1488220970.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] block/rbd: don't copy strings in
 qemu_rbd_next_tok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com

This patch is prep work for parsing options for .bdrv_parse_filename,
and using QDict options.

The function qemu_rbd_next_tok() searched for various key/value pairs,
and copied them into buffers.  This will soon be an unnecessary extra
step, so we will now return found strings by reference only, and
offload the responsibility for safely handling/coping these strings to
the caller.

This also cleans up error handling some, as the callers now rely on
the Error object to determine if there is a parse error.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 99 +++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 64 insertions(+), 35 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 22e8e69..33c21d8 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -102,10 +102,10 @@ typedef struct BDRVRBDState {
     char *snap;
 } BDRVRBDState;
 
-static int qemu_rbd_next_tok(char *dst, int dst_len,
-                             char *src, char delim,
-                             const char *name,
-                             char **p, Error **errp)
+static char *qemu_rbd_next_tok(int max_len,
+                               char *src, char delim,
+                               const char *name,
+                               char **p, Error **errp)
 {
     int l;
     char *end;
@@ -127,17 +127,15 @@ static int qemu_rbd_next_tok(char *dst, int dst_len,
         }
     }
     l = strlen(src);
-    if (l >= dst_len) {
+    if (l >= max_len) {
         error_setg(errp, "%s too long", name);
-        return -EINVAL;
+        return NULL;
     } else if (l == 0) {
         error_setg(errp, "%s too short", name);
-        return -EINVAL;
+        return NULL;
     }
 
-    pstrcpy(dst, dst_len, src);
-
-    return 0;
+    return src;
 }
 
 static void qemu_rbd_unescape(char *src)
@@ -162,7 +160,9 @@ static int qemu_rbd_parsename(const char *filename,
 {
     const char *start;
     char *p, *buf;
-    int ret;
+    int ret = 0;
+    char *found_str;
+    Error *local_err = NULL;
 
     if (!strstart(filename, "rbd:", &start)) {
         error_setg(errp, "File name must start with 'rbd:'");
@@ -174,36 +174,60 @@ static int qemu_rbd_parsename(const char *filename,
     *snap = '\0';
     *conf = '\0';
 
-    ret = qemu_rbd_next_tok(pool, pool_len, p,
-                            '/', "pool name", &p, errp);
-    if (ret < 0 || !p) {
+    found_str = qemu_rbd_next_tok(pool_len, p,
+                                  '/', "pool name", &p, &local_err);
+    if (local_err) {
+        goto done;
+    }
+    if (!p) {
         ret = -EINVAL;
+        error_setg(errp, "Pool name is required");
         goto done;
     }
-    qemu_rbd_unescape(pool);
+    qemu_rbd_unescape(found_str);
+    g_strlcpy(pool, found_str, pool_len);
 
     if (strchr(p, '@')) {
-        ret = qemu_rbd_next_tok(name, name_len, p,
-                                '@', "object name", &p, errp);
-        if (ret < 0) {
+        found_str = qemu_rbd_next_tok(name_len, p,
+                                      '@', "object name", &p, &local_err);
+        if (local_err) {
             goto done;
         }
-        ret = qemu_rbd_next_tok(snap, snap_len, p,
-                                ':', "snap name", &p, errp);
-        qemu_rbd_unescape(snap);
+        qemu_rbd_unescape(found_str);
+        g_strlcpy(name, found_str, name_len);
+
+        found_str = qemu_rbd_next_tok(snap_len, p,
+                                      ':', "snap name", &p, &local_err);
+        if (local_err) {
+            goto done;
+        }
+        qemu_rbd_unescape(found_str);
+        g_strlcpy(snap, found_str, snap_len);
     } else {
-        ret = qemu_rbd_next_tok(name, name_len, p,
-                                ':', "object name", &p, errp);
+        found_str = qemu_rbd_next_tok(name_len, p,
+                                      ':', "object name", &p, &local_err);
+        if (local_err) {
+            goto done;
+        }
+        qemu_rbd_unescape(found_str);
+        g_strlcpy(name, found_str, name_len);
     }
-    qemu_rbd_unescape(name);
-    if (ret < 0 || !p) {
+    if (!p) {
         goto done;
     }
 
-    ret = qemu_rbd_next_tok(conf, conf_len, p,
-                            '\0', "configuration", &p, errp);
+    found_str = qemu_rbd_next_tok(conf_len, p,
+                                  '\0', "configuration", &p, &local_err);
+    if (local_err) {
+        goto done;
+    }
+    g_strlcpy(conf, found_str, conf_len);
 
 done:
+    if (local_err) {
+        ret = -EINVAL;
+        error_propagate(errp, local_err);
+    }
     g_free(buf);
     return ret;
 }
@@ -262,17 +286,18 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
                              Error **errp)
 {
     char *p, *buf;
-    char name[RBD_MAX_CONF_NAME_SIZE];
-    char value[RBD_MAX_CONF_VAL_SIZE];
+    char *name;
+    char *value;
+    Error *local_err = NULL;
     int ret = 0;
 
     buf = g_strdup(conf);
     p = buf;
 
     while (p) {
-        ret = qemu_rbd_next_tok(name, sizeof(name), p,
-                                '=', "conf option name", &p, errp);
-        if (ret < 0) {
+        name = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
+                                 '=', "conf option name", &p, &local_err);
+        if (local_err) {
             break;
         }
         qemu_rbd_unescape(name);
@@ -283,9 +308,9 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
             break;
         }
 
-        ret = qemu_rbd_next_tok(value, sizeof(value), p,
-                                ':', "conf option value", &p, errp);
-        if (ret < 0) {
+        value = qemu_rbd_next_tok(RBD_MAX_CONF_VAL_SIZE, p,
+                                  ':', "conf option value", &p, &local_err);
+        if (local_err) {
             break;
         }
         qemu_rbd_unescape(value);
@@ -313,6 +338,10 @@ static int qemu_rbd_set_conf(rados_t cluster, const char *conf,
         }
     }
 
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+    }
     g_free(buf);
     return ret;
 }
-- 
2.9.3
