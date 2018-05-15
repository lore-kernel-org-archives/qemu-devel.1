Received: from eggs.gnu.org ([2001:4830:134:3::10]:39566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabl-0003pd-Cj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabf-0002na-L4
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:17 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fIabf-0002mA-Dx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:07:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fIabe-0001Nh-39
	for qemu-devel@nongnu.org; Tue, 15 May 2018 15:07:10 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 15:06:53 +0100
Message-Id: <20180515140707.15957-3-peter.maydell@linaro.org>
In-Reply-To: <20180515140707.15957-1-peter.maydell@linaro.org>
References: <20180515140707.15957-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 02/16] fpu/softfloat: Don't set Invalid for
 float-to-int(MAXINT)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180510140141.12120-1-peter.maydell@linaro.org
---
 fpu/softfloat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index b39c0c6fbb..bc0f52fa54 100644
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
