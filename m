Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROyL-0001gx-Gu
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dROyK-0006o9-RM
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:29 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dROyK-0006o1-Ms
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 16:26:28 -0400
Received: by mail-qt0-x242.google.com with SMTP id m54so16673818qtb.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jul 2017 13:26:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat,  1 Jul 2017 13:25:59 -0700
Message-Id: <20170701202600.14057-8-rth@twiddle.net>
In-Reply-To: <20170701202600.14057-1-rth@twiddle.net>
References: <20170701202600.14057-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 7/8] target/s390x: Allow to enable "idtes"
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
Cc: david@redhat.com, aurelien@aurel32.net

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20170627161032.5014-1-david@redhat.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu_models.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 91ef8eb..ca9168d 100644
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
