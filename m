Received: from eggs.gnu.org ([2001:4830:134:3::10]:36440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8GkT-0004RH-UP
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8GkS-0007ab-CT
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:38 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:42579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f8GkS-0007Z8-6p
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:36 -0400
Received: by mail-pf0-x241.google.com with SMTP id o16so11458307pfk.9
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 19:53:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Apr 2018 16:53:27 -1000
Message-Id: <20180417025328.25431-2-richard.henderson@linaro.org>
In-Reply-To: <20180417025328.25431-1-richard.henderson@linaro.org>
References: <20180417025328.25431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] fpu: Check for inf/x before x/0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

The re-factoring of div_floats changed the order of checking meaning
an operation like -inf/0 erroneously raises the divbyzero flag.
IEEE-754 (2008) specifies this should only occur for operations
on finite operands.

We fix this by moving the check on the dividend being Inf/0 to
before the divisor is zero check.

Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index fb8663f59e..ba6e654050 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1146,15 +1146,20 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
         a.cls = float_class_dnan;
         return a;
     }
-    /* Div 0 => Inf */
+    /* Inf / x */
+    if (a.cls == float_class_inf) {
+        a.sign = sign;
+        return a;
+    }
+    /* x / 0 => Inf */
     if (b.cls == float_class_zero) {
         s->float_exception_flags |= float_flag_divbyzero;
         a.cls = float_class_inf;
         a.sign = sign;
         return a;
     }
-    /* Inf / x or 0 / x */
-    if (a.cls == float_class_inf || a.cls == float_class_zero) {
+    /* 0 / x */
+    if (a.cls == float_class_zero) {
         a.sign = sign;
         return a;
     }
-- 
2.14.3
