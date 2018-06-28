Received: from eggs.gnu.org ([2001:4830:134:3::10]:33693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYViv-0006bl-Qp
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYVis-0007tw-V6
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYVis-0007sb-RR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:08:26 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu, 28 Jun 2018 13:08:20 +0100
Message-Id: <20180628120821.10967-2-berrange@redhat.com>
In-Reply-To: <20180628120821.10967-1-berrange@redhat.com>
References: <20180628120821.10967-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 1/2] socket: dont't free msgfds if error
 equals EAGAIN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, linzhecheng <linzhecheng@huawei.com>

From: linzhecheng <linzhecheng@huawei.com>

If we see EAGAIN, no data was sent over the socket, so we still have to
retry sending of msgfds next time.

Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 chardev/char-socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 159e69c3b1..17519ec589 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -134,8 +134,8 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
                                         s->write_msgfds,
                                         s->write_msgfds_num);
=20
-        /* free the written msgfds, no matter what */
-        if (s->write_msgfds_num) {
+        /* free the written msgfds in any cases other than errno=3D=3DEA=
GAIN */
+        if (EAGAIN !=3D errno && s->write_msgfds_num) {
             g_free(s->write_msgfds);
             s->write_msgfds =3D 0;
             s->write_msgfds_num =3D 0;
--=20
2.17.1
