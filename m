Received: from eggs.gnu.org ([2001:4830:134:3::10]:35769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VL-0006iv-Ap
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8VK-0003bJ-GM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:11 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8VK-0003au-Ai
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:19:10 -0500
Received: by mail-pf0-x244.google.com with SMTP id y143so10362957pfb.1
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:19:10 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:18:12 -0800
Message-Id: <20170111021820.24416-58-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 57/65] target-s390x: Avoid a loop for popcnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/int_helper.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index 5bc470b..f26f36a 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -137,14 +137,11 @@ uint64_t HELPER(cvd)(int32_t reg)
     return dec;
 }
 
-uint64_t HELPER(popcnt)(uint64_t r2)
+uint64_t HELPER(popcnt)(uint64_t val)
 {
-    uint64_t ret = 0;
-    int i;
-
-    for (i = 0; i < 64; i += 8) {
-        uint64_t t = ctpop32((r2 >> i) & 0xff);
-        ret |= t << i;
-    }
-    return ret;
+    /* Note that we don't fold past bytes. */
+    val = (val & 0x5555555555555555ULL) + ((val >> 1) & 0x5555555555555555ULL);
+    val = (val & 0x3333333333333333ULL) + ((val >> 2) & 0x3333333333333333ULL);
+    val = (val + (val >> 4)) & 0x0f0f0f0f0f0f0f0fULL;
+    return val;
 }
-- 
2.9.3
