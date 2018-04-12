Received: from eggs.gnu.org ([2001:4830:134:3::10]:40087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f6coE-0007Au-Ru
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f6coA-00032U-3N
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 10:02:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 15:02:22 +0100
Message-Id: <20180412140222.2096-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] linux-user/signal.c: Put AArch64
 frame record in the right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

AArch64 stack frames include a 'frame record' which holds a pointer
to the next frame record in the chain and the LR on entry to the
function. The procedure calling standard doesn't mandate where
exactly this frame record is in the stack frame, but for signal
frames the kernel puts it right at the top. We used to put it
there too, but in commit 7f0f4208b3a96f22 we accidentally put
the "enlarge to the 4K reserved space minimum" check after the
"allow for the frame record" code, rather than before it, with
the effect that the frame record would be inside the reserved
space and immediately after the last used part of it.

Move the frame record back out of the reserved space to where
we used to put it.

This bug shouldn't break any sensible guest code, but test
programs that deliberately look at the internal details
of the signal frame layout will not find what they are
expecting to see.

Fixes: 7f0f4208b3a96f22
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm marking this as for-2.12 on the basis that it puts our frame
layout back to exactly what 2.11 had, and so seems safest.
No sensible guest code should really care, though, so this is
in the "only if we're doing an rc4" bucket; but I think that the
softfloat fixes deserve an rc4 anyway.

 linux-user/signal.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 8d9e6e8410..e6dfe0adfd 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1843,6 +1843,12 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         layout.total_size += sizeof(struct target_aarch64_ctx);
     }
 
+    /* We must always provide at least the standard 4K reserved space,
+     * even if we don't use all of it (this is part of the ABI)
+     */
+    layout.total_size = MAX(layout.total_size,
+                            sizeof(struct target_rt_sigframe));
+
     /* Reserve space for the return code.  On a real system this would
      * be within the VDSO.  So, despite the name this is not a "real"
      * record within the frame.
@@ -1850,12 +1856,6 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     fr_ofs = layout.total_size;
     layout.total_size += sizeof(struct target_rt_frame_record);
 
-    /* We must always provide at least the standard 4K reserved space,
-     * even if we don't use all of it (this is part of the ABI)
-     */
-    layout.total_size = MAX(layout.total_size,
-                            sizeof(struct target_rt_sigframe));
-
     frame_addr = get_sigframe(ka, env, layout.total_size);
     trace_user_setup_frame(env, frame_addr);
     if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
-- 
2.16.2
