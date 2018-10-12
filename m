Received: from eggs.gnu.org ([2001:4830:134:3::10]:54576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0WK-0008Vk-P4
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:42:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0WD-0003XV-Q1
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:42:34 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46438 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0WD-0003Vx-0X
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:42:29 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:15 +0200
Message-Id: <1539362376-12010-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 07/28] linux-user: Add the field for kernel
 thread info flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add the field for kernel thread info flags.

This is essentially copied form kernel header
mips/include/asm/thread_info.h.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/qemu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index e5e7bcd..57f3004 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -23,6 +23,13 @@
  */
 #define SIGSET_T_SIZE (_NSIG / 8)
 
+#if defined TARGET_MIPS
+#define TIF_32BIT_FPREGS    27  /* 32-bit floating point registers  */
+#define TIF_HYBRID_FPREGS   28  /* 64b FP registers, odd singles    */
+                                /* in bits 63:32 of even doubles    */
+#define TIF_MSA_CTX_LIVE    30  /* MSA context must be preserved    */
+#endif /* TARGET_MIPS */
+
 /* This struct is used to hold certain information about the image.
  * Basically, it replicates in user space what would be certain
  * task_struct fields in the kernel
@@ -69,6 +76,11 @@ struct image_info {
         uint32_t        overall_fp_mode;
 #endif /* TARGET_MIPS */
 
+        /* The fields that correspond to kernel thread info flags. */
+#if defined TARGET_MIPS
+        abi_ulong       thread_info_flags;
+#endif /* TARGET_MIPS */
+
         struct image_info *other_info;
 };
 
-- 
2.7.4
