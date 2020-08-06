Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D3EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397D522CE3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397D522CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3aX2-0003DL-HT
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 03:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <longpeng2@huawei.com>)
 id 1k3aWE-0002Lx-Bh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:40:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58120 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <longpeng2@huawei.com>)
 id 1k3aWB-0002nZ-U8
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 03:40:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 28B6E3957B81AC24874D;
 Thu,  6 Aug 2020 15:40:43 +0800 (CST)
Received: from DESKTOP-27KDQMV.china.huawei.com (10.174.151.115) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 6 Aug 2020 15:40:33 +0800
From: "Longpeng(Mike)" <longpeng2@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH 1/2] migration: unify the framework of socket-type channel
Date: Thu, 6 Aug 2020 15:40:29 +0800
Message-ID: <20200806074030.174-2-longpeng2@huawei.com>
X-Mailer: git-send-email 2.25.0.windows.1
In-Reply-To: <20200806074030.174-1-longpeng2@huawei.com>
References: <20200806074030.174-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.151.115]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32; envelope-from=longpeng2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 03:37:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: longpeng2@huawei.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, the only difference of tcp channel and unix channel in
migration/socket.c is the way to build SocketAddress, but socket_parse()
can handle these two types, so use it to instead of tcp_build_address()
and unix_build_address().

The socket-type channel can be further unified based on the up, this
would be helpful for us to add other socket-type channels.

Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
---
 migration/migration.c | 18 ++++++-------
 migration/socket.c    | 72 +++++++++++----------------------------------------
 migration/socket.h    | 11 +++-----
 3 files changed, 26 insertions(+), 75 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 8fe3633..3160b95 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -377,21 +377,20 @@ void migrate_add_address(SocketAddress *address)
 
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
-    const char *p;
+    const char *p = NULL;
 
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
-    } else if (strstart(uri, "tcp:", &p)) {
-        tcp_start_incoming_migration(p, errp);
+    } else if (strstart(uri, "tcp:", &p) ||
+               strstart(uri, "unix:", NULL)) {
+        socket_start_incoming_migration(p ? p : uri, errp);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_incoming_migration(p, errp);
-    } else if (strstart(uri, "unix:", &p)) {
-        unix_start_incoming_migration(p, errp);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_incoming_migration(p, errp);
     } else {
@@ -2064,7 +2063,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
 {
     Error *local_err = NULL;
     MigrationState *s = migrate_get_current();
-    const char *p;
+    const char *p = NULL;
 
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          has_resume && resume, errp)) {
@@ -2072,16 +2071,15 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         return;
     }
 
-    if (strstart(uri, "tcp:", &p)) {
-        tcp_start_outgoing_migration(s, p, &local_err);
+    if (strstart(uri, "tcp:", &p) ||
+        strstart(uri, "unix:", NULL)) {
+        socket_start_outgoing_migration(s, p ? p : uri, &local_err);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
         exec_start_outgoing_migration(s, p, &local_err);
-    } else if (strstart(uri, "unix:", &p)) {
-        unix_start_outgoing_migration(s, p, &local_err);
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
diff --git a/migration/socket.c b/migration/socket.c
index 97c9efd..6016642 100644
--- a/migration/socket.c
+++ b/migration/socket.c
@@ -50,34 +50,6 @@ int socket_send_channel_destroy(QIOChannel *send)
     return 0;
 }
 
-static SocketAddress *tcp_build_address(const char *host_port, Error **errp)
-{
-    SocketAddress *saddr;
-
-    saddr = g_new0(SocketAddress, 1);
-    saddr->type = SOCKET_ADDRESS_TYPE_INET;
-
-    if (inet_parse(&saddr->u.inet, host_port, errp)) {
-        qapi_free_SocketAddress(saddr);
-        return NULL;
-    }
-
-    return saddr;
-}
-
-
-static SocketAddress *unix_build_address(const char *path)
-{
-    SocketAddress *saddr;
-
-    saddr = g_new0(SocketAddress, 1);
-    saddr->type = SOCKET_ADDRESS_TYPE_UNIX;
-    saddr->u.q_unix.path = g_strdup(path);
-
-    return saddr;
-}
-
-
 struct SocketConnectData {
     MigrationState *s;
     char *hostname;
@@ -109,9 +81,10 @@ static void socket_outgoing_migration(QIOTask *task,
     object_unref(OBJECT(sioc));
 }
 
-static void socket_start_outgoing_migration(MigrationState *s,
-                                            SocketAddress *saddr,
-                                            Error **errp)
+static void
+socket_start_outgoing_migration_internal(MigrationState *s,
+                                         SocketAddress *saddr,
+                                         Error **errp)
 {
     QIOChannelSocket *sioc = qio_channel_socket_new();
     struct SocketConnectData *data = g_new0(struct SocketConnectData, 1);
@@ -135,27 +108,18 @@ static void socket_start_outgoing_migration(MigrationState *s,
                                      NULL);
 }
 
-void tcp_start_outgoing_migration(MigrationState *s,
-                                  const char *host_port,
-                                  Error **errp)
+void socket_start_outgoing_migration(MigrationState *s,
+                                     const char *str,
+                                     Error **errp)
 {
     Error *err = NULL;
-    SocketAddress *saddr = tcp_build_address(host_port, &err);
+    SocketAddress *saddr = socket_parse(str, &err);
     if (!err) {
-        socket_start_outgoing_migration(s, saddr, &err);
+        socket_start_outgoing_migration_internal(s, saddr, &err);
     }
     error_propagate(errp, err);
 }
 
-void unix_start_outgoing_migration(MigrationState *s,
-                                   const char *path,
-                                   Error **errp)
-{
-    SocketAddress *saddr = unix_build_address(path);
-    socket_start_outgoing_migration(s, saddr, errp);
-}
-
-
 static void socket_accept_incoming_migration(QIONetListener *listener,
                                              QIOChannelSocket *cioc,
                                              gpointer opaque)
@@ -173,8 +137,9 @@ static void socket_accept_incoming_migration(QIONetListener *listener,
 }
 
 
-static void socket_start_incoming_migration(SocketAddress *saddr,
-                                            Error **errp)
+static void
+socket_start_incoming_migration_internal(SocketAddress *saddr,
+                                         Error **errp)
 {
     QIONetListener *listener = qio_net_listener_new();
     size_t i;
@@ -207,20 +172,13 @@ static void socket_start_incoming_migration(SocketAddress *saddr,
     }
 }
 
-void tcp_start_incoming_migration(const char *host_port, Error **errp)
+void socket_start_incoming_migration(const char *str, Error **errp)
 {
     Error *err = NULL;
-    SocketAddress *saddr = tcp_build_address(host_port, &err);
+    SocketAddress *saddr = socket_parse(str, &err);
     if (!err) {
-        socket_start_incoming_migration(saddr, &err);
+        socket_start_incoming_migration_internal(saddr, &err);
     }
     qapi_free_SocketAddress(saddr);
     error_propagate(errp, err);
 }
-
-void unix_start_incoming_migration(const char *path, Error **errp)
-{
-    SocketAddress *saddr = unix_build_address(path);
-    socket_start_incoming_migration(saddr, errp);
-    qapi_free_SocketAddress(saddr);
-}
diff --git a/migration/socket.h b/migration/socket.h
index 528c3b0..891dbcc 100644
--- a/migration/socket.h
+++ b/migration/socket.h
@@ -23,13 +23,8 @@
 void socket_send_channel_create(QIOTaskFunc f, void *data);
 int socket_send_channel_destroy(QIOChannel *send);
 
-void tcp_start_incoming_migration(const char *host_port, Error **errp);
+void socket_start_incoming_migration(const char *str, Error **errp);
 
-void tcp_start_outgoing_migration(MigrationState *s, const char *host_port,
-                                  Error **errp);
-
-void unix_start_incoming_migration(const char *path, Error **errp);
-
-void unix_start_outgoing_migration(MigrationState *s, const char *path,
-                                   Error **errp);
+void socket_start_outgoing_migration(MigrationState *s, const char *str,
+                                     Error **errp);
 #endif
-- 
1.8.3.1


