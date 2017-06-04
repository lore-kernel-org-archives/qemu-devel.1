Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHc0x-00033W-L1
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dHc0w-0004QT-UL
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:43 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:42638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dHc0w-0004NG-OW
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 16:20:42 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  4 Jun 2017 22:20:34 +0200
Message-Id: <20170604202034.16615-4-aurelien@aurel32.net>
In-Reply-To: <20170604202034.16615-1-aurelien@aurel32.net>
References: <20170604202034.16615-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v4 3/3] target/s390x: check alignment in CDSG
 in the !CONFIG_ATOMIC128 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

The CDSG instruction requires a 16-byte alignement, as expressed in
the MO_ALIGN_16 passed to helper_atomic_cmpxchgo_be_mmu. In the non
parallel case, use check_alignment to enforce this.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/s390x/mem_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a8988e0293..80caab9c9d 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1262,6 +1262,8 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
     } else {
         uint64_t oldh, oldl;
 
+        check_alignment(env, addr, 16, ra);
+
         oldh = cpu_ldq_data_ra(env, addr + 0, ra);
         oldl = cpu_ldq_data_ra(env, addr + 8, ra);
 
-- 
2.11.0
