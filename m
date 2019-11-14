Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5741C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82F9206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 02:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ln1bPMDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E82F9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV5DY-0000aj-Oh
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 21:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV59p-0005KZ-Fx
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV59n-00036l-8V
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33234
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV59l-000347-IQ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 21:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573699608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ejgj3ctoRrU510Bgyle5Nj4SZCJcecSgiTyzrjpIQ0c=;
 b=Ln1bPMDDgRZ4gmrKGqufbEri43jAwbftOlRJK0VxTWFclGv+0c9ftRYWmf5cLeE3ZBP9Lc
 I0WCdOX6palNR3oIvPIzcmQ/pfbOh+9xwLXoABnQAzVfPBWyPesOfFuWTqrto/+2qFciTj
 8x+3/VxZ+lefdNlzfesOiS2yUMiqBjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-WWE7Uw4NPQOrKzbGBZqK0g-1; Wed, 13 Nov 2019 21:46:45 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D8E11802CE0;
 Thu, 14 Nov 2019 02:46:44 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CAD181759;
 Thu, 14 Nov 2019 02:46:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] nbd: Don't send oversize strings
Date: Wed, 13 Nov 2019 20:46:34 -0600
Message-Id: <20191114024635.11363-4-eblake@redhat.com>
In-Reply-To: <20191114024635.11363-1-eblake@redhat.com>
References: <20191114024635.11363-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WWE7Uw4NPQOrKzbGBZqK0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Qemu as server currently won't accept export names larger than 256
bytes, nor create dirty bitmap names longer than 1023 bytes, so most
uses of qemu as client or server have no reason to get anywhere near
the NBD spec maximum of a 4k limit per string.

However, we weren't actually enforcing things, ignoring when the
remote side violates the protocol on input, and also having several
code paths where we send oversize strings on output (for example,
qemu-nbd --description could easily send more than 4k).  Tighten
things up as follows:

client:
- Perform bounds check on export name and dirty bitmap request prior
  to handing it to server
- Validate that copied server replies are not too long (ignoring
  NBD_INFO_* replies that are not copied is not too bad)
server:
- Perform bounds check on export name and description prior to
  advertising it to client
- Reject client name or metadata query that is too long
- Adjust things to allow full 4k name limit rather than previous
  256 byte limit

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  8 ++++----
 block/nbd.c         | 10 ++++++++++
 blockdev-nbd.c      |  5 +++++
 nbd/client.c        | 18 +++++++++++++++---
 nbd/server.c        | 20 +++++++++++++++-----
 qemu-nbd.c          |  9 +++++++++
 6 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index c306423dc85c..7f46932d80f1 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -227,11 +227,11 @@ enum {
 #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)

 /*
- * Maximum size of an export name. The NBD spec requires a minimum of
- * 256 and recommends that servers support up to 4096; all users use
- * malloc so we can bump this constant without worry.
+ * Maximum size of a protocol string (export name, meta context name,
+ * etc.).  Use malloc rather than stack allocation for storage of a
+ * string.
  */
-#define NBD_MAX_NAME_SIZE 256
+#define NBD_MAX_STRING_SIZE 4096

 /* Two types of reply structures */
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
diff --git a/block/nbd.c b/block/nbd.c
index 123976171cf4..5f18f78a9471 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1832,6 +1832,10 @@ static int nbd_process_options(BlockDriverState *bs,=
 QDict *options,
     }

     s->export =3D g_strdup(qemu_opt_get(opts, "export"));
+    if (s->export && strlen(s->export) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "export name too long to send to server");
+        goto error;
+    }

     s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
     if (s->tlscredsid) {
@@ -1849,6 +1853,11 @@ static int nbd_process_options(BlockDriverState *bs,=
 QDict *options,
     }

     s->x_dirty_bitmap =3D g_strdup(qemu_opt_get(opts, "x-dirty-bitmap"));
+    if (s->x_dirty_bitmap && strlen(s->x_dirty_bitmap) > NBD_MAX_STRING_SI=
ZE) {
+        error_setg(errp, "x-dirty-bitmap query too long to send to server"=
);
+        goto error;
+    }
+
     s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay", 0)=
;

     ret =3D 0;
@@ -1859,6 +1868,7 @@ static int nbd_process_options(BlockDriverState *bs, =
QDict *options,
         qapi_free_SocketAddress(s->saddr);
         g_free(s->export);
         g_free(s->tlscredsid);
+        g_free(s->x_dirty_bitmap);
     }
     qemu_opts_del(opts);
     return ret;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 6a8b206e1d74..8c20baa4a4b9 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -162,6 +162,11 @@ void qmp_nbd_server_add(const char *device, bool has_n=
ame, const char *name,
         name =3D device;
     }

+    if (strlen(name) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "export name '%s' too long", name);
+        return;
+    }
+
     if (nbd_export_find(name)) {
         error_setg(errp, "NBD server already has export named '%s'", name)=
;
         return;
diff --git a/nbd/client.c b/nbd/client.c
index f6733962b49b..ba173108baab 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -289,8 +289,8 @@ static int nbd_receive_list(QIOChannel *ioc, char **nam=
e, char **description,
         return -1;
     }
     len -=3D sizeof(namelen);
-    if (len < namelen) {
-        error_setg(errp, "incorrect option name length");
+    if (len < namelen || namelen > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "incorrect name length in server's list response"=
);
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -303,6 +303,12 @@ static int nbd_receive_list(QIOChannel *ioc, char **na=
me, char **description,
     local_name[namelen] =3D '\0';
     len -=3D namelen;
     if (len) {
+        if (len > NBD_MAX_STRING_SIZE) {
+            error_setg(errp, "incorrect description length in server's "
+                       "list response");
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
         local_desc =3D g_malloc(len + 1);
         if (nbd_read(ioc, local_desc, len, "export description", errp) < 0=
) {
             nbd_send_opt_abort(ioc);
@@ -479,6 +485,10 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_=
t opt,
             break;

         default:
+            /*
+             * Not worth the bother to check if NBD_INFO_NAME or
+             * NBD_INFO_DESCRIPTION exceed NBD_MAX_STRING_SIZE.
+             */
             trace_nbd_opt_info_unknown(type, nbd_info_lookup(type));
             if (nbd_drop(ioc, len, errp) < 0) {
                 error_prepend(errp, "Failed to read info payload: ");
@@ -645,9 +655,11 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint32=
_t opt,
     char *p;

     data_len =3D sizeof(export_len) + export_len + sizeof(queries);
+    assert(export_len <=3D NBD_MAX_STRING_SIZE);
     if (query) {
         query_len =3D strlen(query);
         data_len +=3D sizeof(query_len) + query_len;
+        assert(query_len <=3D NBD_MAX_STRING_SIZE);
     } else {
         assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
     }
@@ -1009,7 +1021,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QI=
OChannel *ioc,
     bool zeroes;
     bool base_allocation =3D info->base_allocation;

-    assert(info->name);
+    assert(info->name && strlen(info->name) <=3D NBD_MAX_STRING_SIZE);
     trace_nbd_receive_negotiate_name(info->name);

     result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname, o=
utioc,
diff --git a/nbd/server.c b/nbd/server.c
index c63b76b22735..d28123c562be 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -321,7 +321,7 @@ static int nbd_opt_skip(NBDClient *client, size_t size,=
 Error **errp)
 /* nbd_opt_read_name
  *
  * Read a string with the format:
- *   uint32_t len     (<=3D NBD_MAX_NAME_SIZE)
+ *   uint32_t len     (<=3D NBD_MAX_STRING_SIZE)
  *   len bytes string (not 0-terminated)
  *
  * On success, @name will be allocated.
@@ -344,7 +344,7 @@ static int nbd_opt_read_name(NBDClient *client, char **=
name, uint32_t *length,
     }
     len =3D cpu_to_be32(len);

-    if (len > NBD_MAX_NAME_SIZE) {
+    if (len > NBD_MAX_STRING_SIZE) {
         return nbd_opt_invalid(client, errp,
                                "Invalid name length: %" PRIu32, len);
     }
@@ -379,6 +379,7 @@ static int nbd_negotiate_send_rep_list(NBDClient *clien=
t, NBDExport *exp,
     trace_nbd_negotiate_send_rep_list(name, desc);
     name_len =3D strlen(name);
     desc_len =3D strlen(desc);
+    assert(name_len <=3D NBD_MAX_STRING_SIZE && desc_len <=3D NBD_MAX_STRI=
NG_SIZE);
     len =3D name_len + desc_len + sizeof(len);
     ret =3D nbd_negotiate_send_rep_len(client, NBD_REP_SERVER, len, errp);
     if (ret < 0) {
@@ -445,7 +446,7 @@ static int nbd_negotiate_handle_export_name(NBDClient *=
client, bool no_zeroes,
         [10 .. 133]   reserved     (0) [unless no_zeroes]
      */
     trace_nbd_negotiate_handle_export_name();
-    if (client->optlen > NBD_MAX_NAME_SIZE) {
+    if (client->optlen > NBD_MAX_STRING_SIZE) {
         error_setg(errp, "Bad length received");
         return -EINVAL;
     }
@@ -613,6 +614,7 @@ static int nbd_negotiate_handle_info(NBDClient *client,=
 Error **errp)
     if (exp->description) {
         size_t len =3D strlen(exp->description);

+        assert(len <=3D NBD_MAX_STRING_SIZE);
         rc =3D nbd_negotiate_send_info(client, NBD_INFO_DESCRIPTION,
                                      len, exp->description, errp);
         if (rc < 0) {
@@ -757,6 +759,7 @@ static int nbd_negotiate_send_meta_context(NBDClient *c=
lient,
         {.iov_base =3D (void *)context, .iov_len =3D strlen(context)}
     };

+    assert(iov[1].iov_len <=3D NBD_MAX_STRING_SIZE);
     if (client->opt =3D=3D NBD_OPT_LIST_META_CONTEXT) {
         context_id =3D 0;
     }
@@ -905,7 +908,7 @@ static int nbd_meta_qemu_query(NBDClient *client, NBDEx=
portMetaContexts *meta,
  * Parse namespace name and call corresponding function to parse body of t=
he
  * query.
  *
- * The only supported namespace now is 'base'.
+ * The only supported namespaces are 'base' and 'qemu'.
  *
  * The function aims not wasting time and memory to read long unknown name=
space
  * names.
@@ -931,6 +934,10 @@ static int nbd_negotiate_meta_query(NBDClient *client,
     }
     len =3D cpu_to_be32(len);

+    if (len > NBD_MAX_STRING_SIZE) {
+        trace_nbd_negotiate_meta_query_skip("length too long");
+        return nbd_opt_skip(client, len, errp);
+    }
     if (len < ns_len) {
         trace_nbd_negotiate_meta_query_skip("length too short");
         return nbd_opt_skip(client, len, errp);
@@ -1492,7 +1499,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint6=
4_t dev_offset,
      * access since the export could be available before migration handove=
r.
      * ctx was acquired in the caller.
      */
-    assert(name);
+    assert(name && strlen(name) <=3D NBD_MAX_STRING_SIZE);
     ctx =3D bdrv_get_aio_context(bs);
     bdrv_invalidate_cache(bs, NULL);

@@ -1518,6 +1525,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint6=
4_t dev_offset,
     assert(dev_offset <=3D INT64_MAX);
     exp->dev_offset =3D dev_offset;
     exp->name =3D g_strdup(name);
+    assert(!desc || strlen(desc) <=3D NBD_MAX_STRING_SIZE);
     exp->description =3D g_strdup(desc);
     exp->nbdflags =3D (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_FLUSH |
                      NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
@@ -1564,8 +1572,10 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uint=
64_t dev_offset,

         bdrv_dirty_bitmap_set_busy(bm, true);
         exp->export_bitmap =3D bm;
+        assert(strlen(bitmap) <=3D BDRV_BITMAP_MAX_NAME_SIZE);
         exp->export_bitmap_context =3D g_strdup_printf("qemu:dirty-bitmap:=
%s",
                                                      bitmap);
+        assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }

     exp->close =3D close;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index caacf0ed7379..108a51f7eb01 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -833,9 +833,18 @@ int main(int argc, char **argv)
             break;
         case 'x':
             export_name =3D optarg;
+            if (strlen(export_name) > NBD_MAX_STRING_SIZE) {
+                error_report("export name '%s' too long", export_name);
+                exit(EXIT_FAILURE);
+            }
             break;
         case 'D':
             export_description =3D optarg;
+            if (strlen(export_description) > NBD_MAX_STRING_SIZE) {
+                error_report("export description '%s' too long",
+                             export_description);
+                exit(EXIT_FAILURE);
+            }
             break;
         case 'v':
             verbose =3D 1;
--=20
2.21.0


