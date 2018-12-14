Received: from eggs.gnu.org ([2001:4830:134:3::10]:55685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxY-0004PU-Sd
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXfxX-0005MU-Q8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXfxX-0005Ln-J4
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 00:24:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id t5so4341951otk.1
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 21:24:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 23:23:51 -0600
Message-Id: <20181214052410.11863-9-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-1-richard.henderson@linaro.org>
References: <20181214052410.11863-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 08/27] target/arm: Decode PAuth within
 disas_data_proc_2src
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7ba4c996cf..d034a5edf3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4884,6 +4884,13 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
     case 11: /* RORV */
         handle_shift_reg(s, A64_SHIFT_TYPE_ROR, sf, rm, rn, rd);
         break;
+    case 12: /* PACGA */
+        if (sf == 0 || !dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        gen_helper_pacga(cpu_reg(s, rd), cpu_env,
+                         cpu_reg(s, rn), cpu_reg_sp(s, rm));
+        break;
     case 16:
     case 17:
     case 18:
@@ -4899,6 +4906,7 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    do_unallocated:
         unallocated_encoding(s);
         break;
     }
-- 
2.17.2
