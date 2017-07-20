Received: from eggs.gnu.org ([2001:4830:134:3::10]:60349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qR-00018V-PX
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qM-0005vy-UP
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qM-0005u8-Mh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:22 -0400
Message-Id: <1500520169-23367-37-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 36/43] tcg: introduce **tcg_ctxs to keep
 track of all TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Groundwork for supporting multiple TCG contexts.

Note that having n_tcg_ctxs is unnecessary. However, it is
convenient to have it, since it will simplify iterating over the
array: we'll have just a for loop instead of having to iterate
over a NULL-terminated array (which would require n+1 elems)
or having to check with ifdef's for usermode/softmmu.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f907c47..2217314 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -115,6 +115,8 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 static void tcg_out_tb_init(TCGContext *s);
 static bool tcg_out_tb_finalize(TCGContext *s);
 
+static TCGContext **tcg_ctxs;
+static unsigned int n_tcg_ctxs;
 
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
@@ -382,6 +384,8 @@ void tcg_context_init(TCGContext *s)
     }
 
     tcg_ctx = s;
+    tcg_ctxs = &tcg_ctx;
+    n_tcg_ctxs = 1;
 }
 
 /*
-- 
2.7.4
