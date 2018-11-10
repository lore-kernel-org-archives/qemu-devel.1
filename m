Received: from eggs.gnu.org ([2001:4830:134:3::10]:36543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTbC-0004e3-E0
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gLTb8-0008SN-GK
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gLTb8-0007uu-3c
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 08:46:50 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 10 Nov 2018 17:45:40 +0400
Message-Id: <20181110134548.14741-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181110134548.14741-1-marcandre.lureau@redhat.com>
References: <20181110134548.14741-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 05/13] slirp: remove unused EMU_RSH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

EMU_RSH handling was dropped in commit
0d62c4cfe21752df4c1d6e2c2398f15d5eaa794a.

The assignment, and subsequent free() of ex_ptr->ex_exec to so->extra
looks unsafe (double free is likely to occur).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
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
index 58d1ef64e9..daa0d5d4bd 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -1491,8 +1491,6 @@ static int slirp_state_load(QEMUFile *f, void *opaq=
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
index 322383a1f9..ff6ef1e334 100644
--- a/slirp/socket.c
+++ b/slirp/socket.c
@@ -91,10 +91,6 @@ sofree(struct socket *so)
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
index e0bf7ad070..eb894b6527 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -546,7 +546,6 @@ static const struct tos_t tcptos[] =3D {
 	  {0, 23, IPTOS_LOWDELAY, 0},	/* telnet */
 	  {0, 80, IPTOS_THROUGHPUT, 0},	/* WWW */
 	  {0, 513, IPTOS_LOWDELAY, EMU_RLOGIN|EMU_NOCONNECT},	/* rlogin */
-	  {0, 514, IPTOS_LOWDELAY, EMU_RSH|EMU_NOCONNECT},	/* shell */
 	  {0, 544, IPTOS_LOWDELAY, EMU_KSH},		/* kshell */
 	  {0, 543, IPTOS_LOWDELAY, 0},	/* klogin */
 	  {0, 6667, IPTOS_THROUGHPUT, EMU_IRC},	/* IRC */
--=20
2.19.1.708.g4ede3d42df
