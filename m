Received: from eggs.gnu.org ([209.51.188.92]:35416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C66-0002PQ-CR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1h1C64-0002vp-Er
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:14 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54787 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1h1C64-0002mp-0F
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:35:12 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue,  5 Mar 2019 16:34:28 +0100
Message-Id: <1551800076-8104-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1551800076-8104-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 06/14] tests/tcg: target/mips: Fix test
 utilities for 128-bit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Add "static" and "const" modifiers where appropriate, and fix other
minor issues.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
---
 tests/tcg/mips/include/test_inputs.h |  4 ++--
 tests/tcg/mips/include/test_utils.h  | 15 ++++++++-------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/tcg/mips/include/test_inputs.h b/tests/tcg/mips/include/test_inputs.h
index c173d58..5406e4e 100644
--- a/tests/tcg/mips/include/test_inputs.h
+++ b/tests/tcg/mips/include/test_inputs.h
@@ -28,7 +28,7 @@
 #define PATTERN_INPUTS_COUNT          64
 #define PATTERN_INPUTS_SHORT_COUNT     8
 
-uint64_t b128_pattern[PATTERN_INPUTS_COUNT][2] = {
+static const uint64_t b128_pattern[PATTERN_INPUTS_COUNT][2] = {
     { 0xFFFFFFFFFFFFFFFFULL, 0xFFFFFFFFFFFFFFFFULL, },   /*   0 */
     { 0x0000000000000000ULL, 0x0000000000000000ULL, },
     { 0xAAAAAAAAAAAAAAAAULL, 0xAAAAAAAAAAAAAAAAULL, },
@@ -99,7 +99,7 @@ uint64_t b128_pattern[PATTERN_INPUTS_COUNT][2] = {
 #define RANDOM_INPUTS_COUNT           16
 #define RANDOM_INPUTS_SHORT_COUNT      4
 
-uint64_t b128_random[RANDOM_INPUTS_COUNT][2] = {
+static const uint64_t b128_random[RANDOM_INPUTS_COUNT][2] = {
     { 0x886AE6CC28625540ULL, 0x4B670B5EFE7BB00CULL, },   /*   0 */
     { 0xFBBE00634D93C708ULL, 0x12F7BB1A153F52FCULL, },
     { 0xAC5AAEAAB9CF8B80ULL, 0x27D8C6FFAB2B2514ULL, },
diff --git a/tests/tcg/mips/include/test_utils.h b/tests/tcg/mips/include/test_utils.h
index 82f4b5b..9672903 100644
--- a/tests/tcg/mips/include/test_utils.h
+++ b/tests/tcg/mips/include/test_utils.h
@@ -27,14 +27,14 @@
 #include <inttypes.h>
 #include <string.h>
 
-#define PRINT_RESULTS 1
+#define PRINT_RESULTS 0
 
 
-static inline int32_t check_results(char *instruction_name,
-                                    uint32_t test_count,
-                                    double elapsed_time,
-                                    uint64_t *b128_result,
-                                    uint64_t *b128_expect)
+static inline int32_t check_results(const char *instruction_name,
+                                    const uint32_t test_count,
+                                    const double elapsed_time,
+                                    const uint64_t *b128_result,
+                                    const uint64_t *b128_expect)
 {
 #if PRINT_RESULTS
     uint32_t ii;
@@ -58,7 +58,8 @@ static inline int32_t check_results(char *instruction_name,
 
     printf("%s:   ", instruction_name);
     for (i = 0; i < test_count; i++) {
-        if (b128_result[i] == b128_expect[i]) {
+        if ((b128_result[2 * i] == b128_expect[2 * i]) &&
+            (b128_result[2 * i + 1] == b128_expect[2 * i + 1])) {
             pass_count++;
         } else {
             fail_count++;
-- 
2.7.4
