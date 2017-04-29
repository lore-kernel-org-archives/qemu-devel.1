Received: from eggs.gnu.org ([2001:4830:134:3::10]:39208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXH-0006ry-OD
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXG-0001L2-UN
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:55 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:55403)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1d4VXG-0001Kg-NN
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 12:47:54 -0400
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sat, 29 Apr 2017 18:47:44 +0200
Message-Id: <20170429164750.17414-4-samuel.thibault@ens-lyon.org>
In-Reply-To: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
References: <20170429164750.17414-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] slirp: tftp, copy sockaddr_size
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

ASAN detects an "unknown-crash" when running pxe-test:

/ppc64/pxe/spapr-vlan: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D7143=3D=3DERROR: AddressSanitizer: unknown-crash on address 0x7f6dc=
d298d30 at pc 0x55e22218830d bp 0x7f6dcd2989e0 sp 0x7f6dcd2989d0
READ of size 128 at 0x7f6dcd298d30 thread T2
    #0 0x55e22218830c in tftp_session_allocate /home/elmarco/src/qq/slirp=
/tftp.c:73
    #1 0x55e22218a1f8 in tftp_handle_rrq /home/elmarco/src/qq/slirp/tftp.=
c:289
    #2 0x55e22218b54c in tftp_input /home/elmarco/src/qq/slirp/tftp.c:446
    #3 0x55e2221833fe in udp6_input /home/elmarco/src/qq/slirp/udp6.c:82
    #4 0x55e222137b17 in ip6_input /home/elmarco/src/qq/slirp/ip6_input.c=
:67

Address 0x7f6dcd298d30 is located in stack of thread T2 at offset 96 in f=
rame
    #0 0x55e222182420 in udp6_input /home/elmarco/src/qq/slirp/udp6.c:13

  This frame has 3 object(s):
    [32, 48) '<unknown>'
    [96, 124) 'lhost' <=3D=3D Memory access at offset 96 partially overfl=
ows this variable
    [160, 200) 'save_ip' <=3D=3D Memory access at offset 96 partially und=
erflows this variable

The sockaddr_storage pointer is the sockaddr_in6 lhost on the
stack. Copy only the source addr size.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/tftp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/tftp.c b/slirp/tftp.c
index 50e714807d..a9bc4bb1b6 100644
--- a/slirp/tftp.c
+++ b/slirp/tftp.c
@@ -70,7 +70,7 @@ static int tftp_session_allocate(Slirp *slirp, struct s=
ockaddr_storage *srcsas,
=20
  found:
   memset(spt, 0, sizeof(*spt));
-  spt->client_addr =3D *srcsas;
+  memcpy(&spt->client_addr, srcsas, sockaddr_size(srcsas));
   spt->fd =3D -1;
   spt->block_size =3D 512;
   spt->client_port =3D tp->udp.uh_sport;
--=20
2.11.0
