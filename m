Received: from eggs.gnu.org ([2001:4830:134:3::10]:33513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dJK2z-0000Lu-U6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dJK2v-0006Sh-0p
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dJK2u-0006Q4-Qr
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:33:48 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  9 Jun 2017 17:33:37 +0400
Message-Id: <20170609133337.31183-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

user_creatable_add_opts() returns a reference (the other reference is
for the root parent/child link).

Leak introduced in commit a1af255f065cc.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/check-qom-proplist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index 8e432e9ab6..a3cd7ab29f 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -428,6 +428,8 @@ static void test_dummy_createcmdl(void)
     g_assert(err =3D=3D NULL);
     error_free(err);
=20
+    object_unref(OBJECT(dobj));
+
     /*
      * cmdline-parsing via qemu_opts_parse() results in a QemuOpts entry
      * corresponding to the Object's ID to be added to the QemuOptsList
--=20
2.13.0.91.g00982b8dd
