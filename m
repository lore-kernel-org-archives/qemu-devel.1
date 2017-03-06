Received: from eggs.gnu.org ([2001:4830:134:3::10]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsT-00049F-VA
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsS-0004lh-AS
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:41 +0100
Message-Id: <1488826849-32384-8-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/15] sheepdog: Report errors in
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

Errors in the pseudo-filename are all reported with the same laconic
"Can't parse filename" message.

Add real error reporting, such as:

    $ qemu-system-x86_64 --drive driver=3Dsheepdog,filename=3Dsheepdog://=
/
    qemu-system-x86_64: --drive driver=3Dsheepdog,filename=3Dsheepdog:///=
: missing file path in URI
    $ qemu-system-x86_64 --drive driver=3Dsheepdog,filename=3Dsheepgod://=
/vdi
    qemu-system-x86_64: --drive driver=3Dsheepdog,filename=3Dsheepgod:///=
vdi: URI scheme must be 'sheepdog', 'sheepdog+tcp', or 'sheepdog+unix'
    $ qemu-system-x86_64 --drive driver=3Dsheepdog,filename=3Dsheepdog+un=
ix:///vdi?socke=3Dsheepdog.sock
    qemu-system-x86_64: --drive driver=3Dsheepdog,filename=3Dsheepdog+uni=
x:///vdi?socke=3Dsheepdog.sock: unexpected query parameters

The code to translate legacy syntax to URI fails to escape URI
meta-characters.  The new error messages are misleading then.  Replace
them by the old "Can't parse filename" message.  "Internal error"
would be more honest.  Anyway, no worse than before.  Also add a FIXME
comment.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 88 +++++++++++++++++++++++++++++++++++++-------------=
------
 1 file changed, 59 insertions(+), 29 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index fed7264..161932d 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -957,16 +957,18 @@ static bool sd_parse_snapid_or_tag(const char *str,
     return true;
 }
=20
-static int sd_parse_uri(BDRVSheepdogState *s, const char *filename,
-                        char *vdi, uint32_t *snapid, char *tag)
+static void sd_parse_uri(BDRVSheepdogState *s, const char *filename,
+                         char *vdi, uint32_t *snapid, char *tag,
+                         Error **errp)
 {
+    Error *err =3D NULL;
     URI *uri;
     QueryParams *qp =3D NULL;
-    int ret =3D 0;
=20
     uri =3D uri_parse(filename);
     if (!uri) {
-        return -EINVAL;
+        error_setg(&err, "invalid URI");
+        goto out;
     }
=20
     /* transport */
@@ -977,34 +979,46 @@ static int sd_parse_uri(BDRVSheepdogState *s, const=
 char *filename,
     } else if (!strcmp(uri->scheme, "sheepdog+unix")) {
         s->is_unix =3D true;
     } else {
-        ret =3D -EINVAL;
+        error_setg(&err, "URI scheme must be 'sheepdog', 'sheepdog+tcp',=
"
+                   " or 'sheepdog+unix'");
         goto out;
     }
=20
     if (uri->path =3D=3D NULL || !strcmp(uri->path, "/")) {
-        ret =3D -EINVAL;
+        error_setg(&err, "missing file path in URI");
         goto out;
     }
     if (g_strlcpy(vdi, uri->path + 1, SD_MAX_VDI_LEN) >=3D SD_MAX_VDI_LE=
N) {
-        ret =3D -EINVAL;
+        error_setg(&err, "VDI name is too long");
         goto out;
     }
=20
     qp =3D query_params_parse(uri->query);
-    if (qp->n > 1 || (s->is_unix && !qp->n) || (!s->is_unix && qp->n)) {
-        ret =3D -EINVAL;
-        goto out;
-    }
=20
     if (s->is_unix) {
         /* sheepdog+unix:///vdiname?socket=3Dpath */
-        if (uri->server || uri->port || strcmp(qp->p[0].name, "socket"))=
 {
-            ret =3D -EINVAL;
+        if (uri->server || uri->port) {
+            error_setg(&err, "URI scheme %s doesn't accept a server addr=
ess",
+                       uri->scheme);
+            goto out;
+        }
+        if (!qp->n) {
+            error_setg(&err,
+                       "URI scheme %s requires query parameter 'socket'"=
,
+                       uri->scheme);
+            goto out;
+        }
+        if (qp->n !=3D 1 || strcmp(qp->p[0].name, "socket")) {
+            error_setg(&err, "unexpected query parameters");
             goto out;
         }
         s->host_spec =3D g_strdup(qp->p[0].value);
     } else {
         /* sheepdog[+tcp]://[host:port]/vdiname */
+        if (qp->n) {
+            error_setg(&err, "unexpected query parameters");
+            goto out;
+        }
         s->host_spec =3D g_strdup_printf("%s:%d", uri->server ?: SD_DEFA=
ULT_ADDR,
                                        uri->port ?: SD_DEFAULT_PORT);
     }
@@ -1012,7 +1026,8 @@ static int sd_parse_uri(BDRVSheepdogState *s, const=
 char *filename,
     /* snapshot tag */
     if (uri->fragment) {
         if (!sd_parse_snapid_or_tag(uri->fragment, snapid, tag)) {
-            ret =3D -EINVAL;
+            error_setg(&err, "'%s' is not a valid snapshot ID",
+                       uri->fragment);
             goto out;
         }
     } else {
@@ -1020,11 +1035,11 @@ static int sd_parse_uri(BDRVSheepdogState *s, con=
st char *filename,
     }
=20
 out:
+    error_propagate(errp, err);
     if (qp) {
         query_params_free(qp);
     }
     uri_free(uri);
-    return ret;
 }
=20
 /*
@@ -1044,12 +1059,14 @@ out:
  * You can run VMs outside the Sheepdog cluster by specifying
  * `hostname' and `port' (experimental).
  */
-static int parse_vdiname(BDRVSheepdogState *s, const char *filename,
-                         char *vdi, uint32_t *snapid, char *tag)
+static void parse_vdiname(BDRVSheepdogState *s, const char *filename,
+                          char *vdi, uint32_t *snapid, char *tag,
+                          Error **errp)
 {
+    Error *err =3D NULL;
     char *p, *q, *uri;
     const char *host_spec, *vdi_spec;
-    int nr_sep, ret;
+    int nr_sep;
=20
     strstart(filename, "sheepdog:", &filename);
     p =3D q =3D g_strdup(filename);
@@ -1084,12 +1101,23 @@ static int parse_vdiname(BDRVSheepdogState *s, co=
nst char *filename,
=20
     uri =3D g_strdup_printf("sheepdog://%s/%s", host_spec, vdi_spec);
=20
-    ret =3D sd_parse_uri(s, uri, vdi, snapid, tag);
+    /*
+     * FIXME We to escape URI meta-characters, e.g. "x?y=3Dz"
+     * produces "sheepdog://x?y=3Dz".  Because of that ...
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
=20
     g_free(q);
     g_free(uri);
-
-    return ret;
 }
=20
 static int find_vdi_name(BDRVSheepdogState *s, const char *filename,
@@ -1452,12 +1480,13 @@ static int sd_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     memset(tag, 0, sizeof(tag));
=20
     if (strstr(filename, "://")) {
-        ret =3D sd_parse_uri(s, filename, vdi, &snapid, tag);
+        sd_parse_uri(s, filename, vdi, &snapid, tag, &local_err);
     } else {
-        ret =3D parse_vdiname(s, filename, vdi, &snapid, tag);
+        parse_vdiname(s, filename, vdi, &snapid, tag, &local_err);
     }
-    if (ret < 0) {
-        error_setg(errp, "Can't parse filename");
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret =3D -EINVAL;
         goto err_no_fd;
     }
     s->fd =3D get_sheep_fd(s, errp);
@@ -1785,6 +1814,7 @@ static int parse_block_size_shift(BDRVSheepdogState=
 *s, QemuOpts *opt)
 static int sd_create(const char *filename, QemuOpts *opts,
                      Error **errp)
 {
+    Error *err =3D NULL;
     int ret =3D 0;
     uint32_t vid =3D 0;
     char *backing_file =3D NULL;
@@ -1799,12 +1829,12 @@ static int sd_create(const char *filename, QemuOp=
ts *opts,
=20
     memset(tag, 0, sizeof(tag));
     if (strstr(filename, "://")) {
-        ret =3D sd_parse_uri(s, filename, s->name, &snapid, tag);
+        sd_parse_uri(s, filename, s->name, &snapid, tag, &err);
     } else {
-        ret =3D parse_vdiname(s, filename, s->name, &snapid, tag);
+        parse_vdiname(s, filename, s->name, &snapid, tag, &err);
     }
-    if (ret < 0) {
-        error_setg(errp, "Can't parse filename");
+    if (err) {
+        error_propagate(errp, err);
         goto out;
     }
=20
--=20
2.7.4
