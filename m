Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0277C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C10E207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4so4F++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C10E207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3rx-0003Qa-PE
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f7-0001Q6-8W
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54923
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f1-0003WA-Ko
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9YvBOjz+GveHkdAI4uLmTvYvs3a9LqSfTz7KYaRSlFM=;
 b=S4so4F++7Vdd9pK+Za+3UD8o6ACH6HbegL+4CwC5sD5RyEvNUWBa1tH1yeM5nKY9niwmMI
 CetkgfrZo/0n6fyQsTIB5CSuA/IIRC2VJNyXPYTx3WYFSM9NG3dfLtpqEzhh6GaMqn7bJY
 unrOm4UjJso1xPwoLV04uJRLPQvCxJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-2qBI-vBgO9OGQudCUxE2nA-1; Tue, 19 May 2020 10:56:00 -0400
X-MC-Unique: 2qBI-vBgO9OGQudCUxE2nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9A92835B50
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 93D8F5799C;
 Tue, 19 May 2020 14:55:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 43A101135224; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/55] sysbus: Tidy up sysbus_init_child_obj()'s @childsize
 arg, part 1
Date: Tue, 19 May 2020 16:55:35 +0200
Message-Id: <20200519145551.22836-40-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 00:34:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The callers of sysbus_init_child_obj() commonly pass either &child,
sizeof(child), or pchild, sizeof(*pchild).  Tidy up the few that use
sizeof(child_type) instead, mostly to keep future commits simpler.

Coccinelle script:

    @@
    expression parent, propname, type;
    type T;
    T child;
    @@
    -    sysbus_init_child_obj(parent, propname, &child, sizeof(T), type)
    +    sysbus_init_child_obj(parent, propname, &child, sizeof(child), type)

    @@
    expression parent, propname, type;
    type T;
    T *child;
    @@
    -    sysbus_init_child_obj(parent, propname, child, sizeof(T), type)
    +    sysbus_init_child_obj(parent, propname, child, sizeof(*child), type)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/bcm2835_peripherals.c    | 3 +--
 hw/arm/mps2-tz.c                | 5 ++---
 hw/arm/musca.c                  | 8 +++-----
 hw/display/sm501.c              | 2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c | 4 ++--
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index f1bcc14f55..49bfabee9b 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -27,8 +27,7 @@ static void create_unimp(BCM2835PeripheralState *ps,
                          UnimplementedDeviceState *uds,
                          const char *name, hwaddr ofs, hwaddr size)
 {
-    sysbus_init_child_obj(OBJECT(ps), name, uds,
-                          sizeof(UnimplementedDeviceState),
+    sysbus_init_child_obj(OBJECT(ps), name, uds, sizeof(*uds),
                           TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 8a050228d0..ad0bc9365a 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -174,8 +174,7 @@ static MemoryRegion *make_unimp_dev(MPS2TZMachineState *mms,
      */
     UnimplementedDeviceState *uds = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), name, uds,
-                          sizeof(UnimplementedDeviceState),
+    sysbus_init_child_obj(OBJECT(mms), name, uds, sizeof(*uds),
                           TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
@@ -552,7 +551,7 @@ static void mps2tz_common_init(MachineState *machine)
         char *gpioname;
 
         sysbus_init_child_obj(OBJECT(machine), ppcinfo->name, ppc,
-                              sizeof(TZPPC), TYPE_TZ_PPC);
+                              sizeof(*ppc), TYPE_TZ_PPC);
         ppcdev = DEVICE(ppc);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index cd7df7c191..b7f1c4e128 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -142,8 +142,7 @@ static MemoryRegion *make_unimp_dev(MuscaMachineState *mms,
      */
     UnimplementedDeviceState *uds = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), name, uds,
-                          sizeof(UnimplementedDeviceState),
+    sysbus_init_child_obj(OBJECT(mms), name, uds, sizeof(*uds),
                           TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
     qdev_prop_set_uint64(DEVICE(uds), "size", size);
@@ -246,8 +245,7 @@ static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
     case MPC_CRYPTOISLAND:
         /* We don't implement the CryptoIsland yet */
         uds = &mms->cryptoisland;
-        sysbus_init_child_obj(OBJECT(mms), name, uds,
-                              sizeof(UnimplementedDeviceState),
+        sysbus_init_child_obj(OBJECT(mms), name, uds, sizeof(*uds),
                               TYPE_UNIMPLEMENTED_DEVICE);
         qdev_prop_set_string(DEVICE(uds), "name", mpcinfo[i].name);
         qdev_prop_set_uint64(DEVICE(uds), "size", mpcinfo[i].size);
@@ -535,7 +533,7 @@ static void musca_init(MachineState *machine)
         char *gpioname;
 
         sysbus_init_child_obj(OBJECT(machine), ppcinfo->name, ppc,
-                              sizeof(TZPPC), TYPE_TZ_PPC);
+                              sizeof(*ppc), TYPE_TZ_PPC);
         ppcdev = DEVICE(ppc);
 
         for (port = 0; port < TZ_NUM_PORTS; port++) {
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index cacb6082b2..348d8f0458 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -2006,7 +2006,7 @@ static void sm501_sysbus_init(Object *o)
     SM501SysBusState *sm501 = SYSBUS_SM501(o);
     SerialMM *smm = &sm501->serial;
 
-    sysbus_init_child_obj(o, "serial", smm, sizeof(SerialMM), TYPE_SERIAL_MM);
+    sysbus_init_child_obj(o, "serial", smm, sizeof(*smm), TYPE_SERIAL_MM);
     qdev_set_legacy_instance_id(DEVICE(smm), SM501_UART0, 2);
     qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
     qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index bd56eccd66..30ad133ec3 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -69,8 +69,8 @@ static void xlnx_zynqmp_pmu_soc_init(Object *obj)
     /* Create the IPI device */
     for (int i = 0; i < XLNX_ZYNQMP_PMU_NUM_IPIS; i++) {
         char *name = g_strdup_printf("ipi%d", i);
-        sysbus_init_child_obj(obj, name, &s->ipi[i],
-                              sizeof(XlnxZynqMPIPI), TYPE_XLNX_ZYNQMP_IPI);
+        sysbus_init_child_obj(obj, name, &s->ipi[i], sizeof(s->ipi[i]),
+                              TYPE_XLNX_ZYNQMP_IPI);
         g_free(name);
     }
 }
-- 
2.21.1


