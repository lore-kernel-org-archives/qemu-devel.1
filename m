Received: from eggs.gnu.org ([2001:4830:134:3::10]:43575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFQ-0005K9-OK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFN-0003zx-3u
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:20 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:41 +1100
Message-Id: <20181108121646.26173-18-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/22] ppc/pnv: check size before data buffer
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, Prasad J Pandit <pjp@fedoraproject.org>, David Gibson <david@gibson.dropbear.id.au>

From: Prasad J Pandit <pjp@fedoraproject.org>

While performing PowerNV memory r/w operations, the access length
'sz' could exceed the data[4] buffer size. Add check to avoid OOB
access.

Reported-by: Moguofang <moguofang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_lpc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index d7721320a2..172a915cfc 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -155,9 +155,15 @@ static void pnv_lpc_do_eccb(PnvLpcController *lpc, u=
int64_t cmd)
     /* XXX Check for magic bits at the top, addr size etc... */
     unsigned int sz =3D (cmd & ECCB_CTL_SZ_MASK) >> ECCB_CTL_SZ_LSH;
     uint32_t opb_addr =3D cmd & ECCB_CTL_ADDR_MASK;
-    uint8_t data[4];
+    uint8_t data[8];
     bool success;
=20
+    if (sz > sizeof(data)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+            "ECCB: invalid operation at @0x%08x size %d\n", opb_addr, sz=
);
+        return;
+    }
+
     if (cmd & ECCB_CTL_READ) {
         success =3D opb_read(lpc, opb_addr, data, sz);
         if (success) {
--=20
2.19.1
