Received: from eggs.gnu.org ([209.51.188.92]:51127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk4-0002x8-4a
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gipk2-0006Ks-6b
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:35 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:60036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gipk1-0006A1-Tp
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 19:04:34 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Mon, 14 Jan 2019 01:02:26 +0100
Message-Id: <20190114000326.29847-6-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
References: <20190114000326.29847-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/65] slirp: remove unused EMU_RSH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

EMU_RSH handling was dropped in commit
0d62c4cfe21752df4c1d6e2c2398f15d5eaa794a.

The assignment, and subsequent free() of ex_ptr->ex_exec to so->extra
looks unsafe (double free is likely to occur).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/misc.h     | 1 -
 slirp/slirp.c    | 2 --
 slirp/socket.c   | 4 ----
 slirp/tcp_subr.c | 1 -
 4 files changed, 8 deletions(-)

diff --git a/slirp/misc.h b/slirp/misc.h
index 64ca88c3b7..94829722cd 100644
--- a/slirp/misc.h
+++ b/slirp/misc.h
@@ -26,7 +26,6 @@ struct ex_list {
 #define EMU_REALAUDIO 0x5
 #define EMU_RLOGIN 0x6
 #define EMU_IDENT 0x7
-#define EMU_RSH 0x8
=20
 #define EMU_NOCONNECT 0x10	/* Don't connect */
=20
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 0de46084c0..fac7849195 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1499,8 +1499,6 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
ue, int version_id)
         }
         if (!ex_ptr)
             return -EINVAL;
-
-        so->extra =3D (void *)ex_ptr->ex_exec;
     }
=20
     return vmstate_load_state(f, &vmstate_slirp, slirp, version_id);
diff --git a/slirp/socket.c b/slirp/socket.c
index c01d8696af..041ec5061a 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -89,10 +89,6 @@ sofree(struct socket *so)
   soqfree(so, &slirp->if_fastq);
   soqfree(so, &slirp->if_batchq);
=20
-  if (so->so_emu=3D=3DEMU_RSH && so->extra) {
-	sofree(so->extra);
-	so->extra=3DNULL;
-  }
   if (so =3D=3D slirp->tcp_last_so) {
       slirp->tcp_last_so =3D &slirp->tcb;
   } else if (so =3D=3D slirp->udp_last_so) {
diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index e7b2baa087..fd7521854e 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -541,7 +541,6 @@ static const struct tos_t tcptos[] =3D {
 	  {0, 23, IPTOS_LOWDELAY, 0},	/* telnet */
 	  {0, 80, IPTOS_THROUGHPUT, 0},	/* WWW */
 	  {0, 513, IPTOS_LOWDELAY, EMU_RLOGIN|EMU_NOCONNECT},	/* rlogin */
-	  {0, 514, IPTOS_LOWDELAY, EMU_RSH|EMU_NOCONNECT},	/* shell */
 	  {0, 544, IPTOS_LOWDELAY, EMU_KSH},		/* kshell */
 	  {0, 543, IPTOS_LOWDELAY, 0},	/* klogin */
 	  {0, 6667, IPTOS_THROUGHPUT, EMU_IRC},	/* IRC */
--=20
2.20.1
