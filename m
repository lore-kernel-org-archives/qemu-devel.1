Received: from eggs.gnu.org ([2001:4830:134:3::10]:55422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXAD-0002Bq-V7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dPXAA-0002x0-DJ
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:47:01 -0400
Received: from mail-eopbgr50101.outbound.protection.outlook.com
	([40.107.5.101]:39904
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dPXAA-0002wB-5N
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 12:46:58 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Mon, 26 Jun 2017 19:45:43 +0300
Message-ID: <1498495550-72357-7-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 06/13] test-char: unref chardev-udp after
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

this is only not a problem if the test is last in a suite,
otherwise it makes the following main_loop() calls to fail

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/test-char.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/test-char.c b/tests/test-char.c
index 1f6b9bc..90b1f50 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -452,6 +452,8 @@ static void char_udp_test(void)
=20
     close(sock);
     g_free(tmp);
+    qemu_chr_fe_deinit(&be);
+    object_unparent(OBJECT(chr));
 }
=20
 #ifdef HAVE_CHARDEV_SERIAL
--=20
2.7.4
