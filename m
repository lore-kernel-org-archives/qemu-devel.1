Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA8BC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3302084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3302084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35933 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvYn-0004u2-4l
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:45:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFh-0002LE-4J
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFf-0002Sg-CX
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:25:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFe-0002RA-PD; Fri, 12 Apr 2019 08:25:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAF01308621C;
	Fri, 12 Apr 2019 12:25:48 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A87FD5D9CC;
	Fri, 12 Apr 2019 12:25:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:13 +0200
Message-Id: <20190412122523.24111-8-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 12:25:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 07/17] s390-bios:
 ptr2u32 and u32toptr
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122513.u89jfMdVgc8MjgqhED7dDBjxzxz1I44V1oa_cW9nao8@z>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Introduce inline functions to convert between pointers and unsigned 32-bi=
t
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
index 0000000000..78d5bc7442
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
+ * This work is licensed under the terms of the GNU GPL, version 2 or (a=
t
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
+    IPL_assert((uint64_t)ptr <=3D 0xffffffff, "ptr2u32: ptr too large");
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
--=20
2.21.0


