Received: from eggs.gnu.org ([2001:4830:134:3::10]:59004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRS-0006Ln-L1
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRP-00084S-I3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRP-00083m-9T
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:11 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:41 +0200
Message-Id: <20171006095956.27534-19-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 18/33] s390x/3270: IDA support for 3270 via
 CcwDataStream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

Let us convert the 3270 code so it uses the recently introduced
CcwDataStream abstraction instead of blindly assuming direct data access.

This patch does not change behavior beyond introducing IDA support: for
direct data access CCWs everything stays as-is. (If there are bugs, they
are also preserved).

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170920172314.102710-2-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/char/terminal3270.c      | 18 +++++++++++-------
 hw/s390x/3270-ccw.c         |  4 ++--
 include/hw/s390x/3270-ccw.h |  5 ++---
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 28f599111d..c976a63cc2 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -182,14 +182,18 @@ static void terminal_init(EmulatedCcw3270Device *dev, Error **errp)
                              terminal_read, chr_event, NULL, t, NULL, true);
 }
 
-static int read_payload_3270(EmulatedCcw3270Device *dev, uint32_t cda,
-                             uint16_t count)
+static inline CcwDataStream *get_cds(Terminal3270 *t)
+{
+    return &(CCW_DEVICE(&t->cdev)->sch->cds);
+}
+
+static int read_payload_3270(EmulatedCcw3270Device *dev)
 {
     Terminal3270 *t = TERMINAL_3270(dev);
     int len;
 
-    len = MIN(count, t->in_len);
-    cpu_physical_memory_write(cda, t->inv, len);
+    len = MIN(ccw_dstream_avail(get_cds(t)), t->in_len);
+    ccw_dstream_write_buf(get_cds(t), t->inv, len);
     t->in_len -= len;
 
     return len;
@@ -222,11 +226,11 @@ static int insert_IAC_escape_char(uint8_t *outv, int out_len)
  * Write 3270 outbound to socket.
  * Return the count of 3270 data field if succeeded, zero if failed.
  */
-static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd,
-                              uint32_t cda, uint16_t count)
+static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd)
 {
     Terminal3270 *t = TERMINAL_3270(dev);
     int retval = 0;
+    int count = ccw_dstream_avail(get_cds(t));
 
     assert(count <= (OUTPUT_BUFFER_SIZE - 3) / 2);
 
@@ -244,7 +248,7 @@ static int write_payload_3270(EmulatedCcw3270Device *dev, uint8_t cmd,
         return count;
     }
     t->outv[0] = cmd;
-    cpu_physical_memory_read(cda, &t->outv[1], count);
+    ccw_dstream_read_buf(get_cds(t), &t->outv[1], count);
     t->out_len = count + 1;
 
     t->out_len = insert_IAC_escape_char(t->outv, t->out_len);
diff --git a/hw/s390x/3270-ccw.c b/hw/s390x/3270-ccw.c
index 1554aa2484..eaca28e224 100644
--- a/hw/s390x/3270-ccw.c
+++ b/hw/s390x/3270-ccw.c
@@ -28,7 +28,7 @@ static int handle_payload_3270_read(EmulatedCcw3270Device *dev, CCW1 *ccw)
         return -EFAULT;
     }
 
-    len = ck->read_payload_3270(dev, ccw->cda, ccw->count);
+    len = ck->read_payload_3270(dev);
     ccw_dev->sch->curr_status.scsw.count = ccw->count - len;
 
     return 0;
@@ -45,7 +45,7 @@ static int handle_payload_3270_write(EmulatedCcw3270Device *dev, CCW1 *ccw)
         return -EFAULT;
     }
 
-    len = ck->write_payload_3270(dev, ccw->cmd_code, ccw->cda, ccw->count);
+    len = ck->write_payload_3270(dev, ccw->cmd_code);
 
     if (len <= 0) {
         return -EIO;
diff --git a/include/hw/s390x/3270-ccw.h b/include/hw/s390x/3270-ccw.h
index 46bee2533c..9d1d18e2bd 100644
--- a/include/hw/s390x/3270-ccw.h
+++ b/include/hw/s390x/3270-ccw.h
@@ -45,9 +45,8 @@ typedef struct EmulatedCcw3270Class {
     CCWDeviceClass parent_class;
 
     void (*init)(EmulatedCcw3270Device *, Error **);
-    int (*read_payload_3270)(EmulatedCcw3270Device *, uint32_t, uint16_t);
-    int (*write_payload_3270)(EmulatedCcw3270Device *, uint8_t, uint32_t,
-                              uint16_t);
+    int (*read_payload_3270)(EmulatedCcw3270Device *);
+    int (*write_payload_3270)(EmulatedCcw3270Device *, uint8_t);
 } EmulatedCcw3270Class;
 
 #endif
-- 
2.13.6
