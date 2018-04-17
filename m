Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8GkU-0004RR-V4
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8GkU-0007eC-8a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:39 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:38657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f8GkU-0007cr-2H
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:38 -0400
Received: by mail-pl0-x242.google.com with SMTP id c7-v6so11156769plr.5
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 19:53:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Apr 2018 16:53:28 -1000
Message-Id: <20180417025328.25431-3-richard.henderson@linaro.org>
In-Reply-To: <20180417025328.25431-1-richard.henderson@linaro.org>
References: <20180417025328.25431-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] fpu: Bound increment for scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Without bounding the increment, we can overflow exp either here
in scalbn_decomposed or when adding the bias in round_canonical.
This can result in e.g. underflowing to 0 instead of overflowing
to infinity.

The old softfloat code did bound the increment.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ba6e654050..a589f328c9 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1883,6 +1883,12 @@ static FloatParts scalbn_decomposed(FloatParts a, int n, float_status *s)
         return return_nan(a, s);
     }
     if (a.cls == float_class_normal) {
+        /* The largest float type (even though not supported by FloatParts)
+         * is float128, which has a 15 bit exponent.  Bounding N to 16 bits
+         * still allows rounding to infinity, without allowing overflow
+         * within the int32_t that backs FloatParts.exp.
+         */
+        n = MIN(MAX(n, -0x10000), 0x10000);
         a.exp += n;
     }
     return a;
-- 
2.14.3
