Received: from eggs.gnu.org ([2001:4830:134:3::10]:48695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCza-0005gP-9y
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCzS-0004ul-C6
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCzR-0004sU-UY
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:28:26 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 02:26:48 +0400
Message-Id: <20181212222648.595-7-marcandre.lureau@redhat.com>
In-Reply-To: <20181212222648.595-1-marcandre.lureau@redhat.com>
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 6/6] tpm: clear RAM when "memory overwrite"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, f4bug@amsat.org, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
---
 hw/tpm/tpm_ppi.h    | 10 ++++++++++
 hw/tpm/tpm_crb.c    |  1 +
 hw/tpm/tpm_ppi.c    | 22 ++++++++++++++++++++++
 hw/tpm/tpm_tis.c    |  1 +
 hw/tpm/trace-events |  3 +++
 5 files changed, 37 insertions(+)

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
index 1598e28262..0b4a5adcf8 100644
--- a/hw/tpm/tpm_ppi.h
+++ b/hw/tpm/tpm_ppi.h
@@ -34,4 +34,14 @@ typedef struct TPMPPI {
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
index 012ec686d4..663469bd20 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
 {
     CRBState *s =3D CRB(dev);
=20
+    tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->tpmbe);
=20
     memset(s->regs, 0, sizeof(s->regs));
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
index cf17779c20..914762c014 100644
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
+    if (tpmppi->buf[TPM_PPI_MOVV_OFFSET] & 0x1) {
+        GuestPhysBlockList guest_phys_blocks;
+        GuestPhysBlock *block;
+
+        guest_phys_blocks_init(&guest_phys_blocks);
+        guest_phys_blocks_append(&guest_phys_blocks);
+        QTAILQ_FOREACH(block, &guest_phys_blocks.head, next) {
+            trace_tpm_ppi_memset(block->host_addr,
+                             block->target_end - block->target_start);
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
index da8af8e0e0..225c675302 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -868,6 +868,7 @@ static void tpm_tis_reset(DeviceState *dev)
     s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);
=20
+    tpm_ppi_reset(&s->ppi);
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
2.20.0
