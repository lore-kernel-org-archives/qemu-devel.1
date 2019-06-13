Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCDC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D468E20645
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 17:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D468E20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42278 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTRv-0001dw-JW
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35740)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eblake@redhat.com>) id 1hbRyS-0002uM-EY
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1hbRyQ-0006iU-Vf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 11:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48912)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1hbRy9-0006XN-8C; Thu, 13 Jun 2019 11:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2567BB2DCE;
 Thu, 13 Jun 2019 15:48:52 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-85.phx2.redhat.com [10.3.116.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33F197C581;
 Thu, 13 Jun 2019 15:48:49 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 10:48:35 -0500
Message-Id: <20190613154837.21734-8-eblake@redhat.com>
In-Reply-To: <20190613154837.21734-1-eblake@redhat.com>
References: <20190613154837.21734-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 13 Jun 2019 15:48:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/9] block/nbd-client: drop stale logout
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
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Drop one on failure path (we have errp) and turn two others into trace
points.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20190611102720.86114-2-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.h | 9 ---------
 block/nbd-client.c | 6 +++---
 block/trace-events | 2 ++
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/nbd-client.h b/block/nbd-client.h
index 4587053114af..570538f4c884 100644
--- a/block/nbd-client.h
+++ b/block/nbd-client.h
@@ -5,15 +5,6 @@
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
index 790ecc1ee1cb..f89a67c23b64 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -1136,7 +1136,7 @@ static int nbd_client_connect(BlockDriverState *bs,
     }

     /* NBD handshake */
-    logout("session init %s\n", export);
+    trace_nbd_client_connect(export);
     qio_channel_set_blocking(QIO_CHANNEL(sioc), true, NULL);

     client->info.request_sizes =3D true;
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
index eab51497fc0f..01fa5eb081be 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -165,6 +165,8 @@ nbd_parse_blockstatus_compliance(const char *err) "ig=
noring extra data from non-
 nbd_structured_read_compliance(const char *type) "server sent non-compli=
ant unaligned read %s chunk"
 nbd_read_reply_entry_fail(int ret, const char *err) "ret =3D %d, err: %s=
"
 nbd_co_request_fail(uint64_t from, uint32_t len, uint64_t handle, uint16=
_t flags, uint16_t type, const char *name, int ret, const char *err) "Req=
uest failed { .from =3D %" PRIu64", .len =3D %" PRIu32 ", .handle =3D %" =
PRIu64 ", .flags =3D 0x%" PRIx16 ", .type =3D %" PRIu16 " (%s) } ret =3D =
%d, err: %s"
+nbd_client_connect(const char *export_name) "export '%s'"
+nbd_client_connect_success(const char *export_name) "export '%s'"

 # ssh.c
 ssh_restart_coroutine(void *co) "co=3D%p"
--=20
2.20.1


