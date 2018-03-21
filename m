Received: from eggs.gnu.org ([2001:4830:134:3::10]:42163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029w-U3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5Q-0000yF-Qj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5Q-0000xT-M0
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:38 -0400
Message-Id: <1521663109-32262-4-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 03/14] softfloat: fix {min,
 max}nummag for same-abs-value inputs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Before 8936006 ("fpu/softfloat: re-factor minmax", 2018-02-21),
we used to return +Zero for maxnummag(-Zero,+Zero); after that
commit, we return -Zero.

Fix it by making {min,max}nummag consistent with {min,max}num,
deferring to the latter when the absolute value of the operands
is the same.

With this fix we now pass fp-test.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e124df9..ee615a9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1700,7 +1700,6 @@ static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
         return pick_nan(a, b, s);
     } else {
         int a_exp, b_exp;
-        bool a_sign, b_sign;
 
         switch (a.cls) {
         case float_class_normal:
@@ -1731,20 +1730,22 @@ static FloatParts minmax_floats(FloatParts a, FloatParts b, bool ismin,
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
2.7.4
