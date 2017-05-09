Received: from eggs.gnu.org ([2001:4830:134:3::10]:59868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83QB-0005rk-MD
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d83Q7-00037C-MA
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d83Q7-00036x-Fn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 07:35:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 73E9080F97
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 11:35:10 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  9 May 2017 15:33:27 +0400
Message-Id: <20170509113332.4987-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170509113332.4987-1-marcandre.lureau@redhat.com>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/13] be-hci: use backend functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Avoid accessing CharBackend directly, use qemu_chr_be_* methods instead.

be->chr_read should exists if qemu_chr_be_can_write() is true.

(use qemu_chr_be_write(), _impl() bypasses replay)

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/bt/hci-csr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index 0f2021086d..d13192b9b5 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -82,17 +82,14 @@ enum {
=20
 static inline void csrhci_fifo_wake(struct csrhci_s *s)
 {
-    Chardev *chr =3D (Chardev *)s;
-    CharBackend *be =3D chr->be;
+    Chardev *chr =3D CHARDEV(s);
=20
     if (!s->enable || !s->out_len)
         return;
=20
     /* XXX: Should wait for s->modem_state & CHR_TIOCM_RTS? */
-    if (be && be->chr_can_read && be->chr_can_read(be->opaque) &&
-        be->chr_read) {
-        be->chr_read(be->opaque,
-                     s->outfifo + s->out_start++, 1);
+    if (qemu_chr_be_can_write(chr)) {
+        qemu_chr_be_write(chr, s->outfifo + s->out_start++, 1);
         s->out_len--;
         if (s->out_start >=3D s->out_size) {
             s->out_start =3D 0;
--=20
2.13.0.rc1.16.gd80b50c3f
