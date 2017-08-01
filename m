Received: from eggs.gnu.org ([2001:4830:134:3::10]:47580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2O-0001bF-VN
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2M-0005Sm-VS
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcX2M-0005SL-LU
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:38 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  1 Aug 2017 14:16:13 +0100
Message-Id: <20170801131618.27332-5-stefanha@redhat.com>
In-Reply-To: <20170801131618.27332-1-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] trace: add trace_event_get_state_backends()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Code that checks dstate is unaware of SystemTap and LTTng UST dstate, so
the following trace event will not fire when solely enabled by SystemTap
or LTTng UST:

  if (trace_event_get_state(TRACE_MY_EVENT)) {
      str = g_strdup_printf("Expensive string to generate ...",
                            ...);
      trace_my_event(str);
      g_free(str);
  }

Add trace_event_get_state_backends() to fetch backend dstate.  Those
backends that use QEMU dstate fetch it as part of
generate_h_backend_dstate().

Update existing trace_event_get_state() callers to use
trace_event_get_state_backends() instead.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170731140718.22010-3-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/tracing.txt |  2 +-
 trace/control.h        | 18 +++++++++++++++++-
 hw/usb/hcd-ohci.c      | 13 +++++--------
 net/colo-compare.c     | 11 ++++++-----
 net/filter-rewriter.c  |  4 ++--
 5 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
index 5768a0b7a2..07abbb345c 100644
--- a/docs/devel/tracing.txt
+++ b/docs/devel/tracing.txt
@@ -353,7 +353,7 @@ guard such computations and avoid its compilation when the event is disabled:
     }
 
 You can check both if the event has been disabled and is dynamically enabled at
-the same time using the 'trace_event_get_state' routine (see header
+the same time using the 'trace_event_get_state_backends' routine (see header
 "trace/control.h" for more information).
 
 === "tcg" ===
diff --git a/trace/control.h b/trace/control.h
index b931824d60..1903e22975 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -96,7 +96,7 @@ static const char * trace_event_get_name(TraceEvent *ev);
  * trace_event_get_state:
  * @id: Event identifier name.
  *
- * Get the tracing state of an event (both static and dynamic).
+ * Get the tracing state of an event, both static and the QEMU dynamic state.
  *
  * If the event has the disabled property, the check will have no performance
  * impact.
@@ -105,6 +105,22 @@ static const char * trace_event_get_name(TraceEvent *ev);
     ((id ##_ENABLED) && trace_event_get_state_dynamic_by_id(id))
 
 /**
+ * trace_event_get_state_backends:
+ * @id: Event identifier name.
+ *
+ * Get the tracing state of an event, both static and dynamic state from all
+ * compiled-in backends.
+ *
+ * If the event has the disabled property, the check will have no performance
+ * impact.
+ *
+ * Returns: true if at least one backend has the event enabled and the event
+ * does not have the disabled property.
+ */
+#define trace_event_get_state_backends(id)              \
+    ((id ##_ENABLED) && id ##_BACKEND_DSTATE())
+
+/**
  * trace_event_get_vcpu_state:
  * @vcpu: Target vCPU.
  * @id: Event identifier name.
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 3ada35e954..267982e160 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -936,16 +936,18 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
     return 1;
 }
 
-#ifdef trace_event_get_state
 static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
 {
-    bool print16 = !!trace_event_get_state(TRACE_USB_OHCI_TD_PKT_SHORT);
-    bool printall = !!trace_event_get_state(TRACE_USB_OHCI_TD_PKT_FULL);
+    bool print16;
+    bool printall;
     const int width = 16;
     int i;
     char tmp[3 * width + 1];
     char *p = tmp;
 
+    print16 = !!trace_event_get_state_backends(TRACE_USB_OHCI_TD_PKT_SHORT);
+    printall = !!trace_event_get_state_backends(TRACE_USB_OHCI_TD_PKT_FULL);
+
     if (!printall && !print16) {
         return;
     }
@@ -967,11 +969,6 @@ static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
         p += sprintf(p, " %.2x", buf[i]);
     }
 }
-#else
-static void ohci_td_pkt(const char *msg, const uint8_t *buf, size_t len)
-{
-}
-#endif
 
 /* Service a transport descriptor.
    Returns nonzero to terminate processing of this endpoint.  */
diff --git a/net/colo-compare.c b/net/colo-compare.c
index ca67c68615..5fe8e3fad9 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -188,7 +188,7 @@ static int packet_enqueue(CompareState *s, int mode)
  */
 static int colo_packet_compare_common(Packet *ppkt, Packet *spkt, int offset)
 {
-    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
         strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
@@ -274,7 +274,8 @@ static int colo_packet_compare_tcp(Packet *spkt, Packet *ppkt)
         res = -1;
     }
 
-    if (res != 0 && trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+    if (res != 0 &&
+        trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
         strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
@@ -334,7 +335,7 @@ static int colo_packet_compare_udp(Packet *spkt, Packet *ppkt)
     if (ret) {
         trace_colo_compare_udp_miscompare("primary pkt size", ppkt->size);
         trace_colo_compare_udp_miscompare("Secondary pkt size", spkt->size);
-        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
             qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
                          ppkt->size);
             qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
@@ -371,7 +372,7 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
                                            ppkt->size);
         trace_colo_compare_icmp_miscompare("Secondary pkt size",
                                            spkt->size);
-        if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
             qemu_hexdump((char *)ppkt->data, stderr, "colo-compare pri pkt",
                          ppkt->size);
             qemu_hexdump((char *)spkt->data, stderr, "colo-compare sec pkt",
@@ -390,7 +391,7 @@ static int colo_packet_compare_icmp(Packet *spkt, Packet *ppkt)
 static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
 {
     trace_colo_compare_main("compare other");
-    if (trace_event_get_state(TRACE_COLO_COMPARE_MISCOMPARE)) {
+    if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE)) {
         char pri_ip_src[20], pri_ip_dst[20], sec_ip_src[20], sec_ip_dst[20];
 
         strcpy(pri_ip_src, inet_ntoa(ppkt->ip->ip_src));
diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index 55a6cf56fd..98120095de 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -69,7 +69,7 @@ static int handle_primary_tcp_pkt(NetFilterState *nf,
     struct tcphdr *tcp_pkt;
 
     tcp_pkt = (struct tcphdr *)pkt->transport_header;
-    if (trace_event_get_state(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
+    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
@@ -115,7 +115,7 @@ static int handle_secondary_tcp_pkt(NetFilterState *nf,
 
     tcp_pkt = (struct tcphdr *)pkt->transport_header;
 
-    if (trace_event_get_state(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
+    if (trace_event_get_state_backends(TRACE_COLO_FILTER_REWRITER_DEBUG)) {
         trace_colo_filter_rewriter_pkt_info(__func__,
                     inet_ntoa(pkt->ip->ip_src), inet_ntoa(pkt->ip->ip_dst),
                     ntohl(tcp_pkt->th_seq), ntohl(tcp_pkt->th_ack),
-- 
2.13.3
