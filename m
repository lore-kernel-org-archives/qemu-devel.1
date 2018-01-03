Received: from eggs.gnu.org ([2001:4830:134:3::10]:49495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYaK-0006ko-UD
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWYaJ-0004NB-V1
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:15:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWYaJ-0004Mf-Oa
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 21:15:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AB8DC0587F9
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 02:15:15 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 10:14:54 +0800
Message-Id: <20180103021456.22526-2-peterx@redhat.com>
In-Reply-To: <20180103021456.22526-1-peterx@redhat.com>
References: <20180103021456.22526-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] chardev: use backend chr context when
 watch for fe
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

In commit 6bbb6c0644 ("chardev: use per-dev context for
io_add_watch_poll", 2017-09-22) all the chardev watches are converted to
use per-chardev gcontext to support chardev to be run outside default
main thread.  However that's still missing one call from the frontend
code.  Touch that up.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 chardev/char-fe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index ee6d596100..c611b3fa3e 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -356,7 +356,7 @@ guint qemu_chr_fe_add_watch(CharBackend *be, GIOCondi=
tion cond,
     }
=20
     g_source_set_callback(src, (GSourceFunc)func, user_data, NULL);
-    tag =3D g_source_attach(src, NULL);
+    tag =3D g_source_attach(src, s->gcontext);
     g_source_unref(src);
=20
     return tag;
--=20
2.14.3
