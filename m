Received: from eggs.gnu.org ([209.51.188.92]:42997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbU-0002lh-5Y
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbS-0007Ms-Lb
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:40 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbS-0007CU-DS
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id m22so4808977wml.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:23 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.20 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:29 +0000
Message-Id: <20190118145805.6852-14-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/49] target/arm: Decode PAuth within
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8a8408c1b7d..3f08db580bf 100644
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
2.20.1
