Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ADACA9EB9
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9074420650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TpiWZ1hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9074420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNNax-0003Mt-Ct
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 16:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXC-0005U8-C1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iNKXA-0002OJ-Oe
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59311
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iNKXA-0002Nr-KZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 13:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571852096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTsqm6EGzYbEhal4RyEW+fMR+YdqVobEJtdxNWuQUac=;
 b=TpiWZ1hx+1T2vSjxf7z/hBLrdPd9F0WjzMV88N/LfniJ3eQWnRBrKELRCpekun6nH10ufb
 7KjH4osKztqNPFbX/41qSwYyllZFY3smEjrKt8EuYpwxeKfNPO3c84+tS9OoAAQtb/wKJX
 wTO0Ql2eZuTByJVPewipUT3+URXVhK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-WfzHH8vTN1i3z99l4eemvA-1; Wed, 23 Oct 2019 13:34:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D664C5E9;
 Wed, 23 Oct 2019 17:34:49 +0000 (UTC)
Received: from localhost (ovpn-112-21.ams2.redhat.com [10.36.112.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E59B5C1D4;
 Wed, 23 Oct 2019 17:34:44 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 25/33] sparc: move PIL irq handling to cpu.c
Date: Wed, 23 Oct 2019 19:31:46 +0200
Message-Id: <20191023173154.30051-26-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-1-marcandre.lureau@redhat.com>
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: WfzHH8vTN1i3z99l4eemvA-1
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

Rather than tweaking CPU bits from leon3 machine, move it to cpu.c.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/sparc/leon3.c          | 37 -------------------------------------
 hw/sparc/trace-events     |  4 ----
 target/sparc/cpu.c        | 39 +++++++++++++++++++++++++++++++++++++++
 target/sparc/trace-events |  4 ++++
 4 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6db6ea9b5c..fec460f524 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -38,7 +38,6 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
-#include "trace.h"
 #include "exec/address-spaces.h"
=20
 #include "hw/sparc/grlib.h"
@@ -143,41 +142,6 @@ void leon3_irq_ack(void *irq_manager, int intno)
     grlib_irqmp_ack((DeviceState *)irq_manager, intno);
 }
=20
-static void leon3_set_pil_in(void *opaque, int n, int level)
-{
-    CPUSPARCState *env =3D opaque;
-    uint32_t pil_in =3D level;
-    CPUState *cs;
-
-    assert(env !=3D NULL);
-
-    env->pil_in =3D pil_in;
-
-    if (env->pil_in && (env->interrupt_index =3D=3D 0 ||
-                        (env->interrupt_index & ~15) =3D=3D TT_EXTINT)) {
-        unsigned int i;
-
-        for (i =3D 15; i > 0; i--) {
-            if (env->pil_in & (1 << i)) {
-                int old_interrupt =3D env->interrupt_index;
-
-                env->interrupt_index =3D TT_EXTINT | i;
-                if (old_interrupt !=3D env->interrupt_index) {
-                    cs =3D env_cpu(env);
-                    trace_leon3_set_irq(i);
-                    cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-                }
-                break;
-            }
-        }
-    } else if (!env->pil_in && (env->interrupt_index & ~15) =3D=3D TT_EXTI=
NT) {
-        cs =3D env_cpu(env);
-        trace_leon3_reset_irq(env->interrupt_index & 15);
-        env->interrupt_index =3D 0;
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
-    }
-}
-
 static void leon3_generic_hw_init(MachineState *machine)
 {
     ram_addr_t ram_size =3D machine->ram_size;
@@ -226,7 +190,6 @@ static void leon3_generic_hw_init(MachineState *machine=
)
=20
     /* Allocate IRQ manager */
     dev =3D qdev_create(NULL, TYPE_GRLIB_IRQMP);
-    env->pil_irq =3D qemu_allocate_irq(leon3_set_pil_in, env, 0);
     qdev_connect_gpio_out_named(dev, "grlib-irq", 0, env->pil_irq);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_IRQMP_OFFSET);
diff --git a/hw/sparc/trace-events b/hw/sparc/trace-events
index 355b07ae05..0299df24d4 100644
--- a/hw/sparc/trace-events
+++ b/hw/sparc/trace-events
@@ -15,7 +15,3 @@ sun4m_iommu_mem_writel_pgflush(uint32_t val) "page flush =
0x%x"
 sun4m_iommu_page_get_flags(uint64_t pa, uint64_t iopte, uint32_t ret) "get=
 flags addr 0x%"PRIx64" =3D> pte 0x%"PRIx64", *pte =3D 0x%x"
 sun4m_iommu_translate_pa(uint64_t addr, uint64_t pa, uint32_t iopte) "xlat=
e dva 0x%"PRIx64" =3D> pa 0x%"PRIx64" iopte =3D 0x%x"
 sun4m_iommu_bad_addr(uint64_t addr) "bad addr 0x%"PRIx64
-
-# leon3.c
-leon3_set_irq(int intno) "Set CPU IRQ %d"
-leon3_reset_irq(int intno) "Reset CPU IRQ %d"
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bc65929552..693ffef3d1 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -25,6 +25,8 @@
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
+#include "trace.h"
+#include "hw/irq.h"
=20
 //#define DEBUG_FEATURES
=20
@@ -540,6 +542,41 @@ static const sparc_def_t sparc_defs[] =3D {
 #endif
 };
=20
+static void sparc_set_pil_in(void *opaque, int n, int level)
+{
+    CPUSPARCState *env =3D opaque;
+    uint32_t pil_in =3D level;
+    CPUState *cs;
+
+    assert(env !=3D NULL);
+
+    env->pil_in =3D pil_in;
+
+    if (env->pil_in && (env->interrupt_index =3D=3D 0 ||
+                        (env->interrupt_index & ~15) =3D=3D TT_EXTINT)) {
+        unsigned int i;
+
+        for (i =3D 15; i > 0; i--) {
+            if (env->pil_in & (1 << i)) {
+                int old_interrupt =3D env->interrupt_index;
+
+                env->interrupt_index =3D TT_EXTINT | i;
+                if (old_interrupt !=3D env->interrupt_index) {
+                    cs =3D env_cpu(env);
+                    trace_sparc_set_irq(i);
+                    cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+                }
+                break;
+            }
+        }
+    } else if (!env->pil_in && (env->interrupt_index & ~15) =3D=3D TT_EXTI=
NT) {
+        cs =3D env_cpu(env);
+        trace_sparc_reset_irq(env->interrupt_index & 15);
+        env->interrupt_index =3D 0;
+        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    }
+}
+
 static const char * const feature_name[] =3D {
     "float",
     "float128",
@@ -762,6 +799,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error=
 **errp)
     env->version |=3D env->def.nwindows - 1;
 #endif
=20
+    env->pil_irq =3D qemu_allocate_irq(sparc_set_pil_in, env, 0);
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err !=3D NULL) {
         error_propagate(errp, local_err);
diff --git a/target/sparc/trace-events b/target/sparc/trace-events
index 6a064e2327..01c3174067 100644
--- a/target/sparc/trace-events
+++ b/target/sparc/trace-events
@@ -26,3 +26,7 @@ win_helper_no_switch_pstate(uint32_t new_pstate_regs) "ch=
ange_pstate: regs new=3D0
 win_helper_wrpil(uint32_t psrpil, uint32_t new_pil) "old=3D0x%x new=3D0x%x=
"
 win_helper_done(uint32_t tl) "tl=3D%d"
 win_helper_retry(uint32_t tl) "tl=3D%d"
+
+# cpu.c
+sparc_set_irq(int intno) "Set CPU IRQ %d"
+sparc_reset_irq(int intno) "Reset CPU IRQ %d"
--=20
2.23.0.606.g08da6496b6


