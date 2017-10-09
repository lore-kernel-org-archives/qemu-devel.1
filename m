Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzB-0005zg-QY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzA-000594-VQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzA-00057X-JU
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:20 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:57 +0200
Message-Id: <20171009225623.29232-17-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 16/42] tpm: remove locty_data from TPMState
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

Keep it internal to tpm-tis instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_int.h      |  2 --
 hw/tpm/tpm_emulator.c |  3 +--
 hw/tpm/tpm_tis.c      | 12 +++++-------
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 6d7b3dc850..252c4082ef 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -24,8 +24,6 @@ struct TPMState {
         TPMTISEmuState tis;
     } s;
=20
-    uint8_t     locty_number;
-    TPMLocality *locty_data;
     TPMBackendCmd cmd;
=20
     char *backend;
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 25a6258c10..407ac97651 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -180,8 +180,7 @@ static void tpm_emulator_handle_request(TPMBackend *t=
b, TPMBackendCmd *cmd)
=20
     DPRINTF("processing TPM command");
=20
-    if (tpm_emulator_set_locality(tpm_emu,
-                                  tb->tpm_state->locty_number, &err) < 0=
) {
+    if (tpm_emulator_set_locality(tpm_emu, cmd->locty, &err) < 0) {
         goto error;
     }
=20
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index ffed7bfaf9..ad2845622e 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -203,12 +203,10 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_=
t flags)
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
     TPMTISEmuState *tis =3D &s->s.tis;
+    TPMLocality *locty_data =3D &tis->loc[locty];
=20
     tpm_tis_show_buffer(&tis->loc[locty].w_buffer, "tpm_tis: To TPM");
=20
-    s->locty_number =3D locty;
-    s->locty_data =3D &tis->loc[locty];
-
     /*
      * w_offset serves as length indicator for length of data;
      * it's reset when the response comes back
@@ -217,10 +215,10 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t l=
octy)
=20
     s->cmd =3D (TPMBackendCmd) {
         .locty =3D locty,
-        .in =3D s->locty_data->w_buffer.buffer,
-        .in_len =3D s->locty_data->w_offset,
-        .out =3D s->locty_data->r_buffer.buffer,
-        .out_len =3D s->locty_data->r_buffer.size
+        .in =3D locty_data->w_buffer.buffer,
+        .in_len =3D locty_data->w_offset,
+        .out =3D locty_data->r_buffer.buffer,
+        .out_len =3D locty_data->r_buffer.size
     };
=20
     tpm_backend_deliver_request(s->be_driver, &s->cmd);
--=20
2.14.1.146.gd35faa819
