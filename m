Received: from eggs.gnu.org ([2001:4830:134:3::10]:60208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSX-0001Rh-RI
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ePtSX-0002t0-0F
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:41 -0500
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:46709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ePtSW-0002sp-SO
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 12:07:40 -0500
Received: by mail-it0-x243.google.com with SMTP id t1so21004808ite.5
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 09:07:40 -0800 (PST)
Received: from cloudburst.twiddle.net (141-126-166-226.dhcp.chtrptr.net.
	[141.126.166.226]) by smtp.gmail.com with ESMTPSA id
	k23sm4012974iti.22.2017.12.15.09.07.38 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 15 Dec 2017 09:07:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Dec 2017 11:07:27 -0600
Message-Id: <20171215170732.31125-3-richard.henderson@linaro.org>
In-Reply-To: <20171215170732.31125-1-richard.henderson@linaro.org>
References: <20171215170732.31125-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/7] target/moxie: Fix tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We should not exit unless moxie_cpu_handle_mmu_fault has failed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/moxie/helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/moxie/helper.c b/target/moxie/helper.c
index 2ecee89f11..6890ffd71c 100644
--- a/target/moxie/helper.c
+++ b/target/moxie/helper.c
@@ -36,9 +36,8 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
 
     ret = moxie_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (unlikely(ret)) {
-        cpu_restore_state(cs, retaddr);
+        cpu_loop_exit_restore(cs, retaddr);
     }
-    cpu_loop_exit(cs);
 }
 
 void helper_raise_exception(CPUMoxieState *env, int ex)
-- 
2.14.3
