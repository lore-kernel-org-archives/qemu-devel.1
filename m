Received: from eggs.gnu.org ([2001:4830:134:3::10]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq9-00078g-8K
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq6-0000EM-4g
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43387
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgq5-0000EB-Uz
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:30 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J4JN143852
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:29 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27ruqcus4g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:29 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:27 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:46 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
Message-Id: <1483518107-13218-13-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL 12/13] tests: virtio-9p: no slash in path
 elements during walk
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

The walk operation is expected to fail and to return ENOENT.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 2deb7fbf92f1..83cb23b3afc7 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -276,6 +276,14 @@ static void v9fs_req_free(P9Req *req)
     g_free(req);
 }
 
+/* size[4] Rlerror tag[2] ecode[4] */
+static void v9fs_rlerror(P9Req *req, uint32_t *err)
+{
+    v9fs_req_recv(req, P9_RLERROR);
+    v9fs_uint32_read(req, err);
+    v9fs_req_free(req);
+}
+
 /* size[4] Tversion tag[2] msize[4] version[s] */
 static P9Req *v9fs_tversion(QVirtIO9P *v9p, uint32_t msize, const char *version)
 {
@@ -427,6 +435,21 @@ static void fs_walk(QVirtIO9P *v9p)
     g_free(wqid);
 }
 
+static void fs_walk_no_slash(QVirtIO9P *v9p)
+{
+    char *const wnames[] = { g_strdup(" /") };
+    P9Req *req;
+    uint32_t err;
+
+    fs_attach(v9p);
+    req = v9fs_twalk(v9p, 0, 1, 1, wnames);
+    v9fs_rlerror(req, &err);
+
+    g_assert_cmpint(err, ==, ENOENT);
+
+    g_free(wnames[0]);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
 
 static void v9fs_run_pci_test(gconstpointer data)
@@ -453,6 +476,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/version/basic", fs_version);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/attach/basic", fs_attach);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/basic", fs_walk);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/no_slash", fs_walk_no_slash);
 
     return g_test_run();
 }
-- 
2.7.4
