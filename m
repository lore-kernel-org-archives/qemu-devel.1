Received: from eggs.gnu.org ([209.51.188.92]:48149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB83-0001x3-0n
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gtB81-0007RO-Qb
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 07:56:06 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 11 Feb 2019 15:55:59 +0300
Message-Id: <20190211125601.86533-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190211125601.86533-1-vsementsov@virtuozzo.com>
References: <20190211125601.86533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/4] nbd/client: do negotiation in coroutine
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

As a first step to non-blocking negotiation, move it to coroutine.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 123 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 109 insertions(+), 14 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 10a52ad7d0..2ba2220a4a 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -859,13 +859,14 @@ static int nbd_list_meta_contexts(QIOChannel *ioc,
  *          2: server is newstyle, but lacks structured replies
  *          3: server is newstyle and set up for structured replies
  */
-static int nbd_start_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
-                               const char *hostname, QIOChannel **outioc,
-                               bool structured_reply, bool *zeroes,
-                               Error **errp)
+static int coroutine_fn nbd_co_start_negotiate(
+        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostname,
+        QIOChannel **outioc, bool structured_reply, bool *zeroes, Error **errp)
 {
     uint64_t magic;
 
+    assert(qemu_in_coroutine());
+
     trace_nbd_start_negotiate(tlscreds, hostname ? hostname : "<null>");
 
     if (zeroes) {
@@ -990,19 +991,20 @@ static int nbd_negotiate_finish_oldstyle(QIOChannel *ioc, NBDExportInfo *info,
  * Returns: negative errno: failure talking to server
  *          0: server is connected
  */
-int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
-                          const char *hostname, QIOChannel **outioc,
-                          NBDExportInfo *info, Error **errp)
+static int coroutine_fn nbd_co_receive_negotiate(
+        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostname,
+        QIOChannel **outioc, NBDExportInfo *info, Error **errp)
 {
     int result;
     bool zeroes;
     bool base_allocation = info->base_allocation;
 
+    assert(qemu_in_coroutine());
     assert(info->name);
     trace_nbd_receive_negotiate_name(info->name);
 
-    result = nbd_start_negotiate(ioc, tlscreds, hostname, outioc,
-                                 info->structured_reply, &zeroes, errp);
+    result = nbd_co_start_negotiate(ioc, tlscreds, hostname, outioc,
+                                   info->structured_reply, &zeroes, errp);
 
     info->structured_reply = false;
     info->base_allocation = false;
@@ -1108,9 +1110,9 @@ void nbd_free_export_list(NBDExportInfo *info, int count)
  * in @info by the server, or -1 on error. Caller must free @info using
  * nbd_free_export_list().
  */
-int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
-                            const char *hostname, NBDExportInfo **info,
-                            Error **errp)
+static int coroutine_fn nbd_co_receive_export_list(
+        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostname,
+        NBDExportInfo **info, Error **errp)
 {
     int result;
     int count = 0;
@@ -1120,9 +1122,10 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     NBDExportInfo *array = NULL;
     QIOChannel *sioc = NULL;
 
+    assert(qemu_in_coroutine());
     *info = NULL;
-    result = nbd_start_negotiate(ioc, tlscreds, hostname, &sioc, true, NULL,
-                                 errp);
+    result = nbd_co_start_negotiate(ioc, tlscreds, hostname, &sioc, true, NULL,
+                                    errp);
     if (tlscreds && sioc) {
         ioc = sioc;
     }
@@ -1212,6 +1215,98 @@ int nbd_receive_export_list(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
     return ret;
 }
 
+typedef struct NbdReceiveNegotiateCo {
+    QIOChannel *ioc;
+    QCryptoTLSCreds *tlscreds;
+    const char *hostname;
+    union {
+        struct {
+            QIOChannel **outioc;
+            NBDExportInfo *info;
+        } negotiate;
+        struct {
+            NBDExportInfo **info;
+        } export_list;
+    };
+    Error **errp;
+    int ret;
+} NbdReceiveNegotiateCo;
+
+static void coroutine_fn nbd_receive_negotiate_entry(void *opaque)
+{
+    NbdReceiveNegotiateCo *s = opaque;
+
+    s->ret = nbd_co_receive_negotiate(s->ioc, s->tlscreds, s->hostname,
+                                      s->negotiate.outioc, s->negotiate.info,
+                                      s->errp);
+}
+
+static void coroutine_fn nbd_receive_export_list_entry(void *opaque)
+{
+    NbdReceiveNegotiateCo *s = opaque;
+
+    s->ret = nbd_co_receive_export_list(s->ioc, s->tlscreds, s->hostname,
+                                        s->export_list.info, s->errp);
+}
+
+static int nbd_receive_common(CoroutineEntry *entry,
+                              NbdReceiveNegotiateCo *data)
+{
+    data->ret = -EINPROGRESS;
+
+    if (qemu_in_coroutine()) {
+        entry(data);
+    } else {
+        AioContext *ctx = qio_channel_get_attached_aio_context(data->ioc);
+        bool attach = !ctx;
+
+        if (attach) {
+            ctx = qemu_get_current_aio_context();
+            qio_channel_attach_aio_context(data->ioc, ctx);
+        }
+
+        qemu_aio_coroutine_enter(ctx, qemu_coroutine_create(entry, data));
+        AIO_WAIT_WHILE(ctx, data->ret == -EINPROGRESS);
+
+        if (attach) {
+            qio_channel_detach_aio_context(data->ioc);
+        }
+    }
+
+    return data->ret;
+}
+
+int nbd_receive_negotiate(
+        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostname,
+        QIOChannel **outioc, NBDExportInfo *info, Error **errp)
+{
+    NbdReceiveNegotiateCo data = {
+        .ioc = ioc,
+        .tlscreds = tlscreds,
+        .hostname = hostname,
+        .negotiate.outioc = outioc,
+        .negotiate.info = info,
+        .errp = errp,
+    };
+
+    return nbd_receive_common(nbd_receive_negotiate_entry, &data);
+}
+
+int nbd_receive_export_list(
+        QIOChannel *ioc, QCryptoTLSCreds *tlscreds, const char *hostname,
+        NBDExportInfo **info, Error **errp)
+{
+    NbdReceiveNegotiateCo data = {
+        .ioc = ioc,
+        .tlscreds = tlscreds,
+        .hostname = hostname,
+        .export_list.info = info,
+        .errp = errp,
+    };
+
+    return nbd_receive_common(nbd_receive_export_list_entry, &data);
+}
+
 #ifdef __linux__
 int nbd_init(int fd, QIOChannelSocket *sioc, NBDExportInfo *info,
              Error **errp)
-- 
2.18.0
