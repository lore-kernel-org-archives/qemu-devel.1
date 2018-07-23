Received: from eggs.gnu.org ([2001:4830:134:3::10]:42830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKM-0003Zm-Eo
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKL-0005Db-F0
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:06 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:19 -0500
Message-Id: <20180723201748.25573-71-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 70/99] fpu/softfloat: Don't set Invalid for
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
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit 333583757c5e910b040bef793974773635ce1918)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
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
2.17.1
