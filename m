Received: from eggs.gnu.org ([2001:4830:134:3::10]:51033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLT3-00042p-TZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciLT3-0007jy-4v
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciLT2-0007jf-Li
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 08:35:56 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 27 Feb 2017 13:35:31 +0000
Message-Id: <20170227133531.31874-4-berrange@redhat.com>
In-Reply-To: <20170227133531.31874-1-berrange@redhat.com>
References: <20170227133531.31874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/3] tests: fix leaks in
 test-io-channel-command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

No need for strdup, fix leaks when socat is missing.

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-io-channel-command.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-comm=
and.c
index 1d1f461..46ce1ff 100644
--- a/tests/test-io-channel-command.c
+++ b/tests/test-io-channel-command.c
@@ -29,8 +29,8 @@ static void test_io_channel_command_fifo(bool async)
 #define TEST_FIFO "tests/test-io-channel-command.fifo"
     QIOChannel *src, *dst;
     QIOChannelTest *test;
-    char *srcfifo =3D g_strdup_printf("PIPE:%s,wronly", TEST_FIFO);
-    char *dstfifo =3D g_strdup_printf("PIPE:%s,rdonly", TEST_FIFO);
+    const char *srcfifo =3D "PIPE:" TEST_FIFO ",wronly";
+    const char *dstfifo =3D "PIPE:" TEST_FIFO ",rdonly";
     const char *srcargv[] =3D {
         "/bin/socat", "-", srcfifo, NULL,
     };
@@ -59,8 +59,6 @@ static void test_io_channel_command_fifo(bool async)
     object_unref(OBJECT(src));
     object_unref(OBJECT(dst));
=20
-    g_free(srcfifo);
-    g_free(dstfifo);
     unlink(TEST_FIFO);
 }
=20
--=20
2.9.3
