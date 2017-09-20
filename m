Received: from eggs.gnu.org ([2001:4830:134:3::10]:51664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duiiw-00057S-7v
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:23:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duiit-000624-Gp
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:23:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duiit-00060s-7d
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:23:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KHLteK093667
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:23:41 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3ueqmxu8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 13:23:40 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 18:23:38 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 19:23:14 +0200
In-Reply-To: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
Message-Id: <20170920172314.102710-3-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] s390x/3270: handle writes of arbitrary
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

The problem is, that the current implementation places unrealistic and
arbitrary constraints on the length of writes to the device (that is the
outbound requests), by asserting ccw.count being such that that even the
worst case escaped payload will fit an  more or less arbitrary sized
buffer. Actually on protocol level there is nothing to justify such
a limitation.

Another strange thing is the return value which more or less reflects
the size (written) after escaping instead of before escaping. This
is strange, because this return value is used to calculate SCSW.count.

Let us teach 3270 how to deal with arbitrary long writes.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reported-by: Jason J . Herne <jjherne@linux.vnet.ibm.com>
Tested-by: Jason J . Herne <jjherne@linux.vnet.ibm.com>
---
 hw/char/terminal3270.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index c976a63cc2..a109ce5987 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -30,7 +30,6 @@ typedef struct Terminal3270 {
     uint8_t inv[INPUT_BUFFER_SIZE];
     uint8_t outv[OUTPUT_BUFFER_SIZE];
     int in_len;
-    int out_len;
     bool handshake_done;
     guint timer_tag;
 } Terminal3270;
@@ -145,7 +144,6 @@ static void chr_event(void *opaque, int event)
 
     /* Ensure the initial status correct, always reset them. */
     t->in_len = 0;
-    t->out_len = 0;
     t->handshake_done = false;
     if (t->timer_tag) {
         g_source_remove(t->timer_tag);
@@ -231,8 +229,9 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd)
     Terminal3270 *t = TERMINAL_3270(dev);
     int retval = 0;
     int count = ccw_dstream_avail(get_cds(t));
-
-    assert(count <= (OUTPUT_BUFFER_SIZE - 3) / 2);
+    int bound = (OUTPUT_BUFFER_SIZE - 3) / 2;
+    int len = MIN(count, bound);
+    int out_len = 0;
 
     if (!t->handshake_done) {
         if (!(t->outv[0] == IAC && t->outv[1] != IAC)) {
@@ -247,16 +246,23 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd)
         /* We just say we consumed all data if there's no backend. */
         return count;
     }
-    t->outv[0] = cmd;
-    ccw_dstream_read_buf(get_cds(t), &t->outv[1], count);
-    t->out_len = count + 1;
 
-    t->out_len = insert_IAC_escape_char(t->outv, t->out_len);
-    t->outv[t->out_len++] = IAC;
-    t->outv[t->out_len++] = IAC_EOR;
+    t->outv[out_len++] = cmd;
+    do {
+        ccw_dstream_read_buf(get_cds(t), &t->outv[out_len], len);
+        count = ccw_dstream_avail(get_cds(t));
+        out_len += len;
 
-    retval = qemu_chr_fe_write_all(&t->chr, t->outv, t->out_len);
-    return (retval <= 0) ? 0 : (retval - 3);
+        out_len = insert_IAC_escape_char(t->outv, out_len);
+        if (!count) {
+            t->outv[out_len++] = IAC;
+            t->outv[out_len++] = IAC_EOR;
+        }
+        retval = qemu_chr_fe_write_all(&t->chr, t->outv, out_len);
+        len = MIN(count, bound);
+        out_len = 0;
+    } while (len && retval >= 0);
+    return (retval <= 0) ? 0 : get_cds(t)->count;
 }
 
 static Property terminal_properties[] = {
-- 
2.13.5
