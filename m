Received: from eggs.gnu.org ([2001:4830:134:3::10]:33686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehog-0003Ec-8B
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehof-00038S-86
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehof-00035J-03
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoR-0006pS-Dh
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:09 +0000
Message-Id: <1516887809-6265-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/21] target/arm: Fix 32-bit address truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Commit ("3b39d734141a target/arm: Handle page table walk load failures
correctly") modified both versions of the page table walking code (i.e.,
arm_ldl_ptw and arm_ldq_ptw) to record the result of the translation in
a temporary 'data' variable so that it can be inspected before being
returned. However, arm_ldq_ptw() returns an uint64_t, and using a
temporary uint32_t variable truncates the upper bits, corrupting the
result. This causes problems when using more than 4 GB of memory in
a TCG guest. So use a uint64_t instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-id: 20180119194648.25501-1-ard.biesheuvel@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c83c901..bd05f8a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8360,7 +8360,7 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
     MemTxAttrs attrs = {};
     MemTxResult result = MEMTX_OK;
     AddressSpace *as;
-    uint32_t data;
+    uint64_t data;
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
-- 
2.7.4
