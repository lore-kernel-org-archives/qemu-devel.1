Received: from eggs.gnu.org ([209.51.188.92]:35506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyn-00081P-TE
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyT-0003Ux-Dx
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyR-0003Pg-9m
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:12 -0500
Date: Tue, 15 Jan 2019 15:06:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-43-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 42/49] tpm: clear RAM when "memory overwrite"
 requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Note: the "Platform Reset Attack Mitigation" specification isn't
explicit about NVDIMM, since they could have different usages. It uses
the term "system memory" generally (and also "volatile memory RAM" in
its introduction). For initial support, I propose to consider
non-volatile memory as not being subject to the memory clear. There is
an on-going discussion in the TCG "pcclientwg" working group for
future revisions.

CPU cache clearing is done unconditionally in edk2 since commit
d20ae95a13e851 (edk2-stable201811).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/tpm/tpm_ppi.h    | 10 ++++++++++
 hw/tpm/tpm_crb.c    |  3 +++
 hw/tpm/tpm_ppi.c    | 22 ++++++++++++++++++++++
 hw/tpm/tpm_tis.c    |  3 +++
 hw/tpm/trace-events |  3 +++
 5 files changed, 41 insertions(+)

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index c5e555fe2c..d33ef27de6 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -33,4 +33,14 @@ typedef struct TPMPPI {
 void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
                   hwaddr addr, Object *obj);
=20
+/**
+ * tpm_ppi_reset:
+ * @tpmppi: a TPMPPI
+ *
+ * Function to call on machine reset. It will check if the "Memory
+ * overwrite" variable is set, and perform a memory clear on volatile
+ * memory if requested.
+ **/
+void tpm_ppi_reset(TPMPPI *tpmppi);
+
 #endif /* TPM_TPM_PPI_H */
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 012ec686d4..3087acc4ab 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -233,6 +233,9 @@ static void tpm_crb_reset(void *dev)
 {
     CRBState *s =3D CRB(dev);
=20
+    if (s->ppi_enabled) {
+        tpm_ppi_reset(&s->ppi);
+    }
     tpm_backend_reset(s->tpmbe);
=20
     memset(s->regs, 0, sizeof(s->regs));
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index cf17779c20..cd8205f212 100644
--- a/hw/tpm/tpm_ppi.c
+++ b/hw/tpm/tpm_ppi.c
@@ -16,8 +16,30 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/memory_mapping.h"
+#include "sysemu/reset.h"
 #include "migration/vmstate.h"
 #include "tpm_ppi.h"
+#include "trace.h"
+
+void tpm_ppi_reset(TPMPPI *tpmppi)
+{
+    if (tpmppi->buf[0x15a /* movv, docs/specs/tpm.txt */] & 0x1) {
+        GuestPhysBlockList guest_phys_blocks;
+        GuestPhysBlock *block;
+
+        guest_phys_blocks_init(&guest_phys_blocks);
+        guest_phys_blocks_append(&guest_phys_blocks);
+        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
+            trace_tpm_ppi_memset(block->host_addr,
+                                 block->target_end - block->target_start=
);
+            memset(block->host_addr, 0,
+                   block->target_end - block->target_start);
+            memory_region_set_dirty(block->mr, 0,
+                                    block->target_end - block->target_st=
art);
+        }
+        guest_phys_blocks_free(&guest_phys_blocks);
+    }
+}
=20
 void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
                   hwaddr addr, Object *obj)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 02d9d5c911..fd6bb9b59a 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -872,6 +872,9 @@ static void tpm_tis_reset(DeviceState *dev)
     s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);
=20
+    if (s->ppi_enabled) {
+        tpm_ppi_reset(&s->ppi);
+    }
     tpm_backend_reset(s->be_driver);
=20
     s->active_locty =3D TPM_TIS_NO_LOCALITY;
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 25bee0cecf..920d32ad55 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "Initiating abort"
 tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
 tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to sen=
d to TPM: 0x%08x (size=3D%d)"
 tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offse=
t =3D %u"
+
+# hw/tpm/tpm_ppi.c
+tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
--=20
MST
