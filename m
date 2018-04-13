Received: from eggs.gnu.org ([2001:4830:134:3::10]:46209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6zIl-00037P-PH
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6zIf-0000bO-Vc
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:03:43 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6zIf-0000b6-Or
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:03:37 -0400
Received: by mail-wr0-x241.google.com with SMTP id o3so8435937wri.2
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:03:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Apr 2018 15:03:34 +0100
Message-Id: <20180413140334.26622-3-alex.bennee@linaro.org>
In-Reply-To: <20180413140334.26622-1-alex.bennee@linaro.org>
References: <20180413140334.26622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/2] fpu/softfloat: raise float_invalid for
 NaN/Inf in round_to_int_and_pack
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Aurelien Jarno <aurelien@aurel32.net>

The re-factor broke the raising of INVALID when NaN/Inf is passed to
the float_to_int conversion functions. round_to_uint_and_pack got this
right for NaN but also missed out the Inf handling.

Fixes https://bugs.launchpad.net/qemu/+bug/1759264

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 fpu/softfloat.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9b99aa6ec8..fb8663f59e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1344,8 +1344,10 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     case float_class_qnan:
     case float_class_dnan:
     case float_class_msnan:
+        s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
+        s->float_exception_flags = orig_flags | float_flag_invalid;
         return p.sign ? min : max;
     case float_class_zero:
         return 0;
@@ -1437,6 +1439,7 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, uint64_t max,
         s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
+        s->float_exception_flags = orig_flags | float_flag_invalid;
         return p.sign ? 0 : max;
     case float_class_zero:
         return 0;
-- 
2.17.0
