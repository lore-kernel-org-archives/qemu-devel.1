Received: from eggs.gnu.org ([2001:4830:134:3::10]:52027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXB-0002V0-KS
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycX8-0008Dm-Vq
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eycX8-0008DX-PV
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:07:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LC7ZZE004163
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:07:58 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gup8mtc9j-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:07:57 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 08:07:56 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 08:07:48 -0400
In-Reply-To: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1521634071-16519-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 1/4] tpm: CRB: Set tpmRegValidSts flag to '1'
 in device reset
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

Fix the initialization of the tpmRegValidSts flag and set it to '1'
during device reset without expecting a write to another register.
This seems to also be the default behavior of real hardware.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index d8917cb..114b66e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -145,8 +145,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr a=
ddr,
                              beenSeized, 0);
             ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
                              locAssigned, 1);
-            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
-                             tpmRegValidSts, 1);
             break;
         }
         break;
@@ -210,6 +208,8 @@ static void tpm_crb_reset(void *dev)
=20
     tpm_backend_reset(s->tpmbe);
=20
+    ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                     tpmRegValidSts, 1);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
--=20
2.5.5
