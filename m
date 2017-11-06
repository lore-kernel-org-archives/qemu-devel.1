Received: from eggs.gnu.org ([2001:4830:134:3::10]:39793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKB-0007Dg-Vn
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKB-0004p3-6X
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKB-0004ne-0Z
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:43 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:12 +0100
Message-Id: <20171106183925.16747-16-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 15/28] tpm-passthrough: workaround a
 possible race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
---
 hw/tpm/tpm_passthrough.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 788be3847d..73554aa792 100644
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
2.15.0.rc0.40.gaefcc5f6f
