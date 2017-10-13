Received: from eggs.gnu.org ([2001:4830:134:3::10]:43970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sW-0000XU-LD
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1e32sV-0002Eo-S6
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:04 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:56887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1e32sV-0002Ds-Ml
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 12:32:03 -0400
Received: by mail-wm0-x236.google.com with SMTP id l68so22848263wmd.5
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 09:32:03 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Oct 2017 17:24:37 +0100
Message-Id: <20171013162438.32458-30-alex.bennee@linaro.org>
In-Reply-To: <20171013162438.32458-1-alex.bennee@linaro.org>
References: <20171013162438.32458-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 29/30] tests/test-softfloat: add
 f16_to_int16 conversion test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/test-softfloat.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tests/test-softfloat.c b/tests/test-softfloat.c
index d7b740e1cb..e1f356572d 100644
--- a/tests/test-softfloat.c
+++ b/tests/test-softfloat.c
@@ -16,6 +16,31 @@ typedef struct {
     uint8_t final_exception_flags;
 } f16_test_data;
 
+static void test_f16_convert_to_int(void)
+{
+    int i;
+    float16 out;
+    float_status flags, *fp = &flags;
+    f16_test_data test_data[] = {
+        /* from risu fcvtps  v23.4h, v16.4h */
+        { { .float_rounding_mode = float_round_up}, 0xa619, 0xb860, 0 },
+        { { .float_rounding_mode = float_round_up}, 0x83c0, 0xff91, 0 },
+        { { .float_rounding_mode = float_round_up}, 0x6966, 0x0001, 0 },
+        { { .float_rounding_mode = float_round_up}, 0x06b1, 0x0001, 0 },
+    };
+
+    for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
+        flags = test_data[i].initial_status;
+        out = float16_to_int16(test_data[i].in, fp);
+
+        if (!(test_data[i].out == out)) {
+            fprintf(stderr, "%s[%d]: expected %#04x got %#04x\n",
+                    __func__, i, test_data[i].out, out);
+            g_test_fail();
+        }
+    }
+}
+
 static void test_f16_round_to_int(void)
 {
     int i;
@@ -54,5 +79,6 @@ int main(int argc, char *argv[])
 {
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/softfloat/f16/round_to_int", test_f16_round_to_int);
+    g_test_add_func("/softfloat/f16/convert_to_int", test_f16_convert_to_int);
     return g_test_run();
 }
-- 
2.14.1
