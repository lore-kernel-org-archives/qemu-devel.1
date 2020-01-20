Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A984C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5BFF217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4kCSdMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BFF217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfHj-0007G7-Gp
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6s-0001dk-SG
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6r-0005uH-3Y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:26 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6q-0005tf-Sh
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:25 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so1109576wrh.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wgs2J2LLp4uuSA+tS75w8YGiE9cZF6FQc/75s2TfRGA=;
 b=N4kCSdMddrMC/P804ibycktGFEVTZ1fwAcYmW+mAqYmRgDwq4bjVmKNS6Fr9rXhWHI
 nnl+QpRhi2J0HEPonp9oqlse+lfpe4r/3CJahTjJEPHFBfZaIC7Zok1d9L0OchFnNiOK
 mYzXSY7f9+rF7ahDxNLWM6+JG7tWrJgVTu3no2cJuHI2rYzzfHU9EpYrjF+dy/1q4DCD
 PGHCEjyrWQvHHbICOPk35xBGSC4qJ85urm73Sq8FnT1vwVxVDo8/1PITQYmQWaaLSTsI
 I/NRZViTabFR7e+h8B1U0HRnw/mmHFEvAH6J7a0gIQOMfqkfJYNZ84I/QlSvEpp5ItI+
 xzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=wgs2J2LLp4uuSA+tS75w8YGiE9cZF6FQc/75s2TfRGA=;
 b=HtipeBJ7m8kYO82Y9lK5f32ji7LrPHI1f7C+JekXidxrzJyh+2LTmZnGSv1ATx/sLc
 EhGMMxQD4BGYFbqXxDlcNNYIGMq4oqptmCCiRbDPE94xWb4AFIEPucn9bH6wRoJ/UVe/
 93MJxDQLnRaHnvd51VsMKhfKYx8aXrET3ARfPIRWusjqfwpUjZAmQBicB11fua7aYeSu
 3xb1a7laOPPI8HFfh2c7OrrNTnbx4cUdxYDwlZp/821HQxFW7vXLud8o6q8qQLHRVC7m
 mmYxnDcmDvdkezgOQxlI8CBb7Ck6ephGtVMZcJfF0Bk0XfbNJVoDtGKdqFGBucG0TcH+
 NX0w==
X-Gm-Message-State: APjAAAV6N1+Uo20/GJAkUrOHYuDL0E/20I615SPcwTRLRB7Tx9A4l4jw
 iX52PoyEDriL7rJEfQx5bmzJgodE
X-Google-Smtp-Source: APXvYqyVCAn4Jjn8eG8dGlFtuJ8BngGUry7m/TtUHMWDuXby01mOdd9SBDARXEC+W/SoAl1hz5ivug==
X-Received: by 2002:a05:6000:118d:: with SMTP id
 g13mr1423782wrx.141.1579557683663; 
 Mon, 20 Jan 2020 14:01:23 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/18] hw/timer: Rename avr_timer16 -> atmel_timer16
Date: Mon, 20 Jan 2020 23:00:59 +0100
Message-Id: <20200120220107.17825-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AVR is the architecture, Atmel the manufacturer.

Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
!squash
---
 include/hw/timer/{avr_timer16.h => atmel_timer16.h} | 10 +++++-----
 hw/avr/sample.c                                     |  2 +-
 hw/timer/{avr_timer16.c => atmel_timer16.c}         |  4 ++--
 MAINTAINERS                                         |  4 ++--
 hw/avr/Kconfig                                      |  2 +-
 hw/timer/Kconfig                                    |  2 +-
 hw/timer/Makefile.objs                              |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)
 rename include/hw/timer/{avr_timer16.h => atmel_timer16.h} (92%)
 rename hw/timer/{avr_timer16.c => atmel_timer16.c} (99%)

diff --git a/include/hw/timer/avr_timer16.h b/include/hw/timer/atmel_timer16.h
similarity index 92%
rename from include/hw/timer/avr_timer16.h
rename to include/hw/timer/atmel_timer16.h
index 4ae0c64a34..f0516c41cf 100644
--- a/include/hw/timer/avr_timer16.h
+++ b/include/hw/timer/atmel_timer16.h
@@ -1,5 +1,5 @@
 /*
- * AVR 16 bit timer
+ * Atmel AVR 16 bit timer
  *
  * Copyright (c) 2018 University of Kent
  * Author: Ed Robbins
@@ -25,8 +25,8 @@
  * On ATmega640/V-1280/V-1281/V-2560/V-2561/V timers 1, 3, 4 and 5 are 16 bit
  */
 
-#ifndef AVR_TIMER16_H
-#define AVR_TIMER16_H
+#ifndef HW_TIMER_ATMEL_TIMER16_H
+#define HW_TIMER_ATMEL_TIMER16_H
 
 #include "hw/sysbus.h"
 #include "qemu/timer.h"
@@ -40,7 +40,7 @@ enum NextInterrupt {
     CAPT
 };
 
-#define TYPE_AVR_TIMER16 "avr-timer16"
+#define TYPE_AVR_TIMER16 "atmel-timer16"
 #define AVR_TIMER16(obj) \
     OBJECT_CHECK(AVRTimer16State, (obj), TYPE_AVR_TIMER16)
 
@@ -91,4 +91,4 @@ typedef struct AVRTimer16State {
     enum NextInterrupt next_interrupt;
 } AVRTimer16State;
 
-#endif /* AVR_TIMER16_H */
+#endif /* HW_TIMER_ATMEL_TIMER16_H */
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
index ca67c11233..19e9f56f3b 100644
--- a/hw/avr/sample.c
+++ b/hw/avr/sample.c
@@ -45,7 +45,7 @@
 #include "exec/address-spaces.h"
 #include "include/hw/sysbus.h"
 #include "include/hw/char/atmel_usart.h"
-#include "include/hw/timer/avr_timer16.h"
+#include "include/hw/timer/atmel_timer16.h"
 #include "include/hw/misc/avr_mask.h"
 #include "elf.h"
 #include "hw/misc/unimp.h"
diff --git a/hw/timer/avr_timer16.c b/hw/timer/atmel_timer16.c
similarity index 99%
rename from hw/timer/avr_timer16.c
rename to hw/timer/atmel_timer16.c
index a27933a18a..3b06d6e4e5 100644
--- a/hw/timer/avr_timer16.c
+++ b/hw/timer/atmel_timer16.c
@@ -1,5 +1,5 @@
 /*
- * AVR 16 bit timer
+ * Atmel AVR 16 bit timer
  *
  * Copyright (c) 2018 University of Kent
  * Author: Ed Robbins
@@ -32,7 +32,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/timer/avr_timer16.h"
+#include "hw/timer/atmel_timer16.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index f2e01a6d16..a98d164bc1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -898,8 +898,8 @@ S: Maintained
 F: hw/avr/
 F: hw/char/atmel_usart.c
 F: include/hw/char/atmel_usart.h
-F: hw/timer/avr_timer16.c
-F: include/hw/timer/avr_timer16.h
+F: hw/timer/atmel_timer16.c
+F: include/hw/timer/atmel_timer16.h
 F: hw/misc/avr_mask.c
 F: include/hw/misc/avr_mask.h
 F: tests/acceptance/machine_avr6.py
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index 8084a73176..45c7025f09 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -1,6 +1,6 @@
 config AVR_SAMPLE
     bool
-    select AVR_TIMER16
+    select ATMEL_TIMER16
     select ATMEL_USART
     select AVR_MASK
     select UNIMP
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 2521056dc8..cc66b60ef1 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -36,5 +36,5 @@ config CMSDK_APB_DUALTIMER
     bool
     select PTIMER
 
-config AVR_TIMER16
+config ATMEL_TIMER16
     bool
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index af0913ca3b..08a8a5cee9 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -36,4 +36,4 @@ common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) += cmsdk-apb-dualtimer.o
 common-obj-$(CONFIG_MSF2) += mss-timer.o
 common-obj-$(CONFIG_RASPI) += bcm2835_systmr.o
 
-obj-$(CONFIG_AVR_TIMER16) += avr_timer16.o
+obj-$(CONFIG_ATMEL_TIMER16) += atmel_timer16.o
-- 
2.21.1


