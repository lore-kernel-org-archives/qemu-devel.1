Received: from eggs.gnu.org ([2001:4830:134:3::10]:47742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WH-0005CI-JI
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WF-0006D0-OQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dt1WF-0006Bz-DW
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:39 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 15 Sep 2017 21:03:28 -0400
Message-Id: <20170916010330.10435-10-jsnow@redhat.com>
In-Reply-To: <20170916010330.10435-1-jsnow@redhat.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/11] AHCI: Rework IRQ constants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

Create a new enum so that we can name the IRQ bits, which will make debug=
ging
them a little nicer if we can print them out. Not handled in this patch, =
but
this will make it possible to get a nice debug printf detailing exactly w=
hich
status bits are set, as it can be multiple at any given time.

As a consequence of this patch, it is no longer possible to set multiple =
IRQ
codes at once, but nothing was utilizing this ability anyway.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170901001502.29915-8-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c          | 49 ++++++++++++++++++++++++++++++++++++++------=
-----
 hw/ide/ahci_internal.h | 44 +++++++++++++++++++++++++++++++++++---------
 hw/ide/trace-events    |  2 +-
 3 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 9d2c8ded..2dfcab9 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -56,6 +56,27 @@ static bool ahci_map_fis_address(AHCIDevice *ad);
 static void ahci_unmap_clb_address(AHCIDevice *ad);
 static void ahci_unmap_fis_address(AHCIDevice *ad);
=20
+static const char *AHCIPortIRQ_lookup[AHCI_PORT_IRQ__COUNT] =3D {
+    [AHCI_PORT_IRQ_BIT_DHRS] =3D "DHRS",
+    [AHCI_PORT_IRQ_BIT_PSS]  =3D "PSS",
+    [AHCI_PORT_IRQ_BIT_DSS]  =3D "DSS",
+    [AHCI_PORT_IRQ_BIT_SDBS] =3D "SDBS",
+    [AHCI_PORT_IRQ_BIT_UFS]  =3D "UFS",
+    [AHCI_PORT_IRQ_BIT_DPS]  =3D "DPS",
+    [AHCI_PORT_IRQ_BIT_PCS]  =3D "PCS",
+    [AHCI_PORT_IRQ_BIT_DMPS] =3D "DMPS",
+    [8 ... 21]               =3D "RESERVED",
+    [AHCI_PORT_IRQ_BIT_PRCS] =3D "PRCS",
+    [AHCI_PORT_IRQ_BIT_IPMS] =3D "IPMS",
+    [AHCI_PORT_IRQ_BIT_OFS]  =3D "OFS",
+    [25]                     =3D "RESERVED",
+    [AHCI_PORT_IRQ_BIT_INFS] =3D "INFS",
+    [AHCI_PORT_IRQ_BIT_IFS]  =3D "IFS",
+    [AHCI_PORT_IRQ_BIT_HBDS] =3D "HBDS",
+    [AHCI_PORT_IRQ_BIT_HBFS] =3D "HBFS",
+    [AHCI_PORT_IRQ_BIT_TFES] =3D "TFES",
+    [AHCI_PORT_IRQ_BIT_CPDS] =3D "CPDS"
+};
=20
 static uint32_t  ahci_port_read(AHCIState *s, int port, int offset)
 {
@@ -170,12 +191,18 @@ static void ahci_check_irq(AHCIState *s)
 }
=20
 static void ahci_trigger_irq(AHCIState *s, AHCIDevice *d,
-                             int irq_type)
+                             enum AHCIPortIRQ irqbit)
 {
-    DPRINTF(d->port_no, "trigger irq %#x -> %x\n",
-            irq_type, d->port_regs.irq_mask & irq_type);
+    g_assert(irqbit >=3D 0 && irqbit < 32);
+    uint32_t irq =3D 1U << irqbit;
+    uint32_t irqstat =3D d->port_regs.irq_stat | irq;
=20
-    d->port_regs.irq_stat |=3D irq_type;
+    trace_ahci_trigger_irq(s, d->port_no,
+                           AHCIPortIRQ_lookup[irqbit], irq,
+                           d->port_regs.irq_stat, irqstat,
+                           irqstat & d->port_regs.irq_mask);
+
+    d->port_regs.irq_stat =3D irqstat;
     ahci_check_irq(s);
 }
=20
@@ -718,7 +745,7 @@ static void ahci_write_fis_sdb(AHCIState *s, NCQTrans=
ferState *ncq_tfs)
=20
     /* Trigger IRQ if interrupt bit is set (which currently, it always i=
s) */
     if (sdb_fis->flags & 0x40) {
-        ahci_trigger_irq(s, ad, PORT_IRQ_SDB_FIS);
+        ahci_trigger_irq(s, ad, AHCI_PORT_IRQ_BIT_SDBS);
     }
 }
=20
@@ -761,10 +788,10 @@ static void ahci_write_fis_pio(AHCIDevice *ad, uint=
16_t len)
         ad->port.ifs[0].status;
=20
     if (pio_fis[2] & ERR_STAT) {
-        ahci_trigger_irq(ad->hba, ad, PORT_IRQ_TF_ERR);
+        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
     }
=20
-    ahci_trigger_irq(ad->hba, ad, PORT_IRQ_PIOS_FIS);
+    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_PSS);
 }
=20
 static bool ahci_write_fis_d2h(AHCIDevice *ad)
@@ -804,10 +831,10 @@ static bool ahci_write_fis_d2h(AHCIDevice *ad)
         ad->port.ifs[0].status;
=20
     if (d2h_fis[2] & ERR_STAT) {
-        ahci_trigger_irq(ad->hba, ad, PORT_IRQ_TF_ERR);
+        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_TFES);
     }
=20
-    ahci_trigger_irq(ad->hba, ad, PORT_IRQ_D2H_REG_FIS);
+    ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_DHRS);
     return true;
 }
=20
@@ -1082,7 +1109,7 @@ static void process_ncq_command(AHCIState *s, int p=
ort, uint8_t *cmd_fis,
                      "is smaller than the requested size (0x%zx)",
                      ncq_tfs->sglist.size, size);
         ncq_err(ncq_tfs);
-        ahci_trigger_irq(ad->hba, ad, PORT_IRQ_OVERFLOW);
+        ahci_trigger_irq(ad->hba, ad, AHCI_PORT_IRQ_BIT_OFS);
         return;
     } else if (ncq_tfs->sglist.size !=3D size) {
         trace_process_ncq_command_large(s, port, tag,
@@ -1225,7 +1252,7 @@ static int handle_cmd(AHCIState *s, int port, uint8=
_t slot)
         trace_handle_cmd_badfis(s, port);
         return -1;
     } else if (cmd_len !=3D 0x80) {
-        ahci_trigger_irq(s, &s->dev[port], PORT_IRQ_HBUS_ERR);
+        ahci_trigger_irq(s, &s->dev[port], AHCI_PORT_IRQ_BIT_HBFS);
         trace_handle_cmd_badmap(s, port, cmd_len);
         goto out;
     }
diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 1e21169..ce2e818 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -91,6 +91,31 @@
 #define PORT_CMD_ISSUE            0x38 /* command issue */
 #define PORT_RESERVED             0x3c /* reserved */
=20
+/* Port interrupt bit descriptors */
+enum AHCIPortIRQ {
+    AHCI_PORT_IRQ_BIT_DHRS =3D 0,
+    AHCI_PORT_IRQ_BIT_PSS  =3D 1,
+    AHCI_PORT_IRQ_BIT_DSS  =3D 2,
+    AHCI_PORT_IRQ_BIT_SDBS =3D 3,
+    AHCI_PORT_IRQ_BIT_UFS  =3D 4,
+    AHCI_PORT_IRQ_BIT_DPS  =3D 5,
+    AHCI_PORT_IRQ_BIT_PCS  =3D 6,
+    AHCI_PORT_IRQ_BIT_DMPS =3D 7,
+    /* RESERVED */
+    AHCI_PORT_IRQ_BIT_PRCS =3D 22,
+    AHCI_PORT_IRQ_BIT_IPMS =3D 23,
+    AHCI_PORT_IRQ_BIT_OFS  =3D 24,
+    /* RESERVED */
+    AHCI_PORT_IRQ_BIT_INFS =3D 26,
+    AHCI_PORT_IRQ_BIT_IFS  =3D 27,
+    AHCI_PORT_IRQ_BIT_HBDS =3D 28,
+    AHCI_PORT_IRQ_BIT_HBFS =3D 29,
+    AHCI_PORT_IRQ_BIT_TFES =3D 30,
+    AHCI_PORT_IRQ_BIT_CPDS =3D 31,
+    AHCI_PORT_IRQ__COUNT   =3D 32
+};
+
+
 /* PORT_IRQ_{STAT,MASK} bits */
 #define PORT_IRQ_COLD_PRES        (1U << 31) /* cold presence detect */
 #define PORT_IRQ_TF_ERR           (1 << 30) /* task file error */
@@ -98,18 +123,19 @@
 #define PORT_IRQ_HBUS_DATA_ERR    (1 << 28) /* host bus data error */
 #define PORT_IRQ_IF_ERR           (1 << 27) /* interface fatal error */
 #define PORT_IRQ_IF_NONFATAL      (1 << 26) /* interface non-fatal error=
 */
+                                            /* reserved */
 #define PORT_IRQ_OVERFLOW         (1 << 24) /* xfer exhausted available =
S/G */
 #define PORT_IRQ_BAD_PMP          (1 << 23) /* incorrect port multiplier=
 */
-
 #define PORT_IRQ_PHYRDY           (1 << 22) /* PhyRdy changed */
-#define PORT_IRQ_DEV_ILCK         (1 << 7) /* device interlock */
-#define PORT_IRQ_CONNECT          (1 << 6) /* port connect change status=
 */
-#define PORT_IRQ_SG_DONE          (1 << 5) /* descriptor processed */
-#define PORT_IRQ_UNK_FIS          (1 << 4) /* unknown FIS rx'd */
-#define PORT_IRQ_SDB_FIS          (1 << 3) /* Set Device Bits FIS rx'd *=
/
-#define PORT_IRQ_DMAS_FIS         (1 << 2) /* DMA Setup FIS rx'd */
-#define PORT_IRQ_PIOS_FIS         (1 << 1) /* PIO Setup FIS rx'd */
-#define PORT_IRQ_D2H_REG_FIS      (1 << 0) /* D2H Register FIS rx'd */
+                                            /* reserved */
+#define PORT_IRQ_DEV_ILCK         (1 << 7)  /* device interlock */
+#define PORT_IRQ_CONNECT          (1 << 6)  /* port connect change statu=
s */
+#define PORT_IRQ_SG_DONE          (1 << 5)  /* descriptor processed */
+#define PORT_IRQ_UNK_FIS          (1 << 4)  /* unknown FIS rx'd */
+#define PORT_IRQ_SDB_FIS          (1 << 3)  /* Set Device Bits FIS rx'd =
*/
+#define PORT_IRQ_DMAS_FIS         (1 << 2)  /* DMA Setup FIS rx'd */
+#define PORT_IRQ_PIOS_FIS         (1 << 1)  /* PIO Setup FIS rx'd */
+#define PORT_IRQ_D2H_REG_FIS      (1 << 0)  /* D2H Register FIS rx'd */
=20
 #define PORT_IRQ_FREEZE           (PORT_IRQ_HBUS_ERR | PORT_IRQ_IF_ERR |=
   \
                                    PORT_IRQ_CONNECT | PORT_IRQ_PHYRDY | =
   \
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 0b61c5d..e15fd77 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -62,7 +62,7 @@ ahci_port_read(void *s, int port, int offset, uint32_t =
ret) "ahci(%p)[%d]: port
 ahci_irq_raise(void *s) "ahci(%p): raise irq"
 ahci_irq_lower(void *s) "ahci(%p): lower irq"
 ahci_check_irq(void *s, uint32_t old, uint32_t new) "ahci(%p): check irq=
 0x%08x --> 0x%08x"
-
+ahci_trigger_irq(void *s, int port, const char *name, uint32_t val, uint=
32_t old, uint32_t new, uint32_t effective) "ahci(%p)[%d]: trigger irq +%=
s (0x%08x); irqstat: 0x%08x --> 0x%08x; effective: 0x%08x"
 ahci_port_write(void *s, int port, int offset, uint32_t val) "ahci(%p)[%=
d]: port write @ 0x%x: 0x%08x"
 ahci_mem_read_32(void *s, uint64_t addr, uint32_t val) "ahci(%p): mem re=
ad @ 0x%"PRIx64": 0x%08x"
 ahci_mem_read(void *s, unsigned size, uint64_t addr, uint64_t val) "ahci=
(%p): read%u @ 0x%"PRIx64": 0x%016"PRIx64
--=20
2.9.5
