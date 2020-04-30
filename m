Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B188BC8300B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB8F20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5N4U4tC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB8F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7xK-0004on-Kj
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jp-0003bo-TP
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jn-0000Tm-Lx
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:21 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:36604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jn-0000TP-8l
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id d15so6537699wrx.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5MreYDGc0zzBU/D/41w93auz/a1cW5LbSgeXIHJsmWA=;
 b=F5N4U4tCRmGgV9G9Eka+Fuc2AdkBON+Wc+9U1z1aalUdaCuXxakBV9FzhNPzgsMk2j
 +ijSQ+6oB/q4v4IQxx1jZlfy+FOLLEOzCFLOJV30kGb34w0YilrysIxkjKWZ14h26iNN
 a2oHLGCltQ2fDcd9P/2ffQ0Ocn/B/s2MB4AjHBcfmV5E6b8gcgi4ZGhqaGHK2Q7tDCg6
 f2xNXXmXUrd6K00Rh4Ei7BmtrnV4oyzGIDiXv6P3/ga62ZnqeTgHL9m0+WISFBC9s+7M
 0eOjq6+dQ8avUjbhq//Y9tcE3VUuU5kHl0vwOC8mnmlhkiHBNSIsygHZfNDpuMj6DW0A
 hq/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5MreYDGc0zzBU/D/41w93auz/a1cW5LbSgeXIHJsmWA=;
 b=K+2thIfXJ/CSMbBrcuJtR56yr+ZzITNKbMgX+tx5lvMjUiFOWgznzfdW996TRZ/Oey
 O8LMOQ5wgwM9fiFJFYxF49o08Ef57yzqHQio1D0/97AAQr2IeCzm9vOw6lkUa+8kuNX7
 EfTc6Cm1exj575+OnmiF5Y+i4oftSy5pOtU50hJc1p+kh04yKFopT3BsDoL9j4R74Eso
 D3WumtM/ItCyxpCNAG6MfsAft83Sy2Rgw0dG/Ry8adraZAY5w0RrPzZaNblp8Ya1lhGV
 ThFjjkfpB3wmV8OzPwKtyUUgiRazTphZf2pF5LuzJRbZkzQozK6CNG/Execxpu3tm35J
 e9nA==
X-Gm-Message-State: AGi0PubPeGFo6ZWFStHZ86tvXjfKHkjwzOIjrlK15I+gHptp1MhVWV/S
 IgHR6wWifofmjegG8kRMxksg0VdQYI4hqw==
X-Google-Smtp-Source: APiQypK+LKsTVKM/2daga9dP28KEgzwTK3W2nyGpXZnNnxp0+3NM/z7b/MslH4/n/rXS5uJ0SNPZqg==
X-Received: by 2002:a5d:4109:: with SMTP id l9mr3514446wrp.300.1588247537651; 
 Thu, 30 Apr 2020 04:52:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.52.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:52:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/31] hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102
Date: Thu, 30 Apr 2020 12:51:41 +0100
Message-Id: <20200430115142.13430-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::432
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

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Move arm_boot_info into XlnxZCU102.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200423121114.4274-4-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-zcu102.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index bd645ad8187..4eb117c755a 100644
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


