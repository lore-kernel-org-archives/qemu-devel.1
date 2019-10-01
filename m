Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF96C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F9920815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8vCfkrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F9920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFIQT-0004SY-SN
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKW-0006Au-E8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKV-0001jy-5r
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42700)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKU-0001jI-VX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id n14so15544746wrw.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=h0dNFhGs9tdhjt5L62PjdKnkeMNxQJzqGTxsdc27Rhw=;
 b=E8vCfkrMqnJ8bY4sWNztKHWCIaF+MTSy4TSsNdWhBxVsVndYT2Ldlc0DkdZLilDMue
 RoRqk8ox4gw97yo6i2iO5XMYASktiaaxHaLBluuv2JtnI19D5U8A2j+utnLewm3ymPe/
 H+nZA62pYp79IhUncFc6jrew1aADxNzqBcm6/2uc7/hlw79j6pee/821PqknKZ5N1FxB
 jvW2HjWUSz4gK+NUvHfLb7vExahAhnRysWWumFBJ7RDVTgDRXU1X774PS6zQtphkk5fb
 pDnWgLWBcMRLMatYk3EfWZZApGhn0MBY6p9gz2EslgjVXuG/+Q8cEnUc9KTUCAaP0zQo
 sNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=h0dNFhGs9tdhjt5L62PjdKnkeMNxQJzqGTxsdc27Rhw=;
 b=a7tcWBXnkATkz/d5i9vC8wUyaJq0pBm11xK5Cgzn76gy1xvuUj1SKlQ5lU2ilkOn1E
 kPFjRPpp1xYM56yW3rkWOlEN5NV/8FitLL7dM5d5xzm9d3xirULc55Wgz+n85QRhtu4Y
 H4x2lxf1WkfrUmmObNmVsHlMW2HQKLsD+N/dlYPeAsjeaR7AVlRr3/twxfjqBv8OHyBx
 xGDkUQZrwd2T54xcC+llpiQOJIXfkbYDyWePoetiR0sSOBtpeVp+dFOETSZLayCgreGy
 N4NWXEGpwjgEXqhQDfebLIWE7iMl/PxDTh57mjNXaY/0TQSBnx2ddaexGrDVX2rKKzuE
 VCIg==
X-Gm-Message-State: APjAAAXpUiUVskiGe65NmnOBjoWOaN3PDmDnhmnmLW/WeF0ym/oi0+2F
 x4ONJVeigzyU06rw/wTSP2+Gr1c0
X-Google-Smtp-Source: APXvYqxCtaDnxm8VWWaAfnQGCJSLrrYmo3xnH99LJ5ru+ox+pxsNsCsCTBlI//T810K8YTUD4Atz/A==
X-Received: by 2002:adf:c58b:: with SMTP id m11mr17113576wrg.252.1569936997688; 
 Tue, 01 Oct 2019 06:36:37 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] lm32: do not leak memory on object_new/object_unref
Date: Tue,  1 Oct 2019 15:36:27 +0200
Message-Id: <1569936988-635-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Bottom halves and ptimers are malloced, but nothing in these
files is freeing memory allocated by instance_init.  Since
these are sysctl devices that are never unrealized, just moving
the allocations to realize is enough to avoid the leak in
practice (and also to avoid upsetting asan when running
device-introspect-test).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/lm32_timer.c       |  6 +++---
 hw/timer/milkymist-sysctl.c | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index ac3edaf..cf316ed 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -186,9 +186,6 @@ static void lm32_timer_init(Object *obj)
 
     sysbus_init_irq(dev, &s->irq);
 
-    s->bh = qemu_bh_new(timer_hit, s);
-    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
-
     memory_region_init_io(&s->iomem, obj, &timer_ops, s,
                           "timer", R_MAX * 4);
     sysbus_init_mmio(dev, &s->iomem);
@@ -198,6 +195,9 @@ static void lm32_timer_realize(DeviceState *dev, Error **errp)
 {
     LM32TimerState *s = LM32_TIMER(dev);
 
+    s->bh = qemu_bh_new(timer_hit, s);
+    s->ptimer = ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
+
     ptimer_set_freq(s->ptimer, s->freq_hz);
 }
 
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 9583507..6aedc11 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -283,11 +283,6 @@ static void milkymist_sysctl_init(Object *obj)
     sysbus_init_irq(dev, &s->timer0_irq);
     sysbus_init_irq(dev, &s->timer1_irq);
 
-    s->bh0 = qemu_bh_new(timer0_hit, s);
-    s->bh1 = qemu_bh_new(timer1_hit, s);
-    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
-    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
-
     memory_region_init_io(&s->regs_region, obj, &sysctl_mmio_ops, s,
             "milkymist-sysctl", R_MAX * 4);
     sysbus_init_mmio(dev, &s->regs_region);
@@ -297,6 +292,11 @@ static void milkymist_sysctl_realize(DeviceState *dev, Error **errp)
 {
     MilkymistSysctlState *s = MILKYMIST_SYSCTL(dev);
 
+    s->bh0 = qemu_bh_new(timer0_hit, s);
+    s->bh1 = qemu_bh_new(timer1_hit, s);
+    s->ptimer0 = ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
+    s->ptimer1 = ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
+
     ptimer_set_freq(s->ptimer0, s->freq_hz);
     ptimer_set_freq(s->ptimer1, s->freq_hz);
 }
-- 
1.8.3.1



