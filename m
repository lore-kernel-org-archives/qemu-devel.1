Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBBC352A4
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:43:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1290A20733
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 21:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTzaeOQc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1290A20733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Gpd-0007t6-4q
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 16:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1j1Gnv-0006Gf-S7
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1j1Gnt-0001ZT-HR
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1j1Gnt-0001W4-9I
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 16:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581370876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qduzxPa1kIn6JbRnxdn2A3uEmQeavXD90D62k3y40+Y=;
 b=ZTzaeOQcYNuRx74tNFxpNb7QCGq50l9lCmJkT9CUNyCsIvwghRHnkzUm5v5X6sLFMFalmn
 078z5l0W4ra4pz/E+jkn5BSqpv9HLgCGhIOucVbnelh7B0Lh5b+oDa0ZjGchWi1hnLzfDU
 Y5xE0ONyAL/dWBxpbRI1zkyQHeB2t2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-mlpLeAe1NjqvvZKYxnhUBw-1; Mon, 10 Feb 2020 16:41:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B91100550E;
 Mon, 10 Feb 2020 21:41:13 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-180.phx2.redhat.com [10.3.116.180])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D867E5D9CA;
 Mon, 10 Feb 2020 21:41:12 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] nbd: Add .bdrv_known_zeroes() client support
Date: Mon, 10 Feb 2020 15:41:08 -0600
Message-Id: <20200210214109.751734-3-eblake@redhat.com>
In-Reply-To: <20200210214109.751734-1-eblake@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
 <20200210214109.751734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: mlpLeAe1NjqvvZKYxnhUBw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, rjones@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Using the new NBD extension of NBD_INFO_INIT_STATE, we can pass on the
information when a server reports that an image initially reads as all
zeroes.  The server information is treated as stale the moment we
request a write operation, even across reconnections to the server,
which is fine since our intended usage of BDRV_ZERO_OPEN is to
optimize qemu-img at startup, and not something relied on during later
image use.

Update iotests to reflect improved output of 'qemu-nbd --list'.

As NBD still cannot create or resize images, we don't need to worry
about BDRV_ZERO_CREATE or BDRV_ZERO_TRUNCATE.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c                | 15 +++++++++++++++
 include/block/nbd.h        |  4 ++++
 nbd/client.c               | 24 ++++++++++++++++++++----
 nbd/trace-events           |  1 +
 qemu-nbd.c                 | 13 +++++++++++++
 tests/qemu-iotests/223.out |  4 ++++
 tests/qemu-iotests/233.out |  1 +
 7 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index d085554f21ea..2e1fbd6152f6 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1204,6 +1204,7 @@ static int nbd_client_co_pwritev(BlockDriverState *bs=
, uint64_t offset,
     };

     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
+    s->info.modified =3D true;
     if (flags & BDRV_REQ_FUA) {
         assert(s->info.flags & NBD_FLAG_SEND_FUA);
         request.flags |=3D NBD_CMD_FLAG_FUA;
@@ -1276,6 +1277,7 @@ static int nbd_client_co_pdiscard(BlockDriverState *b=
s, int64_t offset,
     };

     assert(!(s->info.flags & NBD_FLAG_READ_ONLY));
+    s->info.modified =3D true;
     if (!(s->info.flags & NBD_FLAG_SEND_TRIM) || !bytes) {
         return 0;
     }
@@ -1909,6 +1911,16 @@ static int nbd_co_flush(BlockDriverState *bs)
     return nbd_client_co_flush(bs);
 }

+static int nbd_known_zeroes(BlockDriverState *bs)
+{
+    BDRVNBDState *s =3D bs->opaque;
+
+    if (!s->info.modified && s->info.init_state & NBD_INIT_ZERO) {
+        return BDRV_ZERO_OPEN;
+    }
+    return 0;
+}
+
 static void nbd_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
@@ -2027,6 +2039,7 @@ static BlockDriver bdrv_nbd =3D {
     .bdrv_close                 =3D nbd_close,
     .bdrv_co_flush_to_os        =3D nbd_co_flush,
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
+    .bdrv_known_zeroes          =3D nbd_known_zeroes,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
@@ -2052,6 +2065,7 @@ static BlockDriver bdrv_nbd_tcp =3D {
     .bdrv_close                 =3D nbd_close,
     .bdrv_co_flush_to_os        =3D nbd_co_flush,
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
+    .bdrv_known_zeroes          =3D nbd_known_zeroes,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
@@ -2077,6 +2091,7 @@ static BlockDriver bdrv_nbd_unix =3D {
     .bdrv_close                 =3D nbd_close,
     .bdrv_co_flush_to_os        =3D nbd_co_flush,
     .bdrv_co_pdiscard           =3D nbd_client_co_pdiscard,
+    .bdrv_known_zeroes          =3D nbd_known_zeroes,
     .bdrv_refresh_limits        =3D nbd_refresh_limits,
     .bdrv_getlength             =3D nbd_getlength,
     .bdrv_detach_aio_context    =3D nbd_client_detach_aio_context,
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 0de020904a37..5103053bed49 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -307,6 +307,7 @@ struct NBDExportInfo {
     uint32_t min_block;
     uint32_t opt_block;
     uint32_t max_block;
+    uint16_t init_state;

     uint32_t context_id;

@@ -314,6 +315,9 @@ struct NBDExportInfo {
     char *description;
     int n_contexts;
     char **contexts;
+
+    /* Set during runtime to track if init_state is still trustworthy. */
+    bool modified;
 };
 typedef struct NBDExportInfo NBDExportInfo;

diff --git a/nbd/client.c b/nbd/client.c
index ba173108baab..199a8a2bc49e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -350,16 +350,17 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32=
_t opt,

     assert(opt =3D=3D NBD_OPT_GO || opt =3D=3D NBD_OPT_INFO);
     trace_nbd_opt_info_go_start(nbd_opt_lookup(opt), info->name);
-    buf =3D g_malloc(4 + len + 2 + 2 * info->request_sizes + 1);
+    buf =3D g_malloc(4 + len + 2 + 2 * (info->request_sizes + 1) + 1);
     stl_be_p(buf, len);
     memcpy(buf + 4, info->name, len);
-    /* At most one request, everything else up to server */
-    stw_be_p(buf + 4 + len, info->request_sizes);
+    /* One or two requests, everything else up to server */
+    stw_be_p(buf + 4 + len, info->request_sizes + 1);
     if (info->request_sizes) {
         stw_be_p(buf + 4 + len + 2, NBD_INFO_BLOCK_SIZE);
     }
+    stw_be_p(buf + 4 + len + 2 + 2 * info->request_sizes, NBD_INFO_INIT_ST=
ATE);
     error =3D nbd_send_option_request(ioc, opt,
-                                    4 + len + 2 + 2 * info->request_sizes,
+                                    4 + len + 2 + 2 * (info->request_sizes=
 + 1),
                                     buf, errp);
     g_free(buf);
     if (error < 0) {
@@ -484,6 +485,21 @@ static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_=
t opt,
                                           info->max_block);
             break;

+        case NBD_INFO_INIT_STATE:
+            if (len !=3D sizeof(info->init_state)) {
+                error_setg(errp, "remaining export info len %" PRIu32
+                           " is unexpected size", len);
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            if (nbd_read16(ioc, &info->init_state, "info init state",
+                           errp) < 0) {
+                nbd_send_opt_abort(ioc);
+                return -1;
+            }
+            trace_nbd_opt_info_init_state(info->init_state);
+            break;
+
         default:
             /*
              * Not worth the bother to check if NBD_INFO_NAME or
diff --git a/nbd/trace-events b/nbd/trace-events
index a955918e9707..12589b2afb84 100644
--- a/nbd/trace-events
+++ b/nbd/trace-events
@@ -10,6 +10,7 @@ nbd_opt_info_go_start(const char *opt, const char *name) =
"Attempting %s for expo
 nbd_opt_info_go_success(const char *opt) "Export is ready after %s request=
"
 nbd_opt_info_unknown(int info, const char *name) "Ignoring unknown info %d=
 (%s)"
 nbd_opt_info_block_size(uint32_t minimum, uint32_t preferred, uint32_t max=
imum) "Block sizes are 0x%" PRIx32 ", 0x%" PRIx32 ", 0x%" PRIx32
+nbd_opt_info_init_state(unsigned int flags) "Initial state flags 0x%x"
 nbd_receive_query_exports_start(const char *wantname) "Querying export lis=
t for '%s'"
 nbd_receive_query_exports_success(const char *wantname) "Found desired exp=
ort name '%s'"
 nbd_receive_starttls_new_client(void) "Setting up TLS"
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 4aa005004ebd..856df85823bc 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -220,6 +220,19 @@ static int qemu_nbd_client_list(SocketAddress *saddr, =
QCryptoTLSCreds *tls,
             printf("  opt block: %u\n", list[i].opt_block);
             printf("  max block: %u\n", list[i].max_block);
         }
+        {
+            static const char *const init_names[] =3D {
+                [NBD_INIT_SPARSE_BIT]            =3D "sparse",
+                [NBD_INIT_ZERO_BIT]              =3D "zero",
+            };
+            printf("  init state: 0x%x (", list[i].init_state);
+            for (size_t bit =3D 0; bit < ARRAY_SIZE(init_names); bit++) {
+                if (init_names[bit] && (list[i].init_state & (1 << bit))) =
{
+                    printf(" %s", init_names[bit]);
+                }
+            }
+            printf(" )\n");
+        }
         if (list[i].n_contexts) {
             printf("  available meta contexts: %d\n", list[i].n_contexts);
             for (j =3D 0; j < list[i].n_contexts; j++) {
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 80c0cf65095b..ce7945aa7cf6 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -59,6 +59,7 @@ exports available: 2
   min block: 1
   opt block: 4096
   max block: 33554432
+  init state: 0x0 ( )
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b
@@ -69,6 +70,7 @@ exports available: 2
   min block: 1
   opt block: 4096
   max block: 33554432
+  init state: 0x0 ( )
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b2
@@ -140,6 +142,7 @@ exports available: 2
   min block: 1
   opt block: 4096
   max block: 33554432
+  init state: 0x0 ( )
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b
@@ -150,6 +153,7 @@ exports available: 2
   min block: 1
   opt block: 4096
   max block: 33554432
+  init state: 0x0 ( )
   available meta contexts: 2
    base:allocation
    qemu:dirty-bitmap:b2
diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
index c3c344811b2b..5be30d6b7c9c 100644
--- a/tests/qemu-iotests/233.out
+++ b/tests/qemu-iotests/233.out
@@ -43,6 +43,7 @@ exports available: 1
   min block: 1
   opt block: 4096
   max block: 33554432
+  init state: 0x0 ( )
   available meta contexts: 1
    base:allocation

--=20
2.24.1


