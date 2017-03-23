Received: from eggs.gnu.org ([2001:4830:134:3::10]:33374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cr0yS-0001nv-NI
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cr0yN-00064Y-Q6
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:32:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cr0yN-00064A-Jh
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:32:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 23 Mar 2017 15:31:56 +0400
Message-Id: <20170323113156.9277-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: tftp, copy sockaddr_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
2.12.0.191.gc5d8de91d
