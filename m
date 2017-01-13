Received: from eggs.gnu.org ([2001:4830:134:3::10]:53465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMg-0006fd-Vj
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMc-00028I-40
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:31 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:23 +1100
Message-Id: <1484288903-18807-18-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 17/17] target/ppc/mmu_hash64: Fix incorrect
 shift value in amr calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

We are calculating the authority mask register key value wrong.

The pte entry contains the key value with the two upper bits and the three
lower bits stored separately. We should use these two portions to get a 5
bit value, not or them together which will only give us a 3 bit value.

Fix this.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/mmu-hash64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 73d7ce4..e8160c3 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -89,7 +89,7 @@ void ppc_hash64_update_rmls(CPUPPCState *env);
 #define HPTE64_R_C              0x0000000000000080ULL
 #define HPTE64_R_R              0x0000000000000100ULL
 #define HPTE64_R_KEY_LO         0x0000000000000e00ULL
-#define HPTE64_R_KEY(x)         ((((x) & HPTE64_R_KEY_HI) >> 60) | \
+#define HPTE64_R_KEY(x)         ((((x) & HPTE64_R_KEY_HI) >> 57) | \
                                  (((x) & HPTE64_R_KEY_LO) >> 9))
 
 #define HPTE64_V_1TB_SEG        0x4000000000000000ULL
-- 
2.5.5
