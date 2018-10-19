Received: from eggs.gnu.org ([2001:4830:134:3::10]:46272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gDRn7-0006tY-FP
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gDRn1-0007O9-W9
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gDRn1-0007Jj-QM
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:13:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Oct 2018 14:13:46 +0400
Message-Id: <20181019101346.3316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] websock: fix handshake leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, jusual@mail.ru, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Thanks Valgrind:

=3D=3D955=3D=3D 217 bytes in 1 blocks are definitely lost in loss record =
275 of 321
=3D=3D955=3D=3D    at 0x483A965: realloc (vg_replace_malloc.c:785)
=3D=3D955=3D=3D    by 0x50B6839: __vasprintf_chk (in /usr/lib64/libc-2.28=
.so)
=3D=3D955=3D=3D    by 0x49AA05C: g_vasprintf (in /usr/lib64/libglib-2.0.s=
o.0.5800.1)
=3D=3D955=3D=3D    by 0x4983440: g_strdup_vprintf (in /usr/lib64/libglib-=
2.0.so.0.5800.1)
=3D=3D955=3D=3D    by 0x126048: qio_channel_websock_handshake_send_res (c=
hannel-websock.c:162)
=3D=3D955=3D=3D    by 0x1266E6: qio_channel_websock_handshake_send_res_ok=
 (channel-websock.c:362)
=3D=3D955=3D=3D    by 0x126D3E: qio_channel_websock_handshake_process (ch=
annel-websock.c:468)
=3D=3D955=3D=3D    by 0x126EF2: qio_channel_websock_handshake_read (chann=
el-websock.c:511)
=3D=3D955=3D=3D    by 0x12715B: qio_channel_websock_handshake_io (channel=
-websock.c:571)
=3D=3D955=3D=3D    by 0x125027: qio_channel_fd_source_dispatch (channel-w=
atch.c:84)
=3D=3D955=3D=3D    by 0x496326C: g_main_context_dispatch (in /usr/lib64/l=
ibglib-2.0.so.0.5800.1)
=3D=3D955=3D=3D    by 0x169EC3: glib_pollfds_poll (main-loop.c:215)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 io/channel-websock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index e6608b969d..dc43dc6bb9 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -163,6 +163,7 @@ qio_channel_websock_handshake_send_res(QIOChannelWebs=
ock *ioc,
     responselen =3D strlen(response);
     buffer_reserve(&ioc->encoutput, responselen);
     buffer_append(&ioc->encoutput, response, responselen);
+    g_free(response);
     va_end(vargs);
 }
=20
--=20
2.19.0.271.gfe8321ec05
