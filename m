Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8FAC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:45:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4826120707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL8I0v30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4826120707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDw1-000850-B1
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:45:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiQ-0000jb-3Z
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDiO-0000PT-I2
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDiO-0000PL-DN
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrkR9KYpXJDWqiPpiZFZOE335FpagScjc50Vgro92e4=;
 b=XL8I0v30sbPCta8qm3hVw9vooOlFW5pzcyIuDp9nydFnenqckXVdvvMVc0UnCmSRv/8/ai
 P70IsDus43/YBhZX+jHjbxMJFrNPBPiIuucoNjTk8CtGmetFLPWCsH3S4Wb9pT7dG+ZNfX
 OezCqejmrhWinj79CYPw7dvtdH6dRYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-zAd0-MfUMdie55aYUXHa8Q-1; Fri, 22 Nov 2019 13:31:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39A591005512;
 Fri, 22 Nov 2019 18:31:29 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51926E712;
 Fri, 22 Nov 2019 18:31:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 12/20] qapi: Introduce DEFINE_PROP_INTERVAL
Date: Fri, 22 Nov 2019 19:29:35 +0100
Message-Id: <20191122182943.4656-13-eric.auger@redhat.com>
In-Reply-To: <20191122182943.4656-1-eric.auger@redhat.com>
References: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: zAd0-MfUMdie55aYUXHa8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce a new property defining a labelled interval:
<low address>,<high address>,label.

This will be used to encode reserved IOVA regions. The label
is left undefined to ease reuse accross use cases.

For instance, in virtio-iommu use case, reserved IOVA regions
will be passed by the machine code to the virtio-iommu-pci
device (an array of those). The label will match the
virtio_iommu_probe_resv_mem subtype value:
- VIRTIO_IOMMU_RESV_MEM_T_RESERVED (0)
- VIRTIO_IOMMU_RESV_MEM_T_MSI (1)

This is used to inform the virtio-iommu-pci device it should
bypass the MSI region: 0xfee00000, 0xfeefffff, 1.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/core/qdev-properties.c    | 90 ++++++++++++++++++++++++++++++++++++
 include/exec/memory.h        |  6 +++
 include/hw/qdev-properties.h |  3 ++
 include/qemu/typedefs.h      |  1 +
 4 files changed, 100 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index ac28890e5a..8d70f34e37 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -13,6 +13,7 @@
 #include "qapi/visitor.h"
 #include "chardev/char.h"
 #include "qemu/uuid.h"
+#include "qemu/cutils.h"
=20
 void qdev_prop_set_after_realize(DeviceState *dev, const char *name,
                                   Error **errp)
@@ -585,6 +586,95 @@ const PropertyInfo qdev_prop_macaddr =3D {
     .set   =3D set_mac,
 };
=20
+/* --- Labelled Interval --- */
+
+/*
+ * accepted syntax versions:
+ *   <low address>,<high address>,<type>
+ *   where low/high addresses are uint64_t in hexa (feat. 0x prefix)
+ *   and type is an unsigned integer
+ */
+static void get_interval(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    Interval *interval =3D qdev_get_prop_ptr(dev, prop);
+    char buffer[64];
+    char *p =3D buffer;
+
+    snprintf(buffer, sizeof(buffer), "0x%"PRIx64",0x%"PRIx64",%d",
+             interval->low, interval->high, interval->type);
+
+    visit_type_str(v, name, &p, errp);
+}
+
+static void set_interval(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    DeviceState *dev =3D DEVICE(obj);
+    Property *prop =3D opaque;
+    Interval *interval =3D qdev_get_prop_ptr(dev, prop);
+    Error *local_err =3D NULL;
+    unsigned int type;
+    gchar **fields;
+    uint64_t addr;
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
+    fields =3D g_strsplit(str, ",", 3);
+
+    ret =3D qemu_strtou64(fields[0], NULL, 16, &addr);
+    if (!ret) {
+        interval->low =3D addr;
+    } else {
+        error_setg(errp, "Failed to decode interval low addr");
+        error_append_hint(errp,
+                          "should be an address in hexa with 0x prefix\n")=
;
+        goto out;
+    }
+
+    ret =3D qemu_strtou64(fields[1], NULL, 16, &addr);
+    if (!ret) {
+        interval->high =3D addr;
+    } else {
+        error_setg(errp, "Failed to decode interval high addr");
+        error_append_hint(errp,
+                          "should be an address in hexa with 0x prefix\n")=
;
+        goto out;
+    }
+
+    ret =3D qemu_strtoui(fields[2], NULL, 10, &type);
+    if (!ret) {
+        interval->type =3D type;
+    } else {
+        error_setg(errp, "Failed to decode interval type");
+        error_append_hint(errp, "should be an unsigned int in decimal\n");
+    }
+out:
+    g_free(str);
+    g_strfreev(fields);
+    return;
+}
+
+const PropertyInfo qdev_prop_interval =3D {
+    .name  =3D "labelled_interval",
+    .description =3D "Labelled interval, example: 0xFEE00000,0xFEEFFFFF,0"=
,
+    .get   =3D get_interval,
+    .set   =3D set_interval,
+};
+
 /* --- on/off/auto --- */
=20
 const PropertyInfo qdev_prop_on_off_auto =3D {
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc215b..e238d1c352 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -57,6 +57,12 @@ struct MemoryRegionMmio {
     CPUWriteMemoryFunc *write[3];
 };
=20
+struct Interval {
+    hwaddr low;
+    hwaddr high;
+    unsigned int type;
+};
+
 typedef struct IOMMUTLBEntry IOMMUTLBEntry;
=20
 /* See address_space_translate: bit 0 is read, bit 1 is write.  */
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index c6a8cb5516..2ba7c8711b 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -20,6 +20,7 @@ extern const PropertyInfo qdev_prop_chr;
 extern const PropertyInfo qdev_prop_tpm;
 extern const PropertyInfo qdev_prop_ptr;
 extern const PropertyInfo qdev_prop_macaddr;
+extern const PropertyInfo qdev_prop_interval;
 extern const PropertyInfo qdev_prop_on_off_auto;
 extern const PropertyInfo qdev_prop_losttickpolicy;
 extern const PropertyInfo qdev_prop_blockdev_on_error;
@@ -202,6 +203,8 @@ extern const PropertyInfo qdev_prop_pcie_link_width;
     DEFINE_PROP(_n, _s, _f, qdev_prop_drive_iothread, BlockBackend *)
 #define DEFINE_PROP_MACADDR(_n, _s, _f)         \
     DEFINE_PROP(_n, _s, _f, qdev_prop_macaddr, MACAddr)
+#define DEFINE_PROP_INTERVAL(_n, _s, _f)         \
+    DEFINE_PROP(_n, _s, _f, qdev_prop_interval, Interval)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_LOSTTICKPOLICY(_n, _s, _f, _d) \
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 375770a80f..a827c9a3fe 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -58,6 +58,7 @@ typedef struct ISABus ISABus;
 typedef struct ISADevice ISADevice;
 typedef struct IsaDma IsaDma;
 typedef struct MACAddr MACAddr;
+typedef struct Interval Interval;
 typedef struct MachineClass MachineClass;
 typedef struct MachineState MachineState;
 typedef struct MemoryListener MemoryListener;
--=20
2.20.1


