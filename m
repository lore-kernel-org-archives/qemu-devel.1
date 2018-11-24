Received: from eggs.gnu.org ([2001:4830:134:3::10]:57464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmV-0003G5-UD
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gQhmQ-0005Dy-Oo
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:11 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gQhmO-0004eK-8G
	for qemu-devel@nongnu.org; Sat, 24 Nov 2018 18:56:05 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 24 Nov 2018 18:55:41 -0500
Message-Id: <20181124235553.17371-2-cota@braap.org>
In-Reply-To: <20181124235553.17371-1-cota@braap.org>
References: <20181124235553.17371-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 01/13] fp-test: pick TARGET_ARM to get its
 specialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

This gets rid of the muladd errors due to not raising the invalid flag.

- Before:
Errors found in f64_mulAdd, rounding near_even, tininess before rounding:
+000.0000000000000  +7FF.0000000000000  +7FF.FFFFFFFFFFFFF
        => +7FF.FFFFFFFFFFFFF .....  expected -7FF.FFFFFFFFFFFFF v....
[...]

- After:
In 6133248 tests, no errors found in f64_mulAdd, rounding near_even, tininess before rounding.
[...]

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp/Makefile | 3 +++
 1 file changed, 3 insertions(+)

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
