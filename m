Received: from eggs.gnu.org ([2001:4830:134:3::10]:46666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eY-000670-Lp
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gP3eX-0008Hg-QI
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gP3eX-0008Eu-GT
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:53:09 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 20 Nov 2018 11:52:22 +0100
Message-Id: <1542711143-1946-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1542711143-1946-1-git-send-email-thuth@redhat.com>
References: <1542711143-1946-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/3] tests/ide: Free pcibus when finishing a test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>

Once a test has finished, the pcibus structure should be freed, to
avoid leaking memory and to make sure that the structure is properly
re-initialized when the next test starts.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ide-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 33cef61..f0280e6 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -142,6 +142,10 @@ static void ide_test_start(const char *cmdline_fmt, =
...)
=20
 static void ide_test_quit(void)
 {
+    if (pcibus) {
+        qpci_free_pc(pcibus);
+        pcibus =3D NULL;
+    }
     pc_alloc_uninit(guest_malloc);
     guest_malloc =3D NULL;
     qtest_end();
--=20
1.8.3.1
