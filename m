Received: from eggs.gnu.org ([2001:4830:134:3::10]:53371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTY-0000Eg-RC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTU-0002LU-RQ
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45780
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTU-0002L3-N8
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESnEn077837
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:32 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vcdp0dn5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:32 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 09:32:31 -0500
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:27 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405874787.9522.9522647750502445479.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 3/7] tests: virtio-9p: add LOPEN operation test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The "fs_lopen" test creates a file on the backend, walks to it with
the walk operation and issues a LOPEN operation, which is expected to
succeed. Note that LOPEN is the OPEN operation implemented by the
9P2000.L version of the 9P protocol, which is used by the linux kernel
client.

References:

https://github.com/chaos/diod/blob/master/protocol.md#lopen----open-a-file
http://man.cat-v.org/plan_9/5/open

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 9556291567a4..14b4787930ae 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -243,6 +243,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RVERSION ? "RVERSION" :
         id == P9_RATTACH ? "RATTACH" :
         id == P9_RWALK ? "RWALK" :
+        id == P9_RLOPEN ? "RLOPEN" :
         "<unknown>";
 }
 
@@ -395,6 +396,33 @@ static void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid)
     v9fs_req_free(req);
 }
 
+/* size[4] Tlopen tag[2] fid[4] flags[4] */
+static P9Req *v9fs_tlopen(QVirtIO9P *v9p, uint32_t fid, uint32_t flags)
+{
+    P9Req *req;
+
+    req = v9fs_req_init(v9p,  4 + 4, P9_TLOPEN, ++(v9p->p9_req_tag));
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
@@ -483,6 +511,32 @@ static void fs_walk_dotdot(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_lopen(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(__func__) };
+    char *path = g_strdup_printf("%s/%s", v9p->test_share, wnames[0]);
+    uint32_t iounit;
+    int fd;
+    P9Req *req;
+
+    fd = creat(path, 0600);
+    g_assert(fd >= 0);
+    close(fd);
+
+    fs_attach(v9p);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames);
+    v9fs_rwalk(req, NULL, NULL);
+
+    req = v9fs_tlopen(v9p, 1, O_RDONLY);
+    v9fs_rlopen(req, NULL, &iounit);
+
+    g_assert_cmpint(iounit, <=, P9_MAX_SIZE - P9_IOHDRSZ);
+
+    unlink(path);
+    g_free(path);
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -512,6 +566,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/no_slash", fs_walk_no_slash);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/dotdot_from_root",
                        fs_walk_dotdot);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
 
     return g_test_run();
 }
