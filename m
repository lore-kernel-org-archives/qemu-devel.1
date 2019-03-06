Received: from eggs.gnu.org ([209.51.188.92]:47391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR6-000386-7C
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1h1gR5-0003l3-6K
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:56 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:43712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1h1gR4-0003kY-Uy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 18:58:55 -0500
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Thu,  7 Mar 2019 00:58:39 +0100
Message-Id: <20190306235850.30110-2-samuel.thibault@ens-lyon.org>
In-Reply-To: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
References: <20190306235850.30110-1-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/12] slirp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Greg Kurz <groug@kaod.org>, stefanha@redhat.com, jan.kiszka@siemens.com, Samuel Thibault <samuel.thibault@ens-lyon.org>

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
