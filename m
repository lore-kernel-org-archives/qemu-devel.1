Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218F8ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:39:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFC7420873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC7420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5FQ-0001eH-3X
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:39:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1iK5EO-0000gu-Nw
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:38:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1iK5EN-0003gR-Hj
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:38:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26822
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1iK5EN-0003gH-Be
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:38:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9EIc4lJ149393
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:38:05 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vmwfr24ev-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:38:04 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Mon, 14 Oct 2019 19:37:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 14 Oct 2019 19:37:39 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x9EIbcgu44433456
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Oct 2019 18:37:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC3515204E;
 Mon, 14 Oct 2019 18:37:38 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D99AE52052;
 Mon, 14 Oct 2019 18:37:37 +0000 (GMT)
Subject: [PATCH v3 1/3] mem: move nvdimm_device_list to utilities
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, david@gibson.dropbear.id.au, qemu-ppc@nongnu.org,
 xiaoguangrong.eric@gmail.com, mst@redhat.com
Date: Mon, 14 Oct 2019 13:37:37 -0500
In-Reply-To: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101418-0012-0000-0000-000003580246
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101418-0013-0000-0000-000021931557
Message-Id: <157107825148.27733.10924648339824665145.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-14_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140150
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: sbhat@linux.vnet.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

nvdimm_device_list is required for parsing the list for devices
in subsequent patches. Move it to common utility area.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/acpi/nvdimm.c            |   28 +---------------------------
 include/qemu/nvdimm-utils.h |    7 +++++++
 util/Makefile.objs          |    1 +
 util/nvdimm-utils.c         |   29 +++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 27 deletions(-)
 create mode 100644 include/qemu/nvdimm-utils.h
 create mode 100644 util/nvdimm-utils.c

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..5219dd0e2e 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -32,33 +32,7 @@
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
-
-static int nvdimm_device_list(Object *obj, void *opaque)
-{
-    GSList **list = opaque;
-
-    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
-        *list = g_slist_append(*list, DEVICE(obj));
-    }
-
-    object_child_foreach(obj, nvdimm_device_list, opaque);
-    return 0;
-}
-
-/*
- * inquire NVDIMM devices and link them into the list which is
- * returned to the caller.
- *
- * Note: it is the caller's responsibility to free the list to avoid
- * memory leak.
- */
-static GSList *nvdimm_get_device_list(void)
-{
-    GSList *list = NULL;
-
-    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
-    return list;
-}
+#include "qemu/nvdimm-utils.h"
 
 #define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
    { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
diff --git a/include/qemu/nvdimm-utils.h b/include/qemu/nvdimm-utils.h
new file mode 100644
index 0000000000..4b8b198ba7
--- /dev/null
+++ b/include/qemu/nvdimm-utils.h
@@ -0,0 +1,7 @@
+#ifndef NVDIMM_UTILS_H
+#define NVDIMM_UTILS_H
+
+#include "qemu/osdep.h"
+
+GSList *nvdimm_get_device_list(void);
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 41bf59d127..a0f40d26e3 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -20,6 +20,7 @@ util-obj-y += envlist.o path.o module.o
 util-obj-y += host-utils.o
 util-obj-y += bitmap.o bitops.o hbitmap.o
 util-obj-y += fifo8.o
+util-obj-y += nvdimm-utils.o
 util-obj-y += cacheinfo.o
 util-obj-y += error.o qemu-error.o
 util-obj-y += qemu-print.o
diff --git a/util/nvdimm-utils.c b/util/nvdimm-utils.c
new file mode 100644
index 0000000000..5cc768ca47
--- /dev/null
+++ b/util/nvdimm-utils.c
@@ -0,0 +1,29 @@
+#include "qemu/nvdimm-utils.h"
+#include "hw/mem/nvdimm.h"
+
+static int nvdimm_device_list(Object *obj, void *opaque)
+{
+    GSList **list = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
+        *list = g_slist_append(*list, DEVICE(obj));
+    }
+
+    object_child_foreach(obj, nvdimm_device_list, opaque);
+    return 0;
+}
+
+/*
+ * inquire NVDIMM devices and link them into the list which is
+ * returned to the caller.
+ *
+ * Note: it is the caller's responsibility to free the list to avoid
+ * memory leak.
+ */
+GSList *nvdimm_get_device_list(void)
+{
+    GSList *list = NULL;
+
+    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
+    return list;
+}


