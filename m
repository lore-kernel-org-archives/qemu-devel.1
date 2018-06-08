Received: from eggs.gnu.org ([2001:4830:134:3::10]:48002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUK-0002Vm-15
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fRLUH-0001eF-HQ
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1fRLUH-0001dc-8e
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:47:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Jun 2018 13:47:29 -0400
Message-Id: <20180608174733.4936-27-jsnow@redhat.com>
In-Reply-To: <20180608174733.4936-1-jsnow@redhat.com>
References: <20180608174733.4936-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 26/30] ide: push end_transfer_func out of
 start_transfer callback, rename callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Now that end_transfer_func is a tail call in ahci_start_transfer,
formalize the fact that the callback (of which ahci_start_transfer is
the sole implementation) takes care of the transfer too: rename it to
pio_transfer and, if it is present, call the end_transfer_func as soon
as it returns.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180606190955.20845-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/ahci.c             | 13 ++++++-------
 hw/ide/core.c             |  8 +++++---
 hw/ide/trace-events       |  2 +-
 include/hw/ide/internal.h |  2 +-
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index f25bef501d..f7852be842 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1340,8 +1340,8 @@ out:
     return 0;
 }
=20
-/* DMA dev <-> ram */
-static void ahci_start_transfer(IDEDMA *dma)
+/* Transfer PIO data between RAM and device */
+static void ahci_pio_transfer(IDEDMA *dma)
 {
     AHCIDevice *ad =3D DO_UPCAST(AHCIDevice, dma, dma);
     IDEState *s =3D &ad->port.ifs[0];
@@ -1365,9 +1365,9 @@ static void ahci_start_transfer(IDEDMA *dma)
         has_sglist =3D 1;
     }
=20
-    trace_ahci_start_transfer(ad->hba, ad->port_no, is_write ? "writ" : =
"read",
-                              size, is_atapi ? "atapi" : "ata",
-                              has_sglist ? "" : "o");
+    trace_ahci_pio_transfer(ad->hba, ad->port_no, is_write ? "writ" : "r=
ead",
+                            size, is_atapi ? "atapi" : "ata",
+                            has_sglist ? "" : "o");
=20
     if (has_sglist && size) {
         if (is_write) {
@@ -1382,7 +1382,6 @@ static void ahci_start_transfer(IDEDMA *dma)
 out:
     /* declare that we processed everything */
     s->data_ptr =3D s->data_end;
-    s->end_transfer_func(s);
 }
=20
 static void ahci_start_dma(IDEDMA *dma, IDEState *s,
@@ -1503,7 +1502,7 @@ static const IDEDMAOps ahci_dma_ops =3D {
     .start_dma =3D ahci_start_dma,
     .restart =3D ahci_restart,
     .restart_dma =3D ahci_restart_dma,
-    .start_transfer =3D ahci_start_transfer,
+    .pio_transfer =3D ahci_pio_transfer,
     .prepare_buf =3D ahci_dma_prepare_buf,
     .commit_buf =3D ahci_commit_buf,
     .rw_buf =3D ahci_dma_rw_buf,
diff --git a/hw/ide/core.c b/hw/ide/core.c
index cc9ca28c33..1a6cb337bf 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -526,16 +526,18 @@ static void ide_clear_retry(IDEState *s)
 void ide_transfer_start(IDEState *s, uint8_t *buf, int size,
                         EndTransferFunc *end_transfer_func)
 {
-    s->end_transfer_func =3D end_transfer_func;
     s->data_ptr =3D buf;
     s->data_end =3D buf + size;
     ide_set_retry(s);
     if (!(s->status & ERR_STAT)) {
         s->status |=3D DRQ_STAT;
     }
-    if (s->bus->dma->ops->start_transfer) {
-        s->bus->dma->ops->start_transfer(s->bus->dma);
+    if (!s->bus->dma->ops->pio_transfer) {
+        s->end_transfer_func =3D end_transfer_func;
+        return;
     }
+    s->bus->dma->ops->pio_transfer(s->bus->dma);
+    end_transfer_func(s);
 }
=20
 static void ide_cmd_done(IDEState *s)
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index e6bd95f52f..65d6f9034d 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -108,7 +108,7 @@ handle_cmd_badport(void *s, int port) "ahci(%p)[%d]: =
guest accessed unused port"
 handle_cmd_badfis(void *s, int port) "ahci(%p)[%d]: guest provided an in=
valid cmd FIS"
 handle_cmd_badmap(void *s, int port, uint64_t len) "ahci(%p)[%d]: dma_me=
mory_map failed, 0x%02"PRIx64" !=3D 0x80"
 handle_cmd_unhandled_fis(void *s, int port, uint8_t b0, uint8_t b1, uint=
8_t b2) "ahci(%p)[%d]: unhandled FIS type. cmd_fis: 0x%02x-%02x-%02x"
-ahci_start_transfer(void *s, int port, const char *rw, uint32_t size, co=
nst char *tgt, const char *sgl) "ahci(%p)[%d]: %sing %d bytes on %s w/%s =
sglist"
+ahci_pio_transfer(void *s, int port, const char *rw, uint32_t size, cons=
t char *tgt, const char *sgl) "ahci(%p)[%d]: %sing %d bytes on %s w/%s sg=
list"
 ahci_start_dma(void *s, int port) "ahci(%p)[%d]: start dma"
 ahci_dma_prepare_buf(void *s, int port, int32_t io_buffer_size, int32_t =
limit) "ahci(%p)[%d]: prepare buf limit=3D%"PRId32" prepared=3D%"PRId32
 ahci_dma_prepare_buf_fail(void *s, int port) "ahci(%p)[%d]: sglist popul=
ation failed"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 88212f59df..f3de6f9b73 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -444,7 +444,7 @@ struct IDEState {
=20
 struct IDEDMAOps {
     DMAStartFunc *start_dma;
-    DMAVoidFunc *start_transfer;
+    DMAVoidFunc *pio_transfer;
     DMAInt32Func *prepare_buf;
     DMAu32Func *commit_buf;
     DMAIntFunc *rw_buf;
--=20
2.14.3
