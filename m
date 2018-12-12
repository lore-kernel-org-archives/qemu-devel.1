Received: from eggs.gnu.org ([2001:4830:134:3::10]:45246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFk-0008MQ-68
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gXAFj-0001eF-3a
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:33:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gXAFi-0001df-SA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 14:33:03 -0500
From: P J P <ppandit@redhat.com>
Date: Thu, 13 Dec 2018 01:00:39 +0530
Message-Id: <20181212193039.11445-7-ppandit@redhat.com>
In-Reply-To: <20181212193039.11445-1-ppandit@redhat.com>
References: <20181212193039.11445-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 6/6] pvrdma: check return value from
 pvrdma_idx_ring_has_ routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Saar Amar <saaramar5@gmail.com>, Li Qiang <liq3ea@163.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

pvrdma_idx_ring_has_[data/space] routines also return invalid
index PVRDMA_INVALID_IDX[=3D-1], if ring has no data/space. Check
return value from these routines to avoid plausible infinite loops.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/rdma/vmw/pvrdma_dev_ring.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

Update: revert use of idx variable in pvrdma_ring_next_elem_read()
  -> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02814.html

diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.=
c
index 01247fc041..e8e5b502f6 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -73,23 +73,16 @@ out:
=20
 void *pvrdma_ring_next_elem_read(PvrdmaRing *ring)
 {
+    int e;
     unsigned int idx =3D 0, offset;
=20
-    /*
-    pr_dbg("%s: t=3D%d, h=3D%d\n", ring->name, ring->ring_state->prod_ta=
il,
-           ring->ring_state->cons_head);
-    */
-
-    if (!pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &id=
x)) {
+    e =3D pvrdma_idx_ring_has_data(ring->ring_state, ring->max_elems, &i=
dx);
+    if (e <=3D 0) {
         pr_dbg("No more data in ring\n");
         return NULL;
     }
=20
     offset =3D idx * ring->elem_sz;
-    /*
-    pr_dbg("idx=3D%d\n", idx);
-    pr_dbg("offset=3D%d\n", offset);
-    */
     return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAG=
E_SIZE);
 }
=20
@@ -105,20 +98,20 @@ void pvrdma_ring_read_inc(PvrdmaRing *ring)
=20
 void *pvrdma_ring_next_elem_write(PvrdmaRing *ring)
 {
-    unsigned int idx, offset, tail;
+    int idx;
+    unsigned int offset, tail;
=20
-    /*
-    pr_dbg("%s: t=3D%d, h=3D%d\n", ring->name, ring->ring_state->prod_ta=
il,
-           ring->ring_state->cons_head);
-    */
-
-    if (!pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems, &t=
ail)) {
+    idx =3D pvrdma_idx_ring_has_space(ring->ring_state, ring->max_elems,=
 &tail);
+    if (idx <=3D 0) {
         pr_dbg("CQ is full\n");
         return NULL;
     }
=20
     idx =3D pvrdma_idx(&ring->ring_state->prod_tail, ring->max_elems);
-    /* TODO: tail =3D=3D idx */
+    if (idx < 0 || tail !=3D idx) {
+        pr_dbg("invalid idx\n");
+        return NULL;
+    }
=20
     offset =3D idx * ring->elem_sz;
     return ring->pages[offset / TARGET_PAGE_SIZE] + (offset % TARGET_PAG=
E_SIZE);
--=20
2.19.2
