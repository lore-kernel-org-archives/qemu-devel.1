Received: from eggs.gnu.org ([2001:4830:134:3::10]:34534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu7-0003yq-KN
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dIOu6-0002Wm-Ub
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:55 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dIOu6-0002WC-QC
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 20:32:54 -0400
Received: by mail-qt0-x244.google.com with SMTP id x58so19244365qtc.2
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 17:32:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  6 Jun 2017 17:31:17 -0700
Message-Id: <20170607003119.14778-69-rth@twiddle.net>
In-Reply-To: <20170607003119.14778-1-rth@twiddle.net>
References: <20170607003119.14778-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 68/70] target/s390x: check alignment in CDSG
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
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

The CDSG instruction requires a 16-byte alignement, as expressed in
the MO_ALIGN_16 passed to helper_atomic_cmpxchgo_be_mmu. In the non
parallel case, use check_alignment to enforce this.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170604202034.16615-4-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/mem_helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index a8988e0..80caab9 100644
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
2.9.4
