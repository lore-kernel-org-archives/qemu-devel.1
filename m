Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzB-0005zh-Qi
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gz8-00056x-Ow
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gz8-00056W-JI
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:18 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:56 +0200
Message-Id: <20171009225623.29232-16-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 15/42] tpm-emulator: fix error handling
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

The previous patch cleaned up a bit error handling, and exposed an
existing bug: error_report_err() could be called with a NULL error.
Instead, make tpm_emulator_set_locality() set the error.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_emulator.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 788ab9876d..25a6258c10 100644
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
2.14.1.146.gd35faa819
