Received: from eggs.gnu.org ([2001:4830:134:3::10]:37392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxM-0001Ga-Jo
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cHxxL-0000L1-JH
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:12 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35875)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cHxxL-0000KG-DL
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 14:14:11 -0500
Received: by mail-pg0-x244.google.com with SMTP id a1so3497747pgf.3
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:14:11 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 16 Dec 2016 11:13:43 -0800
Message-Id: <20161216191405.9473-5-rth@twiddle.net>
In-Reply-To: <20161216191405.9473-1-rth@twiddle.net>
References: <20161216191405.9473-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 04/26] linux-user: Add SIOCGPGRP, SIOCGSTAMP,
 SIOCGSTAMPNS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>

From: Helge Deller <deller@gmx.de>

Mirror syscall_defs.h for the element type of struct timeval
and struct timespec, even though that's not 100% accurate for
each guest.

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Helge Deller <deller@gmx.de>
[rth: Changed the MK_ARRAY types as per above; added ioctl.h entries.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 4 ++++
 linux-user/syscall_types.h | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index eaf6fe6..2f6e85b 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -164,6 +164,9 @@
   IOCTL(SIOCSRARP, IOC_W, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
   IOCTL(SIOCGRARP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_arpreq)))
   IOCTL(SIOCGIWNAME, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_char_ifreq)))
+  IOCTL(SIOCGPGRP, IOC_R, MK_PTR(TYPE_INT)) /* pid_t */
+  IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
+  IOCTL(SIOCGSTAMPNS, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timespec)))
 
   IOCTL(CDROMPAUSE, 0, TYPE_NULL)
   IOCTL(CDROMSTART, 0, TYPE_NULL)
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 7607df8..55ae367 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -930,9 +930,13 @@ struct target_pollfd {
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4)
 #define TARGET_SIOCATMARK      TARGET_IOR('s', 7, int)
+#define TARGET_SIOCGPGRP       TARGET_IOR('s', 9, pid_t)
 #else
 #define TARGET_SIOCATMARK      0x8905
+#define TARGET_SIOCGPGRP       0x8904
 #endif
+#define TARGET_SIOCGSTAMP      0x8906          /* Get stamp (timeval) */
+#define TARGET_SIOCGSTAMPNS    0x8907          /* Get stamp (timespec) */
 
 /* Networking ioctls */
 #define TARGET_SIOCADDRT       0x890B          /* add routing table entry */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index af79fbf..2b8c0c6 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -14,6 +14,12 @@ STRUCT(serial_icounter_struct,
 STRUCT(sockaddr,
        TYPE_SHORT, MK_ARRAY(TYPE_CHAR, 14))
 
+STRUCT(timeval,
+       MK_ARRAY(TYPE_LONG, 2))
+
+STRUCT(timespec,
+       MK_ARRAY(TYPE_LONG, 2))
+
 STRUCT(rtentry,
        TYPE_ULONG, MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr), MK_STRUCT(STRUCT_sockaddr),
        TYPE_SHORT, TYPE_SHORT, TYPE_ULONG, TYPE_PTRVOID, TYPE_SHORT, TYPE_PTRVOID,
-- 
2.9.3
