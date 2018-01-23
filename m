Received: from eggs.gnu.org ([208.118.235.92]:34611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ee8AR-0001sf-PR
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ee8AO-000789-Ac
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:39:51 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:56251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ee8AN-00075k-TH
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 18:39:48 -0500
Received: from player698.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1B684B9C92
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 00:39:46 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 24 Jan 2018 00:39:41 +0100
Message-ID: <151675078179.29381.692912942013037690.stgit@bahia.lan>
In-Reply-To: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
References: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 7/7] tests: virtio-9p: add FLUSH operation test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

The idea is to send a victim request that will possibly block in the
server and to send a flush request to cancel the victim request.

This patch adds two test to verifiy that:
- the server does not reply to a victim request that was actually
  cancelled
- the server replies to the flush request after replying to the
  victim request if it could not cancel it

9p request cancellation reference:

http://man.cat-v.org/plan_9/5/flush

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-synth.c     |   24 ++++++++++
 hw/9pfs/9p-synth.h     |    5 ++
 hw/9pfs/9p.c           |    1 
 tests/virtio-9p-test.c |  117 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 134 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index f2d59a90a670..0a9940dfa23c 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -521,6 +521,24 @@ static ssize_t v9fs_synth_qtest_write(void *buf, int len, off_t offset,
     return len;
 }
 
+static ssize_t v9fs_synth_qtest_flush_write(void *buf, int len, off_t offset,
+                                            void *arg)
+{
+    QtestV9fsSynthFlushData *data = buf;
+
+    assert(len == sizeof(*data));
+
+    if (data->usec_timeout) {
+        usleep(data->usec_timeout);
+
+        /* This will cause the server to call us again until we're cancelled */
+        errno = EINTR;
+        return -1;
+    }
+
+    return len;
+}
+
 static int synth_init(FsContext *ctx, Error **errp)
 {
     QLIST_INIT(&synth_root.child);
@@ -557,6 +575,12 @@ static int synth_init(FsContext *ctx, Error **errp)
         ret = qemu_v9fs_synth_add_file(NULL, 0, QTEST_V9FS_SYNTH_WRITE_FILE,
                                        NULL, v9fs_synth_qtest_write, ctx);
         assert(!ret);
+
+        /* File for FLUSH test */
+        ret = qemu_v9fs_synth_add_file(NULL, 0, QTEST_V9FS_SYNTH_FLUSH_FILE,
+                                       NULL, v9fs_synth_qtest_flush_write,
+                                       ctx);
+        assert(!ret);
     }
 
     return 0;
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index a74032d7bd9a..502ec6309a36 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -54,5 +54,10 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 #define QTEST_V9FS_SYNTH_WALK_FILE "WALK%d"
 #define QTEST_V9FS_SYNTH_LOPEN_FILE "LOPEN"
 #define QTEST_V9FS_SYNTH_WRITE_FILE "WRITE"
+#define QTEST_V9FS_SYNTH_FLUSH_FILE "FLUSH"
+
+typedef struct {
+    uint32_t usec_timeout;
+} QtestV9fsSynthFlushData;
 
 #endif
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 73dafffe239f..eae82db4ef60 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -24,6 +24,7 @@
 #include "coth.h"
 #include "trace.h"
 #include "migration/blocker.h"
+#include "sysemu/qtest.h"
 
 int open_fd_hw;
 int total_open_fd;
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 57ae3a666c61..b234e09e252d 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -247,14 +247,15 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RWALK ? "RWALK" :
         id == P9_RLOPEN ? "RLOPEN" :
         id == P9_RWRITE ? "RWRITE" :
+        id == P9_RFLUSH ? "RFLUSH" :
         "<unknown>";
 }
 
-static void v9fs_req_wait_for_reply(P9Req *req)
+static void v9fs_req_wait_for_reply(P9Req *req, uint32_t *len)
 {
     QVirtIO9P *v9p = req->v9p;
 
-    qvirtio_wait_used_elem(v9p->dev, v9p->vq, req->free_head, NULL,
+    qvirtio_wait_used_elem(v9p->dev, v9p->vq, req->free_head, len,
                            QVIRTIO_9P_TIMEOUT_US);
 }
 
@@ -451,6 +452,24 @@ static void v9fs_rwrite(P9Req *req, uint32_t *count)
     v9fs_req_free(req);
 }
 
+/* size[4] Tflush tag[2] oldtag[2] */
+static P9Req *v9fs_tflush(QVirtIO9P *v9p, uint16_t oldtag, uint16_t tag)
+{
+    P9Req *req;
+
+    req = v9fs_req_init(v9p,  2, P9_TFLUSH, tag);
+    v9fs_uint32_write(req, oldtag);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rflush tag[2] */
+static void v9fs_rflush(P9Req *req)
+{
+    v9fs_req_recv(req, P9_RFLUSH);
+    v9fs_req_free(req);
+}
+
 static void fs_version(QVirtIO9P *v9p)
 {
     const char *version = "9P2000.L";
@@ -459,7 +478,7 @@ static void fs_version(QVirtIO9P *v9p)
     P9Req *req;
 
     req = v9fs_tversion(v9p, P9_MAX_SIZE, version, P9_NOTAG);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rversion(req, &server_len, &server_version);
 
     g_assert_cmpmem(server_version, server_len, version, strlen(version));
@@ -473,7 +492,7 @@ static void fs_attach(QVirtIO9P *v9p)
 
     fs_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, NULL);
 }
 
@@ -491,7 +510,7 @@ static void fs_walk(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, &nwqid, &wqid);
 
     g_assert_cmpint(nwqid, ==, P9_MAXWELEM);
@@ -511,7 +530,7 @@ static void fs_walk_no_slash(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlerror(req, &err);
 
     g_assert_cmpint(err, ==, ENOENT);
@@ -527,11 +546,11 @@ static void fs_walk_dotdot(QVirtIO9P *v9p)
 
     fs_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, &root_qid);
 
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, &wqid); /* We now we'll get one qid */
 
     g_assert_cmpmem(&root_qid, 13, wqid[0], 13);
@@ -547,11 +566,11 @@ static void fs_lopen(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
 
     req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlopen(req, NULL, NULL);
 
     g_free(wnames[0]);
@@ -567,21 +586,91 @@ static void fs_write(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, NULL, NULL);
 
     req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlopen(req, NULL, NULL);
 
     req = v9fs_twrite(v9p, 1, 0, write_count, buf, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwrite(req, &count);
     g_assert_cmpint(count, ==, write_count);
 
     g_free(wnames[0]);
 }
 
+static void fs_flush_success(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_FLUSH_FILE) };
+    QtestV9fsSynthFlushData data;
+    P9Req *req, *flush_req;
+    uint32_t reply_len;
+
+    fs_attach(v9p);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+
+    req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlopen(req, NULL, NULL);
+
+    /* This will cause the 9p server to try to write data to the backend,
+     * until the write request gets cancelled.
+     */
+    data.usec_timeout = 10;
+    req = v9fs_twrite(v9p, 1, 0, sizeof(data), &data, 0);
+
+    flush_req = v9fs_tflush(v9p, req->tag, 1);
+
+    /* The write request is supposed to be flushed: the server should just
+     * mark the write request as used and reply to the flush request.
+     */
+    v9fs_req_wait_for_reply(req, &reply_len);
+    g_assert_cmpint(reply_len, ==, 0);
+    v9fs_req_free(req);
+    v9fs_rflush(flush_req);
+
+    g_free(wnames[0]);
+}
+
+static void fs_flush_ignored(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_FLUSH_FILE) };
+    QtestV9fsSynthFlushData data;
+    P9Req *req, *flush_req;
+    uint32_t count;
+
+    fs_attach(v9p);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+
+    req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rlopen(req, NULL, NULL);
+
+    /* This will cause the write request to complete right away, before it
+     * could be actually cancelled.
+     */
+    data.usec_timeout = 0;
+    req = v9fs_twrite(v9p, 1, 0, sizeof(data), &data, 0);
+
+    flush_req = v9fs_tflush(v9p, req->tag, 1);
+
+    /* The write request is supposed to complete. The server should
+     * reply to the write request and the flush request.
+     */
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwrite(req, &count);
+    g_assert_cmpint(count, ==, sizeof(data));
+    v9fs_rflush(flush_req);
+
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -613,6 +702,8 @@ int main(int argc, char **argv)
                        fs_walk_dotdot);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/write/basic", fs_write);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/flush/success", fs_flush_success);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/flush/ignored", fs_flush_ignored);
 
     return g_test_run();
 }
