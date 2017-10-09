Received: from eggs.gnu.org ([2001:4830:134:3::10]:54708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gz2-0005qB-5N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gz1-00053C-Bc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gz1-00052q-31
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:11 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:54 +0200
Message-Id: <20171009225623.29232-14-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 13/42] tpm: remove locty argument from
 receive_cb
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

The tpm_state is passed as argument, the assert() is pointless since
we give it the value of tpm_state->locty_number already.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 2 +-
 hw/tpm/tpm_emulator.c        | 3 +--
 hw/tpm/tpm_passthrough.c     | 4 +---
 hw/tpm/tpm_tis.c             | 5 ++---
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 7d7ebfc21d..9c83a512e1 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -30,7 +30,7 @@
 typedef struct TPMBackendClass TPMBackendClass;
 typedef struct TPMBackend TPMBackend;
=20
-typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool selftest_do=
ne);
+typedef void (TPMRecvDataCB)(TPMState *, bool selftest_done);
=20
 struct TPMBackend {
     Object parent;
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index dadc264182..4fe405353a 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -193,8 +193,7 @@ static void tpm_emulator_handle_request(TPMBackend *t=
b)
         error_report_err(err);
     }
=20
-    tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_number,
-                           selftest_done);
+    tb->recv_data_callback(tb->tpm_state, selftest_done);
 }
=20
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index fed3d69799..0ae4596932 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -160,9 +160,7 @@ static void tpm_passthrough_handle_request(TPMBackend=
 *tb)
                                   tb->tpm_state->locty_data,
                                   &selftest_done);
=20
-    tb->recv_data_callback(tb->tpm_state,
-                           tb->tpm_state->locty_number,
-                           selftest_done);
+    tb->recv_data_callback(tb->tpm_state, selftest_done);
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index c54dac32de..345a4fbee5 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -371,14 +371,13 @@ static void tpm_tis_receive_bh(void *opaque)
 /*
  * Callback from the TPM to indicate that the response was received.
  */
-static void tpm_tis_receive_cb(TPMState *s, uint8_t locty,
+static void tpm_tis_receive_cb(TPMState *s,
                                bool is_selftest_done)
 {
     TPMTISEmuState *tis =3D &s->s.tis;
+    uint8_t locty =3D s->locty_number;
     uint8_t l;
=20
-    assert(s->locty_number =3D=3D locty);
-
     if (is_selftest_done) {
         for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
             tis->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
--=20
2.14.1.146.gd35faa819
