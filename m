Received: from eggs.gnu.org ([2001:4830:134:3::10]:51558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqED-0007yE-89
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqE8-00041X-EX
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqE8-00040k-8w
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:19 +0100
Message-Id: <1543851204-41186-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/71] vhost-user-test: use g_cond_broadcast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>

g_cond_signal is rarely the right thing to do, it works now because
vhost-user-test only has two threads but it is not correct in general.
Fix it before adding more calls.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 45d58d8..656e519 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -393,7 +393,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
                                             G_N_ELEMENTS(s->fds));
=20
         /* signal the test that it can continue */
-        g_cond_signal(&s->data_cond);
+        g_cond_broadcast(&s->data_cond);
         break;
=20
     case VHOST_USER_SET_VRING_KICK:
@@ -419,7 +419,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
         p =3D (uint8_t *) &msg;
         qemu_chr_fe_write_all(chr, p, VHOST_USER_HDR_SIZE);
=20
-        g_cond_signal(&s->data_cond);
+        g_cond_broadcast(&s->data_cond);
         break;
=20
     case VHOST_USER_SET_VRING_BASE:
--=20
1.8.3.1
