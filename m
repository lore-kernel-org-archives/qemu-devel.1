Received: from eggs.gnu.org ([2001:4830:134:3::10]:42520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfO-0006Mv-PO
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfL-0006ia-IX
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfL-0006hp-9N
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2U090jb025299
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:10 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h18nmum96-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:10 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Mar 2018 18:13:09 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Mar 2018 20:12:57 -0400
In-Reply-To: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1522368777-32742-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 4/4] tests: Tests more flags of the CRB
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Test and modify more flags of the CRB interface.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/tpm-crb-test.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
index e1513cb..d8f9569 100644
--- a/tests/tpm-crb-test.c
+++ b/tests/tpm-crb-test.c
@@ -28,6 +28,10 @@ static void tpm_crb_test(const void *data)
     uint64_t caddr =3D readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
     uint32_t rsize =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
     uint64_t raddr =3D readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+    uint8_t locstate =3D readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
+    uint32_t locctrl =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL);
+    uint32_t locsts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
+    uint32_t sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
=20
     g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), =3D=3D=
, 1);
     g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), =3D=
=3D, 1);
@@ -45,9 +49,47 @@ static void tpm_crb_test(const void *data)
     g_assert_cmpint(caddr, >, TPM_CRB_ADDR_BASE);
     g_assert_cmpint(raddr, >, TPM_CRB_ADDR_BASE);
=20
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished),=
 =3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), =3D=
=3D, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality),=
 =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), =3D=3D=
, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts),=
 =3D=3D, 1);
+
+    g_assert_cmpint(locctrl, =3D=3D, 0);
+
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), =3D=3D, 0)=
;
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), =3D=3D,=
 0);
+
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
+
+    /* request access to locality 0 */
+    writeb(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 1);
+
+    /* granted bit must be set now */
+    locsts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, Granted), =3D=3D, 1)=
;
+    g_assert_cmpint(FIELD_EX32(locsts, CRB_LOC_STS, beenSeized), =3D=3D,=
 0);
+
+    /* we must have an assigned locality */
+    locstate =3D readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished),=
 =3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), =3D=
=3D, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality),=
 =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), =3D=3D=
, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts),=
 =3D=3D, 1);
+
+    /* set into ready state */
+    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 1);
+
+    /* TPM must not be in the idle state */
+    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
+
     memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
=20
-    uint32_t sts, start =3D 1;
+    uint32_t start =3D 1;
     uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECON=
D;
     writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
     do {
@@ -58,12 +100,40 @@ static void tpm_crb_test(const void *data)
     } while (g_get_monotonic_time() < end_time);
     start =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
     g_assert_cmpint(start & 1, =3D=3D, 0);
+
+    /* TPM must still not be in the idle state */
     sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
-    g_assert_cmpint(sts & 1, =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
=20
     struct tpm_hdr tpm_msg;
     memread(raddr, &tpm_msg, sizeof(tpm_msg));
     g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tp=
m_msg));
+
+    /* set TPM into idle state */
+    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ, 2);
+
+    /* idle state must be indicated now */
+    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmIdle), =3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_CTRL_STS, tpmSts), =3D=3D, 0);
+
+    /* relinquish locality */
+    writel(TPM_CRB_ADDR_BASE + A_CRB_LOC_CTRL, 2);
+
+    /* Granted flag must be cleared */
+    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_LOC_STS);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, Granted), =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(sts, CRB_LOC_STS, beenSeized), =3D=3D, 0)=
;
+
+    /* no locality may be assigned */
+    locstate =3D readb(TPM_CRB_ADDR_BASE + A_CRB_LOC_STATE);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmEstablished),=
 =3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, locAssigned), =3D=
=3D, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, activeLocality),=
 =3D=3D, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, reserved), =3D=3D=
, 0);
+    g_assert_cmpint(FIELD_EX32(locstate, CRB_LOC_STATE, tpmRegValidSts),=
 =3D=3D, 1);
+
 }
=20
 int main(int argc, char **argv)
--=20
2.5.5
