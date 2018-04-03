Received: from eggs.gnu.org ([2001:4830:134:3::10]:36234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3JJr-0000oy-1Z
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f3JJo-00043P-2c
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:39 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f3JJn-00042H-QE
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 06:37:36 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  3 Apr 2018 12:35:38 +0200
Message-Id: <20180403103540.7303-2-laurent@vivier.eu>
In-Reply-To: <20180403103540.7303-1-laurent@vivier.eu>
References: <20180403103540.7303-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/3] linux-user: fix alpha signal emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

setup_frame() doesn't set correctly the address of the trampoline code.
The offset of retcode array must be added to the stack frame address.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20180401204653.14211-1-laurent@vivier.eu>
---
 linux-user/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ea3e0321f..9399f0ec47 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -6367,7 +6367,7 @@ static void setup_frame(int sig, struct target_sigaction *ka,
                    &frame->retcode[1]);
         __put_user(INSN_CALLSYS, &frame->retcode[2]);
         /* imb() */
-        r26 = frame_addr;
+        r26 = frame_addr + offsetof(struct target_sigframe, retcode);
     }
 
     unlock_user_struct(frame, frame_addr, 1);
@@ -6424,7 +6424,7 @@ static void setup_rt_frame(int sig, struct target_sigaction *ka,
                    &frame->retcode[1]);
         __put_user(INSN_CALLSYS, &frame->retcode[2]);
         /* imb(); */
-        r26 = frame_addr;
+        r26 = frame_addr + offsetof(struct target_sigframe, retcode);
     }
 
     if (err) {
-- 
2.14.3
