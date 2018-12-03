Received: from eggs.gnu.org ([2001:4830:134:3::10]:51562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqED-0007yL-Cb
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gTqEA-00043f-0P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gTqE9-00042Z-Ra
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:33:41 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Dec 2018 16:32:20 +0100
Message-Id: <1543851204-41186-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 07/71] vhost-user-test: signal data_cond when
 s->rings changes
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

This speeds up wait_for_rings_started, which currently is just waiting fo=
r
the timeout before checking s->rings.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vhost-user-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 656e519..6a805e6 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -384,6 +384,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
=20
         assert(msg.payload.state.index < s->queues * 2);
         s->rings &=3D ~(0x1ULL << msg.payload.state.index);
+        g_cond_broadcast(&s->data_cond);
         break;
=20
     case VHOST_USER_SET_MEM_TABLE:
@@ -425,6 +426,7 @@ static void chr_read(void *opaque, const uint8_t *buf=
, int size)
     case VHOST_USER_SET_VRING_BASE:
         assert(msg.payload.state.index < s->queues * 2);
         s->rings |=3D 0x1ULL << msg.payload.state.index;
+        g_cond_broadcast(&s->data_cond);
         break;
=20
     case VHOST_USER_GET_QUEUE_NUM:
--=20
1.8.3.1
