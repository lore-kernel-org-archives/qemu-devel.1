Received: from eggs.gnu.org ([2001:4830:134:3::10]:33977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZLB-0007Zv-1r
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1eCZL7-00032O-Re
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:01:01 -0500
Received: from mail-sn1nam01on0042.outbound.protection.outlook.com
	([104.47.32.42]:45518
	helo=NAM01-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1eCZL7-00031u-HK
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:00:57 -0500
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 8 Nov 2017 14:56:46 -0800
Message-ID: <389cacd55d717f1b540c94c0c95eddffd8316fc6.1510181732.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1510181732.git.alistair.francis@xilinx.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 07/45] hw/bt: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, armbru@redhat.com

Replace a large number of the fprintf(stderr, "*\n" calls with
error_report(). The functions were renamed with these commands and then
compiler issues where manually fixed.

find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +
find ./* -type f -exec sed -i \
    'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
    {} +

Some lines where then manually tweaked to pass checkpatch.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
---
V2:
 - Split hw patch into individual directories

 hw/bt/core.c    | 15 +++++++--------
 hw/bt/hci-csr.c | 21 +++++++++++----------
 hw/bt/hci.c     | 40 ++++++++++++++++++----------------------
 hw/bt/hid.c     |  2 +-
 hw/bt/l2cap.c   | 47 ++++++++++++++++++++++++-----------------------
 hw/bt/sdp.c     |  7 ++++---
 6 files changed, 65 insertions(+), 67 deletions(-)

diff --git a/hw/bt/core.c b/hw/bt/core.c
index c1806b71a3..e588eae6d2 100644
--- a/hw/bt/core.c
+++ b/hw/bt/core.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "sysemu/bt.h"
 #include "hw/bt.h"
@@ -31,24 +32,22 @@ static void bt_dummy_lmp_mode_change(struct bt_link_s *link)
 static void bt_dummy_lmp_connection_complete(struct bt_link_s *link)
 {
     if (link->slave->reject_reason)
-        fprintf(stderr, "%s: stray LMP_not_accepted received, fixme\n",
-                        __func__);
+        error_report("%s: stray LMP_not_accepted received, fixme", __func__);
     else
-        fprintf(stderr, "%s: stray LMP_accepted received, fixme\n",
-                        __func__);
+        error_report("%s: stray LMP_accepted received, fixme", __func__);
     exit(-1);
 }
 
 static void bt_dummy_lmp_disconnect_master(struct bt_link_s *link)
 {
-    fprintf(stderr, "%s: stray LMP_detach received, fixme\n", __func__);
+    fprintf(stderr, "%s: stray LMP_detach received, fixme", __func__);
     exit(-1);
 }
 
 static void bt_dummy_lmp_acl_resp(struct bt_link_s *link,
                 const uint8_t *data, int start, int len)
 {
-    fprintf(stderr, "%s: stray ACL response PDU, fixme\n", __func__);
+    error_report("%s: stray ACL response PDU, fixme", __func__);
     exit(-1);
 }
 
@@ -113,8 +112,8 @@ void bt_device_done(struct bt_device_s *dev)
     while (*p && *p != dev)
         p = &(*p)->next;
     if (*p != dev) {
-        fprintf(stderr, "%s: bad bt device \"%s\"\n", __func__,
-                        dev->lmp_name ?: "(null)");
+        error_report("%s: bad bt device \"%s\"", __func__,
+                     dev->lmp_name ?: "(null)");
         exit(-1);
     }
 
diff --git a/hw/bt/hci-csr.c b/hw/bt/hci-csr.c
index ac067b81f6..0341ded50c 100644
--- a/hw/bt/hci-csr.c
+++ b/hw/bt/hci-csr.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "chardev/char-serial.h"
 #include "qemu/timer.h"
@@ -111,14 +112,14 @@ static uint8_t *csrhci_out_packet(struct csrhci_s *s, int len)
 
     if (off < FIFO_LEN) {
         if (off + len > FIFO_LEN && (s->out_size = off + len) > FIFO_LEN * 2) {
-            fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
+            error_report("%s: can't alloc %i bytes", __func__, len);
             exit(-1);
         }
         return s->outfifo + off;
     }
 
     if (s->out_len > s->out_size) {
-        fprintf(stderr, "%s: can't alloc %i bytes\n", __func__, len);
+        error_report("%s: can't alloc %i bytes", __func__, len);
         exit(-1);
     }
 
@@ -168,10 +169,10 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s, int ocf,
             s->bd_addr.b[5] = data[offset + 2];
 
             s->hci->bdaddr_set(s->hci, s->bd_addr.b);
-            fprintf(stderr, "%s: bd_address loaded from firmware: "
-                            "%02x:%02x:%02x:%02x:%02x:%02x\n", __func__,
-                            s->bd_addr.b[0], s->bd_addr.b[1], s->bd_addr.b[2],
-                            s->bd_addr.b[3], s->bd_addr.b[4], s->bd_addr.b[5]);
+            error_report("%s: bd_address loaded from firmware: "
+                         "%02x:%02x:%02x:%02x:%02x:%02x", __func__,
+                         s->bd_addr.b[0], s->bd_addr.b[1], s->bd_addr.b[2],
+                         s->bd_addr.b[3], s->bd_addr.b[4], s->bd_addr.b[5]);
         }
 
         rpkt = csrhci_out_packet_event(s, EVT_VENDOR, 11);
@@ -181,7 +182,7 @@ static void csrhci_in_packet_vendor(struct csrhci_s *s, int ocf,
         break;
 
     default:
-        fprintf(stderr, "%s: got a bad CMD packet\n", __func__);
+        error_report("%s: got a bad CMD packet", __func__);
         return;
     }
 
@@ -226,7 +227,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
     case H4_NEG_PKT:
         if (s->in_hdr != sizeof(csrhci_neg_packet) ||
                         memcmp(pkt - 1, csrhci_neg_packet, s->in_hdr)) {
-            fprintf(stderr, "%s: got a bad NEG packet\n", __func__);
+            error_report("%s: got a bad NEG packet", __func__);
             return;
         }
         pkt += 2;
@@ -241,7 +242,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
 
     case H4_ALIVE_PKT:
         if (s->in_hdr != 4 || pkt[1] != 0x55 || pkt[2] != 0x00) {
-            fprintf(stderr, "%s: got a bad ALIVE packet\n", __func__);
+            error_report("%s: got a bad ALIVE packet", __func__);
             return;
         }
 
@@ -254,7 +255,7 @@ static void csrhci_in_packet(struct csrhci_s *s, uint8_t *pkt)
     default:
     bad_pkt:
         /* TODO: error out */
-        fprintf(stderr, "%s: got a bad packet\n", __func__);
+        error_report("%s: got a bad packet", __func__);
         break;
     }
 
diff --git a/hw/bt/hci.c b/hw/bt/hci.c
index df05f07887..c6b2cc1d48 100644
--- a/hw/bt/hci.c
+++ b/hw/bt/hci.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
@@ -457,8 +458,7 @@ static inline uint8_t *bt_hci_event_start(struct bt_hci_s *hci,
     int mask_byte;
 
     if (len > 255) {
-        fprintf(stderr, "%s: HCI event params too long (%ib)\n",
-                        __func__, len);
+        error_report("%s: HCI event params too long (%ib)", __func__, len);
         exit(-1);
     }
 
@@ -589,8 +589,8 @@ static void bt_hci_inquiry_result(struct bt_hci_s *hci,
         bt_hci_inquiry_result_with_rssi(hci, slave);
         return;
     default:
-        fprintf(stderr, "%s: bad inquiry mode %02x\n", __func__,
-                        hci->lm.inquiry_mode);
+        error_report("%s: bad inquiry mode %02x", __func__,
+                     hci->lm.inquiry_mode);
         exit(-1);
     }
 }
@@ -1971,8 +1971,7 @@ static void bt_submit_hci(struct HCIInfo *info,
         break;
 
     short_hci:
-        fprintf(stderr, "%s: HCI packet too short (%iB)\n",
-                        __func__, length);
+        error_report("%s: HCI packet too short (%iB)", __func__, length);
         bt_hci_event_status(hci, HCI_INVALID_PARAMETERS);
         break;
     }
@@ -1991,8 +1990,8 @@ static inline void bt_hci_lmp_acl_data(struct bt_hci_s *hci, uint16_t handle,
     /* TODO: avoid memcpy'ing */
 
     if (len + HCI_ACL_HDR_SIZE > sizeof(hci->acl_buf)) {
-        fprintf(stderr, "%s: can't take ACL packets %i bytes long\n",
-                        __func__, len);
+        error_report("%s: can't take ACL packets %i bytes long",
+                     __func__, len);
         return;
     }
     memcpy(hci->acl_buf + HCI_ACL_HDR_SIZE, data, len);
@@ -2029,8 +2028,7 @@ static void bt_submit_acl(struct HCIInfo *info,
     struct bt_link_s *link;
 
     if (length < HCI_ACL_HDR_SIZE) {
-        fprintf(stderr, "%s: ACL packet too short (%iB)\n",
-                        __func__, length);
+        error_report("%s: ACL packet too short (%iB)", __func__, length);
         return;
     }
 
@@ -2041,16 +2039,15 @@ static void bt_submit_acl(struct HCIInfo *info,
     length -= HCI_ACL_HDR_SIZE;
 
     if (bt_hci_handle_bad(hci, handle)) {
-        fprintf(stderr, "%s: invalid ACL handle %03x\n",
-                        __func__, handle);
+        error_report("%s: invalid ACL handle %03x", __func__, handle);
         /* TODO: signal an error */
         return;
     }
     handle &= ~HCI_HANDLE_OFFSET;
 
     if (datalen > length) {
-        fprintf(stderr, "%s: ACL packet too short (%iB < %iB)\n",
-                        __func__, length, datalen);
+        error_report("%s: ACL packet too short (%iB < %iB)",
+                     __func__, length, datalen);
         return;
     }
 
@@ -2060,8 +2057,8 @@ static void bt_submit_acl(struct HCIInfo *info,
         if (!hci->asb_handle)
             hci->asb_handle = handle;
         else if (handle != hci->asb_handle) {
-            fprintf(stderr, "%s: Bad handle %03x in Active Slave Broadcast\n",
-                            __func__, handle);
+            error_report("%s: Bad handle %03x in Active Slave Broadcast",
+                         __func__, handle);
             /* TODO: signal an error */
             return;
         }
@@ -2073,7 +2070,7 @@ static void bt_submit_acl(struct HCIInfo *info,
         if (!hci->psb_handle)
             hci->psb_handle = handle;
         else if (handle != hci->psb_handle) {
-            fprintf(stderr, "%s: Bad handle %03x in Parked Slave Broadcast\n",
+            error_report("%s: Bad handle %03x in Parked Slave Broadcast",
                             __func__, handle);
             /* TODO: signal an error */
             return;
@@ -2105,14 +2102,13 @@ static void bt_submit_sco(struct HCIInfo *info,
     length -= 3;
 
     if (bt_hci_handle_bad(hci, handle)) {
-        fprintf(stderr, "%s: invalid SCO handle %03x\n",
-                        __func__, handle);
+        error_report("%s: invalid SCO handle %03x", __func__, handle);
         return;
     }
 
     if (datalen > length) {
-        fprintf(stderr, "%s: SCO packet too short (%iB < %iB)\n",
-                        __func__, length, datalen);
+        error_report("%s: SCO packet too short (%iB < %iB)",
+                     __func__, length, datalen);
         return;
     }
 
@@ -2223,7 +2219,7 @@ struct HCIInfo *hci_init(const char *str)
            return bt_new_hci(vlan);
     }
 
-    fprintf(stderr, "qemu: Unknown bluetooth HCI `%s'.\n", str);
+    error_report("Unknown bluetooth HCI `%s'.", str);
 
     return 0;
 }
diff --git a/hw/bt/hid.c b/hw/bt/hid.c
index 09d17322e4..056291f9b5 100644
--- a/hw/bt/hid.c
+++ b/hw/bt/hid.c
@@ -419,7 +419,7 @@ static void bt_hid_interrupt_sdu(void *opaque, const uint8_t *data, int len)
 
     return;
 bad:
-    fprintf(stderr, "%s: bad transaction on Interrupt channel.\n",
+    error_report("%s: bad transaction on Interrupt channel.",
                     __func__);
 }
 
diff --git a/hw/bt/l2cap.c b/hw/bt/l2cap.c
index 3e53dd082d..9cf27f0df6 100644
--- a/hw/bt/l2cap.c
+++ b/hw/bt/l2cap.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
@@ -467,8 +468,8 @@ static void l2cap_channel_close(struct l2cap_instance_s *l2cap,
 
     if (likely(ch)) {
         if (ch->remote_cid != source_cid) {
-            fprintf(stderr, "%s: Ignoring a Disconnection Request with the "
-                            "invalid SCID %04x.\n", __func__, source_cid);
+            error_report("%s: Ignoring a Disconnection Request with the "
+                            "invalid SCID %04x.", __func__, source_cid);
             return;
         }
 
@@ -790,7 +791,7 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
 #if 0
     /* TODO: do the IDs really have to be in sequence?  */
     if (!id || (id != l2cap->last_id && id != l2cap->next_id)) {
-        fprintf(stderr, "%s: out of sequence command packet ignored.\n",
+        error_report("%s: out of sequence command packet ignored.",
                         __func__);
         return;
     }
@@ -813,9 +814,9 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
         }
 
         /* We never issue commands other than Command Reject currently.  */
-        fprintf(stderr, "%s: stray Command Reject (%02x, %04x) "
-                        "packet, ignoring.\n", __func__, id,
-                        le16_to_cpu(((l2cap_cmd_rej *) params)->reason));
+        error_report("%s: stray Command Reject (%02x, %04x) "
+                     "packet, ignoring.", __func__, id,
+                     le16_to_cpu(((l2cap_cmd_rej *) params)->reason));
         break;
 
     case L2CAP_CONN_REQ:
@@ -836,8 +837,8 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
         }
 
         /* We never issue Connection Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Connection Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Connection Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
 
     case L2CAP_CONF_REQ:
@@ -865,8 +866,8 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
                         le16_to_cpu(((l2cap_conf_rsp *) params)->scid),
                         ((l2cap_conf_rsp *) params)->data,
                         len - L2CAP_CONF_RSP_SIZE(0)))
-            fprintf(stderr, "%s: unexpected Configure Response (%02x) "
-                            "packet, ignoring.\n", __func__, id);
+            error_report("%s: unexpected Configure Response (%02x) "
+                         "packet, ignoring.", __func__, id);
         break;
 
     case L2CAP_DISCONN_REQ:
@@ -887,8 +888,8 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
         }
 
         /* We never issue Disconnection Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Disconnection Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Disconnection Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
 
     case L2CAP_ECHO_REQ:
@@ -897,8 +898,8 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
 
     case L2CAP_ECHO_RSP:
         /* We never issue Echo Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Echo Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Echo Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
 
     case L2CAP_INFO_REQ:
@@ -917,8 +918,8 @@ static void l2cap_command(struct l2cap_instance_s *l2cap, int code, int id,
         }
 
         /* We never issue Information Requests currently. TODO  */
-        fprintf(stderr, "%s: unexpected Information Response (%02x) "
-                        "packet, ignoring.\n", __func__, id);
+        error_report("%s: unexpected Information Response (%02x) "
+                     "packet, ignoring.", __func__, id);
         break;
 
     default:
@@ -1066,8 +1067,8 @@ static void l2cap_frame_in(struct l2cap_instance_s *l2cap,
     uint16_t len = le16_to_cpu(frame->len);
 
     if (unlikely(cid >= L2CAP_CID_MAX || !l2cap->cid[cid])) {
-        fprintf(stderr, "%s: frame addressed to a non-existent L2CAP "
-                        "channel %04x received.\n", __func__, cid);
+        error_report("%s: frame addressed to a non-existent L2CAP "
+                     "channel %04x received.", __func__, cid);
         return;
     }
 
@@ -1128,9 +1129,9 @@ static uint8_t *l2cap_bframe_out(struct bt_l2cap_conn_params_s *parm, int len)
     struct l2cap_chan_s *chan = (struct l2cap_chan_s *) parm;
 
     if (len > chan->params.remote_mtu) {
-        fprintf(stderr, "%s: B-Frame for CID %04x longer than %i octets.\n",
-                        __func__,
-                        chan->remote_cid, chan->params.remote_mtu);
+        error_report("%s: B-Frame for CID %04x longer than %i octets.",
+                     __func__,
+                     chan->remote_cid, chan->params.remote_mtu);
         exit(-1);
     }
 
@@ -1353,8 +1354,8 @@ void bt_l2cap_psm_register(struct bt_l2cap_device_s *dev, int psm, int min_mtu,
     struct bt_l2cap_psm_s *new_psm = l2cap_psm(dev, psm);
 
     if (new_psm) {
-        fprintf(stderr, "%s: PSM %04x already registered for device `%s'.\n",
-                        __func__, psm, dev->device.lmp_name);
+        error_report("%s: PSM %04x already registered for device `%s'.",
+                     __func__, psm, dev->device.lmp_name);
         exit(-1);
     }
 
diff --git a/hw/bt/sdp.c b/hw/bt/sdp.c
index 7c0d38b504..f4aba9d74f 100644
--- a/hw/bt/sdp.c
+++ b/hw/bt/sdp.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qemu-common.h"
 #include "qemu/host-utils.h"
 #include "hw/bt.h"
@@ -506,7 +507,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uint8_t *data, int len)
     int rsp_len = 0;
 
     if (len < 5) {
-        fprintf(stderr, "%s: short SDP PDU (%iB).\n", __func__, len);
+        error_report("%s: short SDP PDU (%iB).", __func__, len);
         return;
     }
 
@@ -517,7 +518,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uint8_t *data, int len)
     len -= 5;
 
     if (len != plen) {
-        fprintf(stderr, "%s: wrong SDP PDU length (%iB != %iB).\n",
+        error_report("%s: wrong SDP PDU length (%iB != %iB).",
                         __func__, plen, len);
         err = SDP_INVALID_PDU_SIZE;
         goto respond;
@@ -544,7 +545,7 @@ static void bt_l2cap_sdp_sdu_in(void *opaque, const uint8_t *data, int len)
     case SDP_SVC_SEARCH_RSP:
     case SDP_SVC_SEARCH_ATTR_RSP:
     default:
-        fprintf(stderr, "%s: unexpected SDP PDU ID %02x.\n",
+        error_report("%s: unexpected SDP PDU ID %02x.",
                         __func__, pdu_id);
         err = SDP_INVALID_SYNTAX;
         break;
-- 
2.14.1
