Received: from eggs.gnu.org ([2001:4830:134:3::10]:54170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe5l-0001ON-Go
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ehe4A-00049h-FN
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:21:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ehe49-00047j-JP
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:19:53 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12GJpDN023423
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 11:19:52 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvsncndsn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 11:19:51 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 2 Feb 2018 16:19:48 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri,  2 Feb 2018 17:19:32 +0100
In-Reply-To: <20180202161935.20803-1-groug@kaod.org>
References: <20180202161935.20803-1-groug@kaod.org>
Message-Id: <20180202161935.20803-8-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 07/10] tests: virtio-9p: add WRITE operation
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

Trivial test of a successful write.

Signed-off-by: Greg Kurz <groug@kaod.org>
(groug, handle potential overflow when computing request size,
        add missing g_free(buf),
        backend handles one written byte at a time to validate
        the server doesn't do short-reads)
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-synth.c     | 11 +++++++++
 hw/9pfs/9p-synth.h     |  1 +
 tests/virtio-9p-test.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index f17b74f44461..ade346070601 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -515,6 +515,12 @@ static int synth_unlinkat(FsContext *ctx, V9fsPath *dir,
     return -1;
 }
 
+static ssize_t v9fs_synth_qtest_write(void *buf, int len, off_t offset,
+                                      void *arg)
+{
+    return 1;
+}
+
 static int synth_init(FsContext *ctx, Error **errp)
 {
     QLIST_INIT(&synth_root.child);
@@ -546,6 +552,11 @@ static int synth_init(FsContext *ctx, Error **errp)
         ret = qemu_v9fs_synth_add_file(NULL, 0, QTEST_V9FS_SYNTH_LOPEN_FILE,
                                        NULL, NULL, ctx);
         assert(!ret);
+
+        /* File for WRITE test */
+        ret = qemu_v9fs_synth_add_file(NULL, 0, QTEST_V9FS_SYNTH_WRITE_FILE,
+                                       NULL, v9fs_synth_qtest_write, ctx);
+        assert(!ret);
     }
 
     return 0;
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index 2a8d6fd00d69..a74032d7bd9a 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -53,5 +53,6 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 
 #define QTEST_V9FS_SYNTH_WALK_FILE "WALK%d"
 #define QTEST_V9FS_SYNTH_LOPEN_FILE "LOPEN"
+#define QTEST_V9FS_SYNTH_WRITE_FILE "WRITE"
 
 #endif
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 6ba782e24f3a..12315aeb4e5b 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -150,6 +150,13 @@ static void v9fs_uint32_write(P9Req *req, uint32_t val)
     v9fs_memwrite(req, &le_val, 4);
 }
 
+static void v9fs_uint64_write(P9Req *req, uint64_t val)
+{
+    uint64_t le_val = cpu_to_le64(val);
+
+    v9fs_memwrite(req, &le_val, 8);
+}
+
 static void v9fs_uint32_read(P9Req *req, uint32_t *val)
 {
     v9fs_memread(req, val, 4);
@@ -239,6 +246,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RATTACH ? "RATTACH" :
         id == P9_RWALK ? "RWALK" :
         id == P9_RLOPEN ? "RLOPEN" :
+        id == P9_RWRITE ? "RWRITE" :
         "<unknown>";
 }
 
@@ -418,6 +426,34 @@ static void v9fs_rlopen(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
     v9fs_req_free(req);
 }
 
+/* size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count] */
+static P9Req *v9fs_twrite(QVirtIO9P *v9p, uint32_t fid, uint64_t offset,
+                          uint32_t count, const void *data, uint16_t tag)
+{
+    P9Req *req;
+    uint32_t body_size = 4 + 8 + 4;
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - count);
+    body_size += count;
+    req = v9fs_req_init(v9p,  body_size, P9_TWRITE, tag);
+    v9fs_uint32_write(req, fid);
+    v9fs_uint64_write(req, offset);
+    v9fs_uint32_write(req, count);
+    v9fs_memwrite(req, data, count);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rwrite tag[2] count[4] */
+static void v9fs_rwrite(P9Req *req, uint32_t *count)
+{
+    v9fs_req_recv(req, P9_RWRITE);
+    if (count) {
+        v9fs_uint32_read(req, count);
+    }
+    v9fs_req_free(req);
+}
+
 static void fs_version(QVirtIO9P *v9p)
 {
     const char *version = "9P2000.L";
@@ -524,6 +560,32 @@ static void fs_lopen(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_write(QVirtIO9P *v9p)
+{
+    static const uint32_t write_count = P9_MAX_SIZE / 2;
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_WRITE_FILE) };
+    char *buf = g_malloc0(write_count);
+    uint32_t count;
+    P9Req *req;
+
+    fs_attach(v9p);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames, 0);
+    v9fs_req_wait_for_reply(req);
+    v9fs_rwalk(req, NULL, NULL);
+
+    req = v9fs_tlopen(v9p, 1, O_WRONLY, 0);
+    v9fs_req_wait_for_reply(req);
+    v9fs_rlopen(req, NULL, NULL);
+
+    req = v9fs_twrite(v9p, 1, 0, write_count, buf, 0);
+    v9fs_req_wait_for_reply(req);
+    v9fs_rwrite(req, &count);
+    g_assert_cmpint(count, ==, write_count);
+
+    g_free(buf);
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -554,6 +616,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/dotdot_from_root",
                        fs_walk_dotdot);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/write/basic", fs_write);
 
     return g_test_run();
 }
-- 
2.13.6
