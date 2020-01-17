Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A3EC33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6ED82072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ED82072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isH9x-0002Ec-UG
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 21:14:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isH7R-0006nT-Nu
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1isH7Q-0003Gn-5a
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:17 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35004 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1isH7P-0003Dc-QC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:12:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id F42171A2012;
 Fri, 17 Jan 2020 03:12:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id BF44F1A20EE;
 Fri, 17 Jan 2020 03:12:11 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] linux-user: mips: Synchronize termbits.h with kernel
Date: Fri, 17 Jan 2020 03:11:55 +0100
Message-Id: <1579227117-6310-3-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: laurent@vivier.eu, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Synchronize all elements of mips' termbits.h with kernel and
make sure that all applicable macros and other definitions are
expressed in terms of target, not the host.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/mips/termbits.h | 140 ++++++++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 51 deletions(-)

diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 3287cf6..79a9b9b 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -3,33 +3,89 @@
 #ifndef LINUX_USER_MIPS_TERMBITS_H
 #define LINUX_USER_MIPS_TERMBITS_H
 
-#define TARGET_NCCS 23
+typedef unsigned char   target_cc_t;
+typedef unsigned int    target_speed_t;
+typedef unsigned int    target_tcflag_t;
 
+/*
+ * The ABI says nothing about NCC but seems to use NCCS as
+ * replacement for it in struct termio
+ */
+#define TARGET_NCCS 23
 struct target_termios {
-    unsigned int c_iflag;               /* input mode flags */
-    unsigned int c_oflag;               /* output mode flags */
-    unsigned int c_cflag;               /* control mode flags */
-    unsigned int c_lflag;               /* local mode flags */
-    unsigned char c_line;                    /* line discipline */
-    unsigned char c_cc[TARGET_NCCS];                /* control characters */
+    target_tcflag_t c_iflag;            /* input mode flags */
+    target_tcflag_t c_oflag;            /* output mode flags */
+    target_tcflag_t c_cflag;            /* control mode flags */
+    target_tcflag_t c_lflag;            /* local mode flags */
+    target_cc_t c_line;                 /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];      /* control characters */
+};
+
+struct target_termios2 {
+    target_tcflag_t c_iflag;            /* input mode flags */
+    target_tcflag_t c_oflag;            /* output mode flags */
+    target_tcflag_t c_cflag;            /* control mode flags */
+    target_tcflag_t c_lflag;            /* local mode flags */
+    target_cc_t c_line;                 /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];      /* control characters */
+    target_speed_t c_ispeed;            /* input speed */
+    target_speed_t c_ospeed;            /* output speed */
+};
+
+struct target_ktermios {
+    target_tcflag_t c_iflag;            /* input mode flags */
+    target_tcflag_t c_oflag;            /* output mode flags */
+    target_tcflag_t c_cflag;            /* control mode flags */
+    target_tcflag_t c_lflag;            /* local mode flags */
+    target_cc_t c_line;                 /* line discipline */
+    target_cc_t c_cc[TARGET_NCCS];      /* control characters */
+    target_speed_t c_ispeed;            /* input speed */
+    target_speed_t c_ospeed;            /* output speed */
 };
 
+/* c_cc character offsets */
+#define TARGET_VINTR    0       /* Interrupt character [ISIG].  */
+#define TARGET_VQUIT    1       /* Quit character [ISIG].  */
+#define TARGET_VERASE   2       /* Erase character [ICANON].  */
+#define TARGET_VKILL    3       /* Kill-line character [ICANON].  */
+#define TARGET_VMIN     4       /* Minimum number of bytes read at once */
+#define TARGET_VTIME    5       /* Time-out value (tenths of a second) */
+#define TARGET_VEOL2    6       /* Second EOL character [ICANON].  */
+#define TARGET_VSWTC    7       /* ??? */
+#define TARGET_VSWTCH   VSWTC
+#define TARGET_VSTART   8       /* Start (X-ON) character [IXON, IXOFF].  */
+#define TARGET_VSTOP    9       /* Stop (X-OFF) character [IXON, IXOFF].  */
+#define TARGET_VSUSP    10      /* Suspend character [ISIG].  */
+
+#if 0
+/*
+ * VDSUSP is not supported
+ */
+#define TARGET_VDSUSP      11   /* Delayed suspend character [ISIG].  */
+#endif
+#define TARGET_VREPRINT 12      /* Reprint-line character [ICANON].  */
+#define TARGET_VDISCARD 13      /* Discard character [IEXTEN].  */
+#define TARGET_VWERASE  14      /* Word-erase character [ICANON].  */
+#define TARGET_VLNEXT   15      /* Literal-next character [IEXTEN].  */
+#define TARGET_VEOF     16      /* End-of-file character [ICANON].  */
+#define TARGET_VEOL     17      /* End-of-line character [ICANON].  */
+
 /* c_iflag bits */
-#define TARGET_IGNBRK  0000001
-#define TARGET_BRKINT  0000002
-#define TARGET_IGNPAR  0000004
-#define TARGET_PARMRK  0000010
-#define TARGET_INPCK   0000020
-#define TARGET_ISTRIP  0000040
-#define TARGET_INLCR   0000100
-#define TARGET_IGNCR   0000200
-#define TARGET_ICRNL   0000400
-#define TARGET_IUCLC   0001000
-#define TARGET_IXON    0002000
-#define TARGET_IXANY   0004000
-#define TARGET_IXOFF   0010000
-#define TARGET_IMAXBEL 0020000
-#define TARGET_IUTF8   0040000
+#define TARGET_IGNBRK  0000001  /* Ignore break condition.  */
+#define TARGET_BRKINT  0000002  /* Signal interrupt on break.  */
+#define TARGET_IGNPAR  0000004  /* Ignore characters with parity errors.  */
+#define TARGET_PARMRK  0000010  /* Mark parity and framing errors.  */
+#define TARGET_INPCK   0000020  /* Enable input parity check.  */
+#define TARGET_ISTRIP  0000040  /* Strip 8th bit off characters.  */
+#define TARGET_INLCR   0000100  /* Map NL to CR on input.  */
+#define TARGET_IGNCR   0000200  /* Ignore CR.  */
+#define TARGET_ICRNL   0000400  /* Map CR to NL on input.  */
+#define TARGET_IUCLC   0001000  /* Map upper case to lower case on input.  */
+#define TARGET_IXON    0002000  /* Enable start/stop output control.  */
+#define TARGET_IXANY   0004000  /* Any character will restart after stop.  */
+#define TARGET_IXOFF   0010000  /* Enable start/stop input control.  */
+#define TARGET_IMAXBEL 0020000  /* Ring bell when input queue is full.  */
+#define TARGET_IUTF8   0040000  /* Input is UTF-8 */
 
 /* c_oflag bits */
 #define TARGET_OPOST   0000001
@@ -82,8 +138,8 @@ struct target_termios {
 #define  TARGET_B9600  0000015
 #define  TARGET_B19200 0000016
 #define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
+#define TARGET_EXTA    TARGET_B19200
+#define TARGET_EXTB    TARGET_B38400
 #define TARGET_CSIZE   0000060
 #define   TARGET_CS5   0000000
 #define   TARGET_CS6   0000020
@@ -134,26 +190,6 @@ struct target_termios {
 #define TARGET_TOSTOP  0100000
 #define TARGET_ITOSTOP TARGET_TOSTOP
 
-/* c_cc character offsets */
-#define TARGET_VINTR	0
-#define TARGET_VQUIT	1
-#define TARGET_VERASE	2
-#define TARGET_VKILL	3
-#define TARGET_VMIN	4
-#define TARGET_VTIME	5
-#define TARGET_VEOL2	6
-#define TARGET_VSWTC	7
-#define TARGET_VSTART	8
-#define TARGET_VSTOP	9
-#define TARGET_VSUSP	10
-/* VDSUSP not supported */
-#define TARGET_VREPRINT	12
-#define TARGET_VDISCARD	13
-#define TARGET_VWERASE	14
-#define TARGET_VLNEXT	15
-#define TARGET_VEOF	16
-#define TARGET_VEOL	17
-
 /* ioctls */
 
 #define TARGET_TCGETA		0x5401
@@ -186,7 +222,7 @@ struct target_termios {
 #define	 TARGET_TIOCPKT_START		0x08	/* start output */
 #define	 TARGET_TIOCPKT_NOSTOP		0x10	/* no more ^S, ^Q */
 #define	 TARGET_TIOCPKT_DOSTOP		0x20	/* now do ^S ^Q */
-/* #define  TIOCPKT_IOCTL		0x40	state change of pty driver */
+#define  TARGET_TIOCPKT_IOCTL       0x40    /* state change of pty driver */
 #define TARGET_TIOCSWINSZ	TARGET_IOW('t', 103, struct winsize)	/* set window size */
 #define TARGET_TIOCGWINSZ	TARGET_IOR('t', 104, struct winsize)	/* get window size */
 #define TARGET_TIOCNOTTY	0x5471		/* void tty association */
@@ -205,8 +241,8 @@ struct target_termios {
 #define TARGET_TIOCGPGRP	TARGET_IOR('t', 119, int)	/* get pgrp of tty */
 #define TARGET_TIOCCONS	TARGET_IOW('t', 120, int)	/* become virtual console */
 
-#define TARGET_FIONREAD	0x467f
-#define TARGET_TIOCINQ		TARGET_FIONREAD
+#define TARGET_FIONREAD        0x467f
+#define TARGET_TIOCINQ         TARGET_FIONREAD
 
 #define TARGET_TIOCGETP        0x7408
 #define TARGET_TIOCSETP        0x7409
@@ -222,10 +258,10 @@ struct target_termios {
 #define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
 #define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
 #define TARGET_TIOCGSID	0x7416  /* Return the session ID of FD */
-#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct termios2)
-#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct termios2)
-#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct termios2)
-#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct termios2)
+#define TARGET_TCGETS2          TARGET_IOR('T', 0x2A, struct target_termios2)
+#define TARGET_TCSETS2          TARGET_IOW('T', 0x2B, struct target_termios2)
+#define TARGET_TCSETSW2         TARGET_IOW('T', 0x2C, struct target_termios2)
+#define TARGET_TCSETSF2         TARGET_IOW('T', 0x2D, struct target_termios2)
 #define TARGET_TIOCGRS485       TARGET_IOR('T', 0x2E, struct serial_rs485)
 #define TARGET_TIOCSRS485       TARGET_IOWR('T', 0x2F, struct serial_rs485)
 #define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
@@ -237,6 +273,8 @@ struct target_termios {
 #define TARGET_TIOCGPTLCK       TARGET_IOR('T', 0x39, int)
 #define TARGET_TIOCGEXCL        TARGET_IOR('T', 0x40, int)
 #define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41)
+#define TARGET_TIOCGISO7816     TARGET_IOR('T', 0x42, struct serial_iso7816)
+#define TARGET_TIOCSISO7816     TARGET_IOWR('T', 0x43, struct serial_iso7816)
 
 /* I hope the range from 0x5480 on is free ... */
 #define TARGET_TIOCSCTTY	0x5480		/* become controlling tty */
-- 
2.7.4


