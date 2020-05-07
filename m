Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D64C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 245EA20735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0jCI6jS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 245EA20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhau-0001uH-5W
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWhZb-0000C9-Ef
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:32:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jWhZY-0006Gq-J4
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588861943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=025Liq6P9NfmWE+4xotssh0pHBJh/qQDTBn0yD+t2WE=;
 b=i0jCI6jS8wG3NS6mvm6lPNoXzSoqa5MWT7fAj/oti+VwPC0GQttKBruXJBjNl2P6oZ6QKf
 4CSiBWGAj7Q3byCZRq0YEhghGLYWF9V1u9Xe3sk0RnBPFMF4mt63TJ5iUyaQKc/ntba/n5
 qdoH/OJqoBJzjXaLINS5tmToXP8yiUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-RBzoz-CuOeGuywLuSwoUCw-1; Thu, 07 May 2020 10:32:18 -0400
X-MC-Unique: RBzoz-CuOeGuywLuSwoUCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7380080058A;
 Thu,  7 May 2020 14:32:17 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BA5E7055D;
 Thu,  7 May 2020 14:32:14 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 bbhushan2@marvell.com, peterx@redhat.com, armbru@redhat.com
Subject: [PATCH 1/5] qdev: Introduce DEFINE_PROP_RESERVED_REGION
Date: Thu,  7 May 2020 16:31:57 +0200
Message-Id: <20200507143201.31080-2-eric.auger@redhat.com>
In-Reply-To: <20200507143201.31080-1-eric.auger@redhat.com>
References: <20200507143201.31080-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a new property defining a reserved region:
<low address>, <high address>, <type>.

This will be used to encode reserved IOVA regions.

For instance, in virtio-iommu use case, reserved IOVA regions
will be passed by the machine code to the virtio-iommu-pci
device (an array of those). The type of the reserved region
will match the virtio_iommu_probe_resv_mem subtype value:
- VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
- VIRTIO_IOMMU_RESV_MEM_T_MSI (1)

on PC/Q35 machine, this will be used to inform the
virtio-iommu-pci device it should bypass the MSI region.
The reserved region will be: 0xfee00000, 0xfeefffff, 1.

On ARM, we can declare the ITS MSI doorbell as an MSI
region to prevent MSIs from being mapped on guest side.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v11 -> v12:
- rename into DEFINE_PROP_RESERVED_REGION
- do not use g_strsplit anymore, use endptr instead
- remove 0x references
---
 include/exec/memory.h        |  6 +++
 include/hw/qdev-properties.h |  3 ++
 include/qemu/typedefs.h      |  1 +
 hw/core/qdev-properties.c    | 89 ++++++++++++++++++++++++++++++++++++
 4 files changed, 99 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e000bd2f97..7e47afabe8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -57,6 +57,12 @@ struct MemoryRegionMmio {
     CPUWriteMemoryFunc *write[3];
 };
=20
+struct ReservedRegion {
+    hwaddr low;
+    hwaddr high;
+    unsigned int type;
+};
+
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
=20
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index f161604fb6..03bf850a7e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -19,6 +19,7 @@ extern const PropertyInfo qdev_prop_string;
 extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_macaddr;
+extern const PropertyInfo qdev_prop_reserved_region;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_multifd_compression;
 extern const PropertyInfo qdev_prop_losttickpolicy;
@@ -183,6 +184,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
+#define DEFINE_PROP_RESERVED_REGION(_n, _s, _f)         \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_reserved_region, ReservedRegion)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_MULTIFD_COMPRESSION(_n, _s, _f, _d) \
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index ecf3cde26c..85c4f891f4 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -59,6 +59,7 @@ typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
 typedef struct IsaDma IsaDma;
 typedef struct MACAddr MACAddr;
+typedef struct ReservedRegion ReservedRegion;
 typedef struct MachineClass MachineClass;
 typedef struct MachineState MachineState;
 typedef struct MemoryListener MemoryListener;
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 2047114fca..c2e0cc7cda 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -14,6 +14,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qemu/cutils.h"
=20
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -577,6 +578,94 @@ const PropertyInfo qdev_prop_macaddr =3D {
     .set   =3D set_mac,
 };
=20
+/* --- Reserved Region --- */
+
+/*
+ * accepted syntax version:
+ *   <low address>,<high address>,<type>
+ *   where low/high addresses are uint64_t in hexadecimal
+ *   and type is an unsigned integer in decimal
+ */
+static void get_reserved_region(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    ReservedRegion *rr =3D qdev_get_prop_ptr(dev, prop);
+    char buffer[64];
+    char *p =3D buffer;
+
+    snprintf(buffer, sizeof(buffer), "0x%"PRIx64",0x%"PRIx64",%u",
+             rr->low, rr->high, rr->type);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_reserved_region(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    ReservedRegion *rr =3D qdev_get_prop_ptr(dev, prop);
+    Error *local_err =3D NULL;
+    const char *endptr;
+    char *str;
+    int ret;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_str(v, name, &str, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    ret =3D qemu_strtou64(str, &endptr, 16, &rr->low);
+    if (ret) {
+        error_setg(errp, "Failed to decode reserved region low addr");
+        error_append_hint(errp,
+                          "should be an address in hexadecimal\n");
+        goto out;
+    }
+    if (*endptr !=3D ',') {
+        goto separator_error;
+    }
+
+    ret =3D qemu_strtou64(endptr + 1, &endptr, 16, &rr->high);
+    if (ret) {
+        error_setg(errp, "Failed to decode reserved region high addr");
+        error_append_hint(errp,
+                          "should be an address in hexadecimal\n");
+        goto out;
+    }
+    if (*endptr !=3D ',') {
+        goto separator_error;
+    }
+
+    ret =3D qemu_strtoui(endptr + 1, &endptr, 10, &rr->type);
+    if (ret) {
+        error_setg(errp, "Failed to decode reserved region type");
+        error_append_hint(errp, "should be an unsigned integer in decimal\=
n");
+    }
+    goto out;
+
+separator_error:
+    error_setg(errp, "reserved region fields must be separated with commas=
");
+out:
+    g_free(str);
+    return;
+}
+
+const PropertyInfo qdev_prop_reserved_region =3D {
+    .name  =3D "reserved_region",
+    .description =3D "Reserved Region, example: 0xFEE00000,0xFEEFFFFF,0",
+    .get   =3D get_reserved_region,
+    .set   =3D set_reserved_region,
+};
+
 /* --- on/off/auto --- */
=20
 const PropertyInfo qdev_prop_on_off_auto =3D {
--=20
2.20.1


