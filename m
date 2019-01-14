Received: from eggs.gnu.org ([209.51.188.92]:59024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gjAp1-0002Az-PA
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:35:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gjAp0-0006Ju-Vh
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:35:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gjAp0-0006Je-Pr
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 17:35:06 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 15 Jan 2019 02:27:49 +0400
Message-Id: <20190114222754.21701-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190114222754.21701-1-marcandre.lureau@redhat.com>
References: <20190114222754.21701-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v17 1/6] tpm: add a "ppi" boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, f4bug@amsat.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

The following patches implement the TPM Physical Presence Interface,
make use of a new memory region and a fw_cfg entry. Enable PPI by
default with >=3D4.0 machine type, to avoid migration issues.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/machine.c | 2 ++
 hw/tpm/tpm_crb.c  | 3 +++
 hw/tpm/tpm_tis.c  | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 95dc7c3913c..92e58c81825 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,6 +28,8 @@ GlobalProperty hw_compat_3_1[] =3D {
     { "pcie-root-port", "x-width", "1" },
     { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "tr=
ue" },
     { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "t=
rue" },
+    { "tpm-crb", "ppi", "false" },
+    { "tpm-tis", "ppi", "false" },
 };
 const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
=20
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index a92dd50437b..d5b0ac5920a 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -41,6 +41,8 @@ typedef struct CRBState {
     MemoryRegion cmdmem;
=20
     size_t be_buffer_size;
+
+    bool ppi_enabled;
 } CRBState;
=20
 #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
@@ -221,6 +223,7 @@ static const VMStateDescription vmstate_tpm_crb =3D {
=20
 static Property tpm_crb_properties[] =3D {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
+    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 2563d7501fc..1698d83cd3f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -81,6 +81,8 @@ typedef struct TPMState {
     TPMVersion be_tpm_version;
=20
     size_t be_buffer_size;
+
+    bool ppi_enabled;
 } TPMState;
=20
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -954,6 +956,7 @@ static const VMStateDescription vmstate_tpm_tis =3D {
 static Property tpm_tis_properties[] =3D {
     DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.20.1.98.gecbdaf0899
