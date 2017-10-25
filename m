Received: from eggs.gnu.org ([2001:4830:134:3::10]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I70-0000K8-Fu
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6z-0000Ft-Bp
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:34 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6z-0000Ex-5B
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:33 -0400
Received: by mail-wr0-x244.google.com with SMTP id l1so23340136wrc.3
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:27 +0200
Message-Id: <20171025093535.10175-44-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 43/51] tcg: introduce **tcg_ctxs to keep track
 of all TCGContext's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting multiple TCG contexts.

Note that having n_tcg_ctxs is unnecessary. However, it is
convenient to have it, since it will simplify iterating over the
array: we'll have just a for loop instead of having to iterate
over a NULL-terminated array (which would require n+1 elems)
or having to check with ifdef's for usermode/softmmu.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 62f418ac8a..24ef6df6b5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -118,6 +118,9 @@ static bool tcg_out_ldst_finalize(TCGContext *s);
 
 #define TCG_HIGHWATER 1024
 
+static TCGContext **tcg_ctxs;
+static unsigned int n_tcg_ctxs;
+
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -384,6 +387,8 @@ void tcg_context_init(TCGContext *s)
     }
 
     tcg_ctx = s;
+    tcg_ctxs = &tcg_ctx;
+    n_tcg_ctxs = 1;
 }
 
 /*
-- 
2.13.6
