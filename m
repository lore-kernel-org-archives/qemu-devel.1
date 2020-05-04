Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2056C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25EB20752
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 14:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtE175Bu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25EB20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVcG9-0007M8-N8
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 10:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6Z-000638-K5
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38182
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jVc6Y-0006Kr-8a
 for qemu-devel@nongnu.org; Mon, 04 May 2020 10:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588602597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqCybmu42mI41rHdytMlKKB4cPDVUzwPKcnB2uEO3VQ=;
 b=dtE175BupVtP44ozgyDkrBJuZzOpJSTG9z7k/uvm5a6B5E09ynGwtQ6Ik/xPfQWEirEHXq
 2BWUHLe5EXm4cXDNrkJ0vQZWX4vYTX9AJYPbTwi1eU7qI9ozW4KN7/5JxWVYsO24KjnNop
 tvnAVOgHYXgE87emIAK9vpyXgaEP+TM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-OqDmhQEtPram_b6_47x0uw-1; Mon, 04 May 2020 10:29:55 -0400
X-MC-Unique: OqDmhQEtPram_b6_47x0uw-1
Received: by mail-wm1-f71.google.com with SMTP id l21so5001411wmh.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 07:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hmDFwmjESqooVdgFwJ4n6T8cNfqvxRsTWu+AT5PSXmk=;
 b=U3n/SXmkSEUaH89F5wO8jxMiDNemvjYBb5yBo8Moj3gH5W7YOVOt6w0r0XTsrPjxgX
 pAXZxcWKeXnRjPouMfuwqaFpADQZq5lDVWPrMdY17K01Z41onDGWM0/dLW56FDqavwP2
 PdHdVF9cJKxnvAW8LaklaK/prtwokilNOOXuIL6MjmQJ74V1v+cIkMBQo5Bek9RXW6St
 FSJ3hYdoQT+SJvhfSiVelc6hBhtzNpM5yvLcNV0NEmoQZXeHW0Qq5dg8vB8Rh1806uTX
 0TaF8osWeXIYrxFftwmjxlgJBwJuHUECdw+RC5RFg9g7ruCwcWJEQMe4EqfVt5ZYvCrJ
 +h2w==
X-Gm-Message-State: AGi0PuYlMp3NRuNz/UTIyvKpGUeHM+R/Gs5fNFABrCUxf2g2aYKW2vGr
 hvfbXogEU+PF0UEa9mlrn7JFh7U2UBBaXVN1K3zxT4MpCva8LR9pkeicSl+MnBHzQUjuSTSuLLv
 IAurW3gFZbVIkJfY=
X-Received: by 2002:adf:e44b:: with SMTP id t11mr13050845wrm.188.1588602594109; 
 Mon, 04 May 2020 07:29:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypJIqHQKDlkZkgVmlhRSRaEGzXwy3ZFaPlC4M5/dSNh9qkgfQtk3BZ8W0MIpPl+d4kMhRJHTEA==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr13050811wrm.188.1588602593819; 
 Mon, 04 May 2020 07:29:53 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h137sm402915wme.0.2020.05.04.07.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2020 07:29:53 -0700 (PDT)
Date: Mon, 4 May 2020 10:29:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] nvdimm: Use configurable ACPI IO base and size
Message-ID: <20200504142814.157589-17-mst@redhat.com>
References: <20200504142814.157589-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200504142814.157589-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Kwangwoo Lee <kwangwoo.lee@sk.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

This patch makes IO base and size configurable to create NPIO AML for
ACPI NFIT. Since a different architecture like AArch64 does not use
port-mapped IO, a configurable IO base is required to create correct
mapping of ACPI IO address and size.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200421125934.14952-3-shameerali.kolothum.thodi@huawei.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/acpi-build.h    |  3 +++
 include/hw/mem/nvdimm.h |  3 +++
 hw/acpi/nvdimm.c        | 32 ++++++++++++++++++++++----------
 hw/i386/acpi-build.c    |  6 ++++++
 hw/i386/pc_piix.c       |  2 ++
 hw/i386/pc_q35.c        |  2 ++
 6 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 007332e51c..74df5fc612 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -1,6 +1,9 @@
=20
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
+#include "hw/acpi/acpi-defs.h"
+
+extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
=20
 void acpi_setup(void);
=20
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 4807ca615b..a3c08955e8 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -26,6 +26,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "qemu/uuid.h"
+#include "hw/acpi/aml-build.h"
=20
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -147,10 +148,12 @@ struct NVDIMMState {
      */
     int32_t persistence;
     char    *persistence_string;
+    struct AcpiGenericAddress dsm_io;
 };
 typedef struct NVDIMMState NVDIMMState;
=20
 void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
+                            struct AcpiGenericAddress dsm_io,
                             FWCfgState *fw_cfg, Object *owner);
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, NVDIMMState *state,
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index df0790719a..fa7bf8b507 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -900,11 +900,13 @@ void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev,=
 DeviceState *dev)
 }
=20
 void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
+                            struct AcpiGenericAddress dsm_io,
                             FWCfgState *fw_cfg, Object *owner)
 {
+    state->dsm_io =3D dsm_io;
     memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
-                          "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
-    memory_region_add_subregion(io, NVDIMM_ACPI_IO_BASE, &state->io_mr);
+                          "nvdimm-acpi-io", dsm_io.bit_width >> 3);
+    memory_region_add_subregion(io, dsm_io.address, &state->io_mr);
=20
     state->dsm_mem =3D g_array_new(false, true /* clear */, 1);
     acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
@@ -933,13 +935,15 @@ void nvdimm_init_acpi_state(NVDIMMState *state, Memor=
yRegion *io,
=20
 #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
=20
-static void nvdimm_build_common_dsm(Aml *dev)
+static void nvdimm_build_common_dsm(Aml *dev,
+                                    NVDIMMState *nvdimm_state)
 {
     Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
     Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_=
size;
     Aml *whilectx, *offset;
     uint8_t byte_list[1];
+    AmlRegionSpace rs;
=20
     method =3D aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
     uuid =3D aml_arg(0);
@@ -950,9 +954,16 @@ static void nvdimm_build_common_dsm(Aml *dev)
=20
     aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem))=
;
=20
+    if (nvdimm_state->dsm_io.space_id =3D=3D AML_AS_SYSTEM_IO) {
+        rs =3D AML_SYSTEM_IO;
+    } else {
+        rs =3D AML_SYSTEM_MEMORY;
+    }
+
     /* map DSM memory and IO into ACPI namespace. */
-    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTEM_=
IO,
-               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
+    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, rs,
+               aml_int(nvdimm_state->dsm_io.address),
+               nvdimm_state->dsm_io.bit_width >> 3));
     aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
                AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
=20
@@ -967,7 +978,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
     field =3D aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
                       AML_PRESERVE);
     aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
-               NVDIMM_ACPI_IO_LEN * BITS_PER_BYTE));
+               nvdimm_state->dsm_io.bit_width));
     aml_append(method, field);
=20
     /*
@@ -1268,7 +1279,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev=
, uint32_t ram_slots)
 }
=20
 static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_area,
+                              BIOSLinker *linker,
+                              NVDIMMState *nvdimm_state,
                               uint32_t ram_slots)
 {
     Aml *ssdt, *sb_scope, *dev;
@@ -1296,7 +1308,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, =
GArray *table_data,
      */
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
=20
-    nvdimm_build_common_dsm(dev);
+    nvdimm_build_common_dsm(dev, nvdimm_state);
=20
     /* 0 is reserved for root device. */
     nvdimm_build_device_dsm(dev, 0);
@@ -1315,7 +1327,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, =
GArray *table_data,
                                                NVDIMM_ACPI_MEM_ADDR);
=20
     bios_linker_loader_alloc(linker,
-                             NVDIMM_DSM_MEM_FILE, dsm_dma_area,
+                             NVDIMM_DSM_MEM_FILE, nvdimm_state->dsm_mem,
                              sizeof(NvdimmDsmIn), false /* high memory */)=
;
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
@@ -1337,7 +1349,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray =
*table_data,
         return;
     }
=20
-    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
+    nvdimm_build_ssdt(table_offsets, table_data, linker, state,
                       ram_slots);
=20
     device_list =3D nvdimm_get_device_list();
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 97f3c75cd9..7d880bec4a 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -128,6 +128,12 @@ typedef struct FwCfgTPMConfig {
=20
 static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
=20
+const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio =3D {
+    .space_id =3D AML_AS_SYSTEM_IO,
+    .address =3D NVDIMM_ACPI_IO_BASE,
+    .bit_width =3D NVDIMM_ACPI_IO_LEN << 3
+};
+
 static void init_common_fadt_data(MachineState *ms, Object *o,
                                   AcpiFadtData *data)
 {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 22dee0e76c..b75087d71b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -61,6 +61,7 @@
 #include "migration/misc.h"
 #include "sysemu/numa.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/i386/acpi-build.h"
=20
 #define MAX_IDE_BUS 2
=20
@@ -297,6 +298,7 @@ static void pc_init1(MachineState *machine,
=20
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d37c425e22..d2806c1b29 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -54,6 +54,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/i386/acpi-build.h"
=20
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -315,6 +316,7 @@ static void pc_q35_init(MachineState *machine)
=20
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
                                x86ms->fw_cfg, OBJECT(pcms));
     }
 }
--=20
MST


