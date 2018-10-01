Received: from eggs.gnu.org ([2001:4830:134:3::10]:44295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVi-0004b3-R6
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g6uVh-0000cR-RT
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g6uVh-0000bd-Ga
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 05:29:01 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  1 Oct 2018 11:28:48 +0200
Message-Id: <20181001092848.11082-6-kraxel@redhat.com>
In-Reply-To: <20181001092848.11082-1-kraxel@redhat.com>
References: <20181001092848.11082-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] ohci: set effectively usb frame rate to 1kHz
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Miguel GAIO <mgaio35@gmail.com>

From: Miguel GAIO <mgaio35@gmail.com>

USB frame rate is slightly lower than 1kHz: ie. ~950Hz.
Thus usb-audio device is not able to perform a simple audio playback
without underruns on audio backend.
eg. "-device pci-ohci,id=ohci -device usb-audio,bus=ohci.0" vs PulseAudio
backend. more than 50 underruns are observed per second.

Update ohci_sof_time computation, using QEMU_CLOCK_VIRTUAL in
ohci_usb_start(), and increment by usb_frame_time in ohci_sof()
makes USB frame rate close to 1kHz.
This way, no audio underrun are observed during audio playback.

Signed-off-by: Miguel GAIO <mgaio35@gmail.com>
Message-Id: <20180927151936.3647-1-mgaio35@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 98da5f0f04..66656a1133 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1253,12 +1253,12 @@ static int ohci_service_ed_list(OHCIState *ohci, uint32_t head, int completion)
 /* set a timer for EOF */
 static void ohci_eof_timer(OHCIState *ohci)
 {
-    ohci->sof_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     timer_mod(ohci->eof_timer, ohci->sof_time + usb_frame_time);
 }
 /* Set a timer for EOF and generate a SOF event */
 static void ohci_sof(OHCIState *ohci)
 {
+    ohci->sof_time += usb_frame_time;
     ohci_eof_timer(ohci);
     ohci_set_interrupt(ohci, OHCI_INTR_SF);
 }
@@ -1362,6 +1362,7 @@ static int ohci_bus_start(OHCIState *ohci)
      * can meet some race conditions
      */
 
+    ohci->sof_time = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     ohci_eof_timer(ohci);
 
     return 1;
@@ -1476,6 +1477,9 @@ static uint32_t ohci_get_frame_remaining(OHCIState *ohci)
      * set already.
      */
     tks = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ohci->sof_time;
+    if (tks < 0) {
+        tks = 0;
+    }
 
     /* avoid muldiv if possible */
     if (tks >= usb_frame_time)
-- 
2.9.3
