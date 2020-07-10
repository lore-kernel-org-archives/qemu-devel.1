Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A896EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20BF520578
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRN0y7C1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20BF520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jttDn-0003UI-BI
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7V-0008Vz-FI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54424
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtt7Q-0004wG-PI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 09:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594387872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZ85lmhdhPKQMOK4Ny5d8eEr5hgQEuHBrLa9QxVMCoM=;
 b=bRN0y7C1pIWccf7b12cP6dvi8vbYRNJNHaKeAymMeojNqdCYZpwWYTBSWOGk/wjLdNHtt8
 0jtqLYekC1jZ8XqzbaD9RXon2j4vuulBqwv5NNojn2GXX77rP6v2/8Yj6LC748hjKM+mhY
 RiVDhSmvQu9as/liYZ9CqoNcyqvLb88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469--K1P2T2fOUCsxENSIqzV9w-1; Fri, 10 Jul 2020 09:31:07 -0400
X-MC-Unique: -K1P2T2fOUCsxENSIqzV9w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DCAB800D5C;
 Fri, 10 Jul 2020 13:31:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E95C87EFA5;
 Fri, 10 Jul 2020 13:31:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 79DE21132922; Fri, 10 Jul 2020 15:31:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 26/53] qom: Put name parameter before value / visitor
 parameter
Date: Fri, 10 Jul 2020 15:31:01 +0200
Message-Id: <20200710133103.2153250-3-armbru@redhat.com>
In-Reply-To: <20200710133103.2153250-1-armbru@redhat.com>
References: <20200710133103.2153250-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The object_property_set_FOO() setters take property name and value in
an unusual order:

    void object_property_set_FOO(Object *obj, FOO_TYPE value,
                                 const char *name, Error **errp)

Having to pass value before name feels grating.  Swap them.

Same for object_property_set(), object_property_get(), and
object_property_parse().

Convert callers with this Coccinelle script:

    @@
    identifier fun = {
        object_property_get, object_property_parse, object_property_set_str,
        object_property_set_link, object_property_set_bool,
        object_property_set_int, object_property_set_uint, object_property_set,
        object_property_set_qobject
    };
    expression obj, v, name, errp;
    @@
    -    fun(obj, v, name, errp)
    +    fun(obj, name, v, errp)

Chokes on hw/arm/musicpal.c's lcd_refresh() with the unhelpful error
message "no position information".  Convert that one manually.

Fails to convert hw/arm/armsse.c, because Coccinelle gets confused by
ARMSSE being used both as typedef and function-like macro there.
Convert manually.

Fails to convert hw/rx/rx-gdbsim.c, because Coccinelle gets confused
by RXCPU being used both as typedef and function-like macro there.
Convert manually.  The other files using RXCPU that way don't need
conversion.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200707160613.848843-27-armbru@redhat.com>
[Straightforwad conflict with commit 2336172d9b "audio: set default
value for pcspk.iobase property" resolved]
---
 include/hw/audio/pcspk.h                 |   2 +-
 include/qom/object.h                     |  44 ++++-----
 include/qom/qom-qobject.h                |   7 +-
 backends/cryptodev.c                     |   2 +-
 backends/rng.c                           |   2 +-
 bootdevice.c                             |   2 +-
 crypto/secret.c                          |   2 +-
 crypto/secret_keyring.c                  |   2 +-
 crypto/tlscredsanon.c                    |   2 +-
 crypto/tlscredspsk.c                     |   2 +-
 crypto/tlscredsx509.c                    |   2 +-
 hw/acpi/cpu_hotplug.c                    |   4 +-
 hw/acpi/ich9.c                           |   2 +-
 hw/acpi/piix4.c                          |   2 +-
 hw/arm/allwinner-a10.c                   |   6 +-
 hw/arm/armsse.c                          |  76 +++++++--------
 hw/arm/armv7m.c                          |  24 +++--
 hw/arm/aspeed.c                          |  24 ++---
 hw/arm/aspeed_ast2600.c                  |  54 +++++------
 hw/arm/aspeed_soc.c                      |  23 +++--
 hw/arm/bcm2835_peripherals.c             |  12 +--
 hw/arm/bcm2836.c                         |   9 +-
 hw/arm/cubieboard.c                      |   6 +-
 hw/arm/digic.c                           |   2 +-
 hw/arm/exynos4210.c                      |  13 +--
 hw/arm/fsl-imx25.c                       |  14 ++-
 hw/arm/fsl-imx31.c                       |   2 +-
 hw/arm/fsl-imx6.c                        |  37 ++++---
 hw/arm/fsl-imx6ul.c                      |  29 +++---
 hw/arm/fsl-imx7.c                        |  31 +++---
 hw/arm/highbank.c                        |  12 +--
 hw/arm/integratorcp.c                    |   2 +-
 hw/arm/mcimx6ul-evk.c                    |   4 +-
 hw/arm/microbit.c                        |   4 +-
 hw/arm/mps2-tz.c                         |  31 +++---
 hw/arm/mps2.c                            |  12 +--
 hw/arm/msf2-soc.c                        |   8 +-
 hw/arm/musca.c                           |  18 ++--
 hw/arm/musicpal.c                        |   4 +-
 hw/arm/nrf51_soc.c                       |   6 +-
 hw/arm/orangepi.c                        |  13 ++-
 hw/arm/raspi.c                           |   2 +-
 hw/arm/realview.c                        |   6 +-
 hw/arm/sbsa-ref.c                        |  16 +--
 hw/arm/stellaris.c                       |   4 +-
 hw/arm/stm32f205_soc.c                   |   8 +-
 hw/arm/stm32f405_soc.c                   |   8 +-
 hw/arm/versatilepb.c                     |   4 +-
 hw/arm/vexpress.c                        |   8 +-
 hw/arm/virt.c                            |  44 +++++----
 hw/arm/xilinx_zynq.c                     |   6 +-
 hw/arm/xlnx-versal-virt.c                |   8 +-
 hw/arm/xlnx-versal.c                     |  30 +++---
 hw/arm/xlnx-zcu102.c                     |   8 +-
 hw/arm/xlnx-zynqmp.c                     |  46 ++++-----
 hw/block/xen-block.c                     |   9 +-
 hw/core/bus.c                            |   8 +-
 hw/core/numa.c                           |   4 +-
 hw/core/qdev-properties-system.c         |  10 +-
 hw/core/qdev-properties.c                |  20 ++--
 hw/core/qdev.c                           |   8 +-
 hw/display/virtio-gpu-pci.c              |   5 +-
 hw/display/virtio-vga.c                  |   5 +-
 hw/dma/sparc32_dma.c                     |   6 +-
 hw/dma/xilinx_axidma.c                   |   4 +-
 hw/i386/pc.c                             |   8 +-
 hw/i386/pc_piix.c                        |   4 +-
 hw/i386/pc_q35.c                         |  28 +++---
 hw/i386/x86.c                            |   2 +-
 hw/ide/qdev.c                            |   2 +-
 hw/intc/pnv_xive.c                       |   9 +-
 hw/intc/spapr_xive.c                     |   9 +-
 hw/intc/xics.c                           |   4 +-
 hw/intc/xive.c                           |   4 +-
 hw/m68k/q800.c                           |   4 +-
 hw/mem/pc-dimm.c                         |   4 +-
 hw/microblaze/petalogix_ml605_mmu.c      |  24 ++---
 hw/microblaze/petalogix_s3adsp1800_mmu.c |   2 +-
 hw/microblaze/xlnx-zynqmp-pmu.c          |  30 +++---
 hw/mips/boston.c                         |   4 +-
 hw/mips/cps.c                            |  24 ++---
 hw/mips/jazz.c                           |   4 +-
 hw/mips/malta.c                          |   4 +-
 hw/misc/iotkit-sysctl.c                  |   2 +-
 hw/misc/macio/macio.c                    |   6 +-
 hw/net/ne2000-isa.c                      |   2 +-
 hw/net/xilinx_axienet.c                  |   4 +-
 hw/pci-host/pnv_phb3.c                   |  20 ++--
 hw/pci-host/pnv_phb4.c                   |   4 +-
 hw/pci-host/pnv_phb4_pec.c               |   4 +-
 hw/pci-host/prep.c                       |   4 +-
 hw/ppc/mac_newworld.c                    |  10 +-
 hw/ppc/mac_oldworld.c                    |   4 +-
 hw/ppc/pnv.c                             | 118 +++++++++++------------
 hw/ppc/pnv_psi.c                         |   9 +-
 hw/ppc/spapr.c                           |   4 +-
 hw/ppc/spapr_irq.c                       |   6 +-
 hw/ppc/spapr_pci.c                       |   2 +-
 hw/riscv/opentitan.c                     |   4 +-
 hw/riscv/sifive_e.c                      |   4 +-
 hw/riscv/sifive_u.c                      |   6 +-
 hw/riscv/spike.c                         |   4 +-
 hw/riscv/virt.c                          |   4 +-
 hw/rx/rx-gdbsim.c                        |  12 +--
 hw/s390x/ipl.c                           |   4 +-
 hw/s390x/s390-pci-bus.c                  |   2 +-
 hw/s390x/s390-skeys.c                    |   2 +-
 hw/s390x/s390-stattrib.c                 |   2 +-
 hw/s390x/s390-virtio-ccw.c               |   6 +-
 hw/s390x/virtio-ccw-crypto.c             |   5 +-
 hw/s390x/virtio-ccw-rng.c                |   3 +-
 hw/scsi/scsi-bus.c                       |   4 +-
 hw/sd/aspeed_sdhci.c                     |   6 +-
 hw/sd/ssi-sd.c                           |   2 +-
 hw/sparc/sun4m.c                         |   2 +-
 hw/sparc64/sun4u.c                       |   2 +-
 hw/usb/dev-storage.c                     |   4 +-
 hw/virtio/virtio-crypto-pci.c            |   5 +-
 hw/virtio/virtio-iommu-pci.c             |   4 +-
 hw/virtio/virtio-mem-pci.c               |   4 +-
 hw/virtio/virtio-pmem-pci.c              |   2 +-
 hw/virtio/virtio-rng-pci.c               |   3 +-
 hw/virtio/virtio-rng.c                   |   4 +-
 linux-user/syscall.c                     |   2 +-
 net/filter.c                             |   2 +-
 net/net.c                                |   2 +-
 qdev-monitor.c                           |   2 +-
 qom/object.c                             |  52 +++++-----
 qom/object_interfaces.c                  |   2 +-
 qom/qom-hmp-cmds.c                       |   2 +-
 qom/qom-qmp-cmds.c                       |   2 +-
 qom/qom-qobject.c                        |   9 +-
 softmmu/vl.c                             |  12 +--
 target/arm/monitor.c                     |   2 +-
 target/i386/cpu.c                        |  57 ++++++-----
 target/ppc/translate_init.inc.c          |   2 +-
 target/s390x/cpu_models.c                |   2 +-
 ui/console.c                             |   4 +-
 138 files changed, 712 insertions(+), 741 deletions(-)

diff --git a/include/hw/audio/pcspk.h b/include/hw/audio/pcspk.h
index 06cba00b83..9506179587 100644
--- a/include/hw/audio/pcspk.h
+++ b/include/hw/audio/pcspk.h
@@ -33,7 +33,7 @@
 
 static inline void pcspk_init(ISADevice *isadev, ISABus *bus, ISADevice *pit)
 {
-    object_property_set_link(OBJECT(isadev), OBJECT(pit), "pit", NULL);
+    object_property_set_link(OBJECT(isadev), "pit", OBJECT(pit), NULL);
     isa_realize_and_unref(isadev, bus, &error_fatal);
 }
 
diff --git a/include/qom/object.h b/include/qom/object.h
index 19c9adeebe..7c2c6791a4 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1203,26 +1203,26 @@ void object_unparent(Object *obj);
 /**
  * object_property_get:
  * @obj: the object
+ * @name: the name of the property
  * @v: the visitor that will receive the property value.  This should be an
  *   Output visitor and the data will be written with @name as the name.
- * @name: the name of the property
  * @errp: returns an error if this function fails
  *
  * Reads a property from a object.
  */
-void object_property_get(Object *obj, Visitor *v, const char *name,
+void object_property_get(Object *obj, const char *name, Visitor *v,
                          Error **errp);
 
 /**
  * object_property_set_str:
- * @value: the value to be written to the property
  * @name: the name of the property
+ * @value: the value to be written to the property
  * @errp: returns an error if this function fails
  *
  * Writes a string value to a property.
  */
-void object_property_set_str(Object *obj, const char *value,
-                             const char *name, Error **errp);
+void object_property_set_str(Object *obj, const char *name,
+                             const char *value, Error **errp);
 
 /**
  * object_property_get_str:
@@ -1239,8 +1239,8 @@ char *object_property_get_str(Object *obj, const char *name,
 
 /**
  * object_property_set_link:
- * @value: the value to be written to the property
  * @name: the name of the property
+ * @value: the value to be written to the property
  * @errp: returns an error if this function fails
  *
  * Writes an object's canonical path to a property.
@@ -1250,8 +1250,8 @@ char *object_property_get_str(Object *obj, const char *name,
  * unreferenced, and a reference is added to the new target object.
  *
  */
-void object_property_set_link(Object *obj, Object *value,
-                              const char *name, Error **errp);
+void object_property_set_link(Object *obj, const char *name,
+                              Object *value, Error **errp);
 
 /**
  * object_property_get_link:
@@ -1268,14 +1268,14 @@ Object *object_property_get_link(Object *obj, const char *name,
 
 /**
  * object_property_set_bool:
- * @value: the value to be written to the property
  * @name: the name of the property
+ * @value: the value to be written to the property
  * @errp: returns an error if this function fails
  *
  * Writes a bool value to a property.
  */
-void object_property_set_bool(Object *obj, bool value,
-                              const char *name, Error **errp);
+void object_property_set_bool(Object *obj, const char *name,
+                              bool value, Error **errp);
 
 /**
  * object_property_get_bool:
@@ -1291,14 +1291,14 @@ bool object_property_get_bool(Object *obj, const char *name,
 
 /**
  * object_property_set_int:
- * @value: the value to be written to the property
  * @name: the name of the property
+ * @value: the value to be written to the property
  * @errp: returns an error if this function fails
  *
  * Writes an integer value to a property.
  */
-void object_property_set_int(Object *obj, int64_t value,
-                             const char *name, Error **errp);
+void object_property_set_int(Object *obj, const char *name,
+                             int64_t value, Error **errp);
 
 /**
  * object_property_get_int:
@@ -1314,14 +1314,14 @@ int64_t object_property_get_int(Object *obj, const char *name,
 
 /**
  * object_property_set_uint:
- * @value: the value to be written to the property
  * @name: the name of the property
+ * @value: the value to be written to the property
  * @errp: returns an error if this function fails
  *
  * Writes an unsigned integer value to a property.
  */
-void object_property_set_uint(Object *obj, uint64_t value,
-                              const char *name, Error **errp);
+void object_property_set_uint(Object *obj, const char *name,
+                              uint64_t value, Error **errp);
 
 /**
  * object_property_get_uint:
@@ -1352,28 +1352,28 @@ int object_property_get_enum(Object *obj, const char *name,
 /**
  * object_property_set:
  * @obj: the object
+ * @name: the name of the property
  * @v: the visitor that will be used to write the property value.  This should
  *   be an Input visitor and the data will be first read with @name as the
  *   name and then written as the property value.
- * @name: the name of the property
  * @errp: returns an error if this function fails
  *
  * Writes a property to a object.
  */
-void object_property_set(Object *obj, Visitor *v, const char *name,
+void object_property_set(Object *obj, const char *name, Visitor *v,
                          Error **errp);
 
 /**
  * object_property_parse:
  * @obj: the object
- * @string: the string that will be used to parse the property value.
  * @name: the name of the property
+ * @string: the string that will be used to parse the property value.
  * @errp: returns an error if this function fails
  *
  * Parses a string and writes the result into a property of an object.
  */
-void object_property_parse(Object *obj, const char *string,
-                           const char *name, Error **errp);
+void object_property_parse(Object *obj, const char *name,
+                           const char *string, Error **errp);
 
 /**
  * object_property_print:
diff --git a/include/qom/qom-qobject.h b/include/qom/qom-qobject.h
index 82136e6e80..ad9a98dd62 100644
--- a/include/qom/qom-qobject.h
+++ b/include/qom/qom-qobject.h
@@ -28,13 +28,14 @@ struct QObject *object_property_get_qobject(Object *obj, const char *name,
 /**
  * object_property_set_qobject:
  * @obj: the object
- * @ret: The value that will be written to the property.
  * @name: the name of the property
+ * @value: The value that will be written to the property.
  * @errp: returns an error if this function fails
  *
  * Writes a property to a object.
  */
-void object_property_set_qobject(Object *obj, struct QObject *qobj,
-                                 const char *name, struct Error **errp);
+void object_property_set_qobject(Object *obj,
+                                 const char *name, struct QObject *value,
+                                 struct Error **errp);
 
 #endif
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 7e7265102e..72b7077475 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -214,7 +214,7 @@ static void cryptodev_backend_instance_init(Object *obj)
                           cryptodev_backend_set_queues,
                           NULL, NULL);
     /* Initialize devices' queues property to 1 */
-    object_property_set_int(obj, 1, "queues", NULL);
+    object_property_set_int(obj, "queues", 1, NULL);
 }
 
 static void cryptodev_backend_finalize(Object *obj)
diff --git a/backends/rng.c b/backends/rng.c
index 597f0ec268..484f04e891 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -48,7 +48,7 @@ static bool rng_backend_prop_get_opened(Object *obj, Error **errp)
 
 static void rng_backend_complete(UserCreatable *uc, Error **errp)
 {
-    object_property_set_bool(OBJECT(uc), true, "opened", errp);
+    object_property_set_bool(OBJECT(uc), "opened", true, errp);
 }
 
 static void rng_backend_prop_set_opened(Object *obj, bool value, Error **errp)
diff --git a/bootdevice.c b/bootdevice.c
index 769f40c77d..8185402a5a 100644
--- a/bootdevice.c
+++ b/bootdevice.c
@@ -341,7 +341,7 @@ void device_add_bootindex_property(Object *obj, int32_t *bootindex,
                         prop);
 
     /* initialize devices' bootindex property to -1 */
-    object_property_set_int(obj, -1, name, NULL);
+    object_property_set_int(obj, name, -1, NULL);
 }
 
 typedef struct FWLCHSEntry FWLCHSEntry;
diff --git a/crypto/secret.c b/crypto/secret.c
index 3447e2f64b..281cb81f0f 100644
--- a/crypto/secret.c
+++ b/crypto/secret.c
@@ -110,7 +110,7 @@ qcrypto_secret_prop_get_file(Object *obj,
 static void
 qcrypto_secret_complete(UserCreatable *uc, Error **errp)
 {
-    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+    object_property_set_bool(OBJECT(uc), "loaded", true, errp);
 }
 
 
diff --git a/crypto/secret_keyring.c b/crypto/secret_keyring.c
index 4f132d6370..8bfc58ebf4 100644
--- a/crypto/secret_keyring.c
+++ b/crypto/secret_keyring.c
@@ -105,7 +105,7 @@ qcrypto_secret_prop_get_key(Object *obj, Visitor *v,
 static void
 qcrypto_secret_keyring_complete(UserCreatable *uc, Error **errp)
 {
-    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+    object_property_set_bool(OBJECT(uc), "loaded", true, errp);
 }
 
 
diff --git a/crypto/tlscredsanon.c b/crypto/tlscredsanon.c
index fc078d5b97..30275b6847 100644
--- a/crypto/tlscredsanon.c
+++ b/crypto/tlscredsanon.c
@@ -165,7 +165,7 @@ qcrypto_tls_creds_anon_prop_get_loaded(Object *obj G_GNUC_UNUSED,
 static void
 qcrypto_tls_creds_anon_complete(UserCreatable *uc, Error **errp)
 {
-    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+    object_property_set_bool(OBJECT(uc), "loaded", true, errp);
 }
 
 
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
index f01b64d8bc..e26807b899 100644
--- a/crypto/tlscredspsk.c
+++ b/crypto/tlscredspsk.c
@@ -234,7 +234,7 @@ qcrypto_tls_creds_psk_prop_get_loaded(Object *obj G_GNUC_UNUSED,
 static void
 qcrypto_tls_creds_psk_complete(UserCreatable *uc, Error **errp)
 {
-    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+    object_property_set_bool(OBJECT(uc), "loaded", true, errp);
 }
 
 
diff --git a/crypto/tlscredsx509.c b/crypto/tlscredsx509.c
index e337d68c4f..dd7267ccdb 100644
--- a/crypto/tlscredsx509.c
+++ b/crypto/tlscredsx509.c
@@ -774,7 +774,7 @@ qcrypto_tls_creds_x509_prop_get_sanity(Object *obj,
 static void
 qcrypto_tls_creds_x509_complete(UserCreatable *uc, Error **errp)
 {
-    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+    object_property_set_bool(OBJECT(uc), "loaded", true, errp);
 }
 
 
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 3e687d227a..53654f8638 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -41,7 +41,7 @@ static void cpu_status_write(void *opaque, hwaddr addr, uint64_t data,
      */
     if (addr == 0 && data == 0) {
         AcpiCpuHotplug *cpus = opaque;
-        object_property_set_bool(cpus->device, false, "cpu-hotplug-legacy",
+        object_property_set_bool(cpus->device, "cpu-hotplug-legacy", false,
                                  &error_abort);
     }
 }
@@ -63,7 +63,7 @@ static void acpi_set_cpu_present_bit(AcpiCpuHotplug *g, CPUState *cpu)
 
     cpu_id = k->get_arch_id(cpu);
     if ((cpu_id / 8) >= ACPI_GPE_PROC_LEN) {
-        object_property_set_bool(g->device, false, "cpu-hotplug-legacy",
+        object_property_set_bool(g->device, "cpu-hotplug-legacy", false,
                                  &error_abort);
         return;
     }
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 2d204babc6..6a19070cec 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -201,7 +201,7 @@ static int vmstate_cpuhp_pre_load(void *opaque)
 {
     ICH9LPCPMRegs *s = opaque;
     Object *obj = OBJECT(s->gpe_cpu.device);
-    object_property_set_bool(obj, false, "cpu-hotplug-legacy", &error_abort);
+    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
     return 0;
 }
 
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 283422e0d3..26bac4f16c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -244,7 +244,7 @@ static bool vmstate_test_use_cpuhp(void *opaque)
 static int vmstate_cpuhp_pre_load(void *opaque)
 {
     Object *obj = OBJECT(opaque);
-    object_property_set_bool(obj, false, "cpu-hotplug-legacy", &error_abort);
+    object_property_set_bool(obj, "cpu-hotplug-legacy", false, &error_abort);
     return 0;
 }
 
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index e1acffe5f6..c5d604af68 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -142,15 +142,15 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
 
             sprintf(bus, "usb-bus.%d", i);
 
-            object_property_set_bool(OBJECT(&s->ehci[i]), true,
-                                     "companion-enable", &error_fatal);
+            object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
+                                     true, &error_fatal);
             sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                             AW_A10_EHCI_BASE + i * 0x8000);
             sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
                                qdev_get_gpio_in(dev, 39 + i));
 
-            object_property_set_str(OBJECT(&s->ohci[i]), bus, "masterbus",
+            object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
                                     &error_fatal);
             sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
             sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 9a48bf86c3..1f8ce94ecc 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -534,21 +534,21 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * later if necessary.
          */
         if (extract32(info->cpuwait_rst, i, 1)) {
-            object_property_set_bool(cpuobj, true, "start-powered-off", &err);
+            object_property_set_bool(cpuobj, "start-powered-off", true, &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
             }
         }
         if (!s->cpu_fpu[i]) {
-            object_property_set_bool(cpuobj, false, "vfp", &err);
+            object_property_set_bool(cpuobj, "vfp", false, &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
             }
         }
         if (!s->cpu_dsp[i]) {
-            object_property_set_bool(cpuobj, false, "dsp", &err);
+            object_property_set_bool(cpuobj, "dsp", false, &err);
             if (err) {
                 error_propagate(errp, err);
                 return;
@@ -562,9 +562,9 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             memory_region_add_subregion_overlap(&s->cpu_container[i], 0,
                                                 &s->container, -1);
         }
-        object_property_set_link(cpuobj, OBJECT(&s->cpu_container[i]),
-                                 "memory", &error_abort);
-        object_property_set_link(cpuobj, OBJECT(s), "idau", &error_abort);
+        object_property_set_link(cpuobj, "memory",
+                                 OBJECT(&s->cpu_container[i]), &error_abort);
+        object_property_set_link(cpuobj, "idau", OBJECT(s), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(cpuobj), &err)) {
             error_propagate(errp, err);
             return;
@@ -604,8 +604,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                 DeviceState *devs = DEVICE(splitter);
                 int cpunum;
 
-                object_property_set_int(splitter, info->num_cpus,
-                                        "num-lines", &err);
+                object_property_set_int(splitter, "num-lines", info->num_cpus,
+                                        &err);
                 if (err) {
                     error_propagate(errp, err);
                     return;
@@ -658,8 +658,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * multiple lines, one for each of the PPCs within the ARMSSE and one
      * that will be an output from the ARMSSE to the system.
      */
-    object_property_set_int(OBJECT(&s->sec_resp_splitter), 3,
-                            "num-lines", &err);
+    object_property_set_int(OBJECT(&s->sec_resp_splitter), "num-lines", 3,
+                            &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -685,8 +685,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, err);
             return;
         }
-        object_property_set_link(OBJECT(&s->mpc[i]), OBJECT(&s->sram[i]),
-                                 "downstream", &error_abort);
+        object_property_set_link(OBJECT(&s->mpc[i]), "downstream",
+                                 OBJECT(&s->sram[i]), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->mpc[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -702,9 +702,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* We must OR together lines from the MPC splitters to go to the NVIC */
-    object_property_set_int(OBJECT(&s->mpc_irq_orgate),
-                            IOTS_NUM_EXP_MPC + info->sram_banks,
-                            "num-lines", &err);
+    object_property_set_int(OBJECT(&s->mpc_irq_orgate), "num-lines",
+                            IOTS_NUM_EXP_MPC + info->sram_banks, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -734,7 +733,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer0), 0,
                        armsse_get_common_irq_in(s, 3));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer0), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[0]",
+    object_property_set_link(OBJECT(&s->apb_ppc0), "port[0]", OBJECT(mr),
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->timer1), "pclk-frq", s->mainclk_frq);
@@ -745,7 +744,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer1), 0,
                        armsse_get_common_irq_in(s, 4));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->timer1), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[1]",
+    object_property_set_link(OBJECT(&s->apb_ppc0), "port[1]", OBJECT(mr),
                              &error_abort);
 
     qdev_prop_set_uint32(DEVICE(&s->dualtimer), "pclk-frq", s->mainclk_frq);
@@ -756,7 +755,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dualtimer), 0,
                        armsse_get_common_irq_in(s, 5));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dualtimer), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr), "port[2]",
+    object_property_set_link(OBJECT(&s->apb_ppc0), "port[2]", OBJECT(mr),
                              &error_abort);
 
     if (info->has_mhus) {
@@ -780,8 +779,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
             }
             port = g_strdup_printf("port[%d]", i + 3);
             mr = sysbus_mmio_get_region(mhu_sbd, 0);
-            object_property_set_link(OBJECT(&s->apb_ppc0), OBJECT(mr),
-                                     port, &error_abort);
+            object_property_set_link(OBJECT(&s->apb_ppc0), port, OBJECT(mr),
+                                     &error_abort);
             g_free(port);
 
             /*
@@ -842,8 +841,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
      * ones) are sent individually to the security controller, and also
      * ORed together to give a single combined PPC interrupt to the NVIC.
      */
-    object_property_set_int(OBJECT(&s->ppc_irq_orgate),
-                            NUM_PPCS, "num-lines", &err);
+    object_property_set_int(OBJECT(&s->ppc_irq_orgate), "num-lines", NUM_PPCS,
+                            &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -923,7 +922,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->s32ktimer), 0,
                        armsse_get_common_irq_in(s, 2));
     mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->s32ktimer), 0);
-    object_property_set_link(OBJECT(&s->apb_ppc1), OBJECT(mr), "port[0]",
+    object_property_set_link(OBJECT(&s->apb_ppc1), "port[0]", OBJECT(mr),
                              &error_abort);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->apb_ppc1), &err)) {
@@ -950,15 +949,14 @@ static void armsse_realize(DeviceState *dev, Error **errp)
                           qdev_get_gpio_in_named(dev_apb_ppc1,
                                                  "cfg_sec_resp", 0));
 
-    object_property_set_int(OBJECT(&s->sysinfo), info->sys_version,
-                            "SYS_VERSION", &err);
+    object_property_set_int(OBJECT(&s->sysinfo), "SYS_VERSION",
+                            info->sys_version, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-    object_property_set_int(OBJECT(&s->sysinfo),
-                            armsse_sys_config_value(s, info),
-                            "SYS_CONFIG", &err);
+    object_property_set_int(OBJECT(&s->sysinfo), "SYS_CONFIG",
+                            armsse_sys_config_value(s, info), &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -970,14 +968,14 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     /* System information registers */
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysinfo), 0, 0x40020000);
     /* System control registers */
-    object_property_set_int(OBJECT(&s->sysctl), info->sys_version,
-                            "SYS_VERSION", &error_abort);
-    object_property_set_int(OBJECT(&s->sysctl), info->cpuwait_rst,
-                            "CPUWAIT_RST", &error_abort);
-    object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
-                            "INITSVTOR0_RST", &error_abort);
-    object_property_set_int(OBJECT(&s->sysctl), s->init_svtor,
-                            "INITSVTOR1_RST", &error_abort);
+    object_property_set_int(OBJECT(&s->sysctl), "SYS_VERSION",
+                            info->sys_version, &error_abort);
+    object_property_set_int(OBJECT(&s->sysctl), "CPUWAIT_RST",
+                            info->cpuwait_rst, &error_abort);
+    object_property_set_int(OBJECT(&s->sysctl), "INITSVTOR0_RST",
+                            s->init_svtor, &error_abort);
+    object_property_set_int(OBJECT(&s->sysctl), "INITSVTOR1_RST",
+                            s->init_svtor, &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), &err)) {
         error_propagate(errp, err);
         return;
@@ -1007,7 +1005,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     }
 
     /* This OR gate wires together outputs from the secure watchdogs to NMI */
-    object_property_set_int(OBJECT(&s->nmi_orgate), 2, "num-lines", &err);
+    object_property_set_int(OBJECT(&s->nmi_orgate), "num-lines", 2, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -1051,7 +1049,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->ppc_irq_splitter); i++) {
         Object *splitter = OBJECT(&s->ppc_irq_splitter[i]);
 
-        object_property_set_int(splitter, 2, "num-lines", &err);
+        object_property_set_int(splitter, "num-lines", 2, &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -1097,7 +1095,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         SplitIRQ *splitter = &s->mpc_irq_splitter[i];
         DeviceState *dev_splitter = DEVICE(splitter);
 
-        object_property_set_int(OBJECT(splitter), 2, "num-lines", &err);
+        object_property_set_int(OBJECT(splitter), "num-lines", 2, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 28baf330e5..923f7fad40 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -167,39 +167,37 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
+    object_property_set_link(OBJECT(s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
     if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
-        object_property_set_link(OBJECT(s->cpu), s->idau, "idau",
+        object_property_set_link(OBJECT(s->cpu), "idau", s->idau,
                                  &error_abort);
     }
     if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
-        object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
-                                 "init-svtor", &err);
+        object_property_set_uint(OBJECT(s->cpu), "init-svtor", s->init_svtor,
+                                 &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "start-powered-off", NULL)) {
-        object_property_set_bool(OBJECT(s->cpu), s->start_powered_off,
-                                 "start-powered-off", &err);
+        object_property_set_bool(OBJECT(s->cpu), "start-powered-off",
+                                 s->start_powered_off, &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
-        object_property_set_bool(OBJECT(s->cpu), s->vfp,
-                                 "vfp", &err);
+        object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
-        object_property_set_bool(OBJECT(s->cpu), s->dsp,
-                                 "dsp", &err);
+        object_property_set_bool(OBJECT(s->cpu), "dsp", s->dsp, &err);
         if (err != NULL) {
             error_propagate(errp, err);
             return;
@@ -245,13 +243,13 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             Object *obj = OBJECT(&s->bitband[i]);
             SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
-            object_property_set_int(obj, bitband_input_addr[i], "base", &err);
+            object_property_set_int(obj, "base", bitband_input_addr[i], &err);
             if (err != NULL) {
                 error_propagate(errp, err);
                 return;
             }
-            object_property_set_link(obj, OBJECT(s->board_memory),
-                                     "source-memory", &error_abort);
+            object_property_set_link(obj, "source-memory",
+                                     OBJECT(s->board_memory), &error_abort);
             if (!sysbus_realize(SYS_BUS_DEVICE(obj), &err)) {
                 error_propagate(errp, err);
                 return;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 379f9672a5..660dcb5414 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -277,7 +277,7 @@ static void aspeed_machine_init(MachineState *machine)
     /*
      * This will error out if isize is not supported by memory controller.
      */
-    object_property_set_uint(OBJECT(&bmc->soc), ram_size, "ram-size",
+    object_property_set_uint(OBJECT(&bmc->soc), "ram-size", ram_size,
                              &error_fatal);
 
     for (i = 0; i < sc->macs_num; i++) {
@@ -288,22 +288,22 @@ static void aspeed_machine_init(MachineState *machine)
         }
     }
 
-    object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap1, "hw-strap1",
+    object_property_set_int(OBJECT(&bmc->soc), "hw-strap1", amc->hw_strap1,
                             &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), amc->hw_strap2, "hw-strap2",
+    object_property_set_int(OBJECT(&bmc->soc), "hw-strap2", amc->hw_strap2,
                             &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), amc->num_cs, "num-cs",
+    object_property_set_int(OBJECT(&bmc->soc), "num-cs", amc->num_cs,
                             &error_abort);
-    object_property_set_link(OBJECT(&bmc->soc), OBJECT(&bmc->ram_container),
-                             "dram", &error_abort);
+    object_property_set_link(OBJECT(&bmc->soc), "dram",
+                             OBJECT(&bmc->ram_container), &error_abort);
     if (machine->kernel_filename) {
         /*
          * When booting with a -kernel command line there is no u-boot
          * that runs to unlock the SCU. In this case set the default to
          * be unlocked as the kernel expects
          */
-        object_property_set_int(OBJECT(&bmc->soc), ASPEED_SCU_PROT_KEY,
-                                "hw-prot-key", &error_abort);
+        object_property_set_int(OBJECT(&bmc->soc), "hw-prot-key",
+                                ASPEED_SCU_PROT_KEY, &error_abort);
     }
     qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
 
@@ -393,10 +393,10 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
     /* add a TMP423 temperature sensor */
     dev = i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 2),
                            "tmp423", 0x4c);
-    object_property_set_int(OBJECT(dev), 31000, "temperature0", &error_abort);
-    object_property_set_int(OBJECT(dev), 28000, "temperature1", &error_abort);
-    object_property_set_int(OBJECT(dev), 20000, "temperature2", &error_abort);
-    object_property_set_int(OBJECT(dev), 110000, "temperature3", &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
 }
 
 static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index b9ae4c12b4..e6e2cf0737 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -196,7 +196,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     object_initialize_child(obj, "sd-controller", &s->sdhci,
                             TYPE_ASPEED_SDHCI);
 
-    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
+    object_property_set_int(OBJECT(&s->sdhci), "num-slots", 2, &error_abort);
 
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
@@ -207,7 +207,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     object_initialize_child(obj, "emmc-controller", &s->emmc,
                             TYPE_ASPEED_SDHCI);
 
-    object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
+    object_property_set_int(OBJECT(&s->emmc), "num-slots", 1, &error_abort);
 
     object_initialize_child(obj, "emmc-controller.sdhci", &s->emmc.slots[0],
                             TYPE_SYSBUS_SDHCI);
@@ -241,17 +241,16 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
-        object_property_set_int(OBJECT(&s->cpu[i]), QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
+        object_property_set_int(OBJECT(&s->cpu[i]), "psci-conduit",
+                                QEMU_PSCI_CONDUIT_SMC, &error_abort);
         if (sc->num_cpus > 1) {
-            object_property_set_int(OBJECT(&s->cpu[i]),
-                                    ASPEED_A7MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+                                    ASPEED_A7MPCORE_ADDR, &error_abort);
         }
-        object_property_set_int(OBJECT(&s->cpu[i]), aspeed_calc_affinity(i),
-                                "mp-affinity", &error_abort);
+        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
+                                aspeed_calc_affinity(i), &error_abort);
 
-        object_property_set_int(OBJECT(&s->cpu[i]), 1125000000, "cntfrq",
+        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 1125000000,
                                 &error_abort);
 
         /*
@@ -266,11 +265,11 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* A7MPCORE */
-    object_property_set_int(OBJECT(&s->a7mpcore), sc->num_cpus, "num-cpu",
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", sc->num_cpus,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore),
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
                             ASPEED_SOC_AST2600_MAX_IRQ + GIC_INTERNAL,
-                            "num-irq", &error_abort);
+                            &error_abort);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
@@ -316,8 +315,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_RTC));
 
     /* Timer */
-    object_property_set_link(OBJECT(&s->timerctrl),
-                             OBJECT(&s->scu), "scu", &error_abort);
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err)) {
         error_propagate(errp, err);
         return;
@@ -337,7 +336,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* I2C */
-    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
+    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err)) {
         error_propagate(errp, err);
@@ -355,10 +354,10 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* FMC, The number of CS is set at the board level */
-    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram",
+    object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-    object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
-                            "sdram-base", &err);
+    object_property_set_int(OBJECT(&s->fmc), "sdram-base",
+                            sc->memmap[ASPEED_SDRAM], &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -375,10 +374,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
-        object_property_set_link(OBJECT(&s->spi[i]), OBJECT(s->dram_mr),
-                                 "dram", &error_abort);
-        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
-                                &error_abort);
+        object_property_set_link(OBJECT(&s->spi[i]), "dram",
+                                 OBJECT(s->dram_mr), &error_abort);
+        object_property_set_int(OBJECT(&s->spi[i]), "num-cs", 1, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -412,8 +410,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->wdts_num; i++) {
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
-        object_property_set_link(OBJECT(&s->wdt[i]),
-                                 OBJECT(&s->scu), "scu", &error_abort);
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
+                                 &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -424,7 +422,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* Net */
     for (i = 0; i < sc->macs_num; i++) {
-        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err)) {
             error_propagate(errp, err);
@@ -435,8 +433,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
 
-        object_property_set_link(OBJECT(&s->mii[i]), OBJECT(&s->ftgmac100[i]),
-                                 "nic", &error_abort);
+        object_property_set_link(OBJECT(&s->mii[i]), "nic",
+                                 OBJECT(&s->ftgmac100[i]), &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->mii[i]), &err)) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index fa56f96f92..27704d87ea 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -204,7 +204,7 @@ static void aspeed_soc_init(Object *obj)
 
     object_initialize_child(obj, "sdc", &s->sdhci, TYPE_ASPEED_SDHCI);
 
-    object_property_set_int(OBJECT(&s->sdhci), 2, "num-slots", &error_abort);
+    object_property_set_int(OBJECT(&s->sdhci), "num-slots", 2, &error_abort);
 
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
@@ -274,8 +274,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_RTC));
 
     /* Timer */
-    object_property_set_link(OBJECT(&s->timerctrl),
-                             OBJECT(&s->scu), "scu", &error_abort);
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
+                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), &err)) {
         error_propagate(errp, err);
         return;
@@ -295,7 +295,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* I2C */
-    object_property_set_link(OBJECT(&s->i2c), OBJECT(s->dram_mr), "dram",
+    object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->i2c), &err)) {
         error_propagate(errp, err);
@@ -306,10 +306,10 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                        aspeed_soc_get_irq(s, ASPEED_I2C));
 
     /* FMC, The number of CS is set at the board level */
-    object_property_set_link(OBJECT(&s->fmc), OBJECT(s->dram_mr), "dram",
+    object_property_set_link(OBJECT(&s->fmc), "dram", OBJECT(s->dram_mr),
                              &error_abort);
-    object_property_set_int(OBJECT(&s->fmc), sc->memmap[ASPEED_SDRAM],
-                            "sdram-base", &err);
+    object_property_set_int(OBJECT(&s->fmc), "sdram-base",
+                            sc->memmap[ASPEED_SDRAM], &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -326,8 +326,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* SPI */
     for (i = 0; i < sc->spis_num; i++) {
-        object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs",
-                                &error_abort);
+        object_property_set_int(OBJECT(&s->spi[i]), "num-cs", 1, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -361,8 +360,8 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < sc->wdts_num; i++) {
         AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
 
-        object_property_set_link(OBJECT(&s->wdt[i]),
-                                 OBJECT(&s->scu), "scu", &error_abort);
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
+                                 &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -373,7 +372,7 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
 
     /* Net */
     for (i = 0; i < sc->macs_num; i++) {
-        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), "aspeed", true,
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ftgmac100[i]), &err)) {
             error_propagate(errp, err);
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index beade39e41..a6ccf3b368 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -222,8 +222,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_uint(OBJECT(&s->fb), ram_size - vcram_size,
-                             "vcram-base", &err);
+    object_property_set_uint(OBJECT(&s->fb), "vcram-base",
+                             ram_size - vcram_size, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -270,11 +270,11 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
      * For the exact details please refer to the Arasan documentation:
      *   SD3.0_Host_AHB_eMMC4.4_Usersguide_ver5.9_jan11_10.pdf
      */
-    object_property_set_uint(OBJECT(&s->sdhci), 3, "sd-spec-version",
+    object_property_set_uint(OBJECT(&s->sdhci), "sd-spec-version", 3,
                              &error_abort);
-    object_property_set_uint(OBJECT(&s->sdhci), BCM2835_SDHC_CAPAREG, "capareg",
-                             &error_abort);
-    object_property_set_bool(OBJECT(&s->sdhci), true, "pending-insert-quirk",
+    object_property_set_uint(OBJECT(&s->sdhci), "capareg",
+                             BCM2835_SDHC_CAPAREG, &error_abort);
+    object_property_set_bool(OBJECT(&s->sdhci), "pending-insert-quirk", true,
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci), &err)) {
         error_propagate(errp, err);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 70ca2f0d9a..91d31a5cb7 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -110,17 +110,16 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         s->cpu[n].core.mp_affinity = (info->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        object_property_set_int(OBJECT(&s->cpu[n].core),
-                                info->peri_base,
-                                "reset-cbar", &err);
+        object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+                                info->peri_base, &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
 
         /* start powered off if not enabled */
-        object_property_set_bool(OBJECT(&s->cpu[n].core), n >= s->enabled_cpus,
-                                 "start-powered-off", &err);
+        object_property_set_bool(OBJECT(&s->cpu[n].core), "start-powered-off",
+                                 n >= s->enabled_cpus, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index c720e24ced..302919246b 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -62,19 +62,19 @@ static void cubieboard_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "soc", OBJECT(a10));
     object_unref(OBJECT(a10));
 
-    object_property_set_int(OBJECT(&a10->emac), 1, "phy-addr", &err);
+    object_property_set_int(OBJECT(&a10->emac), "phy-addr", 1, &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set phy address: ");
         exit(1);
     }
 
-    object_property_set_int(OBJECT(&a10->timer), 32768, "clk0-freq", &err);
+    object_property_set_int(OBJECT(&a10->timer), "clk0-freq", 32768, &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set clk0 frequency: ");
         exit(1);
     }
 
-    object_property_set_int(OBJECT(&a10->timer), 24000000, "clk1-freq", &err);
+    object_property_set_int(OBJECT(&a10->timer), "clk1-freq", 24000000, &err);
     if (err != NULL) {
         error_reportf_err(err, "Couldn't set clk1 frequency: ");
         exit(1);
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 1494c2900a..ffc89d86b8 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -56,7 +56,7 @@ static void digic_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd;
     int i;
 
-    object_property_set_bool(OBJECT(&s->cpu), true, "reset-hivecs", &err);
+    object_property_set_bool(OBJECT(&s->cpu), "reset-hivecs", true, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index fa639806ec..081bbff317 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -188,7 +188,7 @@ static DeviceState *pl330_create(uint32_t base, qemu_or_irq *orgate,
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, base);
 
-    object_property_set_int(OBJECT(orgate), nevents + 1, "num-lines",
+    object_property_set_int(OBJECT(orgate), "num-lines", nevents + 1,
                             &error_abort);
     qdev_realize(DEVICE(orgate), NULL, &error_abort);
 
@@ -215,14 +215,15 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
          * support EL3 so the CPU EL3 property is disabled before realization.
          */
         if (object_property_find(cpuobj, "has_el3", NULL)) {
-            object_property_set_bool(cpuobj, false, "has_el3", &error_fatal);
+            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
         }
 
         s->cpu[n] = ARM_CPU(cpuobj);
-        object_property_set_int(cpuobj, exynos4210_calc_affinity(n),
-                                "mp-affinity", &error_abort);
-        object_property_set_int(cpuobj, EXYNOS4210_SMP_PRIVATE_BASE_ADDR,
-                                "reset-cbar", &error_abort);
+        object_property_set_int(cpuobj, "mp-affinity",
+                                exynos4210_calc_affinity(n), &error_abort);
+        object_property_set_int(cpuobj, "reset-cbar",
+                                EXYNOS4210_SMP_PRIVATE_BASE_ADDR,
+                                &error_abort);
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
     }
 
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 250681f045..ea72a02d06 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -249,14 +249,12 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
             { FSL_IMX25_ESDHC2_ADDR, FSL_IMX25_ESDHC2_IRQ },
         };
 
-        object_property_set_uint(OBJECT(&s->esdhc[i]), 2, "sd-spec-version",
-                                 &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
-                                 "capareg",
-                                 &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
-                                 "vendor",
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "sd-spec-version", 2,
                                  &error_abort);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
+                                 IMX25_ESDHC_CAPABILITIES, &error_abort);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -285,7 +283,7 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
     }
 
     /* Watchdog */
-    object_property_set_bool(OBJECT(&s->wdt), true, "pretimeout-support",
+    object_property_set_bool(OBJECT(&s->wdt), "pretimeout-support", true,
                              &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX25_WDT_ADDR);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 4f007ea5e8..23a5f50175 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -179,7 +179,7 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
             { FSL_IMX31_GPIO3_ADDR, FSL_IMX31_GPIO3_IRQ }
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), false, "has-edge-sel",
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", false,
                                  &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
             error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 417ca6889c..e359ee579d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -120,14 +120,14 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
 
         /* On uniprocessor, the CBAR is set to 0 */
         if (smp_cpus > 1) {
-            object_property_set_int(OBJECT(&s->cpu[i]), FSL_IMX6_A9MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
+            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+                                    FSL_IMX6_A9MPCORE_ADDR, &error_abort);
         }
 
         /* All CPU but CPU 0 start in power off mode */
         if (i) {
-            object_property_set_bool(OBJECT(&s->cpu[i]), true,
-                                     "start-powered-off", &error_abort);
+            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
+                                     true, &error_abort);
         }
 
         if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, &err)) {
@@ -136,12 +136,11 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    object_property_set_int(OBJECT(&s->a9mpcore), smp_cpus, "num-cpu",
+    object_property_set_int(OBJECT(&s->a9mpcore), "num-cpu", smp_cpus,
                             &error_abort);
 
-    object_property_set_int(OBJECT(&s->a9mpcore),
-                            FSL_IMX6_MAX_IRQ + GIC_INTERNAL, "num-irq",
-                            &error_abort);
+    object_property_set_int(OBJECT(&s->a9mpcore), "num-irq",
+                            FSL_IMX6_MAX_IRQ + GIC_INTERNAL, &error_abort);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), &err)) {
         error_propagate(errp, err);
@@ -295,10 +294,10 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             },
         };
 
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-edge-sel",
-                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->gpio[i]), true, "has-upper-pin-irq",
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-edge-sel", true,
                                  &error_abort);
+        object_property_set_bool(OBJECT(&s->gpio[i]), "has-upper-pin-irq",
+                                 true, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -326,14 +325,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         };
 
         /* UHS-I SDIO3.0 SDR104 1.8V ADMA */
-        object_property_set_uint(OBJECT(&s->esdhc[i]), 3, "sd-spec-version",
-                                 &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
-                                 "capareg",
-                                 &error_abort);
-        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
-                                 "vendor",
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "sd-spec-version", 3,
                                  &error_abort);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
+                                 IMX6_ESDHC_CAPABILITIES, &error_abort);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), &err)) {
             error_propagate(errp, err);
             return;
@@ -417,8 +414,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             FSL_IMX6_WDOG2_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
-                                 &error_abort);
+        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
+                                 true, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 51b2f256ec..e0128d7316 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -166,17 +166,16 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    object_property_set_int(OBJECT(&s->cpu), QEMU_PSCI_CONDUIT_SMC,
-                            "psci-conduit", &error_abort);
+    object_property_set_int(OBJECT(&s->cpu), "psci-conduit",
+                            QEMU_PSCI_CONDUIT_SMC, &error_abort);
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
 
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), 1, "num-cpu", &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore),
-                            FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL,
-                            "num-irq", &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", 1, &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
+                            FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL, &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
 
@@ -427,12 +426,10 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_ENET2_TIMER_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->eth[i]),
-                                 s->phy_num[i],
-                                 "phy-num", &error_abort);
-        object_property_set_uint(OBJECT(&s->eth[i]),
-                                 FSL_IMX6UL_ETH_NUM_TX_RINGS,
-                                 "tx-ring-num", &error_abort);
+        object_property_set_uint(OBJECT(&s->eth[i]), "phy-num",
+                                 s->phy_num[i], &error_abort);
+        object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
+                                 FSL_IMX6UL_ETH_NUM_TX_RINGS, &error_abort);
         qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
         sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
 
@@ -482,8 +479,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_USDHC2_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
-                                        "vendor", &error_abort);
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
@@ -515,8 +512,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_WDOG3_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
-                                 &error_abort);
+        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
+                                 true, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index b49d895a41..fad637d328 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -159,19 +159,19 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < smp_cpus; i++) {
         o = OBJECT(&s->cpu[i]);
 
-        object_property_set_int(o, QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
+        object_property_set_int(o, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
+                                &error_abort);
 
         /* On uniprocessor, the CBAR is set to 0 */
         if (smp_cpus > 1) {
-            object_property_set_int(o, FSL_IMX7_A7MPCORE_ADDR,
-                                    "reset-cbar", &error_abort);
+            object_property_set_int(o, "reset-cbar", FSL_IMX7_A7MPCORE_ADDR,
+                                    &error_abort);
         }
 
         if (i) {
             /* Secondary CPUs start in PSCI powered-down state */
-            object_property_set_bool(o, true,
-                                     "start-powered-off", &error_abort);
+            object_property_set_bool(o, "start-powered-off", true,
+                                     &error_abort);
         }
 
         qdev_realize(DEVICE(o), NULL, &error_abort);
@@ -180,11 +180,10 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), smp_cpus, "num-cpu",
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", smp_cpus,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore),
-                            FSL_IMX7_MAX_IRQ + GIC_INTERNAL,
-                            "num-irq", &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
+                            FSL_IMX7_MAX_IRQ + GIC_INTERNAL, &error_abort);
 
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX7_A7MPCORE_ADDR);
@@ -364,8 +363,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_ENET2_ADDR,
         };
 
-        object_property_set_uint(OBJECT(&s->eth[i]), FSL_IMX7_ETH_NUM_TX_RINGS,
-                                 "tx-ring-num", &error_abort);
+        object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
+                                 FSL_IMX7_ETH_NUM_TX_RINGS, &error_abort);
         qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
         sysbus_realize(SYS_BUS_DEVICE(&s->eth[i]), &error_abort);
 
@@ -393,8 +392,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USDHC3_IRQ,
         };
 
-        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
-                                 "vendor", &error_abort);
+        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
+                                 SDHCI_VENDOR_IMX, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
@@ -432,8 +431,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_WDOG4_IRQ,
         };
 
-        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
-                                 &error_abort);
+        object_property_set_bool(OBJECT(&s->wdt[i]), "pretimeout-support",
+                                 true, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX7_WDOGn_ADDR[i]);
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index c7ef48ecde..c96f2ab9cf 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -267,18 +267,18 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         cpuobj = object_new(machine->cpu_type);
         cpu = ARM_CPU(cpuobj);
 
-        object_property_set_int(cpuobj, QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
+        object_property_set_int(cpuobj, "psci-conduit", QEMU_PSCI_CONDUIT_SMC,
+                                &error_abort);
 
         if (n) {
             /* Secondary CPUs start in PSCI powered-down state */
-            object_property_set_bool(cpuobj, true,
-                                     "start-powered-off", &error_abort);
+            object_property_set_bool(cpuobj, "start-powered-off", true,
+                                     &error_abort);
         }
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, MPCORE_PERIPHBASE,
-                                    "reset-cbar", &error_abort);
+            object_property_set_int(cpuobj, "reset-cbar", MPCORE_PERIPHBASE,
+                                    &error_abort);
         }
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         cpu_irq[n] = qdev_get_gpio_in(DEVICE(cpu), ARM_CPU_IRQ);
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b11a846355..f304c2b4f0 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -604,7 +604,7 @@ static void integratorcp_init(MachineState *machine)
      * realization.
      */
     if (object_property_find(cpuobj, "has_el3", NULL)) {
-        object_property_set_bool(cpuobj, false, "has_el3", &error_fatal);
+        object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
     }
 
     qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 9033d3f8f3..ed69a7b037 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -40,8 +40,8 @@ static void mcimx6ul_evk_init(MachineState *machine)
 
     s = FSL_IMX6UL(object_new(TYPE_FSL_IMX6UL));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_uint(OBJECT(s), 2, "fec1-phy-num", &error_fatal);
-    object_property_set_uint(OBJECT(s), 1, "fec2-phy-num", &error_fatal);
+    object_property_set_uint(OBJECT(s), "fec1-phy-num", 2, &error_fatal);
+    object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 8fe42c9d6a..a91acab1cb 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -40,8 +40,8 @@ static void microbit_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "nrf51", &s->nrf51,
                             TYPE_NRF51_SOC);
     qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
-    object_property_set_link(OBJECT(&s->nrf51), OBJECT(system_memory),
-                             "memory", &error_fatal);
+    object_property_set_link(OBJECT(&s->nrf51), "memory",
+                             OBJECT(system_memory), &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(&s->nrf51), &error_fatal);
 
     /*
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index a4fd5ddede..28d9e8bfac 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -265,8 +265,8 @@ static MemoryRegion *make_mpc(MPS2TZMachineState *mms, void *opaque,
     memory_region_init_ram(ssram, NULL, name, ramsize[i], &error_fatal);
 
     object_initialize_child(OBJECT(mms), mpcname, mpc, TYPE_TZ_MPC);
-    object_property_set_link(OBJECT(mpc), OBJECT(ssram),
-                             "downstream", &error_fatal);
+    object_property_set_link(OBJECT(mpc), "downstream", OBJECT(ssram),
+                             &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(mpc), &error_fatal);
     /* Map the upstream end of the MPC into system memory */
     upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 1);
@@ -308,10 +308,9 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
      */
     object_initialize_child(OBJECT(mms), mscname, msc, TYPE_TZ_MSC);
     msc_downstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(&mms->iotkit), 0);
-    object_property_set_link(OBJECT(msc), OBJECT(msc_downstream),
-                             "downstream", &error_fatal);
-    object_property_set_link(OBJECT(msc), OBJECT(mms),
-                             "idau", &error_fatal);
+    object_property_set_link(OBJECT(msc), "downstream",
+                             OBJECT(msc_downstream), &error_fatal);
+    object_property_set_link(OBJECT(msc), "idau", OBJECT(mms), &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(msc), &error_fatal);
 
     qdev_connect_gpio_out_named(DEVICE(msc), "irq", 0,
@@ -330,8 +329,8 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
     msc_upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(msc), 0);
 
     object_initialize_child(OBJECT(mms), name, dma, TYPE_PL081);
-    object_property_set_link(OBJECT(dma), OBJECT(msc_upstream),
-                             "downstream", &error_fatal);
+    object_property_set_link(OBJECT(dma), "downstream", OBJECT(msc_upstream),
+                             &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(dma), &error_fatal);
 
     s = SYS_BUS_DEVICE(dma);
@@ -404,8 +403,8 @@ static void mps2tz_common_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), TYPE_IOTKIT, &mms->iotkit,
                             mmc->armsse_type);
     iotkitdev = DEVICE(&mms->iotkit);
-    object_property_set_link(OBJECT(&mms->iotkit), OBJECT(system_memory),
-                             "memory", &error_abort);
+    object_property_set_link(OBJECT(&mms->iotkit), "memory",
+                             OBJECT(system_memory), &error_abort);
     qdev_prop_set_uint32(iotkitdev, "EXP_NUMIRQ", MPS2TZ_NUMIRQ);
     qdev_prop_set_uint32(iotkitdev, "MAINCLK", SYSCLK_FRQ);
     sysbus_realize(SYS_BUS_DEVICE(&mms->iotkit), &error_fatal);
@@ -425,7 +424,7 @@ static void mps2tz_common_init(MachineState *machine)
                                                NULL);
             g_free(name);
 
-            object_property_set_int(OBJECT(splitter), 2, "num-lines",
+            object_property_set_int(OBJECT(splitter), "num-lines", 2,
                                     &error_fatal);
             qdev_realize(DEVICE(splitter), NULL, &error_fatal);
             qdev_connect_gpio_out(DEVICE(splitter), 0,
@@ -442,9 +441,9 @@ static void mps2tz_common_init(MachineState *machine)
      */
     object_initialize_child(OBJECT(machine), "sec-resp-splitter",
                             &mms->sec_resp_splitter, TYPE_SPLIT_IRQ);
-    object_property_set_int(OBJECT(&mms->sec_resp_splitter),
+    object_property_set_int(OBJECT(&mms->sec_resp_splitter), "num-lines",
                             ARRAY_SIZE(mms->ppc) + ARRAY_SIZE(mms->msc),
-                            "num-lines", &error_fatal);
+                            &error_fatal);
     qdev_realize(DEVICE(&mms->sec_resp_splitter), NULL, &error_fatal);
     dev_splitter = DEVICE(&mms->sec_resp_splitter);
     qdev_connect_gpio_out_named(iotkitdev, "sec_resp_cfg", 0,
@@ -475,7 +474,7 @@ static void mps2tz_common_init(MachineState *machine)
      */
     object_initialize_child(OBJECT(mms), "uart-irq-orgate",
                             &mms->uart_irq_orgate, TYPE_OR_IRQ);
-    object_property_set_int(OBJECT(&mms->uart_irq_orgate), 10, "num-lines",
+    object_property_set_int(OBJECT(&mms->uart_irq_orgate), "num-lines", 10,
                             &error_fatal);
     qdev_realize(DEVICE(&mms->uart_irq_orgate), NULL, &error_fatal);
     qdev_connect_gpio_out(DEVICE(&mms->uart_irq_orgate), 0,
@@ -568,8 +567,8 @@ static void mps2tz_common_init(MachineState *machine)
 
             mr = pinfo->devfn(mms, pinfo->opaque, pinfo->name, pinfo->size);
             portname = g_strdup_printf("port[%d]", port);
-            object_property_set_link(OBJECT(ppc), OBJECT(mr),
-                                     portname, &error_fatal);
+            object_property_set_link(OBJECT(ppc), portname, OBJECT(mr),
+                                     &error_fatal);
             g_free(portname);
         }
 
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index d1653a7e6e..9f12934ca8 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -203,8 +203,8 @@ static void mps2_common_init(MachineState *machine)
     }
     qdev_prop_set_string(armv7m, "cpu-type", machine->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
-    object_property_set_link(OBJECT(&mms->armv7m), OBJECT(system_memory),
-                             "memory", &error_abort);
+    object_property_set_link(OBJECT(&mms->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&mms->armv7m), &error_fatal);
 
     create_unimplemented_device("zbtsmram mirror", 0x00400000, 0x00400000);
@@ -237,7 +237,7 @@ static void mps2_common_init(MachineState *machine)
         DeviceState *orgate_dev;
 
         orgate = object_new(TYPE_OR_IRQ);
-        object_property_set_int(orgate, 6, "num-lines", &error_fatal);
+        object_property_set_int(orgate, "num-lines", 6, &error_fatal);
         qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
@@ -273,7 +273,7 @@ static void mps2_common_init(MachineState *machine)
         DeviceState *orgate_dev;
 
         orgate = object_new(TYPE_OR_IRQ);
-        object_property_set_int(orgate, 10, "num-lines", &error_fatal);
+        object_property_set_int(orgate, "num-lines", 10, &error_fatal);
         qdev_realize(DEVICE(orgate), NULL, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
@@ -288,7 +288,7 @@ static void mps2_common_init(MachineState *machine)
             DeviceState *txrx_orgate_dev;
 
             txrx_orgate = object_new(TYPE_OR_IRQ);
-            object_property_set_int(txrx_orgate, 2, "num-lines", &error_fatal);
+            object_property_set_int(txrx_orgate, "num-lines", 2, &error_fatal);
             qdev_realize(DEVICE(txrx_orgate), NULL, &error_fatal);
             txrx_orgate_dev = DEVICE(txrx_orgate);
             qdev_connect_gpio_out(txrx_orgate_dev, 0,
@@ -356,7 +356,7 @@ static void mps2_common_init(MachineState *machine)
         int j;
 
         orgate = object_new(TYPE_OR_IRQ);
-        object_property_set_int(orgate, 2, "num-lines", &error_fatal);
+        object_property_set_int(orgate, "num-lines", 2, &error_fatal);
         orgate_dev = DEVICE(orgate);
         qdev_realize(orgate_dev, NULL, &error_fatal);
         qdev_connect_gpio_out(orgate_dev, 0,
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 476112b2d9..e6e4bb3153 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -123,8 +123,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_uint32(armv7m, "num-irq", 81);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
-    object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
         error_propagate(errp, err);
         return;
@@ -193,8 +193,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     dev = DEVICE(&s->emac);
-    object_property_set_link(OBJECT(&s->emac), OBJECT(get_system_memory()),
-                             "ahb-bus", &error_abort);
+    object_property_set_link(OBJECT(&s->emac), "ahb-bus",
+                             OBJECT(get_system_memory()), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), &err)) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 34376328fc..4bc737f93b 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -256,8 +256,8 @@ static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
     }
 
     object_initialize_child(OBJECT(mms), mpcname, mpc, TYPE_TZ_MPC);
-    object_property_set_link(OBJECT(mpc), OBJECT(downstream),
-                             "downstream", &error_fatal);
+    object_property_set_link(OBJECT(mpc), "downstream", OBJECT(downstream),
+                             &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(mpc), &error_fatal);
     /* Map the upstream end of the MPC into system memory */
     upstream = sysbus_mmio_get_region(SYS_BUS_DEVICE(mpc), 1);
@@ -374,8 +374,8 @@ static void musca_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "sse-200", &mms->sse,
                             TYPE_SSE200);
     ssedev = DEVICE(&mms->sse);
-    object_property_set_link(OBJECT(&mms->sse), OBJECT(system_memory),
-                             "memory", &error_fatal);
+    object_property_set_link(OBJECT(&mms->sse), "memory",
+                             OBJECT(system_memory), &error_fatal);
     qdev_prop_set_uint32(ssedev, "EXP_NUMIRQ", mmc->num_irqs);
     qdev_prop_set_uint32(ssedev, "init-svtor", mmc->init_svtor);
     qdev_prop_set_uint32(ssedev, "SRAM_ADDR_WIDTH", mmc->sram_addr_width);
@@ -403,7 +403,7 @@ static void musca_init(MachineState *machine)
                                            &error_fatal, NULL);
         g_free(name);
 
-        object_property_set_int(OBJECT(splitter), 2, "num-lines",
+        object_property_set_int(OBJECT(splitter), "num-lines", 2,
                                 &error_fatal);
         qdev_realize(DEVICE(splitter), NULL, &error_fatal);
         qdev_connect_gpio_out(DEVICE(splitter), 0,
@@ -422,8 +422,8 @@ static void musca_init(MachineState *machine)
                                        sizeof(mms->sec_resp_splitter),
                                        TYPE_SPLIT_IRQ, &error_fatal, NULL);
 
-    object_property_set_int(OBJECT(&mms->sec_resp_splitter),
-                            ARRAY_SIZE(mms->ppc), "num-lines", &error_fatal);
+    object_property_set_int(OBJECT(&mms->sec_resp_splitter), "num-lines",
+                            ARRAY_SIZE(mms->ppc), &error_fatal);
     qdev_realize(DEVICE(&mms->sec_resp_splitter), NULL, &error_fatal);
     dev_splitter = DEVICE(&mms->sec_resp_splitter);
     qdev_connect_gpio_out_named(ssedev, "sec_resp_cfg", 0,
@@ -541,8 +541,8 @@ static void musca_init(MachineState *machine)
 
             mr = pinfo->devfn(mms, pinfo->opaque, pinfo->name, pinfo->size);
             portname = g_strdup_printf("port[%d]", port);
-            object_property_set_link(OBJECT(ppc), OBJECT(mr),
-                                     portname, &error_fatal);
+            object_property_set_link(OBJECT(ppc), portname, OBJECT(mr),
+                                     &error_fatal);
             g_free(portname);
         }
 
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 394a3345bd..ff9a7c8cc6 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1690,8 +1690,8 @@ static void musicpal_init(MachineState *machine)
     wm8750_dev = i2c_create_slave(i2c, TYPE_WM8750, MP_WM_ADDR);
     dev = qdev_new(TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
-    object_property_set_link(OBJECT(dev), OBJECT(wm8750_dev),
-                             "wm8750", NULL);
+    object_property_set_link(OBJECT(dev), "wm8750", OBJECT(wm8750_dev),
+                             NULL);
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_mmio_map(s, 0, MP_AUDIO_BASE);
     sysbus_connect_irq(s, 0, pic[MP_AUDIO_IRQ]);
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index e9c77e4c21..c440cd11e9 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -65,7 +65,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    object_property_set_link(OBJECT(&s->cpu), OBJECT(&s->container), "memory",
+    object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), &err)) {
         error_propagate(errp, err);
@@ -106,7 +106,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
                        BASE_TO_IRQ(NRF51_RNG_BASE)));
 
     /* UICR, FICR, NVMC, FLASH */
-    object_property_set_uint(OBJECT(&s->nvm), s->flash_size, "flash-size",
+    object_property_set_uint(OBJECT(&s->nvm), "flash-size", s->flash_size,
                              &err);
     if (err) {
         error_propagate(errp, err);
@@ -141,7 +141,7 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     /* TIMER */
     for (i = 0; i < NRF51_NUM_TIMERS; i++) {
-        object_property_set_uint(OBJECT(&s->timer[i]), i, "id", &err);
+        object_property_set_uint(OBJECT(&s->timer[i]), "id", i, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 843dcbbd62..1679468232 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -63,9 +63,8 @@ static void orangepi_init(MachineState *machine)
     object_unref(OBJECT(h3));
 
     /* Setup timer properties */
-    object_property_set_int(OBJECT(h3), 32768, "clk0-freq",
-                            &error_abort);
-    object_property_set_int(OBJECT(h3), 24 * 1000 * 1000, "clk1-freq",
+    object_property_set_int(OBJECT(h3), "clk0-freq", 32768, &error_abort);
+    object_property_set_int(OBJECT(h3), "clk1-freq", 24 * 1000 * 1000,
                             &error_abort);
 
     /* Setup SID properties. Currently using a default fixed SID identifier. */
@@ -77,12 +76,12 @@ static void orangepi_init(MachineState *machine)
     }
 
     /* Setup EMAC properties */
-    object_property_set_int(OBJECT(&h3->emac), 1, "phy-addr", &error_abort);
+    object_property_set_int(OBJECT(&h3->emac), "phy-addr", 1, &error_abort);
 
     /* DRAMC */
-    object_property_set_uint(OBJECT(h3), h3->memmap[AW_H3_SDRAM],
-                             "ram-addr", &error_abort);
-    object_property_set_int(OBJECT(h3), machine->ram_size / MiB, "ram-size",
+    object_property_set_uint(OBJECT(h3), "ram-addr", h3->memmap[AW_H3_SDRAM],
+                             &error_abort);
+    object_property_set_int(OBJECT(h3), "ram-size", machine->ram_size / MiB,
                             &error_abort);
 
     /* Mark H3 object realized */
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 09bf02ec9c..b2d6c9688f 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -285,7 +285,7 @@ static void raspi_machine_init(MachineState *machine)
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             board_soc_type(board_rev));
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine->ram));
-    object_property_set_int(OBJECT(&s->soc), board_rev, "board-rev",
+    object_property_set_int(OBJECT(&s->soc), "board-rev", board_rev,
                             &error_abort);
     qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index b6c0a1adb9..22e132058e 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -107,11 +107,11 @@ static void realview_init(MachineState *machine,
          * before realization.
          */
         if (object_property_find(cpuobj, "has_el3", NULL)) {
-            object_property_set_bool(cpuobj, false, "has_el3", &error_fatal);
+            object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
         }
 
         if (is_pb && is_mpcore) {
-            object_property_set_int(cpuobj, periphbase, "reset-cbar",
+            object_property_set_int(cpuobj, "reset-cbar", periphbase,
                                     &error_fatal);
         }
 
@@ -205,7 +205,7 @@ static void realview_init(MachineState *machine,
 
     /* DMA controller is optional, apparently.  */
     dev = qdev_new("pl081");
-    object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
+    object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
                              &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e40c868a82..f030a416fd 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -499,7 +499,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
 
     dev = qdev_new("arm-smmuv3");
 
-    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
+    object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
@@ -659,8 +659,8 @@ static void sbsa_ref_init(MachineState *machine)
         }
 
         cpuobj = object_new(possible_cpus->cpus[n].type);
-        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
-                                "mp-affinity", NULL);
+        object_property_set_int(cpuobj, "mp-affinity",
+                                possible_cpus->cpus[n].arch_id, NULL);
 
         cs = CPU(cpuobj);
         cs->cpu_index = n;
@@ -669,16 +669,16 @@ static void sbsa_ref_init(MachineState *machine)
                           &error_fatal);
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj,
+            object_property_set_int(cpuobj, "reset-cbar",
                                     sbsa_ref_memmap[SBSA_CPUPERIPHS].base,
-                                    "reset-cbar", &error_abort);
+                                    &error_abort);
         }
 
-        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
+        object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
                                  &error_abort);
 
-        object_property_set_link(cpuobj, OBJECT(secure_sysmem),
-                                 "secure-memory", &error_abort);
+        object_property_set_link(cpuobj, "secure-memory",
+                                 OBJECT(secure_sysmem), &error_abort);
 
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
         object_unref(cpuobj);
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 97ef566c12..7156fb3ece 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1312,8 +1312,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     qdev_prop_set_uint32(nvic, "num-irq", NUM_IRQ_LINES);
     qdev_prop_set_string(nvic, "cpu-type", ms->cpu_type);
     qdev_prop_set_bit(nvic, "enable-bitband", true);
-    object_property_set_link(OBJECT(nvic), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
+    object_property_set_link(OBJECT(nvic), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
     /* This will exit with an error if the user passed us a bad cpu_type */
     sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
 
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index 46b5332470..9acf401fbf 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -105,8 +105,8 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
-    object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
-                                     "memory", &error_abort);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(get_system_memory()), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
         error_propagate(errp, err);
         return;
@@ -149,8 +149,8 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
 
     /* ADC 1 to 3 */
-    object_property_set_int(OBJECT(s->adc_irqs), STM_NUM_ADCS,
-                            "num-lines", &error_abort);
+    object_property_set_int(OBJECT(s->adc_irqs), "num-lines", STM_NUM_ADCS,
+                            &error_abort);
     if (!qdev_realize(DEVICE(s->adc_irqs), NULL, &err)) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/stm32f405_soc.c b/hw/arm/stm32f405_soc.c
index f1f0dc40b1..07ce323a64 100644
--- a/hw/arm/stm32f405_soc.c
+++ b/hw/arm/stm32f405_soc.c
@@ -116,8 +116,8 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
-    object_property_set_link(OBJECT(&s->armv7m), OBJECT(system_memory),
-                                     "memory", &error_abort);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), &err)) {
         error_propagate(errp, err);
         return;
@@ -167,8 +167,8 @@ static void stm32f405_soc_realize(DeviceState *dev_soc, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_int(OBJECT(&s->adc_irqs), STM_NUM_ADCS,
-                            "num-lines", &error_abort);
+    object_property_set_int(OBJECT(&s->adc_irqs), "num-lines", STM_NUM_ADCS,
+                            &error_abort);
     if (!qdev_realize(DEVICE(&s->adc_irqs), NULL, &err)) {
         error_propagate(errp, err);
         return;
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index e596b8170f..d09ea24ae2 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -213,7 +213,7 @@ static void versatile_init(MachineState *machine, int board_id)
      * realization.
      */
     if (object_property_find(cpuobj, "has_el3", NULL)) {
-        object_property_set_bool(cpuobj, false, "has_el3", &error_fatal);
+        object_property_set_bool(cpuobj, "has_el3", false, &error_fatal);
     }
 
     qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
@@ -288,7 +288,7 @@ static void versatile_init(MachineState *machine, int board_id)
     pl011_create(0x10009000, sic[6], serial_hd(3));
 
     dev = qdev_new("pl080");
-    object_property_set_link(OBJECT(dev), OBJECT(sysmem), "downstream",
+    object_property_set_link(OBJECT(dev), "downstream", OBJECT(sysmem),
                              &error_fatal);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 5bf9cff8a8..762b068e90 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -218,17 +218,17 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
         Object *cpuobj = object_new(cpu_type);
 
         if (!secure) {
-            object_property_set_bool(cpuobj, false, "has_el3", NULL);
+            object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
         if (!virt) {
             if (object_property_find(cpuobj, "has_el2", NULL)) {
-                object_property_set_bool(cpuobj, false, "has_el2", NULL);
+                object_property_set_bool(cpuobj, "has_el2", false, NULL);
             }
         }
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, periphbase,
-                                    "reset-cbar", &error_abort);
+            object_property_set_int(cpuobj, "reset-cbar", periphbase,
+                                    &error_abort);
         }
         qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
     }
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7d9f7157da..9005dae356 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -594,7 +594,7 @@ static void create_its(VirtMachineState *vms)
 
     dev = qdev_new(itsclass);
 
-    object_property_set_link(OBJECT(dev), OBJECT(vms->gic), "parent-gicv3",
+    object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_GIC_ITS].base);
@@ -1175,7 +1175,7 @@ static void create_smmu(const VirtMachineState *vms,
 
     dev = qdev_new("arm-smmuv3");
 
-    object_property_set_link(OBJECT(dev), OBJECT(bus), "primary-bus",
+    object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
@@ -1785,8 +1785,8 @@ static void machvirt_init(MachineState *machine)
         }
 
         cpuobj = object_new(possible_cpus->cpus[n].type);
-        object_property_set_int(cpuobj, possible_cpus->cpus[n].arch_id,
-                                "mp-affinity", NULL);
+        object_property_set_int(cpuobj, "mp-affinity",
+                                possible_cpus->cpus[n].arch_id, NULL);
 
         cs = CPU(cpuobj);
         cs->cpu_index = n;
@@ -1797,43 +1797,44 @@ static void machvirt_init(MachineState *machine)
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
 
         if (!vms->secure) {
-            object_property_set_bool(cpuobj, false, "has_el3", NULL);
+            object_property_set_bool(cpuobj, "has_el3", false, NULL);
         }
 
         if (!vms->virt && object_property_find(cpuobj, "has_el2", NULL)) {
-            object_property_set_bool(cpuobj, false, "has_el2", NULL);
+            object_property_set_bool(cpuobj, "has_el2", false, NULL);
         }
 
         if (vms->psci_conduit != QEMU_PSCI_CONDUIT_DISABLED) {
-            object_property_set_int(cpuobj, vms->psci_conduit,
-                                    "psci-conduit", NULL);
+            object_property_set_int(cpuobj, "psci-conduit", vms->psci_conduit,
+                                    NULL);
 
             /* Secondary CPUs start in PSCI powered-down state */
             if (n > 0) {
-                object_property_set_bool(cpuobj, true,
-                                         "start-powered-off", NULL);
+                object_property_set_bool(cpuobj, "start-powered-off", true,
+                                         NULL);
             }
         }
 
         if (vmc->kvm_no_adjvtime &&
             object_property_find(cpuobj, "kvm-no-adjvtime", NULL)) {
-            object_property_set_bool(cpuobj, true, "kvm-no-adjvtime", NULL);
+            object_property_set_bool(cpuobj, "kvm-no-adjvtime", true, NULL);
         }
 
         if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
-            object_property_set_bool(cpuobj, false, "pmu", NULL);
+            object_property_set_bool(cpuobj, "pmu", false, NULL);
         }
 
         if (object_property_find(cpuobj, "reset-cbar", NULL)) {
-            object_property_set_int(cpuobj, vms->memmap[VIRT_CPUPERIPHS].base,
-                                    "reset-cbar", &error_abort);
+            object_property_set_int(cpuobj, "reset-cbar",
+                                    vms->memmap[VIRT_CPUPERIPHS].base,
+                                    &error_abort);
         }
 
-        object_property_set_link(cpuobj, OBJECT(sysmem), "memory",
+        object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
                                  &error_abort);
         if (vms->secure) {
-            object_property_set_link(cpuobj, OBJECT(secure_sysmem),
-                                     "secure-memory", &error_abort);
+            object_property_set_link(cpuobj, "secure-memory",
+                                     OBJECT(secure_sysmem), &error_abort);
         }
 
         /*
@@ -1857,11 +1858,12 @@ static void machvirt_init(MachineState *machine)
                 }
             }
 
-            object_property_set_link(cpuobj, OBJECT(tag_sysmem),
-                                     "tag-memory", &error_abort);
+            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
+                                     &error_abort);
             if (vms->secure) {
-                object_property_set_link(cpuobj, OBJECT(secure_tag_sysmem),
-                                         "secure-tag-memory", &error_abort);
+                object_property_set_link(cpuobj, "secure-tag-memory",
+                                         OBJECT(secure_tag_sysmem),
+                                         &error_abort);
             }
         }
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index ed970273f3..32aa7323d9 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -196,12 +196,12 @@ static void zynq_init(MachineState *machine)
      * realization.
      */
     if (object_property_find(OBJECT(cpu), "has_el3", NULL)) {
-        object_property_set_bool(OBJECT(cpu), false, "has_el3", &error_fatal);
+        object_property_set_bool(OBJECT(cpu), "has_el3", false, &error_fatal);
     }
 
-    object_property_set_int(OBJECT(cpu), ZYNQ_BOARD_MIDR, "midr",
+    object_property_set_int(OBJECT(cpu), "midr", ZYNQ_BOARD_MIDR,
                             &error_fatal);
-    object_property_set_int(OBJECT(cpu), MPCORE_PERIPHBASE, "reset-cbar",
+    object_property_set_int(OBJECT(cpu), "reset-cbar", MPCORE_PERIPHBASE,
                             &error_fatal);
     qdev_realize(DEVICE(cpu), NULL, &error_fatal);
 
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index a3b1ce9c7c..4b3152ee77 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -502,10 +502,10 @@ static void versal_virt_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "xlnx-versal", &s->soc,
                             TYPE_XLNX_VERSAL);
-    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
-                             "ddr", &error_abort);
-    object_property_set_int(OBJECT(&s->soc), psci_conduit,
-                            "psci-conduit", &error_abort);
+    object_property_set_link(OBJECT(&s->soc), "ddr", OBJECT(machine->ram),
+                             &error_abort);
+    object_property_set_int(OBJECT(&s->soc), "psci-conduit", psci_conduit,
+                            &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     fdt_create(s);
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index fed9d07ca2..ead038b971 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -35,17 +35,17 @@ static void versal_create_apu_cpus(Versal *s)
         object_initialize_child(OBJECT(s), "apu-cpu[*]", &s->fpd.apu.cpu[i],
                                 XLNX_VERSAL_ACPU_TYPE);
         obj = OBJECT(&s->fpd.apu.cpu[i]);
-        object_property_set_int(obj, s->cfg.psci_conduit,
-                                "psci-conduit", &error_abort);
+        object_property_set_int(obj, "psci-conduit", s->cfg.psci_conduit,
+                                &error_abort);
         if (i) {
             /* Secondary CPUs start in PSCI powered-down state */
-            object_property_set_bool(obj, true,
-                                     "start-powered-off", &error_abort);
+            object_property_set_bool(obj, "start-powered-off", true,
+                                     &error_abort);
         }
 
-        object_property_set_int(obj, ARRAY_SIZE(s->fpd.apu.cpu),
-                                "core-count", &error_abort);
-        object_property_set_link(obj, OBJECT(&s->fpd.apu.mr), "memory",
+        object_property_set_int(obj, "core-count", ARRAY_SIZE(s->fpd.apu.cpu),
+                                &error_abort);
+        object_property_set_link(obj, "memory", OBJECT(&s->fpd.apu.mr),
                                  &error_abort);
         qdev_realize(DEVICE(obj), NULL, &error_fatal);
     }
@@ -164,11 +164,9 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
             qemu_check_nic_model(nd, "cadence_gem");
             qdev_set_nic_properties(dev, nd);
         }
-        object_property_set_int(OBJECT(dev),
-                                2, "num-priority-queues",
+        object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
                                 &error_abort);
-        object_property_set_link(OBJECT(dev),
-                                 OBJECT(&s->mr_ps), "dma",
+        object_property_set_link(OBJECT(dev), "dma", OBJECT(&s->mr_ps),
                                  &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -192,7 +190,7 @@ static void versal_create_admas(Versal *s, qemu_irq *pic)
         object_initialize_child(OBJECT(s), name, &s->lpd.iou.adma[i],
                                 TYPE_XLNX_ZDMA);
         dev = DEVICE(&s->lpd.iou.adma[i]);
-        object_property_set_int(OBJECT(dev), 128, "bus-width", &error_abort);
+        object_property_set_int(OBJECT(dev), "bus-width", 128, &error_abort);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
@@ -217,11 +215,11 @@ static void versal_create_sds(Versal *s, qemu_irq *pic)
                                 TYPE_SYSBUS_SDHCI);
         dev = DEVICE(&s->pmc.iou.sd[i]);
 
-        object_property_set_uint(OBJECT(dev),
-                                 3, "sd-spec-version", &error_fatal);
-        object_property_set_uint(OBJECT(dev), SDHCI_CAPABILITIES, "capareg",
+        object_property_set_uint(OBJECT(dev), "sd-spec-version", 3,
                                  &error_fatal);
-        object_property_set_uint(OBJECT(dev), UHS_I, "uhs", &error_fatal);
+        object_property_set_uint(OBJECT(dev), "capareg", SDHCI_CAPABILITIES,
+                                 &error_fatal);
+        object_property_set_uint(OBJECT(dev), "uhs", UHS_I, &error_fatal);
         sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
 
         mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 77449759c6..5997262459 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -118,11 +118,11 @@ static void xlnx_zcu102_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_XLNX_ZYNQMP);
 
-    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
-                         "ddr-ram", &error_abort);
-    object_property_set_bool(OBJECT(&s->soc), s->secure, "secure",
+    object_property_set_link(OBJECT(&s->soc), "ddr-ram", OBJECT(machine->ram),
+                             &error_abort);
+    object_property_set_bool(OBJECT(&s->soc), "secure", s->secure,
                              &error_fatal);
-    object_property_set_bool(OBJECT(&s->soc), s->virt, "virtualization",
+    object_property_set_bool(OBJECT(&s->soc), "virtualization", s->virt,
                              &error_fatal);
 
     qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d703158f8b..e7fe85f1d8 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -200,14 +200,14 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
         name = object_get_canonical_path_component(OBJECT(&s->rpu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
             /* Secondary CPUs start in PSCI powered-down state */
-            object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true,
-                                     "start-powered-off", &error_abort);
+            object_property_set_bool(OBJECT(&s->rpu_cpu[i]),
+                                     "start-powered-off", true, &error_abort);
         } else {
             s->boot_cpu_ptr = &s->rpu_cpu[i];
         }
         g_free(name);
 
-        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), true, "reset-hivecs",
+        object_property_set_bool(OBJECT(&s->rpu_cpu[i]), "reset-hivecs", true,
                                  &error_abort);
         if (!qdev_realize(DEVICE(&s->rpu_cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
@@ -345,27 +345,27 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_apus; i++) {
         char *name;
 
-        object_property_set_int(OBJECT(&s->apu_cpu[i]), QEMU_PSCI_CONDUIT_SMC,
-                                "psci-conduit", &error_abort);
+        object_property_set_int(OBJECT(&s->apu_cpu[i]), "psci-conduit",
+                                QEMU_PSCI_CONDUIT_SMC, &error_abort);
 
         name = object_get_canonical_path_component(OBJECT(&s->apu_cpu[i]));
         if (strcmp(name, boot_cpu)) {
             /* Secondary CPUs start in PSCI powered-down state */
-            object_property_set_bool(OBJECT(&s->apu_cpu[i]), true,
-                                     "start-powered-off", &error_abort);
+            object_property_set_bool(OBJECT(&s->apu_cpu[i]),
+                                     "start-powered-off", true, &error_abort);
         } else {
             s->boot_cpu_ptr = &s->apu_cpu[i];
         }
         g_free(name);
 
-        object_property_set_bool(OBJECT(&s->apu_cpu[i]),
-                                 s->secure, "has_el3", NULL);
-        object_property_set_bool(OBJECT(&s->apu_cpu[i]),
-                                 s->virt, "has_el2", NULL);
-        object_property_set_int(OBJECT(&s->apu_cpu[i]), GIC_BASE_ADDR,
-                                "reset-cbar", &error_abort);
-        object_property_set_int(OBJECT(&s->apu_cpu[i]), num_apus,
-                                "core-count", &error_abort);
+        object_property_set_bool(OBJECT(&s->apu_cpu[i]), "has_el3", s->secure,
+                                 NULL);
+        object_property_set_bool(OBJECT(&s->apu_cpu[i]), "has_el2", s->virt,
+                                 NULL);
+        object_property_set_int(OBJECT(&s->apu_cpu[i]), "reset-cbar",
+                                GIC_BASE_ADDR, &error_abort);
+        object_property_set_int(OBJECT(&s->apu_cpu[i]), "core-count",
+                                num_apus, &error_abort);
         if (!qdev_realize(DEVICE(&s->apu_cpu[i]), NULL, &err)) {
             error_propagate(errp, err);
             return;
@@ -463,9 +463,9 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
             qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
             qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
         }
-        object_property_set_int(OBJECT(&s->gem[i]), GEM_REVISION, "revision",
+        object_property_set_int(OBJECT(&s->gem[i]), "revision", GEM_REVISION,
                                 &error_abort);
-        object_property_set_int(OBJECT(&s->gem[i]), 2, "num-priority-queues",
+        object_property_set_int(OBJECT(&s->gem[i]), "num-priority-queues", 2,
                                 &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem[i]), &err)) {
             error_propagate(errp, err);
@@ -487,7 +487,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
                            gic_spi[uart_intr[i]]);
     }
 
-    object_property_set_int(OBJECT(&s->sata), SATA_NUM_PORTS, "num-ports",
+    object_property_set_int(OBJECT(&s->sata), "num-ports", SATA_NUM_PORTS,
                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sata), &err)) {
         error_propagate(errp, err);
@@ -507,17 +507,17 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
          * - SDIO Specification Version 3.0
          * - eMMC Specification Version 4.51
          */
-        object_property_set_uint(sdhci, 3, "sd-spec-version", &err);
+        object_property_set_uint(sdhci, "sd-spec-version", 3, &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
-        object_property_set_uint(sdhci, SDHCI_CAPABILITIES, "capareg", &err);
+        object_property_set_uint(sdhci, "capareg", SDHCI_CAPABILITIES, &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
-        object_property_set_uint(sdhci, UHS_I, "uhs", &err);
+        object_property_set_uint(sdhci, "uhs", UHS_I, &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -586,7 +586,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
-    object_property_set_link(OBJECT(&s->dp), OBJECT(&s->dpdma), "dpdma",
+    object_property_set_link(OBJECT(&s->dp), "dpdma", OBJECT(&s->dpdma),
                              &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dpdma), 0, DPDMA_ADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->dpdma), 0, gic_spi[DPDMA_IRQ]);
@@ -606,7 +606,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->rtc), 0, gic_spi[RTC_IRQ]);
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GDMA_CH; i++) {
-        object_property_set_uint(OBJECT(&s->gdma[i]), 128, "bus-width", &err);
+        object_property_set_uint(OBJECT(&s->gdma[i]), "bus-width", 128, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 48890536a4..0e6e6df5fa 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -935,21 +935,20 @@ static void xen_block_device_create(XenBackendInstance *backend,
     xendev = XEN_DEVICE(qdev_new(type));
     blockdev = XEN_BLOCK_DEVICE(xendev);
 
-    object_property_set_str(OBJECT(xendev), vdev, "vdev", &local_err);
+    object_property_set_str(OBJECT(xendev), "vdev", vdev, &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err, "failed to set 'vdev': ");
         goto fail;
     }
 
-    object_property_set_str(OBJECT(xendev),
-                            xen_block_drive_get_node_name(drive), "drive",
-                            &local_err);
+    object_property_set_str(OBJECT(xendev), "drive",
+                            xen_block_drive_get_node_name(drive), &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err, "failed to set 'drive': ");
         goto fail;
     }
 
-    object_property_set_str(OBJECT(xendev), iothread->id, "iothread",
+    object_property_set_str(OBJECT(xendev), "iothread", iothread->id,
                             &local_err);
     if (local_err) {
         error_propagate_prepend(errp, local_err,
diff --git a/hw/core/bus.c b/hw/core/bus.c
index 544dd8a6fa..00d1d31762 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -25,8 +25,8 @@
 
 void qbus_set_hotplug_handler(BusState *bus, Object *handler)
 {
-    object_property_set_link(OBJECT(bus), handler,
-                             QDEV_HOTPLUG_HANDLER_PROPERTY, &error_abort);
+    object_property_set_link(OBJECT(bus), QDEV_HOTPLUG_HANDLER_PROPERTY,
+                             handler, &error_abort);
 }
 
 void qbus_set_bus_hotplug_handler(BusState *bus)
@@ -168,14 +168,14 @@ bool qbus_realize(BusState *bus, Error **errp)
 {
     Error *err = NULL;
 
-    object_property_set_bool(OBJECT(bus), true, "realized", &err);
+    object_property_set_bool(OBJECT(bus), "realized", true, &err);
     error_propagate(errp, err);
     return !err;
 }
 
 void qbus_unrealize(BusState *bus)
 {
-    object_property_set_bool(OBJECT(bus), false, "realized", &error_abort);
+    object_property_set_bool(OBJECT(bus), "realized", false, &error_abort);
 }
 
 static bool bus_get_realized(Object *obj, Error **errp)
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 6a20ce7cf1..de9a2f7e32 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -810,8 +810,8 @@ void numa_cpu_pre_plug(const CPUArchId *slot, DeviceState *dev, Error **errp)
         /* due to bug in libvirt, it doesn't pass node-id from props on
          * device_add as expected, so we have to fix it up here */
         if (slot->props.has_node_id) {
-            object_property_set_int(OBJECT(dev), slot->props.node_id,
-                                    "node-id", errp);
+            object_property_set_int(OBJECT(dev), "node-id",
+                                    slot->props.node_id, errp);
         }
     } else if (node_id != slot->props.node_id) {
         error_setg(errp, "invalid node-id, must be %"PRId64,
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 383a54578f..810831b1df 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -436,7 +436,7 @@ void qdev_prop_set_drive_err(DeviceState *dev, const char *name,
         }
     }
 
-    object_property_set_str(OBJECT(dev), ref, name, errp);
+    object_property_set_str(OBJECT(dev), name, ref, errp);
 }
 
 void qdev_prop_set_drive(DeviceState *dev, const char *name,
@@ -449,16 +449,16 @@ void qdev_prop_set_chr(DeviceState *dev, const char *name,
                        Chardev *value)
 {
     assert(!value || value->label);
-    object_property_set_str(OBJECT(dev),
-                            value ? value->label : "", name, &error_abort);
+    object_property_set_str(OBJECT(dev), name, value ? value->label : "",
+                            &error_abort);
 }
 
 void qdev_prop_set_netdev(DeviceState *dev, const char *name,
                           NetClientState *value)
 {
     assert(!value || value->name);
-    object_property_set_str(OBJECT(dev),
-                            value ? value->name : "", name, &error_abort);
+    object_property_set_str(OBJECT(dev), name, value ? value->name : "",
+                            &error_abort);
 }
 
 void qdev_set_nic_properties(DeviceState *dev, NICInfo *nd)
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 4c7a8a05a5..be8d4eb9f6 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1256,37 +1256,37 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, DeviceState *dev,
 
 void qdev_prop_set_bit(DeviceState *dev, const char *name, bool value)
 {
-    object_property_set_bool(OBJECT(dev), value, name, &error_abort);
+    object_property_set_bool(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_uint8(DeviceState *dev, const char *name, uint8_t value)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_int(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_uint16(DeviceState *dev, const char *name, uint16_t value)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_int(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_uint32(DeviceState *dev, const char *name, uint32_t value)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_int(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_int32(DeviceState *dev, const char *name, int32_t value)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_int(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_uint64(DeviceState *dev, const char *name, uint64_t value)
 {
-    object_property_set_int(OBJECT(dev), value, name, &error_abort);
+    object_property_set_int(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_string(DeviceState *dev, const char *name, const char *value)
 {
-    object_property_set_str(OBJECT(dev), value, name, &error_abort);
+    object_property_set_str(OBJECT(dev), name, value, &error_abort);
 }
 
 void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
@@ -1296,7 +1296,7 @@ void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
     snprintf(str, sizeof(str), "%02x:%02x:%02x:%02x:%02x:%02x",
              value[0], value[1], value[2], value[3], value[4], value[5]);
 
-    object_property_set_str(OBJECT(dev), str, name, &error_abort);
+    object_property_set_str(OBJECT(dev), name, str, &error_abort);
 }
 
 void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
@@ -1304,9 +1304,9 @@ void qdev_prop_set_enum(DeviceState *dev, const char *name, int value)
     Property *prop;
 
     prop = qdev_prop_find(dev, name);
-    object_property_set_str(OBJECT(dev),
+    object_property_set_str(OBJECT(dev), name,
                             qapi_enum_lookup(prop->info->enum_table, value),
-                            name, &error_abort);
+                            &error_abort);
 }
 
 static GPtrArray *global_props(void)
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9de16eae05..56daa7b456 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -398,7 +398,7 @@ bool qdev_realize(DeviceState *dev, BusState *bus, Error **errp)
         assert(!DEVICE_GET_CLASS(dev)->bus_type);
     }
 
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    object_property_set_bool(OBJECT(dev), "realized", true, &err);
     if (err) {
         error_propagate(errp, err);
     }
@@ -426,7 +426,7 @@ bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp)
 
 void qdev_unrealize(DeviceState *dev)
 {
-    object_property_set_bool(OBJECT(dev), false, "realized", &error_abort);
+    object_property_set_bool(OBJECT(dev), "realized", false, &error_abort);
 }
 
 static int qdev_assert_realized_properly(Object *obj, void *opaque)
@@ -567,7 +567,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
                                                 "/unattached"),
                                   "non-qdev-gpio[*]", OBJECT(pin));
     }
-    object_property_set_link(OBJECT(dev), OBJECT(pin), propname, &error_abort);
+    object_property_set_link(OBJECT(dev), propname, OBJECT(pin), &error_abort);
     g_free(propname);
 }
 
@@ -593,7 +593,7 @@ static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
     qemu_irq ret = (qemu_irq)object_property_get_link(OBJECT(dev), propname,
                                                       NULL);
     if (ret) {
-        object_property_set_link(OBJECT(dev), NULL, propname, NULL);
+        object_property_set_link(OBJECT(dev), propname, NULL, NULL);
     }
     g_free(propname);
     return ret;
diff --git a/hw/display/virtio-gpu-pci.c b/hw/display/virtio-gpu-pci.c
index 357fefa3c0..d5b7d39bc4 100644
--- a/hw/display/virtio-gpu-pci.c
+++ b/hw/display/virtio-gpu-pci.c
@@ -40,9 +40,8 @@ static void virtio_gpu_pci_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 
     for (i = 0; i < g->conf.max_outputs; i++) {
-        object_property_set_link(OBJECT(g->scanout[i].con),
-                                 OBJECT(vpci_dev),
-                                 "device", &error_abort);
+        object_property_set_link(OBJECT(g->scanout[i].con), "device",
+                                 OBJECT(vpci_dev), &error_abort);
     }
 }
 
diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
index 0fc00fee1f..d5cebf686f 100644
--- a/hw/display/virtio-vga.c
+++ b/hw/display/virtio-vga.c
@@ -151,9 +151,8 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     graphic_console_set_hwops(vga->con, &virtio_vga_base_ops, vvga);
 
     for (i = 0; i < g->conf.max_outputs; i++) {
-        object_property_set_link(OBJECT(g->scanout[i].con),
-                                 OBJECT(vpci_dev),
-                                 "device", &error_abort);
+        object_property_set_link(OBJECT(g->scanout[i].con), "device",
+                                 OBJECT(vpci_dev), &error_abort);
     }
 }
 
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 2d7dbbb92d..9459178866 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -346,7 +346,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
     d = qdev_new(TYPE_LANCE);
     object_property_add_child(OBJECT(dev), "lance", OBJECT(d));
     qdev_set_nic_properties(d, nd);
-    object_property_set_link(OBJECT(d), OBJECT(dev), "dma", &error_abort);
+    object_property_set_link(OBJECT(d), "dma", OBJECT(dev), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(d), &error_fatal);
 }
 
@@ -379,7 +379,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     }
 
     espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
-    object_property_set_link(OBJECT(espdma), iommu, "iommu", &error_abort);
+    object_property_set_link(OBJECT(espdma), "iommu", iommu, &error_abort);
     object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(espdma), &error_fatal);
 
@@ -394,7 +394,7 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
                                 sysbus_mmio_get_region(sbd, 0));
 
     ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
-    object_property_set_link(OBJECT(ledma), iommu, "iommu", &error_abort);
+    object_property_set_link(OBJECT(ledma), "iommu", iommu, &error_abort);
     object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(ledma), &error_fatal);
 
diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index a069637bf2..a4812e480a 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -547,8 +547,8 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
                              (Object **)&cs->dma,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(ds), OBJECT(s), "dma", &error_abort);
-    object_property_set_link(OBJECT(cs), OBJECT(s), "dma", &error_abort);
+    object_property_set_link(OBJECT(ds), "dma", OBJECT(s), &error_abort);
+    object_property_set_link(OBJECT(cs), "dma", OBJECT(s), &error_abort);
 
     for (i = 0; i < 2; i++) {
         struct Stream *st = &s->streams[i];
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index cb15261420..3e933b65b9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -640,8 +640,8 @@ void pc_cmos_init(PCMachineState *pcms,
                              (Object **)&x86ms->rtc,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(pcms), OBJECT(s),
-                             "rtc_state", &error_abort);
+    object_property_set_link(OBJECT(pcms), "rtc_state", OBJECT(s),
+                             &error_abort);
 
     set_boot_dev(s, MACHINE(pcms)->boot_order, &error_fatal);
 
@@ -1143,8 +1143,8 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
         vmmouse = NULL;
     }
     if (vmmouse) {
-        object_property_set_link(OBJECT(vmmouse), OBJECT(i8042),
-                                 "i8042", &error_abort);
+        object_property_set_link(OBJECT(vmmouse), "i8042", OBJECT(i8042),
+                                 &error_abort);
         isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
     }
     port92 = isa_create_simple(isa_bus, TYPE_PORT92);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2bb42a8141..ae0dc9247b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -293,8 +293,8 @@ static void pc_init1(MachineState *machine,
                                  (Object **)&pcms->acpi_dev,
                                  object_property_allow_set_link,
                                  OBJ_PROP_LINK_STRONG);
-        object_property_set_link(OBJECT(machine), OBJECT(piix4_pm),
-                                 PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
+        object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                                 OBJECT(piix4_pm), &error_abort);
     }
 
     if (machine->nvdimms_state->is_enabled) {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 33163ed18d..a3e607a544 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -217,18 +217,18 @@ static void pc_q35_init(MachineState *machine)
     q35_host = Q35_HOST_DEVICE(qdev_new(TYPE_Q35_HOST_DEVICE));
 
     object_property_add_child(qdev_get_machine(), "q35", OBJECT(q35_host));
-    object_property_set_link(OBJECT(q35_host), OBJECT(ram_memory),
-                             MCH_HOST_PROP_RAM_MEM, NULL);
-    object_property_set_link(OBJECT(q35_host), OBJECT(pci_memory),
-                             MCH_HOST_PROP_PCI_MEM, NULL);
-    object_property_set_link(OBJECT(q35_host), OBJECT(get_system_memory()),
-                             MCH_HOST_PROP_SYSTEM_MEM, NULL);
-    object_property_set_link(OBJECT(q35_host), OBJECT(system_io),
-                             MCH_HOST_PROP_IO_MEM, NULL);
-    object_property_set_int(OBJECT(q35_host), x86ms->below_4g_mem_size,
-                            PCI_HOST_BELOW_4G_MEM_SIZE, NULL);
-    object_property_set_int(OBJECT(q35_host), x86ms->above_4g_mem_size,
-                            PCI_HOST_ABOVE_4G_MEM_SIZE, NULL);
+    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_RAM_MEM,
+                             OBJECT(ram_memory), NULL);
+    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_PCI_MEM,
+                             OBJECT(pci_memory), NULL);
+    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_SYSTEM_MEM,
+                             OBJECT(get_system_memory()), NULL);
+    object_property_set_link(OBJECT(q35_host), MCH_HOST_PROP_IO_MEM,
+                             OBJECT(system_io), NULL);
+    object_property_set_int(OBJECT(q35_host), PCI_HOST_BELOW_4G_MEM_SIZE,
+                            x86ms->below_4g_mem_size, NULL);
+    object_property_set_int(OBJECT(q35_host), PCI_HOST_ABOVE_4G_MEM_SIZE,
+                            x86ms->above_4g_mem_size, NULL);
     /* pci */
     sysbus_realize_and_unref(SYS_BUS_DEVICE(q35_host), &error_fatal);
     phb = PCI_HOST_BRIDGE(q35_host);
@@ -243,8 +243,8 @@ static void pc_q35_init(MachineState *machine)
                              (Object **)&pcms->acpi_dev,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(machine), OBJECT(lpc),
-                             PC_MACHINE_ACPI_DEVICE_PROP, &error_abort);
+    object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
+                             OBJECT(lpc), &error_abort);
 
     /* irq lines */
     gsi_state = pc_gsi_create(&x86ms->gsi, pcmc->pci_enabled);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 93f7371a56..54760197cf 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -121,7 +121,7 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
     Error *local_err = NULL;
     Object *cpu = object_new(MACHINE(x86ms)->cpu_type);
 
-    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
+    object_property_set_uint(cpu, "apic-id", apic_id, &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/hw/ide/qdev.c b/hw/ide/qdev.c
index ba8b0d7f02..27ff1f7f66 100644
--- a/hw/ide/qdev.c
+++ b/hw/ide/qdev.c
@@ -269,7 +269,7 @@ static void ide_dev_instance_init(Object *obj)
     object_property_add(obj, "bootindex", "int32",
                         ide_dev_get_bootindex,
                         ide_dev_set_bootindex, NULL, NULL);
-    object_property_set_int(obj, -1, "bootindex", NULL);
+    object_property_set_int(obj, "bootindex", -1, NULL);
 }
 
 static void ide_hd_realize(IDEDevice *dev, Error **errp)
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 3b2e87334d..d6780061f4 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1829,18 +1829,17 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
      * resized dynamically when the controller is configured by the FW
      * to limit accesses to resources not provisioned.
      */
-    object_property_set_int(OBJECT(xsrc), PNV_XIVE_NR_IRQS, "nr-irqs",
+    object_property_set_int(OBJECT(xsrc), "nr-irqs", PNV_XIVE_NR_IRQS,
                             &error_fatal);
-    object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
-                             &error_abort);
+    object_property_set_link(OBJECT(xsrc), "xive", OBJECT(xive), &error_abort);
     if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
     }
 
-    object_property_set_int(OBJECT(end_xsrc), PNV_XIVE_NR_ENDS, "nr-ends",
+    object_property_set_int(OBJECT(end_xsrc), "nr-ends", PNV_XIVE_NR_ENDS,
                             &error_fatal);
-    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
+    object_property_set_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
                              &error_abort);
     if (!qdev_realize(DEVICE(end_xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 615abf5462..1f42bf4f43 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -308,10 +308,9 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     /*
      * Initialize the internal sources, for IPIs and virtual devices.
      */
-    object_property_set_int(OBJECT(xsrc), xive->nr_irqs, "nr-irqs",
+    object_property_set_int(OBJECT(xsrc), "nr-irqs", xive->nr_irqs,
                             &error_fatal);
-    object_property_set_link(OBJECT(xsrc), OBJECT(xive), "xive",
-                             &error_abort);
+    object_property_set_link(OBJECT(xsrc), "xive", OBJECT(xive), &error_abort);
     if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
@@ -321,9 +320,9 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
     /*
      * Initialize the END ESB source
      */
-    object_property_set_int(OBJECT(end_xsrc), xive->nr_irqs, "nr-ends",
+    object_property_set_int(OBJECT(end_xsrc), "nr-ends", xive->nr_irqs,
                             &error_fatal);
-    object_property_set_link(OBJECT(end_xsrc), OBJECT(xive), "xive",
+    object_property_set_link(OBJECT(end_xsrc), "xive", OBJECT(xive),
                              &error_abort);
     if (!qdev_realize(DEVICE(end_xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 811b0346e1..c1feb649fb 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -382,8 +382,8 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi, Error **errp)
     obj = object_new(type);
     object_property_add_child(cpu, type, obj);
     object_unref(obj);
-    object_property_set_link(obj, OBJECT(xi), ICP_PROP_XICS, &error_abort);
-    object_property_set_link(obj, cpu, ICP_PROP_CPU, &error_abort);
+    object_property_set_link(obj, ICP_PROP_XICS, OBJECT(xi), &error_abort);
+    object_property_set_link(obj, ICP_PROP_CPU, cpu, &error_abort);
     if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
         object_unparent(obj);
         error_propagate(errp, local_err);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8e167306e7..34591659d3 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -763,8 +763,8 @@ Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)
     obj = object_new(TYPE_XIVE_TCTX);
     object_property_add_child(cpu, TYPE_XIVE_TCTX, obj);
     object_unref(obj);
-    object_property_set_link(obj, cpu, "cpu", &error_abort);
-    object_property_set_link(obj, OBJECT(xptr), "presenter", &error_abort);
+    object_property_set_link(obj, "cpu", cpu, &error_abort);
+    object_property_set_link(obj, "presenter", OBJECT(xptr), &error_abort);
     if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
         goto error;
     }
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 459d326af0..1ca482ad81 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -262,8 +262,8 @@ static void q800_init(MachineState *machine)
     qdev_set_nic_properties(dev, &nd_table[0]);
     qdev_prop_set_uint8(dev, "it_shift", 2);
     qdev_prop_set_bit(dev, "big_endian", true);
-    object_property_set_link(OBJECT(dev), OBJECT(get_system_memory()),
-                             "dma_mr", &error_abort);
+    object_property_set_link(OBJECT(dev), "dma_mr",
+                             OBJECT(get_system_memory()), &error_abort);
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index f2a86ec4ee..8a075fbf72 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -54,7 +54,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
     if (local_err) {
         goto out;
     }
-    object_property_set_int(OBJECT(dimm), slot, PC_DIMM_SLOT_PROP,
+    object_property_set_int(OBJECT(dimm), PC_DIMM_SLOT_PROP, slot,
                             &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
@@ -225,7 +225,7 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
 static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
                                 Error **errp)
 {
-    object_property_set_uint(OBJECT(md), addr, PC_DIMM_ADDR_PROP, errp);
+    object_property_set_uint(OBJECT(md), PC_DIMM_ADDR_PROP, addr, errp);
 }
 
 static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index fff2c578ef..e49fc86eb8 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -83,14 +83,14 @@ petalogix_ml605_init(MachineState *machine)
 
     /* init CPUs */
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
-    object_property_set_str(OBJECT(cpu), "8.10.a", "version", &error_abort);
+    object_property_set_str(OBJECT(cpu), "version", "8.10.a", &error_abort);
     /* Use FPU but don't use floating point conversion and square
      * root instructions
      */
-    object_property_set_int(OBJECT(cpu), 1, "use-fpu", &error_abort);
-    object_property_set_bool(OBJECT(cpu), true, "dcache-writeback",
+    object_property_set_int(OBJECT(cpu), "use-fpu", 1, &error_abort);
+    object_property_set_bool(OBJECT(cpu), "dcache-writeback", true,
                              &error_abort);
-    object_property_set_bool(OBJECT(cpu), true, "endianness", &error_abort);
+    object_property_set_bool(OBJECT(cpu), "endianness", true, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
@@ -148,10 +148,10 @@ petalogix_ml605_init(MachineState *machine)
     qdev_set_nic_properties(eth0, &nd_table[0]);
     qdev_prop_set_uint32(eth0, "rxmem", 0x1000);
     qdev_prop_set_uint32(eth0, "txmem", 0x1000);
-    object_property_set_link(OBJECT(eth0), ds,
-                             "axistream-connected", &error_abort);
-    object_property_set_link(OBJECT(eth0), cs,
-                             "axistream-control-connected", &error_abort);
+    object_property_set_link(OBJECT(eth0), "axistream-connected", ds,
+                             &error_abort);
+    object_property_set_link(OBJECT(eth0), "axistream-control-connected", cs,
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(eth0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(eth0), 0, AXIENET_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(eth0), 0, irq[AXIENET_IRQ]);
@@ -161,10 +161,10 @@ petalogix_ml605_init(MachineState *machine)
     cs = object_property_get_link(OBJECT(eth0),
                                   "axistream-control-connected-target", NULL);
     qdev_prop_set_uint32(dma, "freqhz", 100 * 1000000);
-    object_property_set_link(OBJECT(dma), ds,
-                             "axistream-connected", &error_abort);
-    object_property_set_link(OBJECT(dma), cs,
-                             "axistream-control-connected", &error_abort);
+    object_property_set_link(OBJECT(dma), "axistream-connected", ds,
+                             &error_abort);
+    object_property_set_link(OBJECT(dma), "axistream-control-connected", cs,
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, AXIDMA_BASEADDR);
     sysbus_connect_irq(SYS_BUS_DEVICE(dma), 0, irq[AXIDMA_IRQ0]);
diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index a43c980fc9..9d959d1ad8 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -70,7 +70,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
-    object_property_set_str(OBJECT(cpu), "7.10.d", "version", &error_abort);
+    object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
diff --git a/hw/microblaze/xlnx-zynqmp-pmu.c b/hw/microblaze/xlnx-zynqmp-pmu.c
index 5e861f5ae2..d22d3e22d1 100644
--- a/hw/microblaze/xlnx-zynqmp-pmu.c
+++ b/hw/microblaze/xlnx-zynqmp-pmu.c
@@ -78,34 +78,34 @@ static void xlnx_zynqmp_pmu_soc_realize(DeviceState *dev, Error **errp)
     XlnxZynqMPPMUSoCState *s = XLNX_ZYNQMP_PMU_SOC(dev);
     Error *err = NULL;
 
-    object_property_set_uint(OBJECT(&s->cpu), XLNX_ZYNQMP_PMU_ROM_ADDR,
-                             "base-vectors", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "use-stack-protection",
+    object_property_set_uint(OBJECT(&s->cpu), "base-vectors",
+                             XLNX_ZYNQMP_PMU_ROM_ADDR, &error_abort);
+    object_property_set_bool(OBJECT(&s->cpu), "use-stack-protection", true,
                              &error_abort);
-    object_property_set_uint(OBJECT(&s->cpu), 0, "use-fpu", &error_abort);
-    object_property_set_uint(OBJECT(&s->cpu), 0, "use-hw-mul", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "use-barrel",
+    object_property_set_uint(OBJECT(&s->cpu), "use-fpu", 0, &error_abort);
+    object_property_set_uint(OBJECT(&s->cpu), "use-hw-mul", 0, &error_abort);
+    object_property_set_bool(OBJECT(&s->cpu), "use-barrel", true,
                              &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "use-msr-instr",
+    object_property_set_bool(OBJECT(&s->cpu), "use-msr-instr", true,
                              &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "use-pcmp-instr",
+    object_property_set_bool(OBJECT(&s->cpu), "use-pcmp-instr", true,
                              &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), false, "use-mmu", &error_abort);
-    object_property_set_bool(OBJECT(&s->cpu), true, "endianness",
+    object_property_set_bool(OBJECT(&s->cpu), "use-mmu", false, &error_abort);
+    object_property_set_bool(OBJECT(&s->cpu), "endianness", true,
                              &error_abort);
-    object_property_set_str(OBJECT(&s->cpu), "8.40.b", "version",
+    object_property_set_str(OBJECT(&s->cpu), "version", "8.40.b",
                             &error_abort);
-    object_property_set_uint(OBJECT(&s->cpu), 0, "pvr", &error_abort);
+    object_property_set_uint(OBJECT(&s->cpu), "pvr", 0, &error_abort);
     if (!qdev_realize(DEVICE(&s->cpu), NULL, &err)) {
         error_propagate(errp, err);
         return;
     }
 
-    object_property_set_uint(OBJECT(&s->intc), 0x10, "intc-intr-size",
+    object_property_set_uint(OBJECT(&s->intc), "intc-intr-size", 0x10,
                              &error_abort);
-    object_property_set_uint(OBJECT(&s->intc), 0x0, "intc-level-edge",
+    object_property_set_uint(OBJECT(&s->intc), "intc-level-edge", 0x0,
                              &error_abort);
-    object_property_set_uint(OBJECT(&s->intc), 0xffff, "intc-positive",
+    object_property_set_uint(OBJECT(&s->intc), "intc-positive", 0xffff,
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->intc), &err)) {
         error_propagate(errp, err);
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index f5d4ac8cd4..766458c015 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -455,9 +455,9 @@ static void boston_mach_init(MachineState *machine)
     is_64b = cpu_supports_isa(machine->cpu_type, ISA_MIPS64);
 
     object_initialize_child(OBJECT(machine), "cps", &s->cps, TYPE_MIPS_CPS);
-    object_property_set_str(OBJECT(&s->cps), machine->cpu_type, "cpu-type",
+    object_property_set_str(OBJECT(&s->cps), "cpu-type", machine->cpu_type,
                             &error_fatal);
-    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp",
+    object_property_set_int(OBJECT(&s->cps), "num-vp", machine->smp.cpus,
                             &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 22b932890d..83a073fba5 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -100,11 +100,11 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Inter-Thread Communication Unit */
     if (itu_present) {
         object_initialize_child(OBJECT(dev), "itu", &s->itu, TYPE_MIPS_ITU);
-        object_property_set_int(OBJECT(&s->itu), 16, "num-fifo",
+        object_property_set_int(OBJECT(&s->itu), "num-fifo", 16,
                                 &error_abort);
-        object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores",
+        object_property_set_int(OBJECT(&s->itu), "num-semaphores", 16,
                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
+        object_property_set_bool(OBJECT(&s->itu), "saar-present", saar_present,
                                  &error_abort);
         if (saar_present) {
             s->itu.saar = &env->CP0_SAAR;
@@ -120,9 +120,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     /* Cluster Power Controller */
     object_initialize_child(OBJECT(dev), "cpc", &s->cpc, TYPE_MIPS_CPC);
-    object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp",
+    object_property_set_int(OBJECT(&s->cpc), "num-vp", s->num_vp,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running",
+    object_property_set_int(OBJECT(&s->cpc), "vp-start-running", 1,
                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpc), &err)) {
         error_propagate(errp, err);
@@ -134,9 +134,9 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     /* Global Interrupt Controller */
     object_initialize_child(OBJECT(dev), "gic", &s->gic, TYPE_MIPS_GIC);
-    object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp",
+    object_property_set_int(OBJECT(&s->gic), "num-vp", s->num_vp,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->gic), 128, "num-irq",
+    object_property_set_int(OBJECT(&s->gic), "num-irq", 128,
                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), &err)) {
         error_propagate(errp, err);
@@ -150,15 +150,15 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     gcr_base = env->CP0_CMGCRBase << 4;
 
     object_initialize_child(OBJECT(dev), "gcr", &s->gcr, TYPE_MIPS_GCR);
-    object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp",
+    object_property_set_int(OBJECT(&s->gcr), "num-vp", s->num_vp,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev",
+    object_property_set_int(OBJECT(&s->gcr), "gcr-rev", 0x800,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base",
+    object_property_set_int(OBJECT(&s->gcr), "gcr-base", gcr_base,
                             &error_abort);
-    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic",
+    object_property_set_link(OBJECT(&s->gcr), "gic", OBJECT(&s->gic.mr),
                              &error_abort);
-    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc",
+    object_property_set_link(OBJECT(&s->gcr), "cpc", OBJECT(&s->cpc.mr),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), &err)) {
         error_propagate(errp, err);
diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index 0002bff695..82a6e3220e 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -290,8 +290,8 @@ static void mips_jazz_init(MachineState *machine,
             dev = qdev_new("dp8393x");
             qdev_set_nic_properties(dev, nd);
             qdev_prop_set_uint8(dev, "it_shift", 2);
-            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
-                                     "dma_mr", &error_abort);
+            object_property_set_link(OBJECT(dev), "dma_mr",
+                                     OBJECT(rc4030_dma_mr), &error_abort);
             sysbus = SYS_BUS_DEVICE(dev);
             sysbus_realize_and_unref(sysbus, &error_fatal);
             sysbus_mmio_map(sysbus, 0, 0x80001000);
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index d95926a89c..a59e20c81c 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1184,9 +1184,9 @@ static void create_cps(MachineState *ms, MaltaState *s,
                        qemu_irq *cbus_irq, qemu_irq *i8259_irq)
 {
     object_initialize_child(OBJECT(s), "cps", &s->cps, TYPE_MIPS_CPS);
-    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
+    object_property_set_str(OBJECT(&s->cps), "cpu-type", ms->cpu_type,
                             &error_fatal);
-    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
+    object_property_set_int(OBJECT(&s->cps), "num-vp", ms->smp.cpus,
                             &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(&s->cps), &error_fatal);
 
diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
index ec1cc1931a..269783366d 100644
--- a/hw/misc/iotkit-sysctl.c
+++ b/hw/misc/iotkit-sysctl.c
@@ -84,7 +84,7 @@ static void set_init_vtor(uint64_t cpuid, uint32_t vtor)
 
     if (cpuobj) {
         if (object_property_find(cpuobj, "init-svtor", NULL)) {
-            object_property_set_uint(cpuobj, vtor, "init-svtor", &error_abort);
+            object_property_set_uint(cpuobj, "init-svtor", vtor, &error_abort);
         }
     }
 }
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index be66bb7758..9b6e3f120e 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -134,7 +134,7 @@ static void macio_realize_ide(MacIOState *s, MACIOIDEState *ide,
     sysbus_connect_irq(sysbus_dev, 0, irq0);
     sysbus_connect_irq(sysbus_dev, 1, irq1);
     qdev_prop_set_uint32(DEVICE(ide), "channel", dmaid);
-    object_property_set_link(OBJECT(ide), OBJECT(&s->dbdma), "dbdma",
+    object_property_set_link(OBJECT(ide), "dbdma", OBJECT(&s->dbdma),
                              &error_abort);
     macio_ide_register_dma(ide);
 
@@ -330,7 +330,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
     if (ns->has_pmu) {
         /* GPIOs */
         sysbus_dev = SYS_BUS_DEVICE(&ns->gpio);
-        object_property_set_link(OBJECT(&ns->gpio), OBJECT(pic_dev), "pic",
+        object_property_set_link(OBJECT(&ns->gpio), "pic", OBJECT(pic_dev),
                                  &error_abort);
         memory_region_add_subregion(&s->bar, 0x50,
                                     sysbus_mmio_get_region(sysbus_dev, 0));
@@ -340,7 +340,7 @@ static void macio_newworld_realize(PCIDevice *d, Error **errp)
 
         /* PMU */
         object_initialize_child(OBJECT(s), "pmu", &s->pmu, TYPE_VIA_PMU);
-        object_property_set_link(OBJECT(&s->pmu), OBJECT(sysbus_dev), "gpio",
+        object_property_set_link(OBJECT(&s->pmu), "gpio", OBJECT(sysbus_dev),
                                  &error_abort);
         qdev_prop_set_bit(DEVICE(&s->pmu), "has-adb", ns->has_adb);
         if (!qdev_realize(DEVICE(&s->pmu), BUS(&s->macio_bus), &err)) {
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 0594abd93a..a878056426 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -133,7 +133,7 @@ static void isa_ne2000_instance_init(Object *obj)
     object_property_add(obj, "bootindex", "int32",
                         isa_ne2000_get_bootindex,
                         isa_ne2000_set_bootindex, NULL, NULL);
-    object_property_set_int(obj, -1, "bootindex", NULL);
+    object_property_set_int(obj, "bootindex", -1, NULL);
 }
 static const TypeInfo ne2000_isa_info = {
     .name          = TYPE_ISA_NE2000,
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 679a359f9a..1e48eb70c9 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -989,8 +989,8 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
                              (Object **) &cs->enet,
                              object_property_allow_set_link,
                              OBJ_PROP_LINK_STRONG);
-    object_property_set_link(OBJECT(ds), OBJECT(s), "enet", &error_abort);
-    object_property_set_link(OBJECT(cs), OBJECT(s), "enet", &error_abort);
+    object_property_set_link(OBJECT(ds), "enet", OBJECT(s), &error_abort);
+    object_property_set_link(OBJECT(cs), "enet", OBJECT(s), &error_abort);
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_enet_info, &s->conf,
diff --git a/hw/pci-host/pnv_phb3.c b/hw/pci-host/pnv_phb3.c
index 7b547b1d78..94cb989136 100644
--- a/hw/pci-host/pnv_phb3.c
+++ b/hw/pci-host/pnv_phb3.c
@@ -999,9 +999,9 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     }
 
     /* LSI sources */
-    object_property_set_link(OBJECT(&phb->lsis), OBJECT(pnv), "xics",
-                                   &error_abort);
-    object_property_set_int(OBJECT(&phb->lsis), PNV_PHB3_NUM_LSI, "nr-irqs",
+    object_property_set_link(OBJECT(&phb->lsis), "xics", OBJECT(pnv),
+                             &error_abort);
+    object_property_set_int(OBJECT(&phb->lsis), "nr-irqs", PNV_PHB3_NUM_LSI,
                             &error_abort);
     if (!qdev_realize(DEVICE(&phb->lsis), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1015,11 +1015,11 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     phb->qirqs = qemu_allocate_irqs(ics_set_irq, &phb->lsis, phb->lsis.nr_irqs);
 
     /* MSI sources */
-    object_property_set_link(OBJECT(&phb->msis), OBJECT(phb), "phb",
-                                   &error_abort);
-    object_property_set_link(OBJECT(&phb->msis), OBJECT(pnv), "xics",
-                                   &error_abort);
-    object_property_set_int(OBJECT(&phb->msis), PHB3_MAX_MSI, "nr-irqs",
+    object_property_set_link(OBJECT(&phb->msis), "phb", OBJECT(phb),
+                             &error_abort);
+    object_property_set_link(OBJECT(&phb->msis), "xics", OBJECT(pnv),
+                             &error_abort);
+    object_property_set_int(OBJECT(&phb->msis), "nr-irqs", PHB3_MAX_MSI,
                             &error_abort);
     if (!qdev_realize(DEVICE(&phb->msis), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1027,8 +1027,8 @@ static void pnv_phb3_realize(DeviceState *dev, Error **errp)
     }
 
     /* Power Bus Common Queue */
-    object_property_set_link(OBJECT(&phb->pbcq), OBJECT(phb), "phb",
-                                   &error_abort);
+    object_property_set_link(OBJECT(&phb->pbcq), "phb", OBJECT(phb),
+                             &error_abort);
     if (!qdev_realize(DEVICE(&phb->pbcq), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 53c2b1785b..a598c89eb0 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1216,8 +1216,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     } else {
         nr_irqs = PNV_PHB4_MAX_INTs >> 1;
     }
-    object_property_set_int(OBJECT(xsrc), nr_irqs, "nr-irqs", &error_fatal);
-    object_property_set_link(OBJECT(xsrc), OBJECT(phb), "xive", &error_fatal);
+    object_property_set_int(OBJECT(xsrc), "nr-irqs", nr_irqs, &error_fatal);
+    object_property_set_link(OBJECT(xsrc), "xive", OBJECT(phb), &error_fatal);
     if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index 45a1b3719d..088ab753aa 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -388,8 +388,8 @@ static void pnv_pec_realize(DeviceState *dev, Error **errp)
         PnvPhb4PecStack *stack = &pec->stacks[i];
         Object *stk_obj = OBJECT(stack);
 
-        object_property_set_int(stk_obj, i, "stack-no", &error_abort);
-        object_property_set_link(stk_obj, OBJECT(pec), "pec", &error_abort);
+        object_property_set_int(stk_obj, "stack-no", i, &error_abort);
+        object_property_set_link(stk_obj, "pec", OBJECT(pec), &error_abort);
         if (!qdev_realize(DEVICE(stk_obj), NULL, &local_err)) {
             error_propagate(errp, local_err);
             return;
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 367e408b91..4b93fd2b01 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -236,7 +236,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
         /* According to PReP specification section 6.1.6 "System Interrupt
          * Assignments", all PCI interrupts are routed via IRQ 15 */
         s->or_irq = OR_IRQ(object_new(TYPE_OR_IRQ));
-        object_property_set_int(OBJECT(s->or_irq), PCI_NUM_PINS, "num-lines",
+        object_property_set_int(OBJECT(s->or_irq), "num-lines", PCI_NUM_PINS,
                                 &error_fatal);
         qdev_realize(DEVICE(s->or_irq), NULL, &error_fatal);
         sysbus_init_irq(dev, &s->or_irq->out_irq);
@@ -307,7 +307,7 @@ static void raven_pcihost_initfn(Object *obj)
 
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_RAVEN_PCI_DEVICE);
     pci_dev = DEVICE(&s->pci_dev);
-    object_property_set_int(OBJECT(&s->pci_dev), PCI_DEVFN(0, 0), "addr",
+    object_property_set_int(OBJECT(&s->pci_dev), "addr", PCI_DEVFN(0, 0),
                             NULL);
     qdev_prop_set_bit(pci_dev, "multifunction", false);
 }
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 828c5992ae..e42bd7a626 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -304,7 +304,7 @@ static void ppc_core99_init(MachineState *machine)
         /* 970 gets a U3 bus */
         /* Uninorth AGP bus */
         dev = qdev_new(TYPE_U3_AGP_HOST_BRIDGE);
-        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
                                  &error_abort);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         uninorth_pci = U3_AGP_HOST_BRIDGE(dev);
@@ -323,7 +323,7 @@ static void ppc_core99_init(MachineState *machine)
         /* Use values found on a real PowerMac */
         /* Uninorth AGP bus */
         dev = qdev_new(TYPE_UNI_NORTH_AGP_HOST_BRIDGE);
-        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
                                  &error_abort);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
@@ -332,7 +332,7 @@ static void ppc_core99_init(MachineState *machine)
 
         /* Uninorth internal bus */
         dev = qdev_new(TYPE_UNI_NORTH_INTERNAL_PCI_HOST_BRIDGE);
-        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
                                  &error_abort);
         s = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(s, &error_fatal);
@@ -342,7 +342,7 @@ static void ppc_core99_init(MachineState *machine)
         /* Uninorth main bus */
         dev = qdev_new(TYPE_UNI_NORTH_PCI_HOST_BRIDGE);
         qdev_prop_set_uint32(dev, "ofw-addr", 0xf2000000);
-        object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+        object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
                                  &error_abort);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         uninorth_pci = UNI_NORTH_PCI_HOST_BRIDGE(dev);
@@ -380,7 +380,7 @@ static void ppc_core99_init(MachineState *machine)
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
     qdev_prop_set_bit(dev, "has-pmu", has_pmu);
     qdev_prop_set_bit(dev, "has-adb", has_adb);
-    object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
+    object_property_set_link(OBJECT(macio), "pic", OBJECT(pic_dev),
                              &error_abort);
     pci_realize_and_unref(macio, pci_bus, &error_fatal);
 
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index f8c204ead7..7aba040f1b 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -254,7 +254,7 @@ static void ppc_heathrow_init(MachineState *machine)
     /* Grackle PCI host bridge */
     dev = qdev_new(TYPE_GRACKLE_PCI_HOST_BRIDGE);
     qdev_prop_set_uint32(dev, "ofw-addr", 0x80000000);
-    object_property_set_link(OBJECT(dev), OBJECT(pic_dev), "pic",
+    object_property_set_link(OBJECT(dev), "pic", OBJECT(pic_dev),
                              &error_abort);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -281,7 +281,7 @@ static void ppc_heathrow_init(MachineState *machine)
     macio = pci_new(-1, TYPE_OLDWORLD_MACIO);
     dev = DEVICE(macio);
     qdev_prop_set_uint64(dev, "frequency", tbfreq);
-    object_property_set_link(OBJECT(macio), OBJECT(pic_dev), "pic",
+    object_property_set_link(OBJECT(macio), "pic", OBJECT(pic_dev),
                              &error_abort);
     pci_realize_and_unref(macio, pci_bus, &error_fatal);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f2d70c3e18..194b457917 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -699,8 +699,8 @@ static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
 {
     ISADevice *dev = isa_new("isa-ipmi-bt");
 
-    object_property_set_link(OBJECT(dev), OBJECT(bmc), "bmc", &error_fatal);
-    object_property_set_int(OBJECT(dev), irq, "irq", &error_fatal);
+    object_property_set_link(OBJECT(dev), "bmc", OBJECT(bmc), &error_fatal);
+    object_property_set_int(OBJECT(dev), "irq", irq, &error_fatal);
     isa_realize_and_unref(dev, bus, &error_fatal);
 }
 
@@ -828,27 +828,27 @@ static void pnv_init(MachineState *machine)
          * way to specify different ranges for each chip
          */
         if (i == 0) {
-            object_property_set_int(chip, machine->ram_size, "ram-size",
+            object_property_set_int(chip, "ram-size", machine->ram_size,
                                     &error_fatal);
         }
 
         snprintf(chip_name, sizeof(chip_name), "chip[%d]", PNV_CHIP_HWID(i));
         object_property_add_child(OBJECT(pnv), chip_name, chip);
-        object_property_set_int(chip, PNV_CHIP_HWID(i), "chip-id",
+        object_property_set_int(chip, "chip-id", PNV_CHIP_HWID(i),
+                                &error_fatal);
+        object_property_set_int(chip, "nr-cores", machine->smp.cores,
+                                &error_fatal);
+        object_property_set_int(chip, "nr-threads", machine->smp.threads,
                                 &error_fatal);
-        object_property_set_int(chip, machine->smp.cores,
-                                "nr-cores", &error_fatal);
-        object_property_set_int(chip, machine->smp.threads,
-                                "nr-threads", &error_fatal);
         /*
          * The POWER8 machine use the XICS interrupt interface.
          * Propagate the XICS fabric to the chip and its controllers.
          */
         if (object_dynamic_cast(OBJECT(pnv), TYPE_XICS_FABRIC)) {
-            object_property_set_link(chip, OBJECT(pnv), "xics", &error_abort);
+            object_property_set_link(chip, "xics", OBJECT(pnv), &error_abort);
         }
         if (object_dynamic_cast(OBJECT(pnv), TYPE_XIVE_FABRIC)) {
-            object_property_set_link(chip, OBJECT(pnv), "xive-fabric",
+            object_property_set_link(chip, "xive-fabric", OBJECT(pnv),
                                      &error_abort);
         }
         sysbus_realize_and_unref(SYS_BUS_DEVICE(chip), &error_fatal);
@@ -1136,10 +1136,10 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     }
 
     /* Processor Service Interface (PSI) Host Bridge */
-    object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
-                            "bar", &error_fatal);
-    object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip8->xics),
-                             ICS_PROP_XICS, &error_abort);
+    object_property_set_int(OBJECT(&chip8->psi), "bar", PNV_PSIHB_BASE(chip),
+                            &error_fatal);
+    object_property_set_link(OBJECT(&chip8->psi), ICS_PROP_XICS,
+                             OBJECT(chip8->xics), &error_abort);
     if (!qdev_realize(DEVICE(&chip8->psi), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
@@ -1148,7 +1148,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                             &PNV_PSI(psi8)->xscom_regs);
 
     /* Create LPC controller */
-    object_property_set_link(OBJECT(&chip8->lpc), OBJECT(&chip8->psi), "psi",
+    object_property_set_link(OBJECT(&chip8->lpc), "psi", OBJECT(&chip8->psi),
                              &error_abort);
     qdev_realize(DEVICE(&chip8->lpc), NULL, &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_regs);
@@ -1168,7 +1168,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     }
 
     /* Create the simplified OCC model */
-    object_property_set_link(OBJECT(&chip8->occ), OBJECT(&chip8->psi), "psi",
+    object_property_set_link(OBJECT(&chip8->occ), "psi", OBJECT(&chip8->psi),
                              &error_abort);
     if (!qdev_realize(DEVICE(&chip8->occ), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1181,7 +1181,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
                                 &chip8->occ.sram_regs);
 
     /* HOMER */
-    object_property_set_link(OBJECT(&chip8->homer), OBJECT(chip), "chip",
+    object_property_set_link(OBJECT(&chip8->homer), "chip", OBJECT(chip),
                              &error_abort);
     if (!qdev_realize(DEVICE(&chip8->homer), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1199,8 +1199,8 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         PnvPHB3 *phb = &chip8->phbs[i];
         PnvPBCQState *pbcq = &phb->pbcq;
 
-        object_property_set_int(OBJECT(phb), i, "index", &error_fatal);
-        object_property_set_int(OBJECT(phb), chip->chip_id, "chip-id",
+        object_property_set_int(OBJECT(phb), "index", i, &error_fatal);
+        object_property_set_int(OBJECT(phb), "chip-id", chip->chip_id,
                                 &error_fatal);
         if (!sysbus_realize(SYS_BUS_DEVICE(phb), &local_err)) {
             error_propagate(errp, local_err);
@@ -1347,7 +1347,7 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
                                            sizeof(*eq), TYPE_PNV_QUAD,
                                            &error_fatal, NULL);
 
-        object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal);
+        object_property_set_int(OBJECT(eq), "id", core_id, &error_fatal);
         qdev_realize(DEVICE(eq), NULL, &error_fatal);
 
         pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->id),
@@ -1368,18 +1368,18 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
         uint32_t pec_nest_base;
         uint32_t pec_pci_base;
 
-        object_property_set_int(OBJECT(pec), i, "index", &error_fatal);
+        object_property_set_int(OBJECT(pec), "index", i, &error_fatal);
         /*
          * PEC0 -> 1 stack
          * PEC1 -> 2 stacks
          * PEC2 -> 3 stacks
          */
-        object_property_set_int(OBJECT(pec), i + 1, "num-stacks",
+        object_property_set_int(OBJECT(pec), "num-stacks", i + 1,
                                 &error_fatal);
-        object_property_set_int(OBJECT(pec), chip->chip_id, "chip-id",
-                                 &error_fatal);
-        object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()),
-                                 "system-memory", &error_abort);
+        object_property_set_int(OBJECT(pec), "chip-id", chip->chip_id,
+                                &error_fatal);
+        object_property_set_link(OBJECT(pec), "system-memory",
+                                 OBJECT(get_system_memory()), &error_abort);
         if (!qdev_realize(DEVICE(pec), NULL, &local_err)) {
             error_propagate(errp, local_err);
             return;
@@ -1396,14 +1396,15 @@ static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
             PnvPhb4PecStack *stack = &pec->stacks[j];
             Object *obj = OBJECT(&stack->phb);
 
-            object_property_set_int(obj, phb_id, "index", &error_fatal);
-            object_property_set_int(obj, chip->chip_id, "chip-id",
+            object_property_set_int(obj, "index", phb_id, &error_fatal);
+            object_property_set_int(obj, "chip-id", chip->chip_id,
                                     &error_fatal);
-            object_property_set_int(obj, PNV_PHB4_VERSION, "version",
+            object_property_set_int(obj, "version", PNV_PHB4_VERSION,
                                     &error_fatal);
-            object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id",
+            object_property_set_int(obj, "device-id", PNV_PHB4_DEVICE_ID,
                                     &error_fatal);
-            object_property_set_link(obj, OBJECT(stack), "stack", &error_abort);
+            object_property_set_link(obj, "stack", OBJECT(stack),
+                                     &error_abort);
             if (!sysbus_realize(SYS_BUS_DEVICE(obj), &local_err)) {
                 error_propagate(errp, local_err);
                 return;
@@ -1453,15 +1454,15 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     }
 
     /* XIVE interrupt controller (POWER9) */
-    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_IC_BASE(chip),
-                            "ic-bar", &error_fatal);
-    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_VC_BASE(chip),
-                            "vc-bar", &error_fatal);
-    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_PC_BASE(chip),
-                            "pc-bar", &error_fatal);
-    object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_TM_BASE(chip),
-                            "tm-bar", &error_fatal);
-    object_property_set_link(OBJECT(&chip9->xive), OBJECT(chip), "chip",
+    object_property_set_int(OBJECT(&chip9->xive), "ic-bar",
+                            PNV9_XIVE_IC_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip9->xive), "vc-bar",
+                            PNV9_XIVE_VC_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip9->xive), "pc-bar",
+                            PNV9_XIVE_PC_BASE(chip), &error_fatal);
+    object_property_set_int(OBJECT(&chip9->xive), "tm-bar",
+                            PNV9_XIVE_TM_BASE(chip), &error_fatal);
+    object_property_set_link(OBJECT(&chip9->xive), "chip", OBJECT(chip),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&chip9->xive), &local_err)) {
         error_propagate(errp, local_err);
@@ -1471,8 +1472,8 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             &chip9->xive.xscom_regs);
 
     /* Processor Service Interface (PSI) Host Bridge */
-    object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
-                            "bar", &error_fatal);
+    object_property_set_int(OBJECT(&chip9->psi), "bar", PNV9_PSIHB_BASE(chip),
+                            &error_fatal);
     if (!qdev_realize(DEVICE(&chip9->psi), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
@@ -1481,7 +1482,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             &PNV_PSI(psi9)->xscom_regs);
 
     /* LPC */
-    object_property_set_link(OBJECT(&chip9->lpc), OBJECT(&chip9->psi), "psi",
+    object_property_set_link(OBJECT(&chip9->lpc), "psi", OBJECT(&chip9->psi),
                              &error_abort);
     if (!qdev_realize(DEVICE(&chip9->lpc), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1494,7 +1495,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                                             (uint64_t) PNV9_LPCM_BASE(chip));
 
     /* Create the simplified OCC model */
-    object_property_set_link(OBJECT(&chip9->occ), OBJECT(&chip9->psi), "psi",
+    object_property_set_link(OBJECT(&chip9->occ), "psi", OBJECT(&chip9->psi),
                              &error_abort);
     if (!qdev_realize(DEVICE(&chip9->occ), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1507,7 +1508,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                                 &chip9->occ.sram_regs);
 
     /* HOMER */
-    object_property_set_link(OBJECT(&chip9->homer), OBJECT(chip), "chip",
+    object_property_set_link(OBJECT(&chip9->homer), "chip", OBJECT(chip),
                              &error_abort);
     if (!qdev_realize(DEVICE(&chip9->homer), NULL, &local_err)) {
         error_propagate(errp, local_err);
@@ -1588,8 +1589,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     }
 
     /* Processor Service Interface (PSI) Host Bridge */
-    object_property_set_int(OBJECT(&chip10->psi), PNV10_PSIHB_BASE(chip),
-                            "bar", &error_fatal);
+    object_property_set_int(OBJECT(&chip10->psi), "bar",
+                            PNV10_PSIHB_BASE(chip), &error_fatal);
     if (!qdev_realize(DEVICE(&chip10->psi), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
@@ -1598,8 +1599,8 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
                             &PNV_PSI(&chip10->psi)->xscom_regs);
 
     /* LPC */
-    object_property_set_link(OBJECT(&chip10->lpc), OBJECT(&chip10->psi), "psi",
-                             &error_abort);
+    object_property_set_link(OBJECT(&chip10->lpc), "psi",
+                             OBJECT(&chip10->psi), &error_abort);
     if (!qdev_realize(DEVICE(&chip10->lpc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
@@ -1707,16 +1708,15 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
         snprintf(core_name, sizeof(core_name), "core[%d]", core_hwid);
         object_property_add_child(OBJECT(chip), core_name, OBJECT(pnv_core));
         chip->cores[i] = pnv_core;
-        object_property_set_int(OBJECT(pnv_core), chip->nr_threads,
-                                "nr-threads", &error_fatal);
-        object_property_set_int(OBJECT(pnv_core), core_hwid,
-                                CPU_CORE_PROP_CORE_ID, &error_fatal);
-        object_property_set_int(OBJECT(pnv_core),
-                                pcc->core_pir(chip, core_hwid),
-                                "pir", &error_fatal);
-        object_property_set_int(OBJECT(pnv_core), pnv->fw_load_addr,
-                                "hrmor", &error_fatal);
-        object_property_set_link(OBJECT(pnv_core), OBJECT(chip), "chip",
+        object_property_set_int(OBJECT(pnv_core), "nr-threads",
+                                chip->nr_threads, &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), CPU_CORE_PROP_CORE_ID,
+                                core_hwid, &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), "pir",
+                                pcc->core_pir(chip, core_hwid), &error_fatal);
+        object_property_set_int(OBJECT(pnv_core), "hrmor", pnv->fw_load_addr,
+                                &error_fatal);
+        object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
                                  &error_abort);
         qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
 
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 7efe6e138f..e23276983f 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -505,7 +505,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
     unsigned int i;
 
     /* Create PSI interrupt control source */
-    object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", &err);
+    object_property_set_int(OBJECT(ics), "nr-irqs", PSI_NUM_INTERRUPTS, &err);
     if (err) {
         error_propagate(errp, err);
         return;
@@ -845,11 +845,10 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     int i;
 
     /* This is the only device with 4k ESB pages */
-    object_property_set_int(OBJECT(xsrc), XIVE_ESB_4K, "shift",
+    object_property_set_int(OBJECT(xsrc), "shift", XIVE_ESB_4K, &error_fatal);
+    object_property_set_int(OBJECT(xsrc), "nr-irqs", PSIHB9_NUM_IRQS,
                             &error_fatal);
-    object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
-                            &error_fatal);
-    object_property_set_link(OBJECT(xsrc), OBJECT(psi), "xive", &error_abort);
+    object_property_set_link(OBJECT(xsrc), "xive", OBJECT(psi), &error_abort);
     if (!qdev_realize(DEVICE(xsrc), NULL, &local_err)) {
         error_propagate(errp, local_err);
         return;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f6f034d039..68e8b504b5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2624,9 +2624,9 @@ static void spapr_init_cpus(SpaprMachineState *spapr)
                 nr_threads = smp_cpus - i * smp_threads;
             }
 
-            object_property_set_int(core, nr_threads, "nr-threads",
+            object_property_set_int(core, "nr-threads", nr_threads,
                                     &error_fatal);
-            object_property_set_int(core, core_id, CPU_CORE_PROP_CORE_ID,
+            object_property_set_int(core, CPU_CORE_PROP_CORE_ID, core_id,
                                     &error_fatal);
             qdev_realize(DEVICE(core), NULL, &error_fatal);
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 1d0db57fc5..eb55171d70 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -308,9 +308,9 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         obj = object_new(TYPE_ICS_SPAPR);
 
         object_property_add_child(OBJECT(spapr), "ics", obj);
-        object_property_set_link(obj, OBJECT(spapr), ICS_PROP_XICS,
+        object_property_set_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                  &error_abort);
-        object_property_set_int(obj, smc->nr_xirqs, "nr-irqs", &error_abort);
+        object_property_set_int(obj, "nr-irqs", smc->nr_xirqs, &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, &local_err)) {
             error_propagate(errp, local_err);
             return;
@@ -331,7 +331,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
          * priority
          */
         qdev_prop_set_uint32(dev, "nr-ends", nr_servers << 3);
-        object_property_set_link(OBJECT(dev), OBJECT(spapr), "xive-fabric",
+        object_property_set_link(OBJECT(dev), "xive-fabric", OBJECT(spapr),
                                  &error_abort);
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 0f00e2421f..223bb8f464 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2418,7 +2418,7 @@ static int spapr_switch_one_vga(DeviceState *dev, void *opaque)
 
     if (object_dynamic_cast(OBJECT(dev), "VGA")
         || object_dynamic_cast(OBJECT(dev), "secondary-vga")) {
-        object_property_set_bool(OBJECT(dev), be, "big-endian-framebuffer",
+        object_property_set_bool(OBJECT(dev), "big-endian-framebuffer", be,
                                  &error_abort);
     }
     return 0;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 5fce455d30..7003b1f62d 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -108,9 +108,9 @@ static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     MemoryRegion *sys_mem = get_system_memory();
     Error *err = NULL;
 
-    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
 
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1b2e95a977..f2df06cc43 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -175,7 +175,7 @@ static void sifive_e_soc_init(Object *obj)
     SiFiveESoCState *s = RISCV_E_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
-    object_property_set_int(OBJECT(&s->cpus), ms->smp.cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
                             &error_abort);
     object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
                             TYPE_SIFIVE_GPIO);
@@ -190,7 +190,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
 
-    object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_abort);
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7b9e7fdc7f..e70253d58f 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -383,8 +383,8 @@ static void sifive_u_machine_init(MachineState *machine)
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
-    object_property_set_uint(OBJECT(&s->soc), s->serial, "serial",
-                            &error_abort);
+    object_property_set_uint(OBJECT(&s->soc), "serial", s->serial,
+                             &error_abort);
     qdev_realize(DEVICE(&s->soc), NULL, &error_abort);
 
     /* register RAM */
@@ -708,7 +708,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(DEVICE(&s->gem), nd);
     }
-    object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
+    object_property_set_int(OBJECT(&s->gem), "revision", GEM_REVISION,
                             &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gem), &err)) {
         error_propagate(errp, err);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3c87e04fdc..c107bf3ba1 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -171,9 +171,9 @@ static void spike_board_init(MachineState *machine)
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->soc), "num-harts", smp_cpus,
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 616db6f5ac..f7630c8a89 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -487,9 +487,9 @@ static void virt_machine_init(MachineState *machine)
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
                             TYPE_RISCV_HART_ARRAY);
-    object_property_set_str(OBJECT(&s->soc), machine->cpu_type, "cpu-type",
+    object_property_set_str(OBJECT(&s->soc), "cpu-type", machine->cpu_type,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "num-harts",
+    object_property_set_int(OBJECT(&s->soc), "num-harts", smp_cpus,
                             &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_abort);
 
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index b8a56fa7af..54992ebe57 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -101,12 +101,12 @@ static void rx_gdbsim_init(MachineState *machine)
 
     /* Initialize MCU */
     object_initialize_child(OBJECT(machine), "mcu", &s->mcu, rxc->mcu_name);
-    object_property_set_link(OBJECT(&s->mcu), OBJECT(sysmem),
-                             "main-bus", &error_abort);
-    object_property_set_uint(OBJECT(&s->mcu), rxc->xtal_freq_hz,
-                             "xtal-frequency-hz", &error_abort);
-    object_property_set_bool(OBJECT(&s->mcu), kernel_filename != NULL,
-                             "load-kernel", &error_abort);
+    object_property_set_link(OBJECT(&s->mcu), "main-bus", OBJECT(sysmem),
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->mcu), "xtal-frequency-hz",
+                             rxc->xtal_freq_hz, &error_abort);
+    object_property_set_bool(OBJECT(&s->mcu), "load-kernel",
+                             kernel_filename != NULL, &error_abort);
     qdev_realize(DEVICE(&s->mcu), NULL, &error_abort);
 
     /* Load kernel and dtb */
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index ce21494c08..7c893e5683 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -555,9 +555,9 @@ static void update_machine_ipl_properties(IplParameterBlock *iplb)
             ascii_loadparm[i] = ebcdic2ascii[(uint8_t) ebcdic_loadparm[i]];
         }
         ascii_loadparm[i] = 0;
-        object_property_set_str(machine, ascii_loadparm, "loadparm", &err);
+        object_property_set_str(machine, "loadparm", ascii_loadparm, &err);
     } else {
-        object_property_set_str(machine, "", "loadparm", &err);
+        object_property_set_str(machine, "loadparm", "", &err);
     }
     if (err) {
         warn_report_err(err);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 1e4537f0e3..a7b2a15a96 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -824,7 +824,7 @@ static S390PCIBusDevice *s390_pci_device_new(S390pciState *s,
         return NULL;
     }
 
-    object_property_set_str(OBJECT(dev), target, "target", &local_err);
+    object_property_set_str(OBJECT(dev), "target", target, &local_err);
     if (local_err) {
         object_unparent(OBJECT(dev));
         error_propagate_prepend(errp, local_err,
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 1e036cc602..db2f49cb27 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -401,7 +401,7 @@ static void s390_skeys_instance_init(Object *obj)
     object_property_add_bool(obj, "migration-enabled",
                              s390_skeys_get_migration_enabled,
                              s390_skeys_set_migration_enabled);
-    object_property_set_bool(obj, true, "migration-enabled", NULL);
+    object_property_set_bool(obj, "migration-enabled", true, NULL);
 }
 
 static void s390_skeys_class_init(ObjectClass *oc, void *data)
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 0144b9021c..4441e1d331 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -388,7 +388,7 @@ static void s390_stattrib_instance_init(Object *obj)
     object_property_add_bool(obj, "migration-enabled",
                              s390_stattrib_get_migration_enabled,
                              s390_stattrib_set_migration_enabled);
-    object_property_set_bool(obj, true, "migration-enabled", NULL);
+    object_property_set_bool(obj, "migration-enabled", true, NULL);
     sas->migration_cur_gfn = 0;
 }
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 023fd25f2b..07609a9a58 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -70,7 +70,7 @@ static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
     S390CPU *cpu = S390_CPU(object_new(typename));
     Error *err = NULL;
 
-    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
+    object_property_set_int(OBJECT(cpu), "core-id", core_id, &err);
     if (err != NULL) {
         goto out;
     }
@@ -736,14 +736,14 @@ static inline void s390_machine_initfn(Object *obj)
                              machine_set_aes_key_wrap);
     object_property_set_description(obj, "aes-key-wrap",
             "enable/disable AES key wrapping using the CPACF wrapping key");
-    object_property_set_bool(obj, true, "aes-key-wrap", NULL);
+    object_property_set_bool(obj, "aes-key-wrap", true, NULL);
 
     object_property_add_bool(obj, "dea-key-wrap",
                              machine_get_dea_key_wrap,
                              machine_set_dea_key_wrap);
     object_property_set_description(obj, "dea-key-wrap",
             "enable/disable DEA key wrapping using the CPACF wrapping key");
-    object_property_set_bool(obj, true, "dea-key-wrap", NULL);
+    object_property_set_bool(obj, "dea-key-wrap", true, NULL);
     object_property_add_str(obj, "loadparm",
             machine_get_loadparm, machine_set_loadparm);
     object_property_set_description(obj, "loadparm",
diff --git a/hw/s390x/virtio-ccw-crypto.c b/hw/s390x/virtio-ccw-crypto.c
index 36cfdf865c..5720e84fc9 100644
--- a/hw/s390x/virtio-ccw-crypto.c
+++ b/hw/s390x/virtio-ccw-crypto.c
@@ -26,9 +26,8 @@ static void virtio_ccw_crypto_realize(VirtioCcwDevice *ccw_dev, Error **errp)
         return;
     }
 
-    object_property_set_link(OBJECT(vdev),
-                             OBJECT(dev->vdev.conf.cryptodev), "cryptodev",
-                             NULL);
+    object_property_set_link(OBJECT(vdev), "cryptodev",
+                             OBJECT(dev->vdev.conf.cryptodev), NULL);
 }
 
 static void virtio_ccw_crypto_instance_init(Object *obj)
diff --git a/hw/s390x/virtio-ccw-rng.c b/hw/s390x/virtio-ccw-rng.c
index 513f85ac63..8cf01ce76c 100644
--- a/hw/s390x/virtio-ccw-rng.c
+++ b/hw/s390x/virtio-ccw-rng.c
@@ -27,8 +27,7 @@ static void virtio_ccw_rng_realize(VirtioCcwDevice *ccw_dev, Error **errp)
         return;
     }
 
-    object_property_set_link(OBJECT(dev),
-                             OBJECT(dev->vdev.conf.rng), "rng",
+    object_property_set_link(OBJECT(dev), "rng", OBJECT(dev->vdev.conf.rng),
                              NULL);
 }
 
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 365d09fb48..4860863f1d 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -268,7 +268,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
 
     qdev_prop_set_uint32(dev, "scsi-id", unit);
     if (bootindex >= 0) {
-        object_property_set_int(OBJECT(dev), bootindex, "bootindex",
+        object_property_set_int(OBJECT(dev), "bootindex", bootindex,
                                 &error_abort);
     }
     if (object_property_find(OBJECT(dev), "removable", NULL)) {
@@ -283,7 +283,7 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
         object_unparent(OBJECT(dev));
         return NULL;
     }
-    object_property_set_bool(OBJECT(dev), share_rw, "share-rw", &err);
+    object_property_set_bool(OBJECT(dev), "share-rw", share_rw, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         object_unparent(OBJECT(dev));
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 2d0d5651e3..29aa11df66 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -132,14 +132,14 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
         Object *sdhci_slot = OBJECT(&sdhci->slots[i]);
         SysBusDevice *sbd_slot = SYS_BUS_DEVICE(&sdhci->slots[i]);
 
-        object_property_set_int(sdhci_slot, 2, "sd-spec-version", &err);
+        object_property_set_int(sdhci_slot, "sd-spec-version", 2, &err);
         if (err) {
             error_propagate(errp, err);
             return;
         }
 
-        object_property_set_uint(sdhci_slot, ASPEED_SDHCI_CAPABILITIES,
-                                 "capareg", &err);
+        object_property_set_uint(sdhci_slot, "capareg",
+                                 ASPEED_SDHCI_CAPABILITIES, &err);
         if (err) {
             error_propagate(errp, err);
             return;
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index c57d76b1c8..d4b57cda80 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -261,7 +261,7 @@ static void ssi_sd_realize(SSISlave *d, Error **errp)
         }
     }
 
-    object_property_set_bool(OBJECT(carddev), true, "spi", &err);
+    object_property_set_bool(OBJECT(carddev), "spi", true, &err);
     if (err) {
         goto fail;
     }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index ee52b5cbbc..9be930415f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -878,7 +878,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
 
     /* Create and map RAM frontend */
     dev = qdev_new("memory");
-    object_property_set_link(OBJECT(dev), ram_memdev, "memdev", &error_fatal);
+    object_property_set_link(OBJECT(dev), "memdev", ram_memdev, &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 9c8655cffc..9e30203dcc 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -579,7 +579,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     sabre = SABRE_DEVICE(qdev_new(TYPE_SABRE));
     qdev_prop_set_uint64(DEVICE(sabre), "special-base", PBM_SPECIAL_BASE);
     qdev_prop_set_uint64(DEVICE(sabre), "mem-base", PBM_MEM_BASE);
-    object_property_set_link(OBJECT(sabre), OBJECT(iommu), "iommu",
+    object_property_set_link(OBJECT(sabre), "iommu", OBJECT(iommu),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(sabre), &error_fatal);
 
diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 721665191e..2ed6a8df24 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -748,7 +748,7 @@ static void usb_msd_set_bootindex(Object *obj, Visitor *v, const char *name,
     s->conf.bootindex = boot_index;
 
     if (s->scsi_dev) {
-        object_property_set_int(OBJECT(s->scsi_dev), boot_index, "bootindex",
+        object_property_set_int(OBJECT(s->scsi_dev), "bootindex", boot_index,
                                 &error_abort);
     }
 
@@ -769,7 +769,7 @@ static void usb_msd_instance_init(Object *obj)
     object_property_add(obj, "bootindex", "int32",
                         usb_msd_get_bootindex,
                         usb_msd_set_bootindex, NULL, NULL);
-    object_property_set_int(obj, -1, "bootindex", NULL);
+    object_property_set_int(obj, "bootindex", -1, NULL);
 }
 
 static void usb_msd_class_bot_initfn(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 0755722288..f1cc979d33 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -57,9 +57,8 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     if (!qdev_realize(vdev, BUS(&vpci_dev->bus), errp)) {
         return;
     }
-    object_property_set_link(OBJECT(vcrypto),
-                 OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
-                 NULL);
+    object_property_set_link(OBJECT(vcrypto), "cryptodev",
+                             OBJECT(vcrypto->vdev.conf.cryptodev), NULL);
 }
 
 static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 592abc9279..ba62d60a0a 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -65,9 +65,9 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
             error_append_hint(errp, "Valid values are 0 and 1\n");
         }
     }
-    object_property_set_link(OBJECT(dev),
+    object_property_set_link(OBJECT(dev), "primary-bus",
                              OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
-                             "primary-bus", &error_abort);
+                             &error_abort);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 1a8e854123..d375280ee1 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -22,13 +22,13 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     DeviceState *vdev = DEVICE(&mem_pci->vdev);
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), true, "realized", errp);
+    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
 }
 
 static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
                                     Error **errp)
 {
-    object_property_set_uint(OBJECT(md), addr, VIRTIO_MEM_ADDR_PROP, errp);
+    object_property_set_uint(OBJECT(md), VIRTIO_MEM_ADDR_PROP, addr, errp);
 }
 
 static uint64_t virtio_mem_pci_get_addr(const MemoryDeviceState *md)
diff --git a/hw/virtio/virtio-pmem-pci.c b/hw/virtio/virtio-pmem-pci.c
index 11d0c8ebc6..21a457d151 100644
--- a/hw/virtio/virtio-pmem-pci.c
+++ b/hw/virtio/virtio-pmem-pci.c
@@ -28,7 +28,7 @@ static void virtio_pmem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 static void virtio_pmem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
                                      Error **errp)
 {
-    object_property_set_uint(OBJECT(md), addr, VIRTIO_PMEM_ADDR_PROP, errp);
+    object_property_set_uint(OBJECT(md), VIRTIO_PMEM_ADDR_PROP, addr, errp);
 }
 
 static uint64_t virtio_pmem_pci_get_addr(const MemoryDeviceState *md)
diff --git a/hw/virtio/virtio-rng-pci.c b/hw/virtio/virtio-rng-pci.c
index 20ce1b113b..8b11c4b425 100644
--- a/hw/virtio/virtio-rng-pci.c
+++ b/hw/virtio/virtio-rng-pci.c
@@ -41,8 +41,7 @@ static void virtio_rng_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
         return;
     }
 
-    object_property_set_link(OBJECT(vrng),
-                             OBJECT(vrng->vdev.conf.rng), "rng",
+    object_property_set_link(OBJECT(vrng), "rng", OBJECT(vrng->vdev.conf.rng),
                              NULL);
 }
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index a8df41b11b..85f7163e2d 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -208,8 +208,8 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
         /* The child property took a reference, we can safely drop ours now */
         object_unref(default_backend);
 
-        object_property_set_link(OBJECT(dev), default_backend,
-                                 "rng", &error_abort);
+        object_property_set_link(OBJECT(dev), "rng", default_backend,
+                                 &error_abort);
     }
 
     vrng->rng = vrng->conf.rng;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 82afadcea0..98ea86ca81 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7722,7 +7722,7 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         if (CPU_NEXT(first_cpu)) {
             TaskState *ts = cpu->opaque;
 
-            object_property_set_bool(OBJECT(cpu), false, "realized", NULL);
+            object_property_set_bool(OBJECT(cpu), "realized", false, NULL);
             object_unref(OBJECT(cpu));
             /*
              * At this point the CPU should be unrealized and removed
diff --git a/net/filter.c b/net/filter.c
index caf6443655..eac8ba1e9c 100644
--- a/net/filter.c
+++ b/net/filter.c
@@ -338,7 +338,7 @@ static void default_handle_event(NetFilterState *nf, int event, Error **errp)
     case COLO_EVENT_CHECKPOINT:
         break;
     case COLO_EVENT_FAILOVER:
-        object_property_set_str(OBJECT(nf), "off", "status", errp);
+        object_property_set_str(OBJECT(nf), "status", "off", errp);
         break;
     default:
         break;
diff --git a/net/net.c b/net/net.c
index 6fe74c80bb..7fddcebaa2 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1164,7 +1164,7 @@ static void netfilter_print_info(Monitor *mon, NetFilterState *nf)
             continue;
         }
         v = string_output_visitor_new(false, &str);
-        object_property_get(OBJECT(nf), v, prop->name, NULL);
+        object_property_get(OBJECT(nf), prop->name, v, NULL);
         visit_complete(v, &str);
         visit_free(v);
         monitor_printf(mon, ",%s=%s", prop->name, str);
diff --git a/qdev-monitor.c b/qdev-monitor.c
index cbcbbb5d50..f4c6e6073a 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -186,7 +186,7 @@ static int set_property(void *opaque, const char *name, const char *value,
     if (strcmp(name, "bus") == 0)
         return 0;
 
-    object_property_parse(obj, value, name, &err);
+    object_property_parse(obj, name, value, &err);
     if (err != NULL) {
         error_propagate(errp, err);
         return -1;
diff --git a/qom/object.c b/qom/object.c
index be8fed6688..7d75c452b9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -404,7 +404,7 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
             continue;
         }
         p->used = true;
-        object_property_parse(obj, p->value, p->property, &err);
+        object_property_parse(obj, p->property, p->value, &err);
         if (err != NULL) {
             error_prepend(&err, "can't apply global %s.%s=%s: ",
                           p->driver, p->property, p->value);
@@ -798,7 +798,7 @@ int object_set_propv(Object *obj,
         const char *value = va_arg(vargs, char *);
 
         g_assert(value != NULL);
-        object_property_parse(obj, value, propname, &local_err);
+        object_property_parse(obj, propname, value, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return -1;
@@ -1312,7 +1312,7 @@ void object_property_del(Object *obj, const char *name)
     g_hash_table_remove(obj->properties, name);
 }
 
-void object_property_get(Object *obj, Visitor *v, const char *name,
+void object_property_get(Object *obj, const char *name, Visitor *v,
                          Error **errp)
 {
     ObjectProperty *prop = object_property_find(obj, name, errp);
@@ -1327,7 +1327,7 @@ void object_property_get(Object *obj, Visitor *v, const char *name,
     }
 }
 
-void object_property_set(Object *obj, Visitor *v, const char *name,
+void object_property_set(Object *obj, const char *name, Visitor *v,
                          Error **errp)
 {
     ObjectProperty *prop = object_property_find(obj, name, errp);
@@ -1342,11 +1342,11 @@ void object_property_set(Object *obj, Visitor *v, const char *name,
     }
 }
 
-void object_property_set_str(Object *obj, const char *value,
-                             const char *name, Error **errp)
+void object_property_set_str(Object *obj, const char *name,
+                             const char *value, Error **errp)
 {
     QString *qstr = qstring_from_str(value);
-    object_property_set_qobject(obj, QOBJECT(qstr), name, errp);
+    object_property_set_qobject(obj, name, QOBJECT(qstr), errp);
 
     qobject_unref(qstr);
 }
@@ -1370,15 +1370,15 @@ char *object_property_get_str(Object *obj, const char *name,
     return retval;
 }
 
-void object_property_set_link(Object *obj, Object *value,
-                              const char *name, Error **errp)
+void object_property_set_link(Object *obj, const char *name,
+                              Object *value, Error **errp)
 {
     if (value) {
         char *path = object_get_canonical_path(value);
-        object_property_set_str(obj, path, name, errp);
+        object_property_set_str(obj, name, path, errp);
         g_free(path);
     } else {
-        object_property_set_str(obj, "", name, errp);
+        object_property_set_str(obj, name, "", errp);
     }
 }
 
@@ -1400,11 +1400,11 @@ Object *object_property_get_link(Object *obj, const char *name,
     return target;
 }
 
-void object_property_set_bool(Object *obj, bool value,
-                              const char *name, Error **errp)
+void object_property_set_bool(Object *obj, const char *name,
+                              bool value, Error **errp)
 {
     QBool *qbool = qbool_from_bool(value);
-    object_property_set_qobject(obj, QOBJECT(qbool), name, errp);
+    object_property_set_qobject(obj, name, QOBJECT(qbool), errp);
 
     qobject_unref(qbool);
 }
@@ -1431,11 +1431,11 @@ bool object_property_get_bool(Object *obj, const char *name,
     return retval;
 }
 
-void object_property_set_int(Object *obj, int64_t value,
-                             const char *name, Error **errp)
+void object_property_set_int(Object *obj, const char *name,
+                             int64_t value, Error **errp)
 {
     QNum *qnum = qnum_from_int(value);
-    object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
+    object_property_set_qobject(obj, name, QOBJECT(qnum), errp);
 
     qobject_unref(qnum);
 }
@@ -1500,12 +1500,12 @@ void object_property_set_default_uint(ObjectProperty *prop, uint64_t value)
     object_property_set_default(prop, QOBJECT(qnum_from_uint(value)));
 }
 
-void object_property_set_uint(Object *obj, uint64_t value,
-                              const char *name, Error **errp)
+void object_property_set_uint(Object *obj, const char *name,
+                              uint64_t value, Error **errp)
 {
     QNum *qnum = qnum_from_uint(value);
 
-    object_property_set_qobject(obj, QOBJECT(qnum), name, errp);
+    object_property_set_qobject(obj, name, QOBJECT(qnum), errp);
     qobject_unref(qnum);
 }
 
@@ -1567,11 +1567,11 @@ int object_property_get_enum(Object *obj, const char *name,
     return ret;
 }
 
-void object_property_parse(Object *obj, const char *string,
-                           const char *name, Error **errp)
+void object_property_parse(Object *obj, const char *name,
+                           const char *string, Error **errp)
 {
     Visitor *v = string_input_visitor_new(string);
-    object_property_set(obj, v, name, errp);
+    object_property_set(obj, name, v, errp);
     visit_free(v);
 }
 
@@ -1583,7 +1583,7 @@ char *object_property_print(Object *obj, const char *name, bool human,
     Error *local_err = NULL;
 
     v = string_output_visitor_new(human, &string);
-    object_property_get(obj, v, name, &local_err);
+    object_property_get(obj, name, v, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto out;
@@ -2645,7 +2645,7 @@ static void property_get_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
 
-    object_property_get(prop->target_obj, v, prop->target_name, errp);
+    object_property_get(prop->target_obj, prop->target_name, v, errp);
 }
 
 static void property_set_alias(Object *obj, Visitor *v, const char *name,
@@ -2653,7 +2653,7 @@ static void property_set_alias(Object *obj, Visitor *v, const char *name,
 {
     AliasProperty *prop = opaque;
 
-    object_property_set(prop->target_obj, v, prop->target_name, errp);
+    object_property_set(prop->target_obj, prop->target_name, v, errp);
 }
 
 static Object *property_resolve_alias(Object *obj, void *opaque,
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 3085ae0b31..4c59ee56d5 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -67,7 +67,7 @@ Object *user_creatable_add_type(const char *type, const char *id,
         goto out;
     }
     for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-        object_property_set(obj, v, e->key, &local_err);
+        object_property_set(obj, e->key, v, &local_err);
         if (local_err) {
             break;
         }
diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
index b0abe84cb1..9ed8bb1c9f 100644
--- a/qom/qom-hmp-cmds.c
+++ b/qom/qom-hmp-cmds.c
@@ -57,7 +57,7 @@ void hmp_qom_set(Monitor *mon, const QDict *qdict)
             error_set(&err, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
         } else {
-            object_property_parse(obj, value, property, &err);
+            object_property_parse(obj, property, value, &err);
         }
     } else {
         QObject *obj = qobject_from_json(value, &err);
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 5e2c8cbf33..310ab2d048 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -71,7 +71,7 @@ void qmp_qom_set(const char *path, const char *property, QObject *value,
         return;
     }
 
-    object_property_set_qobject(obj, value, property, errp);
+    object_property_set_qobject(obj, property, value, errp);
 }
 
 QObject *qmp_qom_get(const char *path, const char *property, Error **errp)
diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index c3b95aa354..f949572d8a 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -17,13 +17,14 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/qobject-output-visitor.h"
 
-void object_property_set_qobject(Object *obj, QObject *value,
-                                 const char *name, Error **errp)
+void object_property_set_qobject(Object *obj,
+                                 const char *name, QObject *value,
+                                 Error **errp)
 {
     Visitor *v;
 
     v = qobject_input_visitor_new(value);
-    object_property_set(obj, v, name, errp);
+    object_property_set(obj, name, v, errp);
     visit_free(v);
 }
 
@@ -35,7 +36,7 @@ QObject *object_property_get_qobject(Object *obj, const char *name,
     Visitor *v;
 
     v = qobject_output_visitor_new(&ret);
-    object_property_get(obj, v, name, &local_err);
+    object_property_get(obj, name, v, &local_err);
     if (!local_err) {
         visit_complete(v, &ret);
     }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f3ff5d06ca..f6bcad1c07 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -2469,7 +2469,7 @@ static int object_parse_property_opt(Object *obj,
         return 0;
     }
 
-    object_property_parse(obj, value, name, &local_err);
+    object_property_parse(obj, name, value, &local_err);
 
     if (local_err) {
         error_propagate(errp, local_err);
@@ -2817,17 +2817,17 @@ static void create_default_memdev(MachineState *ms, const char *path)
 
     obj = object_new(path ? TYPE_MEMORY_BACKEND_FILE : TYPE_MEMORY_BACKEND_RAM);
     if (path) {
-        object_property_set_str(obj, path, "mem-path", &error_fatal);
+        object_property_set_str(obj, "mem-path", path, &error_fatal);
     }
-    object_property_set_int(obj, ms->ram_size, "size", &error_fatal);
+    object_property_set_int(obj, "size", ms->ram_size, &error_fatal);
     object_property_add_child(object_get_objects_root(), mc->default_ram_id,
                               obj);
     /* Ensure backend's memory region name is equal to mc->default_ram_id */
-    object_property_set_bool(obj, false, "x-use-canonical-path-for-ramblock-id",
-                             &error_fatal);
+    object_property_set_bool(obj, "x-use-canonical-path-for-ramblock-id",
+                             false, &error_fatal);
     user_creatable_complete(USER_CREATABLE(obj), &error_fatal);
     object_unref(obj);
-    object_property_set_str(OBJECT(ms), mc->default_ram_id, "memory-backend",
+    object_property_set_str(OBJECT(ms), "memory-backend", mc->default_ram_id,
                             &error_fatal);
 }
 
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 98fe11ae69..087726a394 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -184,7 +184,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         i = 0;
         while ((name = cpu_model_advertised_features[i++]) != NULL) {
             if (qdict_get(qdict_in, name)) {
-                object_property_set(obj, visitor, name, &err);
+                object_property_set(obj, name, visitor, &err);
                 if (err) {
                     break;
                 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index c69d057df3..dd83cb7f72 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4260,12 +4260,12 @@ static void max_x86_cpu_initfn(Object *obj)
         host_vendor_fms(vendor, &family, &model, &stepping);
         cpu_x86_fill_model_id(model_id);
 
-        object_property_set_str(OBJECT(cpu), vendor, "vendor", &error_abort);
-        object_property_set_int(OBJECT(cpu), family, "family", &error_abort);
-        object_property_set_int(OBJECT(cpu), model, "model", &error_abort);
-        object_property_set_int(OBJECT(cpu), stepping, "stepping",
+        object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
+        object_property_set_int(OBJECT(cpu), "family", family, &error_abort);
+        object_property_set_int(OBJECT(cpu), "model", model, &error_abort);
+        object_property_set_int(OBJECT(cpu), "stepping", stepping,
                                 &error_abort);
-        object_property_set_str(OBJECT(cpu), model_id, "model-id",
+        object_property_set_str(OBJECT(cpu), "model-id", model_id,
                                 &error_abort);
 
         if (kvm_enabled()) {
@@ -4285,20 +4285,20 @@ static void max_x86_cpu_initfn(Object *obj)
         }
 
         if (lmce_supported()) {
-            object_property_set_bool(OBJECT(cpu), true, "lmce", &error_abort);
+            object_property_set_bool(OBJECT(cpu), "lmce", true, &error_abort);
         }
     } else {
-        object_property_set_str(OBJECT(cpu), CPUID_VENDOR_AMD,
-                                "vendor", &error_abort);
-        object_property_set_int(OBJECT(cpu), 6, "family", &error_abort);
-        object_property_set_int(OBJECT(cpu), 6, "model", &error_abort);
-        object_property_set_int(OBJECT(cpu), 3, "stepping", &error_abort);
-        object_property_set_str(OBJECT(cpu),
+        object_property_set_str(OBJECT(cpu), "vendor", CPUID_VENDOR_AMD,
+                                &error_abort);
+        object_property_set_int(OBJECT(cpu), "family", 6, &error_abort);
+        object_property_set_int(OBJECT(cpu), "model", 6, &error_abort);
+        object_property_set_int(OBJECT(cpu), "stepping", 3, &error_abort);
+        object_property_set_str(OBJECT(cpu), "model-id",
                                 "QEMU TCG CPU version " QEMU_HW_VERSION,
-                                "model-id", &error_abort);
+                                &error_abort);
     }
 
-    object_property_set_bool(OBJECT(cpu), true, "pmu", &error_abort);
+    object_property_set_bool(OBJECT(cpu), "pmu", true, &error_abort);
 }
 
 static const TypeInfo max_x86_cpu_type_info = {
@@ -5067,7 +5067,7 @@ static void x86_cpu_apply_props(X86CPU *cpu, PropValue *props)
         if (!pv->value) {
             continue;
         }
-        object_property_parse(OBJECT(cpu), pv->value, pv->prop,
+        object_property_parse(OBJECT(cpu), pv->prop, pv->value,
                               &error_abort);
     }
 }
@@ -5086,7 +5086,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
         PropValue *p;
 
         for (p = vdef->props; p && p->prop; p++) {
-            object_property_parse(OBJECT(cpu), p->value, p->prop,
+            object_property_parse(OBJECT(cpu), p->prop, p->value,
                                   &error_abort);
         }
 
@@ -5117,18 +5117,16 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
      */
 
     /* CPU models only set _minimum_ values for level/xlevel: */
-    object_property_set_uint(OBJECT(cpu), def->level, "min-level",
+    object_property_set_uint(OBJECT(cpu), "min-level", def->level,
                              &error_abort);
-    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel",
+    object_property_set_uint(OBJECT(cpu), "min-xlevel", def->xlevel,
                              &error_abort);
 
-    object_property_set_int(OBJECT(cpu), def->family, "family",
+    object_property_set_int(OBJECT(cpu), "family", def->family, &error_abort);
+    object_property_set_int(OBJECT(cpu), "model", def->model, &error_abort);
+    object_property_set_int(OBJECT(cpu), "stepping", def->stepping,
                             &error_abort);
-    object_property_set_int(OBJECT(cpu), def->model, "model",
-                            &error_abort);
-    object_property_set_int(OBJECT(cpu), def->stepping, "stepping",
-                            &error_abort);
-    object_property_set_str(OBJECT(cpu), def->model_id, "model-id",
+    object_property_set_str(OBJECT(cpu), "model-id", def->model_id,
                             &error_abort);
     for (w = 0; w < FEATURE_WORDS; w++) {
         env->features[w] = def->features[w];
@@ -5166,8 +5164,7 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
         vendor = host_vendor;
     }
 
-    object_property_set_str(OBJECT(cpu), vendor, "vendor",
-                            &error_abort);
+    object_property_set_str(OBJECT(cpu), "vendor", vendor, &error_abort);
 
     x86_cpu_apply_version_props(cpu, model);
 }
@@ -5274,8 +5271,8 @@ static void object_apply_props(Object *obj, QDict *props, Error **errp)
     Error *err = NULL;
 
     for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
-        object_property_set_qobject(obj, qdict_entry_value(prop),
-                                         qdict_entry_key(prop), &err);
+        object_property_set_qobject(obj, qdict_entry_key(prop),
+                                    qdict_entry_value(prop), &err);
         if (err) {
             break;
         }
@@ -6343,7 +6340,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
+        object_property_set_bool(OBJECT(cpu), prop, true, &local_err);
         if (local_err) {
             goto out;
         }
@@ -6351,7 +6348,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 
     for (l = minus_features; l; l = l->next) {
         const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
+        object_property_set_bool(OBJECT(cpu), prop, false, &local_err);
         if (local_err) {
             goto out;
         }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 49212bfd90..7e66822b5d 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -10482,7 +10482,7 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
 
         if (compat_str) {
             char *v = compat_str + strlen("compat=");
-            object_property_set_str(machine, v, "max-cpu-compat", &local_err);
+            object_property_set_str(machine, "max-cpu-compat", v, &local_err);
         }
         g_strfreev(inpieces);
         if (local_err) {
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 65c26c4c86..8ab206186b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -517,7 +517,7 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
             return;
         }
         for (e = qdict_first(qdict); e; e = qdict_next(qdict, e)) {
-            object_property_set(obj, visitor, e->key, &err);
+            object_property_set(obj, e->key, visitor, &err);
             if (err) {
                 break;
             }
diff --git a/ui/console.c b/ui/console.c
index 865fa32635..08f75c9bf6 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1910,7 +1910,7 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
     }
     graphic_console_set_hwops(s, hw_ops, opaque);
     if (dev) {
-        object_property_set_link(OBJECT(s), OBJECT(dev), "device",
+        object_property_set_link(OBJECT(s), "device", OBJECT(dev),
                                  &error_abort);
     }
 
@@ -1937,7 +1937,7 @@ void graphic_console_close(QemuConsole *con)
     }
 
     trace_console_gfx_close(con->index);
-    object_property_set_link(OBJECT(con), NULL, "device", &error_abort);
+    object_property_set_link(OBJECT(con), "device", NULL, &error_abort);
     graphic_console_set_hwops(con, &unused_ops, NULL);
 
     if (con->gl) {
-- 
2.26.2


