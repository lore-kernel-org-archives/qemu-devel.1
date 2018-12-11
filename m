Received: from eggs.gnu.org ([2001:4830:134:3::10]:47978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi61-0002Ne-0a
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gWi60-0000iU-3q
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gWi5z-0000hy-UK
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 08:29:08 -0500
From: P J P <ppandit@redhat.com>
Date: Tue, 11 Dec 2018 18:56:41 +0530
Message-Id: <20181211132642.3027-5-ppandit@redhat.com>
In-Reply-To: <20181211132642.3027-1-ppandit@redhat.com>
References: <20181211132642.3027-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/5] pvrdma: release ring object in case of an
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

create_cq and create_qp routines allocate ring object, but it's
not released in case of an error, leading to memory leakage.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/vmw/pvrdma_cmd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index ee2888259c..e8d99f29fa 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -337,7 +337,9 @@ static int create_cq(PVRDMADev *dev, union pvrdma_cmd=
_req *req,
=20
     resp->hdr.err =3D rdma_rm_alloc_cq(&dev->rdma_dev_res, &dev->backend=
_dev,
                                      cmd->cqe, &resp->cq_handle, ring);
-    resp->cqe =3D cmd->cqe;
+    if (resp->hdr.err) {
+        g_free(ring);
+    }
=20
 out:
     pr_dbg("ret=3D%d\n", resp->hdr.err);
@@ -490,6 +492,10 @@ static int create_qp(PVRDMADev *dev, union pvrdma_cm=
d_req *req,
                                      cmd->max_send_sge, cmd->send_cq_han=
dle,
                                      cmd->max_recv_wr, cmd->max_recv_sge=
,
                                      cmd->recv_cq_handle, rings, &resp->=
qpn);
+    if (resp->hdr.err) {
+        g_free(rings);
+        goto out;
+    }
=20
     resp->max_send_wr =3D cmd->max_send_wr;
     resp->max_recv_wr =3D cmd->max_recv_wr;
--=20
2.19.2
