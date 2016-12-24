Received: from eggs.gnu.org ([2001:4830:134:3::10]:55954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWY-00079V-Oq
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cKdWY-00066p-25
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:34 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cKdWX-00066U-Tl
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 23:01:34 -0500
Received: by mail-pg0-x244.google.com with SMTP id i5so2481104pgh.2
	for <qemu-devel@nongnu.org>; Fri, 23 Dec 2016 20:01:33 -0800 (PST)
Received: from bigtime.domain ([2602:47:d954:1500:5e51:4fff:fe40:9c64])
	by smtp.gmail.com with ESMTPSA id
	n25sm65339316pfi.33.2016.12.23.20.01.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 23 Dec 2016 20:01:32 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Dec 2016 20:00:38 -0800
Message-Id: <20161224040042.12654-62-rth@twiddle.net>
In-Reply-To: <20161224040042.12654-1-rth@twiddle.net>
References: <20161224040042.12654-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 61/65] qemu/host-utils.h: Reduce the operation
 count in the fallback ctpop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/qemu/host-utils.h | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 46187bb..96288d0 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -327,7 +327,7 @@ static inline int ctpop8(uint8_t val)
 #else
     val = (val & 0x55) + ((val >> 1) & 0x55);
     val = (val & 0x33) + ((val >> 2) & 0x33);
-    val = (val & 0x0f) + ((val >> 4) & 0x0f);
+    val = (val + (val >> 4)) & 0x0f;
 
     return val;
 #endif
@@ -344,8 +344,8 @@ static inline int ctpop16(uint16_t val)
 #else
     val = (val & 0x5555) + ((val >> 1) & 0x5555);
     val = (val & 0x3333) + ((val >> 2) & 0x3333);
-    val = (val & 0x0f0f) + ((val >> 4) & 0x0f0f);
-    val = (val & 0x00ff) + ((val >> 8) & 0x00ff);
+    val = (val + (val >> 4)) & 0x0f0f;
+    val = (val + (val >> 8)) & 0x00ff;
 
     return val;
 #endif
@@ -360,11 +360,10 @@ static inline int ctpop32(uint32_t val)
 #if QEMU_GNUC_PREREQ(3, 4)
     return __builtin_popcount(val);
 #else
-    val = (val & 0x55555555) + ((val >>  1) & 0x55555555);
-    val = (val & 0x33333333) + ((val >>  2) & 0x33333333);
-    val = (val & 0x0f0f0f0f) + ((val >>  4) & 0x0f0f0f0f);
-    val = (val & 0x00ff00ff) + ((val >>  8) & 0x00ff00ff);
-    val = (val & 0x0000ffff) + ((val >> 16) & 0x0000ffff);
+    val = (val & 0x55555555) + ((val >> 1) & 0x55555555);
+    val = (val & 0x33333333) + ((val >> 2) & 0x33333333);
+    val = (val + (val >> 4)) & 0x0f0f0f0f;
+    val = (val * 0x01010101) >> 24;
 
     return val;
 #endif
@@ -379,12 +378,10 @@ static inline int ctpop64(uint64_t val)
 #if QEMU_GNUC_PREREQ(3, 4)
     return __builtin_popcountll(val);
 #else
-    val = (val & 0x5555555555555555ULL) + ((val >>  1) & 0x5555555555555555ULL);
-    val = (val & 0x3333333333333333ULL) + ((val >>  2) & 0x3333333333333333ULL);
-    val = (val & 0x0f0f0f0f0f0f0f0fULL) + ((val >>  4) & 0x0f0f0f0f0f0f0f0fULL);
-    val = (val & 0x00ff00ff00ff00ffULL) + ((val >>  8) & 0x00ff00ff00ff00ffULL);
-    val = (val & 0x0000ffff0000ffffULL) + ((val >> 16) & 0x0000ffff0000ffffULL);
-    val = (val & 0x00000000ffffffffULL) + ((val >> 32) & 0x00000000ffffffffULL);
+    val = (val & 0x5555555555555555ULL) + ((val >> 1) & 0x5555555555555555ULL);
+    val = (val & 0x3333333333333333ULL) + ((val >> 2) & 0x3333333333333333ULL);
+    val = (val + (val >> 4)) & 0x0f0f0f0f0f0f0f0fULL;
+    val = (val * 0x0101010101010101ULL) >> 56;
 
     return val;
 #endif
-- 
2.9.3
