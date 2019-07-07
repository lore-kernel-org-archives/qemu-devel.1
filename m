Return-Path: <SRS0=qwNR=VE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CA0C48BDB
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:45:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD322082F
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2019 14:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD322082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hk8PT-0005b2-J0
	for qemu-devel@archiver.kernel.org; Sun, 07 Jul 2019 10:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49610)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tao3.xu@intel.com>) id 1hk8EE-0008Mn-IN
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1hk8EC-0003do-KG
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:31569)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hk8EA-00037I-H4
 for qemu-devel@nongnu.org; Sun, 07 Jul 2019 10:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jul 2019 07:33:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,462,1557212400"; d="scan'208";a="185497857"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.104])
 by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2019 07:32:59 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Sun,  7 Jul 2019 22:29:55 +0800
Message-Id: <20190707142958.31316-12-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190707142958.31316-1-tao3.xu@intel.com>
References: <20190707142958.31316-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.65
Subject: [Qemu-devel] [PATCH v6 11/14] acpi: introduce aml_build_runtime_buf
 for NFIT generalizations
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the _FIT method buff Aml-build codes into
aml_build_runtime_buf(), and then NFIT and HMAT can both use it.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v6:
    - Add more commit message and change the function name
---
 hw/acpi/nvdimm.c        | 49 +++++++++++++++++++++++++++--------------
 include/hw/mem/nvdimm.h |  6 +++++
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..0eb57245d3 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1140,12 +1140,11 @@ static void nvdimm_build_device_dsm(Aml *dev, uint32_t handle)
 
 static void nvdimm_build_fit(Aml *dev)
 {
-    Aml *method, *pkg, *buf, *buf_size, *offset, *call_result;
-    Aml *whilectx, *ifcond, *ifctx, *elsectx, *fit;
+    Aml *method, *pkg, *buf, *buf_name, *buf_size, *call_result;
 
     buf = aml_local(0);
     buf_size = aml_local(1);
-    fit = aml_local(2);
+    buf_name = aml_local(2);
 
     aml_append(dev, aml_name_decl(NVDIMM_DSM_RFIT_STATUS, aml_int(0)));
 
@@ -1164,6 +1163,22 @@ static void nvdimm_build_fit(Aml *dev)
                             aml_int(1) /* Revision 1 */,
                             aml_int(0x1) /* Read FIT */,
                             pkg, aml_int(NVDIMM_QEMU_RSVD_HANDLE_ROOT));
+
+    aml_build_runtime_buf(method, buf, buf_size,
+                          call_result, buf_name, dev,
+                          "RFIT", "_FIT",
+                          NVDIMM_DSM_RET_STATUS_SUCCESS,
+                          NVDIMM_DSM_RET_STATUS_FIT_CHANGED);
+}
+
+void aml_build_runtime_buf(Aml *method, Aml *buf, Aml *buf_size,
+                           Aml *call_result, Aml *buf_name, Aml *dev,
+                           const char *help_function, const char *method_name,
+                           int ret_status_success,
+                           int ret_status_changed)
+{
+    Aml *offset, *whilectx, *ifcond, *ifctx, *elsectx;
+
     aml_append(method, aml_store(call_result, buf));
 
     /* handle _DSM result. */
@@ -1174,7 +1189,7 @@ static void nvdimm_build_fit(Aml *dev)
                                  aml_name(NVDIMM_DSM_RFIT_STATUS)));
 
      /* if something is wrong during _DSM. */
-    ifcond = aml_equal(aml_int(NVDIMM_DSM_RET_STATUS_SUCCESS),
+    ifcond = aml_equal(aml_int(ret_status_success),
                        aml_name("STAU"));
     ifctx = aml_if(aml_lnot(ifcond));
     aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
@@ -1185,7 +1200,7 @@ static void nvdimm_build_fit(Aml *dev)
                                     aml_int(4) /* the size of "STAU" */,
                                     buf_size));
 
-    /* if we read the end of fit. */
+    /* if we read the end of buff method. */
     ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
     aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
     aml_append(method, ifctx);
@@ -1196,38 +1211,38 @@ static void nvdimm_build_fit(Aml *dev)
     aml_append(method, aml_return(aml_name("BUFF")));
     aml_append(dev, method);
 
-    /* build _FIT. */
-    method = aml_method("_FIT", 0, AML_SERIALIZED);
+    /* build buff method. */
+    method = aml_method(method_name, 0, AML_SERIALIZED);
     offset = aml_local(3);
 
-    aml_append(method, aml_store(aml_buffer(0, NULL), fit));
+    aml_append(method, aml_store(aml_buffer(0, NULL), buf_name));
     aml_append(method, aml_store(aml_int(0), offset));
 
     whilectx = aml_while(aml_int(1));
-    aml_append(whilectx, aml_store(aml_call1("RFIT", offset), buf));
+    aml_append(whilectx, aml_store(aml_call1(help_function, offset), buf));
     aml_append(whilectx, aml_store(aml_sizeof(buf), buf_size));
 
     /*
-     * if fit buffer was changed during RFIT, read from the beginning
-     * again.
+     * if buffer was changed during runtime,
+     * read from the beginning again.
      */
     ifctx = aml_if(aml_equal(aml_name(NVDIMM_DSM_RFIT_STATUS),
-                             aml_int(NVDIMM_DSM_RET_STATUS_FIT_CHANGED)));
-    aml_append(ifctx, aml_store(aml_buffer(0, NULL), fit));
+                             aml_int(ret_status_changed)));
+    aml_append(ifctx, aml_store(aml_buffer(0, NULL), buf_name));
     aml_append(ifctx, aml_store(aml_int(0), offset));
     aml_append(whilectx, ifctx);
 
     elsectx = aml_else();
 
-    /* finish fit read if no data is read out. */
+    /* finish buff read if no data is read out. */
     ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
-    aml_append(ifctx, aml_return(fit));
+    aml_append(ifctx, aml_return(buf_name));
     aml_append(elsectx, ifctx);
 
     /* update the offset. */
     aml_append(elsectx, aml_add(offset, buf_size, offset));
-    /* append the data we read out to the fit buffer. */
-    aml_append(elsectx, aml_concatenate(fit, buf, fit));
+    /* append the data we read out to the buffer. */
+    aml_append(elsectx, aml_concatenate(buf_name, buf, buf_name));
     aml_append(whilectx, elsectx);
     aml_append(method, whilectx);
 
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..95bbe044cb 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
 
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -150,4 +151,9 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        uint32_t ram_slots);
 void nvdimm_plug(NVDIMMState *state);
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev);
+void aml_build_runtime_buf(Aml *method, Aml *buf, Aml *buf_size,
+                           Aml *call_result, Aml *buf_name, Aml *dev,
+                           const char *help_function, const char *method_name,
+                           int ret_status_success,
+                           int ret_status_changed);
 #endif
-- 
2.20.1


