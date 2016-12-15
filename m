Received: from eggs.gnu.org ([2001:4830:134:3::10]:42108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBd-0001xm-Mf
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBa-00015z-Uc
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57462
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBa-00015c-Nw
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:14 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0ha7F007033
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:14 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm611kb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:13 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:13 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:09 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-16-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 15/67] scsi: mptconfig: fix misuse of
 MPTSAS_CONFIG_PACK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

These issues cause respectively a QEMU crash and a leak of 2 bytes of
stack.  They were discovered by VictorV of 360 Marvel Team.

Reported-by: Tom Victor <i-tangtianwen@360.cm>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 65a8e1f6413a0f6f79894da710b5d6d43361d27d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/scsi/mptconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 3e4f400..87a416a 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -203,7 +203,7 @@ size_t mptsas_config_manufacturing_1(MPTSASState *s, uint8_t **data, int address
 {
     /* VPD - all zeros */
     return MPTSAS_CONFIG_PACK(1, MPI_CONFIG_PAGETYPE_MANUFACTURING, 0x00,
-                              "s256");
+                              "*s256");
 }
 
 static
@@ -328,7 +328,7 @@ size_t mptsas_config_ioc_0(MPTSASState *s, uint8_t **data, int address)
     return MPTSAS_CONFIG_PACK(0, MPI_CONFIG_PAGETYPE_IOC, 0x01,
                               "*l*lwwb*b*b*blww",
                               pcic->vendor_id, pcic->device_id, pcic->revision,
-                              pcic->subsystem_vendor_id,
+                              pcic->class_id, pcic->subsystem_vendor_id,
                               pcic->subsystem_id);
 }
 
-- 
1.9.1
