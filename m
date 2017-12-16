Received: from eggs.gnu.org ([2001:4830:134:3::10]:46169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGUE-0006ZT-1a
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGUA-0000Wm-4W
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55134
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGU9-0000Vh-VJ
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:54 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdVRl122750
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:49 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew0c7bcba-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:49 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:48 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:49 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-33-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 32/32] tpm: tpm_passthrough: Fail startup if
 FE buffer size < BE buffer size
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

If the requested buffer size of the frontend is smaller than the fixed
buffer size of the host's TPM, fail the startup_tpm() interface function,
which will make the device unusable. We fail it because the backend TPM
could produce larger packets than what the frontend could pass to the OS.

The current combination of TIS frontend and either passthrough or emulato=
r
backend will not lead to this case since the TIS can support any size of
buffer.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_passthrough.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 886af9e..487aae2 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -304,6 +304,20 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *=
opts)
     return TPM_BACKEND(obj);
 }
=20
+static int tpm_passthrough_startup_tpm(TPMBackend *tb, size_t buffersize=
)
+{
+    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
+
+    if (buffersize && buffersize < tpm_pt->tpm_buffersize) {
+        error_report("Requested buffer size of %zu is smaller than host =
TPM's "
+                     "fixed buffer size of %zu",
+                     buffersize, tpm_pt->tpm_buffersize);
+        return -1;
+    }
+
+    return 0;
+}
+
 static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
 {
     TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);
@@ -362,6 +376,7 @@ static void tpm_passthrough_class_init(ObjectClass *k=
lass, void *data)
     tbc->opts =3D tpm_passthrough_cmdline_opts;
     tbc->desc =3D "Passthrough TPM backend driver";
     tbc->create =3D tpm_passthrough_create;
+    tbc->startup_tpm =3D tpm_passthrough_startup_tpm;
     tbc->reset =3D tpm_passthrough_reset;
     tbc->cancel_cmd =3D tpm_passthrough_cancel_cmd;
     tbc->get_tpm_established_flag =3D tpm_passthrough_get_tpm_establishe=
d_flag;
--=20
2.5.5
