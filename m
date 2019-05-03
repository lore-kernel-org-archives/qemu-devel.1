Received: from eggs.gnu.org ([209.51.188.92]:60746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfY-0001Ta-IW
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1hMbfX-0003Ds-EC
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:20 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46172 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1hMbfX-0001h5-7C
	for qemu-devel@nongnu.org; Fri, 03 May 2019 13:08:19 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri,  3 May 2019 19:06:47 +0200
Message-Id: <1556903209-6036-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1556903209-6036-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 3/5] linux-user: Add support the
 SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, nchen@wavecomp.com, daniel.santos@pobox.com, jcmvbkbc@gmail.com, lvivier@redhat.com, thuth@redhat.com, philmd@redhat.com

From: Neng Chen <nchen@wavecomp.com>

Add support for setting and getting extended (private) flags of a
network device via SIOCSIFPFLAGS and SIOCGIFPFLAGS ioctls.

The ioctl numeric value is platform-independent and determined by
the file include/uapi/linux/sockios.h in Linux kernel source code:

  #define SIOCSIFPFLAGS 0x8934

The ioctls set and get field ifr_flags of type short in the structure
ifreq. Such functionality in QEMU is achieved using MK_STRUCT() and
MK_PTR() macros with an appropriate argument.

Signed-off-by: Neng Chen <nchen@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-Id: <1554839486-3527-1-git-send-email-aleksandar.markovic@rt-rk.com>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index c37adc5..76375df 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -206,6 +206,8 @@
   IOCTL(SIOCADDMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
   IOCTL(SIOCDELMULTI, IOC_W, MK_PTR(MK_STRUCT(STRUCT_sockaddr_ifreq)))
   IOCTL(SIOCGIFINDEX, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_int_ifreq)))
+  IOCTL(SIOCSIFPFLAGS, IOC_W, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
+  IOCTL(SIOCGIFPFLAGS, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_short_ifreq)))
   IOCTL(SIOCSIFLINK, 0, TYPE_NULL)
   IOCTL_SPECIAL(SIOCGIFCONF, IOC_W | IOC_R, do_ioctl_ifconf,
                 MK_PTR(MK_STRUCT(STRUCT_ifconf)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 2941231..8904d35 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -781,6 +781,8 @@ struct target_pollfd {
 #define TARGET_SIOCADDMULTI    0x8931          /* Multicast address lists      */
 #define TARGET_SIOCDELMULTI    0x8932
 #define TARGET_SIOCGIFINDEX    0x8933
+#define TARGET_SIOCSIFPFLAGS   0x8934          /* set extended flags          */
+#define TARGET_SIOCGIFPFLAGS   0x8935          /* get extended flags          */
 
 /* Bridging control calls */
 #define TARGET_SIOCGIFBR       0x8940          /* Bridging support             */
-- 
2.7.4
