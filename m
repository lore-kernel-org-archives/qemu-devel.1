Received: from eggs.gnu.org ([2001:4830:134:3::10]:37073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytL-0006kc-RQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cTytI-0002s3-Nz
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:43 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cTytI-0002rl-HX
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 17:39:40 -0500
Received: by mail-wm0-x242.google.com with SMTP id r144so7568674wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:39:40 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 18 Jan 2017 23:38:31 +0100
Message-Id: <1484779123-18968-19-git-send-email-atar4qemu@gmail.com>
In-Reply-To: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
References: <1484779123-18968-1-git-send-email-atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/30] target-sparc: replace the last tlb entry
 when no free entries left
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

Implement the behavior described in the chapter 13.9.11 of
UltraSPARC T1™ Supplement to the UltraSPARC Architecture 2005:

"If a TLB Data-In replacement is attempted with all TLB
entries locked and valid, the last TLB entry (entry 63) is
replaced."

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
---
 target/sparc/ldst_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d3747cf..029120d 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -246,9 +246,11 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
     }
 
 #ifdef DEBUG_MMU
-    DPRINTF_MMU("%s lru replacement failed: no entries available\n", strmmu);
+    DPRINTF_MMU("%s lru replacement: no free entries available, "
+                "replacing the last one\n", strmmu);
 #endif
-    /* error state? */
+    /* corner case: the last entry is replaced anyway */
+    replace_tlb_entry(&tlb[63], tlb_tag, tlb_tte, env1);
 }
 
 #endif
-- 
2.7.2
