Received: from eggs.gnu.org ([2001:4830:134:3::10]:49117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnvg-0008Kv-D8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gXnve-0001vI-Ix
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:55:00 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:36222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gXnve-0001ur-CL
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:54:58 -0500
Received: by mail-wr1-x436.google.com with SMTP id u4so4543847wrp.3
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:54:57 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 14 Dec 2018 13:54:40 +0000
Message-Id: <20181214135452.25936-4-alex.bennee@linaro.org>
In-Reply-To: <20181214135452.25936-1-alex.bennee@linaro.org>
References: <20181214135452.25936-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/15] fp-test: pick TARGET_ARM to get its
 specialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

This gets rid of the muladd errors due to not raising the invalid flag.

- Before:
Errors found in f64_mulAdd, rounding near_even, tininess before rounding:
+000.0000000000000  +7FF.0000000000000  +7FF.FFFFFFFFFFFFF
        => +7FF.FFFFFFFFFFFFF .....  expected -7FF.FFFFFFFFFFFFF v....
[...]

- After:
In 6133248 tests, no errors found in f64_mulAdd, rounding near_even, tininess before rounding.
[...]

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/fp/Makefile b/tests/fp/Makefile
index d649a5a1db..49cdcd1bd2 100644
--- a/tests/fp/Makefile
+++ b/tests/fp/Makefile
@@ -29,6 +29,9 @@ QEMU_INCLUDES += -I$(TF_SOURCE_DIR)
 
 # work around TARGET_* poisoning
 QEMU_CFLAGS += -DHW_POISON_H
+# define a target to match testfloat's implementation-defined choices, such as
+# whether to raise the invalid flag when dealing with NaNs in muladd.
+QEMU_CFLAGS += -DTARGET_ARM
 
 # capstone has a platform.h file that clashes with softfloat's
 QEMU_CFLAGS := $(filter-out %capstone, $(QEMU_CFLAGS))
-- 
2.17.1
