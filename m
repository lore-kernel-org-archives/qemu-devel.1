Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE449C2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56EB2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 08:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56EB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih8Yi-0007Xl-53
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 03:50:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ih8XL-00062J-A8
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ih8XJ-0002uk-V6
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:48:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ih8XJ-0002u5-Np
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 03:48:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBH8lMSR067339
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 03:48:57 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wxpvwgk3c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 03:48:56 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Tue, 17 Dec 2019 08:48:54 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Dec 2019 08:48:52 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBH8mpbN41615706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2019 08:48:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44B9652051;
 Tue, 17 Dec 2019 08:48:51 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6BC5A52059;
 Tue, 17 Dec 2019 08:48:50 +0000 (GMT)
Subject: [PATCH v4 2/4] nvdimm: add uuid property to nvdimm
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: imammedo@redhat.com, mst@redhat.com, xiaoguangrong.eric@gmail.com,
 david@gibson.dropbear.id.au
Date: Tue, 17 Dec 2019 02:48:49 -0600
In-Reply-To: <157657241446.53829.7078678659499762596.stgit@lep8c.aus.stglabs.ibm.com>
References: <157657241446.53829.7078678659499762596.stgit@lep8c.aus.stglabs.ibm.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121708-4275-0000-0000-0000038FD96F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121708-4276-0000-0000-000038A39E4B
Message-Id: <157657250781.53829.2713365565241605642.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=2 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170077
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For ppc64, PAPR requires the nvdimm device to have UUID property
set in the device tree. Add an option to get it from the user.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 hw/mem/nvdimm.c         |   40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/mem/nvdimm.h |    7 +++++++
 2 files changed, 47 insertions(+)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 375f9a588a..e1238b5bed 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -69,11 +69,51 @@ out:
     error_propagate(errp, local_err);
 }
 
+static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    char *value = NULL;
+
+    value = qemu_uuid_unparse_strdup(&nvdimm->uuid);
+
+    visit_type_str(v, name, &value, errp);
+    g_free(value);
+}
+
+
+static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+    Error *local_err = NULL;
+    char *value;
+
+    visit_type_str(v, name, &value, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
+        error_setg(errp, "Property '%s.%s' has invalid value",
+                   object_get_typename(obj), name);
+        goto out;
+    }
+    g_free(value);
+
+out:
+    error_propagate(errp, local_err);
+}
+
+
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
+
+    object_property_add(obj, NVDIMM_UUID_PROP, "QemuUUID", nvdimm_get_uuid,
+                        nvdimm_set_uuid, NULL, NULL, NULL);
 }
 
 static void nvdimm_finalize(Object *obj)
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..4807ca615b 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
 
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "qemu/uuid.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -49,6 +50,7 @@
                                                TYPE_NVDIMM)
 
 #define NVDIMM_LABEL_SIZE_PROP "label-size"
+#define NVDIMM_UUID_PROP       "uuid"
 #define NVDIMM_UNARMED_PROP    "unarmed"
 
 struct NVDIMMDevice {
@@ -83,6 +85,11 @@ struct NVDIMMDevice {
      * the guest write persistence.
      */
     bool unarmed;
+
+    /*
+     * The PPC64 - spapr requires each nvdimm device have a uuid.
+     */
+    QemuUUID uuid;
 };
 typedef struct NVDIMMDevice NVDIMMDevice;
 


