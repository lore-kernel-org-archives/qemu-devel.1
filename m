Received: from eggs.gnu.org ([2001:4830:134:3::10]:51692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavyh-00055n-C0
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sam.bobroff@au1.ibm.com>) id 1cavye-0002sS-Bw
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:57:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sam.bobroff@au1.ibm.com>)
	id 1cavye-0002s1-2P
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:57:56 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v172ruMJ091577
	for <qemu-devel@nongnu.org>; Mon, 6 Feb 2017 21:57:54 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28f3bump2c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 21:57:54 -0500
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sam.bobroff@au1.ibm.com>;
	Tue, 7 Feb 2017 12:57:51 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
Date: Tue,  7 Feb 2017 13:56:44 +1100
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
Message-Id: <900ea185630c17f315c4984b2a595b2d3fba7c9a.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: [Qemu-devel] [RFC PATCH 1/9] spapr: fix off-by-one error in
 spapr_ovec_populate_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

The last byte of the option vector was missing due to an off-by-one
error. Without this fix, client architecture support negotiation will
fail because the last byte of option vector 5, which contains the MMU
support, will be missed.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 hw/ppc/spapr_ovec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
index 4f4c090a29..18dbc4a9ac 100644
--- a/hw/ppc/spapr_ovec.c
+++ b/hw/ppc/spapr_ovec.c
@@ -251,7 +251,7 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
         }
     }
 
-    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len);
+    return fdt_setprop(fdt, fdt_offset, name, vec, vec_len + 1);
 }
 
 void spapr_ovec_ruler(int width, sPAPROptionVector *ov)
-- 
2.11.0
