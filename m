Received: from eggs.gnu.org ([2001:4830:134:3::10]:43973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAV-0003V9-NM
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAR-0000Hc-BG
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0625704796=stefanb@linux.vnet.ibm.com>)
	id 1f1IAR-0000HD-2J
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:59:35 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2SKx8MQ011127
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:33 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h0gf955nn-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 16:59:33 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 28 Mar 2018 14:59:32 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 28 Mar 2018 16:59:21 -0400
In-Reply-To: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522270761-29646-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1522270761-29646-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 4/4] tests: Tests more flags of the CRB
 interface
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

Test and modify more flags of the CRB interface.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/tpm-crb-test.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
index e1513cb..d8f9569 100644
--- a/tests/tpm-crb-test.c
+++ b/tests/tpm-crb-test.c
@@ -28,6 +28,10 @@ static void tpm_crb_test(const void *data)
     uint64_t caddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
     uint32_t rsize = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
     uint64_t raddr = readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint8_t locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
+    uint32_t locctrl = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
+    uint32_t locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
+    uint32_t sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
 
     g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), ==, 1);
     g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), ==, 1);
@@ -45,9 +49,47 @@ static void tpm_crb_test(const void *data)
     g_assert_cmpint(caddr, >, TPM_CRB_ADDR_BASE);
     g_assert_cmpint(raddr, >, TPM_CRB_ADDR_BASE);
 
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
+
+    g_assert_cmpint(locctrl, ==, 0);
+
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
+
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
+    /* request access to locality 0 */
+    writeb(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+
+    /* granted bit must be set now */
+    locsts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), ==, 0);
+
+    /* we must have an assigned locality */
+    locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
+
+    /* set into ready state */
+    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 1);
+
+    /* TPM must not be in the idle state */
+    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
     memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
 
-    uint32_t sts, start = 1;
+    uint32_t start = 1;
     uint64_t end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
     writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
     do {
@@ -58,12 +100,40 @@ static void tpm_crb_test(const void *data)
     } while (g_get_monotonic_time() < end_time);
     start = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
     g_assert_cmpint(start & 1, ==, 0);
+
+    /* TPM must still not be in the idle state */
     sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(sts & 1, ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
 
     struct tpm_hdr tpm_msg;
     memread(raddr, &tpm_msg, sizeof(tpm_msg));
     g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm_msg));
+
+    /* set TPM into idle state */
+    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 2);
+
+    /* idle state must be indicated now */
+    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), ==, 1);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), ==, 0);
+
+    /* relinquish locality */
+    writel(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 2);
+
+    /* Granted flag must be cleared */
+    sts = readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), ==, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), ==, 0);
+
+    /* no locality may be assigned */
+    locstate = readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished), ==, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), ==, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts), ==, 1);
+
 }
 
 int main(int argc, char **argv)
-- 
2.5.5
