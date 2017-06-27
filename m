Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dPtlE-0007wp-IC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dPt4i-0003jw-NR
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:10:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dPt4i-0003jZ-I2
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:10:48 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 27 Jun 2017 18:10:32 +0200
Message-Id: <20170627161032.5014-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1] s390x/cpumodel: allow to enable "idtes"
 feature for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, agraf@suse.de, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, david@redhat.com

STFL bit 4 and 5 are just indications to the guest, which TLB entries an
IDTE call will clear. These are performance indicators for the guest.

STFL bit 4:
    INVALIDATE DAT TABLE ENTRY (IDTE) performs
    the invalidation-and-clearing operation by
    selectively clearing TLB segment-table entries
    when a segment-table entry or entries are
    invalidated. IDTE also performs the clearing-by-
    ASCE operation. Unless bit 4 is one, IDTE simply
    purges all TLBs. Bit 3 is one if bit 4 is one.

We can simply set STFL bit 4 ("idtes") and still purge the complete TLB.
Purging more than advertised is never bad. E.g. Linux doesn't even care
about this bit. We can optimized this later.
This is helpful, as the z9 base model contains this facility.

STFL bit 5 (clearing TLB region-table-entries) was never implemented on
real HW, therefore we can simply ignore it for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 63903c2..f056357 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -676,6 +676,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
 {
     static const int feats[] = {
         S390_FEAT_DAT_ENH,
+        S390_FEAT_IDTE_SEGMENT,
         S390_FEAT_STFLE,
         S390_FEAT_EXTENDED_IMMEDIATE,
         S390_FEAT_EXTENDED_TRANSLATION_2,
-- 
2.9.4
