Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40D5C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4BF206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC7bt3ro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4BF206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GAU-0007Vb-Ve
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7C-00022V-Mn
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57604
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G7A-0001Gu-NR
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KgmtOfPHUtpRrXWlGz7u5in3FO/VtA6SKFE+c+MqFIU=;
 b=gC7bt3roTzZZd6zPbFkOTzQxS2mvy8/H8KiRfV7gAbOTmCpBrxwvUbnolaRhlfHrN136Am
 H2yZLfkWfKuOLF5bKejn/nN/Exi1JQZVxKeXtsVth3pH+f+pqydcGoOGKWRiZ7/qWB54/e
 MEZeBYpbfiY4vI32kWDzHJ+iQhwYF04=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-GrBkc5DNM_irM_H40jnTfw-1; Thu, 13 Aug 2020 12:30:02 -0400
X-MC-Unique: GrBkc5DNM_irM_H40jnTfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A56B1835870;
 Thu, 13 Aug 2020 16:30:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC3D55C1A3;
 Thu, 13 Aug 2020 16:29:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 10/22] nbd: Remove NBDExport.close callback
Date: Thu, 13 Aug 2020 18:29:23 +0200
Message-Id: <20200813162935.210070-11-kwolf@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The export close callback is unused by the built-in NBD server. qemu-nbd
uses it only during shutdown to wait for the unrefed export to actually
go away. It can just use nbd_export_close_all() instead and do without
the callback.

This removes the close callback from nbd_export_new() and makes both
callers of it more similar.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/nbd.h |  3 +--
 blockdev-nbd.c      |  2 +-
 nbd/server.c        |  9 +--------
 qemu-nbd.c          | 14 ++++----------
 4 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 6fc1f05ef4..50e1a46075 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -332,8 +332,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp);
 NBDExport *nbd_export_new(BlockDriverState *bs,
                           const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
-                          void (*close)(NBDExport *), bool writethrough,
-                          Error **errp);
+                          bool writethrough, Error **errp);
 void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk);
 void nbd_export_close(NBDExport *exp);
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp);
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 17417c1b6b..d5b084acc2 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -218,7 +218,7 @@ BlockExport *nbd_export_create(BlockExportOptions *exp_args, Error **errp)
 
     exp = nbd_export_new(bs, arg->name, arg->description, arg->bitmap,
                          !arg->writable, !arg->writable,
-                         NULL, exp_args->writethrough, errp);
+                         exp_args->writethrough, errp);
     if (!exp) {
         goto out;
     }
diff --git a/nbd/server.c b/nbd/server.c
index 0b84fd30e2..eadc5b9804 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -84,7 +84,6 @@ struct NBDRequestData {
 struct NBDExport {
     BlockExport common;
     int refcount;
-    void (*close)(NBDExport *exp);
 
     BlockBackend *blk;
     char *name;
@@ -1520,8 +1519,7 @@ void nbd_export_set_on_eject_blk(BlockExport *exp, BlockBackend *blk)
 NBDExport *nbd_export_new(BlockDriverState *bs,
                           const char *name, const char *desc,
                           const char *bitmap, bool readonly, bool shared,
-                          void (*close)(NBDExport *), bool writethrough,
-                          Error **errp)
+                          bool writethrough, Error **errp)
 {
     AioContext *ctx;
     BlockBackend *blk;
@@ -1625,7 +1623,6 @@ NBDExport *nbd_export_new(BlockDriverState *bs,
         assert(strlen(exp->export_bitmap_context) < NBD_MAX_STRING_SIZE);
     }
 
-    exp->close = close;
     exp->ctx = ctx;
     blk_add_aio_context_notifier(blk, blk_aio_attached, blk_aio_detach, exp);
 
@@ -1723,10 +1720,6 @@ void nbd_export_put(NBDExport *exp)
         assert(exp->name == NULL);
         assert(exp->description == NULL);
 
-        if (exp->close) {
-            exp->close(exp);
-        }
-
         if (exp->blk) {
             if (exp->eject_notifier_blk) {
                 notifier_remove(&exp->eject_notifier);
diff --git a/qemu-nbd.c b/qemu-nbd.c
index e348d5d6d8..48aa8a9d46 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -70,7 +70,7 @@ static int verbose;
 static char *srcpath;
 static SocketAddress *saddr;
 static int persistent = 0;
-static enum { RUNNING, TERMINATE, TERMINATING, TERMINATED } state;
+static enum { RUNNING, TERMINATE, TERMINATED } state;
 static int shared = 1;
 static int nb_fds;
 static QIONetListener *server;
@@ -331,12 +331,6 @@ static int nbd_can_accept(void)
     return state == RUNNING && nb_fds < shared;
 }
 
-static void nbd_export_closed(NBDExport *export)
-{
-    assert(state == TERMINATING);
-    state = TERMINATED;
-}
-
 static void nbd_update_server_watch(void);
 
 static void nbd_client_closed(NBDClient *client, bool negotiated)
@@ -1058,7 +1052,7 @@ int main(int argc, char **argv)
 
     export = nbd_export_new(bs, export_name,
                             export_description, bitmap, readonly, shared > 1,
-                            nbd_export_closed, writethrough, &error_fatal);
+                            writethrough, &error_fatal);
 
     if (device) {
 #if HAVE_NBD_DEVICE
@@ -1098,10 +1092,10 @@ int main(int argc, char **argv)
     do {
         main_loop_wait(false);
         if (state == TERMINATE) {
-            state = TERMINATING;
-            nbd_export_close(export);
             nbd_export_put(export);
+            nbd_export_close_all();
             export = NULL;
+            state = TERMINATED;
         }
     } while (state != TERMINATED);
 
-- 
2.25.4


