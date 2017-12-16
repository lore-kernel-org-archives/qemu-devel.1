Received: from eggs.gnu.org ([2001:4830:134:3::10]:45931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTj-000635-Cy
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTf-0008UX-C3
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45830
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTf-0008Ty-63
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdUdn134491
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:22 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ew0h5k70f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:22 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:21 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:32 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-16-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 15/32] tpm-passthrough: workaround a possible
 race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The TPM backend processing thread has common shared variable race
issues. (they should not be so easy to reach since guest interaction
with the device is slow compared to host emulation)

An obvious one is setting op_cancelled from device thread after
calling write(cancel_fd). The backend thread may return before the
device thread has set the variable. Instead set it before
cancellation. Even if the write() failed, the end result is command
get possibly cancelled (even if cancellation came from external
sources it doesn't matter much).

It's worth to consider removing the backend processing thread for now.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 788be38..73554aa 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -89,6 +89,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruStat=
e *tpm_pt,
     bool is_selftest;
     const struct tpm_resp_hdr *hdr;
=20
+    /* FIXME: protect shared variables or use other sync mechanism */
     tpm_pt->tpm_op_canceled =3D false;
     tpm_pt->tpm_executing =3D true;
     *selftest_done =3D false;
@@ -178,12 +179,11 @@ static void tpm_passthrough_cancel_cmd(TPMBackend *=
tb)
      */
     if (tpm_pt->tpm_executing) {
         if (tpm_pt->cancel_fd >=3D 0) {
+            tpm_pt->tpm_op_canceled =3D true;
             n =3D write(tpm_pt->cancel_fd, "-", 1);
             if (n !=3D 1) {
                 error_report("Canceling TPM command failed: %s",
                              strerror(errno));
-            } else {
-                tpm_pt->tpm_op_canceled =3D true;
             }
         } else {
             error_report("Cannot cancel TPM command due to missing "
--=20
2.5.5
