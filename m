Received: from eggs.gnu.org ([2001:4830:134:3::10]:38022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPMo-0006wv-2t
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fMPMl-0001aV-0o
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33912
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fMPMk-0001Zv-O8
	for qemu-devel@nongnu.org; Fri, 25 May 2018 22:55:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4Q2sBm7016422
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:55:34 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j6t3aguhd-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 22:55:33 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 25 May 2018 22:55:33 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 25 May 2018 22:55:18 -0400
In-Reply-To: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
References: <20180526025520.3298441-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180526025520.3298441-3-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v4 2/4] tpm: extend TPM TIS with state migration
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM TIS interface with state migration support.

We need to synchronize with the backend thread to make sure that a comman=
d
being processed by the external TPM emulator has completed and its
response been received.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c    | 52 +++++++++++++++++++++++++++++++++++++++++++++++=
+++--
 hw/tpm/trace-events |  1 +
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 2ac7e74307..12f5c9a759 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -894,9 +894,57 @@ static void tpm_tis_reset(DeviceState *dev)
     tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
 }
=20
+/* persistent state handling */
+
+static int tpm_tis_pre_save(void *opaque)
+{
+    TPMState *s =3D opaque;
+    uint8_t locty =3D s->active_locty;
+
+    trace_tpm_tis_pre_save(locty, s->rw_offset);
+
+    if (DEBUG_TIS) {
+        tpm_tis_dump_state(opaque, 0);
+    }
+
+    /*
+     * Synchronize with backend completion.
+     */
+    tpm_backend_finish_sync(s->be_driver);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_locty =3D {
+    .name =3D "tpm-tis/locty",
+    .version_id =3D 0,
+    .fields      =3D (VMStateField[]) {
+        VMSTATE_UINT32(state, TPMLocality),
+        VMSTATE_UINT32(inte, TPMLocality),
+        VMSTATE_UINT32(ints, TPMLocality),
+        VMSTATE_UINT8(access, TPMLocality),
+        VMSTATE_UINT32(sts, TPMLocality),
+        VMSTATE_UINT32(iface_id, TPMLocality),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis =3D {
-    .name =3D "tpm",
-    .unmigratable =3D 1,
+    .name =3D "tpm-tis",
+    .version_id =3D 0,
+    .pre_save  =3D tpm_tis_pre_save,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_BUFFER(buffer, TPMState),
+        VMSTATE_UINT16(rw_offset, TPMState),
+        VMSTATE_UINT8(active_locty, TPMState),
+        VMSTATE_UINT8(aborting_locty, TPMState),
+        VMSTATE_UINT8(next_locty, TPMState),
+
+        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 0,
+                             vmstate_locty, TPMLocality),
+
+        VMSTATE_END_OF_LIST()
+    }
 };
=20
 static Property tpm_tis_properties[] =3D {
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index c5bfbf1d4b..25bee0cecf 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -50,3 +50,4 @@ tpm_tis_mmio_write_locty_seized(uint8_t locty, uint8_t =
active) "Locality %d seiz
 tpm_tis_mmio_write_init_abort(void) "Initiating abort"
 tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
 tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to sen=
d to TPM: 0x%08x (size=3D%d)"
+tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offse=
t =3D %u"
--=20
2.14.3
