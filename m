Received: from eggs.gnu.org ([2001:4830:134:3::10]:43950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAQ-0003Sd-Qr
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAP-0000H5-Pr
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38486
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAP-0000Gy-K0
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2SKwfxa007171
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:32 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h0fa580pb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:32 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 28 Mar 2018 14:59:31 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 16:59:20 -0400
In-Reply-To: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1522270761-29646-4-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 3/4] tpm: CRB: Enforce locality is requested
 before processing buffer
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

Section 5.5.3.2.2 of the CRB specs states that use of the TPM
through the localty control method must first be requested,
otherwise TPM commands will be dropped. This patch makes sure
that the current locality is the active locality and only then
sends off the command for processing.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index ee6c87e..520e74e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -76,6 +76,8 @@ enum crb_cancel {
     CRB_CANCEL_INVOKE = BIT(0),
 };
 
+#define TPM_CRB_NO_LOCALITY 0xff
+
 static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
@@ -95,10 +97,18 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
     return val;
 }
 
+static uint8_t tpm_crb_get_active_locty(CRBState *s)
+{
+    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned))
+         return TPM_CRB_NO_LOCALITY;
+    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
+}
+
 static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
     CRBState *s = CRB(opaque);
+    uint8_t locty =  addr >> 12;
 
     trace_tpm_crb_mmio_write(addr, size, val);
 
@@ -123,7 +133,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         break;
     case A_CRB_CTRL_START:
         if (val == CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
+            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
+            tpm_crb_get_active_locty(s) == locty) {
             void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
             s->regs[R_CRB_CTRL_START] |= CRB_START_INVOKE;
-- 
2.5.5
