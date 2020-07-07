Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0FEC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA212065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHYQSo3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA212065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsquX-0006tj-9P
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsqqc-0000Wi-I7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:53:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47137
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsqqZ-00072D-T4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594140811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkAQltNuOP2YXnC4GnK3EmsF7L67rYh833RXsqUTHOE=;
 b=AHYQSo3yWbuAssq/srD4rbKBRuh6bngn1SjXLYfeHdBT6pLpDD4UqsEJrpvQXlaWa5u3Kr
 5pLea2Q3OHcx3imQsB5rUiUkE6qDB3F5HrB/v6j1OVI1o1kFmT1klAxw/HawGu99i9Vq7B
 Beim9GUDV3Y9f/cfF9fxv7qy0hyw86c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-RP_ZSErIOhiH6b3uAxhGHA-1; Tue, 07 Jul 2020 12:50:54 -0400
X-MC-Unique: RP_ZSErIOhiH6b3uAxhGHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF71107ACF4;
 Tue,  7 Jul 2020 16:50:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 22AF060E1C;
 Tue,  7 Jul 2020 16:50:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34DC611326F2; Tue,  7 Jul 2020 18:50:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v12 7/8] nbd: Use ERRP_AUTO_PROPAGATE()
Date: Tue,  7 Jul 2020 18:50:36 +0200
Message-Id: <20200707165037.1026246-8-armbru@redhat.com>
In-Reply-To: <20200707165037.1026246-1-armbru@redhat.com>
References: <20200707165037.1026246-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Laszlo Ersek <lersek@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, groug@kaod.org,
 Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp == &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit is generated by command

    sed -n '/^Network Block Device (NBD)$/,/^$/{s/^F: //p}' \
        MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/block/nbd.h | 1 +
 block/nbd.c         | 7 +++----
 nbd/client.c        | 5 +++++
 nbd/server.c        | 5 +++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 20363280ae..f7d87636d3 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -361,6 +361,7 @@ void nbd_server_start_options(NbdServerOptions *arg, Error **errp);
 static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,
                            const char *desc, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int ret = qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 
     if (ret < 0) {
diff --git a/block/nbd.c b/block/nbd.c
index 6876da04a7..b7cea0f650 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1408,16 +1408,15 @@ static void nbd_client_close(BlockDriverState *bs)
 static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
                                                   Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     QIOChannelSocket *sioc;
-    Error *local_err = NULL;
 
     sioc = qio_channel_socket_new();
     qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
 
-    qio_channel_socket_connect_sync(sioc, saddr, &local_err);
-    if (local_err) {
+    qio_channel_socket_connect_sync(sioc, saddr, errp);
+    if (*errp) {
         object_unref(OBJECT(sioc));
-        error_propagate(errp, local_err);
         return NULL;
     }
 
diff --git a/nbd/client.c b/nbd/client.c
index ba173108ba..e258ef3f7e 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -68,6 +68,7 @@ static int nbd_send_option_request(QIOChannel *ioc, uint32_t opt,
                                    uint32_t len, const char *data,
                                    Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NBDOption req;
     QEMU_BUILD_BUG_ON(sizeof(req) != 16);
 
@@ -153,6 +154,7 @@ static int nbd_receive_option_reply(QIOChannel *ioc, uint32_t opt,
 static int nbd_handle_reply_err(QIOChannel *ioc, NBDOptionReply *reply,
                                 bool strict, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *msg = NULL;
 
     if (!(reply->type & (1 << 31))) {
@@ -337,6 +339,7 @@ static int nbd_receive_list(QIOChannel *ioc, char **name, char **description,
 static int nbd_opt_info_or_go(QIOChannel *ioc, uint32_t opt,
                               NBDExportInfo *info, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     NBDOptionReply reply;
     uint32_t len = strlen(info->name);
     uint16_t type;
@@ -882,6 +885,7 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                                bool structured_reply, bool *zeroes,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     uint64_t magic;
 
     trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");
@@ -1017,6 +1021,7 @@ int nbd_receive_negotiate(AioContext *aio_context, QIOChannel *ioc,
                           const char *hostname, QIOChannel **outioc,
                           NBDExportInfo *info, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int result;
     bool zeroes;
     bool base_allocation = info->base_allocation;
diff --git a/nbd/server.c b/nbd/server.c
index 20754e9ebc..8a12e586d7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -211,6 +211,7 @@ static int GCC_FMT_ATTR(4, 0)
 nbd_negotiate_send_rep_verr(NBDClient *client, uint32_t type,
                             Error **errp, const char *fmt, va_list va)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *msg = NULL;
     int ret;
     size_t len;
@@ -382,6 +383,7 @@ static int nbd_opt_read_name(NBDClient *client, char **name, uint32_t *length,
 static int nbd_negotiate_send_rep_list(NBDClient *client, NBDExport *exp,
                                        Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     size_t name_len, desc_len;
     uint32_t len;
     const char *name = exp->name ? exp->name : "";
@@ -445,6 +447,7 @@ static void nbd_check_meta_export(NBDClient *client)
 static int nbd_negotiate_handle_export_name(NBDClient *client, bool no_zeroes,
                                             Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     g_autofree char *name = NULL;
     char buf[NBD_REPLY_EXPORT_NAME_SIZE] = "";
     size_t len;
@@ -1289,6 +1292,7 @@ static int nbd_negotiate_options(NBDClient *client, Error **errp)
  */
 static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     char buf[NBD_OLDSTYLE_NEGOTIATE_SIZE] = "";
     int ret;
 
@@ -1663,6 +1667,7 @@ void nbd_export_close(NBDExport *exp)
 
 void nbd_export_remove(NBDExport *exp, NbdServerRemoveMode mode, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     if (mode == NBD_SERVER_REMOVE_MODE_HARD || QTAILQ_EMPTY(&exp->clients)) {
         nbd_export_close(exp);
         return;
-- 
2.26.2


