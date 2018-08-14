Received: from eggs.gnu.org ([2001:4830:134:3::10]:33903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHm-0006H2-PZ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fpOHj-0002GO-KS
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56313)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fpOHj-0002Fy-Ec
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:38:11 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon, 13 Aug 2018 21:38:00 -0400
Message-Id: <20180814013801.26036-4-cota@braap.org>
In-Reply-To: <20180814013801.26036-1-cota@braap.org>
References: <20180814013801.26036-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 3/4] target/i386/translate: use thread-local
 storage in !user-mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Needed for MTTCG.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 07d185e7b6..f4c2a41f8f 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -71,26 +71,34 @@
 
 //#define MACRO_TEST   1
 
+/* we need thread-local storage for mttcg */
+#ifdef CONFIG_USER_ONLY
+#define I386_THREAD
+#else
+#define I386_THREAD __thread
+#endif
+
 /* global register indexes */
-static TCGv cpu_A0;
-static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2, cpu_cc_srcT;
+static TCGv cpu_cc_dst, cpu_cc_src, cpu_cc_src2;
 static TCGv_i32 cpu_cc_op;
 static TCGv cpu_regs[CPU_NB_REGS];
 static TCGv cpu_seg_base[6];
 static TCGv_i64 cpu_bndl[4];
 static TCGv_i64 cpu_bndu[4];
 /* local temps */
-static TCGv cpu_T0, cpu_T1;
+static I386_THREAD TCGv cpu_cc_srcT;
+static I386_THREAD TCGv cpu_A0;
+static I386_THREAD TCGv cpu_T0, cpu_T1;
 /* local register indexes (only used inside old micro ops) */
-static TCGv cpu_tmp0, cpu_tmp4;
-static TCGv_ptr cpu_ptr0, cpu_ptr1;
-static TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
-static TCGv_i64 cpu_tmp1_i64;
+static I386_THREAD TCGv cpu_tmp0, cpu_tmp4;
+static I386_THREAD TCGv_ptr cpu_ptr0, cpu_ptr1;
+static I386_THREAD TCGv_i32 cpu_tmp2_i32, cpu_tmp3_i32;
+static I386_THREAD TCGv_i64 cpu_tmp1_i64;
 
 #include "exec/gen-icount.h"
 
 #ifdef TARGET_X86_64
-static int x86_64_hregs;
+static I386_THREAD int x86_64_hregs;
 #endif
 
 typedef struct DisasContext {
-- 
2.17.1
