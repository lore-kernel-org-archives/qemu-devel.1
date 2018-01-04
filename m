Received: from eggs.gnu.org ([2001:4830:134:3::10]:41388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eX30A-00026O-Eh
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eX309-0001MA-Mi
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:43:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eX309-0001Le-GU
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 05:43:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0A1687620
	for <qemu-devel@nongnu.org>; Thu,  4 Jan 2018 10:43:56 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Thu,  4 Jan 2018 18:43:35 +0800
Message-Id: <20180104104336.2794-3-peterx@redhat.com>
In-Reply-To: <20180104104336.2794-1-peterx@redhat.com>
References: <20180104104336.2794-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/3] chardev: let g_idle_add() be with
 chardev gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, peterx@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The idle task will be attached to main gcontext even if the chardev
backend is running in another gcontext.  Fix the only caller by
extending the g_idle_add() logic into the more powerful
g_source_attach().  It's basically g_idle_add_full() implementation, but
with the chardev's gcontext passed in.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-pty.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/chardev/char-pty.c b/chardev/char-pty.c
index 761ae6dec1..dd17b1b823 100644
--- a/chardev/char-pty.c
+++ b/chardev/char-pty.c
@@ -210,9 +210,14 @@ static void pty_chr_state(Chardev *chr, int connecte=
d)
             s->timer_tag =3D 0;
         }
         if (!s->connected) {
+            GSource *source =3D g_idle_source_new();
+
             g_assert(s->open_tag =3D=3D 0);
             s->connected =3D 1;
-            s->open_tag =3D g_idle_add(qemu_chr_be_generic_open_func, ch=
r);
+            g_source_set_callback(source, qemu_chr_be_generic_open_func,
+                                  chr, NULL);
+            s->open_tag =3D g_source_attach(source, chr->gcontext);
+            g_source_unref(source);
         }
         if (!chr->gsource) {
             chr->gsource =3D io_add_watch_poll(chr, s->ioc,
--=20
2.14.3
