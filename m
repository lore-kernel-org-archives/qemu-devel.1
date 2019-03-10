Received: from eggs.gnu.org ([209.51.188.92]:43367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tot-0001jx-RJ
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tos-0001qy-SX
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:39 +1100
Message-Id: <20190310082703.1245-37-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 36/60] target/ppc: move Vsr* macros from
 internal.h to cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

It isn't possible to include internal.h from cpu.h so move the Vsr* macro=
s
into cpu.h alongside the other VMX/VSX register access functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20190307180520.13868-4-mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h      | 20 ++++++++++++++++++++
 target/ppc/internal.h | 19 -------------------
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0c3fc8e084..1c4af4a1dc 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -2563,6 +2563,26 @@ static inline bool lsw_reg_in_range(int start, int=
 nregs, int rx)
 }
=20
 /* Accessors for FP, VMX and VSX registers */
+#if defined(HOST_WORDS_BIGENDIAN)
+#define VsrB(i) u8[i]
+#define VsrSB(i) s8[i]
+#define VsrH(i) u16[i]
+#define VsrSH(i) s16[i]
+#define VsrW(i) u32[i]
+#define VsrSW(i) s32[i]
+#define VsrD(i) u64[i]
+#define VsrSD(i) s64[i]
+#else
+#define VsrB(i) u8[15 - (i)]
+#define VsrSB(i) s8[15 - (i)]
+#define VsrH(i) u16[7 - (i)]
+#define VsrSH(i) s16[7 - (i)]
+#define VsrW(i) u32[3 - (i)]
+#define VsrSW(i) s32[3 - (i)]
+#define VsrD(i) u64[1 - (i)]
+#define VsrSD(i) s64[1 - (i)]
+#endif
+
 static inline int fpr_offset(int i)
 {
     return offsetof(CPUPPCState, vsr[i].u64[0]);
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index f26a71ffcf..3ebbdf4da4 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -204,25 +204,6 @@ EXTRACT_HELPER(IMM8, 11, 8);
 EXTRACT_HELPER(DCMX, 16, 7);
 EXTRACT_HELPER_SPLIT_3(DCMX_XV, 5, 16, 0, 1, 2, 5, 1, 6, 6);
=20
-#if defined(HOST_WORDS_BIGENDIAN)
-#define VsrB(i) u8[i]
-#define VsrSB(i) s8[i]
-#define VsrH(i) u16[i]
-#define VsrSH(i) s16[i]
-#define VsrW(i) u32[i]
-#define VsrSW(i) s32[i]
-#define VsrD(i) u64[i]
-#define VsrSD(i) s64[i]
-#else
-#define VsrB(i) u8[15 - (i)]
-#define VsrSB(i) s8[15 - (i)]
-#define VsrH(i) u16[7 - (i)]
-#define VsrSH(i) s16[7 - (i)]
-#define VsrW(i) u32[3 - (i)]
-#define VsrSW(i) s32[3 - (i)]
-#define VsrD(i) u64[1 - (i)]
-#define VsrSD(i) s64[1 - (i)]
-#endif
 static inline void getVSR(int n, ppc_vsr_t *vsr, CPUPPCState *env)
 {
     vsr->VsrD(0) =3D env->vsr[n].u64[0];
--=20
2.20.1
