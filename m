Received: from eggs.gnu.org ([2001:4830:134:3::10]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq9-00078j-Oq
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cOgq6-0000EY-JS
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cOgq6-0000E2-AH
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:22:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v048J74c104380
	for <qemu-devel@nongnu.org>; Wed, 4 Jan 2017 03:22:29 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27rvnc1qy4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Jan 2017 03:22:29 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 4 Jan 2017 08:22:26 -0000
From: Greg Kurz <groug@kaod.org>
Date: Wed,  4 Jan 2017 09:21:45 +0100
In-Reply-To: <1483518107-13218-1-git-send-email-groug@kaod.org>
References: <1483518107-13218-1-git-send-email-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1483518107-13218-12-git-send-email-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] tests: virtio-9p: add walk operation test
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

The walk operation is used to traverse the directory tree and to associat=
e
paths to fids. A single walk can be used to traverse up to P9_MAXWELEM pa=
th
elements at the same time.

The test creates a path with P9_MAXWELEM elements on the backend (=C3=A0 =
la
'mkdir -p') and issues a walk operation. The walk is expected to succeed
without error.

Reference:

http://man.cat-v.org/plan_9/5/walk

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/virtio-9p-test.c | 70 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 70 insertions(+)

diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
index 37a256ef4a59..2deb7fbf92f1 100644
--- a/tests/virtio-9p-test.c
+++ b/tests/virtio-9p-test.c
@@ -334,6 +334,45 @@ static void v9fs_rattach(P9Req *req, v9fs_qid *qid)
     v9fs_req_free(req);
 }
=20
+/* size[4] Twalk tag[2] fid[4] newfid[4] nwname[2] nwname*(wname[s]) */
+static P9Req *v9fs_twalk(QVirtIO9P *v9p, uint32_t fid, uint32_t newfid,
+                         uint16_t nwname, char *const wnames[])
+{
+    P9Req *req;
+    int i;
+    uint32_t size =3D 4 + 4 + 2;
+
+    for (i =3D 0; i < nwname; i++) {
+        size +=3D v9fs_string_size(wnames[i]);
+    }
+    req =3D v9fs_req_init(v9p,  size, P9_TWALK, ++(v9p->p9_req_tag));
+    v9fs_uint32_write(req, fid);
+    v9fs_uint32_write(req, newfid);
+    v9fs_uint16_write(req, nwname);
+    for (i =3D 0; i < nwname; i++) {
+        v9fs_string_write(req, wnames[i]);
+    }
+    v9fs_req_send(req);
+    return req;
+}
+
+/* size[4] Rwalk tag[2] nwqid[2] nwqid*(wqid[13]) */
+static void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid)
+{
+    uint16_t local_nwqid;
+
+    v9fs_req_recv(req, P9_RWALK);
+    v9fs_uint16_read(req, &local_nwqid);
+    if (nwqid) {
+        *nwqid =3D local_nwqid;
+    }
+    if (wqid) {
+        *wqid =3D g_malloc(local_nwqid * 13);
+        v9fs_memread(req, *wqid, local_nwqid * 13);
+    }
+    v9fs_req_free(req);
+}
+
 static void fs_version(QVirtIO9P *v9p)
 {
     const char *version =3D "9P2000.L";
@@ -358,6 +397,36 @@ static void fs_attach(QVirtIO9P *v9p)
     v9fs_rattach(req, NULL);
 }
=20
+static void fs_walk(QVirtIO9P *v9p)
+{
+    char *wnames[P9_MAXWELEM], *paths[P9_MAXWELEM];
+    char *last_path =3D v9p->test_share;
+    uint16_t nwqid;
+    v9fs_qid *wqid;
+    int i;
+    P9Req *req;
+
+    for (i =3D 0; i < P9_MAXWELEM; i++) {
+        wnames[i] =3D g_strdup_printf("%s%d", __func__, i);
+        last_path =3D paths[i] =3D g_strdup_printf("%s/%s", last_path, w=
names[i]);
+        g_assert(!mkdir(paths[i], 0700));
+    }
+
+    fs_attach(v9p);
+    req =3D v9fs_twalk(v9p, 0, 1, P9_MAXWELEM, wnames);
+    v9fs_rwalk(req, &nwqid, &wqid);
+
+    g_assert_cmpint(nwqid, =3D=3D, P9_MAXWELEM);
+
+    for (i =3D 0; i < P9_MAXWELEM; i++) {
+        rmdir(paths[P9_MAXWELEM - i - 1]);
+        g_free(paths[P9_MAXWELEM - i - 1]);
+        g_free(wnames[i]);
+    }
+
+    g_free(wqid);
+}
+
 typedef void (*v9fs_test_fn)(QVirtIO9P *v9p);
=20
 static void v9fs_run_pci_test(gconstpointer data)
@@ -383,6 +452,7 @@ int main(int argc, char **argv)
     v9fs_qtest_pci_add("/virtio/9p/pci/config", pci_config);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/version/basic", fs_version);
     v9fs_qtest_pci_add("/virtio/9p/pci/fs/attach/basic", fs_attach);
+    v9fs_qtest_pci_add("/virtio/9p/pci/fs/walk/basic", fs_walk);
=20
     return g_test_run();
 }
--=20
2.7.4
