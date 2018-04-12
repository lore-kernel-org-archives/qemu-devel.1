Received: from eggs.gnu.org ([2001:4830:134:3::10]:44907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6asI-0007LM-9J
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6asE-0007Py-HM
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:46 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:52877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6asE-0007PS-Bx
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:42 -0400
Received: by mail-wm0-x243.google.com with SMTP id g8so10970732wmd.2
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 04:58:42 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Apr 2018 12:58:38 +0100
Message-Id: <20180412115838.10208-3-alex.bennee@linaro.org>
In-Reply-To: <20180412115838.10208-1-alex.bennee@linaro.org>
References: <20180412115838.10208-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/2] fpu/softfloat: raise float_invalid for
 NaN in float_to_int
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

Fixes https://bugs.launchpad.net/qemu/+bug/1759264

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 fpu/softfloat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9b99aa6ec8..ddc77c273c 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1344,6 +1344,7 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode,
     case float_class_qnan:
     case float_class_dnan:
     case float_class_msnan:
+        s->float_exception_flags = orig_flags | float_flag_invalid;
         return max;
     case float_class_inf:
         return p.sign ? min : max;
-- 
2.17.0
