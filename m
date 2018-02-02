Received: from eggs.gnu.org ([2001:4830:134:3::10]:36261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ehcXF-00078u-PI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ehcXA-00010H-TI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59096
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ehcXA-00010C-Nh
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:41:44 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w129d17S066003
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 04:42:47 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvm79utqn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 04:42:46 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 2 Feb 2018 09:42:45 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri,  2 Feb 2018 09:42:41 +0000
Message-Id: <20180202094241.59537-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] s390x/sclp: fix event mask handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, qemu-stable@nongnu.org

commit 67915de9f038 ("s390x/event-facility: variable-length event
masks") switches the sclp receive/send mask. This broke the sclp
lm console.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length event masks")
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org
---
 hw/s390x/event-facility.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index b0f71f4554..155a69467b 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
     ef->receive_mask = be32_to_cpu(tmp_mask);
 
     /* return the SCLP's capability masks to the guest */
-    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
+    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
     copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
               mask_length, sizeof(tmp_mask));
-    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
+    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
     copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
               mask_length, sizeof(tmp_mask));
 
-- 
2.14.3
