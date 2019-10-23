Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98403CA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:39:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612EC20663
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 18:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf5fRUoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612EC20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNLXK-00071T-US
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 14:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXM-0005jl-MP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXL-0002U4-D5
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28624
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKXL-0002Ts-8B
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eybeycl+Mdd0uyU/fVDKSh323lQWcR1DmZZ34tMwi+A=;
 b=Mf5fRUoXAeQ+9j793NXPMJHtwGu+cDJNX7dYwOtxw5qv2KBYvWcw07ya+DW1ObeVDgjqv7
 a+yAq8oVrevRFJXEaqVebIs0dKGe1LOv05F2zwYUGZD21SnKqDPiG1B3wzCSxWrT8veNMV
 fw8xw3dAVc9dzGX1WjSAsDeEELtnAS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-cm98ngysNjO3AXe0jT2EwQ-1; Wed, 23 Oct 2019 13:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33ADC800D62;
 Wed, 23 Oct 2019 17:35:03 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9CD516061E;
 Wed, 23 Oct 2019 17:34:55 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 27/33] cris: improve passing PIC interrupt vector to the CPU
Date: Wed, 23 Oct 2019 19:31:48 +0200
Message-Id: <20191023173154.30051-28-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: cm98ngysNjO3AXe0jT2EwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
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

Instead of accessing cpu interrupt vector directly from PIC, send the
vector value over the qemu_irq.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/cris/axis_dev88.c  |  4 ----
 hw/intc/etraxfs_pic.c | 26 +-------------------------
 target/cris/cpu.c     |  8 ++++++++
 target/cris/cpu.h     |  1 +
 4 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
index 940c7dd122..be7760476a 100644
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
     memory_region_allocate_system_memory(phys_ram, NULL, "axisdev88.ram",
@@ -297,8 +295,6 @@ void axisdev88_init(MachineState *machine)
=20
=20
     dev =3D qdev_create(NULL, "etraxfs,pic");
-    /* FIXME: Is there a proper way to signal vectors to the CPU core?  */
-    qdev_prop_set_ptr(dev, "interrupt_vector", &env->interrupt_vector);
     qdev_init_nofail(dev);
     s =3D SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(s, 0, 0x3001c000);
diff --git a/hw/intc/etraxfs_pic.c b/hw/intc/etraxfs_pic.c
index 77f652acec..12988c7aa9 100644
--- a/hw/intc/etraxfs_pic.c
+++ b/hw/intc/etraxfs_pic.c
@@ -27,8 +27,6 @@
 #include "qemu/module.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-//#include "pc.h"
-//#include "etraxfs.h"
=20
 #define D(x)
=20
@@ -48,7 +46,6 @@ struct etrax_pic
     SysBusDevice parent_obj;
=20
     MemoryRegion mmio;
-    void *interrupt_vector;
     qemu_irq parent_irq;
     qemu_irq parent_nmi;
     uint32_t regs[R_MAX];
@@ -79,11 +76,7 @@ static void pic_update(struct etrax_pic *fs)
         }
     }
=20
-    if (fs->interrupt_vector) {
-        /* hack alert: ptr property */
-        *(uint32_t*)(fs->interrupt_vector) =3D vector;
-    }
-    qemu_set_irq(fs->parent_irq, !!vector);
+    qemu_set_irq(fs->parent_irq, vector);
 }
=20
 static uint64_t
@@ -163,28 +156,11 @@ static void etraxfs_pic_init(Object *obj)
     sysbus_init_mmio(sbd, &s->mmio);
 }
=20
-static Property etraxfs_pic_properties[] =3D {
-    DEFINE_PROP_PTR("interrupt_vector", struct etrax_pic, interrupt_vector=
),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void etraxfs_pic_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-
-    dc->props =3D etraxfs_pic_properties;
-    /*
-     * Note: pointer property "interrupt_vector" may remain null, thus
-     * no need for dc->user_creatable =3D false;
-     */
-}
-
 static const TypeInfo etraxfs_pic_info =3D {
     .name          =3D TYPE_ETRAX_FS_PIC,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(struct etrax_pic),
     .instance_init =3D etraxfs_pic_init,
-    .class_init    =3D etraxfs_pic_class_init,
 };
=20
 static void etraxfs_pic_register_types(void)
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 7adfd6caf4..6a857f548d 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -147,6 +147,14 @@ static void cris_cpu_set_irq(void *opaque, int irq, in=
t level)
     CPUState *cs =3D CPU(cpu);
     int type =3D irq =3D=3D CRIS_CPU_IRQ ? CPU_INTERRUPT_HARD : CPU_INTERR=
UPT_NMI;
=20
+    if (irq =3D=3D CRIS_CPU_IRQ) {
+        /*
+         * The PIC passes us the vector for the IRQ as the value it sends
+         * over the qemu_irq line
+         */
+        cpu->env.interrupt_vector =3D level;
+    }
+
     if (level) {
         cpu_interrupt(cs, type);
     } else {
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index aba0a66474..a7c2a8e15b 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -34,6 +34,7 @@
 #define CPU_INTERRUPT_NMI       CPU_INTERRUPT_TGT_EXT_3
=20
 /* CRUS CPU device objects interrupt lines.  */
+/* PIC passes the vector for the IRQ as the value of it sends over qemu_ir=
q */
 #define CRIS_CPU_IRQ 0
 #define CRIS_CPU_NMI 1
=20
--=20
2.23.0.606.g08da6496b6


