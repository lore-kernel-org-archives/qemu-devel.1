Return-Path: <SRS0=RqUc=6D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D60C38A30
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D36E21744
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2020 16:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG6EdRwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D36E21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQCpu-0002Pr-PA
	for qemu-devel@archiver.kernel.org; Sun, 19 Apr 2020 12:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42268 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn8-0006tG-7O
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:34 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1jQCn7-0006k9-Oz
 for qemu-devel@nongnu.org; Sun, 19 Apr 2020 12:27:34 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:42193)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jQCn7-0006gj-C1; Sun, 19 Apr 2020 12:27:33 -0400
Received: by mail-lf1-x142.google.com with SMTP id j14so5844123lfg.9;
 Sun, 19 Apr 2020 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=grTZvoXi/O+6VUNDWXexr0Pz9O2SUdhYMt8q6LVR+M0=;
 b=EG6EdRwrIJTBkCWR+9HGy+WXJnoTk8i8dC96Gm8zEM94ROVQoKE/5EzvMuBUq9rofs
 NAa+2SD4L2ZPsZPGqXzqY2Kp14iJNk3YoXi6A13aKwOUqzOCM14mZB/2m6fYbOicyhmy
 D/lK5zxO1ar8N7ptdY0Oar4pHSRQVtwMaGOS97Njg1SuHH/PW5RW2jc/uULlJT3ITQ6O
 S3+lGrlLN2LOC8GAVgYh3sLT6FBxX8zSYxPKs+i3PgG7vwqYMD0qpJNY8pE1zQUvHzCb
 q+5C/L4A6W8KWsxEFHhWfLEnjMR/2h9vDnrXzxk3kp2cD6n+opjHFo/oovGLlAWl61mN
 4e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=grTZvoXi/O+6VUNDWXexr0Pz9O2SUdhYMt8q6LVR+M0=;
 b=RMGgq1d4XA6n39Qrq3bqA85uX2R2c9Vvdh9HDJsE2alFMHKZphjT+TMWQhGB/gCxUj
 BGp8y5Sq5BWuUfrU4Oigl5AOfGpj/iGr9yQQ+G00Jcu9413ZL4bOHk1GoxDXKND2KHXM
 tjy+RSv8IPazfDfIJyk1cqWQHobRKRR7dB4iuokFQT+zLDrvQJPky+1+iH7eCAEu6Blp
 TERsSGm1Wowd6zUkHztPGqrVnRyFfYXNA7M1vPjFjAc5Ni9ZLVRuR6LTQ2dR7lTRmMMT
 fWW88VXzHr6KenEftv4gTWfW85oRaggHGrw09jhZEPg3oDRhhYQGBsyq22IINcY50COz
 ++LA==
X-Gm-Message-State: AGi0PuaEw+SGv0gC6CyGU17XmHLaD9R53he6LZv178cEDl31xChkrKp9
 MdUGM3JxCU2VRbnhWCtxvrnaR79K/r8=
X-Google-Smtp-Source: APiQypJiHPZ4ro1aCt59A7Gjs0fu6/p/hq6FuhJmZ0Hr0PTtu79+ujqFx2YtXyfF4q4rFTbdkVW32Q==
X-Received: by 2002:ac2:46c4:: with SMTP id p4mr7848355lfo.37.1587313651207;
 Sun, 19 Apr 2020 09:27:31 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j13sm23441337lfb.19.2020.04.19.09.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2020 09:27:30 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/3] hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102
Date: Sun, 19 Apr 2020 18:27:26 +0200
Message-Id: <20200419162727.19148-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419162727.19148-1-edgar.iglesias@gmail.com>
References: <20200419162727.19148-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
X-detected-operating-system: by eggs1p.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, qemu-arm@nongnu.org,
 philmd@redhat.com, luc.michel@greensocs.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move arm_boot_info into XlnxZCU102.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/arm/xlnx-zcu102.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bd645ad818..4eb117c755 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -31,13 +31,14 @@ typedef struct XlnxZCU102 {
 
     bool secure;
     bool virt;
+
+    struct arm_boot_info binfo;
 } XlnxZCU102;
 
 #define TYPE_ZCU102_MACHINE   MACHINE_TYPE_NAME("xlnx-zcu102")
 #define ZCU102_MACHINE(obj) \
     OBJECT_CHECK(XlnxZCU102, (obj), TYPE_ZCU102_MACHINE)
 
-static struct arm_boot_info xlnx_zcu102_binfo;
 
 static bool zcu102_get_secure(Object *obj, Error **errp)
 {
@@ -166,9 +167,9 @@ static void xlnx_zcu102_init(MachineState *machine)
 
     /* TODO create and connect IDE devices for ide_drive_get() */
 
-    xlnx_zcu102_binfo.ram_size = ram_size;
-    xlnx_zcu102_binfo.loader_start = 0;
-    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &xlnx_zcu102_binfo);
+    s->binfo.ram_size = ram_size;
+    s->binfo.loader_start = 0;
+    arm_load_kernel(s->soc.boot_cpu_ptr, machine, &s->binfo);
 }
 
 static void xlnx_zcu102_machine_instance_init(Object *obj)
-- 
2.20.1


