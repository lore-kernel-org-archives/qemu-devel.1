Received: from eggs.gnu.org ([2001:4830:134:3::10]:57878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCf-0002TI-LJ
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCc-0007wi-OP
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gBTCc-0007ve-HV
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 13 Oct 2018 19:19:21 -0400
Message-Id: <20181013231933.28789-2-cota@braap.org>
In-Reply-To: <20181013231933.28789-1-cota@braap.org>
References: <20181013231933.28789-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 01/13] fp-test: pick TARGET_ARM to get its
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
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

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
