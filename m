Received: from eggs.gnu.org ([2001:4830:134:3::10]:44808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbc-0006Zw-K1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5gbb-0007zv-3a
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:32 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:45640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5gba-0007zY-Tc
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 19:21:31 -0400
Received: by mail-pf0-x244.google.com with SMTP id d28so13079027pfe.2
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 16:21:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 20 Oct 2017 16:20:15 -0700
Message-Id: <20171020232023.15010-45-richard.henderson@linaro.org>
In-Reply-To: <20171020232023.15010-1-richard.henderson@linaro.org>
References: <20171020232023.15010-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v7 44/52] tcg: introduce **tcg_ctxs to keep
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
Cc: cota@braap.org, f4bug@amsat.org, pbonzini@redhat.com

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
