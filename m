Received: from eggs.gnu.org ([2001:4830:134:3::10]:41744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkI-00014t-5G
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkD-0000er-6E
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53408
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSTkD-0000ee-1G
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:37 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMKETMY017432
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:36 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2f17h0u20m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:36 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 13:16:35 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 15:16:18 -0500
In-Reply-To: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513973785-14427-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 03/10] tpm_tis: limit size of buffer from
 backend
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

This is a preparatory patch for the subsequent ones where we
get rid of the flexibility of supporting any kind of buffer size
that the backend may support. We keep the size at 4096, which is
also the size the external emulator supports. So, limit the size
of the buffer we can support and pass it back to the backend.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index ac5f51f..a6e2f6e 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1012,7 +1012,8 @@ static void tpm_tis_reset(DeviceState *dev)
     int c;
=20
     s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
-    s->be_buffer_size =3D tpm_backend_get_buffer_size(s->be_driver);
+    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
+                            TPM_TIS_BUFFER_MAX);
=20
     tpm_backend_reset(s->be_driver);
=20
@@ -1044,7 +1045,7 @@ static void tpm_tis_reset(DeviceState *dev)
         tpm_tis_realloc_buffer(&s->loc[c].r_buffer, s->be_buffer_size);
     }
=20
-    tpm_tis_do_startup_tpm(s, 0);
+    tpm_tis_do_startup_tpm(s, s->be_buffer_size);
 }
=20
 static const VMStateDescription vmstate_tpm_tis =3D {
--=20
2.5.5
