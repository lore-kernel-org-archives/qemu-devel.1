Received: from eggs.gnu.org ([209.51.188.92]:42965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB479-0003jP-7r
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB477-00050G-BC
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB477-0004n9-0J
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4eGa053806
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:47 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx57rg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:44 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:01:57 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:58:35 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190401210011.16009-2-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 01/97] target/arm: Fix sign of
 sve_cmpeq_ppzw/sve_cmpne_ppzw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

From: Richard Henderson <richard.henderson@linaro.org>

The normal vector element is sign-extended before
comparing with the wide vector element.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180801123111.3595-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit df4e001093988544d09887122ae824f18ba55c68)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/arm/sve_helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 54795c9194..9bd0694d55 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2436,13 +2436,13 @@ uint32_t HELPER(NAME)(void *vd, void *vn, void *v=
m, void *vg, uint32_t desc) \
 #define DO_CMP_PPZW_S(NAME, TYPE, TYPEW, OP) \
     DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H1_4, 0x1111111111111111ull)
=20
-DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, uint8_t,  uint64_t, =3D=3D)
-DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, uint16_t, uint64_t, =3D=3D)
-DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, uint32_t, uint64_t, =3D=3D)
+DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, int8_t,  uint64_t, =3D=3D)
+DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, int16_t, uint64_t, =3D=3D)
+DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, int32_t, uint64_t, =3D=3D)
=20
-DO_CMP_PPZW_B(sve_cmpne_ppzw_b, uint8_t,  uint64_t, !=3D)
-DO_CMP_PPZW_H(sve_cmpne_ppzw_h, uint16_t, uint64_t, !=3D)
-DO_CMP_PPZW_S(sve_cmpne_ppzw_s, uint32_t, uint64_t, !=3D)
+DO_CMP_PPZW_B(sve_cmpne_ppzw_b, int8_t,  uint64_t, !=3D)
+DO_CMP_PPZW_H(sve_cmpne_ppzw_h, int16_t, uint64_t, !=3D)
+DO_CMP_PPZW_S(sve_cmpne_ppzw_s, int32_t, uint64_t, !=3D)
=20
 DO_CMP_PPZW_B(sve_cmpgt_ppzw_b, int8_t,   int64_t, >)
 DO_CMP_PPZW_H(sve_cmpgt_ppzw_h, int16_t,  int64_t, >)
--=20
2.17.1
