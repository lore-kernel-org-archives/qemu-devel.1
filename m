Received: from eggs.gnu.org ([209.51.188.92]:36105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rZ0-0008NJ-2Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1rYz-0003UX-3U
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:50 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1rYy-0003TM-Q8
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:51:48 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 12:51:31 +0100
Message-Id: <20190307115143.780-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
References: <20190307115143.780-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULLv2 01/12] slirp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, stefanha@redhat.com, jan.kiszka@siemens.com, peter.maydell@linaro.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

From: Greg Kurz <groug@kaod.org>

Build fails with gcc 9:

  CC      slirp/ndp_table.o
slirp/ndp_table.c: In function =E2=80=98ndp_table_add=E2=80=99:
slirp/ndp_table.c:31:23: error: taking address of packed member of =E2=80=
=98struct ndpentry=E2=80=99 may result in an unaligned pointer value [-We=
rror=3Daddress-of-packed-member]
   31 |         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)) {
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
slirp/ndp_table.c: In function =E2=80=98ndp_table_search=E2=80=99:
slirp/ndp_table.c:75:23: error: taking address of packed member of =E2=80=
=98struct ndpentry=E2=80=99 may result in an unaligned pointer value [-We=
rror=3Daddress-of-packed-member]
   75 |         if (in6_equal(&ndp_table->table[i].ip_addr, &ip_addr)) {
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

The ndpentry structure isn't used to model on-the-wire data or anything
else that would care for the struct layout. It doesn't need to be packed
actually. Just drop SLIRP_PACKED.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155143315831.102868.17515265400523392682.stgit@bahia.lan>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
---
 slirp/slirp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 752a4cd8c8..8068ba1d1e 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -106,7 +106,7 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
 struct ndpentry {
     unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address *=
/
     struct in6_addr ip_addr;                /* sender IP address       *=
/
-} SLIRP_PACKED;
+};
=20
 #define NDP_TABLE_SIZE 16
=20
--=20
2.20.1
