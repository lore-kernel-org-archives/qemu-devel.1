Received: from eggs.gnu.org ([2001:4830:134:3::10]:60154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJB-0006yG-B7
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJ4-00066t-GZ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6EJ4-00065v-89
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44Ai6DB044919
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 06:48:21 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7vc3h1kt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 06:48:20 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 4 May 2017 11:48:18 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  4 May 2017 12:48:04 +0200
In-Reply-To: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
References: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Message-Id: <20170504104806.8120-7-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 6/8] s390x/3270: Add the TCP socket events
 handler for 3270
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

This introduces a chr_event handler to handle the 3270 connection
and disconnection events.

Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/char/terminal3270.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
index 55eed5622a..450608e3c3 100644
--- a/hw/char/terminal3270.c
+++ b/hw/char/terminal3270.c
@@ -117,6 +117,32 @@ static void terminal_read(void *opaque, const uint8_t *buf, int size)
     }
 }
 
+static void chr_event(void *opaque, int event)
+{
+    Terminal3270 *t = opaque;
+    CcwDevice *ccw_dev = CCW_DEVICE(t);
+    SubchDev *sch = ccw_dev->sch;
+
+    /* Ensure the initial status correct, always reset them. */
+    t->in_len = 0;
+    t->out_len = 0;
+    t->handshake_done = false;
+
+    switch (event) {
+    case CHR_EVENT_OPENED:
+        /*
+         * 3270 does handshake firstly by the negotiate options in
+         * char-socket.c. Once qemu receives the terminal-type of the
+         * client, mark handshake done and trigger everything rolling again.
+         */
+        break;
+    case CHR_EVENT_CLOSED:
+        sch->curr_status.scsw.dstat = SCSW_DSTAT_DEVICE_END;
+        css_conditional_io_interrupt(sch);
+        break;
+    }
+}
+
 static void terminal_init(EmulatedCcw3270Device *dev, Error **errp)
 {
     Terminal3270 *t = TERMINAL_3270(dev);
@@ -128,7 +154,7 @@ static void terminal_init(EmulatedCcw3270Device *dev, Error **errp)
     }
     terminal_available = true;
     qemu_chr_fe_set_handlers(&t->chr, terminal_can_read,
-                             terminal_read, NULL, t, NULL, true);
+                             terminal_read, chr_event, t, NULL, true);
 }
 
 static int read_payload_3270(EmulatedCcw3270Device *dev, uint32_t cda,
-- 
2.11.0
