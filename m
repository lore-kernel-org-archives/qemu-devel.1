Received: from eggs.gnu.org ([2001:4830:134:3::10]:45131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1exxXt-0001Qu-Nw
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1exxXp-00046Z-PU
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:22:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1exxXp-00045t-JV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:21:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2JGGcRL111016
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 12:21:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gtfk9ujvm-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 12:21:56 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 19 Mar 2018 12:21:54 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 19 Mar 2018 12:21:45 -0400
In-Reply-To: <1521476505-30584-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521476505-30584-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1521476505-30584-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tpm: Set tpmRegValidSts flag to '1' in
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Fix the initialization of the tpmRegValidSts flag and set it to '1'
during device reset without expecting a write to another register.
This seems to also be the default behavior of real hardware.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index d8917cb..114b66e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,8 +145,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
                              beenSeized, 0);
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
                              locAssigned, 1);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
-                             tpmRegValidSts, 1);
             break;
         }
         break;
@@ -210,6 +208,8 @@ static void tpm_crb_reset(void *dev)
 
     tpm_backend_reset(s->tpmbe);
 
+    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                     tpmRegValidSts, 1);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-- 
2.5.5
