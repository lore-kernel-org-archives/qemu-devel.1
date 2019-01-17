Received: from eggs.gnu.org ([209.51.188.92]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk7sT-0006Hr-Hf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk7sS-00066n-8b
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:38:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk7sQ-00061T-E1
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:38:36 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Jan 2019 14:38:12 +0100
Message-Id: <1547732292-14021-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1547732292-14021-1-git-send-email-thuth@redhat.com>
References: <1547732292-14021-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 26/28] seccomp: Work-around GCC 4.x bug in
 gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>, groug@kaod.org, clg@kaod.org, mst@redhat.com

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

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
