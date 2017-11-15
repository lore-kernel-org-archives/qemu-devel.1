Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEwqo-000311-FS
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eEwqk-0002B2-QP
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59236
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eEwqk-0002Ac-Kn
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 07:31:26 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAFCScHu008208
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:31:20 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e8mdpuny1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 07:31:19 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 15 Nov 2017 07:31:19 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 15 Nov 2017 07:31:07 -0500
In-Reply-To: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510749069-22059-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1510749069-22059-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/4] tpm-emulator: protect concurrent ctrl_chr
 access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The control chardev is being used from the data thread to set the
locality of the next request. Altough the chr has a write mutex, we
may potentially read the reply from another thread request.

Add a mutex to protect from concurrent control commands.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c | 44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 9aaec8e..e1a6810 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -71,15 +71,21 @@ typedef struct TPMEmulator {
     ptm_cap caps; /* capabilities of the TPM */
     uint8_t cur_locty_number; /* last set locality */
     Error *migration_blocker;
+
+    QemuMutex mutex;
 } TPMEmulator;
=20
=20
-static int tpm_emulator_ctrlcmd(CharBackend *dev, unsigned long cmd, voi=
d *msg,
+static int tpm_emulator_ctrlcmd(TPMEmulator *tpm, unsigned long cmd, voi=
d *msg,
                                 size_t msg_len_in, size_t msg_len_out)
 {
+    CharBackend *dev =3D &tpm->ctrl_chr;
     uint32_t cmd_no =3D cpu_to_be32(cmd);
     ssize_t n =3D sizeof(uint32_t) + msg_len_in;
     uint8_t *buf =3D NULL;
+    int ret =3D -1;
+
+    qemu_mutex_lock(&tpm->mutex);
=20
     buf =3D g_alloca(n);
     memcpy(buf, &cmd_no, sizeof(cmd_no));
@@ -87,17 +93,21 @@ static int tpm_emulator_ctrlcmd(CharBackend *dev, uns=
igned long cmd, void *msg,
=20
     n =3D qemu_chr_fe_write_all(dev, buf, n);
     if (n <=3D 0) {
-        return -1;
+        goto end;
     }
=20
     if (msg_len_out !=3D 0) {
         n =3D qemu_chr_fe_read_all(dev, msg, msg_len_out);
         if (n <=3D 0) {
-            return -1;
+            goto end;
         }
     }
=20
-    return 0;
+    ret =3D 0;
+
+end:
+    qemu_mutex_unlock(&tpm->mutex);
+    return ret;
 }
=20
 static int tpm_emulator_unix_tx_bufs(TPMEmulator *tpm_emu,
@@ -154,7 +164,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
_emu, uint8_t locty_number,
=20
     DPRINTF("setting locality : 0x%x", locty_number);
     loc.u.req.loc =3D locty_number;
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_LOCALITY, &loc,
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_LOCALITY, &loc,
                              sizeof(loc), sizeof(loc)) < 0) {
         error_setg(errp, "tpm-emulator: could not set locality : %s",
                    strerror(errno));
@@ -202,8 +212,8 @@ error:
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
 {
     DPRINTF("%s", __func__);
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_CAPABILITY,
-                         &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) < 0) =
{
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_CAPABILITY,
+                             &tpm_emu->caps, 0, sizeof(tpm_emu->caps)) <=
 0) {
         error_report("tpm-emulator: probing failed : %s", strerror(errno=
));
         return -1;
     }
@@ -254,8 +264,8 @@ static int tpm_emulator_startup_tpm(TPMBackend *tb)
     ptm_res res;
=20
     DPRINTF("%s", __func__);
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_INIT, &init, sizeof=
(init),
-                         sizeof(init)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_INIT, &init, sizeof(init),
+                             sizeof(init)) < 0) {
         error_report("tpm-emulator: could not send INIT: %s",
                      strerror(errno));
         goto err_exit;
@@ -278,7 +288,7 @@ static bool tpm_emulator_get_tpm_established_flag(TPM=
Backend *tb)
     ptm_est est;
=20
     DPRINTF("%s", __func__);
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLISHED,=
 &est,
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
                              0, sizeof(est)) < 0) {
         error_report("tpm-emulator: Could not get the TPM established fl=
ag: %s",
                      strerror(errno));
@@ -302,7 +312,7 @@ static int tpm_emulator_reset_tpm_established_flag(TP=
MBackend *tb,
     }
=20
     reset_est.u.req.loc =3D tpm_emu->cur_locty_number;
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_RESET_TPMESTABLISHE=
D,
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_RESET_TPMESTABLISHED,
                              &reset_est, sizeof(reset_est),
                              sizeof(reset_est)) < 0) {
         error_report("tpm-emulator: Could not reset the establishment bi=
t: %s",
@@ -330,7 +340,7 @@ static void tpm_emulator_cancel_cmd(TPMBackend *tb)
         return;
     }
=20
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_CANCEL_TPM_CMD, &re=
s, 0,
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_CANCEL_TPM_CMD, &res, 0,
                              sizeof(res)) < 0) {
         error_report("tpm-emulator: Could not cancel command: %s",
                      strerror(errno));
@@ -378,8 +388,8 @@ static int tpm_emulator_prepare_data_fd(TPMEmulator *=
tpm_emu)
=20
     qemu_chr_fe_set_msgfds(&tpm_emu->ctrl_chr, fds + 1, 1);
=20
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_DATAFD, &res, 0=
,
-                    sizeof(res)) || res !=3D 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SET_DATAFD, &res, 0,
+                             sizeof(res)) < 0 || res !=3D 0) {
         error_report("tpm-emulator: Failed to send CMD_SET_DATAFD: %s",
                      strerror(errno));
         goto err_exit;
@@ -501,6 +511,7 @@ static void tpm_emulator_inst_init(Object *obj)
     DPRINTF("%s", __func__);
     tpm_emu->options =3D g_new0(TPMEmulatorOptions, 1);
     tpm_emu->cur_locty_number =3D ~0;
+    qemu_mutex_init(&tpm_emu->mutex);
 }
=20
 /*
@@ -510,8 +521,7 @@ static void tpm_emulator_shutdown(TPMEmulator *tpm_em=
u)
 {
     ptm_res res;
=20
-    if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SHUTDOWN, &res, 0,
-                             sizeof(res)) < 0) {
+    if (tpm_emulator_ctrlcmd(tpm_emu, CMD_SHUTDOWN, &res, 0, sizeof(res)=
) < 0) {
         error_report("tpm-emulator: Could not cleanly shutdown the TPM: =
%s",
                      strerror(errno));
     } else if (res !=3D 0) {
@@ -536,6 +546,8 @@ static void tpm_emulator_inst_finalize(Object *obj)
         migrate_del_blocker(tpm_emu->migration_blocker);
         error_free(tpm_emu->migration_blocker);
     }
+
+    qemu_mutex_destroy(&tpm_emu->mutex);
 }
=20
 static void tpm_emulator_class_init(ObjectClass *klass, void *data)
--=20
2.5.5
