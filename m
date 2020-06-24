Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28891C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:42:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6EDA2088E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 08:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdB0GlTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6EDA2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo0zU-0001eP-49
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 04:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0uj-0000d8-LG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30269
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo0ue-00023u-Me
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 04:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592987864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qdZrGRWK0pCBmLrox63Bp3XBBsnlXRTh2MNWVXmBCxg=;
 b=EdB0GlTAuSdw/nSTLQmPNLyUC4R32cmXs33NRf63W0x+utBaB3CFq85rFtqok+N/oe4+Ip
 Lffptgh3anTDY37iPaQuAkE1WuR5NaDUnfORFP/XLmOYYahXcfezdxtc62I60Tky2yqckV
 sGLdj+72eV97h2bGjWH09xKa+a2ITrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-v9XZYIeUPt-fgYfuFfws0A-1; Wed, 24 Jun 2020 04:37:41 -0400
X-MC-Unique: v9XZYIeUPt-fgYfuFfws0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11398800C64;
 Wed, 24 Jun 2020 08:37:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 132605C1D4;
 Wed, 24 Jun 2020 08:37:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 83BFC1138471; Wed, 24 Jun 2020 10:37:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/25] Clean up some calls to ignore Error objects the
 right way
Date: Wed, 24 Jun 2020 10:37:15 +0200
Message-Id: <20200624083737.3086768-4-armbru@redhat.com>
In-Reply-To: <20200624083737.3086768-1-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 03:27:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jerome Forissier <jerome@forissier.org>,
 "Daniel P . Berrange" <berrange@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Receiving the error in a local variable only to free it is less clear
(and also less efficient) than passing NULL.  Clean up.

Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Jerome Forissier <jerome@forissier.org>
CC: Greg Kurz <groug@kaod.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 chardev/char-socket.c | 6 ++----
 hw/9pfs/9p.c          | 6 ++----
 hw/arm/virt.c         | 4 +---
 hw/ppc/spapr_drc.c    | 4 +---
 ui/vnc.c              | 3 +--
 5 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index afebeec5c3..b0cae97960 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -815,22 +815,20 @@ static void tcp_chr_tls_init(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
     QIOChannelTLS *tioc;
-    Error *err = NULL;
     gchar *name;
 
     if (s->is_listen) {
         tioc = qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
             s->tls_authz,
-            &err);
+            NULL);
     } else {
         tioc = qio_channel_tls_new_client(
             s->ioc, s->tls_creds,
             s->addr->u.inet.host,
-            &err);
+            NULL);
     }
     if (tioc == NULL) {
-        error_free(err);
         tcp_chr_disconnect(chr);
         return;
     }
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 45a788f6e6..9755fba9a9 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1399,7 +1399,6 @@ static void coroutine_fn v9fs_attach(void *opaque)
     size_t offset = 7;
     V9fsQID qid;
     ssize_t err;
-    Error *local_err = NULL;
 
     v9fs_string_init(&uname);
     v9fs_string_init(&aname);
@@ -1437,9 +1436,8 @@ static void coroutine_fn v9fs_attach(void *opaque)
         error_setg(&s->migration_blocker,
                    "Migration is disabled when VirtFS export path '%s' is mounted in the guest using mount_tag '%s'",
                    s->ctx.fs_root ? s->ctx.fs_root : "NULL", s->tag);
-        err = migrate_add_blocker(s->migration_blocker, &local_err);
-        if (local_err) {
-            error_free(local_err);
+        err = migrate_add_blocker(s->migration_blocker, NULL);
+        if (err < 0) {
             error_free(s->migration_blocker);
             s->migration_blocker = NULL;
             clunk_fid(s, fid);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index caceb1e4a0..29b9d5b2e6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -217,11 +217,9 @@ static bool cpu_type_valid(const char *cpu)
 
 static void create_kaslr_seed(VirtMachineState *vms, const char *node)
 {
-    Error *err = NULL;
     uint64_t seed;
 
-    if (qemu_guest_getrandom(&seed, sizeof(seed), &err)) {
-        error_free(err);
+    if (qemu_guest_getrandom(&seed, sizeof(seed), NULL)) {
         return;
     }
     qemu_fdt_setprop_u64(vms->fdt, node, "kaslr-seed", seed);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 2689104295..951bcdf2c0 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -1163,16 +1163,14 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
 
     if (!drc->fdt) {
-        Error *local_err = NULL;
         void *fdt;
         int fdt_size;
 
         fdt = create_device_tree(&fdt_size);
 
         if (drck->dt_populate(drc, spapr, fdt, &drc->fdt_start_offset,
-                              &local_err)) {
+                              NULL)) {
             g_free(fdt);
-            error_free(local_err);
             rc = SPAPR_DR_CC_RESPONSE_ERROR;
             goto out;
         }
diff --git a/ui/vnc.c b/ui/vnc.c
index 12a12714e1..0702a76cce 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -458,9 +458,8 @@ static VncServerInfo2List *qmp_query_server_entry(QIOChannelSocket *ioc,
     Error *err = NULL;
     SocketAddress *addr;
 
-    addr = qio_channel_socket_get_local_address(ioc, &err);
+    addr = qio_channel_socket_get_local_address(ioc, NULL);
     if (!addr) {
-        error_free(err);
         return prev;
     }
 
-- 
2.26.2


