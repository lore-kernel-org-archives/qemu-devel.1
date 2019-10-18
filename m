Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C2CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:57:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B4882082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 15:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B4882082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUct-0000m4-5V
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 11:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iLUPU-0000qj-Fz
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iLUPT-000763-4p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iLUPQ-00072e-AO; Fri, 18 Oct 2019 11:43:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6390483F45;
 Fri, 18 Oct 2019 15:43:19 +0000 (UTC)
Received: from localhost (ovpn-112-40.ams2.redhat.com [10.36.112.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEDD2600D1;
 Fri, 18 Oct 2019 15:43:17 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/14] cris: replace PROP_PTR with PROP_LINK for interrupt
 vector
Date: Fri, 18 Oct 2019 17:42:06 +0200
Message-Id: <20191018154212.13458-9-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-1-marcandre.lureau@redhat.com>
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 18 Oct 2019 15:43:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using raw interrupt vector pointer, store the associated
CPU with a link property.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/cris/axis_dev88.c  |  4 +---
 hw/intc/Makefile.objs |  2 +-
 hw/intc/etraxfs_pic.c | 18 +++++++-----------
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 940c7dd122..cb7b1b58aa 100644
--- a/hw/cris/axis_dev88.c
+++ b/hw/cris/axis_dev88.c
@@ -253,7 +253,6 @@ void axisdev88_init(MachineState *machine)
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     CRISCPU *cpu;
-    CPUCRISState *env;
     DeviceState *dev;
     SysBusDevice *s;
     DriveInfo *nand;
@@ -267,7 +266,6 @@ void axisdev88_init(MachineState *machine)
=20
     /* init CPUs */
     cpu =3D CRIS_CPU(cpu_create(machine->cpu_type));
-    env =3D &cpu->env;
=20
     /* allocate RAM */
     memory_region_allocate_system_memory(phys_ram, NULL, "axisdev88.ram"=
,
@@ -298,7 +296,7 @@ void axisdev88_init(MachineState *machine)
=20
     dev =3D qdev_create(NULL, "etraxfs,pic");
     /* FIXME: Is there a proper way to signal vectors to the CPU core?  =
*/
-    qdev_prop_set_ptr(dev, "interrupt_vector", &env->interrupt_vector);
+    object_property_set_link(OBJECT(dev), OBJECT(cpu), "cpu", &error_abo=
rt);
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, 0x3001c000);
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index f726d87532..26a3cb36cb 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -5,7 +5,6 @@ common-obj-$(CONFIG_PUV3) +=3D puv3_intc.o
 common-obj-$(CONFIG_XILINX) +=3D xilinx_intc.o
 common-obj-$(CONFIG_XLNX_ZYNQMP_PMU) +=3D xlnx-pmu-iomod-intc.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-ipi.o
-common-obj-$(CONFIG_ETRAXFS) +=3D etraxfs_pic.o
 common-obj-$(CONFIG_IMX) +=3D imx_avic.o imx_gpcv2.o
 common-obj-$(CONFIG_LM32) +=3D lm32_pic.o
 common-obj-$(CONFIG_REALVIEW) +=3D realview_gic.o
@@ -49,3 +48,4 @@ obj-$(CONFIG_ARM_GIC) +=3D arm_gicv3_cpuif.o
 obj-$(CONFIG_MIPS_CPS) +=3D mips_gic.o
 obj-$(CONFIG_NIOS2) +=3D nios2_iic.o
 obj-$(CONFIG_OMPIC) +=3D ompic.o
+obj-$(CONFIG_ETRAXFS) +=3D etraxfs_pic.o
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 77f652acec..8065fc757e 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -27,8 +27,7 @@
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-//#include "pc.h"
-//#include "etraxfs.h"
+#include "target/cris/cpu.h"
=20
 #define D(x)
=20
@@ -48,10 +47,10 @@ struct etrax_pic
     SysBusDevice parent_obj;
=20
     MemoryRegion mmio;
-    void *interrupt_vector;
     qemu_irq parent_irq;
     qemu_irq parent_nmi;
     uint32_t regs[R_MAX];
+    CRISCPU *cpu;
 };
=20
 static void pic_update(struct etrax_pic *fs)
@@ -79,9 +78,10 @@ static void pic_update(struct etrax_pic *fs)
         }
     }
=20
-    if (fs->interrupt_vector) {
-        /* hack alert: ptr property */
-        *(uint32_t*)(fs->interrupt_vector) =3D vector;
+    if (fs->cpu) {
+        /* hack alert: cpu link property */
+        int32_t *int_vec =3D &fs->cpu->env.interrupt_vector;
+        *int_vec =3D (uint32_t)vector;
     }
     qemu_set_irq(fs->parent_irq, !!vector);
 }
@@ -164,7 +164,7 @@ static void etraxfs_pic_init(Object *obj)
 }
=20
 static Property etraxfs_pic_properties[] =3D {
-    DEFINE_PROP_PTR("interrupt_vector", struct etrax_pic, interrupt_vect=
or),
+    DEFINE_PROP_LINK("cpu", struct etrax_pic, cpu, TYPE_CRIS_CPU, CRISCP=
U *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -173,10 +173,6 @@ static void etraxfs_pic_class_init(ObjectClass *klas=
s, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->props =3D etraxfs_pic_properties;
-    /*
-     * Note: pointer property "interrupt_vector" may remain null, thus
-     * no need for dc->user_creatable =3D false;
-     */
 }
=20
 static const TypeInfo etraxfs_pic_info =3D {
--=20
2.23.0.606.g08da6496b6


