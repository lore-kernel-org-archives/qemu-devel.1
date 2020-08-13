Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:39:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94E16206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjMjLuwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94E16206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GG8-0002G5-Ng
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7I-0002E9-Gl
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7G-0001Hd-Op
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gjTbZYrXoIR0MeHZ6tOs7rNuhtSlvwBUk2TO+CPIQU=;
 b=hjMjLuwYEd27Lxwd1Jh+siXLBXBkG9tK7jnhbgFSFIJ3CW3Hg1p+dxaQLeKnxxWAOID/TG
 NFeEFUOpp0Kgb/WfCt59991xAf2vA5kHZ+irx1y+t8gHylOOebhN/ABJcShi5bwnIG+ck1
 vhhph1j+ogAMlyQ35e+Px2JwRj1Gwjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-JAQyawrDPUOIBYEK57JbGA-1; Thu, 13 Aug 2020 12:30:06 -0400
X-MC-Unique: JAQyawrDPUOIBYEK57JbGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 715AB1835865;
 Thu, 13 Aug 2020 16:30:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 632BE5C1BB;
 Thu, 13 Aug 2020 16:30:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 11/22] qemu-nbd: Use blk_exp_add() to create the export
Date: Thu, 13 Aug 2020 18:29:24 +0200
Message-Id: <20200813162935.210070-12-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this change, NBD exports are only created through the BlockExport
interface any more. This allows us finally to move things from the NBD
layer to the BlockExport layer if they make sense for other export
types, too.

blk_exp_add() returns only a weak reference, so the explicit
nbd_export_put() goes away.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/export.h |  2 ++
 include/block/nbd.h    |  1 +
 block/export/export.c  |  2 +-
 blockdev-nbd.c         |  8 +++++++-
 qemu-nbd.c             | 28 ++++++++++++++++++++++------
 5 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/block/export.h b/include/block/export.h
index b1d7325403..5424bdc85d 100644
--- a/include/block/export.h
+++ b/include/block/export.h
@@ -29,4 +29,6 @@ struct BlockExport {
 
 extern const BlockExportDriver blk_exp_nbd;
 
+BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp);
+
 #endif
diff --git a/include/block/nbd.h b/include/block/nbd.h
index 50e1a46075..23030db3f1 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -350,6 +350,7 @@ void nbd_client_new(QIOChannelSocket *sioc,
 void nbd_client_get(NBDClient *client);
 void nbd_client_put(NBDClient *client);
 
+void nbd_server_is_qemu_nbd(bool value);
 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
                       const char *tls_authz, uint32_t max_connections,
                       Error **errp);
diff --git a/block/export/export.c b/block/export/export.c
index 2d5f92861c..12672228c7 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -36,7 +36,7 @@ static const BlockExportDriver *blk_exp_find_driver(BlockExportType type)
     return NULL;
 }
 
-static BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
+BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
 {
     const BlockExportDriver *drv;
 
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index d5b084acc2..8dd127af52 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -28,9 +28,15 @@ typedef struct NBDServerData {
 } NBDServerData;
 
 static NBDServerData *nbd_server;
+static bool is_qemu_nbd;
 
 static void nbd_update_server_watch(NBDServerData *s);
 
+void nbd_server_is_qemu_nbd(bool value)
+{
+    is_qemu_nbd = value;
+}
+
 static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
 {
     nbd_client_put(client);
@@ -176,7 +182,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 
     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
 
-    if (!nbd_server) {
+    if (!nbd_server && !is_qemu_nbd) {
         error_setg(errp, "NBD server not running");
         return NULL;
     }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 48aa8a9d46..d967b8fcb9 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -65,7 +65,6 @@
 
 #define MBR_SIZE 512
 
-static NBDExport *export;
 static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
@@ -579,6 +578,7 @@ int main(int argc, char **argv)
     int old_stderr = -1;
     unsigned socket_activation;
     const char *pid_file_name = NULL;
+    BlockExportOptions *export_opts;
 
     /* The client thread uses SIGTERM to interrupt the server.  A signal
      * handler ensures that "qemu-nbd -v -c" exits with a nice status code.
@@ -1050,9 +1050,27 @@ int main(int argc, char **argv)
 
     bs->detect_zeroes = detect_zeroes;
 
-    export = nbd_export_new(bs, export_name,
-                            export_description, bitmap, readonly, shared > 1,
-                            writethrough, &error_fatal);
+    nbd_server_is_qemu_nbd(true);
+
+    export_opts = g_new(BlockExportOptions, 1);
+    *export_opts = (BlockExportOptions) {
+        .type               = BLOCK_EXPORT_TYPE_NBD,
+        .has_writethrough   = true,
+        .writethrough       = writethrough,
+        .u.nbd = {
+            .device             = g_strdup(bdrv_get_node_name(bs)),
+            .has_name           = true,
+            .name               = g_strdup(export_name),
+            .has_description    = !!export_description,
+            .description        = g_strdup(export_description),
+            .has_writable       = true,
+            .writable           = !readonly,
+            .has_bitmap         = !!bitmap,
+            .bitmap             = g_strdup(bitmap),
+        },
+    };
+    blk_exp_add(export_opts, &error_fatal);
+    qapi_free_BlockExportOptions(export_opts);
 
     if (device) {
 #if HAVE_NBD_DEVICE
@@ -1092,9 +1110,7 @@ int main(int argc, char **argv)
     do {
         main_loop_wait(false);
         if (state == TERMINATE) {
-            nbd_export_put(export);
             nbd_export_close_all();
-            export = NULL;
             state = TERMINATED;
         }
     } while (state != TERMINATED);
-- 
2.25.4


