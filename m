Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTyt0-0006PY-1t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTysy-0002cy-Iz
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:22 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTysy-0002cX-Ci
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:20 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so7555939wmd.2
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:20 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:20 +0100
Message-Id: <1484779123-18968-8-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
Subject: [Qemu-devel] [PULL 07/30] target-sparc: simplify replace_tlb_entry
 by using TTE_PGSIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, rth@twiddle.net, Artyom Tarasenko <atar4qemu@gmail.com>

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Reviewed-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 20e202b..7a134b3 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -127,9 +127,8 @@ static void replace_tlb_entry(SparcTLBEntry *tlb,
     if (TTE_IS_VALID(tlb->tte)) {
         CPUState *cs = CPU(sparc_env_get_cpu(env1));
 
-        mask = 0xffffffffffffe000ULL;
-        mask <<= 3 * ((tlb->tte >> 61) & 3);
-        size = ~mask + 1;
+        size = 8192ULL << 3 * TTE_PGSIZE(tlb->tte);
+        mask = 1ULL + ~size;
 
         va = tlb->tag & mask;
 
-- 
2.7.2
