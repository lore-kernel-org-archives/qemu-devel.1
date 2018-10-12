Received: from eggs.gnu.org ([2001:4830:134:3::10]:33136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlEA-0005eB-PH
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAlEA-00053d-3W
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAlE9-00052W-Qk
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 20:22:50 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9696CC04BD47
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 00:22:48 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Fri, 12 Oct 2018 02:22:11 +0200
Message-Id: <20181012002217.2864-6-philmd@redhat.com>
In-Reply-To: <20181012002217.2864-1-philmd@redhat.com>
References: <20181012002217.2864-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/11] chardev: Let chr_sync_read() use
 unsigned type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Prasad J Pandit <ppandit@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Note than tcp_chr_recv() already use size_t.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 chardev/char-socket.c  | 2 +-
 include/chardev/char.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 76cc3c48b0..7e627b243e 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -494,7 +494,7 @@ static gboolean tcp_chr_hup(QIOChannel *channel,
     return G_SOURCE_REMOVE;
 }
=20
-static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
+static size_t tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, size_t=
 len)
 {
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     int size;
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 7becd8c80c..ef4509bfa3 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -251,7 +251,7 @@ typedef struct ChardevClass {
                  bool *be_opened, Error **errp);
=20
     int (*chr_write)(Chardev *s, const uint8_t *buf, int len);
-    int (*chr_sync_read)(Chardev *s, const uint8_t *buf, int len);
+    size_t (*chr_sync_read)(Chardev *s, const uint8_t *buf, size_t len);
     GSource *(*chr_add_watch)(Chardev *s, GIOCondition cond);
     void (*chr_update_read_handler)(Chardev *s);
     int (*chr_ioctl)(Chardev *s, int cmd, void *arg);
--=20
2.17.1
