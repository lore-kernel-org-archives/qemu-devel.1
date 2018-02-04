Received: from eggs.gnu.org ([2001:4830:134:3::10]:47344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeo-0004gK-Gv
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBen-0004xY-HG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:58 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:34683)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBen-0004xE-BD
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:57 -0500
Received: by mail-pl0-x242.google.com with SMTP id q17so7156124pll.1
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:11:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:23 -0800
Message-Id: <20180204041136.17525-12-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 11/24] fpu/soft-fp: Adjust soft-fp types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, cota@braap.org, hsp.cat7@gmail.com

Glibc uses host compiler floating-point types for packing.
We need to use softfloat.h types.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/double.h | 6 ++----
 fpu/half.h   | 4 +---
 fpu/quad.h   | 6 ++----
 fpu/single.h | 4 +---
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/fpu/double.h b/fpu/double.h
index f6c83d7253..6f8fe49a7d 100644
--- a/fpu/double.h
+++ b/fpu/double.h
@@ -69,13 +69,11 @@
 #define _FP_HIGHBIT_DW_D	\
   ((_FP_W_TYPE) 1 << (_FP_WFRACBITS_DW_D - 1) % _FP_W_TYPE_SIZE)
 
-typedef float DFtype __attribute__ ((mode (DF)));
-
 #if _FP_W_TYPE_SIZE < 64
 
 union _FP_UNION_D
 {
-  DFtype flt;
+  float64 flt;
   struct _FP_STRUCT_LAYOUT
   {
 # if __BYTE_ORDER == __BIG_ENDIAN
@@ -198,7 +196,7 @@ union _FP_UNION_D
 
 union _FP_UNION_D
 {
-  DFtype flt;
+  float64 flt;
   struct _FP_STRUCT_LAYOUT
   {
 # if __BYTE_ORDER == __BIG_ENDIAN
diff --git a/fpu/half.h b/fpu/half.h
index ea28db6c18..75a3168a75 100644
--- a/fpu/half.h
+++ b/fpu/half.h
@@ -59,11 +59,9 @@
 /* The implementation of _FP_MUL_MEAT_H and _FP_DIV_MEAT_H should be
    chosen by the target machine.  */
 
-typedef float HFtype __attribute__ ((mode (HF)));
-
 union _FP_UNION_H
 {
-  HFtype flt;
+  float16 flt;
   struct _FP_STRUCT_LAYOUT
   {
 #if __BYTE_ORDER == __BIG_ENDIAN
diff --git a/fpu/quad.h b/fpu/quad.h
index 71621f01bf..24a3245fb7 100644
--- a/fpu/quad.h
+++ b/fpu/quad.h
@@ -69,13 +69,11 @@
 #define _FP_HIGHBIT_DW_Q	\
   ((_FP_W_TYPE) 1 << (_FP_WFRACBITS_DW_Q - 1) % _FP_W_TYPE_SIZE)
 
-typedef float TFtype __attribute__ ((mode (TF)));
-
 #if _FP_W_TYPE_SIZE < 64
 
 union _FP_UNION_Q
 {
-  TFtype flt;
+  float128 flt;
   struct _FP_STRUCT_LAYOUT
   {
 # if __BYTE_ORDER == __BIG_ENDIAN
@@ -202,7 +200,7 @@ union _FP_UNION_Q
 #else   /* not _FP_W_TYPE_SIZE < 64 */
 union _FP_UNION_Q
 {
-  TFtype flt /* __attribute__ ((mode (TF))) */ ;
+  float128 flt;
   struct _FP_STRUCT_LAYOUT
   {
     _FP_W_TYPE a, b;
diff --git a/fpu/single.h b/fpu/single.h
index 2918f78d97..91252f82ff 100644
--- a/fpu/single.h
+++ b/fpu/single.h
@@ -66,11 +66,9 @@
 /* The implementation of _FP_MUL_MEAT_S and _FP_DIV_MEAT_S should be
    chosen by the target machine.  */
 
-typedef float SFtype __attribute__ ((mode (SF)));
-
 union _FP_UNION_S
 {
-  SFtype flt;
+  float32 flt;
   struct _FP_STRUCT_LAYOUT
   {
 #if __BYTE_ORDER == __BIG_ENDIAN
-- 
2.14.3
