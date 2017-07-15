Received: from eggs.gnu.org ([2001:4830:134:3::10]:50161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuP-0006WK-Ep
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWQuM-0000uq-C1
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:13 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWQuM-0000ug-5y
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 13:31:10 -0400
Received: by mail-pf0-x244.google.com with SMTP id q85so14630098pfq.2
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 10:31:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 15 Jul 2017 07:30:49 -1000
Message-Id: <20170715173050.31018-8-rth@twiddle.net>
In-Reply-To: <20170715173050.31018-1-rth@twiddle.net>
References: <20170715173050.31018-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 7/8] target/s390x: Allow to enable "idtes"
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>

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
index 9e9e649..f4f73b8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -779,6 +779,7 @@ static void add_qemu_cpu_model_features(S390FeatBitmap fbm)
 {
     static const int feats[] = {
         S390_FEAT_DAT_ENH,
+        S390_FEAT_IDTE_SEGMENT,
         S390_FEAT_STFLE,
         S390_FEAT_EXTENDED_IMMEDIATE,
         S390_FEAT_EXTENDED_TRANSLATION_2,
-- 
2.9.4
