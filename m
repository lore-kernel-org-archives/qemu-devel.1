Received: from eggs.gnu.org ([2001:4830:134:3::10]:47355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBep-0004hf-Sq
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiBeo-0004y1-Tw
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:59 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:37814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiBeo-0004xn-Ng
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 23:11:58 -0500
Received: by mail-pl0-x241.google.com with SMTP id ay8so9372650plb.4
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 20:11:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  3 Feb 2018 20:11:24 -0800
Message-Id: <20180204041136.17525-13-richard.henderson@linaro.org>
In-Reply-To: <20180204041136.17525-1-richard.henderson@linaro.org>
References: <20180204041136.17525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/24] fpu/soft-fp: Add ties_away and to_odd
 rounding modes
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

These rounding modes are used by ARM and PowerPC respectively.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/op-common.h | 20 ++++++++++++++++++++
 fpu/soft-fp.h   | 25 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/fpu/op-common.h b/fpu/op-common.h
index 4526afd1b6..c5f33c0148 100644
--- a/fpu/op-common.h
+++ b/fpu/op-common.h
@@ -130,6 +130,7 @@
   do							\
     {							\
       if (FP_ROUNDMODE == FP_RND_NEAREST		\
+	  || FP_ROUNDMODE == FP_RND_TIESAWAY		\
 	  || (FP_ROUNDMODE == FP_RND_PINF && !X##_s)	\
 	  || (FP_ROUNDMODE == FP_RND_MINF && X##_s))	\
 	{						\
@@ -287,6 +288,7 @@
 		  switch (FP_ROUNDMODE)					\
 		    {							\
 		    case FP_RND_NEAREST:				\
+		    case FP_RND_TIESAWAY:				\
 		      X##_c = FP_CLS_INF;				\
 		      break;						\
 		    case FP_RND_PINF:					\
@@ -297,6 +299,10 @@
 		      if (X##_s)					\
 			X##_c = FP_CLS_INF;				\
 		      break;						\
+		    case FP_RND_ODD:					\
+		      break;						\
+		    default:						\
+		      _FP_UNREACHABLE;					\
 		    }							\
 		  if (X##_c == FP_CLS_INF)				\
 		    {							\
@@ -1610,10 +1616,14 @@
 	  switch (FP_ROUNDMODE)						\
 	    {								\
 	    case FP_RND_NEAREST:					\
+	    case FP_RND_TIESAWAY:					\
 	      _FP_TO_INT_ROUND_rounds_away				\
 		= (X##_e == _FP_EXPBIAS_##fs - 1			\
 		   && !_FP_FRAC_ZEROP_##wc (X));			\
 	      break;							\
+	    case FP_RND_ODD:						\
+	      _FP_TO_INT_ROUND_rounds_away = 1;				\
+	      break;							\
 	    case FP_RND_ZERO:						\
 	      /* _FP_TO_INT_ROUND_rounds_away is already 0.  */		\
 	      break;							\
@@ -1623,6 +1633,8 @@
 	    case FP_RND_MINF:						\
 	      _FP_TO_INT_ROUND_rounds_away = X##_s;			\
 	      break;							\
+	    default:							\
+	      _FP_UNREACHABLE;						\
 	    }								\
 	  if ((rsigned) == 0 && _FP_TO_INT_ROUND_rounds_away && X##_s)	\
 	    {								\
@@ -1740,6 +1752,14 @@
 		    case FP_RND_MINF:					\
 		      _FP_ROUND_MINF (wc, X);				\
 		      break;						\
+		    case FP_RND_TIESAWAY:				\
+		      _FP_ROUND_TIESAWAY (wc, X);			\
+		      break;						\
+		    case FP_RND_ODD:					\
+		      _FP_ROUND_ODD (wc, X);				\
+		      break;						\
+		    default:						\
+		      _FP_UNREACHABLE;					\
 		    }							\
 		}							\
 	      _FP_FRAC_SRL_##wc (X, _FP_WORKBITS);			\
diff --git a/fpu/soft-fp.h b/fpu/soft-fp.h
index a7a01334b7..a95485f465 100644
--- a/fpu/soft-fp.h
+++ b/fpu/soft-fp.h
@@ -93,6 +93,8 @@
 # define FP_RND_ZERO		1
 # define FP_RND_PINF		2
 # define FP_RND_MINF		3
+# define FP_RND_TIESAWAY	4
+# define FP_RND_ODD		5
 #endif
 #ifndef FP_ROUNDMODE
 # define FP_ROUNDMODE		FP_RND_NEAREST
@@ -282,6 +284,21 @@
     }						\
   while (0)
 
+#define _FP_ROUND_TIESAWAY(wc, X)		\
+  do						\
+    {						\
+      _FP_FRAC_ADDI_##wc (X, _FP_WORK_ROUND);	\
+    }						\
+  while (0)
+
+#define _FP_ROUND_ODD(wc, X)				\
+  do							\
+    {							\
+      if (!(_FP_FRAC_LOW_##wc (X) & _FP_WORK_LSB))	\
+        _FP_FRAC_ADDI_##wc (X, _FP_WORK_LSB - 1);	\
+    }							\
+  while (0)
+
 #define _FP_ROUND(wc, X)			\
   do						\
     {						\
@@ -302,6 +319,14 @@
 	    case FP_RND_MINF:			\
 	      _FP_ROUND_MINF (wc, X);		\
 	      break;				\
+	    case FP_RND_TIESAWAY:		\
+	      _FP_ROUND_TIESAWAY (wc, X);	\
+	      break;				\
+	    case FP_RND_ODD:			\
+	      _FP_ROUND_ODD (wc, X);		\
+	      break;				\
+            default:				\
+	      _FP_UNREACHABLE;			\
 	    }					\
 	}					\
     }						\
-- 
2.14.3
