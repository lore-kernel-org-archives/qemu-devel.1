Received: from eggs.gnu.org ([2001:4830:134:3::10]:55060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eehQQ-0003eL-PF
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:18:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eehQK-0008NS-IP
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:18:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:57611)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1eehQK-0008M1-86
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:18:36 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 22FD9AD9F
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 13:18:33 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
References: <mvm7es7sds9.fsf@suse.de>
Date: Thu, 25 Jan 2018 14:18:32 +0100
In-Reply-To: <mvm7es7sds9.fsf@suse.de> (Andreas Schwab's message of "Wed, 24
	Jan 2018 12:21:26 +0100")
Message-ID: <mvm8tcmqdp3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] linux-user: Implement ioctl cmd TIOCGPTPEER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

With glibc 2.27 the openpty function will prefer the TIOCGPTPEER ioctl.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
v2: handle host with old kernel headers
---
 linux-user/aarch64/termbits.h    | 2 ++
 linux-user/alpha/termbits.h      | 1 +
 linux-user/arm/termbits.h        | 1 +
 linux-user/cris/termbits.h       | 1 +
 linux-user/hppa/termbits.h       | 2 ++
 linux-user/i386/termbits.h       | 1 +
 linux-user/ioctls.h              | 3 +++
 linux-user/m68k/termbits.h       | 1 +
 linux-user/microblaze/termbits.h | 1 +
 linux-user/mips/termbits.h       | 1 +
 linux-user/nios2/termbits.h      | 2 ++
 linux-user/openrisc/termbits.h   | 2 ++
 linux-user/ppc/termbits.h        | 1 +
 linux-user/s390x/termbits.h      | 1 +
 linux-user/sh4/termbits.h        | 1 +
 linux-user/sparc/termbits.h      | 1 +
 linux-user/sparc64/termbits.h    | 1 +
 linux-user/syscall.c             | 9 +++++++++
 linux-user/tilegx/termbits.h     | 1 +
 linux-user/x86_64/termbits.h     | 1 +
 20 files changed, 34 insertions(+)

diff --git a/linux-user/aarch64/termbits.h b/linux-user/aarch64/termbits.h
index b64ba974cf..f9f80f0f37 100644
--- a/linux-user/aarch64/termbits.h
+++ b/linux-user/aarch64/termbits.h
@@ -187,6 +187,8 @@ struct target_termios {
         /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
         /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
+        /* Safely open the slave */
 
 #define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX          0x5451
diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index 6406b6a799..139bc87fa6 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -245,6 +245,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_TIOCSERCONFIG	0x5453
 #define TARGET_TIOCSERGWILD	0x5454
diff --git a/linux-user/arm/termbits.h b/linux-user/arm/termbits.h
index 7772df175c..a61e138ec4 100644
--- a/linux-user/arm/termbits.h
+++ b/linux-user/arm/termbits.h
@@ -185,6 +185,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
index fc82ca084e..c825cd2f5e 100644
--- a/linux-user/cris/termbits.h
+++ b/linux-user/cris/termbits.h
@@ -182,6 +182,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index e9633ef119..ad51c9c911 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -186,6 +186,8 @@ struct target_termios {
         /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
         /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
+        /* Safely open the slave */
 
 #define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX          0x5451
diff --git a/linux-user/i386/termbits.h b/linux-user/i386/termbits.h
index e051a3af74..32dd0dde5d 100644
--- a/linux-user/i386/termbits.h
+++ b/linux-user/i386/termbits.h
@@ -195,6 +195,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 35cad6f944..586c794639 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -40,6 +40,9 @@
      IOCTL(TIOCSETD, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(TIOCGPTN, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(TIOCSPTLCK, IOC_W, MK_PTR(TYPE_INT))
+#ifdef TIOCGPTPEER
+     IOCTL_SPECIAL(TIOCGPTPEER, 0, do_ioctl_tiocgptpeer, TYPE_INT)
+#endif
      IOCTL(FIOCLEX, 0, TYPE_NULL)
      IOCTL(FIONCLEX, 0, TYPE_NULL)
      IOCTL(FIOASYNC, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/m68k/termbits.h b/linux-user/m68k/termbits.h
index f7982fb6c2..9df58dc5cb 100644
--- a/linux-user/m68k/termbits.h
+++ b/linux-user/m68k/termbits.h
@@ -196,6 +196,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/microblaze/termbits.h b/linux-user/microblaze/termbits.h
index fc82ca084e..c825cd2f5e 100644
--- a/linux-user/microblaze/termbits.h
+++ b/linux-user/microblaze/termbits.h
@@ -182,6 +182,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index a0bcad0946..49a72c5539 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -233,6 +233,7 @@ struct target_termios {
 #define TARGET_TIOCGPKT         TARGET_IOR('T', 0x38, int)
 #define TARGET_TIOCGPTLCK       TARGET_IOR('T', 0x39, int)
 #define TARGET_TIOCGEXCL        TARGET_IOR('T', 0x40, int)
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
 
 /* I hope the range from 0x5480 on is free ... */
 #define TARGET_TIOCSCTTY	0x5480		/* become controlling tty */
diff --git a/linux-user/nios2/termbits.h b/linux-user/nios2/termbits.h
index b64ba974cf..f9f80f0f37 100644
--- a/linux-user/nios2/termbits.h
+++ b/linux-user/nios2/termbits.h
@@ -187,6 +187,8 @@ struct target_termios {
         /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK       TARGET_IOW('T', 0x31, int)
         /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
+        /* Safely open the slave */
 
 #define TARGET_FIONCLEX         0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX          0x5451
diff --git a/linux-user/openrisc/termbits.h b/linux-user/openrisc/termbits.h
index 373af77215..231a49806b 100644
--- a/linux-user/openrisc/termbits.h
+++ b/linux-user/openrisc/termbits.h
@@ -245,6 +245,8 @@ struct target_termios3 {
 #define TARGET_TIOCGPTN        TARGET_IOR('T', 0x30, unsigned int)
 /* Lock/unlock Pty */
 #define TARGET_TIOCSPTLCK      TARGET_IOW('T', 0x31, int)
+/* Safely open the slave */
+#define TARGET_TIOCGPTPEER     TARGET_IO('T', 0x41)
 /* Get primary device node of /dev/console */
 #define TARGET_TIOCGDEV        TARGET_IOR('T', 0x32, unsigned int)
 #define TARGET_TCGETX          0x5432 /* SYS5 TCGETX compatibility */
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index 73e7151756..a5b1bb783b 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -219,6 +219,7 @@ struct target_termios {
 #define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_TIOCSERCONFIG	0x5453
 #define TARGET_TIOCSERGWILD	0x5454
diff --git a/linux-user/s390x/termbits.h b/linux-user/s390x/termbits.h
index 2a78a05594..8bcca89cd7 100644
--- a/linux-user/s390x/termbits.h
+++ b/linux-user/s390x/termbits.h
@@ -252,6 +252,7 @@ struct target_ktermios {
 #define TARGET_TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 #define TARGET_TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index 2ff774f6ba..5723ed7752 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -250,6 +250,7 @@ ID of FD */
 #define TARGET_TIOCGPTN        TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-m
 ux device) */
 #define TARGET_TIOCSPTLCK      TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER     TARGET_IO('T', 0x41) /* Safely open the slave */
 
 
 #define TARGET_TIOCSERCONFIG   TARGET_IO('T', 83) /* 0x5453 */
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 691600d27a..98268936dc 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -245,6 +245,7 @@ struct target_termios {
 /* Get minor device of a pty master's FD -- Solaris equiv is ISPTM */
 #define TARGET_TIOCGPTN	TARGET_IOR('t', 134, unsigned int) /* Get Pty Number */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('t', 135, int) /* Lock/unlock PTY */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 137) /* Safely open the slave */
 
 /* Little f */
 #define TARGET_FIOCLEX		TARGET_IO('f', 1)
diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.h
index 691600d27a..98268936dc 100644
--- a/linux-user/sparc64/termbits.h
+++ b/linux-user/sparc64/termbits.h
@@ -245,6 +245,7 @@ struct target_termios {
 /* Get minor device of a pty master's FD -- Solaris equiv is ISPTM */
 #define TARGET_TIOCGPTN	TARGET_IOR('t', 134, unsigned int) /* Get Pty Number */
 #define TARGET_TIOCSPTLCK	TARGET_IOW('t', 135, int) /* Lock/unlock PTY */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 137) /* Safely open the slave */
 
 /* Little f */
 #define TARGET_FIOCLEX		TARGET_IO('f', 1)
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 11c9116c4a..e0070e31c0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5607,6 +5607,15 @@ static abi_long do_ioctl_kdsigaccept(const IOCTLEntry *ie, uint8_t *buf_temp,
     return get_errno(safe_ioctl(fd, ie->host_cmd, sig));
 }
 
+#ifdef TIOCGPTPEER
+static abi_long do_ioctl_tiocgptpeer(const IOCTLEntry *ie, uint8_t *buf_temp,
+                                     int fd, int cmd, abi_long arg)
+{
+    int flags = target_to_host_bitmask(arg, fcntl_flags_tbl);
+    return get_errno(safe_ioctl(fd, ie->host_cmd, flags));
+}
+#endif
+
 static IOCTLEntry ioctl_entries[] = {
 #define IOCTL(cmd, access, ...) \
     { TARGET_ ## cmd, cmd, #cmd, access, 0, {  __VA_ARGS__ } },
diff --git a/linux-user/tilegx/termbits.h b/linux-user/tilegx/termbits.h
index 91ec23654e..966daec088 100644
--- a/linux-user/tilegx/termbits.h
+++ b/linux-user/tilegx/termbits.h
@@ -242,6 +242,7 @@ struct target_termios2 {
 #define TARGET_TIOCGPKT                 TARGET_IOR('T', 0x38, int)
 #define TARGET_TIOCGPTLCK               TARGET_IOR('T', 0x39, int)
 #define TARGET_TIOCGEXCL                TARGET_IOR('T', 0x40, int)
+#define TARGET_TIOCGPTPEER              TARGET_IO('T', 0x41)
 
 #define TARGET_FIONCLEX                 0x5450
 #define TARGET_FIOCLEX                  0x5451
diff --git a/linux-user/x86_64/termbits.h b/linux-user/x86_64/termbits.h
index 387e742592..f5776a8aa6 100644
--- a/linux-user/x86_64/termbits.h
+++ b/linux-user/x86_64/termbits.h
@@ -215,6 +215,7 @@ struct target_termios {
 #define TARGET_TCSETSF2         TARGET_IOW('T',0x2D, struct termios2)
 #define TARGET_TIOCGPTN         TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TARGET_TIOCSPTLCK       TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
+#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
 
 #define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
 #define TARGET_FIOCLEX		0x5451
-- 
2.16.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
