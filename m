Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F3C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C6E2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+xenE+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C6E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Z5b-0004U9-3O
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Ykd-0000lf-40
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkY-0006rq-4W
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:37849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6YkX-0006p3-Jj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id a6so2847390wme.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GT6on3p8wEsQiTUGN/RebiRNVDY5uR81qXMFnwv9ZQs=;
 b=r+xenE+a8x511YTNUeQUYExOL+et//8flPpIQJ2xrE/gGGlxjFHS2q2ZUJ4/09+p5E
 V3TrF/PcHCkGo5BsPcpaLv38dohT4Y8J5XFY1yvQr+TKIQMxUqgG3kmx6lXMcwjy5K/o
 b4nKk9XPiSEn2B07ky93ZpG5TieuSuhywImNPp7U35IUVAjlqcMJKRqztCxGRxhKLelj
 4NbCkH2qH+UnxdXbsXDxtsrycXYekPIhsuf8/z6EX/R3KnciW69vUTb8EDl5t0C+UOLN
 9lhfSFtCZONIEnqI5LCCdBG7eMVACBW1SbX6/jsDij7eRdzMV2YIERAniKXSIi9g1tA3
 wZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=GT6on3p8wEsQiTUGN/RebiRNVDY5uR81qXMFnwv9ZQs=;
 b=LiconrgJtP7SAEIckU4XgccY9SC0RbaITRItbaUvDYLb/kY3P/69TJmxHTuIWPhJwF
 0TowMaoHm/sq8q4JcF6iMeGpjk6TNYKVc4s0rgT8o+c7MCijnpMuFHdY5/JsWFfOs0+p
 EoUxIXZ6A5Gi/qMteP3GZtxpcYRkeLThXJv3KmXEawPOeri5DJ/+xUW2DnL7cdlaGaJs
 ICBPeVnSJX8S+XUm9VxJtXFiGy7bsOWmDQ/rwGt/LoZwlXtpUEhvZSvkrnfz4tOxY56Z
 ppsKpjkR59a6nf2/IYUrV27oEuOSn96tQVHd1uWYZ2pIHw2AZ6J0UHKdbsVRHUq2G5Kh
 Ww8Q==
X-Gm-Message-State: APjAAAVKQAHYwxdozpkZDB0mGHv4WrlQ50u2DdTk6PZm0fM3X+NrG0PA
 1IgL6uDMoA83UxLPUvyfewWauubW
X-Google-Smtp-Source: APXvYqzoYzJu1BOsImkds560HbjfD4eTP5Y+oAtlPQbfWPwblVeEcVDO5jY4dUMPsbvj6RRul19oHg==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr4939572wmf.124.1582631500365; 
 Tue, 25 Feb 2020 03:51:40 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:39 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 036/136] arm/xlnx-versal-virt: use memdev for RAM
Date: Tue, 25 Feb 2020 12:49:26 +0100
Message-Id: <1582631466-13880-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200219160953.13771-37-imammedo@redhat.com>
---
 hw/arm/xlnx-versal-virt.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c..c137ff4 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -30,7 +30,6 @@ typedef struct VersalVirt {
     MachineState parent_obj;
 
     Versal soc;
-    MemoryRegion mr_ddr;
 
     void *fdt;
     int fdt_size;
@@ -414,12 +413,9 @@ static void versal_virt_init(MachineState *machine)
         psci_conduit = QEMU_PSCI_CONDUIT_SMC;
     }
 
-    memory_region_allocate_system_memory(&s->mr_ddr, NULL, "ddr",
-                                         machine->ram_size);
-
     sysbus_init_child_obj(OBJECT(machine), "xlnx-ve", &s->soc,
                           sizeof(s->soc), TYPE_XLNX_VERSAL);
-    object_property_set_link(OBJECT(&s->soc), OBJECT(&s->mr_ddr),
+    object_property_set_link(OBJECT(&s->soc), OBJECT(machine->ram),
                              "ddr", &error_abort);
     object_property_set_int(OBJECT(&s->soc), psci_conduit,
                             "psci-conduit", &error_abort);
@@ -473,6 +469,7 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = XLNX_VERSAL_NR_ACPUS;
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS;
     mc->no_cdrom = true;
+    mc->default_ram_id = "ddr";
 }
 
 static const TypeInfo versal_virt_machine_init_typeinfo = {
-- 
1.8.3.1



