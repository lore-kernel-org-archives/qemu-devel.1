Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD8EC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B298206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNeB703y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B298206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRMy-0006xQ-Pv
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKg-00026M-7E
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKd-0006v0-4K
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HT+NqsXqZ55lovfZdVRNYKERL4Z23yYzyKSPgI5rRk8=;
 b=eNeB703yTxx5L5eUwn7N8Jpzq8VV3ZUMnUaQS4BpfK3vMpVSEjwv0+iGD36jhKwAKhZuP6
 gELtwrhHUXZQz0MsG/aRyKycraw2Dn4B83NpiMbWp+7VcmKXUktBbtI48gilYg262S5C2/
 GyRcbX+lB8oR+kYLjDQwTMindHJGa4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-LVZL2t5YP2SLNxFT_AV6cA-1; Wed, 02 Sep 2020 07:53:35 -0400
X-MC-Unique: LVZL2t5YP2SLNxFT_AV6cA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4B36802B6E;
 Wed,  2 Sep 2020 11:53:34 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F02B5C1C4;
 Wed,  2 Sep 2020 11:53:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/20] rx: Rename QOM type check macros
Date: Wed,  2 Sep 2020 07:53:09 -0400
Message-Id: <20200902115323.850385-7-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently we have a RXCPU typedef and a RXCPU type checking
macro, but OBJECT_DECLARE* would transform the RXCPU macro into a
function, and the function name would conflict with the typedef
name.

Rename the RXCPU* QOM type check macros to RX_CPU*, so we will
avoid the conflict and make the macro names consistent with the
TYPE_RX_CPU constant name.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20200825192110.3528606-53-ehabkost@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/rx/cpu-qom.h   |  6 +++---
 hw/rx/rx-gdbsim.c     |  4 ++--
 target/rx/cpu.c       | 14 +++++++-------
 target/rx/gdbstub.c   |  4 ++--
 target/rx/helper.c    |  4 ++--
 target/rx/translate.c |  2 +-
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index 3e81856ef5..af937bc680 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -25,11 +25,11 @@
 
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
 
-#define RXCPU_CLASS(klass) \
+#define RX_CPU_CLASS(klass) \
     OBJECT_CLASS_CHECK(RXCPUClass, (klass), TYPE_RX_CPU)
-#define RXCPU(obj) \
+#define RX_CPU(obj) \
     OBJECT_CHECK(RXCPU, (obj), TYPE_RX_CPU)
-#define RXCPU_GET_CLASS(obj) \
+#define RX_CPU_GET_CLASS(obj) \
     OBJECT_GET_CLASS(RXCPUClass, (obj), TYPE_RX_CPU)
 
 /*
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 54992ebe57..6914de2e59 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -118,7 +118,7 @@ static void rx_gdbsim_init(MachineState *machine)
          * the latter half of the SDRAM space.
          */
         kernel_offset = machine->ram_size / 2;
-        rx_load_image(RXCPU(first_cpu), kernel_filename,
+        rx_load_image(RX_CPU(first_cpu), kernel_filename,
                       SDRAM_BASE + kernel_offset, kernel_offset);
         if (dtb_filename) {
             ram_addr_t dtb_offset;
@@ -141,7 +141,7 @@ static void rx_gdbsim_init(MachineState *machine)
             rom_add_blob_fixed("dtb", dtb, dtb_size,
                                SDRAM_BASE + dtb_offset);
             /* Set dtb address to R1 */
-            RXCPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
+            RX_CPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
         }
     }
 }
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 219e05397b..23ee17a701 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -28,14 +28,14 @@
 
 static void rx_cpu_set_pc(CPUState *cs, vaddr value)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
 
     cpu->env.pc = value;
 }
 
 static void rx_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
 
     cpu->env.pc = tb->pc;
 }
@@ -48,8 +48,8 @@ static bool rx_cpu_has_work(CPUState *cs)
 
 static void rx_cpu_reset(DeviceState *dev)
 {
-    RXCPU *cpu = RXCPU(dev);
-    RXCPUClass *rcc = RXCPU_GET_CLASS(cpu);
+    RXCPU *cpu = RX_CPU(dev);
+    RXCPUClass *rcc = RX_CPU_GET_CLASS(cpu);
     CPURXState *env = &cpu->env;
     uint32_t *resetvec;
 
@@ -108,7 +108,7 @@ static ObjectClass *rx_cpu_class_by_name(const char *cpu_model)
 static void rx_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
-    RXCPUClass *rcc = RXCPU_GET_CLASS(dev);
+    RXCPUClass *rcc = RX_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
     cpu_exec_realizefn(cs, &local_err);
@@ -164,7 +164,7 @@ static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 static void rx_cpu_init(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    RXCPU *cpu = RXCPU(obj);
+    RXCPU *cpu = RX_CPU(obj);
     CPURXState *env = &cpu->env;
 
     cpu_set_cpustate_pointers(cpu);
@@ -176,7 +176,7 @@ static void rx_cpu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     CPUClass *cc = CPU_CLASS(klass);
-    RXCPUClass *rcc = RXCPU_CLASS(klass);
+    RXCPUClass *rcc = RX_CPU_CLASS(klass);
 
     device_class_set_parent_realize(dc, rx_cpu_realize,
                                     &rcc->parent_realize);
diff --git a/target/rx/gdbstub.c b/target/rx/gdbstub.c
index 9391e8151e..c811d4810b 100644
--- a/target/rx/gdbstub.c
+++ b/target/rx/gdbstub.c
@@ -22,7 +22,7 @@
 
 int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
     CPURXState *env = &cpu->env;
 
     switch (n) {
@@ -54,7 +54,7 @@ int rx_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
 int rx_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
     CPURXState *env = &cpu->env;
     uint32_t psw;
     switch (n) {
diff --git a/target/rx/helper.c b/target/rx/helper.c
index a6a337a311..3e380a94fe 100644
--- a/target/rx/helper.c
+++ b/target/rx/helper.c
@@ -44,7 +44,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
 #define INT_FLAGS (CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIR)
 void rx_cpu_do_interrupt(CPUState *cs)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
     CPURXState *env = &cpu->env;
     int do_irq = cs->interrupt_request & INT_FLAGS;
     uint32_t save_psw;
@@ -121,7 +121,7 @@ void rx_cpu_do_interrupt(CPUState *cs)
 
 bool rx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
     CPURXState *env = &cpu->env;
     int accept = 0;
     /* hardware interrupt (Normal) */
diff --git a/target/rx/translate.c b/target/rx/translate.c
index da9713d362..482278edd2 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -128,7 +128,7 @@ static int bdsp_s(DisasContext *ctx, int d)
 
 void rx_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    RXCPU *cpu = RXCPU(cs);
+    RXCPU *cpu = RX_CPU(cs);
     CPURXState *env = &cpu->env;
     int i;
     uint32_t psw;
-- 
2.26.2


