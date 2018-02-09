Received: from eggs.gnu.org ([2001:4830:134:3::10]:44735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDqb-0005EK-0j
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ekDqZ-00082X-HB
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:56:33 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  9 Feb 2018 18:51:42 +0000
Message-Id: <20180209185142.17151-13-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCHv2 12/12] cuda: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 Makefile.objs              |  1 +
 hw/misc/macio/cuda.c       | 50 ++++++++++++++++------------------------------
 hw/misc/macio/trace-events | 11 ++++++++++
 3 files changed, 29 insertions(+), 33 deletions(-)
 create mode 100644 hw/misc/macio/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index 2efba6d768..3f1a1b674d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -133,6 +133,7 @@ trace-events-subdirs += hw/net
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/misc
+trace-events-subdirs += hw/misc/macio
 trace-events-subdirs += hw/usb
 trace-events-subdirs += hw/scsi
 trace-events-subdirs += hw/nvram
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index 377b91d266..bd9b862034 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -32,19 +32,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
-
-/* debug CUDA packets */
-//#define DEBUG_CUDA_PACKET
-
-/* debug CUDA packets */
-//#define DEBUG_CUDA_PACKET
-
-#ifdef DEBUG_CUDA
-#define CUDA_DPRINTF(fmt, ...)                                  \
-    do { printf("CUDA: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define CUDA_DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 /* Bits in B data register: all active low */
 #define TREQ            0x08    /* Transfer request (input) */
@@ -120,7 +108,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
         return;
     }
 
-    CUDA_DPRINTF("CUDA: %s:%d\n", __func__, __LINE__);
+    trace_cuda_delay_set_sr_int();
 
     expire = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->sr_delay_ns;
     timer_mod(s->sr_delay_timer, expire);
@@ -141,7 +129,7 @@ static void cuda_update(CUDAState *s)
             /* data output */
             if ((ms->b & (TACK | TIP)) != (s->last_b & (TACK | TIP))) {
                 if (s->data_out_index < sizeof(s->data_out)) {
-                    CUDA_DPRINTF("send: %02x\n", ms->sr);
+                    trace_cuda_data_send(ms->sr);
                     s->data_out[s->data_out_index++] = ms->sr;
                     cuda_delay_set_sr_int(s);
                 }
@@ -151,7 +139,7 @@ static void cuda_update(CUDAState *s)
                 /* data input */
                 if ((ms->b & (TACK | TIP)) != (s->last_b & (TACK | TIP))) {
                     ms->sr = s->data_in[s->data_in_index++];
-                    CUDA_DPRINTF("recv: %02x\n", ms->sr);
+                    trace_cuda_data_recv(ms->sr);
                     /* indicate end of transfer */
                     if (s->data_in_index >= s->data_in_size) {
                         ms->b = (ms->b | TREQ);
@@ -199,15 +187,13 @@ static void cuda_update(CUDAState *s)
 static void cuda_send_packet_to_host(CUDAState *s,
                                      const uint8_t *data, int len)
 {
-#ifdef DEBUG_CUDA_PACKET
-    {
-        int i;
-        printf("cuda_send_packet_to_host:\n");
-        for(i = 0; i < len; i++)
-            printf(" %02x", data[i]);
-        printf("\n");
+    int i;
+
+    trace_cuda_packet_send(len);
+    for (i = 0; i < len; i++) {
+        trace_cuda_packet_send_data(i, data[i]);
     }
-#endif
+
     memcpy(s->data_in, data, len);
     s->data_in_size = len;
     s->data_in_index = 0;
@@ -411,7 +397,7 @@ static void cuda_receive_packet(CUDAState *s,
     for (i = 0; i < ARRAY_SIZE(handlers); i++) {
         const CudaCommand *desc = &handlers[i];
         if (desc->command == data[0]) {
-            CUDA_DPRINTF("handling command %s\n", desc->name);
+            trace_cuda_receive_packet_cmd(desc->name);
             out_len = 0;
             if (desc->handler(s, data + 1, len - 1, obuf + 3, &out_len)) {
                 cuda_send_packet_to_host(s, obuf, 3 + out_len);
@@ -440,15 +426,13 @@ static void cuda_receive_packet(CUDAState *s,
 static void cuda_receive_packet_from_host(CUDAState *s,
                                           const uint8_t *data, int len)
 {
-#ifdef DEBUG_CUDA_PACKET
-    {
-        int i;
-        printf("cuda_receive_packet_from_host:\n");
-        for(i = 0; i < len; i++)
-            printf(" %02x", data[i]);
-        printf("\n");
+    int i;
+
+    trace_cuda_packet_receive(len);
+    for (i = 0; i < len; i++) {
+        trace_cuda_packet_receive_data(i, data[i]);
     }
-#endif
+
     switch(data[0]) {
     case ADB_PACKET:
         {
diff --git a/hw/misc/macio/trace-events b/hw/misc/macio/trace-events
new file mode 100644
index 0000000000..24c0a36824
--- /dev/null
+++ b/hw/misc/macio/trace-events
@@ -0,0 +1,11 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# hw/misc/macio/cuda.c
+cuda_delay_set_sr_int(void) ""
+cuda_data_send(uint8_t data) "send: 0x%02x"
+cuda_data_recv(uint8_t data) "recv: 0x%02x"
+cuda_receive_packet_cmd(const char *cmd) "handling command %s"
+cuda_packet_receive(int len) "length %d"
+cuda_packet_receive_data(int i, const uint8_t data) "[%d] 0x%02x"
+cuda_packet_send(int len) "length %d"
+cuda_packet_send_data(int i, const uint8_t data) "[%d] 0x%02x"
-- 
2.11.0
