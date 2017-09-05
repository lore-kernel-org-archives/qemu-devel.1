Received: from eggs.gnu.org ([2001:4830:134:3::10]:34555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpGHK-0006Kf-SW
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dpGHD-0000KQ-8c
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59703
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dpGHD-0000JV-3V
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:00:35 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v85Fwo23017495
	for <qemu-devel@nongnu.org>; Tue, 5 Sep 2017 12:00:34 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2csweq59vg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 12:00:34 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 5 Sep 2017 17:00:32 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue,  5 Sep 2017 18:00:26 +0200
In-Reply-To: <20170905160027.15081-1-groug@kaod.org>
References: <20170905160027.15081-1-groug@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20170905160027.15081-4-groug@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 3/4] 9pfs: local: clarify fchmodat_nofollow()
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

Since fchmodat(2) on Linux doesn't support AT_SYMLINK_NOFOLLOW, we have t=
o
implement it using workarounds. There are two different ways, depending o=
n
whether the system supports O_PATH or not.

In the case O_PATH is supported, we rely on the behavhior of openat(2)
when passing O_NOFOLLOW | O_PATH and the file is a symbolic link. Even
if openat_file() already adds O_NOFOLLOW to the flags, this patch makes
it explicit that we need both creation flags to obtain the expected
behavior.

This is only cleanup, no functional change.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/9pfs/9p-local.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index efb0b79a74bf..e51af87309c6 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -349,11 +349,11 @@ static int fchmodat_nofollow(int dirfd, const char =
*name, mode_t mode)
         return -1;
     }
=20
-    /* Access modes are ignored when O_PATH is supported. We try O_RDONL=
Y and
-     * O_WRONLY for old-systems that don't support O_PATH.
-     */
-    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
+    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL | O_NOFOLL=
OW, 0);
 #if O_PATH_9P_UTIL =3D=3D 0
+    /* Fallback for systems that don't support O_PATH: we depend on the =
file
+     * being readable or writable.
+     */
     if (fd =3D=3D -1) {
         /* In case the file is writable-only and isn't a directory. */
         if (errno =3D=3D EACCES) {
@@ -368,6 +368,10 @@ static int fchmodat_nofollow(int dirfd, const char *=
name, mode_t mode)
     }
     ret =3D fchmod(fd, mode);
 #else
+    /* Access modes are ignored when O_PATH is supported. If name is a s=
ymbolic
+     * link, O_PATH | O_NOFOLLOW causes openat(2) to return a file descr=
iptor
+     * referring to the symbolic link.
+     */
     if (fd =3D=3D -1) {
         return -1;
     }
--=20
2.13.5
