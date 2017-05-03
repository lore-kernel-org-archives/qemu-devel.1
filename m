Received: from eggs.gnu.org ([2001:4830:134:3::10]:53488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62ve-0001fS-RK
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62va-0000Mo-Uo
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d62va-0000MH-Ow
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:39:22 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 02:38:45 +0400
Message-Id: <20170503223846.6559-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170503223846.6559-1-marcandre.lureau@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 4/5] slirp: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>

Spotted by ASAN:

/x86_64/hmp/pc-0.12:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D22538=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 224 byte(s) in 1 object(s) allocated from:
    #0 0x7f0f63cdee60 in malloc (/lib64/libasan.so.3+0xc6e60)
    #1 0x556f11ff32d7 in tcp_newtcpcb /home/elmarco/src/qemu/slirp/tcp_su=
br.c:250
    #2 0x556f11fdb1d1 in tcp_listen /home/elmarco/src/qemu/slirp/socket.c=
:688
    #3 0x556f11fca9d5 in slirp_add_hostfwd /home/elmarco/src/qemu/slirp/s=
lirp.c:1052
    #4 0x556f11f8db41 in slirp_hostfwd /home/elmarco/src/qemu/net/slirp.c=
:506
    #5 0x556f11f8dd83 in hmp_hostfwd_add /home/elmarco/src/qemu/net/slirp=
.c:535

There might be a better way to fix this, but calling slirp tcp_close()
doesn't work.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 slirp/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/slirp/socket.c b/slirp/socket.c
index 86927722e1..3b49a69a93 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -100,6 +100,9 @@ sofree(struct socket *so)
   if(so->so_next && so->so_prev)
     remque(so);  /* crashes if so is not in a queue */
=20
+  if (so->so_tcpcb) {
+      free(so->so_tcpcb);
+  }
   free(so);
 }
=20
--=20
2.12.0.191.gc5d8de91d
