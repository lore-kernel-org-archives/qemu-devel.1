Received: from eggs.gnu.org ([209.51.188.92]:41561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45I-00025a-Gu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB45H-0003t6-Go
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB45H-0003ly-22
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:03:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1piC062060
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:59 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksw4s319-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:59 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:58 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:52 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-79-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 78/97] hw/s390x: Fix bad mask in time2tod()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since "s390x/tcg: avoid overflows in time2tod/tod2time", the
time2tod() function tries to deal with the 9 uppermost bits in the
time value, but uses the wrong mask for this: 0xff80000000000000 should
be used instead of 0xff10000000000000 here.

Fixes: 14055ce53c2d901d826ffad7fb7d6bb8ab46bdfd
Cc: qemu-stable@nongnu.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1544792887-14575-1-git-send-email-thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[CH: tweaked commit message]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
(cherry picked from commit aba7a5a2de3dba5917024df25441f715b9249e31)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/hw/s390x/tod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/s390x/tod.h b/include/hw/s390x/tod.h
index 413c0d7c02..442f45b2f5 100644
--- a/include/hw/s390x/tod.h
+++ b/include/hw/s390x/tod.h
@@ -50,7 +50,7 @@ typedef struct S390TODClass {
 /* Converts ns to s390's clock format */
 static inline uint64_t time2tod(uint64_t ns)
 {
-    return (ns << 9) / 125 + (((ns & 0xff10000000000000ull) / 125) << 9);
+    return (ns << 9) / 125 + (((ns & 0xff80000000000000ull) / 125) << 9);
 }
 
 /* Converts s390's clock format to ns */
-- 
2.17.1
