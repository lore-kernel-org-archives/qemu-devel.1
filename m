Received: from eggs.gnu.org ([2001:4830:134:3::10]:55589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ7-0008Hh-ON
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVZ7-0006pD-0Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:37 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVZ6-0006p8-S7
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:36 -0500
Received: by mail-qt0-x242.google.com with SMTP id n13so850165qtc.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:36 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:54 -0800
Message-Id: <20170112025606.27332-19-rth@twiddle.net>
In-Reply-To: <20170112025606.27332-1-rth@twiddle.net>
References: <20170112025606.27332-1-rth@twiddle.net>
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
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

From: Artyom Tarasenko <atar4qemu@gmail.com>

Implement the behavior described in the chapter 13.9.11 of
UltraSPARC T1™ Supplement to the UltraSPARC Architecture 2005:

"If a TLB Data-In replacement is attempted with all TLB
entries locked and valid, the last TLB entry (entry 63) is
replaced."

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <86cbe148bfaf96575128f3d8394a17c48ad92f28.1484165352.git.atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sparc/ldst_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index d524aaa..8cc8bb1 100644
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
2.9.3
