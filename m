Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE94C3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:05:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA51B21D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 01:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rv/G8zGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA51B21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8vzX-0007pv-RM
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 20:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl9-00036j-52
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j8vl6-0004f5-Os
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:07 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:42889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j8vl6-0004eb-Hl
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:50:04 -0500
Received: by mail-pl1-x62c.google.com with SMTP id u3so501454plr.9
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=QkFXHaLS5zlcI8OA2QDono5LxTYgDFUD9/bo7kYQTas=;
 b=Rv/G8zGPxbtwWgkO0FUOC2raCL/iRkF3CaxIs8T6Rpf3hDXPywrA6si1Qzt+naSAV7
 TFvR89SVq9S87iRm4nNAd9KDe5hszuBn4ehjdQWvnE4K/cWssJ0ZmtvUvJYoURmsaW3O
 o2GEnInxZOEVhIpVM8DYkkM8/qeCMPj60KOwCX93leoMeTeHBrcD9oHtQiF5/BsKxL1u
 oG9fSTL3EqVhjJVUiLXZf2lptGOvxsRZZnpDIhfdVwQRNcpXS8S/eL6PQRrHRLEh6kZC
 4dhyk0yujTRk9y6dJT+pN14AeqYV/aY1BTsvVDl8dXNGh2BCrv3Xm98I/H5btMObf6ke
 uTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=QkFXHaLS5zlcI8OA2QDono5LxTYgDFUD9/bo7kYQTas=;
 b=CEUxNIrK9gSpnmOh54xLv5oK2YTHPmbSilTLdNZcjRqGTdyu7NQaISQyOh/Ug81iwV
 6brUDTzKCUmvSvX93jb0fRIMo/ZFu8JkSqJM86wLhMVIoDtc+MyZlavckFl8xETDH/8q
 HItQfuVHz8ty/7vguU1zK18ZxOQSBECRjT3IwGPjZ0Oo1gY2Of7JN6zKKSQT5PBEhx+V
 SF4Z3hcuVvyyXSHRnXAg/cpvNY7JeIBBKpvdz5PQhyzD+elh9E9RyPtBBIiLuQG26wq0
 umBCnTne6bqshgRZp4ZpZltPbi2lzFINsvhyn9J2LNo/GJtX7oT3+n6fe38ZF+zXpGGk
 O9Tw==
X-Gm-Message-State: ANhLgQ1xz55rocCKNLvjUjOXCO863JCAw4VWlmxe66fAsvqThorRH6q3
 fq3ehhnIWeOxTlhcJ1UGgmcS0g==
X-Google-Smtp-Source: ADFU+vvDAPOQnKqfImIbbsB7ZdmCppOth4QLMuaewn8JykUc2tk0O0yENetS6cKY/mTTO5zPFsmQsQ==
X-Received: by 2002:a17:902:fe05:: with SMTP id
 g5mr1719431plj.248.1583196603312; 
 Mon, 02 Mar 2020 16:50:03 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id y7sm9656801pfq.15.2020.03.02.16.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 16:50:02 -0800 (PST)
Subject: [PULL 38/38] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
Date: Mon,  2 Mar 2020 16:48:48 -0800
Message-Id: <20200303004848.136788-39-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200303004848.136788-1-palmerdabbelt@google.com>
References: <20200303004848.136788-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Anup Patel <anup.patel@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
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

From: Anup Patel <anup.patel@wdc.com>

This patch extends CLINT emulation to provide rdtime callback for
TCG. This rdtime callback will be called wheneven TIME CSRs are
read in privileged modes.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 hw/riscv/sifive_clint.c         | 6 +++++-
 hw/riscv/sifive_e.c             | 2 +-
 hw/riscv/sifive_u.c             | 2 +-
 hw/riscv/spike.c                | 9 ++++++---
 hw/riscv/virt.c                 | 2 +-
 include/hw/riscv/sifive_clint.h | 3 ++-
 6 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index e2feee871b..e933d35092 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -227,7 +227,8 @@ type_init(sifive_clint_register_types)
  * Create CLINT device.
  */
 DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base)
+    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
+    bool provide_rdtime)
 {
     int i;
     for (i = 0; i < num_harts; i++) {
@@ -236,6 +237,9 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
         if (!env) {
             continue;
         }
+        if (provide_rdtime) {
+            riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
+        }
         env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                   &sifive_clint_timer_cb, cpu);
         env->timecmp = 0;
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8a6b0348df..a254cad489 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -164,7 +164,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_PLIC].size);
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
         memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
     create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
     sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0e12b3ccef..156a003642 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -549,7 +549,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_UART1_IRQ));
     sifive_clint_create(memmap[SIFIVE_U_CLINT].base,
         memmap[SIFIVE_U_CLINT].size, ms->smp.cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, false);
 
     object_property_set_bool(OBJECT(&s->prci), true, "realized", &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->prci), 0, memmap[SIFIVE_U_PRCI].base);
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 8823681783..6e5723a171 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -227,7 +227,8 @@ static void spike_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        false);
 }
 
 static void spike_v1_10_0_board_init(MachineState *machine)
@@ -316,7 +317,8 @@ static void spike_v1_10_0_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        false);
 }
 
 static void spike_v1_09_1_board_init(MachineState *machine)
@@ -424,7 +426,8 @@ static void spike_v1_09_1_board_init(MachineState *machine)
 
     /* Core Local Interruptor (timer and IPI) */
     sifive_clint_create(memmap[SPIKE_CLINT].base, memmap[SPIKE_CLINT].size,
-        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        smp_cpus, SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
+        false);
 
     g_free(config_string);
 }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5d175d5c9e..85ec9e22aa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -593,7 +593,7 @@ static void riscv_virt_board_init(MachineState *machine)
         memmap[VIRT_PLIC].size);
     sifive_clint_create(memmap[VIRT_CLINT].base,
         memmap[VIRT_CLINT].size, smp_cpus,
-        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
+        SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE, true);
     sifive_test_create(memmap[VIRT_TEST].base);
 
     for (i = 0; i < VIRTIO_COUNT; i++) {
diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/riscv/sifive_clint.h
index ae8286c884..4a720bfece 100644
--- a/include/hw/riscv/sifive_clint.h
+++ b/include/hw/riscv/sifive_clint.h
@@ -41,7 +41,8 @@ typedef struct SiFiveCLINTState {
 } SiFiveCLINTState;
 
 DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
-    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base);
+    uint32_t sip_base, uint32_t timecmp_base, uint32_t time_base,
+    bool provide_rdtime);
 
 enum {
     SIFIVE_SIP_BASE     = 0x0,
-- 
2.25.0.265.gbab2e86ba0-goog


