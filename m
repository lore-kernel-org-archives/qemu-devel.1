Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA28C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B972067B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 14:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzbiMyTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B972067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjl2n-00071k-JJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 10:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1X-0005Cg-UH
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl1V-0001MI-MW
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezVaZ39w/Zt6S04FtdW+skZfwDczX4yGiWwy5FV/qKo=;
 b=ZzbiMyTfgVLqT7qu9Hy3w1MRBeWhRfiRht7Qu24WScpS7ia82m4KG5ZF4dRyMhGz8aXjRp
 b8YoSlOUVjoTlPcxkCpFZ7fMklxYqMMqeiMk/YL7z6xaVzKM34jdSR9C/r6wRb9SlL2Dn4
 07lOxX1xRTXHqPZvFBt63YseyhknShU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-b9gyMVJ9MiGJOKNPGi7sKA-1; Fri, 12 Jun 2020 10:51:11 -0400
X-MC-Unique: b9gyMVJ9MiGJOKNPGi7sKA-1
Received: by mail-wm1-f70.google.com with SMTP id t145so2545028wmt.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ezVaZ39w/Zt6S04FtdW+skZfwDczX4yGiWwy5FV/qKo=;
 b=cadq4J6pZc2IOE9Sfymdnuzq7HYzEtlhe0YzjoCF9nN9CbWxdoArP+vTFy4nzRHGJO
 5S7Pgac2chJQDt/iOXoN3uocYQz++ziu5EK6E2St33fu9rRW78STTF9j2GXcYM1LXvrY
 PgxUoYCLe5UckRqOTNSydd1iqeB75+MYnamerpPZh5ss+pzSykYUb3ZGDRyHO9hF2rJJ
 m7JmqCbUYvkMRk9wp3OKCUAes/KhWuRmr9Qzb1mJx6eEoPEiqp2OCYIY1hafOlmy84MF
 B4ND+niHn8OKEbayTAvMTuM93gbzHsSQCJ0D5lXxHq7WVS7NXzhEUEzumYCUtN1H3cNV
 PF8w==
X-Gm-Message-State: AOAM530Rj1fcy3TQEDfXUmA9J1nI5DOnRtTPDbb5OT7Mdz/iFHm/8QyX
 yxiYQSQO535Y+oBsz2hBjy65pTbzrVWyTQx2H4RbymB1WlRXIK5MFOtwRS2FMmuFrmy2jPXlFPI
 k8hTiMFWaky5rKdQ=
X-Received: by 2002:a1c:2082:: with SMTP id g124mr14255826wmg.21.1591973469590; 
 Fri, 12 Jun 2020 07:51:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEG0pJXLkOLT0yypGv25+q3tAYfMF2FkJ+8vRADgp1GU0Xko87chojkSQxIx77EuSNTk9gPA==
X-Received: by 2002:a1c:2082:: with SMTP id g124mr14255796wmg.21.1591973469321; 
 Fri, 12 Jun 2020 07:51:09 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id y5sm10767253wrs.63.2020.06.12.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:51:08 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:51:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 03/58] hw/acpi/nvdimm: add a helper to augment SRAT
 generation
Message-ID: <20200612141917.9446-4-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:00:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Jingqi Liu <jingqi.liu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vishal Verma <vishal.l.verma@intel.com>

NVDIMMs can belong to their own proximity domains, as described by the
NFIT. In such cases, the SRAT needs to have Memory Affinity structures
in the SRAT for these NVDIMMs, otherwise Linux doesn't populate node
data structures properly during NUMA initialization. See the following
for an example failure case.

https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/

Introduce a new helper, nvdimm_build_srat(), and call it for both the
i386 and arm versions of 'build_srat()' to augment the SRAT with
memory affinity information for NVDIMMs.

The relevant command line options to exercise this are below. Nodes 0-1
contain CPUs and regular memory, and nodes 2-3 are the NVDIMM address
space.

    -object memory-backend-ram,id=mem0,size=2048M
    -numa node,nodeid=0,memdev=mem0,
    -numa cpu,node-id=0,socket-id=0
    -object memory-backend-ram,id=mem1,size=2048M
    -numa node,nodeid=1,memdev=mem1,
    -numa cpu,node-id=1,socket-id=1
    -numa node,nodeid=2,
    -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=1G
    -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=2
    -numa node,nodeid=3,
    -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=1G
    -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=3

Cc: Jingqi Liu <jingqi.liu@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Message-Id: <20200606000911.9896-3-vishal.l.verma@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/mem/nvdimm.h  |  1 +
 hw/acpi/nvdimm.c         | 23 +++++++++++++++++++++++
 hw/arm/virt-acpi-build.c |  4 ++++
 hw/i386/acpi-build.c     |  5 +++++
 4 files changed, 33 insertions(+)

diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index a3c08955e8..b67a1aedf6 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -155,6 +155,7 @@ typedef struct NVDIMMState NVDIMMState;
 void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
                             struct AcpiGenericAddress dsm_io,
                             FWCfgState *fw_cfg, Object *owner);
+void nvdimm_build_srat(GArray *table_data);
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, NVDIMMState *state,
                        uint32_t ram_slots);
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9316d12b70..8f7cc16add 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -28,6 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/uuid.h"
+#include "qapi/error.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
@@ -1334,6 +1335,28 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
     free_aml_allocator();
 }
 
+void nvdimm_build_srat(GArray *table_data)
+{
+    GSList *device_list = nvdimm_get_device_list();
+
+    for (; device_list; device_list = device_list->next) {
+        AcpiSratMemoryAffinity *numamem = NULL;
+        DeviceState *dev = device_list->data;
+        Object *obj = OBJECT(dev);
+        uint64_t addr, size;
+        int node;
+
+        node = object_property_get_int(obj, PC_DIMM_NODE_PROP, &error_abort);
+        addr = object_property_get_uint(obj, PC_DIMM_ADDR_PROP, &error_abort);
+        size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, &error_abort);
+
+        numamem = acpi_data_push(table_data, sizeof *numamem);
+        build_srat_memory(numamem, addr, size, node,
+                          MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
+    }
+    g_slist_free(device_list);
+}
+
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, NVDIMMState *state,
                        uint32_t ram_slots)
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1b0a584c7b..2cbccd5fe2 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -539,6 +539,10 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
+    if (ms->nvdimms_state->is_enabled) {
+        nvdimm_build_srat(table_data);
+    }
+
     if (ms->device_memory) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
         build_srat_memory(numamem, ms->device_memory->base,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e15f6848e..d996525e2c 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2428,6 +2428,11 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
                               MEM_AFFINITY_ENABLED);
         }
     }
+
+    if (machine->nvdimms_state->is_enabled) {
+        nvdimm_build_srat(table_data);
+    }
+
     slots = (table_data->len - numa_start) / sizeof *numamem;
     for (; slots < pcms->numa_nodes + 2; slots++) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
-- 
MST


