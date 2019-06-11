Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA27C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78CA206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 10:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78CA206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55980 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hae2e-00040N-05
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 06:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60365)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hae06-0002E1-Tw
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hae00-0001D7-Gu
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 06:27:31 -0400
Received: from relay.sw.ru ([185.231.240.75]:45604)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hadzy-0001Aa-D0; Tue, 11 Jun 2019 06:27:27 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hadzt-00083J-LK; Tue, 11 Jun 2019 13:27:21 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Tue, 11 Jun 2019 13:27:18 +0300
Message-Id: <20190611102720.86114-2-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190611102720.86114-1-vsementsov@virtuozzo.com>
References: <20190611102720.86114-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH 1/3] block/nbd-client: drop stale logout
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop one on failure path (we have errp) and turn two others into trace
points.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/nbd-client.h | 9 ---------
 block/nbd-client.c | 6 +++---
 block/trace-events | 2 ++
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 09e03013d2..231dc13c48 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -6,15 +6,6 @@
 #include "block/block_int.h"
 #include "io/channel-socket.h"
 
-/* #define DEBUG_NBD */
-
-#if defined(DEBUG_NBD)
-#define logout(fmt, ...) \
-    fprintf(stderr, "nbd\t%-24s" fmt, __func__, ##__VA_ARGS__)
-#else
-#define logout(fmt, ...) ((void)0)
-#endif
-
 #define MAX_NBD_REQUESTS    16
 
 typedef struct {
diff --git a/block/nbd-client.c b/block/nbd-client.c
index 790ecc1ee1..f89a67c23b 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1136,7 +1136,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     }
 
     /* NBD handshake */
-    logout("session init %s\n", export);
+    trace_nbd_client_connect(export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);
 
     client->info.request_sizes = true;
@@ -1149,7 +1149,6 @@ static int nbd_client_connect(BlockDriverState *bs,
     g_free(client->info.x_dirty_bitmap);
     g_free(client->info.name);
     if (ret < 0) {
-        logout("Failed to negotiate with the NBD server\n");
         object_unref(OBJECT(sioc));
         return ret;
     }
@@ -1187,7 +1186,8 @@ static int nbd_client_connect(BlockDriverState *bs,
     bdrv_inc_in_flight(bs);
     nbd_client_attach_aio_context(bs, bdrv_get_aio_context(bs));
 
-    logout("Established connection with NBD server\n");
+    trace_nbd_client_connect_success(export);
+
     return 0;
 
  fail:
diff --git a/block/trace-events b/block/trace-events
index eab51497fc..01fa5eb081 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -165,6 +165,8 @@ nbd_parse_blockstatus_compliance(const char *err) "ignoring extra data from non-
 nbd_structured_read_compliance(const char *type) "server sent non-compliant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret = %d, err: %s"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16_t flags, uint16_t type, const char *name, int ret, const char *err) "Request failed { .from = %" PRIu64", .len = %" PRIu32 ", .handle = %" PRIu64 ", .flags = 0x%" PRIx16 ", .type = %" PRIu16 " (%s) } ret = %d, err: %s"
+nbd_client_connect(const char *export_name) "export '%s'"
+nbd_client_connect_success(const char *export_name) "export '%s'"
 
 # ssh.c
 ssh_restart_coroutine(void *co) "co=%p"
-- 
2.18.0


