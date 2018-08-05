Received: from eggs.gnu.org ([2001:4830:134:3::10]:40112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNmF-0006Cg-00
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.zbitskiy@gmail.com>) id 1fmNmA-0005Py-K7
	for qemu-devel@nongnu.org; Sun, 05 Aug 2018 14:29:14 -0400
From: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Date: Sun,  5 Aug 2018 14:28:30 -0400
Message-Id: <20180805182832.3012-6-pavel.zbitskiy@gmail.com>
In-Reply-To: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
References: <20180805182832.3012-1-pavel.zbitskiy@gmail.com>
Subject: [Qemu-devel] [PATCH 5/6] target/s390x: fix PACK reading 1 byte less
 and writing 1 byte more
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Pavel Zbitskiy <pavel.zbitskiy@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

PACK fails on the test from the Principles of Operation: F1F2F3F4
becomes 0000234C instead of 0001234C due to an off-by-one error.
Furthermore, it overwrites one extra byte to the left of F1.

Signed-off-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
---
 target/s390x/mem_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index 704d0193b5..bacae4f503 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1019,15 +1019,15 @@ void HELPER(pack)(CPUS390XState *env, uint32_t len, uint64_t dest, uint64_t src)
     len_src--;
 
     /* now pack every value */
-    while (len_dest >= 0) {
+    while (len_dest > 0) {
         b = 0;
 
-        if (len_src > 0) {
+        if (len_src >= 0) {
             b = cpu_ldub_data_ra(env, src, ra) & 0x0f;
             src--;
             len_src--;
         }
-        if (len_src > 0) {
+        if (len_src >= 0) {
             b |= cpu_ldub_data_ra(env, src, ra) << 4;
             src--;
             len_src--;
-- 
2.16.2.windows.1
