Received: from eggs.gnu.org ([2001:4830:134:3::10]:41724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkH-00014f-41
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eSTkC-0000eL-53
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eSTkB-0000do-SF
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 15:16:36 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBMKGCmO068448
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:34 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2f13bygqd0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Dec 2017 15:16:33 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 22 Dec 2017 13:16:33 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 22 Dec 2017 15:16:16 -0500
In-Reply-To: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513973785-14427-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 01/10] tpm_emulator: Add a caching layer for
 the TPM Established flag
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

Add a caching layer for the TPM established flag so that we don't
need to go to the emulator every time the flag is read by accessing
the REG_ACCESS register.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 38b6f17..35c78de 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -72,6 +72,9 @@ typedef struct TPMEmulator {
     Error *migration_blocker;
=20
     QemuMutex mutex;
+
+    unsigned int established_flag:1;
+    unsigned int established_flag_cached:1;
 } TPMEmulator;
=20
=20
@@ -349,16 +352,22 @@ static bool tpm_emulator_get_tpm_established_flag(T=
PMBackend *tb)
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
     ptm_est est;
=20
-    DPRINTF("%s", __func__);
+    if (tpm_emu->established_flag_cached) {
+        return tpm_emu->established_flag;
+    }
+
     if (tpm_emulator_ctrlcmd(tpm_emu, CMD_GET_TPMESTABLISHED, &est,
                              0, sizeof(est)) < 0) {
         error_report("tpm-emulator: Could not get the TPM established fl=
ag: %s",
                      strerror(errno));
         return false;
     }
-    DPRINTF("established flag: %0x", est.u.resp.bit);
+    DPRINTF("got established flag: %0x", est.u.resp.bit);
+
+    tpm_emu->established_flag_cached =3D 1;
+    tpm_emu->established_flag =3D (est.u.resp.bit !=3D 0);
=20
-    return (est.u.resp.bit !=3D 0);
+    return tpm_emu->established_flag;
 }
=20
 static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
@@ -389,6 +398,8 @@ static int tpm_emulator_reset_tpm_established_flag(TP=
MBackend *tb,
         return -1;
     }
=20
+    tpm_emu->established_flag_cached =3D 0;
+
     return 0;
 }
=20
--=20
2.5.5
