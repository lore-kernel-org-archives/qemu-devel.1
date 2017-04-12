Received: from eggs.gnu.org ([2001:4830:134:3::10]:41196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6ux-00082N-Mc
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cy6uw-0006Q0-Cr
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 21:17:55 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 11 Apr 2017 21:17:26 -0400
Message-Id: <1491959850-30756-7-git-send-email-cota@braap.org>
In-Reply-To: <1491959850-30756-1-git-send-email-cota@braap.org>
References: <1491959850-30756-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 06/10] tcg: add brcondi_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Claudio Fontana <claudio.fontana@huawei.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

This will be used by TCG targets to implement a fast path
for indirect branches.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tcg/tcg-op.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 1924633..abf784b 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -1118,6 +1118,8 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
     tcg_gen_addi_i32(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
 # define tcg_gen_ext_i32_ptr(R, A) \
     tcg_gen_mov_i32(TCGV_PTR_TO_NAT(R), (A))
+# define tcg_gen_brcondi_ptr(C, A, I, L) \
+    tcg_gen_brcondi_i32(C, TCGV_PTR_TO_NAT(A), (uintptr_t)I, L)
 #else
 # define tcg_gen_ld_ptr(R, A, O) \
     tcg_gen_ld_i64(TCGV_PTR_TO_NAT(R), (A), (O))
@@ -1129,4 +1131,6 @@ void tcg_gen_atomic_xor_fetch_i64(TCGv_i64, TCGv, TCGv_i64, TCGArg, TCGMemOp);
     tcg_gen_addi_i64(TCGV_PTR_TO_NAT(R), TCGV_PTR_TO_NAT(A), (B))
 # define tcg_gen_ext_i32_ptr(R, A) \
     tcg_gen_ext_i32_i64(TCGV_PTR_TO_NAT(R), (A))
+# define tcg_gen_brcondi_ptr(C, A, I, L) \
+    tcg_gen_brcondi_i64(C, TCGV_PTR_TO_NAT(A), (uintptr_t)I, L)
 #endif /* UINTPTR_MAX == UINT32_MAX */
-- 
2.7.4
