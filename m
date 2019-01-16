Received: from eggs.gnu.org ([209.51.188.92]:38661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjux2-000689-Gu
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gjuws-0002lt-IC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:50:22 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:54556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gjuwp-0002fo-9U
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 18:50:16 -0500
Date: Thu, 17 Jan 2019 00:50:09 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190116235009.tl4gcv53e62npecl@function>
References: <20181226034254.17842-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181226034254.17842-1-richard.henderson@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Use lduw_be_p in slirp_input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, jan.kiszka@siemens.com

Hello,

Richard Henderson, le mer. 26 d=C3=A9c. 2018 14:42:54 +1100, a ecrit:
> The pointer may be unaligned, so we must use our routines for that.
> At the same time, we might as well use the big-endian version
> instead of ntohs.
>=20
> This fixes sparc64 host SIGBUS during pxe boot.

I'm not at ease with applying this, when Marc-Andr=C3=A9 is trying to mak=
e
slirp an external library...  I'd rather apply the change below, could
somebody review it?

Samuel


slirp: Avoid unaligned 16bit memory access

pkt parameter may be unaligned, so we must access it byte-wise.

This fixes sparc64 host SIGBUS during pxe boot.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/slirp/slirp.c b/slirp/slirp.c
index ab2fc4eb8b..0e41d5aedf 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -851,7 +851,7 @@ void slirp_input(Slirp *slirp, const uint8_t *pkt, in=
t pkt_len)
     if (pkt_len < ETH_HLEN)
         return;
=20
-    proto =3D ntohs(*(uint16_t *)(pkt + 12));
+    proto =3D (((uint16_t) pkt[12]) << 8) + pkt[13];
     switch(proto) {
     case ETH_P_ARP:
         arp_input(slirp, pkt, pkt_len);
