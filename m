Received: from eggs.gnu.org ([2001:4830:134:3::10]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTf-0000Kq-BM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTb-0002My-DI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33012
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTb-0002Mn-7P
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:32:39 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESvba072757
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:38 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27w0y11r40-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:38 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 09:32:38 -0500
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:34 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405875409.9522.3186403269993262538.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 4/7] tests: virtio-9p: TLOPEN should fail to
 open a FIFO
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

A 9P server should only try to open regular files and directories.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 14b4787930ae..334833f88a6e 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -537,6 +537,29 @@ static void fs_lopen(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_lopen_fifo_not_allowed(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(__func__) };
+    char *test_fifo;
+    P9Req *req;
+    uint32_t err;
+
+    test_fifo = g_strdup_printf("%s/%s", v9p->test_share, wnames[0]);
+    g_assert(mkfifo(test_fifo, 0600) == 0);
+
+    fs_attach(v9p);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames);
+    v9fs_rwalk(req, NULL, NULL);
+    req = v9fs_tlopen(v9p, 1, O_RDONLY);
+    v9fs_rlerror(req, &err);
+
+    g_assert_cmpint(err, ==, EINVAL);
+
+    unlink(test_fifo);
+    g_free(test_fifo);
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -567,6 +590,8 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/dotdot_from_root",
                        fs_walk_dotdot);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/basic", fs_lopen);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/fifo_not_allowed",
+                       fs_lopen_fifo_not_allowed);
 
     return g_test_run();
 }
