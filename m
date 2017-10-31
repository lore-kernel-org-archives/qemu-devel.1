Received: from eggs.gnu.org ([2001:4830:134:3::10]:59328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9dOA-00013v-RO
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e9dO7-0004Ea-OP
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e9dO7-0004EA-FJ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 16:43:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9VKf8r4087449
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 16:43:53 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dy04ugwvy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 16:43:52 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 31 Oct 2017 14:43:52 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 31 Oct 2017 18:43:30 -0200
In-Reply-To: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
References: <20171031204330.14803-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171031204330.14803-5-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/4] tests/rtas-test.c: fix Apple endian.h
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com, lvivier@redhat.com

Recent rtas-test.c changes added a call to 'be32toh', a function
from the header 'endian.h' in Linux. This caused QEMU Travis build
to break because be32toh is undefined in Mac OS (even using the
machine/endian.h header).

This patch makes a conditional code to include the proper header
file if we're compiling in an __APPLE__ env.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 tests/rtas-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/rtas-test.c b/tests/rtas-test.c
index b3538bf878..511980ad17 100644
--- a/tests/rtas-test.c
+++ b/tests/rtas-test.c
@@ -5,6 +5,17 @@
 #include "libqos/libqos-spapr.h"
 #include "libqos/rtas.h"
 
+#if defined(__APPLE__)
+#    include <libkern/OSByteOrder.h>
+
+#    define be32toh(x) OSSwapBigToHostInt32(x)
+#    define __BYTE_ORDER    BYTE_ORDER
+#    define __BIG_ENDIAN    BIG_ENDIAN
+#    define __LITTLE_ENDIAN LITTLE_ENDIAN
+#else
+#    include <endian.h>
+#endif
+
 #define EVENT_MASK_EPOW (1 << 30)
 #define EVENT_LOG_LEN 2048
 
-- 
2.13.6
