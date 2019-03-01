Received: from eggs.gnu.org ([209.51.188.92]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzede-0001ky-5p
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gzedd-0004Fa-Aw
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:39:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55468
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gzedd-0004Do-4d
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 04:39:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x219T2sM025385
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 04:39:26 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qy15nbd69-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 04:39:25 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 1 Mar 2019 09:39:24 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 01 Mar 2019 10:39:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <155143315831.102868.17515265400523392682.stgit@bahia.lan>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2] slirp: Fix build with gcc 9
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

The ndpentry structure isn't used to model on-the-wire data or anything
else that would care for the struct layout. It doesn't need to be packed
actually. Just drop SLIRP_PACKED.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - don't check the struct size at compile time
---
 slirp/slirp.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/slirp/slirp.h b/slirp/slirp.h
index 752a4cd8c81c..8068ba1d1e9e 100644
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
