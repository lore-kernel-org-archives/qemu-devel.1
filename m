Received: from eggs.gnu.org ([2001:4830:134:3::10]:33217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId5-0003xa-GU
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHId4-0002oV-PM
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:19 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHId4-0002oC-Jp
	for qemu-devel@nongnu.org; Fri, 11 May 2018 20:43:18 -0400
Received: by mail-pf0-x244.google.com with SMTP id a14-v6so3438958pfi.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 17:43:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 17:42:46 -0700
Message-Id: <20180512004311.9299-3-richard.henderson@linaro.org>
In-Reply-To: <20180512004311.9299-1-richard.henderson@linaro.org>
References: <20180512004311.9299-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 02/27] fpu/softfloat: Don't set Invalid for
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

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
