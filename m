Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E0C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:38:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE3920637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CtvgfVOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE3920637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tWQ-0000Sk-Fq
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:38:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPN-0003pm-3W
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPL-0002mq-Jt
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:38092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPL-0002lL-Br
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:35 -0500
Received: by mail-wr1-x433.google.com with SMTP id t11so7801026wrw.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FMoHaWzahHswrnGpkdh208+DyOcSTnJAR/zWbqH+ju4=;
 b=CtvgfVOF29kYiBq0PFvd4/I0ohFnWZ8ilwn9b7c3Y03eulrxR+c9Huz9T9QTk3vnaZ
 wUctaNSU2ls7VeD73hnvqvRr7fL/nI0iAkSMoG6Ge5xYUYTLSWDS1Ej49av6eHTzpTm7
 UWsI3XdCtanqAJasWeVECRjvIEdYWTX6uw2qoONjBP2WadSiaXBhOuidcUCfPBtyW51x
 y8q5+8016q6Qp5PqSuPeKkUYsX3TeL29HkVhoigv4Dx2KZ+oV55E4Upa9IGAzwUMy+Iq
 af506oyDkymmoQRAzqMPv37H0I4J6zFsj7CKhWesIzODHzg609qA11MUTb6QAa9EmUEH
 gJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FMoHaWzahHswrnGpkdh208+DyOcSTnJAR/zWbqH+ju4=;
 b=rAWval41F8IhMEKTj45AOgkOwa9GiVu4Zrt6xtwlfvZ3pwNU7Vrbhl9z2Ap+AObANF
 SjMINhVVhtphABoYGhJfZ2tsCDWmSD0QxZ+FviC4TK+1suDBe9T4rWwG+BMEBfgO5hV4
 K6R8sBDceH8EeDyEONUrAfjZMtAnSbANP0pueVzuyMZAc32ppLNnSfozLZrwKw56bQOe
 3w/15o9NCiugVeuwqZfryJuuBwFxcD+vls4vnzNbuOMXr4k6ztqxY6Ex/awgK1AZMf/d
 uQfex8UPJ01tsKMKj4sGThbSiVDL8N5Ovn3DymLx7aUoJtZkfVmVhNm922VET4xzvCy2
 sDQQ==
X-Gm-Message-State: ANhLgQ12pmtfnIOltSpaUVMrkgWEEqT6O/3LzXPb84uTHvxzzS6qTbW4
 wAEfU4Bg5bI3ayhJIpmgEuSsDbejooDu7Q==
X-Google-Smtp-Source: ADFU+vvCXhofhRjBfj42sx19syxjRM8lQaigNP5RgkB0kfzqBigAf4EKYCMdvv80sBb0zUNDN9hP3w==
X-Received: by 2002:a5d:4dc7:: with SMTP id f7mr8079744wru.72.1583425893880;
 Thu, 05 Mar 2020 08:31:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/37] hw/arm/cubieboard: restrict allowed RAM size to 512MiB
 and 1GiB
Date: Thu,  5 Mar 2020 16:30:52 +0000
Message-Id: <20200305163100.22912-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

The Cubieboard contains either 512MiB or 1GiB of onboard RAM [1].
Prevent changing RAM to a different size which could break user programs.

 [1] http://linux-sunxi.org/Cubieboard

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200227220149.6845-4-nieklinnenbank@gmail.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/cubieboard.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 010375f0a8d..6c55d9056f5 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -33,6 +33,13 @@ static void cubieboard_init(MachineState *machine)
     AwA10State *a10;
     Error *err = NULL;
 
+    /* This board has fixed size RAM (512MiB or 1GiB) */
+    if (machine->ram_size != 512 * MiB &&
+        machine->ram_size != 1 * GiB) {
+        error_report("This machine can only be used with 512MiB or 1GiB RAM");
+        exit(1);
+    }
+
     /* Only allow Cortex-A8 for this board */
     if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a8")) != 0) {
         error_report("This board can only be used with cortex-a8 CPU");
@@ -78,6 +85,7 @@ static void cubieboard_machine_init(MachineClass *mc)
 {
     mc->desc = "cubietech cubieboard (Cortex-A8)";
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
+    mc->default_ram_size = 1 * GiB;
     mc->init = cubieboard_init;
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
-- 
2.20.1


