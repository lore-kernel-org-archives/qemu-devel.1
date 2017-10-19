Received: from eggs.gnu.org ([2001:4830:134:3::10]:36356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAS-0007S3-Br
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAL-0007QP-B7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAL-0007OQ-1i
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI2bAV112697
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:32 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dq0xbg6w7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:30 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:49 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-16-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 15/21] tpm-emulator: fix error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The previous patch cleaned up a bit error handling, and exposed an
existing bug: error_report_err() could be called with a NULL error.
Instead, make tpm_emulator_set_locality() set the error.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 0b1a99f..a613cec 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -141,7 +141,8 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm=
_emu,
     return 0;
 }
=20
-static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty=
_number)
+static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t locty=
_number,
+                                     Error **errp)
 {
     ptm_loc loc;
=20
@@ -155,15 +156,15 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number)
     loc.u.req.loc =3D locty_number;
     if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc)) < 0) {
-        error_report("tpm-emulator: could not set locality : %s",
-                     strerror(errno));
+        error_setg(errp, "tpm-emulator: could not set locality : %s",
+                   strerror(errno));
         return -1;
     }
=20
     loc.u.resp.tpm_result =3D be32_to_cpu(loc.u.resp.tpm_result);
     if (loc.u.resp.tpm_result !=3D 0) {
-        error_report("tpm-emulator: TPM result for set locality : 0x%x",
-                     loc.u.resp.tpm_result);
+        error_setg(errp, "tpm-emulator: TPM result for set locality : 0x=
%x",
+                   loc.u.resp.tpm_result);
         return -1;
     }
=20
@@ -179,7 +180,8 @@ static void tpm_emulator_handle_request(TPMBackend *t=
b, TPMBackendCmd *cmd)
=20
     DPRINTF("processing TPM command");
=20
-    if (tpm_emulator_set_locality(tpm_emu, tb->tpm_state->locty_number) =
< 0) {
+    if (tpm_emulator_set_locality(tpm_emu,
+                                  tb->tpm_state->locty_number, &err) < 0=
) {
         goto error;
     }
=20
--=20
2.5.5
