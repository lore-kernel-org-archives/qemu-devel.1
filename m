Received: from eggs.gnu.org ([2001:4830:134:3::10]:54907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzN-00068Q-Mz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzK-0005Ch-NA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzK-0005CL-Ay
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:00 +0200
Message-Id: <20171009225623.29232-20-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 19/42] tpm-tis: fold TPMTISEmuState in TPMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_tis.c | 336 ++++++++++++++++++++++++++-----------------------=
------
 1 file changed, 157 insertions(+), 179 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 73cda41dc6..d84eec48b4 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -72,7 +72,10 @@ typedef struct TPMLocality {
     TPMSizedBuffer r_buffer;
 } TPMLocality;
=20
-typedef struct TPMTISEmuState {
+struct TPMState {
+    ISADevice busdev;
+    MemoryRegion mmio;
+
     QEMUBH *bh;
     uint32_t offset;
     uint8_t buf[TPM_TIS_BUFFER_MAX];
@@ -85,15 +88,6 @@ typedef struct TPMTISEmuState {
=20
     qemu_irq irq;
     uint32_t irq_num;
-} TPMTISEmuState;
-
-struct TPMState {
-    ISADevice busdev;
-    MemoryRegion mmio;
-
-    union {
-        TPMTISEmuState tis;
-    } s;
=20
     uint8_t     locty_number;
     TPMBackendCmd cmd;
@@ -272,16 +266,15 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_=
t flags)
  */
 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
-    TPMLocality *locty_data =3D &tis->loc[locty];
+    TPMLocality *locty_data =3D &s->loc[locty];
=20
-    tpm_tis_show_buffer(&tis->loc[locty].w_buffer, "tpm_tis: To TPM");
+    tpm_tis_show_buffer(&s->loc[locty].w_buffer, "tpm_tis: To TPM");
=20
     /*
      * w_offset serves as length indicator for length of data;
      * it's reset when the response comes back
      */
-    tis->loc[locty].state =3D TPM_TIS_STATE_EXECUTION;
+    s->loc[locty].state =3D TPM_TIS_STATE_EXECUTION;
=20
     s->cmd =3D (TPMBackendCmd) {
         .locty =3D locty,
@@ -297,17 +290,15 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t l=
octy)
 /* raise an interrupt if allowed */
 static void tpm_tis_raise_irq(TPMState *s, uint8_t locty, uint32_t irqma=
sk)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
-
     if (!TPM_TIS_IS_VALID_LOCTY(locty)) {
         return;
     }
=20
-    if ((tis->loc[locty].inte & TPM_TIS_INT_ENABLED) &&
-        (tis->loc[locty].inte & irqmask)) {
+    if ((s->loc[locty].inte & TPM_TIS_INT_ENABLED) &&
+        (s->loc[locty].inte & irqmask)) {
         DPRINTF("tpm_tis: Raising IRQ for flag %08x\n", irqmask);
-        qemu_irq_raise(s->s.tis.irq);
-        tis->loc[locty].ints |=3D irqmask;
+        qemu_irq_raise(s->irq);
+        s->loc[locty].ints |=3D irqmask;
     }
 }
=20
@@ -319,7 +310,7 @@ static uint32_t tpm_tis_check_request_use_except(TPMS=
tate *s, uint8_t locty)
         if (l =3D=3D locty) {
             continue;
         }
-        if ((s->s.tis.loc[l].access & TPM_TIS_ACCESS_REQUEST_USE)) {
+        if ((s->loc[l].access & TPM_TIS_ACCESS_REQUEST_USE)) {
             return 1;
         }
     }
@@ -329,14 +320,13 @@ static uint32_t tpm_tis_check_request_use_except(TP=
MState *s, uint8_t locty)
=20
 static void tpm_tis_new_active_locality(TPMState *s, uint8_t new_active_=
locty)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
-    bool change =3D (s->s.tis.active_locty !=3D new_active_locty);
+    bool change =3D (s->active_locty !=3D new_active_locty);
     bool is_seize;
     uint8_t mask;
=20
-    if (change && TPM_TIS_IS_VALID_LOCTY(s->s.tis.active_locty)) {
+    if (change && TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
         is_seize =3D TPM_TIS_IS_VALID_LOCTY(new_active_locty) &&
-                   tis->loc[new_active_locty].access & TPM_TIS_ACCESS_SE=
IZE;
+                   s->loc[new_active_locty].access & TPM_TIS_ACCESS_SEIZ=
E;
=20
         if (is_seize) {
             mask =3D ~(TPM_TIS_ACCESS_ACTIVE_LOCALITY);
@@ -345,73 +335,70 @@ static void tpm_tis_new_active_locality(TPMState *s=
, uint8_t new_active_locty)
                      TPM_TIS_ACCESS_REQUEST_USE);
         }
         /* reset flags on the old active locality */
-        tis->loc[s->s.tis.active_locty].access &=3D mask;
+        s->loc[s->active_locty].access &=3D mask;
=20
         if (is_seize) {
-            tis->loc[tis->active_locty].access |=3D TPM_TIS_ACCESS_BEEN_=
SEIZED;
+            s->loc[s->active_locty].access |=3D TPM_TIS_ACCESS_BEEN_SEIZ=
ED;
         }
     }
=20
-    tis->active_locty =3D new_active_locty;
+    s->active_locty =3D new_active_locty;
=20
-    DPRINTF("tpm_tis: Active locality is now %d\n", s->s.tis.active_loct=
y);
+    DPRINTF("tpm_tis: Active locality is now %d\n", s->active_locty);
=20
     if (TPM_TIS_IS_VALID_LOCTY(new_active_locty)) {
         /* set flags on the new active locality */
-        tis->loc[new_active_locty].access |=3D TPM_TIS_ACCESS_ACTIVE_LOC=
ALITY;
-        tis->loc[new_active_locty].access &=3D ~(TPM_TIS_ACCESS_REQUEST_=
USE |
+        s->loc[new_active_locty].access |=3D TPM_TIS_ACCESS_ACTIVE_LOCAL=
ITY;
+        s->loc[new_active_locty].access &=3D ~(TPM_TIS_ACCESS_REQUEST_US=
E |
                                                TPM_TIS_ACCESS_SEIZE);
     }
=20
     if (change) {
-        tpm_tis_raise_irq(s, tis->active_locty, TPM_TIS_INT_LOCALITY_CHA=
NGED);
+        tpm_tis_raise_irq(s, s->active_locty, TPM_TIS_INT_LOCALITY_CHANG=
ED);
     }
 }
=20
 /* abort -- this function switches the locality */
 static void tpm_tis_abort(TPMState *s, uint8_t locty)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
-
-    tis->loc[locty].r_offset =3D 0;
-    tis->loc[locty].w_offset =3D 0;
+    s->loc[locty].r_offset =3D 0;
+    s->loc[locty].w_offset =3D 0;
=20
-    DPRINTF("tpm_tis: tis_abort: new active locality is %d\n", tis->next=
_locty);
+    DPRINTF("tpm_tis: tis_abort: new active locality is %d\n", s->next_l=
octy);
=20
     /*
      * Need to react differently depending on who's aborting now and
      * which locality will become active afterwards.
      */
-    if (tis->aborting_locty =3D=3D tis->next_locty) {
-        tis->loc[tis->aborting_locty].state =3D TPM_TIS_STATE_READY;
-        tpm_tis_sts_set(&tis->loc[tis->aborting_locty],
+    if (s->aborting_locty =3D=3D s->next_locty) {
+        s->loc[s->aborting_locty].state =3D TPM_TIS_STATE_READY;
+        tpm_tis_sts_set(&s->loc[s->aborting_locty],
                         TPM_TIS_STS_COMMAND_READY);
-        tpm_tis_raise_irq(s, tis->aborting_locty, TPM_TIS_INT_COMMAND_RE=
ADY);
+        tpm_tis_raise_irq(s, s->aborting_locty, TPM_TIS_INT_COMMAND_READ=
Y);
     }
=20
     /* locality after abort is another one than the current one */
-    tpm_tis_new_active_locality(s, tis->next_locty);
+    tpm_tis_new_active_locality(s, s->next_locty);
=20
-    tis->next_locty =3D TPM_TIS_NO_LOCALITY;
+    s->next_locty =3D TPM_TIS_NO_LOCALITY;
     /* nobody's aborting a command anymore */
-    tis->aborting_locty =3D TPM_TIS_NO_LOCALITY;
+    s->aborting_locty =3D TPM_TIS_NO_LOCALITY;
 }
=20
 /* prepare aborting current command */
 static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlo=
cty)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
     uint8_t busy_locty;
=20
-    tis->aborting_locty =3D locty;
-    tis->next_locty =3D newlocty;  /* locality after successful abort */
+    s->aborting_locty =3D locty;
+    s->next_locty =3D newlocty;  /* locality after successful abort */
=20
     /*
      * only abort a command using an interrupt if currently executing
      * a command AND if there's a valid connection to the vTPM.
      */
     for (busy_locty =3D 0; busy_locty < TPM_TIS_NUM_LOCALITIES; busy_loc=
ty++) {
-        if (tis->loc[busy_locty].state =3D=3D TPM_TIS_STATE_EXECUTION) {
+        if (s->loc[busy_locty].state =3D=3D TPM_TIS_STATE_EXECUTION) {
             /*
              * request the backend to cancel. Some backends may not
              * support it
@@ -427,16 +414,15 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t=
 locty, uint8_t newlocty)
 static void tpm_tis_receive_bh(void *opaque)
 {
     TPMState *s =3D opaque;
-    TPMTISEmuState *tis =3D &s->s.tis;
     uint8_t locty =3D s->cmd.locty;
=20
-    tpm_tis_sts_set(&tis->loc[locty],
+    tpm_tis_sts_set(&s->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
-    tis->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
-    tis->loc[locty].r_offset =3D 0;
-    tis->loc[locty].w_offset =3D 0;
+    s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
+    s->loc[locty].r_offset =3D 0;
+    s->loc[locty].w_offset =3D 0;
=20
-    if (TPM_TIS_IS_VALID_LOCTY(tis->next_locty)) {
+    if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
         tpm_tis_abort(s, locty);
     }
=20
@@ -449,18 +435,17 @@ static void tpm_tis_receive_bh(void *opaque)
  */
 static void tpm_tis_receive_cb(TPMState *s)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
     bool is_selftest_done =3D s->cmd.selftest_done;
     uint8_t locty =3D s->cmd.locty;
     uint8_t l;
=20
     if (is_selftest_done) {
         for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
-            tis->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
+            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
         }
     }
=20
-    qemu_bh_schedule(tis->bh);
+    qemu_bh_schedule(s->bh);
 }
=20
 /*
@@ -468,21 +453,20 @@ static void tpm_tis_receive_cb(TPMState *s)
  */
 static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
 {
-    TPMTISEmuState *tis =3D &s->s.tis;
     uint32_t ret =3D TPM_TIS_NO_DATA_BYTE;
     uint16_t len;
=20
-    if ((tis->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
-        len =3D tpm_tis_get_size_from_buffer(&tis->loc[locty].r_buffer);
+    if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
+        len =3D tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer);
=20
-        ret =3D tis->loc[locty].r_buffer.buffer[tis->loc[locty].r_offset=
++];
-        if (tis->loc[locty].r_offset >=3D len) {
+        ret =3D s->loc[locty].r_buffer.buffer[s->loc[locty].r_offset++];
+        if (s->loc[locty].r_offset >=3D len) {
             /* got last byte */
-            tpm_tis_sts_set(&tis->loc[locty], TPM_TIS_STS_VALID);
+            tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
             tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
         }
         DPRINTF("tpm_tis: tpm_tis_data_read byte 0x%02x   [%d]\n",
-                ret, tis->loc[locty].r_offset-1);
+                ret, s->loc[locty].r_offset - 1);
     }
=20
     return ret;
@@ -505,13 +489,12 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
     uint8_t locty =3D tpm_tis_locality_from_addr(addr);
     hwaddr base =3D addr & ~0xfff;
     TPMState *s =3D opaque;
-    TPMTISEmuState *tis =3D &s->s.tis;
=20
     DPRINTF("tpm_tis: active locality      : %d\n"
             "tpm_tis: state of locality %d : %d\n"
             "tpm_tis: register dump:\n",
-            tis->active_locty,
-            locty, tis->loc[locty].state);
+            s->active_locty,
+            locty, s->loc[locty].state);
=20
     for (idx =3D 0; regs[idx] !=3D 0xfff; idx++) {
         DPRINTF("tpm_tis: 0x%04x : 0x%08x\n", regs[idx],
@@ -520,25 +503,25 @@ static void tpm_tis_dump_state(void *opaque, hwaddr=
 addr)
=20
     DPRINTF("tpm_tis: read offset   : %d\n"
             "tpm_tis: result buffer : ",
-            tis->loc[locty].r_offset);
+            s->loc[locty].r_offset);
     for (idx =3D 0;
-         idx < tpm_tis_get_size_from_buffer(&tis->loc[locty].r_buffer);
+         idx < tpm_tis_get_size_from_buffer(&s->loc[locty].r_buffer);
          idx++) {
         DPRINTF("%c%02x%s",
-                tis->loc[locty].r_offset =3D=3D idx ? '>' : ' ',
-                tis->loc[locty].r_buffer.buffer[idx],
+                s->loc[locty].r_offset =3D=3D idx ? '>' : ' ',
+                s->loc[locty].r_buffer.buffer[idx],
                 ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
     }
     DPRINTF("\n"
             "tpm_tis: write offset  : %d\n"
             "tpm_tis: request buffer: ",
-            tis->loc[locty].w_offset);
+            s->loc[locty].w_offset);
     for (idx =3D 0;
-         idx < tpm_tis_get_size_from_buffer(&tis->loc[locty].w_buffer);
+         idx < tpm_tis_get_size_from_buffer(&s->loc[locty].w_buffer);
          idx++) {
         DPRINTF("%c%02x%s",
-                tis->loc[locty].w_offset =3D=3D idx ? '>' : ' ',
-                tis->loc[locty].w_buffer.buffer[idx],
+                s->loc[locty].w_offset =3D=3D idx ? '>' : ' ',
+                s->loc[locty].w_buffer.buffer[idx],
                 ((idx & 0xf) =3D=3D 0xf) ? "\ntpm_tis:                 "=
 : "");
     }
     DPRINTF("\n");
@@ -553,7 +536,6 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
                                   unsigned size)
 {
     TPMState *s =3D opaque;
-    TPMTISEmuState *tis =3D &s->s.tis;
     uint16_t offset =3D addr & 0xffc;
     uint8_t shift =3D (addr & 0x3) * 8;
     uint32_t val =3D 0xffffffff;
@@ -568,7 +550,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
     switch (offset) {
     case TPM_TIS_REG_ACCESS:
         /* never show the SEIZE flag even though we use it internally */
-        val =3D tis->loc[locty].access & ~TPM_TIS_ACCESS_SEIZE;
+        val =3D s->loc[locty].access & ~TPM_TIS_ACCESS_SEIZE;
         /* the pending flag is always calculated */
         if (tpm_tis_check_request_use_except(s, locty)) {
             val |=3D TPM_TIS_ACCESS_PENDING_REQUEST;
@@ -576,13 +558,13 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
         val |=3D !tpm_backend_get_tpm_established_flag(s->be_driver);
         break;
     case TPM_TIS_REG_INT_ENABLE:
-        val =3D tis->loc[locty].inte;
+        val =3D s->loc[locty].inte;
         break;
     case TPM_TIS_REG_INT_VECTOR:
-        val =3D tis->irq_num;
+        val =3D s->irq_num;
         break;
     case TPM_TIS_REG_INT_STATUS:
-        val =3D tis->loc[locty].ints;
+        val =3D s->loc[locty].ints;
         break;
     case TPM_TIS_REG_INTF_CAPABILITY:
         switch (s->be_tpm_version) {
@@ -598,14 +580,14 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
         }
         break;
     case TPM_TIS_REG_STS:
-        if (tis->active_locty =3D=3D locty) {
-            if ((tis->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
+        if (s->active_locty =3D=3D locty) {
+            if ((s->loc[locty].sts & TPM_TIS_STS_DATA_AVAILABLE)) {
                 val =3D TPM_TIS_BURST_COUNT(
-                       tpm_tis_get_size_from_buffer(&tis->loc[locty].r_b=
uffer)
-                       - tis->loc[locty].r_offset) | tis->loc[locty].sts=
;
+                       tpm_tis_get_size_from_buffer(&s->loc[locty].r_buf=
fer)
+                       - s->loc[locty].r_offset) | s->loc[locty].sts;
             } else {
-                avail =3D tis->loc[locty].w_buffer.size
-                        - tis->loc[locty].w_offset;
+                avail =3D s->loc[locty].w_buffer.size
+                        - s->loc[locty].w_offset;
                 /*
                  * byte-sized reads should not return 0x00 for 0x100
                  * available bytes.
@@ -613,13 +595,13 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwa=
ddr addr,
                 if (size =3D=3D 1 && avail > 0xff) {
                     avail =3D 0xff;
                 }
-                val =3D TPM_TIS_BURST_COUNT(avail) | tis->loc[locty].sts=
;
+                val =3D TPM_TIS_BURST_COUNT(avail) | s->loc[locty].sts;
             }
         }
         break;
     case TPM_TIS_REG_DATA_FIFO:
     case TPM_TIS_REG_DATA_XFIFO ... TPM_TIS_REG_DATA_XFIFO_END:
-        if (tis->active_locty =3D=3D locty) {
+        if (s->active_locty =3D=3D locty) {
             if (size > 4 - (addr & 0x3)) {
                 /* prevent access beyond FIFO */
                 size =3D 4 - (addr & 0x3);
@@ -627,7 +609,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
             val =3D 0;
             shift =3D 0;
             while (size > 0) {
-                switch (tis->loc[locty].state) {
+                switch (s->loc[locty].state) {
                 case TPM_TIS_STATE_COMPLETION:
                     v =3D tpm_tis_data_read(s, locty);
                     break;
@@ -643,7 +625,7 @@ static uint64_t tpm_tis_mmio_read(void *opaque, hwadd=
r addr,
         }
         break;
     case TPM_TIS_REG_INTERFACE_ID:
-        val =3D tis->loc[locty].iface_id;
+        val =3D s->loc[locty].iface_id;
         break;
     case TPM_TIS_REG_DID_VID:
         val =3D (TPM_TIS_TPM_DID << 16) | TPM_TIS_TPM_VID;
@@ -675,7 +657,6 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
                                uint64_t val, unsigned size)
 {
     TPMState *s =3D opaque;
-    TPMTISEmuState *tis =3D &s->s.tis;
     uint16_t off =3D addr & 0xffc;
     uint8_t shift =3D (addr & 0x3) * 8;
     uint8_t locty =3D tpm_tis_locality_from_addr(addr);
@@ -712,17 +693,17 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
                      TPM_TIS_ACCESS_ACTIVE_LOCALITY);
         }
=20
-        active_locty =3D tis->active_locty;
+        active_locty =3D s->active_locty;
=20
         if ((val & TPM_TIS_ACCESS_ACTIVE_LOCALITY)) {
             /* give up locality if currently owned */
-            if (tis->active_locty =3D=3D locty) {
+            if (s->active_locty =3D=3D locty) {
                 DPRINTF("tpm_tis: Releasing locality %d\n", locty);
=20
                 uint8_t newlocty =3D TPM_TIS_NO_LOCALITY;
                 /* anybody wants the locality ? */
                 for (c =3D TPM_TIS_NUM_LOCALITIES - 1; c >=3D 0; c--) {
-                    if ((tis->loc[c].access & TPM_TIS_ACCESS_REQUEST_USE=
)) {
+                    if ((s->loc[c].access & TPM_TIS_ACCESS_REQUEST_USE))=
 {
                         DPRINTF("tpm_tis: Locality %d requests use.\n", =
c);
                         newlocty =3D c;
                         break;
@@ -740,12 +721,12 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
                 }
             } else {
                 /* not currently the owner; clear a pending request */
-                tis->loc[locty].access &=3D ~TPM_TIS_ACCESS_REQUEST_USE;
+                s->loc[locty].access &=3D ~TPM_TIS_ACCESS_REQUEST_USE;
             }
         }
=20
         if ((val & TPM_TIS_ACCESS_BEEN_SEIZED)) {
-            tis->loc[locty].access &=3D ~TPM_TIS_ACCESS_BEEN_SEIZED;
+            s->loc[locty].access &=3D ~TPM_TIS_ACCESS_BEEN_SEIZED;
         }
=20
         if ((val & TPM_TIS_ACCESS_SEIZE)) {
@@ -756,19 +737,19 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
              * allow seize for requesting locality if no locality is
              * active
              */
-            while ((TPM_TIS_IS_VALID_LOCTY(tis->active_locty) &&
-                    locty > tis->active_locty) ||
-                    !TPM_TIS_IS_VALID_LOCTY(tis->active_locty)) {
+            while ((TPM_TIS_IS_VALID_LOCTY(s->active_locty) &&
+                    locty > s->active_locty) ||
+                    !TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
                 bool higher_seize =3D FALSE;
=20
                 /* already a pending SEIZE ? */
-                if ((tis->loc[locty].access & TPM_TIS_ACCESS_SEIZE)) {
+                if ((s->loc[locty].access & TPM_TIS_ACCESS_SEIZE)) {
                     break;
                 }
=20
                 /* check for ongoing seize by a higher locality */
                 for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES; l++) {
-                    if ((tis->loc[l].access & TPM_TIS_ACCESS_SEIZE)) {
+                    if ((s->loc[l].access & TPM_TIS_ACCESS_SEIZE)) {
                         higher_seize =3D TRUE;
                         break;
                     }
@@ -780,24 +761,24 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
=20
                 /* cancel any seize by a lower locality */
                 for (l =3D 0; l < locty - 1; l++) {
-                    tis->loc[l].access &=3D ~TPM_TIS_ACCESS_SEIZE;
+                    s->loc[l].access &=3D ~TPM_TIS_ACCESS_SEIZE;
                 }
=20
-                tis->loc[locty].access |=3D TPM_TIS_ACCESS_SEIZE;
+                s->loc[locty].access |=3D TPM_TIS_ACCESS_SEIZE;
                 DPRINTF("tpm_tis: TPM_TIS_ACCESS_SEIZE: "
                         "Locality %d seized from locality %d\n",
-                        locty, tis->active_locty);
+                        locty, s->active_locty);
                 DPRINTF("tpm_tis: TPM_TIS_ACCESS_SEIZE: Initiating abort=
.\n");
                 set_new_locty =3D 0;
-                tpm_tis_prep_abort(s, tis->active_locty, locty);
+                tpm_tis_prep_abort(s, s->active_locty, locty);
                 break;
             }
         }
=20
         if ((val & TPM_TIS_ACCESS_REQUEST_USE)) {
-            if (tis->active_locty !=3D locty) {
-                if (TPM_TIS_IS_VALID_LOCTY(tis->active_locty)) {
-                    tis->loc[locty].access |=3D TPM_TIS_ACCESS_REQUEST_U=
SE;
+            if (s->active_locty !=3D locty) {
+                if (TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
+                    s->loc[locty].access |=3D TPM_TIS_ACCESS_REQUEST_USE=
;
                 } else {
                     /* no locality active -> make this one active now */
                     active_locty =3D locty;
@@ -811,12 +792,12 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
=20
         break;
     case TPM_TIS_REG_INT_ENABLE:
-        if (tis->active_locty !=3D locty) {
+        if (s->active_locty !=3D locty) {
             break;
         }
=20
-        tis->loc[locty].inte &=3D mask;
-        tis->loc[locty].inte |=3D (val & (TPM_TIS_INT_ENABLED |
+        s->loc[locty].inte &=3D mask;
+        s->loc[locty].inte |=3D (val & (TPM_TIS_INT_ENABLED |
                                         TPM_TIS_INT_POLARITY_MASK |
                                         TPM_TIS_INTERRUPTS_SUPPORTED));
         break;
@@ -824,30 +805,30 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
         /* hard wired -- ignore */
         break;
     case TPM_TIS_REG_INT_STATUS:
-        if (tis->active_locty !=3D locty) {
+        if (s->active_locty !=3D locty) {
             break;
         }
=20
         /* clearing of interrupt flags */
         if (((val & TPM_TIS_INTERRUPTS_SUPPORTED)) &&
-            (tis->loc[locty].ints & TPM_TIS_INTERRUPTS_SUPPORTED)) {
-            tis->loc[locty].ints &=3D ~val;
-            if (tis->loc[locty].ints =3D=3D 0) {
-                qemu_irq_lower(tis->irq);
+            (s->loc[locty].ints & TPM_TIS_INTERRUPTS_SUPPORTED)) {
+            s->loc[locty].ints &=3D ~val;
+            if (s->loc[locty].ints =3D=3D 0) {
+                qemu_irq_lower(s->irq);
                 DPRINTF("tpm_tis: Lowering IRQ\n");
             }
         }
-        tis->loc[locty].ints &=3D ~(val & TPM_TIS_INTERRUPTS_SUPPORTED);
+        s->loc[locty].ints &=3D ~(val & TPM_TIS_INTERRUPTS_SUPPORTED);
         break;
     case TPM_TIS_REG_STS:
-        if (tis->active_locty !=3D locty) {
+        if (s->active_locty !=3D locty) {
             break;
         }
=20
         if (s->be_tpm_version =3D=3D TPM_VERSION_2_0) {
             /* some flags that are only supported for TPM 2 */
             if (val & TPM_TIS_STS_COMMAND_CANCEL) {
-                if (tis->loc[locty].state =3D=3D TPM_TIS_STATE_EXECUTION=
) {
+                if (s->loc[locty].state =3D=3D TPM_TIS_STATE_EXECUTION) =
{
                     /*
                      * request the backend to cancel. Some backends may =
not
                      * support it
@@ -867,16 +848,16 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
                 TPM_TIS_STS_RESPONSE_RETRY);
=20
         if (val =3D=3D TPM_TIS_STS_COMMAND_READY) {
-            switch (tis->loc[locty].state) {
+            switch (s->loc[locty].state) {
=20
             case TPM_TIS_STATE_READY:
-                tis->loc[locty].w_offset =3D 0;
-                tis->loc[locty].r_offset =3D 0;
+                s->loc[locty].w_offset =3D 0;
+                s->loc[locty].r_offset =3D 0;
             break;
=20
             case TPM_TIS_STATE_IDLE:
-                tpm_tis_sts_set(&tis->loc[locty], TPM_TIS_STS_COMMAND_RE=
ADY);
-                tis->loc[locty].state =3D TPM_TIS_STATE_READY;
+                tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_COMMAND_READ=
Y);
+                s->loc[locty].state =3D TPM_TIS_STATE_READY;
                 tpm_tis_raise_irq(s, locty, TPM_TIS_INT_COMMAND_READY);
             break;
=20
@@ -889,23 +870,23 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
             break;
=20
             case TPM_TIS_STATE_COMPLETION:
-                tis->loc[locty].w_offset =3D 0;
-                tis->loc[locty].r_offset =3D 0;
+                s->loc[locty].w_offset =3D 0;
+                s->loc[locty].r_offset =3D 0;
                 /* shortcut to ready state with C/R set */
-                tis->loc[locty].state =3D TPM_TIS_STATE_READY;
-                if (!(tis->loc[locty].sts & TPM_TIS_STS_COMMAND_READY)) =
{
-                    tpm_tis_sts_set(&tis->loc[locty],
+                s->loc[locty].state =3D TPM_TIS_STATE_READY;
+                if (!(s->loc[locty].sts & TPM_TIS_STS_COMMAND_READY)) {
+                    tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_COMMAND_READY);
                     tpm_tis_raise_irq(s, locty, TPM_TIS_INT_COMMAND_READ=
Y);
                 }
-                tis->loc[locty].sts &=3D ~(TPM_TIS_STS_DATA_AVAILABLE);
+                s->loc[locty].sts &=3D ~(TPM_TIS_STS_DATA_AVAILABLE);
             break;
=20
             }
         } else if (val =3D=3D TPM_TIS_STS_TPM_GO) {
-            switch (tis->loc[locty].state) {
+            switch (s->loc[locty].state) {
             case TPM_TIS_STATE_RECEPTION:
-                if ((tis->loc[locty].sts & TPM_TIS_STS_EXPECT) =3D=3D 0)=
 {
+                if ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) =3D=3D 0) {
                     tpm_tis_tpm_send(s, locty);
                 }
                 break;
@@ -914,10 +895,10 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
                 break;
             }
         } else if (val =3D=3D TPM_TIS_STS_RESPONSE_RETRY) {
-            switch (tis->loc[locty].state) {
+            switch (s->loc[locty].state) {
             case TPM_TIS_STATE_COMPLETION:
-                tis->loc[locty].r_offset =3D 0;
-                tpm_tis_sts_set(&tis->loc[locty],
+                s->loc[locty].r_offset =3D 0;
+                tpm_tis_sts_set(&s->loc[locty],
                                 TPM_TIS_STS_VALID|
                                 TPM_TIS_STS_DATA_AVAILABLE);
                 break;
@@ -930,20 +911,20 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
     case TPM_TIS_REG_DATA_FIFO:
     case TPM_TIS_REG_DATA_XFIFO ... TPM_TIS_REG_DATA_XFIFO_END:
         /* data fifo */
-        if (tis->active_locty !=3D locty) {
+        if (s->active_locty !=3D locty) {
             break;
         }
=20
-        if (tis->loc[locty].state =3D=3D TPM_TIS_STATE_IDLE ||
-            tis->loc[locty].state =3D=3D TPM_TIS_STATE_EXECUTION ||
-            tis->loc[locty].state =3D=3D TPM_TIS_STATE_COMPLETION) {
+        if (s->loc[locty].state =3D=3D TPM_TIS_STATE_IDLE ||
+            s->loc[locty].state =3D=3D TPM_TIS_STATE_EXECUTION ||
+            s->loc[locty].state =3D=3D TPM_TIS_STATE_COMPLETION) {
             /* drop the byte */
         } else {
             DPRINTF("tpm_tis: Data to send to TPM: %08x (size=3D%d)\n",
                     (int)val, size);
-            if (tis->loc[locty].state =3D=3D TPM_TIS_STATE_READY) {
-                tis->loc[locty].state =3D TPM_TIS_STATE_RECEPTION;
-                tpm_tis_sts_set(&tis->loc[locty],
+            if (s->loc[locty].state =3D=3D TPM_TIS_STATE_READY) {
+                s->loc[locty].state =3D TPM_TIS_STATE_RECEPTION;
+                tpm_tis_sts_set(&s->loc[locty],
                                 TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
             }
=20
@@ -953,30 +934,30 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr=
 addr,
                 size =3D 4 - (addr & 0x3);
             }
=20
-            while ((tis->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > =
0) {
-                if (tis->loc[locty].w_offset < tis->loc[locty].w_buffer.=
size) {
-                    tis->loc[locty].w_buffer.
-                        buffer[tis->loc[locty].w_offset++] =3D (uint8_t)=
val;
+            while ((s->loc[locty].sts & TPM_TIS_STS_EXPECT) && size > 0)=
 {
+                if (s->loc[locty].w_offset < s->loc[locty].w_buffer.size=
) {
+                    s->loc[locty].w_buffer.
+                        buffer[s->loc[locty].w_offset++] =3D (uint8_t)va=
l;
                     val >>=3D 8;
                     size--;
                 } else {
-                    tpm_tis_sts_set(&tis->loc[locty], TPM_TIS_STS_VALID)=
;
+                    tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
                 }
             }
=20
             /* check for complete packet */
-            if (tis->loc[locty].w_offset > 5 &&
-                (tis->loc[locty].sts & TPM_TIS_STS_EXPECT)) {
+            if (s->loc[locty].w_offset > 5 &&
+                (s->loc[locty].sts & TPM_TIS_STS_EXPECT)) {
                 /* we have a packet length - see if we have all of it */
-                bool need_irq =3D !(tis->loc[locty].sts & TPM_TIS_STS_VA=
LID);
+                bool need_irq =3D !(s->loc[locty].sts & TPM_TIS_STS_VALI=
D);
=20
-                len =3D tpm_tis_get_size_from_buffer(&tis->loc[locty].w_=
buffer);
-                if (len > tis->loc[locty].w_offset) {
-                    tpm_tis_sts_set(&tis->loc[locty],
+                len =3D tpm_tis_get_size_from_buffer(&s->loc[locty].w_bu=
ffer);
+                if (len > s->loc[locty].w_offset) {
+                    tpm_tis_sts_set(&s->loc[locty],
                                     TPM_TIS_STS_EXPECT | TPM_TIS_STS_VAL=
ID);
                 } else {
                     /* packet complete */
-                    tpm_tis_sts_set(&tis->loc[locty], TPM_TIS_STS_VALID)=
;
+                    tpm_tis_sts_set(&s->loc[locty], TPM_TIS_STS_VALID);
                 }
                 if (need_irq) {
                     tpm_tis_raise_irq(s, locty, TPM_TIS_INT_STS_VALID);
@@ -987,7 +968,7 @@ static void tpm_tis_mmio_write(void *opaque, hwaddr a=
ddr,
     case TPM_TIS_REG_INTERFACE_ID:
         if (val & TPM_TIS_IFACE_ID_INT_SEL_LOCK) {
             for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
-                tis->loc[l].iface_id |=3D TPM_TIS_IFACE_ID_INT_SEL_LOCK;
+                s->loc[l].iface_id |=3D TPM_TIS_IFACE_ID_INT_SEL_LOCK;
             }
         }
         break;
@@ -1036,39 +1017,38 @@ TPMVersion tpm_tis_get_tpm_version(Object *obj)
 static void tpm_tis_reset(DeviceState *dev)
 {
     TPMState *s =3D TPM(dev);
-    TPMTISEmuState *tis =3D &s->s.tis;
     int c;
=20
     s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
=20
     tpm_backend_reset(s->be_driver);
=20
-    tis->active_locty =3D TPM_TIS_NO_LOCALITY;
-    tis->next_locty =3D TPM_TIS_NO_LOCALITY;
-    tis->aborting_locty =3D TPM_TIS_NO_LOCALITY;
+    s->active_locty =3D TPM_TIS_NO_LOCALITY;
+    s->next_locty =3D TPM_TIS_NO_LOCALITY;
+    s->aborting_locty =3D TPM_TIS_NO_LOCALITY;
=20
     for (c =3D 0; c < TPM_TIS_NUM_LOCALITIES; c++) {
-        tis->loc[c].access =3D TPM_TIS_ACCESS_TPM_REG_VALID_STS;
+        s->loc[c].access =3D TPM_TIS_ACCESS_TPM_REG_VALID_STS;
         switch (s->be_tpm_version) {
         case TPM_VERSION_UNSPEC:
             break;
         case TPM_VERSION_1_2:
-            tis->loc[c].sts =3D TPM_TIS_STS_TPM_FAMILY1_2;
-            tis->loc[c].iface_id =3D TPM_TIS_IFACE_ID_SUPPORTED_FLAGS1_3=
;
+            s->loc[c].sts =3D TPM_TIS_STS_TPM_FAMILY1_2;
+            s->loc[c].iface_id =3D TPM_TIS_IFACE_ID_SUPPORTED_FLAGS1_3;
             break;
         case TPM_VERSION_2_0:
-            tis->loc[c].sts =3D TPM_TIS_STS_TPM_FAMILY2_0;
-            tis->loc[c].iface_id =3D TPM_TIS_IFACE_ID_SUPPORTED_FLAGS2_0=
;
+            s->loc[c].sts =3D TPM_TIS_STS_TPM_FAMILY2_0;
+            s->loc[c].iface_id =3D TPM_TIS_IFACE_ID_SUPPORTED_FLAGS2_0;
             break;
         }
-        tis->loc[c].inte =3D TPM_TIS_INT_POLARITY_LOW_LEVEL;
-        tis->loc[c].ints =3D 0;
-        tis->loc[c].state =3D TPM_TIS_STATE_IDLE;
-
-        tis->loc[c].w_offset =3D 0;
-        tpm_tis_realloc_buffer(&tis->loc[c].w_buffer);
-        tis->loc[c].r_offset =3D 0;
-        tpm_tis_realloc_buffer(&tis->loc[c].r_buffer);
+        s->loc[c].inte =3D TPM_TIS_INT_POLARITY_LOW_LEVEL;
+        s->loc[c].ints =3D 0;
+        s->loc[c].state =3D TPM_TIS_STATE_IDLE;
+
+        s->loc[c].w_offset =3D 0;
+        tpm_tis_realloc_buffer(&s->loc[c].w_buffer);
+        s->loc[c].r_offset =3D 0;
+        tpm_tis_realloc_buffer(&s->loc[c].r_buffer);
     }
=20
     tpm_tis_do_startup_tpm(s);
@@ -1080,8 +1060,7 @@ static const VMStateDescription vmstate_tpm_tis =3D=
 {
 };
=20
 static Property tpm_tis_properties[] =3D {
-    DEFINE_PROP_UINT32("irq", TPMState,
-                       s.tis.irq_num, TPM_TIS_IRQ),
+    DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_STRING("tpmdev", TPMState, backend),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1089,7 +1068,6 @@ static Property tpm_tis_properties[] =3D {
 static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
 {
     TPMState *s =3D TPM(dev);
-    TPMTISEmuState *tis =3D &s->s.tis;
=20
     s->be_driver =3D qemu_find_tpm(s->backend);
     if (!s->be_driver) {
@@ -1106,15 +1084,15 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
         return;
     }
=20
-    if (tis->irq_num > 15) {
+    if (s->irq_num > 15) {
         error_setg(errp, "tpm_tis: IRQ %d for TPM TIS is outside valid r=
ange "
-                   "of 0 to 15", tis->irq_num);
+                   "of 0 to 15", s->irq_num);
         return;
     }
=20
-    tis->bh =3D qemu_bh_new(tpm_tis_receive_bh, s);
+    s->bh =3D qemu_bh_new(tpm_tis_receive_bh, s);
=20
-    isa_init_irq(&s->busdev, &tis->irq, tis->irq_num);
+    isa_init_irq(&s->busdev, &s->irq, s->irq_num);
=20
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
--=20
2.14.1.146.gd35faa819
