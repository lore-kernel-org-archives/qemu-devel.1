Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7DCC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF4BC2168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wb2dCeNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF4BC2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GCn-0005PY-Tf
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:15:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhP-0004pB-0Y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhN-0002Q3-No
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:38 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51274)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2FhN-0002Je-Gl
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:37 -0500
Received: by mail-wm1-x32c.google.com with SMTP id t23so6545404wmi.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=N0Kibz+Zwr8u1oAxdBoyGL/jmEs53LkcKtGIGXIk9Jc=;
 b=wb2dCeNIurBpUwfbb+APC04g/OdzVnWqKdQvnLa1cLt/2n93PP9Vf1kWWSq8fEkjlk
 KJZ2xAPZbx8IrjqXXwMKL6k2a4b+MB417a8gGkizabplGLFcLGXLDMcw3/RGsNZi46tY
 yegTzrkI/t2qo2MjxOg2Qayz3jda1whapC657j3/CaPmZuRZxx4WJx7mbBR7vxbG7Y5V
 1jQy4VZ/9Tl1cTGYuNeDUO+35ibMXhHeQ5JTvulG8hePM9XzFr7H4GykaeU+2Jqcjx9R
 cDgceb3pbdCBkciuAdXtYq/4rRZJlWeylBXOOiuK0siJwYGO4LSaQSjkp8YL8R1+d+xO
 BejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N0Kibz+Zwr8u1oAxdBoyGL/jmEs53LkcKtGIGXIk9Jc=;
 b=uily8rNaLX37ezcvUErvrew1jQEYk0i/MZj8Sc6maGdqvy6W1qWPJDP8/NGXTAZw7n
 eXLRUSV3CFAHSS9BDMspNMARxO6oJOZ/TlhzSxjRn/WHKhgLXEmNfTc0b6c+yUu4g9i/
 M3LSGvlEzbMYr1qRegl4IZnHAIUZbrwHMkqjjMLLKQSrCdNe+Ulh7IuIBXDVxC6KrTUz
 jpgCRgaxa+t9NsrmhS1C3SFy+9DVct0CknN8drlA373mXnC/MQB8Uds3Vnnhs0x7/IXM
 iiPE3dtmvGWtq9v8oKhk4t2PYfcXTzrdjdsHPkUl7qRmDT9fnPUoxKAm/XjsLnqe+E87
 Gaxw==
X-Gm-Message-State: APjAAAXmUoSUyPk62cJEXOXPax1/Rl21+IlAN53rXXdejr0G7xBTbCpk
 d7NKSh3d91yuyCC0WHkIlwBC0ijscnY=
X-Google-Smtp-Source: APXvYqzi9MoiaVJPVAlZNkKtGHYFbUaHRSDbd+RDOerdVtWFt31e4cAwDTdWIBb07cjHAXsupdXEog==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr6268103wmi.89.1581604948544;
 Thu, 13 Feb 2020 06:42:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/46] hw/arm/raspi: Extract the RAM size from the board
 revision
Date: Thu, 13 Feb 2020 14:41:35 +0000
Message-Id: <20200213144145.818-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The board revision encode the amount of RAM. Add a helper
to extract the RAM size, and use it.
Since the amount of RAM is fixed (it is impossible to physically
modify to have more or less RAM), do not allow sizes different
than the one anounced by the manufacturer.

Acked-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200208165645.15657-5-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/raspi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index f285e2988fc..dcd8d2d6d38 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/arm/bcm2836.h"
@@ -49,6 +50,12 @@ FIELD(REV_CODE, MANUFACTURER,      16, 4);
 FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
 FIELD(REV_CODE, STYLE,             23, 1);
 
+static uint64_t board_ram_size(uint32_t board_rev)
+{
+    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
+    return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
+}
+
 static int board_processor_id(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -191,15 +198,17 @@ static void raspi_init(MachineState *machine, uint32_t board_rev)
 {
     RasPiState *s = g_new0(RasPiState, 1);
     int version = board_version(board_rev);
+    uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
     DriveInfo *di;
     BlockBackend *blk;
     BusState *bus;
     DeviceState *carddev;
 
-    if (machine->ram_size > 1 * GiB) {
-        error_report("Requested ram size is too large for this machine: "
-                     "maximum is 1GB");
+    if (machine->ram_size != ram_size) {
+        char *size_str = size_to_str(ram_size);
+        error_report("Invalid RAM size, should be %s", size_str);
+        g_free(size_str);
         exit(1);
     }
 
-- 
2.20.1


