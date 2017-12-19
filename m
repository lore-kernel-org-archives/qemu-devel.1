Received: from eggs.gnu.org ([2001:4830:134:3::10]:47426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eRDGA-0002C4-Id
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eRDG6-0004s0-N9
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:28:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eRDG6-0004rd-FF
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 03:28:18 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBJ8RikG126950
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 03:28:15 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2exy9bg0m1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 03:28:14 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 19 Dec 2017 08:28:11 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Dec 2017 09:28:07 +0100
Message-Id: <20171219082807.84494-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/sclp: fixup highest CPU address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

the highest cpu address is not the same as max_cpus. max_cpus
counts from 1 while the cpu address starts at 0.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
---
 hw/s390x/sclp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9be0cb80ad..21351ffffc 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -67,7 +67,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
     prepare_cpu_entries(sclp, read_info->entries, &cpu_count);
     read_info->entries_cpu = cpu_to_be16(cpu_count);
     read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
-    read_info->highest_cpu = cpu_to_be16(max_cpus);
+    read_info->highest_cpu = cpu_to_be16(max_cpus - 1);
 
     read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
 
-- 
2.13.4
