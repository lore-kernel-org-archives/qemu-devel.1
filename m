Received: from eggs.gnu.org ([2001:4830:134:3::10]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJ6-0006vB-WC
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6EJ1-00063b-Bc
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6EJ1-00062I-3F
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:48:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v44AiRxM084830
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 06:48:17 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7ux51t01-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 06:48:17 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 4 May 2017 11:48:15 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Thu,  4 May 2017 12:48:02 +0200
In-Reply-To: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
References: <20170504104806.8120-1-cornelia.huck@de.ibm.com>
Message-Id: <20170504104806.8120-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 4/8] s390x/3270: Add emulated terminal3270 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Yang Chen <bjcyang@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Yang Chen <bjcyang@linux.vnet.ibm.com>

This is a basic implementation of the emulated ccw-attached 3270
called x-terminal3270, which provides visibility of the device in
the qemu monitor and guest. The x prefix indicates that this is
just an experimental implementation for the current stage. This
device will not be compiled until the basic functions are available.

Signed-off-by: Yang Chen <bjcyang@linux.vnet.ibm.com>
Signed-off-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/char/terminal3270.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 hw/char/terminal3270.c

diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
new file mode 100644
index 0000000000..bef3812c18
--- /dev/null
+++ b/hw/char/terminal3270.c
@@ -0,0 +1,54 @@
+/*
+ * Terminal 3270 implementation
+ *
+ * Copyright 2017 IBM Corp.
+ *
+ * Authors: Yang Chen <bjcyang@linux.vnet.ibm.com>
+ *          Jing Liu <liujbjl@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/s390x/3270-ccw.h"
+
+typedef struct Terminal3270 {
+    EmulatedCcw3270Device cdev;
+} Terminal3270;
+
+#define TYPE_TERMINAL_3270 "x-terminal3270"
+
+static void terminal_init(EmulatedCcw3270Device *dev, Error **errp)
+{
+    static bool terminal_available;
+
+    if (terminal_available) {
+        error_setg(errp, "Multiple 3270 terminals are not supported.");
+        return;
+    }
+    terminal_available = true;
+}
+
+static void terminal_class_init(ObjectClass *klass, void *data)
+{
+    EmulatedCcw3270Class *ck = EMULATED_CCW_3270_CLASS(klass);
+
+    ck->init = terminal_init;
+}
+
+static const TypeInfo ccw_terminal_info = {
+    .name = TYPE_TERMINAL_3270,
+    .parent = TYPE_EMULATED_CCW_3270,
+    .instance_size = sizeof(Terminal3270),
+    .class_init = terminal_class_init,
+    .class_size = sizeof(EmulatedCcw3270Class),
+};
+
+static void register_types(void)
+{
+    type_register_static(&ccw_terminal_info);
+}
+
+type_init(register_types)
-- 
2.11.0
