Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516CCC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCED22316
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 03:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkjOxS9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCED22316
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWtve-0006D1-0r
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 22:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iWtsF-0001sL-C7
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iWtsD-0004fF-ED
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iWtsD-0004e4-AQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 22:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574132891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6TjX/L+saoePk/7FJ7wZ4ec27XNv3l1AI8xcJt9k9w=;
 b=RkjOxS9j3LVWo10j/EVyrHDRL/GAk9zv5WAqwgQE4huwKBXSl17LrCX7fvfj6mXRbCmXMF
 Iq1JlAr0l8vF7Kp7XHEuY9sMHKZD6w+4W84O0IIYasWLwz8crHGAfo4uJzxmXrcQ1EyGM2
 4wLlbQoyBqCdf55+yBq6DbW040Okazk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-_zrnzMuHNriAMQzd4RPHSw-1; Mon, 18 Nov 2019 22:08:08 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70153802682;
 Tue, 19 Nov 2019 03:08:07 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0A9560565;
 Tue, 19 Nov 2019 03:08:06 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/10] nbd/server: Prefer heap over stack for parsing client
 names
Date: Mon, 18 Nov 2019 21:07:52 -0600
Message-Id: <20191119030759.24907-4-eblake@redhat.com>
In-Reply-To: <20191119030759.24907-1-eblake@redhat.com>
References: <20191119030759.24907-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: _zrnzMuHNriAMQzd4RPHSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As long as we limit NBD names to 256 bytes (the bare minimum permitted
by the standard), stack-allocation works for parsing a name received
from the client.  But as mentioned in a comment, we eventually want to
permit up to the 4k maximum of the NBD standard, which is too large
for stack allocation; so switch everything in the server to use heap
allocation.  For now, there is no change in actually supported name
length.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20191114024635.11363-2-eblake@redhat.com>
[eblake: fix uninit variable compile failure]
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h | 10 +++++-----
 nbd/server.c        | 25 +++++++++++++++----------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 316fd705a9e4..c306423dc85c 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -226,11 +226,11 @@ enum {
 /* Maximum size of a single READ/WRITE data buffer */
 #define NBD_MAX_BUFFER_SIZE (32 * 1024 * 1024)

-/* Maximum size of an export name. The NBD spec requires 256 and
- * suggests that servers support up to 4096, but we stick to only the
- * required size so that we can stack-allocate the names, and because
- * going larger would require an audit of more code to make sure we
- * aren't overflowing some other buffer. */
+/*
+ * Maximum size of an export name. The NBD spec requires a minimum of
+ * 256 and recommends that servers support up to 4096; all users use
+ * malloc so we can bump this constant without worry.
+ */
 #define NBD_MAX_NAME_SIZE 256

 /* Two types of reply structures */
diff --git a/nbd/server.c b/nbd/server.c
index d8d1e6245532..6bbeb98f8237 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -324,18 +324,20 @@ static int nbd_opt_skip(NBDClient *client, size_t siz=
e, Error **errp)
  *   uint32_t len     (<=3D NBD_MAX_NAME_SIZE)
  *   len bytes string (not 0-terminated)
  *
- * @name should be enough to store NBD_MAX_NAME_SIZE+1.
+ * On success, @name will be allocated.
  * If @length is non-null, it will be set to the actual string length.
  *
  * Return -errno on I/O error, 0 if option was completely handled by
  * sending a reply about inconsistent lengths, or 1 on success.
  */
-static int nbd_opt_read_name(NBDClient *client, char *name, uint32_t *leng=
th,
+static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *len=
gth,
                              Error **errp)
 {
     int ret;
     uint32_t len;
+    g_autofree char *local_name =3D NULL;

+    *name =3D NULL;
     ret =3D nbd_opt_read(client, &len, sizeof(len), errp);
     if (ret <=3D 0) {
         return ret;
@@ -347,15 +349,17 @@ static int nbd_opt_read_name(NBDClient *client, char =
*name, uint32_t *length,
                                "Invalid name length: %" PRIu32, len);
     }

-    ret =3D nbd_opt_read(client, name, len, errp);
+    local_name =3D g_malloc(len + 1);
+    ret =3D nbd_opt_read(client, local_name, len, errp);
     if (ret <=3D 0) {
         return ret;
     }
-    name[len] =3D '\0';
+    local_name[len] =3D '\0';

     if (length) {
         *length =3D len;
     }
+    *name =3D g_steal_pointer(&local_name);

     return 1;
 }
@@ -427,7 +431,7 @@ static void nbd_check_meta_export(NBDClient *client)
 static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zer=
oes,
                                             Error **errp)
 {
-    char name[NBD_MAX_NAME_SIZE + 1];
+    g_autofree char *name =3D NULL;
     char buf[NBD_REPLY_EXPORT_NAME_SIZE] =3D "";
     size_t len;
     int ret;
@@ -441,10 +445,11 @@ static int nbd_negotiate_handle_export_name(NBDClient=
 *client, bool no_zeroes,
         [10 .. 133]   reserved     (0) [unless no_zeroes]
      */
     trace_nbd_negotiate_handle_export_name();
-    if (client->optlen >=3D sizeof(name)) {
+    if (client->optlen > NBD_MAX_NAME_SIZE) {
         error_setg(errp, "Bad length received");
         return -EINVAL;
     }
+    name =3D g_malloc(client->optlen + 1);
     if (nbd_read(client->ioc, name, client->optlen, "export name", errp) <=
 0) {
         return -EIO;
     }
@@ -533,7 +538,7 @@ static int nbd_reject_length(NBDClient *client, bool fa=
tal, Error **errp)
 static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
 {
     int rc;
-    char name[NBD_MAX_NAME_SIZE + 1];
+    g_autofree char *name =3D NULL;
     NBDExport *exp;
     uint16_t requests;
     uint16_t request;
@@ -551,7 +556,7 @@ static int nbd_negotiate_handle_info(NBDClient *client,=
 Error **errp)
         2 bytes: N, number of requests (can be 0)
         N * 2 bytes: N requests
     */
-    rc =3D nbd_opt_read_name(client, name, &namelen, errp);
+    rc =3D nbd_opt_read_name(client, &name, &namelen, errp);
     if (rc <=3D 0) {
         return rc;
     }
@@ -957,7 +962,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client=
,
                                       NBDExportMetaContexts *meta, Error *=
*errp)
 {
     int ret;
-    char export_name[NBD_MAX_NAME_SIZE + 1];
+    g_autofree char *export_name =3D NULL;
     NBDExportMetaContexts local_meta;
     uint32_t nb_queries;
     int i;
@@ -976,7 +981,7 @@ static int nbd_negotiate_meta_queries(NBDClient *client=
,

     memset(meta, 0, sizeof(*meta));

-    ret =3D nbd_opt_read_name(client, export_name, NULL, errp);
+    ret =3D nbd_opt_read_name(client, &export_name, NULL, errp);
     if (ret <=3D 0) {
         return ret;
     }
--=20
2.21.0


