Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C61C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:52:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4212073D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9jqgMqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4212073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiYb-0006UM-CK
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifiXZ-0005Xv-5K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifiXY-0001Xi-2u
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifiXX-0001VO-VQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:51:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5K7ONr2rRKoOKjnPt4dYZ5TprIjSuVC0cOky3wXTxE=;
 b=V9jqgMqLbVO7+SZWN7d6RiYUdv7mIES7PW5m3IlmPZQuUjyj3KTkg1uqYH9j37p48F17de
 +RLgU44sI98rUf2d5o+pxm+f5nTZ0z/RwM8dHos35PYaRH3yiMn3yS5dzy0P1vxwRoOx8G
 nEEAgUZzGlSmhsa9epdb9sfWRcRO8jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-X08GZLzuMcqwU-pRKg3hyQ-1; Fri, 13 Dec 2019 05:51:15 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FC45DB60;
 Fri, 13 Dec 2019 10:51:14 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8974210013A1;
 Fri, 13 Dec 2019 10:51:11 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] hw/i386/pc: Convert DPRINTF() to trace events
Date: Fri, 13 Dec 2019 11:50:57 +0100
Message-Id: <20191213105100.8173-2-philmd@redhat.com>
In-Reply-To: <20191213105100.8173-1-philmd@redhat.com>
References: <20191213105100.8173-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: X08GZLzuMcqwU-pRKg3hyQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the deprecated DPRINTF() macro to trace events.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 19 +++++--------------
 hw/i386/trace-events |  6 ++++++
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ac08e63604..66a30cfdf5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -90,16 +90,7 @@
 #include "config-devices.h"
 #include "e820_memory_layout.h"
 #include "fw_cfg.h"
-
-/* debug PC/ISA interrupts */
-//#define DEBUG_IRQ
-
-#ifdef DEBUG_IRQ
-#define DPRINTF(fmt, ...)                                       \
-    do { printf("CPUIRQ: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
=20
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
@@ -348,7 +339,7 @@ void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
=20
-    DPRINTF("pc: %s GSI %d\n", level ? "raising" : "lowering", n);
+    trace_pc_gsi_interrupt(n, level);
     if (n < ISA_NUM_IRQS) {
         qemu_set_irq(s->i8259_irq[n], level);
     }
@@ -426,7 +417,7 @@ static void pic_irq_request(void *opaque, int irq, int =
level)
     CPUState *cs =3D first_cpu;
     X86CPU *cpu =3D X86_CPU(cs);
=20
-    DPRINTF("pic_irqs: %s irq %d\n", level? "raise" : "lower", irq);
+    trace_pc_pic_interrupt(irq, level);
     if (cpu->apic_state && !kvm_irqchip_in_kernel()) {
         CPU_FOREACH(cs) {
             cpu =3D X86_CPU(cs);
@@ -760,7 +751,7 @@ static void port92_write(void *opaque, hwaddr addr, uin=
t64_t val,
     Port92State *s =3D opaque;
     int oldval =3D s->outport;
=20
-    DPRINTF("port92: write 0x%02" PRIx64 "\n", val);
+    trace_port92_write(val);
     s->outport =3D val;
     qemu_set_irq(s->a20_out, (val >> 1) & 1);
     if ((val & 1) && !(oldval & 1)) {
@@ -775,7 +766,7 @@ static uint64_t port92_read(void *opaque, hwaddr addr,
     uint32_t ret;
=20
     ret =3D s->outport;
-    DPRINTF("port92: read 0x%02x\n", ret);
+    trace_port92_read(ret);
     return ret;
 }
=20
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index c8bc464bc5..43f33cf7e2 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -111,3 +111,9 @@ amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"=
PRIx64" lo 0x%"PRIx64
 # vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command:=
 0x%02x func: %p opaque: %p"
 vmport_command(unsigned char command) "command: 0x%02x"
+
+# pc.c
+pc_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
+pc_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
+port92_read(uint8_t val) "port92: read 0x%02x"
+port92_write(uint8_t val) "port92: write 0x%02x"
--=20
2.21.0


