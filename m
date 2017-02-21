Received: from eggs.gnu.org ([2001:4830:134:3::10]:55699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBDk-0000bf-2b
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cgBDi-0003li-7d
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cgBDi-0003lB-1z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:15:10 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4162E7E9E5
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 14:15:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Feb 2017 18:14:24 +0400
Message-Id: <20170221141451.28305-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-1-marcandre.lureau@redhat.com>
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/30] tests: fix leaks in
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

No need for strdup, fix leaks when socat is missing.

Spotted by ASAN.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: "Daniel P. Berrange" <berrange@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 tests/test-io-channel-command.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/test-io-channel-command.c b/tests/test-io-channel-comm=
and.c
index 1d1f461bed..46ce1ff01c 100644
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
2.11.0.295.gd7dffce1c.dirty
