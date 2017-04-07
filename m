Received: from eggs.gnu.org ([2001:4830:134:3::10]:60810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cwRvG-0008GG-6s
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cwRvC-0004YZ-4L
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cwRvB-0004YM-QU
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 07:19:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v37BJGEG012703
	for <qemu-devel@nongnu.org>; Fri, 7 Apr 2017 07:19:16 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29p6g61tp4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:19:16 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 7 Apr 2017 12:19:13 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri,  7 Apr 2017 13:18:47 +0200
In-Reply-To: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
References: <20170407111851.20680-1-cornelia.huck@de.ibm.com>
Message-Id: <20170407111851.20680-5-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH v2 for-2.10 4/8] s390x/3270: Add emulated
 terminal3270 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, marcandre.lureau@redhat.com, Yang Chen <bjcyang@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

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
