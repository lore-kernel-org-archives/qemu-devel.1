Received: from eggs.gnu.org ([2001:4830:134:3::10]:49108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTJT-000640-A2
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTJS-0008Sw-FN
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjTJS-0008SH-9B
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:42 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  2 Mar 2017 16:10:32 +0000
Message-Id: <20170302161033.4787-3-berrange@redhat.com>
In-Reply-To: <20170302161033.4787-1-berrange@redhat.com>
References: <20170302161033.4787-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 2/3] tests: fix leaks in
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
