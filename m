Received: from eggs.gnu.org ([209.51.188.92]:55617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjSa3-000272-Dp
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjSa2-0007Rp-BF
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:32:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjSa2-0007RA-5z
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:32:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FABC86663
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 17:32:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 15 Jan 2019 18:32:42 +0100
Message-Id: <1547573562-32754-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] seccomp: Work-around GCC 4.x bug in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>

We'd like to compile QEMU with -std=3Dgnu99, but GCC 4.8 currently
fails to compile qemu-seccomp.c in this mode:

qemu-seccomp.c:45:1: error: initializer element is not constant
 };
 ^
qemu-seccomp.c:45:1: error: (near initialization for =E2=80=98sched_setsc=
heduler_arg[0]=E2=80=99)

This is due to a compiler bug which has just been fixed in GCC 5.0:

 https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63567

Since we still want to support GCC 4.8 for a while and also want to use
gnu99 mode, work-around the issue by expanding the macro manually.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-seccomp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 5c73e6a..36d5829 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -41,7 +41,8 @@ struct QemuSeccompSyscall {
 };
=20
 const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
-    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
+    /* was SCMP_A1(SCMP_CMP_NE, SCHED_IDLE), but expanded due to GCC 4.x=
 bug */
+    { .arg =3D 1, .op =3D SCMP_CMP_NE, .datum_a =3D SCHED_IDLE }
 };
=20
 static const struct QemuSeccompSyscall blacklist[] =3D {
--=20
1.8.3.1
