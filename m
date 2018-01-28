Received: from eggs.gnu.org ([2001:4830:134:3::10]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBi-0003Fz-7v
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1efwBh-0000l5-8r
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:38 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:40458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1efwBh-0000jd-2U
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 18:16:37 -0500
Received: by mail-pg0-x242.google.com with SMTP id g16so3004902pgn.7
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 15:16:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun, 28 Jan 2018 15:15:27 -0800
Message-Id: <20180128231528.22719-43-richard.henderson@linaro.org>
In-Reply-To: <20180128231528.22719-1-richard.henderson@linaro.org>
References: <20180128231528.22719-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v4 42/43] target/hppa: Fix 32-bit operand masks
 for 0E FCVT
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

We masked the wrong bits, which prevented some of the
32-bit R registers.  E.g. "fcnvxf,sgl,sgl fr22R,fr6R".

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index b9b097acc9..c62ee72615 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -4381,34 +4381,34 @@ static const DisasInsn table_float_0e[] = {
     /* floating point class one */
     /* float/float */
     { 0x38000a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_s },
-    { 0x38002200, 0xfc1fffc0, FOP_DEW = gen_helper_fcnv_s_d },
+    { 0x38002200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_d },
     /* int/float */
-    { 0x38008200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_w_s },
+    { 0x38008200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_w_s },
     { 0x38008a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_dw_s },
     { 0x3800a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_w_d },
     { 0x3800aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_dw_d },
     /* float/int */
-    { 0x38010200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_s_w },
+    { 0x38010200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_s_w },
     { 0x38010a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_w },
     { 0x38012200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_dw },
     { 0x38012a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_dw },
     /* float/int truncate */
-    { 0x38018200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_t_s_w },
+    { 0x38018200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_t_s_w },
     { 0x38018a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_t_d_w },
     { 0x3801a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_t_s_dw },
     { 0x3801aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_dw },
     /* uint/float */
-    { 0x38028200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_uw_s },
+    { 0x38028200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_uw_s },
     { 0x38028a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_udw_s },
     { 0x3802a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_uw_d },
     { 0x3802aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_udw_d },
     /* float/uint */
-    { 0x38030200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_s_uw },
+    { 0x38030200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_s_uw },
     { 0x38030a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_d_uw },
     { 0x38032200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_s_udw },
     { 0x38032a00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_d_udw },
     /* float/uint truncate */
-    { 0x38038200, 0xfc1ffe60, FOP_WEW = gen_helper_fcnv_t_s_uw },
+    { 0x38038200, 0xfc1ffe20, FOP_WEW = gen_helper_fcnv_t_s_uw },
     { 0x38038a00, 0xfc1fffa0, FOP_WED = gen_helper_fcnv_t_d_uw },
     { 0x3803a200, 0xfc1fff60, FOP_DEW = gen_helper_fcnv_t_s_udw },
     { 0x3803aa00, 0xfc1fffe0, FOP_DED = gen_helper_fcnv_t_d_udw },
-- 
2.14.3
