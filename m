Received: from eggs.gnu.org ([209.51.188.92]:48145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB82-0001x2-Pg
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB81-0007Rh-Sv
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 15:55:58 +0300
Message-Id: <20190211125601.86533-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-1-vsementsov@virtuozzo.com>
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 1/4] io/channel: add
 qio_channel_get_attached_aio_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Expose attached aio context. It will be used in nbd code, to
understand, in which aio context negotiation should be done.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/io/channel.h | 9 +++++++++
 io/channel.c         | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/include/io/channel.h b/include/io/channel.h
index da2f138200..1a1e4a01b0 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -718,6 +718,15 @@ GSource *qio_channel_add_watch_source(QIOChannel *ioc,
 void qio_channel_attach_aio_context(QIOChannel *ioc,
                                     AioContext *ctx);
 
+/*
+ * qio_channel_get_aio_context
+ * @ioc: the channel object
+ *
+ * Returns channel AioContext if any attached by
+ * qio_channel_attach_aio_context(), otherwise NULL.
+ */
+AioContext *qio_channel_get_attached_aio_context(QIOChannel *ioc);
+
 /**
  * qio_channel_detach_aio_context:
  * @ioc: the channel object
diff --git a/io/channel.c b/io/channel.c
index 8dd0684f5d..a1b937bb6b 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -454,6 +454,11 @@ void qio_channel_detach_aio_context(QIOChannel *ioc)
     ioc->ctx = NULL;
 }
 
+AioContext *qio_channel_get_attached_aio_context(QIOChannel *ioc)
+{
+    return ioc->ctx;
+}
+
 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
                                     GIOCondition condition)
 {
-- 
2.18.0
