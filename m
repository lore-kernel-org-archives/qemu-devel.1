Received: from eggs.gnu.org ([2001:4830:134:3::10]:45184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiKbS-0000aI-6J
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiKbP-0006kz-5b
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fiKbP-0006kT-0F
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:17:19 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Wed, 25 Jul 2018 16:16:09 +0200
Message-Id: <20180725141610.12075-2-otubo@redhat.com>
In-Reply-To: <20180725141610.12075-1-otubo@redhat.com>
References: <20180725141610.12075-1-otubo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] seccomp: use SIGSYS signal instead of
 killing the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The seccomp action SCMP_ACT_KILL results in immediate termination of
the thread that made the bad system call. However, qemu being
multi-threaded, it keeps running. There is no easy way for parent
process / management layer (libvirt) to know about that situation.

Instead, the default SIGSYS handler when invoked with SCMP_ACT_TRAP
will terminate the program and core dump.

This may not be the most secure solution, but probably better than
just killing the offending thread. SCMP_ACT_KILL_PROCESS has been
added in Linux 4.14 to improve the situation, which I propose to use
by default if available in the next patch.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Eduardo Otubo <otubo@redhat.com>
---
 qemu-seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 9cd8eb9499..b117a92559 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -125,7 +125,7 @@ static int seccomp_start(uint32_t seccomp_opts)
             continue;
         }
=20
-        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_KILL, blacklist[i].n=
um,
+        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_TRAP, blacklist[i].n=
um,
                                     blacklist[i].narg, blacklist[i].arg_=
cmp);
         if (rc < 0) {
             goto seccomp_return;
--=20
2.17.1
