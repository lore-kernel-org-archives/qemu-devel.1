Received: from eggs.gnu.org ([2001:4830:134:3::10]:60176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJD-0006zZ-7h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJ7-0006AG-VG
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6EJ7-00069P-MK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44AiODM119687
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 06:48:24 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7vsy7sse-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 06:48:24 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 4 May 2017 11:48:21 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  4 May 2017 12:48:05 +0200
In-Reply-To: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
References: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Message-Id: <20170504104806.8120-8-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 7/8] s390x/3270: Detect for continued presence
 of a 3270 client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Jing Liu <liujbjl@linux.vnet.ibm.com>

To ensure that we do not keep any 3270 sockets where the client is not
connected anymore, we send a packet with the timing mark option after
ten minutes of client inactivity. If the client does not answer it,
then the socket will be closed automatically.

This helps to ensure that there is no half-open situation on the 3270
socket.

Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/char/terminal3270.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 450608e3c3..58bcc4be15 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -32,6 +32,7 @@ typedef struct Terminal3270 {
     int in_len;
     int out_len;
     bool handshake_done;
+    guint timer_tag;
 } Terminal3270;
 
 #define TYPE_TERMINAL_3270 "x-terminal3270"
@@ -60,6 +61,19 @@ static void TN3270_handshake_done(Terminal3270 *t)
 }
 
 /*
+ * Called when the interval is timeout to detect
+ * if the client is still alive by Timing Mark.
+ */
+static gboolean send_timing_mark_cb(gpointer opaque)
+{
+    Terminal3270 *t = opaque;
+    const uint8_t timing[] = {0xff, 0xfd, 0x06};
+
+    qemu_chr_fe_write_all(&t->chr, timing, sizeof(timing));
+    return true;
+}
+
+/*
  * Receive inbound data from socket.
  * For data given to guest, drop the data boundary IAC, IAC_EOR.
  * TODO:
@@ -77,6 +91,12 @@ static void terminal_read(void *opaque, const uint8_t *buf, int size)
 
     assert(size <= (INPUT_BUFFER_SIZE - t->in_len));
 
+    if (t->timer_tag) {
+        g_source_remove(t->timer_tag);
+        t->timer_tag = 0;
+    }
+    t->timer_tag = g_timeout_add_seconds(600, send_timing_mark_cb, t);
+
     memcpy(&t->inv[t->in_len], buf, size);
     t->in_len += size;
     if (t->in_len < 2) {
@@ -127,6 +147,10 @@ static void chr_event(void *opaque, int event)
     t->in_len = 0;
     t->out_len = 0;
     t->handshake_done = false;
+    if (t->timer_tag) {
+        g_source_remove(t->timer_tag);
+        t->timer_tag = 0;
+    }
 
     switch (event) {
     case CHR_EVENT_OPENED:
@@ -135,6 +159,7 @@ static void chr_event(void *opaque, int event)
          * char-socket.c. Once qemu receives the terminal-type of the
          * client, mark handshake done and trigger everything rolling again.
          */
+        t->timer_tag = g_timeout_add_seconds(600, send_timing_mark_cb, t);
         break;
     case CHR_EVENT_CLOSED:
         sch->curr_status.scsw.dstat = SCSW_DSTAT_DEVICE_END;
@@ -206,11 +231,13 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd,
     assert(count <= (OUTPUT_BUFFER_SIZE - 3) / 2);
 
     if (!t->handshake_done) {
-        /*
-         * Before having finished 3270 negotiation,
-         * sending outbound data is prohibited.
-         */
-        return 0;
+        if (!(t->outv[0] == IAC && t->outv[1] != IAC)) {
+            /*
+             * Before having finished 3270 negotiation,
+             * sending outbound data except protocol options is prohibited.
+             */
+            return 0;
+        }
     }
     if (!qemu_chr_fe_get_driver(&t->chr)) {
         /* We just say we consumed all data if there's no backend. */
-- 
2.11.0
