Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC9C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5497121019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5497121019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60289 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOG6q-0007Zv-HI
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:31:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFw9-0005GQ-GW
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFw8-0000JL-0Q
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:57358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOFw7-00005t-HU
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 23:20:13 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 23:20:11 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com, mst@redhat.com, eblake@redhat.com,
	ehabkost@redhat.com, xiaoguangrong.eric@gmail.com
Date: Wed,  8 May 2019 14:17:25 +0800
Message-Id: <20190508061726.27631-11-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 10/11] acpi: introduce build_acpi_aml_common
 for NFIT generalizations
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
Cc: pbonzini@redhat.com, tao3.xu@intel.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The aim of this patch is to move some of the NFIT Aml-build codes into
build_acpi_aml_common(), and then NFIT and HMAT can both use it.

Reviewed-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v4 -> v3:
    - Split 8/8 of patch v3 into two parts, introduces NFIT
    generalizations (build_acpi_aml_common)
---
 hw/acpi/nvdimm.c        | 49 +++++++++++++++++++++++++++--------------
 include/hw/mem/nvdimm.h |  6 +++++
 2 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..e2be79a8b7 100644
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
+    build_acpi_aml_common(method, buf, buf_size,
+                          call_result, buf_name, dev,
+                          "RFIT", "_FIT",
+                          NVDIMM_DSM_RET_STATUS_SUCCESS,
+                          NVDIMM_DSM_RET_STATUS_FIT_CHANGED);
+}
+
+void build_acpi_aml_common(Aml *method, Aml *buf, Aml *buf_size,
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
+    /* if we read the end of fit or hma. */
     ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
     aml_append(ifctx, aml_return(aml_buffer(0, NULL)));
     aml_append(method, ifctx);
@@ -1196,38 +1211,38 @@ static void nvdimm_build_fit(Aml *dev)
     aml_append(method, aml_return(aml_name("BUFF")));
     aml_append(dev, method);
 
-    /* build _FIT. */
-    method = aml_method("_FIT", 0, AML_SERIALIZED);
+    /* build _FIT or _HMA. */
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
+     * if buffer was changed during RFIT or RHMA,
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
+    /* finish fit or hma read if no data is read out. */
     ifctx = aml_if(aml_equal(buf_size, aml_int(0)));
-    aml_append(ifctx, aml_return(fit));
+    aml_append(ifctx, aml_return(buf_name));
     aml_append(elsectx, ifctx);
 
     /* update the offset. */
     aml_append(elsectx, aml_add(offset, buf_size, offset));
-    /* append the data we read out to the fit buffer. */
-    aml_append(elsectx, aml_concatenate(fit, buf, fit));
+    /* append the data we read out to the fit or hma buffer. */
+    aml_append(elsectx, aml_concatenate(buf_name, buf, buf_name));
     aml_append(whilectx, elsectx);
     aml_append(method, whilectx);
 
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..6f04eddb40 100644
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
+void build_acpi_aml_common(Aml *method, Aml *buf, Aml *buf_size,
+                           Aml *call_result, Aml *buf_name, Aml *dev,
+                           const char *help_function, const char *method_name,
+                           int ret_status_success,
+                           int ret_status_changed);
 #endif
-- 
2.17.1


