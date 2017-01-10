Received: from eggs.gnu.org ([2001:4830:134:3::10]:53505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTt-0000Wx-MK
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:33:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTp-0002Ud-Lg
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43269
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTp-0002UV-Fg
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:53 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESn8L093699
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:53 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27vv8j5p0m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:52 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 07:32:50 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:46 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405876653.9522.4734781387233985335.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 6/7] tests: virtio-9p: add LCREATE operation
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
Cc: Eric Blake <eblake@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

The "fs_lcreate" test clones the root directory fid, walks to it and
issues a LCREATE operation, which is expected to succeed. It then
ensures a file was indeed created in the underlying filesystem.
Note that LCREATE is the CREATE operation implemented by the 9P2000.L
version of the 9P protocol, which is used by the linux kernel client.

References:

https://github.com/chaos/diod/blob/master/protocol.md#lcreate----create-regular-file
http://man.cat-v.org/plan_9/5/open

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 334833f88a6e..7f2ee41ca0f0 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -244,6 +244,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RATTACH ? "RATTACH" :
         id == P9_RWALK ? "RWALK" :
         id == P9_RLOPEN ? "RLOPEN" :
+        id == P9_RLCREATE ? "RLCREATE" :
         "<unknown>";
 }
 
@@ -423,6 +424,38 @@ static void v9fs_rlopen(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
     v9fs_req_free(req);
 }
 
+/* size[4] Tlcreate tag[2] fid[4] name[s] flags[4] mode[4] gid[4] */
+static P9Req *v9fs_tlcreate(QVirtIO9P *v9p, uint32_t fid, const char *name,
+                            uint32_t flags, uint32_t mode, uint32_t gid)
+{
+    P9Req *req;
+
+    req = v9fs_req_init(v9p,  4 + 4 + v9fs_string_size(name) + 4 + 4 + 4,
+                        P9_TLCREATE, ++(v9p->p9_req_tag));
+    v9fs_uint32_write(req, fid);
+    v9fs_string_write(req, name);
+    v9fs_uint32_write(req, flags);
+    v9fs_uint32_write(req, mode);
+    v9fs_uint32_write(req, gid);
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rlcreate tag[2] qid[13] iounit[4] */
+static void v9fs_rlcreate(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
+{
+    v9fs_req_recv(req, P9_RLCREATE);
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
@@ -560,6 +593,34 @@ static void fs_lopen_fifo_not_allowed(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_lcreate(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(__func__) };
+    char *path = g_strdup_printf("%s/%s", v9p->test_share, wnames[0]);
+    uint32_t iounit;
+    P9Req *req;
+
+    fs_attach(v9p);
+    /* Clone the root directory fid and open it */
+    req = v9fs_twalk(v9p, 0, 1, 0, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+    req = v9fs_tlopen(v9p, 1, O_RDWR);
+    v9fs_rlopen(req, NULL, NULL);
+
+    req = v9fs_tlcreate(v9p, 1, wnames[0], O_RDONLY, 0600, getgid());
+    v9fs_rlcreate(req, NULL, &iounit);
+
+    g_assert_cmpint(iounit, <=, P9_MAX_SIZE - P9_IOHDRSZ);
+
+    /* Was the file created ? */
+    req = v9fs_twalk(v9p, 0, 2, 1, wnames);
+    v9fs_rwalk(req, NULL, NULL);
+
+    unlink(path);
+    g_free(path);
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -592,6 +653,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/fifo_not_allowed",
                        fs_lopen_fifo_not_allowed);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/lcreate/basic", fs_lcreate);
 
     return g_test_run();
 }
