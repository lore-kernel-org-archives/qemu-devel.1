Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB02C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA522081C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA522081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57073 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeLq-0004X9-6w
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:23:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeK0-0003Hb-0l
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJz-0003fx-4A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeJy-0003fa-VC; Thu, 25 Apr 2019 09:21:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 350843091783;
	Thu, 25 Apr 2019 13:21:50 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D69BD60BE5;
	Thu, 25 Apr 2019 13:21:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:22 +0200
Message-Id: <20190425132134.2839-8-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 13:21:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 07/19] s390-bios: ptr2u32 and u32toptr
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132122.a9Z20ksirZj8S1nyqCiqfYOr634filU_Y7mrhUw-EJM@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Introduce inline functions to convert between pointers and unsigned 32-bit
ints. These are used to hide the ugliness required to  avoid compiler
warnings.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-8-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/helper.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 pc-bios/s390-ccw/helper.h

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
new file mode 100644
index 000000000000..78d5bc74421b
--- /dev/null
+++ b/pc-bios/s390-ccw/helper.h
@@ -0,0 +1,31 @@
+/*
+ * Helper Functions
+ *
+ * Copyright (c) 2019 IBM Corp.
+ *
+ * Author(s): Jason J. Herne <jjherne@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef S390_CCW_HELPER_H
+#define S390_CCW_HELPER_H
+
+#include "s390-ccw.h"
+
+/* Avoids compiler warnings when casting a pointer to a u32 */
+static inline uint32_t ptr2u32(void *ptr)
+{
+    IPL_assert((uint64_t)ptr <= 0xffffffff, "ptr2u32: ptr too large");
+    return (uint32_t)(uint64_t)ptr;
+}
+
+/* Avoids compiler warnings when casting a u32 to a pointer */
+static inline void *u32toptr(uint32_t n)
+{
+    return (void *)(uint64_t)n;
+}
+
+#endif
-- 
2.17.2


