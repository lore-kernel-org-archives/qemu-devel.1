Received: from eggs.gnu.org ([2001:4830:134:3::10]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxU1-0000cW-BB
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:33:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cQxTx-0002WS-DU
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:33:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cQxTx-0002W1-2p
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 09:33:01 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0AESnkS124413
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:33:00 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27w18ngptf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 09:32:59 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 10 Jan 2017 07:32:58 -0700
From: Greg Kurz <groug@kaod.org>
Date: Tue, 10 Jan 2017 15:32:53 +0100
In-Reply-To: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <148405872846.9522.17126828396099315346.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148405877363.9522.2658048290773626523.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: [Qemu-devel] [PATCH 7/7] tests: virtio-9p: TLCREATE should fail if
 pathname exists
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

As specified in the http://man.cat-v.org/plan_9/5/open :

"An attempt to create a file in a directory where the given
name already exists will be rejected"

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 7f2ee41ca0f0..2ba321b990d3 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -621,6 +621,35 @@ static void fs_lcreate(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_lcreate_exclusive(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(__func__) };
+    char *path = g_strdup_printf("%s/%s", v9p->test_share, wnames[0]);
+    int fd;
+    uint32_t err;
+    P9Req *req;
+
+    fd = creat(path, 0600);
+    g_assert(fd >= 0);
+    close(fd);
+
+    fs_attach(v9p);
+    /* Clone the root directory fid and open it */
+    req = v9fs_twalk(v9p, 0, 1, 0, NULL);
+    v9fs_rwalk(req, NULL, NULL);
+    req = v9fs_tlopen(v9p, 1, O_RDWR);
+    v9fs_rlopen(req, NULL, NULL);
+
+    req = v9fs_tlcreate(v9p, 1, wnames[0], O_RDONLY, 0600, getgid());
+    v9fs_rlerror(req, &err);
+
+    g_assert_cmpint(err, ==, EEXIST);
+
+    unlink(path);
+    g_free(path);
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -654,6 +683,8 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lopen/fifo_not_allowed",
                        fs_lopen_fifo_not_allowed);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/lcreate/basic", fs_lcreate);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/lcreate/exclusive",
+                       fs_lcreate_exclusive);
 
     return g_test_run();
 }
