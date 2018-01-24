Received: from eggs.gnu.org ([2001:4830:134:3::10]:51302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURq-00050L-OK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeURp-000229-SZ
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:18 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeURp-00021z-MP
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:27:17 -0500
Received: by mail-pg0-x244.google.com with SMTP id o13so3819202pgs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:27:17 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.27.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:27:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:26:12 -0800
Message-Id: <20180124232625.30105-33-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 32/45] target/hppa: Only use EXCP_DTLB_MISS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unknown why this works, but if we return EXCP_ITLB_MISS we
will triple-fault the first userland instruction fetch.
Is it something to do with having a combined I/DTLB?

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/mem_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index c14317ebef..81bcbe45db 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -97,7 +97,9 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     if (ent == NULL || !ent->entry_valid) {
         phys = 0;
         prot = 0;
-        ret = (ifetch ? EXCP_ITLB_MISS : EXCP_DTLB_MISS);
+        /* ??? Unconditionally report data tlb miss,
+           even if this is an instruction fetch.  */
+        ret = EXCP_DTLB_MISS;
         goto egress;
     }
 
-- 
2.14.3
