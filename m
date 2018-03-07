Received: from eggs.gnu.org ([2001:4830:134:3::10]:54470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYK-0003Yz-PL
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1etYYI-0008RS-Q4
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34604
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1etYYI-0008QT-Kf
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:52:14 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w27CpJJP083821
	for <qemu-devel@nongnu.org>; Wed, 7 Mar 2018 07:52:14 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gjejgvu8t-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 07:52:13 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 7 Mar 2018 05:52:12 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  7 Mar 2018 07:51:59 -0500
In-Reply-To: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1520427119-6236-6-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 5/5] tpm: convert tpm_tis.c to use
 trace-events
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

Leave the DEBUG_TIS for more debugging and convert to use if (DEBUG_TIS)
rather than #if DEBUG_TIS where it is being used.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/tpm/tpm_tis.c    | 98 ++++++++++++++++++++++++-----------------------=
------
 hw/tpm/trace-events | 16 +++++++++
 2 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 834eef7..2ac7e74 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -31,6 +31,7 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
+#include "trace.h"
=20
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
@@ -86,12 +87,6 @@ typedef struct TPMState {
=20
 #define DEBUG_TIS 0
=20
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_TIS) { \
-        printf(fmt, ## __VA_ARGS__); \
-    } \
-} while (0)
-
 /* local prototypes */
=20
 static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
@@ -107,19 +102,17 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr ad=
dr)
 static void tpm_tis_show_buffer(const unsigned char *buffer,
                                 size_t buffer_size, const char *string)
 {
-#ifdef DEBUG_TIS
     uint32_t len, i;
=20
     len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
-    DPRINTF("tpm_tis: %s length =3D %d\n", string, len);
+    printf("tpm_tis: %s length =3D %d\n", string, len);
     for (i =3D 0; i < len; i++) {
         if (i && !(i % 16)) {
-            DPRINTF("\n");
+            printf("\n");
         }
-        DPRINTF("%.2X ", buffer[i]);
+        printf("%.2X ", buffer[i]);
     }
-    DPRINTF("\n");
-#endif
+    printf("\n");
 }
=20
 /*
@@ -146,8 +139,10 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t=
 flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
-                        "tpm_tis: To TPM");
+    if (DEBUG_TIS) {
+        tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
+                            "tpm_tis: To TPM");
+    }
=20
     /*
      * rw_offset serves as length indicator for length of data;
@@ -175,7 +170,7 @@ static void tpm_tis_raise_irq(TPMState *s, uint8_t lo=
cty, uint32_t irqmask)
=20
     if ((s->loc[locty].inte & TPM_TIS_INT_ENABLED) &&
         (s->loc[locty].inte & irqmask)) {
-        DPRINTF("tpm_tis: Raising IRQ for flag %08x\n", irqmask);
+        trace_tpm_tis_raise_irq(irqmask);
         qemu_irq_raise(s->irq);
         s->loc[locty].ints |=3D irqmask;
     }
@@ -223,7 +218,7 @@ static void tpm_tis_new_active_locality(TPMState *s, =
uint8_t new_active_locty)
=20
     s->active_locty =3D new_active_locty;
=20
-    DPRINTF("tpm_tis: Active locality is now %d\n", s->active_locty);
+    trace_tpm_tis_new_active_locality(s->active_locty);
=20
     if (TPM_TIS_IS_VALID_LOCTY(new_active_locty)) {
         /* set flags on the new active locality */
@@ -242,7 +237,7 @@ static void tpm_tis_abort(TPMState *s, uint8_t locty)
 {
     s->rw_offset =3D 0;
=20
-    DPRINTF("tpm_tis: tis_abort: new active locality is %d\n", s->next_l=
octy);
+    trace_tpm_tis_abort(s->next_locty);
=20
     /*
      * Need to react differently depending on who's aborting now and
@@ -310,8 +305,10 @@ static void tpm_tis_request_completed(TPMIf *ti, int=
 ret)
     s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
     s->rw_offset =3D 0;
=20
-    tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
-                        "tpm_tis: From TPM");
+    if (DEBUG_TIS) {
+        tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
+                            "tpm_tis: From TPM");
+    }
=20
     if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
         tpm_tis_abort(s, locty);
@@ -339,8 +336,7 @@ static uint32_t tpm_tis_data_read(TPMState *s, uint8_=
t locty)
             tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
             tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
         }
-        DPRINTF("tpm_tis: tpm_tis_data_read byte 0x%02x   [%d]\n",
-                ret, s->rw_offset - 1);
+        trace_tpm_tis_data_read(ret, s->rw_offset - 1);
     }
=20
     return ret;
@@ -364,29 +360,29 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
     hwaddr base =3D addr & ~0xfff;
     TPMState *s =3D opaque;
=20
-    DPRINTF("tpm_tis: active locality      : %d\n"
-            "tpm_tis: state of locality %d : %d\n"
-            "tpm_tis: register dump:\n",
-            s->active_locty,
-            locty, s->loc[locty].state);
+    printf("tpm_tis: active locality      : %d\n"
+           "tpm_tis: state of locality %d : %d\n"
+           "tpm_tis: register dump:\n",
+           s->active_locty,
+           locty, s->loc[locty].state);
=20
     for (idx =3D 0; regs[idx] !=3D 0xfff; idx++) {
-        DPRINTF("tpm_tis: 0x%04x : 0x%08x\n", regs[idx],
-                (int)tpm_tis_mmio_read(opaque, base + regs[idx], 4));
+        printf("tpm_tis: 0x%04x : 0x%08x\n", regs[idx],
+               (int)tpm_tis_mmio_read(opaque, base + regs[idx], 4));
     }
=20
-    DPRINTF("tpm_tis: r/w offset    : %d\n"
-            "tpm_tis: result buffer : ",
-            s->rw_offset);
+    printf("tpm_tis: r/w offset    : %d\n"
+           "tpm_tis: result buffer : ",
+           s->rw_offset);
     for (idx =3D 0;
          idx < MIN(tpm_cmd_get_size(&s->buffer), s->be_buffer_size);
          idx++) {
-        DPRINTF("%c%02x%s",
-                s->rw_offset =3D=3D idx ? '>' : ' ',
-                s->buffer[idx],
-                ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
+        printf("%c%02x%s",
+               s->rw_offset =3D=3D idx ? '>' : ' ',
+               s->buffer[idx],
+               ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 " =
: "");
     }
-    DPRINTF("\n");
+    printf("\n");
 }
 #endif
=20
@@ -506,7 +502,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
         val >>=3D shift;
     }
=20
-    DPRINTF("tpm_tis:  read.%u(%08x) =3D %08x\n", size, (int)addr, (int)=
val);
+    trace_tpm_tis_mmio_read(size, addr, val);
=20
     return val;
 }
@@ -527,10 +523,10 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
     uint16_t len;
     uint32_t mask =3D (size =3D=3D 1) ? 0xff : ((size =3D=3D 2) ? 0xffff=
 : ~0);
=20
-    DPRINTF("tpm_tis: write.%u(%08x) =3D %08x\n", size, (int)addr, (int)=
val);
+    trace_tpm_tis_mmio_write(size, addr, val);
=20
     if (locty =3D=3D 4) {
-        DPRINTF("tpm_tis: Access to locality 4 only allowed from hardwar=
e\n");
+        trace_tpm_tis_mmio_write_locty4();
         return;
     }
=20
@@ -560,20 +556,18 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
         if ((val & TPM_TIS_ACCESS_ACTIVE_LOCALITY)) {
             /* give up locality if currently owned */
             if (s->active_locty =3D=3D locty) {
-                DPRINTF("tpm_tis: Releasing locality %d\n", locty);
+                trace_tpm_tis_mmio_write_release_locty(locty);
=20
                 uint8_t newlocty =3D TPM_TIS_NO_LOCALITY;
                 /* anybody wants the locality ? */
                 for (c =3D TPM_TIS_NUM_LOCALITIES - 1; c >=3D 0; c--) {
                     if ((s->loc[c].access & TPM_TIS_ACCESS_REQUEST_USE))=
 {
-                        DPRINTF("tpm_tis: Locality %d requests use.\n", =
c);
+                        trace_tpm_tis_mmio_write_locty_req_use(c);
                         newlocty =3D c;
                         break;
                     }
                 }
-                DPRINTF("tpm_tis: TPM_TIS_ACCESS_ACTIVE_LOCALITY: "
-                        "Next active locality: %d\n",
-                        newlocty);
+                trace_tpm_tis_mmio_write_next_locty(newlocty);
=20
                 if (TPM_TIS_IS_VALID_LOCTY(newlocty)) {
                     set_new_locty =3D 0;
@@ -627,10 +621,10 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
                 }
=20
                 s->loc[locty].access |=3D TPM_TIS_ACCESS_SEIZE;
-                DPRINTF("tpm_tis: TPM_TIS_ACCESS_SEIZE: "
-                        "Locality %d seized from locality %d\n",
-                        locty, s->active_locty);
-                DPRINTF("tpm_tis: TPM_TIS_ACCESS_SEIZE: Initiating abort=
.\n");
+
+                trace_tpm_tis_mmio_write_locty_seized(locty, s->active_l=
octy);
+                trace_tpm_tis_mmio_write_init_abort();
+
                 set_new_locty =3D 0;
                 tpm_tis_prep_abort(s, s->active_locty, locty);
                 break;
@@ -677,7 +671,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
             s->loc[locty].ints &=3D ~val;
             if (s->loc[locty].ints =3D=3D 0) {
                 qemu_irq_lower(s->irq);
-                DPRINTF("tpm_tis: Lowering IRQ\n");
+                trace_tpm_tis_mmio_write_lowering_irq();
             }
         }
         s->loc[locty].ints &=3D ~(val & TPM_TIS_INTERRUPTS_SUPPORTED);
@@ -725,8 +719,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
             case TPM_TIS_STATE_EXECUTION:
             case TPM_TIS_STATE_RECEPTION:
                 /* abort currently running command */
-                DPRINTF("tpm_tis: %s: Initiating abort.\n",
-                        __func__);
+                trace_tpm_tis_mmio_write_init_abort();
                 tpm_tis_prep_abort(s, locty, locty);
             break;
=20
@@ -780,8 +773,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
             s->loc[locty].state =3D=3D TPM_TIS_STATE_COMPLETION) {
             /* drop the byte */
         } else {
-            DPRINTF("tpm_tis: Data to send to TPM: %08x (size=3D%d)\n",
-                    (int)val, size);
+            trace_tpm_tis_mmio_write_data2send(val, size);
             if (s->loc[locty].state =3D=3D TPM_TIS_STATE_READY) {
                 s->loc[locty].state =3D TPM_TIS_STATE_RECEPTION;
                 tpm_tis_sts_set(&s->loc[locty],
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index fe88fa6..9a65384 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -28,3 +28,19 @@ tpm_emulator_handle_device_opts_tpm2(void) "TPM Versio=
n 2"
 tpm_emulator_handle_device_opts_unspec(void) "TPM Version Unspecified"
 tpm_emulator_handle_device_opts_startup_error(void) "Startup error"
 tpm_emulator_inst_init(void) ""
+
+# hw/tpm/tpm_tis.c
+tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08x"
+tpm_tis_new_active_locality(uint8_t locty) "Active locality is now %d"
+tpm_tis_abort(uint8_t locty) "New active locality is %d"
+tpm_tis_data_read(uint32_t value, uint32_t off) "byte 0x%02x   [%d]"
+tpm_tis_mmio_read(unsigned size, uint32_t addr, uint32_t val)  " read.%u=
(0x%08x) =3D 0x%08x"
+tpm_tis_mmio_write(unsigned size, uint32_t addr, uint32_t val) "write.%u=
(0x%08x) =3D 0x%08x"
+tpm_tis_mmio_write_locty4(void) "Access to locality 4 only allowed from =
hardware"
+tpm_tis_mmio_write_release_locty(uint8_t locty) "Releasing locality %d"
+tpm_tis_mmio_write_locty_req_use(uint8_t locty) "Locality %d requests us=
e"
+tpm_tis_mmio_write_next_locty(uint8_t locty) "Next active locality is %d=
"
+tpm_tis_mmio_write_locty_seized(uint8_t locty, uint8_t active) "Locality=
 %d seized from locality %d"
+tpm_tis_mmio_write_init_abort(void) "Initiating abort"
+tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
+tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to sen=
d to TPM: 0x%08x (size=3D%d)"
--=20
2.5.5
