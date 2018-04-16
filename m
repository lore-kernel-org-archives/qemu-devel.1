Received: from eggs.gnu.org ([2001:4830:134:3::10]:58392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f85uw-0004rY-7l
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:19:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f85uv-0008Cj-AF
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:19:42 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 16:19:23 +0100
Message-Id: <20180416151923.22588-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [prefix=PATCH for-2.12?] linux-user: check that all of
 AArch64 SVE extended sigframe is writable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>

In commit 8c5931de0ac7738809 we added support for SVE extended
sigframe records.  These mean that the signal frame might now be
larger than the size of the target_rt_sigframe record, so make sure
we call lock_user on the entire frame size when we're creating it.
(The code for restoring the signal frame already correctly handles
the extended records by locking the 'extra' section separately to the
main section.)

In particular, this fixes a bug even for non-SVE signal frames,
because it extends the locked section to cover the
target_rt_frame_record. Previously this was part of 'struct
target_rt_sigframe', but in commit e1eecd1d9d4c1ade3 we pulled
it out into its own struct, and so locking the target_rt_sigframe
alone doesn't cover it. This bug would mean that we would fail
to correctly handle the case where a signal was taken with
SP pointing 16 bytes into an unwritable page, with the page
immediately below it in memory being writable.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The requirements to trigger the bug sound implausible, except
that the stack page might be unwritable because we just
executed some trampoline code from it, so perhaps not so
unlikely as it first seems? Not sure whether to put into 2.12
or not...
---
 linux-user/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index e6dfe0adfd..b283270391 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1858,7 +1858,8 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
 
     frame_addr = get_sigframe(ka, env, layout.total_size);
     trace_user_setup_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0)) {
+    frame = lock_user(VERIFY_WRITE, frame_addr, layout.total_size, 0);
+    if (!frame) {
         goto give_sigsegv;
     }
 
@@ -1904,11 +1905,11 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
         env->xregs[2] = frame_addr + offsetof(struct target_rt_sigframe, uc);
     }
 
-    unlock_user_struct(frame, frame_addr, 1);
+    unlock_user(frame, frame_addr, layout.total_size);
     return;
 
  give_sigsegv:
-    unlock_user_struct(frame, frame_addr, 1);
+    unlock_user(frame, frame_addr, layout.total_size);
     force_sigsegv(usig);
 }
 
-- 
2.17.0
