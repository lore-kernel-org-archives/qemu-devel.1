Received: from eggs.gnu.org ([2001:4830:134:3::10]:43030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHTe-0001BO-CU
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHTa-0000D9-Bc
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFHTa-0000Cf-38
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:22 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB99Ow9j046607
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 04:28:21 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277ru1aybk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 04:28:20 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 9 Dec 2016 02:28:20 -0700
From: Greg Kurz <groug@kaod.org>
Date: Fri, 09 Dec 2016 10:28:15 +0100
In-Reply-To: <148127558476.2633.13433882390740185948.stgit@bahia>
References: <148127558476.2633.13433882390740185948.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148127569509.2633.12364612819225579911.stgit@bahia>
Subject: [Qemu-devel] [PATCH 5/8] tests: virtio-9p: add attach operation test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

The attach operation is used to establish a connection between the
client and the server. After this, the client is able to access the
underlying filesystem and do I/O.

This test simply ensures the operation succeeds without error.

Reference:

http://man.cat-v.org/plan_9/5/attach

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index b3ee956cbcb2..37a256ef4a59 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -25,6 +25,7 @@ typedef struct {
     QOSState *qs;
     QVirtQueue *vq;
     char *test_share;
+    uint16_t p9_req_tag;
 } QVirtIO9P;
 
 static QVirtIO9P *qvirtio_9p_start(const char *driver)
@@ -304,6 +305,35 @@ static void v9fs_rversion(P9Req *req, uint16_t *len, char **version)
     v9fs_req_free(req);
 }
 
+/* size[4] Tattach tag[2] fid[4] afid[4] uname[s] aname[s] n_uname[4] */
+static P9Req *v9fs_tattach(QVirtIO9P *v9p, uint32_t fid, uint32_t n_uname)
+{
+    const char *uname = ""; /* ignored by QEMU */
+    const char *aname = ""; /* ignored by QEMU */
+    P9Req *req = v9fs_req_init(v9p, 4 + 4 + 2 + 2 + 4, P9_TATTACH,
+                               ++(v9p->p9_req_tag));
+
+    v9fs_uint32_write(req, fid);
+    v9fs_uint32_write(req, P9_NOFID);
+    v9fs_string_write(req, uname);
+    v9fs_string_write(req, aname);
+    v9fs_uint32_write(req, n_uname);
+    v9fs_req_send(req);
+    return req;
+}
+
+typedef char v9fs_qid[13];
+
+/* size[4] Rattach tag[2] qid[13] */
+static void v9fs_rattach(P9Req *req, v9fs_qid *qid)
+{
+    v9fs_req_recv(req, P9_RATTACH);
+    if (qid) {
+        v9fs_memread(req, qid, 13);
+    }
+    v9fs_req_free(req);
+}
+
 static void fs_version(QVirtIO9P *v9p)
 {
     const char *version = "9P2000.L";
@@ -319,6 +349,15 @@ static void fs_version(QVirtIO9P *v9p)
     g_free(server_version);
 }
 
+static void fs_attach(QVirtIO9P *v9p)
+{
+    P9Req *req;
+
+    fs_version(v9p);
+    req = v9fs_tattach(v9p, 0, getuid());
+    v9fs_rattach(req, NULL);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -343,6 +382,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/nop", NULL);
     v9fs_qtest_pci_add("/virtio/9p/pci/config", pci_config);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/version/basic", fs_version);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/attach/basic", fs_attach);
 
     return g_test_run();
 }
