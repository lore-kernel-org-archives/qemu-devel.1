Received: from eggs.gnu.org ([2001:4830:134:3::10]:52336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZt1-0008Jx-3T
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1egZsv-0004IP-TQ
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46144
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1egZsv-00049W-Ly
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:39:53 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0UHdeXq020635
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:45 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ftuq8cs3j-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 12:39:45 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 Jan 2018 17:39:43 -0000
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 Jan 2018 18:39:31 +0100
In-Reply-To: <20180130173935.5172-1-groug@kaod.org>
References: <20180130173935.5172-1-groug@kaod.org>
Message-Id: <20180130173935.5172-7-groug@kaod.org>
Subject: [Qemu-devel] [PULL 06/10] tests: virtio-9p: add LOPEN operation test
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

Trivial test of a successful open.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/9pfs/9p-synth.c     |  5 +++++
 hw/9pfs/9p-synth.h     |  1 +
 tests/virtio-9p-test.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index dcbd320da17a..f17b74f44461 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -541,6 +541,11 @@ static int synth_init(FsContext *ctx, Error **errp)
             assert(!ret);
             g_free(name);
         }
+
+        /* File for LOPEN test */
+        ret = qemu_v9fs_synth_add_file(NULL, 0, QTEST_V9FS_SYNTH_LOPEN_FILE,
+                                       NULL, NULL, ctx);
+        assert(!ret);
     }
 
     return 0;
diff --git a/hw/9pfs/9p-synth.h b/hw/9pfs/9p-synth.h
index 876b4ef58288..2a8d6fd00d69 100644
--- a/hw/9pfs/9p-synth.h
+++ b/hw/9pfs/9p-synth.h
@@ -52,5 +52,6 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, int mode,
 /* qtest stuff */
 
 #define QTEST_V9FS_SYNTH_WALK_FILE "WALK%d"
+#define QTEST_V9FS_SYNTH_LOPEN_FILE "LOPEN"
 
 #endif
diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 652198156731..6ba782e24f3a 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -238,6 +238,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RVERSION ? "RVERSION" :
         id == P9_RATTACH ? "RATTACH" :
         id == P9_RWALK ? "RWALK" :
+        id == P9_RLOPEN ? "RLOPEN" :
         "<unknown>";
 }
 
@@ -389,6 +390,34 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid)
     v9fs_req_free(req);
 }
 
+/* size[4] Tlopen tag[2] fid[4] flags[4] */
+static P9Req *v9fs_tlopen(QVirtIO9P *v9p, uint32_t fid, uint32_t flags,
+                          uint16_t tag)
+{
+    P9Req *req;
+
+    req = v9fs_req_init(v9p,  4 + 4, P9_TLOPEN, tag);
+    v9fs_uint32_write(req, fid);
+    v9fs_uint32_write(req, flags);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rlopen tag[2] qid[13] iounit[4] */
+static void v9fs_rlopen(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
+{
+    v9fs_req_recv(req, P9_RLOPEN);
+    if (qid) {
+        v9fs_memread(req, qid, 13);
+    } else {
+        v9fs_memskip(req, 13);
+    }
+    if (iounit) {
+        v9fs_uint32_read(req, iounit);
+    }
+    v9fs_req_free(req);
+}
+
 static void fs_version(QVirtIO9P *v9p)
 {
     const char *version = "9P2000.L";
@@ -478,6 +507,23 @@ static void fs_walk_dotdot(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_lopen(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(QTEST_V9FS_SYNTH_LOPEN_FILE) };
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
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -507,6 +553,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/no_slash", fs_walk_no_slash);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/dotdot_from_root",
                        fs_walk_dotdot);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
 
     return g_test_run();
 }
-- 
2.13.6
