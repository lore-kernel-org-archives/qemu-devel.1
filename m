Received: from eggs.gnu.org ([2001:4830:134:3::10]:36247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QA-0d
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAK-0007PK-Ut
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007NR-IL
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI3532113802
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dq0xbg6v4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:47 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-14-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 13/21] tpm: remove locty argument from
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
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The tpm_state is passed as argument, the assert() is pointless since
we give it the value of tpm_state->locty_number already.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_emulator.c        | 3 +--
 hw/tpm/tpm_passthrough.c     | 4 +---
 hw/tpm/tpm_tis.c             | 5 ++---
 include/sysemu/tpm_backend.h | 2 +-
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index a6763e8..8fbe9ad 100644
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
index fed3d69..0ae4596 100644
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
index c54dac3..345a4fb 100644
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
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 7d7ebfc..9c83a51 100644
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
--=20
2.5.5
