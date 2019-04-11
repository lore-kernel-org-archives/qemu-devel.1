Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC73C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 561F42084D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 17:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 561F42084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52605 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEdYT-0008ES-IW
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 13:32:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTm-0004ZG-Qe
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bH-Kw
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:59352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTl-0003Zx-9f; Thu, 11 Apr 2019 13:27:13 -0400
Received: from [10.28.8.145] (helo=kvm.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hEdTi-00044D-Tp; Thu, 11 Apr 2019 20:27:10 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Thu, 11 Apr 2019 20:27:06 +0300
Message-Id: <20190411172709.205032-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v6 4/7] block/nbd: add cmdline and qapi
 parameter reconnect-delay
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190411172706._i7sOS6lBwU9_5RaGGYa07AALvudu4YEpr1a_tFTYVo@z>

Reconnect will be implemented in the following commit, so for now,
in semantics below, disconnect itself is a "serious error".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block-core.json | 12 +++++++++++-
 block/nbd-client.h   |  1 +
 block/nbd-client.c   |  1 +
 block/nbd.c          | 16 +++++++++++++++-
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..815258bd89 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3798,13 +3798,23 @@
 #                  traditional "base:allocation" block status (see
 #                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (since 3.0)
 #
+# @reconnect-delay: Reconnect delay. On unexpected disconnect, nbd client tries
+#                   to connect again, until success or serious error. During
+#                   first @reconnect-delay seconds of reconnecting loop all
+#                   requests are paused and have a chance to rerun, if
+#                   successful connect occurs during this time. After
+#                   @reconnect-delay seconds all delayed requests are failed
+#                   and all following requests will be failed too (until
+#                   successful reconnect). Default 0 (Since 4.1)
+#
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsNbd',
   'data': { 'server': 'SocketAddress',
             '*export': 'str',
             '*tls-creds': 'str',
-            '*x-dirty-bitmap': 'str' } }
+            '*x-dirty-bitmap': 'str',
+            '*reconnect-delay': 'uint32' } }
 
 ##
 # @BlockdevOptionsRaw:
diff --git a/block/nbd-client.h b/block/nbd-client.h
index e45b7b0a14..91a6b32bdd 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -52,6 +52,7 @@ int nbd_client_init(BlockDriverState *bs,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
                     const char *x_dirty_bitmap,
+                    uint32_t reconnect_delay,
                     Error **errp);
 void nbd_client_close(BlockDriverState *bs);
 
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 9f5c86eaa3..1359aff162 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1218,6 +1218,7 @@ int nbd_client_init(BlockDriverState *bs,
                     QCryptoTLSCreds *tlscreds,
                     const char *hostname,
                     const char *x_dirty_bitmap,
+                    uint32_t reconnect_delay,
                     Error **errp)
 {
     int ret;
diff --git a/block/nbd.c b/block/nbd.c
index 208be59602..cffb2aee89 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -360,6 +360,18 @@ static QemuOptsList nbd_runtime_opts = {
             .help = "experimental: expose named dirty bitmap in place of "
                     "block status",
         },
+        {
+            .name = "reconnect-delay",
+            .type = QEMU_OPT_NUMBER,
+            .help = "Reconnect delay. On unexpected disconnect, nbd client "
+                    "tries to connect again, until success or serious error. "
+                    "During first @reconnect-delay seconds of reconnecting "
+                    "loop all requests are paused and have a chance to rerun, "
+                    "if successful connect occurs during this time. After"
+                    "@reconnect-delay seconds all delayed requests are failed"
+                    "and all following requests will be failed too (until"
+                    "successful reconnect). Default 0",
+        },
         { /* end of list */ }
     },
 };
@@ -411,7 +423,9 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* NBD handshake */
     ret = nbd_client_init(bs, s->saddr, s->export, tlscreds, hostname,
-                          qemu_opt_get(opts, "x-dirty-bitmap"), errp);
+                          qemu_opt_get(opts, "x-dirty-bitmap"),
+                          qemu_opt_get_number(opts, "reconnect-delay", 0),
+                          errp);
 
  error:
     if (tlscreds) {
-- 
2.18.0


