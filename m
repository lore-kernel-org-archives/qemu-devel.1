Received: from eggs.gnu.org ([2001:4830:134:3::10]:39919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvK-0000DL-UT
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvJ-0008Nu-AM
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:56:01 +0200
Message-Id: <1490691368-32099-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 03/10] rbd: Don't limit length of
 parameter values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

We laboriously enforce that parameter values are between one and some
arbitrary limit in length.  Only RBD_MAX_IMAGE_NAME_SIZE comes from
librbd.h, and I'm not sure it applies.  Where the other limits come
from is unclear.

Drop the length checking.  The limits librbd actually imposes must be
checked by librbd anyway.

There's one minor complication: BDRVRBDState member name is a
fixed-size array.  Depends on the length limit.  Make it a pointer to
a dynamically allocated string.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
---
 block/rbd.c | 91 ++++++++++---------------------------------------------------
 1 file changed, 14 insertions(+), 77 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 5ba2a87..0fea348 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -56,11 +56,6 @@
 
 #define OBJ_MAX_SIZE (1UL << OBJ_DEFAULT_OBJ_ORDER)
 
-#define RBD_MAX_CONF_NAME_SIZE 128
-#define RBD_MAX_CONF_VAL_SIZE 512
-#define RBD_MAX_CONF_SIZE 1024
-#define RBD_MAX_POOL_NAME_SIZE 128
-#define RBD_MAX_SNAP_NAME_SIZE 128
 #define RBD_MAX_SNAPS 100
 
 /* The LIBRBD_SUPPORTS_IOVEC is defined in librbd.h */
@@ -99,16 +94,12 @@ typedef struct BDRVRBDState {
     rados_t cluster;
     rados_ioctx_t io_ctx;
     rbd_image_t image;
-    char name[RBD_MAX_IMAGE_NAME_SIZE];
+    char *name;
     char *snap;
 } BDRVRBDState;
 
-static char *qemu_rbd_next_tok(int max_len,
-                               char *src, char delim,
-                               const char *name,
-                               char **p, Error **errp)
+static char *qemu_rbd_next_tok(char *src, char delim, char **p)
 {
-    int l;
     char *end;
 
     *p = NULL;
@@ -127,15 +118,6 @@ static char *qemu_rbd_next_tok(int max_len,
             *end = '\0';
         }
     }
-    l = strlen(src);
-    if (l >= max_len) {
-        error_setg(errp, "%s too long", name);
-        return NULL;
-    } else if (l == 0) {
-        error_setg(errp, "%s too short", name);
-        return NULL;
-    }
-
     return src;
 }
 
@@ -159,7 +141,6 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
     char *p, *buf, *keypairs;
     char *found_str;
     size_t max_keypair_size;
-    Error *local_err = NULL;
 
     if (!strstart(filename, "rbd:", &start)) {
         error_setg(errp, "File name must start with 'rbd:'");
@@ -171,11 +152,7 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
     keypairs = g_malloc0(max_keypair_size);
     p = buf;
 
-    found_str = qemu_rbd_next_tok(RBD_MAX_POOL_NAME_SIZE, p,
-                                  '/', "pool name", &p, &local_err);
-    if (local_err) {
-        goto done;
-    }
+    found_str = qemu_rbd_next_tok(p, '/', &p);
     if (!p) {
         error_setg(errp, "Pool name is required");
         goto done;
@@ -184,27 +161,15 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
     qdict_put(options, "pool", qstring_from_str(found_str));
 
     if (strchr(p, '@')) {
-        found_str = qemu_rbd_next_tok(RBD_MAX_IMAGE_NAME_SIZE, p,
-                                      '@', "object name", &p, &local_err);
-        if (local_err) {
-            goto done;
-        }
+        found_str = qemu_rbd_next_tok(p, '@', &p);
         qemu_rbd_unescape(found_str);
         qdict_put(options, "image", qstring_from_str(found_str));
 
-        found_str = qemu_rbd_next_tok(RBD_MAX_SNAP_NAME_SIZE, p,
-                                      ':', "snap name", &p, &local_err);
-        if (local_err) {
-            goto done;
-        }
+        found_str = qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(found_str);
         qdict_put(options, "snapshot", qstring_from_str(found_str));
     } else {
-        found_str = qemu_rbd_next_tok(RBD_MAX_IMAGE_NAME_SIZE, p,
-                                      ':', "object name", &p, &local_err);
-        if (local_err) {
-            goto done;
-        }
+        found_str = qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(found_str);
         qdict_put(options, "image", qstring_from_str(found_str));
     }
@@ -212,11 +177,7 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
         goto done;
     }
 
-    found_str = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
-                                  '\0', "configuration", &p, &local_err);
-    if (local_err) {
-        goto done;
-    }
+    found_str = qemu_rbd_next_tok(p, '\0', &p);
 
     p = found_str;
 
@@ -224,12 +185,7 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
      * 'id' and 'conf' a bit special.  Key/value pairs may be in any order. */
     while (p) {
         char *name, *value;
-        name = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
-                                 '=', "conf option name", &p, &local_err);
-        if (local_err) {
-            break;
-        }
-
+        name = qemu_rbd_next_tok(p, '=', &p);
         if (!p) {
             error_setg(errp, "conf option %s has no value", name);
             break;
@@ -237,11 +193,7 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
 
         qemu_rbd_unescape(name);
 
-        value = qemu_rbd_next_tok(RBD_MAX_CONF_VAL_SIZE, p,
-                                  ':', "conf option value", &p, &local_err);
-        if (local_err) {
-            break;
-        }
+        value = qemu_rbd_next_tok(p, ':', &p);
         qemu_rbd_unescape(value);
 
         if (!strcmp(name, "conf")) {
@@ -274,9 +226,6 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
 
 
 done:
-    if (local_err) {
-        error_propagate(errp, local_err);
-    }
     g_free(buf);
     g_free(keypairs);
     return;
@@ -308,30 +257,20 @@ static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs,
     char *p, *buf;
     char *name;
     char *value;
-    Error *local_err = NULL;
     int ret = 0;
 
     buf = g_strdup(keypairs);
     p = buf;
 
     while (p) {
-        name = qemu_rbd_next_tok(RBD_MAX_CONF_NAME_SIZE, p,
-                                 '=', "conf option name", &p, &local_err);
-        if (local_err) {
-            break;
-        }
-
+        name = qemu_rbd_next_tok(p, '=', &p);
         if (!p) {
             error_setg(errp, "conf option %s has no value", name);
             ret = -EINVAL;
             break;
         }
 
-        value = qemu_rbd_next_tok(RBD_MAX_CONF_VAL_SIZE, p,
-                                  ':', "conf option value", &p, &local_err);
-        if (local_err) {
-            break;
-        }
+        value = qemu_rbd_next_tok(p, ':', &p);
 
         ret = rados_conf_set(cluster, name, value);
         if (ret < 0) {
@@ -341,10 +280,6 @@ static int qemu_rbd_set_keypairs(rados_t cluster, const char *keypairs,
         }
     }
 
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-    }
     g_free(buf);
     return ret;
 }
@@ -724,7 +659,7 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->snap = g_strdup(snap);
-    pstrcpy(s->name, RBD_MAX_IMAGE_NAME_SIZE, name);
+    s->name = g_strdup(name);
 
     /* try default location when conf=NULL, but ignore failure */
     r = rados_conf_read_file(s->cluster, conf);
@@ -798,6 +733,7 @@ failed_open:
 failed_shutdown:
     rados_shutdown(s->cluster);
     g_free(s->snap);
+    g_free(s->name);
 failed_opts:
     qemu_opts_del(opts);
     g_free(mon_host);
@@ -812,6 +748,7 @@ static void qemu_rbd_close(BlockDriverState *bs)
     rbd_close(s->image);
     rados_ioctx_destroy(s->io_ctx);
     g_free(s->snap);
+    g_free(s->name);
     rados_shutdown(s->cluster);
 }
 
-- 
2.7.4
