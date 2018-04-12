Received: from eggs.gnu.org ([2001:4830:134:3::10]:44902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6asH-0007LH-ML
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6asD-0007Od-AY
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:45 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6asD-0007Mw-2y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:41 -0400
Received: by mail-wr0-x244.google.com with SMTP id v60so940575wrc.7
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 04:58:40 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Apr 2018 12:58:37 +0100
Message-Id: <20180412115838.10208-2-alex.bennee@linaro.org>
In-Reply-To: <20180412115838.10208-1-alex.bennee@linaro.org>
References: <20180412115838.10208-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/2] softfloat: fix {min,
 max}nummag for same-abs-value inputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

Before 8936006 ("fpu/softfloat: re-factor minmax", 2018-02-21),
we used to return +Zero for maxnummag(-Zero,+Zero); after that
commit, we return -Zero.

Fix it by making {min,max}nummag consistent with {min,max}num,
deferring to the latter when the absolute value of the operands
is the same.

With this fix we now pass fp-test.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b46dccc63e..9b99aa6ec8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1704,7 +1704,6 @@ static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
         return pick_nan(a, b, s);
     } else {
         int a_exp, b_exp;
-        bool a_sign, b_sign;
 
         switch (a.cls) {
         case float_class_normal:
@@ -1735,20 +1734,22 @@ static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
             break;
         }
 
-        a_sign = a.sign;
-        b_sign = b.sign;
-        if (ismag) {
-            a_sign = b_sign = 0;
+        if (ismag && (a_exp != b_exp || a.frac != b.frac)) {
+            bool a_less = a_exp < b_exp;
+            if (a_exp == b_exp) {
+                a_less = a.frac < b.frac;
+            }
+            return a_less ^ ismin ? b : a;
         }
 
-        if (a_sign == b_sign) {
+        if (a.sign == b.sign) {
             bool a_less = a_exp < b_exp;
             if (a_exp == b_exp) {
                 a_less = a.frac < b.frac;
             }
-            return a_sign ^ a_less ^ ismin ? b : a;
+            return a.sign ^ a_less ^ ismin ? b : a;
         } else {
-            return a_sign ^ ismin ? b : a;
+            return a.sign ^ ismin ? b : a;
         }
     }
 }
-- 
2.17.0
