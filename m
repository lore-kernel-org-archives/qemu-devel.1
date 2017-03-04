Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErt-0006jw-CA
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErq-0008A9-AF
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:25 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErq-0008A1-6F
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:22 -0500
Received: by mail-qk0-x241.google.com with SMTP id n127so35021506qkf.2
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:57:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:56:48 -0300
Message-Id: <20170304185652.10675-2-f4bug@amsat.org>
In-Reply-To: <20170304185652.10675-1-f4bug@amsat.org>
References: <20170304185652.10675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/5] target-mips: fix compiler warnings (clang
 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

static code analyzer complain:

target/mips/helper.c:453:5: warning: Function call argument is an uninitialized value
    qemu_log_mask(CPU_LOG_MMU,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~

'physical' and 'prot' are uninitialized if 'ret' is not TLBRET_MATCH.

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/helper.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index d2e77958fd..e359ca3b44 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -450,10 +450,18 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int rw,
     access_type = ACCESS_INT;
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, access_type);
-    qemu_log_mask(CPU_LOG_MMU,
-             "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
-             " prot %d\n",
-             __func__, address, ret, physical, prot);
+    switch (ret) {
+    case TLBRET_MATCH:
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=%" VADDR_PRIx " physical " TARGET_FMT_plx
+                      " prot %d\n", __func__, address, physical, prot);
+        break;
+    default:
+        qemu_log_mask(CPU_LOG_MMU,
+                      "%s address=%" VADDR_PRIx " ret %d\n", __func__, address,
+                      ret);
+        break;
+    }
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
                      physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
-- 
2.11.0
