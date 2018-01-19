Received: from eggs.gnu.org ([2001:4830:134:3::10]:57578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecccz-0001mv-Lj
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:47:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ecccw-0000OT-Fa
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:47:05 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ecccw-0000O4-93
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 14:47:02 -0500
Received: by mail-wm0-x243.google.com with SMTP id f71so5510799wmf.0
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 11:47:02 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 19 Jan 2018 19:46:48 +0000
Message-Id: <20180119194648.25501-1-ard.biesheuvel@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Fix 32-bit address truncation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Commit ("3b39d734141a target/arm: Handle page table walk load failures
correctly") modified both versions of the page table walking code (i.e.,
arm_ldl_ptw and arm_ldq_ptw) to record the result of the translation in
a temporary 'data' variable so that it can be inspected before being
returned. However, arm_ldq_ptw() returns an uint64_t, and using a
temporary uint32_t variable truncates the upper bits, corrupting the
result. This causes problems when using more than 4 GB of memory in
a TCG guest. So use a uint64_t instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 67059033019c..a41b6c3a1b82 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8368,7 +8368,7 @@ static uint64_t arm_ldq_ptw(CPUState *cs, hwaddr addr, bool is_secure,
     MemTxAttrs attrs = {};
     MemTxResult result = MEMTX_OK;
     AddressSpace *as;
-    uint32_t data;
+    uint64_t data;
 
     attrs.secure = is_secure;
     as = arm_addressspace(cs, attrs);
-- 
2.11.0
