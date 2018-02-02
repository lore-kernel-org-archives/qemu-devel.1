Received: from eggs.gnu.org ([2001:4830:134:3::10]:47776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe5I-0006iE-MQ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:22:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe4C-0004Br-MY
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:21:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehe4B-00049v-9R
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12GHcQv109417
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 11:19:54 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvrynq8s4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 11:19:53 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 2 Feb 2018 16:19:51 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri,  2 Feb 2018 17:19:34 +0100
In-Reply-To: <20180202161935.20803-1-groug@kaod.org>
References: <20180202161935.20803-1-groug@kaod.org>
Message-Id: <20180202161935.20803-10-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 09/10] tests: virtio-9p: add FLUSH operation
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(groug, change the test to only write a single byte to avoid
        any alignment or endianess consideration)
---
 hw/9pfs/9p-synth.c     |  20 +++++++++
 hw/9pfs/9p-synth.h     |   7 +++
 hw/9pfs/9p.c           |   1 +
 tests/virtio-9p-test.c | 117 +++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 132 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index ade346070601..18082dffe865 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -521,6 +521,20 @@ static ssize_t v9fs_synth_qtest_write(void *buf, int len, off_t offset,
     return 1;
 }
 
+static ssize_t v9fs_synth_qtest_flush_write(void *buf, int len, off_t offset,
+                                            void *arg)
+{
+    bool should_block = !!*(uint8_t *)buf;
+
+    if (should_block) {
+        /* This will cause the server to call us again until we're cancelled */
+        errno = EINTR;
+        return -1;
+    }
+
+    return 1;
+}
+
 static int synth_init(FsContext *ctx, Error **errp)
 {
     QLIST_INIT(&synth_root.child);
@@ -557,6 +571,12 @@ static int synth_init(FsContext *ctx, Error **errp)
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
index a74032d7bd9a..af7a993a1e8e 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -55,4 +55,11 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 #define QTEST_V9FS_SYNTH_LOPEN_FILE "LOPEN"
 #define QTEST_V9FS_SYNTH_WRITE_FILE "WRITE"
 
+/* Any write to the "FLUSH" file is handled one byte at a time by the
+ * backend. If the byte is zero, the backend returns success (ie, 1),
+ * otherwise it forces the server to try again forever. Thus allowing
+ * the client to cancel the request.
+ */
+#define QTEST_V9FS_SYNTH_FLUSH_FILE "FLUSH"
+
 #endif
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e88bb50f1365..85a1ed8171a4 100644
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
index 0d0341491e79..0d3334a6ce17 100644
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
 
@@ -454,6 +455,24 @@ static void v9fs_rwrite(P9Req *req, uint32_t *count)
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
@@ -462,7 +481,7 @@ static void fs_version(QVirtIO9P *v9p)
     P9Req *req;
 
     req = v9fs_tversion(v9p, P9_MAX_SIZE, version, P9_NOTAG);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rversion(req, &server_len, &server_version);
 
     g_assert_cmpmem(server_version, server_len, version, strlen(version));
@@ -476,7 +495,7 @@ static void fs_attach(QVirtIO9P *v9p)
 
     fs_version(v9p);
     req = v9fs_tattach(v9p, 0, getuid(), 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rattach(req, NULL);
 }
 
@@ -494,7 +513,7 @@ static void fs_walk(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rwalk(req, &nwqid, &wqid);
 
     g_assert_cmpint(nwqid, ==, P9_MAXWELEM);
@@ -514,7 +533,7 @@ static void fs_walk_no_slash(QVirtIO9P *v9p)
 
     fs_attach(v9p);
     req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
-    v9fs_req_wait_for_reply(req);
+    v9fs_req_wait_for_reply(req, NULL);
     v9fs_rlerror(req, &err);
 
     g_assert_cmpint(err, ==, ENOENT);
@@ -530,11 +549,11 @@ static void fs_walk_dotdot(QVirtIO9P *v9p)
 
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
@@ -550,11 +569,11 @@ static void fs_lopen(QVirtIO9P *v9p)
 
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
@@ -570,15 +589,15 @@ static void fs_write(QVirtIO9P *v9p)
 
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
 
@@ -586,6 +605,76 @@ static void fs_write(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_flush_success(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_FLUSH_FILE) };
+    P9Req *req, *flush_req;
+    uint32_t reply_len;
+    uint8_t should_block;
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
+    should_block = 1;
+    req = v9fs_twrite(v9p, 1, 0, sizeof(should_block), &should_block, 0);
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
+    P9Req *req, *flush_req;
+    uint32_t count;
+    uint8_t should_block;
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
+    should_block = 0;
+    req = v9fs_twrite(v9p, 1, 0, sizeof(should_block), &should_block, 0);
+
+    flush_req = v9fs_tflush(v9p, req->tag, 1);
+
+    /* The write request is supposed to complete. The server should
+     * reply to the write request and the flush request.
+     */
+    v9fs_req_wait_for_reply(req, NULL);
+    v9fs_rwrite(req, &count);
+    g_assert_cmpint(count, ==, sizeof(should_block));
+    v9fs_rflush(flush_req);
+
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -617,6 +706,8 @@ int main(int argc, char **argv)
                        fs_walk_dotdot);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/write/basic", fs_write);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/flush/success", fs_flush_success);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/flush/ignored", fs_flush_ignored);
 
     return g_test_run();
 }
-- 
2.13.6
