Received: from eggs.gnu.org ([2001:4830:134:3::10]:55868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWV-00077U-SV
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWV-00063o-7g
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:31 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWV-00063O-2d
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:31 -0500
Received: by mail-pf0-x244.google.com with SMTP id i88so14544300pfk.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:30 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.29 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:29 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:34 -0800
Message-Id: <20161224040042.12654-58-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 57/65] target-s390x: Avoid a loop for popcnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
