Received: from eggs.gnu.org ([2001:4830:134:3::10]:41340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpq-0004L5-LN
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpo-0004tA-TC
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpo-0004rx-Op
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70554BB41E
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:10:08 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:08 +0200
Message-Id: <20180713130916.4153-22-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 21/29] util: use fcntl() for
 qemu_write_pidfile() locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

According to Daniel Berrange, fcntl() locks have better portable
semantics than lockf().

Use an exclusive lock on the first byte with fcntl().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 util/oslib-posix.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index da1d4a3201..26b11490b9 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -92,6 +92,11 @@ bool qemu_write_pidfile(const char *pidfile, Error **e=
rrp)
 {
     int pidfd;
     char pidstr[32];
+    struct flock lock =3D {
+        .l_type =3D F_WRLCK,
+        .l_whence =3D SEEK_SET,
+        .l_len =3D 1,
+    };
=20
     pidfd =3D qemu_open(pidfile, O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR);
     if (pidfd =3D=3D -1) {
@@ -99,10 +104,11 @@ bool qemu_write_pidfile(const char *pidfile, Error *=
*errp)
         return false;
     }
=20
-    if (lockf(pidfd, F_TLOCK, 0)) {
+    if (fcntl(pidfd, F_SETLK, &lock)) {
         error_setg_errno(errp, errno, "Cannot lock pid file");
         goto fail;
     }
+
     if (ftruncate(pidfd, 0)) {
         error_setg_errno(errp, errno, "Failed to truncate pid file");
         goto fail;
--=20
2.18.0.129.ge3331758f1
