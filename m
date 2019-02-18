Received: from eggs.gnu.org ([209.51.188.92]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1d-0003ys-IR
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gvi1c-0004Xq-NV
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:27:57 -0500
From: David Hildenbrand <david@redhat.com>
Date: Mon, 18 Feb 2019 13:27:10 +0100
Message-Id: <20190218122710.23639-16-david@redhat.com>
In-Reply-To: <20190218122710.23639-1-david@redhat.com>
References: <20190218122710.23639-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 15/15] s390x: Add floating-point extension
 facility to "qemu" cpu model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

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

z14 PoP mentiones that "The floating-point extension facility is installed
in the z/Architecture architectural mode. When bit 37 is one, bit 42 is
also one.", meaning that the DFP (decimal-floating-point) facility also
has to be inidicated. We can ignore that for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/gen-features.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 44eca45474..e4739a6b9f 100644
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
