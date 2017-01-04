Received: from eggs.gnu.org ([2001:4830:134:3::10]:57852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgqE-0007B7-0K
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgqA-0000Gy-TB
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46216)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgqA-0000GO-IH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:34 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4Gu073880
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:33 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rspg0mf1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:32 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:30 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:47 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-14-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 13/13] tests: virtio-9p: ".." cannot be used to
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

According to the 9P spec at http://man.cat-v.org/plan_9/5/intro, the
parent directory of the root directory of a server's tree is itself.
This test hence checks that the qid of the root directory as returned by
attach is the same as the qid of ".." when walking from the root directory.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 21 +++++++++++++++++++++
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
-- 
2.7.4
