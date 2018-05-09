Received: from eggs.gnu.org ([2001:4830:134:3::10]:41645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRLB-0001Pt-EB
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fGRLA-0007ag-Bw
	for qemu-devel@nongnu.org; Wed, 09 May 2018 11:49:17 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  9 May 2018 17:49:10 +0200
Message-Id: <20180509154910.23578-3-cohuck@redhat.com>
In-Reply-To: <20180509154910.23578-1-cohuck@redhat.com>
References: <20180509154910.23578-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 2/2] s390/css: add some tracing for
 pass-through handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

...so we can get more easily an idea whether halt/clear is sent to
the device or emulated.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c        | 6 ++++++
 hw/s390x/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b6727d0607..b6f3421380 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1182,11 +1182,13 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
 
 static IOInstEnding sch_handle_clear_func_passthrough(SubchDev *sch)
 {
+    trace_css_handle_clear_pt(sch->cssid, sch->ssid, sch->schid);
     return s390_ccw_cmd_request(sch);
 }
 
 static IOInstEnding sch_handle_halt_func_passthrough(SubchDev *sch)
 {
+    trace_css_handle_halt_pt(sch->cssid, sch->ssid, sch->schid);
     return s390_ccw_cmd_request(sch);
 }
 
@@ -1197,6 +1199,8 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
     SCSW *s = &sch->curr_status.scsw;
 
     ORB *orb = &sch->orb;
+
+    trace_css_handle_start_pt(sch->cssid, sch->ssid, sch->schid);
     if (!(s->ctrl & SCSW_ACTL_SUSP)) {
         assert(orb != NULL);
         p->intparm = orb->intparm;
@@ -1252,6 +1256,7 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
         } else {
             if (sch_handle_clear_func_passthrough(sch) == IOINST_OPNOTSUPP) {
                 no_halt_clear = true;
+                trace_css_no_haltclear_pt();
                 sch_handle_halt_func(sch);
             }
         }
@@ -1260,6 +1265,7 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
             sch_handle_halt_func(sch);
         } else {
             if (sch_handle_halt_func_passthrough(sch) == IOINST_OPNOTSUPP) {
+                trace_css_no_haltclear_pt();
                 no_halt_clear = true;
                 sch_handle_halt_func(sch);
             }
diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
index 0d3622ec6f..d4fd1b9da6 100644
--- a/hw/s390x/trace-events
+++ b/hw/s390x/trace-events
@@ -9,6 +9,10 @@ css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, uint16_t sc
 css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uint8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x (intparm 0x%08x, isc 0x%x) %s"
 css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc 0x%x)"
 css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode 0x%x on isc 0x%x"
+css_handle_clear_pt(int cssid, int ssid, int schid) "CSS: handling clear function for pass-through subchannel %x.%x.%04x"
+css_handle_halt_pt(int cssid, int ssid, int schid) "CSS: handling halt function for pass-through subchannel %x.%x.%04x"
+css_handle_start_pt(int cssid, int ssid, int schid) "CSS: handling start function for pass-through subchannel %x.%x.%04x"
+css_no_haltclear_pt(void) "CSS: no kernel support for halt/clear function passthrough handling, falling back to emulation"
 
 # hw/s390x/virtio-ccw.c
 virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code) "VIRTIO-CCW: %x.%x.%04x: interpret command 0x%x"
-- 
2.14.3
