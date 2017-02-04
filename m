Received: from eggs.gnu.org ([2001:4830:134:3::10]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpvA-0003nr-2F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1cZpv6-0000Bw-Ts
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1cZpv6-0000BU-Kt
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 21:17:44 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1428fH6009187
	for <qemu-devel@nongnu.org>; Fri, 3 Feb 2017 21:17:41 -0500
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28d33umh4e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 21:17:41 -0500
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Sat, 4 Feb 2017 00:17:38 -0200
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
	by d24dlp01.br.ibm.com (Postfix) with ESMTP id E8ED9352005F
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 21:17:01 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v142HYEQ26149056
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:34 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	v142HYqC011990
	for <qemu-devel@nongnu.org>; Sat, 4 Feb 2017 00:17:34 -0200
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Date: Sat,  4 Feb 2017 00:17:16 -0200
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
Message-Id: <1486174642-14883-2-git-send-email-joserz@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH Risu 1/7] risu_ppc64le: improve xsrqpi[x] and
 xsrqpxp instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nikunj@linux.vnet.ibm.com

New constraint added to the referred instructions in order to avoid
generation of reserved (not used today) rounding modes for floating
point operations.

Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
---
 ppc64.risu | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ppc64.risu b/ppc64.risu
index 7b2bfe3..f7fa3f4 100644
--- a/ppc64.risu
+++ b/ppc64.risu
@@ -3019,12 +3019,15 @@ XSREDP PPC64LE 111100 t:5 00000 b:5 00101 1010 bx:1 tx:1
 XSRESP PPC64LE 111100 t:5 00000 b:5 00001 1010 bx:1 tx:1
 
 # format:Z23 book:I page:636 v3.0 xsrqpi[x] VSX Scalar Round QP to Integral
-XSRQPI PPC64LE 111111 vrt:5 0000 r:1 vrb:5 rmc:2 000001010
+XSRQPI PPC64LE 111111 vrt:5 0000 r:1 vrb:5 rmc:2 000001010 \
+!constraints { ($r == 0 && ($rmc != 1 && $rmc != 2)) || $r == 1; }
 # format:Z23 book:I page:636 v3.0 xsrqpi[x] VSX Scalar Round QP to Integral
-XSRQPIx PPC64LE 111111 vrt:5 0000 r:1 vrb:5 rmc:2 000001011
+XSRQPIx PPC64LE 111111 vrt:5 0000 r:1 vrb:5 rmc:2 000001011 \
+!constraints { ($r == 0 && ($rmc != 1 && $rmc != 2)) || $r == 1; }
 
 # format:Z23 book:I page:638 v3.0 xsrqpxp VSX Scalar Round QP to XP
-XSRQPXP PPC64LE 111111 vrt:5 0000 r:1 vrb:5 rmc:2 001001010
+XSRQPXP PPC64LE 111111 vrt:5 0000 r:1 vrb:5 rmc:2 001001010 \
+!constraints { ($r == 0 && ($rmc != 1 && $rmc != 2)) || $r == 1; }
 
 # format:XX2 book:I page:640 v2.07 xsrsp VSX Scalar Round DP to SP
 XSRSP PPC64LE 111100 t:5 00000 b:5 10001 1001 bx:1 tx:1
-- 
2.7.4
