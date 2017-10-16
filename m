Received: from eggs.gnu.org ([2001:4830:134:3::10]:52800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49Ab-0002pM-5b
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49Aa-00041e-By
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:17 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:46254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49Aa-00040w-5j
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:27:16 -0400
Received: by mail-pf0-x234.google.com with SMTP id p87so16296522pfj.3
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:27:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:26:03 -0700
Message-Id: <20171016172609.23422-45-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 44/50] tcg: introduce **tcg_ctxs to keep
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Groundwork for supporting multiple TCG contexts.

Note that having n_tcg_ctxs is unnecessary. However, it is
convenient to have it, since it will simplify iterating over the
array: we'll have just a for loop instead of having to iterate
over a NULL-terminated array (which would require n+1 elems)
or having to check with ifdef's for usermode/softmmu.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e509fdc255..225e7cccea 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -118,6 +118,9 @@ static bool tcg_out_ldst_finalize(TCGContext *s);
 
 #define TCG_HIGHWATER 1024
 
+static TCGContext **tcg_ctxs;
+static unsigned int n_tcg_ctxs;
+
 static TCGRegSet tcg_target_available_regs[2];
 static TCGRegSet tcg_target_call_clobber_regs;
 
@@ -387,6 +390,8 @@ void tcg_context_init(TCGContext *s)
     }
 
     tcg_ctx = s;
+    tcg_ctxs = &tcg_ctx;
+    n_tcg_ctxs = 1;
 }
 
 /*
-- 
2.13.6
