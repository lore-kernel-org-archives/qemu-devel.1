Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA82FC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D10206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D10206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIz4C-00006X-8b
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 13:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxRT-0007Ey-Hu
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:07:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iIxRM-0004zM-Da
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:06:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:47994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxRL-0004BR-NW; Fri, 11 Oct 2019 12:06:52 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iIxQc-0003XG-VH; Fri, 11 Oct 2019 19:06:07 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [RFC v5 029/126] tcg: introduce ERRP_AUTO_PROPAGATE
Date: Fri, 11 Oct 2019 19:04:15 +0300
Message-Id: <20191011160552.22907-30-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011160552.22907-1-vsementsov@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Marek Vasut <marex@denx.de>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, armbru@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Greg Kurz <groug@kaod.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
Otherwise, this info will not be added when errp == &fatal_err
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such cases.

If we want to check error after errp-function call, we need to
introduce local_err and than propagate it to errp. Instead, use
ERRP_AUTO_PROPAGATE macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
   &error_fatel, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

This commit (together with its neighbors) was generated by

for f in $(git grep -l errp \*.[ch]); do \
    spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
    --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff $f; \
done;

then fix a bit of compilation problems: coccinelle for some reason
leaves several
f() {
    ...
    goto out;
    ...
    out:
}
patterns, with "out:" at function end.

then
./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"

(auto-msg was a file with this commit message)

Still, for backporting it may be more comfortable to use only the first
command and then do one huge commit.

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 exec.c                          |  21 +++---
 hw/arm/armv7m.c                 |  52 ++++++--------
 hw/arm/smmu-common.c            |   7 +-
 hw/arm/smmuv3.c                 |   7 +-
 hw/cpu/a15mpcore.c              |   7 +-
 hw/cpu/a9mpcore.c               |  27 +++----
 hw/cpu/arm11mpcore.c            |  22 +++---
 hw/i386/pc.c                    | 120 +++++++++++++-------------------
 hw/intc/nios2_iic.c             |   6 +-
 hw/mips/cps.c                   |  46 ++++++------
 hw/riscv/riscv_hart.c           |   7 +-
 hw/riscv/sifive_e.c             |   7 +-
 hw/riscv/sifive_u.c             |  11 ++-
 hw/sd/milkymist-memcard.c       |  11 +--
 target/alpha/cpu.c              |   7 +-
 target/arm/cpu.c                |   7 +-
 target/arm/cpu64.c              |  11 ++-
 target/cris/cpu.c               |   7 +-
 target/hppa/cpu.c               |   7 +-
 target/i386/cpu.c               | 117 ++++++++++++++-----------------
 target/lm32/cpu.c               |   7 +-
 target/m68k/cpu.c               |   7 +-
 target/microblaze/cpu.c         |   7 +-
 target/mips/cpu.c               |   7 +-
 target/moxie/cpu.c              |   7 +-
 target/nios2/cpu.c              |   7 +-
 target/openrisc/cpu.c           |   7 +-
 target/ppc/compat.c             |  20 +++---
 target/ppc/translate_init.inc.c |  26 +++----
 target/riscv/cpu.c              |   7 +-
 target/sh4/cpu.c                |   7 +-
 target/sparc/cpu.c              |  14 ++--
 target/tricore/cpu.c            |   7 +-
 target/unicore32/cpu.c          |   7 +-
 target/xtensa/cpu.c             |   7 +-
 35 files changed, 280 insertions(+), 371 deletions(-)

diff --git a/exec.c b/exec.c
index bdcfcdff3f..2dc17769f7 100644
--- a/exec.c
+++ b/exec.c
@@ -2239,10 +2239,10 @@ static void dirty_memory_extend(ram_addr_t old_ram_size,
 
 static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 {
+    ERRP_AUTO_PROPAGATE();
     RAMBlock *block;
     RAMBlock *last_block = NULL;
     ram_addr_t old_ram_size, new_ram_size;
-    Error *err = NULL;
 
     old_ram_size = last_ram_page();
 
@@ -2252,9 +2252,8 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
     if (!new_block->host) {
         if (xen_enabled()) {
             xen_ram_alloc(new_block->offset, new_block->max_length,
-                          new_block->mr, &err);
-            if (err) {
-                error_propagate(errp, err);
+                          new_block->mr, errp);
+            if (*errp) {
                 qemu_mutex_unlock_ramlist();
                 return;
             }
@@ -2319,8 +2318,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
                                  uint32_t ram_flags, int fd,
                                  Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     RAMBlock *new_block;
-    Error *local_err = NULL;
     int64_t file_size;
 
     /* Just support these ram flags by now. */
@@ -2368,10 +2367,9 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    ram_block_add(new_block, &local_err, ram_flags & RAM_SHARED);
-    if (local_err) {
+    ram_block_add(new_block, errp, ram_flags & RAM_SHARED);
+    if (*errp) {
         g_free(new_block);
-        error_propagate(errp, local_err);
         return NULL;
     }
     return new_block;
@@ -2413,8 +2411,8 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
                                   void *host, bool resizeable, bool share,
                                   MemoryRegion *mr, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     RAMBlock *new_block;
-    Error *local_err = NULL;
 
     size = HOST_PAGE_ALIGN(size);
     max_size = HOST_PAGE_ALIGN(max_size);
@@ -2433,10 +2431,9 @@ RAMBlock *qemu_ram_alloc_internal(ram_addr_t size, ram_addr_t max_size,
     if (resizeable) {
         new_block->flags |= RAM_RESIZEABLE;
     }
-    ram_block_add(new_block, &local_err, share);
-    if (local_err) {
+    ram_block_add(new_block, errp, share);
+    if (*errp) {
         g_free(new_block);
-        error_propagate(errp, local_err);
         return NULL;
     }
     return new_block;
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7a3c48f002..1a738789de 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -148,9 +148,9 @@ static void armv7m_instance_init(Object *obj)
 
 static void armv7m_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     ARMv7MState *s = ARMV7M(dev);
     SysBusDevice *sbd;
-    Error *err = NULL;
     int i;
 
     if (!s->board_memory) {
@@ -161,50 +161,44 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
 
     s->cpu = ARM_CPU(object_new_with_props(s->cpu_type, OBJECT(s), "cpu",
-                                           &err, NULL));
-    if (err != NULL) {
-        error_propagate(errp, err);
+                                           errp, NULL));
+    if (*errp) {
         return;
     }
 
     object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
                              &error_abort);
     if (object_property_find(OBJECT(s->cpu), "idau", NULL)) {
-        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_link(OBJECT(s->cpu), s->idau, "idau", errp);
+        if (*errp) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "init-svtor", NULL)) {
         object_property_set_uint(OBJECT(s->cpu), s->init_svtor,
-                                 "init-svtor", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+                                 "init-svtor", errp);
+        if (*errp) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "start-powered-off", NULL)) {
         object_property_set_bool(OBJECT(s->cpu), s->start_powered_off,
-                                 "start-powered-off", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+                                 "start-powered-off", errp);
+        if (*errp) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "vfp", NULL)) {
         object_property_set_bool(OBJECT(s->cpu), s->vfp,
-                                 "vfp", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+                                 "vfp", errp);
+        if (*errp) {
             return;
         }
     }
     if (object_property_find(OBJECT(s->cpu), "dsp", NULL)) {
         object_property_set_bool(OBJECT(s->cpu), s->dsp,
-                                 "dsp", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+                                 "dsp", errp);
+        if (*errp) {
             return;
         }
     }
@@ -216,16 +210,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
     s->cpu->env.nvic = &s->nvic;
     s->nvic.cpu = s->cpu;
 
-    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(s->cpu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     /* Note that we must realize the NVIC after the CPU */
-    object_property_set_bool(OBJECT(&s->nvic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->nvic), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -250,16 +242,14 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
             Object *obj = OBJECT(&s->bitband[i]);
             SysBusDevice *sbd = SYS_BUS_DEVICE(&s->bitband[i]);
 
-            object_property_set_int(obj, bitband_input_addr[i], "base", &err);
-            if (err != NULL) {
-                error_propagate(errp, err);
+            object_property_set_int(obj, bitband_input_addr[i], "base", errp);
+            if (*errp) {
                 return;
             }
             object_property_set_link(obj, OBJECT(s->board_memory),
                                      "source-memory", &error_abort);
-            object_property_set_bool(obj, true, "realized", &err);
-            if (err != NULL) {
-                error_propagate(errp, err);
+            object_property_set_bool(obj, true, "realized", errp);
+            if (*errp) {
                 return;
             }
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 245817d23e..b89d72db08 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -421,13 +421,12 @@ void smmu_inv_notifiers_all(SMMUState *s)
 
 static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SMMUState *s = ARM_SMMU(dev);
     SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    sbc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    sbc->parent_realize(dev, errp);
+    if (*errp) {
         return;
     }
     s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index e2fbb8357e..d6ffd3a665 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1385,15 +1385,14 @@ static void smmu_reset(DeviceState *dev)
 
 static void smmu_realize(DeviceState *d, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SMMUState *sys = ARM_SMMU(d);
     SMMUv3State *s = ARM_SMMUV3(sys);
     SMMUv3Class *c = ARM_SMMUV3_GET_CLASS(s);
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
-    Error *local_err = NULL;
 
-    c->parent_realize(d, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    c->parent_realize(d, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 7e9983aa19..d010be7476 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -49,12 +49,12 @@ static void a15mp_priv_initfn(Object *obj)
 
 static void a15mp_priv_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     A15MPPrivState *s = A15MPCORE_PRIV(dev);
     DeviceState *gicdev;
     SysBusDevice *busdev;
     int i;
-    Error *err = NULL;
     bool has_el3;
     bool has_el2 = false;
     Object *cpuobj;
@@ -77,9 +77,8 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
     }
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (*errp) {
         return;
     }
     busdev = SYS_BUS_DEVICE(&s->gic);
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 6872a3a00a..9a66401cdd 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -46,21 +46,20 @@ static void a9mp_priv_initfn(Object *obj)
 
 static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     A9MPPrivState *s = A9MPCORE_PRIV(dev);
     DeviceState *scudev, *gicdev, *gtimerdev, *mptimerdev, *wdtdev;
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
-    Error *err = NULL;
     int i;
     bool has_el3;
     Object *cpuobj;
 
     scudev = DEVICE(&s->scu);
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->scu), true, "realized", errp);
+    if (*errp) {
         return;
     }
     scubusdev = SYS_BUS_DEVICE(&s->scu);
@@ -77,9 +76,8 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
         object_property_get_bool(cpuobj, "has_el3", &error_abort);
     qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
 
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (*errp) {
         return;
     }
     gicbusdev = SYS_BUS_DEVICE(&s->gic);
@@ -92,27 +90,24 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->gtimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gtimer), true, "realized", errp);
+    if (*errp) {
         return;
     }
     gtimerbusdev = SYS_BUS_DEVICE(&s->gtimer);
 
     mptimerdev = DEVICE(&s->mptimer);
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", errp);
+    if (*errp) {
         return;
     }
     mptimerbusdev = SYS_BUS_DEVICE(&s->mptimer);
 
     wdtdev = DEVICE(&s->wdt);
     qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->wdt), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->wdt), true, "realized", errp);
+    if (*errp) {
         return;
     }
     wdtbusdev = SYS_BUS_DEVICE(&s->wdt);
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index e78f5d080c..21c2fa6289 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -69,26 +69,24 @@ static void mpcore_priv_map_setup(ARM11MPCorePriveState *s)
 
 static void mpcore_priv_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     ARM11MPCorePriveState *s = ARM11MPCORE_PRIV(dev);
     DeviceState *scudev = DEVICE(&s->scu);
     DeviceState *gicdev = DEVICE(&s->gic);
     DeviceState *mptimerdev = DEVICE(&s->mptimer);
     DeviceState *wdtimerdev = DEVICE(&s->wdtimer);
-    Error *err = NULL;
 
     qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->scu), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->scu), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -99,16 +97,14 @@ static void mpcore_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, mpcore_priv_set_irq, s->num_irq - 32);
 
     qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->mptimer), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
     qdev_prop_set_uint32(wdtimerdev, "num-cpu", s->num_cpu);
-    object_property_set_bool(OBJECT(&s->wdtimer), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->wdtimer), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bcda50efcc..bd94cff454 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1376,8 +1376,8 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level)
 
 static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     Object *cpu = NULL;
-    Error *local_err = NULL;
     CPUX86State *env = NULL;
 
     cpu = object_new(MACHINE(pcms)->cpu_type);
@@ -1385,11 +1385,10 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
     env = &X86_CPU(cpu)->env;
     env->nr_dies = pcms->smp_dies;
 
-    object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
-    object_property_set_bool(cpu, true, "realized", &local_err);
+    object_property_set_uint(cpu, apic_id, "apic-id", errp);
+    object_property_set_bool(cpu, true, "realized", errp);
 
     object_unref(cpu);
-    error_propagate(errp, local_err);
 }
 
 /*
@@ -1474,9 +1473,9 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
 
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PCMachineState *pcms = PC_MACHINE(ms);
     int64_t apic_id = x86_cpu_apic_id_from_index(pcms, id);
-    Error *local_err = NULL;
 
     if (id < 0) {
         error_setg(errp, "Invalid CPU id: %" PRIi64, id);
@@ -1490,9 +1489,8 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
         return;
     }
 
-    pc_new_cpu(PC_MACHINE(ms), apic_id, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    pc_new_cpu(PC_MACHINE(ms), apic_id, errp);
+    if (*errp) {
         return;
     }
 }
@@ -1990,12 +1988,12 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
 static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                                Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     const PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     const MachineState *ms = MACHINE(hotplug_dev);
     const bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
     const uint64_t legacy_align = TARGET_PAGE_SIZE;
-    Error *local_err = NULL;
 
     /*
      * When -no-acpi is used with Q35 machine type, no ACPI is built,
@@ -2013,9 +2011,8 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    hotplug_handler_pre_plug(pcms->acpi_dev, dev, errp);
+    if (*errp) {
         return;
     }
 
@@ -2026,14 +2023,14 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 static void pc_memory_plug(HotplugHandler *hotplug_dev,
                            DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
     MachineState *ms = MACHINE(hotplug_dev);
     bool is_nvdimm = object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM);
 
-    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), &local_err);
-    if (local_err) {
-        goto out;
+    pc_dimm_plug(PC_DIMM(dev), MACHINE(pcms), errp);
+    if (*errp) {
+        return;
     }
 
     if (is_nvdimm) {
@@ -2041,14 +2038,12 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
     }
 
     hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &error_abort);
-out:
-    error_propagate(errp, local_err);
 }
 
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     /*
@@ -2057,38 +2052,34 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
      * addition to cover this case.
      */
     if (!pcms->acpi_dev || !acpi_enabled) {
-        error_setg(&local_err,
+        error_setg(errp,
                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
-        goto out;
+        return;
     }
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
-        error_setg(&local_err,
+        error_setg(errp,
                    "nvdimm device hot unplug is not supported yet.");
-        goto out;
+        return;
     }
 
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
-                                   &local_err);
-out:
-    error_propagate(errp, local_err);
+                                   errp);
 }
 
 static void pc_memory_unplug(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    Error *local_err = NULL;
 
-    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-    if (local_err) {
-        goto out;
+    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, errp);
+    if (*errp) {
+        return;
     }
 
     pc_dimm_unplug(PC_DIMM(dev), MACHINE(pcms));
     object_property_set_bool(OBJECT(dev), false, "realized", NULL);
- out:
-    error_propagate(errp, local_err);
 }
 
 static int pc_apic_cmp(const void *a, const void *b)
@@ -2120,15 +2111,15 @@ static CPUArchId *pc_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
 static void pc_cpu_plug(HotplugHandler *hotplug_dev,
                         DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUArchId *found_cpu;
-    Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (pcms->acpi_dev) {
-        hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-        if (local_err) {
-            goto out;
+        hotplug_handler_plug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, errp);
+        if (*errp) {
+            return;
         }
     }
 
@@ -2143,51 +2134,46 @@ static void pc_cpu_plug(HotplugHandler *hotplug_dev,
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
     found_cpu->cpu = OBJECT(dev);
-out:
-    error_propagate(errp, local_err);
 }
 static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     int idx = -1;
-    Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (!pcms->acpi_dev) {
-        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
-        goto out;
+        error_setg(errp, "CPU hot unplug not supported without ACPI");
+        return;
     }
 
     pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     assert(idx != -1);
     if (idx == 0) {
-        error_setg(&local_err, "Boot CPU is unpluggable");
-        goto out;
+        error_setg(errp, "Boot CPU is unpluggable");
+        return;
     }
 
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
-                                   &local_err);
-    if (local_err) {
-        goto out;
+                                   errp);
+    if (*errp) {
+        return;
     }
 
- out:
-    error_propagate(errp, local_err);
-
 }
 
 static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
                              DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUArchId *found_cpu;
-    Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
-    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, &local_err);
-    if (local_err) {
-        goto out;
+    hotplug_handler_unplug(HOTPLUG_HANDLER(pcms->acpi_dev), dev, errp);
+    if (*errp) {
+        return;
     }
 
     found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
@@ -2199,8 +2185,6 @@ static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
     /* Update the number of CPUs in CMOS */
     rtc_set_cpus_count(pcms->rtc, pcms->boot_cpus);
     fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
- out:
-    error_propagate(errp, local_err);
 }
 
 static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
@@ -2353,8 +2337,8 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
 static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
-    Error *local_err = NULL;
 
     if (!hotplug_dev2) {
         /*
@@ -2370,18 +2354,17 @@ static void pc_virtio_pmem_pci_pre_plug(HotplugHandler *hotplug_dev,
      * succeeds, branch of to the actual hotplug handler.
      */
     memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NULL,
-                           &local_err);
-    if (!local_err) {
-        hotplug_handler_pre_plug(hotplug_dev2, dev, &local_err);
+                           errp);
+    if (!*errp) {
+        hotplug_handler_pre_plug(hotplug_dev2, dev, errp);
     }
-    error_propagate(errp, local_err);
 }
 
 static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
                                     DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     HotplugHandler *hotplug_dev2 = qdev_get_bus_hotplug_handler(dev);
-    Error *local_err = NULL;
 
     /*
      * Plug the memory device first and then branch off to the actual
@@ -2389,11 +2372,10 @@ static void pc_virtio_pmem_pci_plug(HotplugHandler *hotplug_dev,
      * device bits.
      */
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
-    hotplug_handler_plug(hotplug_dev2, dev, &local_err);
-    if (local_err) {
+    hotplug_handler_plug(hotplug_dev2, dev, errp);
+    if (*errp) {
         memory_device_unplug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
     }
-    error_propagate(errp, local_err);
 }
 
 static void pc_virtio_pmem_pci_unplug_request(HotplugHandler *hotplug_dev,
@@ -2504,20 +2486,18 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
                                             const char *name, void *opaque,
                                             Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PCMachineState *pcms = PC_MACHINE(obj);
-    Error *error = NULL;
     uint64_t value;
 
-    visit_type_size(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
+    visit_type_size(v, name, &value, errp);
+    if (*errp) {
         return;
     }
     if (value > 4 * GiB) {
-        error_setg(&error,
+        error_setg(errp,
                    "Machine option 'max-ram-below-4g=%"PRIu64
                    "' expects size less than or equal to 4G", value);
-        error_propagate(errp, error);
         return;
     }
 
diff --git a/hw/intc/nios2_iic.c b/hw/intc/nios2_iic.c
index 3a5d86c2a4..a291536bbe 100644
--- a/hw/intc/nios2_iic.c
+++ b/hw/intc/nios2_iic.c
@@ -65,13 +65,13 @@ static void altera_iic_init(Object *obj)
 
 static void altera_iic_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     struct AlteraIIC *pv = ALTERA_IIC(dev);
-    Error *err = NULL;
 
-    pv->cpu = object_property_get_link(OBJECT(dev), "cpu", &err);
+    pv->cpu = object_property_get_link(OBJECT(dev), "cpu", errp);
     if (!pv->cpu) {
         error_setg(errp, "altera,iic: CPU link not found: %s",
-                   error_get_pretty(err));
+                   error_get_pretty(*errp));
         return;
     }
 }
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 1660f86908..0ea7959193 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -67,11 +67,11 @@ static bool cpu_mips_itu_supported(CPUMIPSState *env)
 
 static void mips_cps_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MIPSCPSState *s = MIPS_CPS(dev);
     CPUMIPSState *env;
     MIPSCPU *cpu;
     int i;
-    Error *err = NULL;
     target_ulong gcr_base;
     bool itu_present = false;
     bool saar_present = false;
@@ -101,16 +101,15 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     if (itu_present) {
         sysbus_init_child_obj(OBJECT(dev), "itu", &s->itu, sizeof(s->itu),
                               TYPE_MIPS_ITU);
-        object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", &err);
-        object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", &err);
+        object_property_set_int(OBJECT(&s->itu), 16, "num-fifo", errp);
+        object_property_set_int(OBJECT(&s->itu), 16, "num-semaphores", errp);
         object_property_set_bool(OBJECT(&s->itu), saar_present, "saar-present",
-                                 &err);
+                                 errp);
         if (saar_present) {
             qdev_prop_set_ptr(DEVICE(&s->itu), "saar", (void *)&env->CP0_SAAR);
         }
-        object_property_set_bool(OBJECT(&s->itu), true, "realized", &err);
-        if (err != NULL) {
-            error_propagate(errp, err);
+        object_property_set_bool(OBJECT(&s->itu), true, "realized", errp);
+        if (*errp) {
             return;
         }
 
@@ -121,11 +120,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Cluster Power Controller */
     sysbus_init_child_obj(OBJECT(dev), "cpc", &s->cpc, sizeof(s->cpc),
                           TYPE_MIPS_CPC);
-    object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", &err);
-    object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", &err);
-    object_property_set_bool(OBJECT(&s->cpc), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_int(OBJECT(&s->cpc), s->num_vp, "num-vp", errp);
+    object_property_set_int(OBJECT(&s->cpc), 1, "vp-start-running", errp);
+    object_property_set_bool(OBJECT(&s->cpc), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -135,11 +133,10 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Global Interrupt Controller */
     sysbus_init_child_obj(OBJECT(dev), "gic", &s->gic, sizeof(s->gic),
                           TYPE_MIPS_GIC);
-    object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp", &err);
-    object_property_set_int(OBJECT(&s->gic), 128, "num-irq", &err);
-    object_property_set_bool(OBJECT(&s->gic), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_int(OBJECT(&s->gic), s->num_vp, "num-vp", errp);
+    object_property_set_int(OBJECT(&s->gic), 128, "num-irq", errp);
+    object_property_set_bool(OBJECT(&s->gic), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
@@ -151,14 +148,13 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_child_obj(OBJECT(dev), "gcr", &s->gcr, sizeof(s->gcr),
                           TYPE_MIPS_GCR);
-    object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", &err);
-    object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", &err);
-    object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", &err);
-    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic", &err);
-    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc", &err);
-    object_property_set_bool(OBJECT(&s->gcr), true, "realized", &err);
-    if (err != NULL) {
-        error_propagate(errp, err);
+    object_property_set_int(OBJECT(&s->gcr), s->num_vp, "num-vp", errp);
+    object_property_set_int(OBJECT(&s->gcr), 0x800, "gcr-rev", errp);
+    object_property_set_int(OBJECT(&s->gcr), gcr_base, "gcr-base", errp);
+    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->gic.mr), "gic", errp);
+    object_property_set_link(OBJECT(&s->gcr), OBJECT(&s->cpc.mr), "cpc", errp);
+    object_property_set_bool(OBJECT(&s->gcr), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index 5b98227db6..4c83693e48 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -43,7 +43,7 @@ static void riscv_harts_cpu_reset(void *opaque)
 static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
                                char *cpu_type, Error **errp)
 {
-    Error *err = NULL;
+    ERRP_AUTO_PROPAGATE();
 
     object_initialize_child(OBJECT(s), "harts[*]", &s->harts[idx],
                             sizeof(RISCVCPU), cpu_type,
@@ -51,9 +51,8 @@ static void riscv_hart_realize(RISCVHartArrayState *s, int idx,
     s->harts[idx].env.mhartid = s->hartid_base + idx;
     qemu_register_reset(riscv_harts_cpu_reset, &s->harts[idx]);
     object_property_set_bool(OBJECT(&s->harts[idx]), true,
-                             "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+                             "realized", errp);
+    if (*errp) {
         return;
     }
 }
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0f9d641a0e..fbac83c684 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -134,9 +134,9 @@ static void riscv_sifive_e_soc_init(Object *obj)
 
 static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MachineState *ms = MACHINE(qdev_get_machine());
     const struct MemmapEntry *memmap = sifive_e_memmap;
-    Error *err = NULL;
 
     SiFiveESoCState *s = RISCV_E_SOC(dev);
     MemoryRegion *sys_mem = get_system_memory();
@@ -171,9 +171,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     /* GPIO */
 
-    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", errp);
+    if (*errp) {
         return;
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 9f8e84bf2e..ab30e78969 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -426,6 +426,7 @@ static void riscv_sifive_u_soc_init(Object *obj)
 
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MachineState *ms = MACHINE(qdev_get_machine());
     SiFiveUSoCState *s = RISCV_U_SOC(dev);
     const struct MemmapEntry *memmap = sifive_u_memmap;
@@ -435,7 +436,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
-    Error *err = NULL;
     NICInfo *nd = &nd_table[0];
 
     object_property_set_bool(OBJECT(&s->e_cpus), true, "realized",
@@ -493,10 +493,10 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
 
-    object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
+    object_property_set_bool(OBJECT(&s->prci), true, "realized", errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
 
-    object_property_set_bool(OBJECT(&s->otp), true, "realized", &err);
+    object_property_set_bool(OBJECT(&s->otp), true, "realized", errp);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
     for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
@@ -509,9 +509,8 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     object_property_set_int(OBJECT(&s->gem), GEM_REVISION, "revision",
                             &error_abort);
-    object_property_set_bool(OBJECT(&s->gem), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
+    object_property_set_bool(OBJECT(&s->gem), true, "realized", errp);
+    if (*errp) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 926e1af475..0aee7abc69 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -265,11 +265,11 @@ static void milkymist_memcard_init(Object *obj)
 
 static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     MilkymistMemcardState *s = MILKYMIST_MEMCARD(dev);
     DeviceState *carddev;
     BlockBackend *blk;
     DriveInfo *dinfo;
-    Error *err = NULL;
 
     qbus_create_inplace(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS,
                         dev, "sd-bus");
@@ -279,10 +279,11 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_create(BUS(&s->sdbus), TYPE_SD_CARD);
-    qdev_prop_set_drive(carddev, "drive", blk, &err);
-    object_property_set_bool(OBJECT(carddev), true, "realized", &err);
-    if (err) {
-        error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
+    qdev_prop_set_drive(carddev, "drive", blk, errp);
+    object_property_set_bool(OBJECT(carddev), true, "realized", errp);
+    if (*errp) {
+        error_setg(errp, "failed to init SD card: %s",
+                   error_get_pretty(*errp));
         return;
     }
     s->enabled = blk && blk_is_inserted(blk);
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index b3fd6643e8..f093783c34 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -56,13 +56,12 @@ static void alpha_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     AlphaCPUClass *acc = ALPHA_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 2399c14471..07b4bbe82b 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1200,12 +1200,12 @@ static void arm_cpu_finalizefn(Object *obj)
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     ARMCPU *cpu = ARM_CPU(dev);
     ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
     CPUARMState *env = &cpu->env;
     int pagebits;
-    Error *local_err = NULL;
     bool no_aa32 = false;
 
     /* If we needed to query the host kernel for the CPU features
@@ -1248,9 +1248,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                           arm_gt_stimer_cb, cpu);
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d7f5bf610a..15a96e68be 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -266,17 +266,16 @@ static void cpu_max_get_sve_vq(Object *obj, Visitor *v, const char *name,
 static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     ARMCPU *cpu = ARM_CPU(obj);
-    Error *err = NULL;
 
-    visit_type_uint32(v, name, &cpu->sve_max_vq, &err);
+    visit_type_uint32(v, name, &cpu->sve_max_vq, errp);
 
-    if (!err && (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ)) {
-        error_setg(&err, "unsupported SVE vector length");
-        error_append_hint(&err, "Valid sve-max-vq in range [1-%d]\n",
+    if (!*errp && (cpu->sve_max_vq == 0 || cpu->sve_max_vq > ARM_MAX_VQ)) {
+        error_setg(errp, "unsupported SVE vector length");
+        error_append_hint(errp, "Valid sve-max-vq in range [1-%d]\n",
                           ARM_MAX_VQ);
     }
-    error_propagate(errp, err);
 }
 
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 7adfd6caf4..296b68dff6 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -124,13 +124,12 @@ void cris_cpu_list(void)
 
 static void cris_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 71b6aca45d..f6f2e3980c 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -89,13 +89,12 @@ static void hppa_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
 
 static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     HPPACPUClass *acc = HPPA_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 44f1bbdcac..4e350906cb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3391,16 +3391,15 @@ static void x86_cpuid_version_set_family(Object *obj, Visitor *v,
                                          const char *name, void *opaque,
                                          Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xff + 0xf;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (*errp) {
         return;
     }
     if (value < min || value > max) {
@@ -3434,16 +3433,15 @@ static void x86_cpuid_version_set_model(Object *obj, Visitor *v,
                                         const char *name, void *opaque,
                                         Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xff;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (*errp) {
         return;
     }
     if (value < min || value > max) {
@@ -3472,16 +3470,15 @@ static void x86_cpuid_version_set_stepping(Object *obj, Visitor *v,
                                            const char *name, void *opaque,
                                            Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *cpu = X86_CPU(obj);
     CPUX86State *env = &cpu->env;
     const int64_t min = 0;
     const int64_t max = 0xf;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (*errp) {
         return;
     }
     if (value < min || value > max) {
@@ -3578,15 +3575,14 @@ static void x86_cpuid_get_tsc_freq(Object *obj, Visitor *v, const char *name,
 static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
                                    void *opaque, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *cpu = X86_CPU(obj);
     const int64_t min = 0;
     const int64_t max = INT64_MAX;
-    Error *local_err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_int(v, name, &value, errp);
+    if (*errp) {
         return;
     }
     if (value < min || value > max) {
@@ -4247,49 +4243,46 @@ static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
 
 static void object_apply_props(Object *obj, QDict *props, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const QDictEntry *prop;
-    Error *err = NULL;
 
     for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
         object_property_set_qobject(obj, qdict_entry_value(prop),
-                                         qdict_entry_key(prop), &err);
-        if (err) {
+                                         qdict_entry_key(prop), errp);
+        if (*errp) {
             break;
         }
     }
-
-    error_propagate(errp, err);
 }
 
 /* Create X86CPU object according to model+props specification */
 static X86CPU *x86_cpu_from_model(const char *model, QDict *props, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *xc = NULL;
     X86CPUClass *xcc;
-    Error *err = NULL;
 
     xcc = X86_CPU_CLASS(cpu_class_by_name(TYPE_X86_CPU, model));
     if (xcc == NULL) {
-        error_setg(&err, "CPU model '%s' not found", model);
+        error_setg(errp, "CPU model '%s' not found", model);
         goto out;
     }
 
     xc = X86_CPU(object_new(object_class_get_name(OBJECT_CLASS(xcc))));
     if (props) {
-        object_apply_props(OBJECT(xc), props, &err);
-        if (err) {
+        object_apply_props(OBJECT(xc), props, errp);
+        if (*errp) {
             goto out;
         }
     }
 
-    x86_cpu_expand_features(xc, &err);
-    if (err) {
+    x86_cpu_expand_features(xc, errp);
+    if (*errp) {
         goto out;
     }
 
 out:
-    if (err) {
-        error_propagate(errp, err);
+    if (*errp) {
         object_unref(OBJECT(xc));
         xc = NULL;
     }
@@ -4301,8 +4294,8 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
                                                       CpuModelInfo *model,
                                                       Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *xc = NULL;
-    Error *err = NULL;
     CpuModelExpansionInfo *ret = g_new0(CpuModelExpansionInfo, 1);
     QDict *props = NULL;
     const char *base_name;
@@ -4310,8 +4303,8 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
     xc = x86_cpu_from_model(model->name,
                             model->has_props ?
                                 qobject_to(QDict, model->props) :
-                                NULL, &err);
-    if (err) {
+                                NULL, errp);
+    if (*errp) {
         goto out;
     }
 
@@ -4335,7 +4328,7 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         x86_cpu_to_dict_full(xc, props);
     break;
     default:
-        error_setg(&err, "Unsupported expansion type");
+        error_setg(errp, "Unsupported expansion type");
         goto out;
     }
 
@@ -4345,8 +4338,7 @@ qmp_query_cpu_model_expansion(CpuModelExpansionType type,
 
 out:
     object_unref(OBJECT(xc));
-    if (err) {
-        error_propagate(errp, err);
+    if (*errp) {
         qapi_free_CpuModelExpansionInfo(ret);
         ret = NULL;
     }
@@ -5297,24 +5289,24 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
  */
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUX86State *env = &cpu->env;
     FeatureWord w;
     int i;
     GList *l;
-    Error *local_err = NULL;
 
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
-        if (local_err) {
+        object_property_set_bool(OBJECT(cpu), true, prop, errp);
+        if (*errp) {
             goto out;
         }
     }
 
     for (l = minus_features; l; l = l->next) {
         const char *prop = l->data;
-        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
-        if (local_err) {
+        object_property_set_bool(OBJECT(cpu), false, prop, errp);
+        if (*errp) {
             goto out;
         }
     }
@@ -5410,8 +5402,7 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     }
 
 out:
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    if (*errp) {
     }
 }
 
@@ -5471,17 +5462,17 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
 
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     X86CPU *cpu = X86_CPU(dev);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
     CPUX86State *env = &cpu->env;
-    Error *local_err = NULL;
     static bool ht_warned;
 
     if (xcc->host_cpuid_required) {
         if (!accel_uses_host_cpuid()) {
             char *name = x86_cpu_class_get_model_name(xcc);
-            error_setg(&local_err, "CPU model '%s' requires KVM", name);
+            error_setg(errp, "CPU model '%s' requires KVM", name);
             g_free(name);
             goto out;
         }
@@ -5502,15 +5493,15 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    x86_cpu_expand_features(cpu, &local_err);
-    if (local_err) {
+    x86_cpu_expand_features(cpu, errp);
+    if (*errp) {
         goto out;
     }
 
     x86_cpu_filter_features(cpu, cpu->check_cpuid || cpu->enforce_cpuid);
 
     if (cpu->enforce_cpuid && x86_cpu_have_filtered_features(cpu)) {
-        error_setg(&local_err,
+        error_setg(errp,
                    accel_uses_host_cpuid() ?
                        "Host doesn't support requested features" :
                        "TCG doesn't support requested features");
@@ -5625,9 +5616,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
@@ -5636,8 +5626,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
 
     if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
-        x86_cpu_apic_create(cpu, &local_err);
-        if (local_err != NULL) {
+        x86_cpu_apic_create(cpu, errp);
+        if (*errp) {
             goto out;
         }
     }
@@ -5694,26 +5684,25 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             ht_warned = true;
     }
 
-    x86_cpu_apic_realize(cpu, &local_err);
-    if (local_err != NULL) {
+    x86_cpu_apic_realize(cpu, errp);
+    if (*errp) {
         goto out;
     }
     cpu_reset(cs);
 
-    xcc->parent_realize(dev, &local_err);
+    xcc->parent_realize(dev, errp);
 
 out:
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    if (*errp) {
         return;
     }
 }
 
 static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     X86CPU *cpu = X86_CPU(dev);
     X86CPUClass *xcc = X86_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
     cpu_remove_sync(CPU(dev));
@@ -5725,9 +5714,8 @@ static void x86_cpu_unrealizefn(DeviceState *dev, Error **errp)
         cpu->apic_state = NULL;
     }
 
-    xcc->parent_unrealize(dev, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    xcc->parent_unrealize(dev, errp);
+    if (*errp) {
         return;
     }
 }
@@ -5750,10 +5738,10 @@ static void x86_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
 static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     DeviceState *dev = DEVICE(obj);
     X86CPU *cpu = X86_CPU(obj);
     BitProperty *fp = opaque;
-    Error *local_err = NULL;
     bool value;
 
     if (dev->realized) {
@@ -5761,9 +5749,8 @@ static void x86_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
         return;
     }
 
-    visit_type_bool(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_bool(v, name, &value, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
index b35537de62..c876c8d7d4 100644
--- a/target/lm32/cpu.c
+++ b/target/lm32/cpu.c
@@ -122,13 +122,12 @@ static void lm32_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 static void lm32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     LM32CPUClass *lcc = LM32_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index e6596de29c..b83eca5cfa 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -216,16 +216,15 @@ static void any_cpu_initfn(Object *obj)
 
 static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     M68kCPU *cpu = M68K_CPU(dev);
     M68kCPUClass *mcc = M68K_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
     register_m68k_insns(&cpu->env);
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 9cfd7445e7..d1591cc23a 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -140,6 +140,7 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     MicroBlazeCPUClass *mcc = MICROBLAZE_CPU_GET_CLASS(dev);
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
@@ -147,11 +148,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     uint8_t version_code = 0;
     const char *version;
     int i = 0;
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index bbcf7ca463..89b661e7ff 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -136,14 +136,13 @@ static void mips_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 
 static void mips_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     MIPSCPU *cpu = MIPS_CPU(dev);
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
index 48996d0554..19fe37284c 100644
--- a/target/moxie/cpu.c
+++ b/target/moxie/cpu.c
@@ -55,13 +55,12 @@ static void moxie_cpu_disas_set_info(CPUState *cpu, disassemble_info *info)
 
 static void moxie_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     MoxieCPUClass *mcc = MOXIE_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index ca9c7a6df5..3cdaa0010b 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -82,13 +82,12 @@ static ObjectClass *nios2_cpu_class_by_name(const char *cpu_model)
 
 static void nios2_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     Nios2CPUClass *ncc = NIOS2_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 506aec6bfb..f297a2f96d 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -67,13 +67,12 @@ static void openrisc_cpu_reset(CPUState *s)
 
 static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     OpenRISCCPUClass *occ = OPENRISC_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/ppc/compat.c b/target/ppc/compat.c
index 7de4bf3122..610de2fb07 100644
--- a/target/ppc/compat.c
+++ b/target/ppc/compat.c
@@ -251,13 +251,12 @@ static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
 static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
                                 void *opaque, Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
     char *value;
     uint32_t compat_pvr;
 
-    visit_type_str(v, name, &value, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    visit_type_str(v, name, &value, errp);
+    if (*errp) {
         return;
     }
 
@@ -292,16 +291,16 @@ void ppc_compat_add_property(Object *obj, const char *name,
                              uint32_t *compat_pvr, const char *basedesc,
                              Error **errp)
 {
-    Error *local_err = NULL;
+    ERRP_AUTO_PROPAGATE();
     gchar *namesv[ARRAY_SIZE(compat_table) + 1];
     gchar *names, *desc;
     int i;
 
     object_property_add(obj, name, "string",
                         ppc_compat_prop_get, ppc_compat_prop_set, NULL,
-                        compat_pvr, &local_err);
-    if (local_err) {
-        goto out;
+                        compat_pvr, errp);
+    if (*errp) {
+        return;
     }
 
     for (i = 0; i < ARRAY_SIZE(compat_table); i++) {
@@ -315,11 +314,8 @@ void ppc_compat_add_property(Object *obj, const char *name,
 
     names = g_strjoinv(", ", namesv);
     desc = g_strdup_printf("%s. Valid values are %s.", basedesc, names);
-    object_property_set_description(obj, name, desc, &local_err);
+    object_property_set_description(obj, name, desc, errp);
 
     g_free(names);
     g_free(desc);
-
-out:
-    error_propagate(errp, local_err);
 }
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index ba726dec4d..1f4c2d4b94 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -9807,14 +9807,13 @@ static int ppc_fixup_cpu(PowerPCCPU *cpu)
 
 static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
     if (cpu->vcpu_id == UNASSIGNED_CPU_INDEX) {
@@ -9828,9 +9827,8 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    create_ppc_opcodes(cpu, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    create_ppc_opcodes(cpu, errp);
+    if (*errp) {
         goto unrealize;
     }
     init_ppc_proc(cpu);
@@ -10033,15 +10031,14 @@ unrealize:
 
 static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-    Error *local_err = NULL;
     opc_handler_t **table, **table_2;
     int i, j, k;
 
-    pcc->parent_unrealize(dev, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    pcc->parent_unrealize(dev, errp);
+    if (*errp) {
         return;
     }
 
@@ -10188,6 +10185,7 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
 static void ppc_cpu_parse_featurestr(const char *type, char *features,
                                      Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     Object *machine = qdev_get_machine();
     const PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(object_class_by_name(type));
 
@@ -10199,7 +10197,6 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
         int i;
         char **inpieces;
         char *s = features;
-        Error *local_err = NULL;
         char *compat_str = NULL;
 
         /*
@@ -10227,11 +10224,10 @@ static void ppc_cpu_parse_featurestr(const char *type, char *features,
 
         if (compat_str) {
             char *v = compat_str + strlen("compat=");
-            object_property_set_str(machine, v, "max-cpu-compat", &local_err);
+            object_property_set_str(machine, v, "max-cpu-compat", errp);
         }
         g_strfreev(inpieces);
-        if (local_err) {
-            error_propagate(errp, local_err);
+        if (*errp) {
             return;
         }
     }
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index f13e298a36..6f27404b89 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -316,17 +316,16 @@ static void riscv_cpu_disas_set_info(CPUState *s, disassemble_info *info)
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     RISCVCPU *cpu = RISCV_CPU(dev);
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
     target_ulong target_misa = 0;
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index d0a7707991..d17d398a75 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -174,13 +174,12 @@ static void sh7785_class_init(ObjectClass *oc, void *data)
 
 static void superh_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     SuperHCPUClass *scc = SUPERH_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index bc65929552..2f631ed63b 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -736,9 +736,9 @@ static ObjectClass *sparc_cpu_class_by_name(const char *cpu_model)
 
 static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
     SPARCCPU *cpu = SPARC_CPU(dev);
     CPUSPARCState *env = &cpu->env;
 
@@ -762,9 +762,8 @@ static void sparc_cpu_realizefn(DeviceState *dev, Error **errp)
     env->version |= env->def.nwindows - 1;
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
@@ -798,15 +797,14 @@ static void sparc_get_nwindows(Object *obj, Visitor *v, const char *name,
 static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
                                void *opaque, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     const int64_t min = MIN_NWINDOWS;
     const int64_t max = MAX_NWINDOWS;
     SPARCCPU *cpu = SPARC_CPU(obj);
-    Error *err = NULL;
     int64_t value;
 
-    visit_type_int(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
+    visit_type_int(v, name, &value, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index df807c1d74..becb4a1ae9 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -71,15 +71,14 @@ static bool tricore_cpu_has_work(CPUState *cs)
 
 static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     TriCoreCPU *cpu = TRICORE_CPU(dev);
     TriCoreCPUClass *tcc = TRICORE_CPU_GET_CLASS(dev);
     CPUTriCoreState *env = &cpu->env;
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index b27fb9689f..1f3fbe6c1a 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -84,13 +84,12 @@ static void uc32_any_cpu_initfn(Object *obj)
 
 static void uc32_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     UniCore32CPUClass *ucc = UNICORE32_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index c65dcf9dd7..0b2811f8e0 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -131,17 +131,16 @@ static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
 {
+    ERRP_AUTO_PROPAGATE();
     CPUState *cs = CPU(dev);
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(dev);
-    Error *local_err = NULL;
 
 #ifndef CONFIG_USER_ONLY
     xtensa_irq_init(&XTENSA_CPU(dev)->env);
 #endif
 
-    cpu_exec_realizefn(cs, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
+    cpu_exec_realizefn(cs, errp);
+    if (*errp) {
         return;
     }
 
-- 
2.21.0


