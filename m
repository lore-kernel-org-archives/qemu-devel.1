Received: from eggs.gnu.org ([209.51.188.92]:47785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hJHUo-0002aW-TR
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hJHUJ-0000Ua-1B
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:59:24 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54666 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hJHUI-0007X2-R1
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 08:58:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 24 Apr 2019 14:56:59 +0200
Message-Id: <1556110623-655-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 1/5] linux-user: Fix support for the
 SIOCATMARK and SIOCGPGRP ioctls for eXtensa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, daniel.santos@pobox.com, jcmvbkbc@gmail.com, lvivier@redhat.com, thuth@redhat.com, philmd@redhat.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fix support for the SIOCATMARK and SIOCGPGRP ioctls for eXtensa by
correcting corresponding macro definition.

Values for TARGET_SIOCATMARK and TARGET_SIOCGPGRP are determined by
Linux kernel. Following relevant lines are from kernel source tree:

arch/ia64/include/uapi/asm/sockios.h:#define SIOCATMARK    0x8905
arch/mips/include/uapi/asm/sockios.h:#define SIOCATMARK    _IOR('s', 7, int)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCATMARK  0x8905
arch/sh/include/uapi/asm/sockios.h:#define SIOCATMARK      _IOR('s', 7, int)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCATMARK  _IOR('s', 7, int)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCATMARK   _IOR('s', 7, int)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCATMARK   0x8905
include/uapi/asm-generic/sockios.h:#define SIOCATMARK	   0x8905

arch/ia64/include/uapi/asm/sockios.h:#define SIOCGPGRP     0x8904
arch/mips/include/uapi/asm/sockios.h:#define SIOCGPGRP     _IOR('s', 9, pid_t)
arch/parisc/include/uapi/asm/sockios.h:#define SIOCGPGRP   0x8904
arch/sh/include/uapi/asm/sockios.h:#define SIOCGPGRP       _IOR('s', 9, pid_t)
arch/xtensa/include/uapi/asm/sockios.h:#define SIOCGPGRP   _IOR('s', 9, pid_t)
arch/alpha/include/uapi/asm/sockios.h:#define SIOCGPGRP    _IOR('s', 9, pid_t)
arch/sparc/include/uapi/asm/sockios.h:#define SIOCGPGRP    0x8904
include/uapi/asm-generic/sockios.h:#define SIOCGPGRP       0x8904

It is visible that eXtensa should have the same definitions as
alpha, mips and sh4 already do. This patch brings that to the
accurate state.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/syscall_defs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 12c8407..1e86fb9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -736,7 +736,8 @@ struct target_pollfd {
 #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
 #define TARGET_KDSIGACCEPT     0x4B4E
 
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
+       defined(TARGET_XTENSA)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
 #define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
-- 
2.7.4
