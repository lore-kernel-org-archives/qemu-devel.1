Received: from eggs.gnu.org ([2001:4830:134:3::10]:60765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEwqo-000313-Fk
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEwqk-0002An-IQ
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEwqk-0002AB-Aa
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:26 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAFCTFL9052740
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:31:20 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e8jdn9e9g-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:31:20 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 15 Nov 2017 07:31:18 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 07:31:08 -0500
In-Reply-To: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1510749069-22059-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] tpm_tis: Return TPM_VERSION_UNSPEC in case
 of BE failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

In case the backend has a failure, such as the tpm_emulator's CMD_INIT
failing, the TIS goes into failure mode and does not respond to reads
or writes to MMIO registers. In this case we need to prevent the ACPI
table from being added and the straight-forward way is to indicate that
there's no known TPM version being used.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7402528..fec2fc6 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1008,6 +1008,10 @@ TPMVersion tpm_tis_get_tpm_version(Object *obj)
 {
     TPMState *s =3D TPM(obj);
=20
+    if (tpm_backend_had_startup_error(s->be_driver)) {
+        return TPM_VERSION_UNSPEC;
+    }
+
     return tpm_backend_get_tpm_version(s->be_driver);
 }
=20
--=20
2.5.5
