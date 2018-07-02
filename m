Received: from eggs.gnu.org ([2001:4830:134:3::10]:43696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqF-0001zn-LZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fZwqE-00063i-Qk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:17:59 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  2 Jul 2018 13:17:26 +0200
Message-Id: <20180702111737.18970-5-cohuck@redhat.com>
In-Reply-To: <20180702111737.18970-1-cohuck@redhat.com>
References: <20180702111737.18970-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 04/15] s390x/tcg: avoid overflows in
 time2tod/tod2time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Big values for the TOD/ns clock can result in some overflows that can be
avoided. Not all overflows can be handled however, as the conversion either
multiplies by 4.096 or divided by 4.096.

Apply the trick used in the Linux kernel in arch/s390/include/asm/timex.h
for tod_to_ns() and use the same trick also for the conversion in the
other direction.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180627134410.4901-2-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/internal.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index e392a02d12..6cf63340bf 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -243,13 +243,14 @@ enum cc_op {
 /* Converts ns to s390's clock format */
 static inline uint64_t time2tod(uint64_t ns)
 {
-    return (ns << 9) / 125;
+    return (ns << 9) / 125 + (((ns & 0xff10000000000000ull) / 125) << 9);
+
 }
 
 /* Converts s390's clock format to ns */
 static inline uint64_t tod2time(uint64_t t)
 {
-    return (t * 125) >> 9;
+    return ((t >> 9) * 125) + (((t & 0x1ff) * 125) >> 9);
 }
 
 static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
-- 
2.14.4
