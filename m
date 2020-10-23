Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D0BC5517A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7212820857
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 21:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="k9S7XY+m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=keithp.com header.i=@keithp.com header.b="k9S7XY+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7212820857
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW4u0-0006Iw-8R
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 17:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW4sF-0005H7-Nl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:45:23 -0400
Received: from home.keithp.com ([63.227.221.253]:42418 helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1kW4sA-0007G1-B3
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 17:45:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id 896C23F2DD15
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603489513; bh=o9FSc9IqFdAVRsYbyKeZduUk4m6kW9TmMdzQOXB/0Xw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k9S7XY+mRROGKh0fL8fe1LvmiDJYV/JvgnIhsm9BUlZQrZX3G8HDYfXnoCsXhpzqs
 vg8kpxl1mOPEtKfFoktaz2NAcf1OmCnNcRtd0qi+uDEBRIt8W4yDBvmCMz7x/iA/fS
 W8mRS3D+AER0gl15B11H35mXTpAkyVdfQPOzXaMjUZfuu4HyGHOiMzIS1ygIQXqD7D
 JiqqGvznboHoV/sXvZl2xVlqGepWfnlHcM/d0myX5nJpXW0+J0gYRMQcsNe3j08WUn
 +ynd+zhDBHculPpLAjbN3v6GTsmZIELKQ/J7BNMeDMYfjmZSbb+7hSdBDBFLFmrKor
 UI+35QtBlpiUA==
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id uXvQ_44UuN9a; Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
Received: from keithp.com (koto.keithp.com [10.0.0.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 3B4A13F2DD11;
 Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1603489513; bh=o9FSc9IqFdAVRsYbyKeZduUk4m6kW9TmMdzQOXB/0Xw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k9S7XY+mRROGKh0fL8fe1LvmiDJYV/JvgnIhsm9BUlZQrZX3G8HDYfXnoCsXhpzqs
 vg8kpxl1mOPEtKfFoktaz2NAcf1OmCnNcRtd0qi+uDEBRIt8W4yDBvmCMz7x/iA/fS
 W8mRS3D+AER0gl15B11H35mXTpAkyVdfQPOzXaMjUZfuu4HyGHOiMzIS1ygIQXqD7D
 JiqqGvznboHoV/sXvZl2xVlqGepWfnlHcM/d0myX5nJpXW0+J0gYRMQcsNe3j08WUn
 +ynd+zhDBHculPpLAjbN3v6GTsmZIELKQ/J7BNMeDMYfjmZSbb+7hSdBDBFLFmrKor
 UI+35QtBlpiUA==
Received: by keithp.com (Postfix, from userid 1000)
 id 0726915821A2; Fri, 23 Oct 2020 14:45:13 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 1/2] riscv: Add sifive test device to sifive_e target
Date: Fri, 23 Oct 2020 14:45:05 -0700
Message-Id: <20201023214506.917601-2-keithp@keithp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023214506.917601-1-keithp@keithp.com>
References: <20201023214506.917601-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 17:45:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Keith Packard <keithp@keithp.com>
From: Keith Packard via <qemu-devel@nongnu.org>

The SiFive test device provides a mechanism for terminating the qemu
instance from the emulated system. This patch adds that device to the
sifive_e target.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/riscv/sifive_e.c         | 4 ++++
 include/hw/riscv/sifive_e.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index fcfac16816..417e3a5409 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -11,6 +11,7 @@
  * 3) PRCI (Power, Reset, Clock, Interrupt)
  * 4) Registers emulated as RAM: AON, GPIO, QSPI, PWM
  * 5) Flash memory emulated as RAM
+ * 6) TEST (Test device)
  *
  * The Mask ROM reset vector jumps to the flash payload at 0x2040_0000.
  * The OTP ROM and Flash boot code will be emulated in a future version.
@@ -45,6 +46,7 @@
 #include "hw/intc/sifive_clint.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_e_prci.h"
+#include "hw/misc/sifive_test.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
@@ -57,6 +59,7 @@ static const struct MemmapEntry {
     [SIFIVE_E_DEV_DEBUG] =    {        0x0,     0x1000 },
     [SIFIVE_E_DEV_MROM] =     {     0x1000,     0x2000 },
     [SIFIVE_E_DEV_OTP] =      {    0x20000,     0x2000 },
+    [SIFIVE_E_DEV_TEST] =     {   0x100000,     0x1000 },
     [SIFIVE_E_DEV_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_E_DEV_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_E_DEV_AON] =      { 0x10000000,     0x8000 },
@@ -216,6 +219,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_E_DEV_CLINT].size, 0, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE,
         SIFIVE_CLINT_TIMEBASE_FREQ, false);
+    sifive_test_create(memmap[SIFIVE_E_DEV_TEST].base);
     create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_DEV_AON].base, memmap[SIFIVE_E_DEV_AON].size);
     sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 83604da805..92bab6d0d4 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -56,6 +56,7 @@ enum {
     SIFIVE_E_DEV_DEBUG,
     SIFIVE_E_DEV_MROM,
     SIFIVE_E_DEV_OTP,
+    SIFIVE_E_DEV_TEST,
     SIFIVE_E_DEV_CLINT,
     SIFIVE_E_DEV_PLIC,
     SIFIVE_E_DEV_AON,
-- 
2.28.0


