Received: from eggs.gnu.org ([2001:4830:134:3::10]:43207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHU0-0002NL-Kg
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFHTu-0000Mh-Tu
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFHTu-0000MK-JI
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 04:28:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uB99OvWR046532
	for <qemu-devel@nongnu.org>; Fri, 9 Dec 2016 04:28:41 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 277ru1ayrd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 04:28:41 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 9 Dec 2016 02:28:40 -0700
From: Greg Kurz <groug@kaod.org>
Date: Fri, 09 Dec 2016 10:28:35 +0100
In-Reply-To: <148127558476.2633.13433882390740185948.stgit@bahia>
References: <148127558476.2633.13433882390740185948.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148127571577.2633.15384169688307851883.stgit@bahia>
Subject: [Qemu-devel] [PATCH 8/8] tests: virtio-9p: ".." cannot be used to
 walk out of the shared directory
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

According to the 9P spec at http://man.cat-v.org/plan_9/5/intro, the
parent directory of the root directory of a server's tree is itself.
This test hence checks that the qid of the root directory as returned by
attach is the same as the qid of ".." when walking from the root directory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 83cb23b3afc7..060407b20e39 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -450,6 +450,25 @@ static void fs_walk_no_slash(QVirtIO9P *v9p)
     g_free(wnames[0]);
 }
 
+static void fs_walk_dotdot(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup("..") };
+    v9fs_qid root_qid, *wqid;
+    P9Req *req;
+
+    fs_version(v9p);
+    req = v9fs_tattach(v9p, 0, getuid());
+    v9fs_rattach(req, &root_qid);
+
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames);
+    v9fs_rwalk(req, NULL, &wqid); /* We now we'll get one qid */
+
+    g_assert_cmpmem(&root_qid, 13, wqid[0], 13);
+
+    g_free(wqid);
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -477,6 +496,8 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/attach/basic", fs_attach);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/basic", fs_walk);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/no_slash", fs_walk_no_slash);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/dotdot_from_root",
+                       fs_walk_dotdot);
 
     return g_test_run();
 }
