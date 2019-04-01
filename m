Received: from eggs.gnu.org ([209.51.188.92]:42910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB478-0003i5-1o
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB476-0004zT-Iw
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41914
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB476-0004mW-6k
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:05:04 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L4dJ0053632
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:04:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rkrjx58v4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:04:41 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:03:04 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:55 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-82-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 81/97] s390x: Return specification exception
 for unimplemented diag 308 subcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Janosch Frank <frankja@linux.ibm.com>

The architecture specifies specification exceptions for all
unavailable subcodes.

The presence of subcodes is indicated by checking some query subcode.
For example 6 will indicate that 3-6 are available. So future systems
might call new subcodes to check for new features. This should not
trigger a hw error, instead we return the architectured specification
exception.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20190111113657.66195-3-frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit 37dbd1f4d4805edcd18d94eb202bb3461b3cd52d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/s390x/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index acb0f3d4af..aafa740f61 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -130,7 +130,7 @@ out:
         }
         return;
     default:
-        hw_error("Unhandled diag308 subcode %" PRIx64, subcode);
+        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
         break;
     }
 }
-- 
2.17.1
