Received: from eggs.gnu.org ([209.51.188.92]:42675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to2-0000rS-87
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to1-0001G8-CF
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:21 +1100
Message-Id: <20190310082703.1245-19-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/60] spapr: Force SPAPR_MEMORY_BLOCK_SIZE to
 be a hwaddr (64-bit)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

SPAPR_MEMORY_BLOCK_SIZE is logically a difference in memory addresses, an=
d
hence of type hwaddr which is 64-bit.  Previously it wasn't marked as suc=
h
which means that it could be treated as 32-bit.  That will work in some
circumstances but if multiplied by another 32-bit value it could lead to
a 32-bit overflow and an incorrect result.

One specific instance of this in spapr_lmb_dt_populate() was spotted by
Coverity (CID 1399145).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ff1bd60615..1311ebe28e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -792,7 +792,7 @@ int spapr_rtc_import_offset(sPAPRRTCState *rtc, int64=
_t legacy_offset);
=20
 #define TYPE_SPAPR_RNG "spapr-rng"
=20
-#define SPAPR_MEMORY_BLOCK_SIZE (1 << 28) /* 256MB */
+#define SPAPR_MEMORY_BLOCK_SIZE ((hwaddr)1 << 28) /* 256MB */
=20
 /*
  * This defines the maximum number of DIMM slots we can have for sPAPR
--=20
2.20.1
