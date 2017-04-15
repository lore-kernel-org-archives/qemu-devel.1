Received: from eggs.gnu.org ([2001:4830:134:3::10]:59528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1czTOP-0002vg-EU
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 15:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1czTOL-0003lc-Fs
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 15:29:57 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1czTOL-0003l6-C9
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 15:29:53 -0400
Received: by mail-yw0-x242.google.com with SMTP id l189so7780727ywb.0
	for <qemu-devel@nongnu.org>; Sat, 15 Apr 2017 12:29:53 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Sat, 15 Apr 2017 15:29:30 -0400
Message-Id: <20170415192930.1443-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] timer.h: Provide monotonic time for ARM guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Tested and confirmed that the stretch i386 debian qcow2 image on a
raspberry pi 2 works.

Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/qemu/timer.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index e1742f2f3d..14c9558da4 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -1015,6 +1015,16 @@ static inline int64_t cpu_get_host_ticks(void)
     return cur - ofs;
 }
 
+#elif defined(__arm__) || defined(__aarch64__)
+
+/* ARM does not have a user-space readble cycle counter available.
+ * This is a compromise to get monotonically increasing time.
+ */
+static inline int64_t cpu_get_host_ticks(void)
+{
+    return get_clock();
+}
+
 #else
 /* The host CPU doesn't have an easily accessible cycle counter.
    Just return a monotonically increasing value.  This will be
-- 
2.11.0
