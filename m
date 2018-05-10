Received: from eggs.gnu.org ([2001:4830:134:3::10]:54489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGm8u-0004jW-MQ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGm8l-00075n-7Z
	for qemu-devel@nongnu.org; Thu, 10 May 2018 10:02:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 15:01:41 +0100
Message-Id: <20180510140141.12120-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] fpu/softfloat: Don't set Invalid for
 float-to-int(MAXINT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

In float-to-integer conversion, if the floating point input
converts exactly to the largest or smallest integer that
fits in to the result type, this is not an overflow.
In this situation we were producing the correct result value,
but were incorrectly setting the Invalid flag.
For example for Arm A64, "FCVTAS w0, d0" on an input of
0x41dfffffffc00000 should produce 0x7fffffff and set no flags.

Fix the boundary case to take the right half of the if()
statements.

This fixes a regression from 2.11 introduced by the softfloat
refactoring.

Cc: qemu-stable@nongnu.org
Fixes: ab52f973a50
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8401b37bd4..9bcaaebe4f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1368,14 +1368,14 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
             r = UINT64_MAX;
         }
         if (p.sign) {
-            if (r < -(uint64_t) min) {
+            if (r <= -(uint64_t) min) {
                 return -r;
             } else {
                 s->float_exception_flags = orig_flags | float_flag_invalid;
                 return min;
             }
         } else {
-            if (r < max) {
+            if (r <= max) {
                 return r;
             } else {
                 s->float_exception_flags = orig_flags | float_flag_invalid;
-- 
2.17.0
