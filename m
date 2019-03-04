Received: from eggs.gnu.org ([209.51.188.92]:47546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mLW-0002HM-0T
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:05:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h0mLU-0003JU-SP
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:05:25 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  4 Mar 2019 13:02:10 +0100
Message-Id: <20190304120210.31500-28-cohuck@redhat.com>
In-Reply-To: <20190304120210.31500-1-cohuck@redhat.com>
References: <20190304120210.31500-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 27/27] s390x: Add floating-point extension
 facility to "qemu" cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

The floating-point extension facility implemented certain changes to
BFP, HFP and DFP instructions.

As we don't implement HFP/DFP, we can ignore those completely. Related
to BFP, the changes include
- SET BFP ROUNDING MODE (SRNMB) instruction
- BFP-rounding-mode field in the FPC register is changed to 3 bits
- CONVERT FROM LOGICAL instructions
- CONVERT TO LOGICAL instructions
- Changes (rounding mode + XxC) added to
-- CONVERT TO FIXED
-- CONVERT FROM FIXED
-- LOAD FP INTEGER
-- LOAD ROUNDED
-- DIVIDE TO INTEGER

For TCG, we don't implement DIVIDE TO INTEGER, and it is harder to
implement, so skip that. Also, as we don't implement PFPO, we can skip
changes to that as well. The other parts are now implemented, we can
indicate the facility.

z14 PoP mentions that "The floating-point extension facility is installed
in the z/Architecture architectural mode. When bit 37 is one, bit 42 is
also one.", meaning that the DFP (decimal-floating-point) facility also
has to be indicated. We can ignore that for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190218122710.23639-16-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/gen-features.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 44eca4547475..e4739a6b9f61 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -601,6 +601,11 @@ static uint16_t qemu_V3_1[] = {
 };
 
 static uint16_t qemu_LATEST[] = {
+    /*
+     * Only BFP bits are implemented (HFP, DFP, PFPO and DIVIDE TO INTEGER not
+     * implemented yet).
+     */
+    S390_FEAT_FLOATING_POINT_EXT,
     S390_FEAT_ZPCI,
 };
 
-- 
2.17.2
