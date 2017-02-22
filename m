Received: from eggs.gnu.org ([2001:4830:134:3::10]:42600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpO-0004iC-NP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpJ-0002uk-R7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:54 -0500
Received: from [45.249.212.187] (port=2538 helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cgNpI-0002pk-Rb
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 22:42:49 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Wed, 22 Feb 2017 11:42:02 +0800
Message-ID: <1487734936-43472-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 01/15] net/colo: Add notifier/callback related
 helpers for filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com
Cc: lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>

We will use this notifier to help COLO to notify filter object
to do something, like do checkpoint, or process failover event.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 net/colo.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo.h | 18 ++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/net/colo.c b/net/colo.c
index 8cc166b..1697150 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "trace.h"
 #include "net/colo.h"
+#include "qapi/error.h"
 
 uint32_t connection_key_hash(const void *opaque)
 {
@@ -209,3 +210,94 @@ Connection *connection_get(GHashTable *connection_track_table,
 
     return conn;
 }
+
+static gboolean
+filter_notify_prepare(GSource *source, gint *timeout)
+{
+    *timeout = -1;
+
+    return FALSE;
+}
+
+static gboolean
+filter_notify_check(GSource *source)
+{
+    FilterNotifier *notify = (FilterNotifier *)source;
+
+    return notify->pfd.revents & (G_IO_IN | G_IO_HUP | G_IO_ERR);
+}
+
+static gboolean
+filter_notify_dispatch(GSource *source,
+                       GSourceFunc callback,
+                       gpointer user_data)
+{
+    FilterNotifier *notify = (FilterNotifier *)source;
+    int revents;
+    int ret;
+
+    revents = notify->pfd.revents & notify->pfd.events;
+    if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
+        ret = event_notifier_test_and_clear(&notify->event);
+        if (notify->cb) {
+            notify->cb(notify, ret);
+        }
+    }
+    return TRUE;
+}
+
+static void
+filter_notify_finalize(GSource *source)
+{
+    FilterNotifier *notify = (FilterNotifier *)source;
+
+    event_notifier_cleanup(&notify->event);
+}
+
+static GSourceFuncs notifier_source_funcs = {
+    filter_notify_prepare,
+    filter_notify_check,
+    filter_notify_dispatch,
+    filter_notify_finalize,
+};
+
+FilterNotifier *filter_noitifier_new(FilterNotifierCallback *cb,
+                    void *opaque, Error **errp)
+{
+    FilterNotifier *notify;
+    int ret;
+
+    notify = (FilterNotifier *)g_source_new(&notifier_source_funcs,
+                sizeof(FilterNotifier));
+    ret = event_notifier_init(&notify->event, false);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to initialize event notifier");
+        goto fail;
+    }
+    notify->pfd.fd = event_notifier_get_fd(&notify->event);
+    notify->pfd.events = G_IO_IN | G_IO_HUP | G_IO_ERR;
+    notify->cb = cb;
+    notify->opaque = opaque;
+    g_source_add_poll(&notify->source, &notify->pfd);
+
+    return notify;
+
+fail:
+    g_source_destroy(&notify->source);
+    return NULL;
+}
+
+int filter_notifier_set(FilterNotifier *notify, uint64_t value)
+{
+    ssize_t ret;
+
+    do {
+        ret = write(notify->event.wfd, &value, sizeof(value));
+    } while (ret < 0 && errno == EINTR);
+
+    /* EAGAIN is fine, a read must be pending.  */
+    if (ret < 0 && errno != EAGAIN) {
+        return -errno;
+    }
+    return 0;
+}
diff --git a/net/colo.h b/net/colo.h
index cd9027f..00f03b5 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -19,6 +19,7 @@
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
 #include "slirp/tcp.h"
+#include "qemu/event_notifier.h"
 
 #define HASHTABLE_MAX_SIZE 16384
 
@@ -89,4 +90,21 @@ void connection_hashtable_reset(GHashTable *connection_track_table);
 Packet *packet_new(const void *data, int size);
 void packet_destroy(void *opaque, void *user_data);
 
+typedef void FilterNotifierCallback(void *opaque, int value);
+typedef struct FilterNotifier {
+    GSource source;
+    EventNotifier event;
+    GPollFD pfd;
+    FilterNotifierCallback *cb;
+    void *opaque;
+} FilterNotifier;
+
+FilterNotifier *filter_noitifier_new(FilterNotifierCallback *cb,
+                    void *opaque, Error **errp);
+int filter_notifier_set(FilterNotifier *notify, uint64_t value);
+
+enum {
+    COLO_CHECKPOINT = 2,
+    COLO_FAILOVER,
+};
 #endif /* QEMU_COLO_PROXY_H */
-- 
1.8.3.1
