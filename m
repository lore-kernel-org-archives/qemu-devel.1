Received: from eggs.gnu.org ([2001:4830:134:3::10]:35180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWI-0005Zr-AH
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWG-0002sJ-R5
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:18 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:58 +0100
Message-Id: <1488491046-2549-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1488491046-2549-1-git-send-email-armbru@redhat.com>
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 07/15] sheepdog: Report errors in
 pseudo-filename more usefully
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Errors in the pseudo-filename are all reported with the same laconic
"Can't parse filename" message.

Add real error reporting, such as:

    $ qemu-system-x86_64 --drive driver=sheepdog,filename=sheepdog:///
    qemu-system-x86_64: --drive driver=sheepdog,filename=sheepdog:///: missing file path in URI
    $ qemu-system-x86_64 --drive driver=sheepdog,filename=sheepgod:///vdi
    qemu-system-x86_64: --drive driver=sheepdog,filename=sheepgod:///vdi: URI scheme must be 'sheepdog', 'sheepdog+tcp', or 'sheepdog+unix'
    $ qemu-system-x86_64 --drive driver=sheepdog,filename=sheepdog+unix:///vdi?socke=sheepdog.sock
    qemu-system-x86_64: --drive driver=sheepdog,filename=sheepdog+unix:///vdi?socke=sheepdog.sock: unexpected query parameters

The code to translate legacy syntax to URI fails to escape URI
meta-characters.  The new error messages are misleading then.  Replace
them by the old "Can't parse filename" message.  "Internal error"
would be more honest.  Anyway, no worse than before.  Also add a FIXME
comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/sheepdog.c | 86 ++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 72a52a6..ac62225 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -957,16 +957,18 @@ static bool sd_parse_snapid_or_tag(const char *str,
     return true;
 }
 
-static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
-                        char *vdi, uint32_t *snapid, char *tag)
+static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
+                         char *vdi, uint32_t *snapid, char *tag,
+                         Error **errp)
 {
+    Error *err = NULL;
     URI *uri;
     QueryParams *qp = NULL;
-    int ret = 0;
 
     uri = uri_parse(filename);
     if (!uri) {
-        return -EINVAL;
+        error_setg(&err, "invalid URI");
+        goto out;
     }
 
     /* transport */
@@ -977,33 +979,46 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
     } else if (!strcmp(uri->scheme, "sheepdog+unix")) {
         s->is_unix = true;
     } else {
-        ret = -EINVAL;
+        error_setg(&err, "URI scheme must be 'sheepdog', 'sheepdog+tcp',"
+                   " or 'sheepdog+unix'");
         goto out;
     }
 
     if (uri->path == NULL || !strcmp(uri->path, "/")) {
-        ret = -EINVAL;
+        error_setg(&err, "missing file path in URI");
         goto out;
     }
     if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >= SD_MAX_VDI_LEN) {
+        error_setg(&err, "VDI name is too long");
         goto out;
     }
 
     qp = query_params_parse(uri->query);
-    if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n)) {
-        ret = -EINVAL;
-        goto out;
-    }
 
     if (s->is_unix) {
         /* sheepdog+unix:///vdiname?socket=path */
-        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket")) {
-            ret = -EINVAL;
+        if (uri->server || uri->port) {
+            error_setg(&err, "URI scheme %s doesn't accept a server address",
+                       uri->scheme);
+            goto out;
+        }
+        if (!qp->n) {
+            error_setg(&err,
+                       "URI scheme %s requires query parameter 'socket'",
+                       uri->scheme);
+            goto out;
+        }
+        if (qp->n != 1 || strcmp(qp->p[0].name, "socket")) {
+            error_setg(&err, "unexpected query parameters");
             goto out;
         }
         s->host_spec = g_strdup(qp->p[0].value);
     } else {
         /* sheepdog[+tcp]://[host:port]/vdiname */
+        if (qp->n) {
+            error_setg(&err, "unexpected query parameters");
+            goto out;
+        }
         s->host_spec = g_strdup_printf("%s:%d", uri->server ?: SD_DEFAULT_ADDR,
                                        uri->port ?: SD_DEFAULT_PORT);
     }
@@ -1011,7 +1026,8 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
     /* snapshot tag */
     if (uri->fragment) {
         if (!sd_parse_snapid_or_tag(uri->fragment, snapid, tag)) {
-            ret = -EINVAL;
+            error_setg(&err, "'%s' is not a valid snapshot ID",
+                       uri->fragment);
             goto out;
         }
     } else {
@@ -1019,11 +1035,11 @@ static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
     }
 
 out:
+    error_propagate(errp, err);
     if (qp) {
         query_params_free(qp);
     }
     uri_free(uri);
-    return ret;
 }
 
 /*
@@ -1043,12 +1059,14 @@ out:
  * You can run VMs outside the Sheepdog cluster by specifying
  * `hostname' and `port' (experimental).
  */
-static int parse_vdiname(BDRVSheepdogState *s, const char *filename,
-                         char *vdi, uint32_t *snapid, char *tag)
+static void parse_vdiname(BDRVSheepdogState *s, const char *filename,
+                          char *vdi, uint32_t *snapid, char *tag,
+                          Error **errp)
 {
+    Error *err = NULL;
     char *p, *q, *uri;
     const char *host_spec, *vdi_spec;
-    int nr_sep, ret;
+    int nr_sep;
 
     strstart(filename, "sheepdog:", &filename);
     p = q = g_strdup(filename);
@@ -1083,12 +1101,23 @@ static int parse_vdiname(BDRVSheepdogState *s, const char *filename,
 
     uri = g_strdup_printf("sheepdog://%s/%s", host_spec, vdi_spec);
 
-    ret = sd_parse_uri(s, uri, vdi, snapid, tag);
+    /*
+     * FIXME We to escape URI meta-characters, e.g. "x?y=z"
+     * produces "sheepdog://x?y=z".  Because of that ...
+     */
+    sd_parse_uri(s, uri, vdi, snapid, tag, &err);
+    if (err) {
+        /*
+         * ... this can fail, but the error message is misleading.
+         * Replace it by the traditional useless one until the
+         * escaping is fixed.
+         */
+        error_free(err);
+        error_setg(errp, "Can't parse filename");
+    }
 
     g_free(q);
     g_free(uri);
-
-    return ret;
 }
 
 static int find_vdi_name(BDRVSheepdogState *s, const char *filename,
@@ -1451,12 +1480,12 @@ static int sd_open(BlockDriverState *bs, QDict *options, int flags,
     memset(tag, 0, sizeof(tag));
 
     if (strstr(filename, "://")) {
-        ret = sd_parse_uri(s, filename, vdi, &snapid, tag);
+        sd_parse_uri(s, filename, vdi, &snapid, tag, &local_err);
     } else {
-        ret = parse_vdiname(s, filename, vdi, &snapid, tag);
+        parse_vdiname(s, filename, vdi, &snapid, tag, &local_err);
     }
-    if (ret < 0) {
-        error_setg(errp, "Can't parse filename");
+    if (local_err) {
+        error_propagate(errp, local_err);
         goto out_no_fd;
     }
     s->fd = get_sheep_fd(s, errp);
@@ -1785,6 +1814,7 @@ static int parse_block_size_shift(BDRVSheepdogState *s, QemuOpts *opt)
 static int sd_create(const char *filename, QemuOpts *opts,
                      Error **errp)
 {
+    Error *err = NULL;
     int ret = 0;
     uint32_t vid = 0;
     char *backing_file = NULL;
@@ -1799,12 +1829,12 @@ static int sd_create(const char *filename, QemuOpts *opts,
 
     memset(tag, 0, sizeof(tag));
     if (strstr(filename, "://")) {
-        ret = sd_parse_uri(s, filename, s->name, &snapid, tag);
+        sd_parse_uri(s, filename, s->name, &snapid, tag, &err);
     } else {
-        ret = parse_vdiname(s, filename, s->name, &snapid, tag);
+        parse_vdiname(s, filename, s->name, &snapid, tag, &err);
     }
-    if (ret < 0) {
-        error_setg(errp, "Can't parse filename");
+    if (err) {
+        error_propagate(errp, err);
         goto out;
     }
 
-- 
2.7.4
