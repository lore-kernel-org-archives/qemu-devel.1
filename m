Received: from eggs.gnu.org ([2001:4830:134:3::10]:56879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDQ-0007uU-Ke
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDP-0000iS-B5
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40760)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDP-0000er-2d
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDN-0007dW-U3
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:22 +0100
Message-Id: <20180410121724.8549-11-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/12] linux-user/signal.c: Ensure AArch64
 signal frame isn't too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The AArch64 signal frame design was extended for SVE in commit
8c5931de0ac77388096d79ceb, so that instead of having a fixed setup we
now add various records to the frame, with some of them possibly
overflowing into an extra space outside the original 4K reserved
block in the target_sigcontext.  However, we failed to ensure that we
always at least allocate the 4K reserved block.  This is ABI, and
some userspace programs rely on it.  In particular the dash shell
would segfault if the frame wasn't as big enough.

(Compare the kernel's sigframe_size() function in
arch/arm64/kernel/signal.c.)

Reported-by: Richard Henwood <richard.henwood@arm.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180409140714.26841-1-peter.maydell@linaro.org
Fixes: https://bugs.launchpad.net/bugs/1761535
Fixes: 8c5931de0ac77388096d79ceb
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 046d4c8aa0..8d9e6e8410 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1850,6 +1850,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     fr_ofs = layout.total_size;
     layout.total_size += sizeof(struct target_rt_frame_record);
 
+    /* We must always provide at least the standard 4K reserved space,
+     * even if we don't use all of it (this is part of the ABI)
+     */
+    layout.total_size = MAX(layout.total_size,
+                            sizeof(struct target_rt_sigframe));
+
     frame_addr = get_sigframe(ka, env, layout.total_size);
     trace_user_setup_frame(env, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-- 
2.16.2
