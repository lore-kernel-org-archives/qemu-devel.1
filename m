Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BACC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 21:04:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F972067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 21:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F972067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIfbs-0006tc-L7
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iIfY5-0004ol-K4
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 17:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iIfY3-0007HL-Hd
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 17:00:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iIfXr-0007D1-IF; Thu, 10 Oct 2019 17:00:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E05D52BF73;
 Thu, 10 Oct 2019 21:00:20 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5738460600;
 Thu, 10 Oct 2019 21:00:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] nbd: Don't send oversize strings
Date: Thu, 10 Oct 2019 16:00:17 -0500
Message-Id: <20191010210018.22000-2-eblake@redhat.com>
In-Reply-To: <20191010210018.22000-1-eblake@redhat.com>
References: <20191010210018.22000-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 10 Oct 2019 21:00:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, mlevitsk@redhat.com
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

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 include/block/nbd.h |  1 +
 block/nbd.c         |  9 +++++++++
 blockdev-nbd.c      |  5 +++++
 nbd/client.c        | 16 +++++++++++++---
 nbd/server.c        | 14 ++++++++++++--
 qemu-nbd.c          |  9 +++++++++
 6 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 316fd705a9e4..fcabdf0f37c3 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -232,6 +232,7 @@ enum {
  * going larger would require an audit of more code to make sure we
  * aren't overflowing some other buffer. */
 #define NBD_MAX_NAME_SIZE 256
+#define NBD_MAX_STRING_SIZE 4096

 /* Two types of reply structures */
 #define NBD_SIMPLE_REPLY_MAGIC      0x67446698
diff --git a/block/nbd.c b/block/nbd.c
index 813c40d8f067..76eb1dbe04df 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1621,6 +1621,10 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
     }

     s->export =3D g_strdup(qemu_opt_get(opts, "export"));
+    if (s->export && strlen(s->export) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "export name too long to send to server");
+        goto error;
+    }

     s->tlscredsid =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
     if (s->tlscredsid) {
@@ -1638,6 +1642,11 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
     }

     s->x_dirty_bitmap =3D g_strdup(qemu_opt_get(opts, "x-dirty-bitmap"))=
;
+    if (s->x_dirty_bitmap && strlen(s->x_dirty_bitmap) > NBD_MAX_STRING_=
SIZE) {
+        error_setg(errp, "x_dirty_bitmap query too long to send to serve=
r");
+        goto error;
+    }
+
     s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay", =
0);

     ret =3D 0;
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 6a8b206e1d74..8c20baa4a4b9 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -162,6 +162,11 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
         name =3D device;
     }

+    if (strlen(name) > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "export name '%s' too long", name);
+        return;
+    }
+
     if (nbd_export_find(name)) {
         error_setg(errp, "NBD server already has export named '%s'", nam=
e);
         return;
diff --git a/nbd/client.c b/nbd/client.c
index f6733962b49b..d6e29daced63 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -289,8 +289,8 @@ static int nbd_receive_list(QIOChannel *ioc, char **n=
ame, char **description,
         return -1;
     }
     len -=3D sizeof(namelen);
-    if (len < namelen) {
-        error_setg(errp, "incorrect option name length");
+    if (len < namelen || namelen > NBD_MAX_STRING_SIZE) {
+        error_setg(errp, "incorrect list name length");
         nbd_send_opt_abort(ioc);
         return -1;
     }
@@ -303,6 +303,11 @@ static int nbd_receive_list(QIOChannel *ioc, char **=
name, char **description,
     local_name[namelen] =3D '\0';
     len -=3D namelen;
     if (len) {
+        if (len > NBD_MAX_STRING_SIZE) {
+            error_setg(errp, "incorrect list description length");
+            nbd_send_opt_abort(ioc);
+            return -1;
+        }
         local_desc =3D g_malloc(len + 1);
         if (nbd_read(ioc, local_desc, len, "export description", errp) <=
 0) {
             nbd_send_opt_abort(ioc);
@@ -479,6 +484,10 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint3=
2_t opt,
             break;

         default:
+            /*
+             * Not worth the bother to check if NBD_INFO_NAME or
+             * NBD_INFO_DESCRIPTION exceed NBD_MAX_STRING_SIZE.
+             */
             trace_nbd_opt_info_unknown(type, nbd_info_lookup(type));
             if (nbd_drop(ioc, len, errp) < 0) {
                 error_prepend(errp, "Failed to read info payload: ");
@@ -648,6 +657,7 @@ static int nbd_send_meta_query(QIOChannel *ioc, uint3=
2_t opt,
     if (query) {
         query_len =3D strlen(query);
         data_len +=3D sizeof(query_len) + query_len;
+        assert(query_len <=3D NBD_MAX_STRING_SIZE);
     } else {
         assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
     }
@@ -1009,7 +1019,7 @@ int nbd_receive_negotiate(AioContext *aio_context, =
QIOChannel *ioc,
     bool zeroes;
     bool base_allocation =3D info->base_allocation;

-    assert(info->name);
+    assert(info->name && strlen(info->name) <=3D NBD_MAX_STRING_SIZE);
     trace_nbd_receive_negotiate_name(info->name);

     result =3D nbd_start_negotiate(aio_context, ioc, tlscreds, hostname,=
 outioc,
diff --git a/nbd/server.c b/nbd/server.c
index d8d1e6245532..dfbefd5a1ebc 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -375,6 +375,7 @@ static int nbd_negotiate_send_rep_list(NBDClient *cli=
ent, NBDExport *exp,
     trace_nbd_negotiate_send_rep_list(name, desc);
     name_len =3D strlen(name);
     desc_len =3D strlen(desc);
+    assert(name_len <=3D NBD_MAX_STRING_SIZE && desc_len <=3D NBD_MAX_ST=
RING_SIZE);
     len =3D name_len + desc_len + sizeof(len);
     ret =3D nbd_negotiate_send_rep_len(client, NBD_REP_SERVER, len, errp=
);
     if (ret < 0) {
@@ -608,6 +609,7 @@ static int nbd_negotiate_handle_info(NBDClient *clien=
t, Error **errp)
     if (exp->description) {
         size_t len =3D strlen(exp->description);

+        assert(len <=3D NBD_MAX_STRING_SIZE);
         rc =3D nbd_negotiate_send_info(client, NBD_INFO_DESCRIPTION,
                                      len, exp->description, errp);
         if (rc < 0) {
@@ -752,6 +754,7 @@ static int nbd_negotiate_send_meta_context(NBDClient =
*client,
         {.iov_base =3D (void *)context, .iov_len =3D strlen(context)}
     };

+    assert(iov[1].iov_len <=3D NBD_MAX_STRING_SIZE);
     if (client->opt =3D=3D NBD_OPT_LIST_META_CONTEXT) {
         context_id =3D 0;
     }
@@ -900,7 +903,7 @@ static int nbd_meta_qemu_query(NBDClient *client, NBD=
ExportMetaContexts *meta,
  * Parse namespace name and call corresponding function to parse body of=
 the
  * query.
  *
- * The only supported namespace now is 'base'.
+ * The only supported namespaces are 'base' and 'qemu'.
  *
  * The function aims not wasting time and memory to read long unknown na=
mespace
  * names.
@@ -926,6 +929,10 @@ static int nbd_negotiate_meta_query(NBDClient *clien=
t,
     }
     len =3D cpu_to_be32(len);

+    if (len > NBD_MAX_STRING_SIZE) {
+        trace_nbd_negotiate_meta_query_skip("length too long");
+        return nbd_opt_skip(client, len, errp);
+    }
     if (len < ns_len) {
         trace_nbd_negotiate_meta_query_skip("length too short");
         return nbd_opt_skip(client, len, errp);
@@ -1487,7 +1494,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
      * access since the export could be available before migration hando=
ver.
      * ctx was acquired in the caller.
      */
-    assert(name);
+    assert(name && strlen(name) <=3D NBD_MAX_STRING_SIZE);
     ctx =3D bdrv_get_aio_context(bs);
     bdrv_invalidate_cache(bs, NULL);

@@ -1513,6 +1520,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
     assert(dev_offset <=3D INT64_MAX);
     exp->dev_offset =3D dev_offset;
     exp->name =3D g_strdup(name);
+    assert(!desc || strlen(desc) <=3D NBD_MAX_STRING_SIZE);
     exp->description =3D g_strdup(desc);
     exp->nbdflags =3D (NBD_FLAG_HAS_FLAGS | NBD_FLAG_SEND_FLUSH |
                      NBD_FLAG_SEND_FUA | NBD_FLAG_SEND_CACHE);
@@ -1561,6 +1569,8 @@ NBDExport *nbd_export_new(BlockDriverState *bs, uin=
t64_t dev_offset,
         exp->export_bitmap =3D bm;
         exp->export_bitmap_context =3D g_strdup_printf("qemu:dirty-bitma=
p:%s",
                                                      bitmap);
+        /* See BME_MAX_NAME_SIZE in block/qcow2-bitmap.c */
+        assert(strlen(exp->export_bitmap_context) <=3D NBD_MAX_STRING_SI=
ZE);
     }

     exp->close =3D close;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 9032b6de2ace..55ce69b141f0 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -826,9 +826,18 @@ int main(int argc, char **argv)
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


