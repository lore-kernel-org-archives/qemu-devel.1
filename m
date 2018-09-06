Received: from eggs.gnu.org ([2001:4830:134:3::10]:37341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxkzv-00056g-KT
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fxkzs-0003qQ-9r
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:30:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fxkzm-0003kw-FZ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 23:30:14 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  6 Sep 2018 07:29:45 +0400
Message-Id: <20180906032949.13753-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180906032949.13753-1-marcandre.lureau@redhat.com>
References: <20180906032949.13753-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v11 2/6] tpm: add a "ppi" boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The following patches implement the TPM Physical Presence Interface,
make use of a new memory region and a fw_cfg entry. Enable PPI by
default with >3.0 machine type, to avoid migration issues.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/compat.h | 11 ++++++++++-
 hw/tpm/tpm_crb.c    |  3 +++
 hw/tpm/tpm_tis.c    |  3 +++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/compat.h b/include/hw/compat.h
index 6f4d5fc647..8098a62744 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -2,7 +2,16 @@
 #define HW_COMPAT_H
=20
 #define HW_COMPAT_3_0 \
-    /* empty */
+    {\
+        .driver   =3D "tpm-crb",\
+        .property =3D "ppi",\
+        .value    =3D "false",\
+    },\
+    {\
+        .driver   =3D "tpm-tis",\
+        .property =3D "ppi",\
+        .value    =3D "false",\
+    },
=20
 #define HW_COMPAT_2_12 \
     {\
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index a92dd50437..d5b0ac5920 100644
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
index 12f5c9a759..d9ddf9b723 100644
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
@@ -950,6 +952,7 @@ static const VMStateDescription vmstate_tpm_tis =3D {
 static Property tpm_tis_properties[] =3D {
     DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
+    DEFINE_PROP_BOOL("ppi", TPMState, ppi_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.19.0.rc1
