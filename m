Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECCC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61E5321921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRCNQ/XY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E5321921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpY9q-0000ow-Jl
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9E-0007Oc-17
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9C-00036r-KU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpY9C-00035y-EB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:34 -0400
Received: by mail-wm1-x343.google.com with SMTP id w9so28766654wmd.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JCIUgbCXYRFhL/tzoxMmaDrpmhwWT1hxcCQiVglgdPQ=;
 b=TRCNQ/XY/5ZNbLM99j7leegvf79WbbGiK0ZAduWlBgZmZUIarBneZDKwVrc4Ps/Tmu
 lgiayF1GNuq365xEvUEq6x53zVZbXkraMG7vx4/+ZLTyALx3XuybD5X1oo+IPSqq24k+
 UXZjlbkHbp5Hgf1PSIEv/dePVM4G6gbE4Rp2k5kBzd04qGB7aVQ5jzy9KgEXPWCKc1Jq
 IpZ7mfMARXpla4TIp2RD/1qsdx+grMxSgXplOHuij4XuHGBVLiqshIcQWCDj8okZlTro
 8MRzFI8JunujmLDpyGb1jsiSeMoa6c5jJ72KmKAthCEKQeixTbYXWv9+6n1ov5JNwYif
 tZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JCIUgbCXYRFhL/tzoxMmaDrpmhwWT1hxcCQiVglgdPQ=;
 b=el8q35y20MzLmNvgEx23kKk0gdFJjOVEBIu2rVQtx0PZ7ihL1EWfFwo6MtMb8Q3W/Y
 qUnYr9IEF4iVtUOWU2JXXEEDZVZXjq8FEN12pCRFh+VJW31cQWg0wupg842HHoWzgCj1
 AuHw0RzvoPMDwS1XGb9iMzjuIlQ0oSinP0exjB3gfGsFC6ut6ixq2QUxUBw5rJxBX9XW
 G7rPcckq+PbMpus6Z0/EgoBL0wuMcg5bsbkESaXik7NvG2JaOeZDSJwyjiCOqM1iLQJE
 evie1K7eIzD2yWhyR8oX/mTexeC/TtaK1qk3Snz8CkT0xRGPZ9erO9MkJRse++9QBvxq
 HhMw==
X-Gm-Message-State: APjAAAVEyZQQlN7Lu3LV9GkF1jJycnUee543UGOIp1PoYk/+Fynqr7KR
 D5RSYPf/eu6auv3c3CLo5R2XGRCtOpqirQ==
X-Google-Smtp-Source: APXvYqxXCwpjNf9I5fs+2p/dbbA0GWf4CVwF0EI2zSmOTg1nqY+4KaIraK9Jr3VFSAwIBp3nJDwPhg==
X-Received: by 2002:a1c:305:: with SMTP id 5mr33080448wmd.101.1563801273238;
 Mon, 22 Jul 2019 06:14:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f12sm42207217wrg.5.2019.07.22.06.14.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 06:14:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 14:14:25 +0100
Message-Id: <20190722131427.2669-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722131427.2669-1-peter.maydell@linaro.org>
References: <20190722131427.2669-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 3/5] target/arm: Limit ID register assertions to
 TCG
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

In arm_cpu_realizefn() we make several assertions about the values of
guest ID registers:
 * if the CPU provides AArch32 v7VE or better it must advertise the
   ARM_DIV feature
 * if the CPU provides AArch32 A-profile v6 or better it must
   advertise the Jazelle feature

These are essentially consistency checks that our ID register
specifications in cpu.c didn't accidentally miss out a feature,
because increasingly the TCG emulation gates features on the values
in ID registers rather than using old-style checks of ARM_FEATURE_FOO
bits.

Unfortunately, these asserts can cause problems if we're running KVM,
because in that case we don't control the values of the ID registers
-- we read them from the host kernel.  In particular, if the host
kernel is older than 4.15 then it doesn't expose the ID registers via
the KVM_GET_ONE_REG ioctl, and we set up dummy values for some
registers and leave the rest at zero.  (See the comment in
target/arm/kvm64.c kvm_arm_get_host_cpu_features().) This set of
dummy values is not sufficient to pass our assertions, and so on
those kernels running an AArch32 guest on AArch64 will assert.

We could provide a more sophisticated set of dummy ID registers in
this case, but that still leaves the possibility of a host CPU which
reports bogus ID register values that would cause us to assert.  It's
more robust to only do these ID register checks if we're using TCG,
as that is the only case where this is truly a QEMU code bug.

Reported-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190718125928.20147-1-peter.maydell@linaro.org
Fixes: https://bugs.launchpad.net/qemu/+bug/1830864
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1959467fdc8..9eb40ff755f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1369,6 +1369,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * There exist AArch64 cpus without AArch32 support.  When KVM
      * queries ID_ISAR0_EL1 on such a host, the value is UNKNOWN.
      * Similarly, we cannot check ID_AA64PFR0 without AArch64 support.
+     * As a general principle, we also do not make ID register
+     * consistency checks anywhere unless using TCG, because only
+     * for TCG would a consistency-check failure be a QEMU bug.
      */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         no_aa32 = !cpu_isar_feature(aa64_aa32, cpu);
@@ -1383,7 +1386,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
          * Presence of EL2 itself is ARM_FEATURE_EL2, and of the
          * Security Extensions is ARM_FEATURE_EL3.
          */
-        assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
+        assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(arm_div, cpu));
         set_feature(env, ARM_FEATURE_LPAE);
         set_feature(env, ARM_FEATURE_V7);
     }
@@ -1409,7 +1412,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V6)) {
         set_feature(env, ARM_FEATURE_V5);
         if (!arm_feature(env, ARM_FEATURE_M)) {
-            assert(no_aa32 || cpu_isar_feature(jazelle, cpu));
+            assert(!tcg_enabled() || no_aa32 || cpu_isar_feature(jazelle, cpu));
             set_feature(env, ARM_FEATURE_AUXCR);
         }
     }
-- 
2.20.1


