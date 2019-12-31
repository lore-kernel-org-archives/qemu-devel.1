Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC9C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D10205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G4i9HqrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D10205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHIl-00067Z-B6
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBr-0005AR-7S
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBp-0002OP-HV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42898
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBp-0002LD-Ba
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2A0sz/3RlF1o0iEKZLVw9QhSVU121d+d0YysvQISzxs=;
 b=G4i9HqrXOm7JAK/J78R29NEo4jMd/WWWw2iyHAvtNEaZq4UNJu78G34eT+7vpWhnWbm9fy
 M/zqlyTW4zK86pAttW0ekxVEhLKajaHi+3XyR2TxpuRudFORWha6OgnfvYce93pfAWm069
 T7fkjdbKI3OLi6Y0xEUV7aO22C3zaQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-J6l0JsPkNGuKJzhxwUXefA-1; Tue, 31 Dec 2019 08:03:58 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8976C477
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:57 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E16578E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:56 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/86] arm:aspeed: convert valid RAM sizes to data
Date: Tue, 31 Dec 2019 14:02:53 +0100
Message-Id: <1577797450-88458-10-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: J6l0JsPkNGuKJzhxwUXefA-1
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

various foo_rambits() hardcode mapping of RAM sizes to RAM feature bits,
which is hard to reuse and repeats over and over.

Convert maps into GLib's hash tables and perform mapping using
common mapping function.

Follow up patch will reuse tables for actually checking ram-size
property.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/misc/aspeed_sdmc.h |   2 +
 hw/misc/aspeed_sdmc.c         | 116 ++++++++++++++++----------------------=
----
 2 files changed, 47 insertions(+), 71 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 5dbde59..de1501f 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -39,6 +39,8 @@ typedef struct AspeedSDMCState {
 typedef struct AspeedSDMCClass {
     SysBusDeviceClass parent_class;
=20
+    GHashTable *ram2feat;
+    int fallback_ram_size;
     uint64_t max_ram_size;
     uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
     void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 2df3244..3fc80f0 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -148,72 +148,6 @@ static const MemoryRegionOps aspeed_sdmc_ops =3D {
     .valid.max_access_size =3D 4,
 };
=20
-static int ast2400_rambits(AspeedSDMCState *s)
-{
-    switch (s->ram_size >> 20) {
-    case 64:
-        return ASPEED_SDMC_DRAM_64MB;
-    case 128:
-        return ASPEED_SDMC_DRAM_128MB;
-    case 256:
-        return ASPEED_SDMC_DRAM_256MB;
-    case 512:
-        return ASPEED_SDMC_DRAM_512MB;
-    default:
-        break;
-    }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 256M",
-                s->ram_size);
-    s->ram_size =3D 256 << 20;
-    return ASPEED_SDMC_DRAM_256MB;
-}
-
-static int ast2500_rambits(AspeedSDMCState *s)
-{
-    switch (s->ram_size >> 20) {
-    case 128:
-        return ASPEED_SDMC_AST2500_128MB;
-    case 256:
-        return ASPEED_SDMC_AST2500_256MB;
-    case 512:
-        return ASPEED_SDMC_AST2500_512MB;
-    case 1024:
-        return ASPEED_SDMC_AST2500_1024MB;
-    default:
-        break;
-    }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
-                s->ram_size);
-    s->ram_size =3D 512 << 20;
-    return ASPEED_SDMC_AST2500_512MB;
-}
-
-static int ast2600_rambits(AspeedSDMCState *s)
-{
-    switch (s->ram_size >> 20) {
-    case 256:
-        return ASPEED_SDMC_AST2600_256MB;
-    case 512:
-        return ASPEED_SDMC_AST2600_512MB;
-    case 1024:
-        return ASPEED_SDMC_AST2600_1024MB;
-    case 2048:
-        return ASPEED_SDMC_AST2600_2048MB;
-    default:
-        break;
-    }
-
-    /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
-                s->ram_size);
-    s->ram_size =3D 1024 << 20;
-    return ASPEED_SDMC_AST2600_1024MB;
-}
-
 static void aspeed_sdmc_reset(DeviceState *dev)
 {
     AspeedSDMCState *s =3D ASPEED_SDMC(dev);
@@ -257,11 +191,14 @@ static Property aspeed_sdmc_properties[] =3D {
 static void aspeed_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_CLASS(klass);
+
     dc->realize =3D aspeed_sdmc_realize;
     dc->reset =3D aspeed_sdmc_reset;
     dc->desc =3D "ASPEED SDRAM Memory Controller";
     dc->vmsd =3D &vmstate_aspeed_sdmc;
     dc->props =3D aspeed_sdmc_properties;
+    asc->ram2feat =3D g_hash_table_new(g_direct_hash, g_direct_equal);
 }
=20
 static const TypeInfo aspeed_sdmc_info =3D {
@@ -273,10 +210,28 @@ static const TypeInfo aspeed_sdmc_info =3D {
     .abstract   =3D true,
 };
=20
+static int aspeed_get_ram_feat(AspeedSDMCState *s)
+{
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
+    int ram_mb =3D s->ram_size >> 20;
+    gpointer val;
+
+    if (g_hash_table_contains(asc->ram2feat, GINT_TO_POINTER(ram_mb))) {
+        val =3D g_hash_table_lookup(asc->ram2feat, GINT_TO_POINTER(ram_mb)=
);
+        return GPOINTER_TO_INT(val);
+    }
+
+    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default %dM",
+                 s->ram_size, asc->fallback_ram_size);
+    s->ram_size =3D asc->fallback_ram_size << 20;
+    val =3D g_hash_table_lookup(asc->ram2feat, &asc->fallback_ram_size);
+    return GPOINTER_TO_INT(val);
+}
+
 static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32_t=
 data)
 {
-    uint32_t fixed_conf =3D ASPEED_SDMC_VGA_COMPAT |
-        ASPEED_SDMC_DRAM_SIZE(ast2400_rambits(s));
+    int ram_f =3D aspeed_get_ram_feat(s);
+    uint32_t fixed_conf =3D ASPEED_SDMC_VGA_COMPAT | ASPEED_SDMC_DRAM_SIZE=
(ram_f);
=20
     /* Make sure readonly bits are kept */
     data &=3D ~ASPEED_SDMC_READONLY_MASK;
@@ -298,6 +253,9 @@ static void aspeed_2400_sdmc_write(AspeedSDMCState *s, =
uint32_t reg,
     s->regs[reg] =3D data;
 }
=20
+#define REGISTER_RAM_SIZE(h, k, v) \
+    g_hash_table_insert(h->ram2feat, GINT_TO_POINTER(k), GINT_TO_POINTER(v=
))
+
 static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -307,6 +265,11 @@ static void aspeed_2400_sdmc_class_init(ObjectClass *k=
lass, void *data)
     asc->max_ram_size =3D 512 << 20;
     asc->compute_conf =3D aspeed_2400_sdmc_compute_conf;
     asc->write =3D aspeed_2400_sdmc_write;
+    asc->fallback_ram_size =3D 256;
+    REGISTER_RAM_SIZE(asc, 64, ASPEED_SDMC_DRAM_64MB);
+    REGISTER_RAM_SIZE(asc, 128, ASPEED_SDMC_DRAM_128MB);
+    REGISTER_RAM_SIZE(asc, 256, ASPEED_SDMC_DRAM_256MB);
+    REGISTER_RAM_SIZE(asc, 512, ASPEED_SDMC_DRAM_512MB);
 }
=20
 static const TypeInfo aspeed_2400_sdmc_info =3D {
@@ -317,10 +280,10 @@ static const TypeInfo aspeed_2400_sdmc_info =3D {
=20
 static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32_t=
 data)
 {
+    int ram_f =3D aspeed_get_ram_feat(s);
     uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |
         ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
-        ASPEED_SDMC_CACHE_INITIAL_DONE |
-        ASPEED_SDMC_DRAM_SIZE(ast2500_rambits(s));
+        ASPEED_SDMC_CACHE_INITIAL_DONE | ASPEED_SDMC_DRAM_SIZE(ram_f);
=20
     /* Make sure readonly bits are kept */
     data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
@@ -360,6 +323,11 @@ static void aspeed_2500_sdmc_class_init(ObjectClass *k=
lass, void *data)
     asc->max_ram_size =3D 1024 << 20;
     asc->compute_conf =3D aspeed_2500_sdmc_compute_conf;
     asc->write =3D aspeed_2500_sdmc_write;
+    asc->fallback_ram_size =3D 512;
+    REGISTER_RAM_SIZE(asc, 128, ASPEED_SDMC_AST2500_128MB);
+    REGISTER_RAM_SIZE(asc, 256, ASPEED_SDMC_AST2500_256MB);
+    REGISTER_RAM_SIZE(asc, 512, ASPEED_SDMC_AST2500_512MB);
+    REGISTER_RAM_SIZE(asc, 1024, ASPEED_SDMC_AST2500_1024MB);
 }
=20
 static const TypeInfo aspeed_2500_sdmc_info =3D {
@@ -370,9 +338,10 @@ static const TypeInfo aspeed_2500_sdmc_info =3D {
=20
 static uint32_t aspeed_2600_sdmc_compute_conf(AspeedSDMCState *s, uint32_t=
 data)
 {
+    int ram_f =3D aspeed_get_ram_feat(s);
     uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(3) |
         ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
-        ASPEED_SDMC_DRAM_SIZE(ast2600_rambits(s));
+        ASPEED_SDMC_DRAM_SIZE(ram_f);
=20
     /* Make sure readonly bits are kept (use ast2500 mask) */
     data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
@@ -413,6 +382,11 @@ static void aspeed_2600_sdmc_class_init(ObjectClass *k=
lass, void *data)
     asc->max_ram_size =3D 2048 << 20;
     asc->compute_conf =3D aspeed_2600_sdmc_compute_conf;
     asc->write =3D aspeed_2600_sdmc_write;
+    asc->fallback_ram_size =3D 512;
+    REGISTER_RAM_SIZE(asc, 256, ASPEED_SDMC_AST2600_256MB);
+    REGISTER_RAM_SIZE(asc, 512, ASPEED_SDMC_AST2600_512MB);
+    REGISTER_RAM_SIZE(asc, 1024, ASPEED_SDMC_AST2600_1024MB);
+    REGISTER_RAM_SIZE(asc, 2048, ASPEED_SDMC_AST2600_2048MB);
 }
=20
 static const TypeInfo aspeed_2600_sdmc_info =3D {
--=20
2.7.4


