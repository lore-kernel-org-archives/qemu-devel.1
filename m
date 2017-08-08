Received: from eggs.gnu.org ([2001:4830:134:3::10]:57929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df4b3-0003DB-RE
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df4ay-0004cP-MH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:30:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:44717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1df4ay-0004aR-FK
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:30:52 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1df4ax-0008IJ-Ej
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 13:30:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 67C492E80C9
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 13:30:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 13:21:47 -0000
From: Riku Voipio <riku.voipio@linaro.org>
Reply-To: Bug 1709170 <1709170@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150213708469.19430.16716526584783151905.malonedeb@chaenomeles.canonical.com>
Message-Id: <20170808132147.GA29384@kos.to>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1709170] [PATCH] linux-user: fix O_TMPFILE
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since O_TMPFILE might differ between guest and host,
add it to the bitmask_transtbl. While at it, fix the definitions
of O_DIRECTORY etc on arm64, which are identical to arm32 according
to kernel sources.

This fixes open14 and openat03 ltp testcases.

Fixes: https://bugs.launchpad.net/qemu/+bug/1709170

---
 linux-user/strace.c       | 4 ++++
 linux-user/syscall.c      | 3 +++
 linux-user/syscall_defs.h | 8 +++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index d821d165ff..bd897a3f20 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -838,6 +838,10 @@ UNUSED static struct flags open_flags[] =3D {
 #ifdef O_PATH
     FLAG_TARGET(O_PATH),
 #endif
+#ifdef O_TMPFILE
+    FLAG_TARGET(O_TMPFILE),
+    FLAG_TARGET(__O_TMPFILE),
+#endif
     FLAG_END,
 };
 =

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 54343c06be..b3aa8099b4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -342,6 +342,9 @@ static bitmask_transtbl fcntl_flags_tbl[] =3D {
 #if defined(O_PATH)
   { TARGET_O_PATH,      TARGET_O_PATH,      O_PATH,      O_PATH       },
 #endif
+#if defined(O_TMPFILE)
+  { TARGET_O_TMPFILE,   TARGET_O_TMPFILE,   O_TMPFILE,   O_TMPFILE    },
+#endif
   /* Don't terminate the list prematurely on 64-bit host+guest.  */
 #if TARGET_O_LARGEFILE !=3D 0 || O_LARGEFILE !=3D 0
   { TARGET_O_LARGEFILE, TARGET_O_LARGEFILE, O_LARGEFILE, O_LARGEFILE, },
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 40c5027e93..6e2287e918 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2416,7 +2416,7 @@ struct target_statfs64 {
 #define TARGET_O_CLOEXEC     010000000
 #define TARGET___O_SYNC      000100000
 #define TARGET_O_PATH        020000000
-#elif defined(TARGET_ARM) || defined(TARGET_M68K)
+#elif defined(TARGET_ARM) || defined(TARGET_M68K) || defined(TARGET_AARCH6=
4)
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
@@ -2513,6 +2513,12 @@ struct target_statfs64 {
 #ifndef TARGET_O_PATH
 #define TARGET_O_PATH        010000000
 #endif
+#ifndef TARGET___O_TMPFILE
+#define TARGET___O_TMPFILE   020000000
+#endif
+#ifndef TARGET_O_TMPFILE
+#define TARGET_O_TMPFILE     (TARGET___O_TMPFILE | TARGET_O_DIRECTORY)
+#endif
 #ifndef TARGET_O_NDELAY
 #define TARGET_O_NDELAY  TARGET_O_NONBLOCK
 #endif
-- =

2.11.0

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1709170

Title:
  QEMU fails to honor O_TMPFILE

Status in QEMU:
  New

Bug description:
  When making a call like

    open("/tmp", O_TMPFILE | O_RDWR);

  under QEMU, we ged -EISDIR.

  Under any kernel 3.11 or later, we are supposed to get an unnamed file
  in /tmp. In case the filesystem for /tmp does not support unnamed
  files, we are supposed to get EOPNOTSUPP.

  [I don't know the QEMU version, since this happened in a system I
  don't have access to]

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1709170/+subscriptions
