Received: from eggs.gnu.org ([209.51.188.92]:48452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWoo-0002c4-P4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWon-0007mW-SY
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:06 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWon-0007lf-Lo
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:05 -0400
Received: by mail-pl1-x644.google.com with SMTP id w23so4370461ply.4
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:05 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:33 +0700
Message-Id: <20190403034358.21999-2-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 01/26] tcg: Assert h2g_valid for 32-bit guest
 on 64-bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For this combination, we can tell whether or not the address
being accessed is within the 4GB range that is accessible by
the guest.  Otherwise the fault must be elsewhere in qemu,
accessing qemu data structures.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/user-exec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 0789984fe6..fa9380a380 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -143,6 +143,15 @@ static inline int handle_cpu_signal(uintptr_t pc, siginfo_t *info,
         }
     }
 
+    /*
+     * For a 32-bit guest on a 64-bit host, the set of addresses that we
+     * access on behalf of the guest is constrained.  Anything outside
+     * that range is a bug elsewhere in QEMU.
+     */
+#if TARGET_LONG_BITS == 32 && HOST_LONG_BITS == 64
+    g_assert(h2g_valid(address));
+#endif
+
     /* Convert forcefully to guest address space, invalid addresses
        are still valid segv ones */
     address = h2g_nocheck(address);
-- 
2.17.1
