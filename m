Received: from eggs.gnu.org ([2001:4830:134:3::10]:42527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfQ-0006Qm-Nv
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfN-0006lK-Hk
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=0627a78234=stefanb@linux.vnet.ibm.com>)
	id 1f1hfN-0006kq-9J
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 20:13:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2U0AAmh101423
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:10 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h18er44vp-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 20:13:09 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 29 Mar 2018 18:13:09 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 29 Mar 2018 20:12:56 -0400
In-Reply-To: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1522368777-32742-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1522368777-32742-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 3/4] tpm: CRB: Enforce locality is requested
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
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

Section 5.5.3.2.2 of the CRB specs states that use of the TPM
through the localty control method must first be requested,
otherwise the command will be dropped.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index ee6c87e..a92dd50 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -76,6 +76,8 @@ enum crb_cancel {
     CRB_CANCEL_INVOKE =3D BIT(0),
 };
=20
+#define TPM_CRB_NO_LOCALITY 0xff
+
 static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
@@ -95,10 +97,19 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwadd=
r addr,
     return val;
 }
=20
+static uint8_t tpm_crb_get_active_locty(CRBState *s)
+{
+    if (!ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, locAssigned)) {
+        return TPM_CRB_NO_LOCALITY;
+    }
+    return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
+}
+
 static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
     CRBState *s =3D CRB(opaque);
+    uint8_t locty =3D  addr >> 12;
=20
     trace_tpm_crb_mmio_write(addr, size, val);
=20
@@ -123,7 +134,8 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
         break;
     case A_CRB_CTRL_START:
         if (val =3D=3D CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
+            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
+            tpm_crb_get_active_locty(s) =3D=3D locty) {
             void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
=20
             s->regs[R_CRB_CTRL_START] |=3D CRB_START_INVOKE;
--=20
2.5.5
