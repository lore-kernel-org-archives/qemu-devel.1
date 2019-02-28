Received: from eggs.gnu.org ([209.51.188.92]:41885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzPun-0008Ig-Fs
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzPui-0008Nc-Cw
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:56:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzPub-0008J7-Ra
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:56:02 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1SHsZqZ141285
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:55:57 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qxj7gq9e1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:55:57 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 28 Feb 2019 17:55:55 -0000
From: Greg Kurz <groug@kaod.org>
Date: Thu, 28 Feb 2019 18:55:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <155137655081.44146.7139636183950580495.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] slirp: Fix build with gcc 9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, Peter Maydell <peter.maydell@linaro.org>

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

All members of struct ndpentry are naturally aligned. Drop the QEMU_PACKE=
D
attribute and check there isn't unwanted padding at build time.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 slirp/slirp.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 752a4cd8c81c..97552962697a 100644
--- a/slirp/slirp.h
+++ b/slirp/slirp.h
@@ -106,7 +106,9 @@ bool arp_table_search(Slirp *slirp, uint32_t ip_addr,
 struct ndpentry {
     unsigned char   eth_addr[ETH_ALEN];     /* sender hardware address *=
/
     struct in6_addr ip_addr;                /* sender IP address       *=
/
-} SLIRP_PACKED;
+};
+
+G_STATIC_ASSERT(sizeof(struct ndpentry) =3D=3D 22);
=20
 #define NDP_TABLE_SIZE 16
=20
