Received: from eggs.gnu.org ([2001:4830:134:3::10]:34055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qWy-0000pW-Am
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qWv-0003lP-8A
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:36 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3470
	helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d1qWu-0003k7-LA
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 04:36:33 -0400
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Sat, 22 Apr 2017 16:35:11 +0800
Message-ID: <1492850128-17472-2-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v2 01/18] net/colo: Add
 notifier/callback related helpers for filter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com
Cc: quintela@redhat.com, zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Jason Wang <jasowang@redhat.com>, Li
	Zhijian <lizhijian@cn.fujitsu.com>

We will use this notifier to help COLO to notify filter object
to do something, like do checkpoint, or process failover event.

Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 net/colo.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 net/colo.h |  19 +++++++++++
 2 files changed, 124 insertions(+)

diff --git a/net/colo.c b/net/colo.c
index 8cc166b..8aef670 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "trace.h"
 #include "net/colo.h"
+#include "qapi/error.h"
 
 uint32_t connection_key_hash(const void *opaque)
 {
@@ -209,3 +210,107 @@ Connection *connection_get(GHashTable *connection_track_table,
 
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
+    uint64_t value;
+    int ret;
+
+    revents = notify->pfd.revents & notify->pfd.events;
+    if (revents & (G_IO_IN | G_IO_HUP | G_IO_ERR)) {
+        ret = filter_notifier_get(notify, &value);
+        if (notify->cb && !ret) {
+            notify->cb(notify, value);
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
+FilterNotifier *filter_notifier_new(FilterNotifierCallback *cb,
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
+
+int filter_notifier_get(FilterNotifier *notify, uint64_t *value)
+{
+    ssize_t len;
+
+    /* Drain the notify pipe.  For eventfd, only 8 bytes will be read.  */
+    do {
+        len = read(notify->event.rfd, value, sizeof(*value));
+    } while ((len == -1 && errno == EINTR));
+
+    return len != sizeof(*value) ? -1 : 0;
+}
diff --git a/net/colo.h b/net/colo.h
index cd9027f..b586db3 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -19,6 +19,7 @@
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
 #include "slirp/tcp.h"
+#include "qemu/event_notifier.h"
 
 #define HASHTABLE_MAX_SIZE 16384
 
@@ -89,4 +90,22 @@ void connection_hashtable_reset(GHashTable *connection_track_table);
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
+FilterNotifier *filter_notifier_new(FilterNotifierCallback *cb,
+                    void *opaque, Error **errp);
+int filter_notifier_set(FilterNotifier *notify, uint64_t value);
+int filter_notifier_get(FilterNotifier *notify, uint64_t *value);
+
+enum {
+    COLO_CHECKPOINT = 2,
+    COLO_FAILOVER,
+};
 #endif /* QEMU_COLO_PROXY_H */
-- 
1.8.3.1
