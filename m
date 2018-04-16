Received: from eggs.gnu.org ([2001:4830:134:3::10]:36317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f84at-0005Ez-0Q
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f84ao-0006sj-Ha
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:54:55 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f84ao-0006s3-AW
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 09:54:50 -0400
Received: by mail-wr0-x243.google.com with SMTP id w3so9666585wrg.2
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 06:54:49 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 16 Apr 2018 14:54:42 +0100
Message-Id: <20180416135442.30606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Aurelien Jarno <aurelien@aurel32.net>

The re-factoring of div_floats changed the order of checking meaning
an operation like -inf/0 erroneously raises the divbyzero flag.
IEEE-754 (2008) specifies this should only occur for operations on
finite operands.

We fix this by moving the check on the dividend being Inf/0 to before
the divisor is zero check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 fpu/softfloat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b46dccc63e..a7d0f3ff56 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1146,6 +1146,11 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
         a.cls = float_class_dnan;
         return a;
     }
+    /* Inf / x or 0 / x */
+    if (a.cls == float_class_inf || a.cls == float_class_zero) {
+        a.sign = sign;
+        return a;
+    }
     /* Div 0 => Inf */
     if (b.cls == float_class_zero) {
         s->float_exception_flags |= float_flag_divbyzero;
@@ -1153,11 +1158,6 @@ static FloatParts div_floats(FloatParts a, FloatParts b, float_status *s)
         a.sign = sign;
         return a;
     }
-    /* Inf / x or 0 / x */
-    if (a.cls == float_class_inf || a.cls == float_class_zero) {
-        a.sign = sign;
-        return a;
-    }
     /* Div by Inf */
     if (b.cls == float_class_inf) {
         a.cls = float_class_zero;
-- 
2.17.0
