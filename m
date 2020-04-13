Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB19C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0CEC2072C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTpMe59F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0CEC2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNx0V-0002Fp-S5
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jNwxr-0007WC-5A
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jNwxp-00076d-Ht
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jNwxp-0006y2-D1
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586776155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kJUSLyyd/FhSQI7dImJ761r6OxD1h8L7ChQu+2/D99Y=;
 b=FTpMe59FdTTJP12dKXtBHk+36tRwcc04wzfOuQul6u6FvE7yG6GwaY6aMuPy8v0nirXZ+X
 pbZWjITFqfhTg47hefhyI13kWjLsNO1jta27ZaTcz4NJa+YYGtclpWkq07caM4cVrunKc4
 LT9Y7BJ2jf2xsQjA/MfLEC5mEBrxV+I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-5YghlXlEOYeFe8JqD7iX6w-1; Mon, 13 Apr 2020 07:09:13 -0400
X-MC-Unique: 5YghlXlEOYeFe8JqD7iX6w-1
Received: by mail-wr1-f70.google.com with SMTP id f15so6572298wrj.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 04:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MLA7kiIbbP9cwbAxVDUuKyWpMwD53/uRqCg6C22vu3w=;
 b=VcoblX0WK5vKN5UzUqWNv9KFMc5IQn+X+qZj9lR05vWQjxGgPxwOaQewiIaPv2rrzJ
 U1O93igHu5Of03McV8aKUocu12/bJpNdebukCF4aIfu4GY87tU679iF5ijv93bUH3x84
 A0CTyeWCPoIZgqEPIBB4zU+iIORiP4JvDF/JFONX79YB1NQFUWrRPjUVjjtmUGw90KKP
 lk7ObG1nJzyJrTwnP8YXNbiTQSURrsUUFx/3TFioP+o/vbZrJ1ITi/uc0gUCbWn+VhXN
 zk/Km/3mqYSKI0qbcRBCtLbBTHtUkB3hJLukBjbLNs0SIBIEMLpzkLmuQeW0qQek5Lq4
 +j0Q==
X-Gm-Message-State: AGi0PuY+bm0f/r4QpadGSNRxkOwfWv7QwZKn/UpgmzBbPik0CGM4UXVW
 2OSGo2eNwc5DzFLFp/a5dzqXysP8tH6VCfCrfwsObfacbnt+z9gAgbuyJehsWwrM7sXUA+e5PZ4
 XCeAzbCAOhiiRLRM=
X-Received: by 2002:adf:df8a:: with SMTP id z10mr17338394wrl.278.1586776152440; 
 Mon, 13 Apr 2020 04:09:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypJlAjvS+rDeBWVWu0GMIkW3uI8l0jviwc9suK0IQOg09mMakKqRxpIT0L3foU1aN/II0BAgzA==
X-Received: by 2002:adf:df8a:: with SMTP id z10mr17338358wrl.278.1586776152128; 
 Mon, 13 Apr 2020 04:09:12 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id d6sm14517700wrw.10.2020.04.13.04.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 04:09:11 -0700 (PDT)
Date: Mon, 13 Apr 2020 07:09:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] fw_cfg: Migrate ACPI table mr sizes separately
Message-ID: <20200413110838.151374-4-mst@redhat.com>
References: <20200413110838.151374-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200413110838.151374-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Any sub-page size update to ACPI MRs will be lost during
migration, as we use aligned size in ram_load_precopy() ->
qemu_ram_resize() path. This will result in inconsistency in
FWCfgEntry sizes between source and destination. In order to avoid
this, save and restore them separately during migration.

Up until now, this problem may not be that relevant for x86 as both
ACPI table and Linker MRs gets padded and aligned. Also at present,
qemu_ram_resize() doesn't invoke callback to update FWCfgEntry for
unaligned size changes. But since we are going to fix the
qemu_ram_resize() in the subsequent patch, the issue may become
more serious especially for RSDP MR case.

Moreover, the issue will soon become prominent in arm/virt as well
where the MRs are not padded or aligned at all and eventually have
acpi table changes as part of future additions like NVDIMM hot-add
feature.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Acked-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200403101827.30664-3-shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/nvram/fw_cfg.h |  6 +++
 hw/core/machine.c         |  1 +
 hw/nvram/fw_cfg.c         | 91 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 1 deletion(-)

diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b5291eefad..25d9307018 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -53,6 +53,12 @@ struct FWCfgState {
     dma_addr_t dma_addr;
     AddressSpace *dma_as;
     MemoryRegion dma_iomem;
+
+    /* restore during migration */
+    bool acpi_mr_restore;
+    uint64_t table_mr_size;
+    uint64_t linker_mr_size;
+    uint64_t rsdp_mr_size;
 };
=20
 struct FWCfgIoState {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index de0c425605..c1a444cb75 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] =3D {
     { "usb-redir", "suppress-remote-wake", "off" },
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
+    { "fw_cfg", "acpi-mr-restore", "false" },
 };
 const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
=20
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 179b302f01..4be6c9d9fd 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -39,6 +39,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "hw/acpi/aml-build.h"
=20
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
=20
@@ -610,6 +611,55 @@ bool fw_cfg_dma_enabled(void *opaque)
     return s->dma_enabled;
 }
=20
+static bool fw_cfg_acpi_mr_restore(void *opaque)
+{
+    FWCfgState *s =3D opaque;
+    bool mr_aligned;
+
+    mr_aligned =3D QEMU_IS_ALIGNED(s->table_mr_size, qemu_real_host_page_s=
ize) &&
+                 QEMU_IS_ALIGNED(s->linker_mr_size, qemu_real_host_page_si=
ze) &&
+                 QEMU_IS_ALIGNED(s->rsdp_mr_size, qemu_real_host_page_size=
);
+    return s->acpi_mr_restore && !mr_aligned;
+}
+
+static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
+{
+    MemoryRegion *mr;
+    ram_addr_t offset;
+    int arch =3D !!(key & FW_CFG_ARCH_LOCAL);
+    void *ptr;
+
+    key &=3D FW_CFG_ENTRY_MASK;
+    assert(key < fw_cfg_max_entry(s));
+
+    ptr =3D s->entries[arch][key].data;
+    mr =3D memory_region_from_host(ptr, &offset);
+
+    memory_region_ram_resize(mr, size, &error_abort);
+}
+
+static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
+{
+    FWCfgState *s =3D opaque;
+    int i, index;
+
+    assert(s->files);
+
+    index =3D be32_to_cpu(s->files->count);
+
+    for (i =3D 0; i < index; i++) {
+        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
+            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_size);
+        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE)) {
+            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_size);
+        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE)) {
+            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size);
+        }
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_fw_cfg_dma =3D {
     .name =3D "fw_cfg/dma",
     .needed =3D fw_cfg_dma_enabled,
@@ -619,6 +669,20 @@ static const VMStateDescription vmstate_fw_cfg_dma =3D=
 {
     },
 };
=20
+static const VMStateDescription vmstate_fw_cfg_acpi_mr =3D {
+    .name =3D "fw_cfg/acpi_mr",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .needed =3D fw_cfg_acpi_mr_restore,
+    .post_load =3D fw_cfg_acpi_mr_restore_post_load,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(table_mr_size, FWCfgState),
+        VMSTATE_UINT64(linker_mr_size, FWCfgState),
+        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_fw_cfg =3D {
     .name =3D "fw_cfg",
     .version_id =3D 2,
@@ -631,6 +695,7 @@ static const VMStateDescription vmstate_fw_cfg =3D {
     },
     .subsections =3D (const VMStateDescription*[]) {
         &vmstate_fw_cfg_dma,
+        &vmstate_fw_cfg_acpi_mr,
         NULL,
     }
 };
@@ -815,6 +880,23 @@ static struct {
 #define FW_CFG_ORDER_OVERRIDE_LAST 200
 };
=20
+/*
+ * Any sub-page size update to these table MRs will be lost during migrati=
on,
+ * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
+ * In order to avoid the inconsistency in sizes save them seperately and
+ * migrate over in vmstate post_load().
+ */
+static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_=
t len)
+{
+    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
+        s->table_mr_size =3D len;
+    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
+        s->linker_mr_size =3D len;
+    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
+        s->rsdp_mr_size =3D len;
+    }
+}
+
 static int get_fw_cfg_order(FWCfgState *s, const char *name)
 {
     int i;
@@ -914,6 +996,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const cha=
r *filename,
     trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
=20
     s->files->count =3D cpu_to_be32(count+1);
+    fw_cfg_acpi_mr_save(s, filename, len);
 }
=20
 void fw_cfg_add_file(FWCfgState *s,  const char *filename,
@@ -937,6 +1020,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *fi=
lename,
             ptr =3D fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
                                            data, len);
             s->files->f[i].size   =3D cpu_to_be32(len);
+            fw_cfg_acpi_mr_save(s, filename, len);
             return ptr;
         }
     }
@@ -973,7 +1057,10 @@ static void fw_cfg_machine_ready(struct Notifier *n, =
void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
=20
-
+static Property fw_cfg_properties[] =3D {
+    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true)=
,
+    DEFINE_PROP_END_OF_LIST(),
+};
=20
 static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
 {
@@ -1097,6 +1184,8 @@ static void fw_cfg_class_init(ObjectClass *klass, voi=
d *data)
=20
     dc->reset =3D fw_cfg_reset;
     dc->vmsd =3D &vmstate_fw_cfg;
+
+    device_class_set_props(dc, fw_cfg_properties);
 }
=20
 static const TypeInfo fw_cfg_info =3D {
--=20
MST


