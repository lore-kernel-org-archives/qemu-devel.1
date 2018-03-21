Received: from eggs.gnu.org ([2001:4830:134:3::10]:52083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXL-0002fm-Hu
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eycXF-0008HE-T2
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41320
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eycXF-0008Gr-Nj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:08:05 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2LC7oRA046663
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:08:05 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gun4kwjsh-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 08:08:01 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 21 Mar 2018 08:07:55 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 08:07:51 -0400
In-Reply-To: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521634071-16519-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1521634071-16519-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 4/4] tpm: CRB: query backend for TPM
 established flag
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

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index e8c42f6..ef8b80e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -84,6 +84,12 @@ static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr=
 addr,
     unsigned offset =3D addr & 3;
     uint32_t val =3D *(uint32_t *)regs >> (8 * offset);
=20
+    switch (addr) {
+    case A_CRB_LOC_STATE:
+        val |=3D !tpm_backend_get_tpm_established_flag(s->tpmbe);
+        break;
+    }
+
     trace_tpm_crb_mmio_read(addr, size, val);
=20
     return val;
--=20
2.5.5
