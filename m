Received: from eggs.gnu.org ([2001:4830:134:3::10]:59574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9v-00044f-4q
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fOT9u-0008Tc-4P
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:51 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fOT9t-0008Sg-UT
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:22:50 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu, 31 May 2018 21:22:30 +0200
Message-Id: <20180531192237.3994-3-samuel.thibault@ens-lyon.org>
In-Reply-To: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
References: <20180531192237.3994-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] slirp: disable Nagle in outgoing connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andreas Gustafsson <gson@gson.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Andreas Gustafsson <gson@gson.org>

When setting up an outgoing user mode networking TCP connection,
disable the Nagle algorithm in the host-side connection.  Either the
guest is already doing Nagle, in which case there is no point in doing
it twice, or it has chosen to disable it, in which case we should
respect that choice.

This change speeds up GDB remote debugging over TCP over user mode
networking (with GDB runing on the guest) by multiple orders of
magnitude, and has been part of the local patches applied by pkgsrc
since 2012 with no reported ill effects.

Signed-off-by: Andreas Gustafsson <gson@gson.org>
Reviewed-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tcp_subr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/slirp/tcp_subr.c b/slirp/tcp_subr.c
index da0d53743f..8d0f94b75f 100644
--- a/slirp/tcp_subr.c
+++ b/slirp/tcp_subr.c
@@ -416,6 +416,8 @@ int tcp_fconnect(struct socket *so, unsigned short af=
)
     socket_set_fast_reuse(s);
     opt =3D 1;
     qemu_setsockopt(s, SOL_SOCKET, SO_OOBINLINE, &opt, sizeof(opt));
+    opt =3D 1;
+    qemu_setsockopt(s, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
=20
     addr =3D so->fhost.ss;
     DEBUG_CALL(" connect()ing")
--=20
2.17.0
