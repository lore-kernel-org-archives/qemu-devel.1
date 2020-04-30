Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3199C8300C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:00:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA1E20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 12:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKACY60d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA1E20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7s4-0003rc-BY
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 08:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jY-0002sf-0a
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jU-0000Mq-MS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:52:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:36656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jT-0000MG-L6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:59 -0400
Received: by mail-wm1-x336.google.com with SMTP id u127so1556144wmg.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VXBXtqv3GitaXcVyiEVFZJrNpGUF5enLW1nUxgiyox0=;
 b=BKACY60dzGyalop3Fdykr4+lf1xfeK21azs6Wu+TUDexrG4+Wxqpd+t3LDT+Jl/pQZ
 ygT1pt4i8q4nF1Jug6zCLn9bVHATKUMOcuOhvyJy5PvwVBlZ0sjefbcjEBnhI4MMrG1c
 T+p3tGFjhyywKNSg4RB6JfYJjO8/CBuphJZDaHIUT2FKGr1eH42F4ncQslnMqSwaicRC
 ZeLpDgfeEmatC3M+Vqk+3BFc/axrrvJ/m8L+ieMa5yubpmAyfdsleUL5oGdqp0O4EO30
 fulHfpQQJzYLK8JuSLwdpvH8Ounlkk+lGPha7NDdQ/tLmW3XgqI/Ssx1vwjy9Q2pIrh0
 Rn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VXBXtqv3GitaXcVyiEVFZJrNpGUF5enLW1nUxgiyox0=;
 b=ojaureRJ4COsslhib9lB2a2L92ZC5i9G0JFdFix1v/ptuylbZSzhLkrMMh6kEDAacw
 K3EsF80A2Fd4Noftx9y+Ky5ujuecyTGmfRl8YmLNxFkL2sPsaeRb1100IeD7s22mn43R
 urNCgYIvQoVpjVp/f7z0s+vtstuNejxYQCC+PGhxuHwYYSpbV5eAdpLnmH6FkMQrytMl
 +b4bNwn1kEjW30hh2lO5ImvDxPUrG6F7zivnBSHrXCZMg2/lIRlmEIvuURUIqUFTIhRa
 UITnduvRksH2Y6TC+nhbnQt+sHlsZea2xXKvfn89lqd8mgUskWr3kpmG22W8junERyWX
 Xf0Q==
X-Gm-Message-State: AGi0Pua6/iKQi9N+1I2lHdnl2god+5lzNSEyfEpiPA/quPaqC9Iz1DZu
 8vZxVtgWg3lhpi2Hpme6fyoACRpflW6OHA==
X-Google-Smtp-Source: APiQypLXDrItqpA0QjI8TjkpJhr0Q2swIdQjL2ziFtqG0jlD/bojW/ALvQtuO9cKKDsxeI8EXDEM4A==
X-Received: by 2002:a7b:c390:: with SMTP id s16mr2551630wmj.14.1588247517380; 
 Thu, 30 Apr 2020 04:51:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/31] qdev-clock: introduce an init array to ease the device
 construction
Date: Thu, 30 Apr 2020 12:51:23 +0100
Message-Id: <20200430115142.13430-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::336
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

From: Damien Hedde <damien.hedde@greensocs.com>

Introduce a function and macro helpers to setup several clocks
in a device from a static array description.

An element of the array describes the clock (name and direction) as
well as the related callback and an optional offset to store the
created object pointer in the device state structure.

The array must be terminated by a special element QDEV_CLOCK_END.

This is based on the original work of Frederic Konrad.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200406135251.157596-5-damien.hedde@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/qdev-clock.h | 55 +++++++++++++++++++++++++++++++++++++++++
 hw/core/qdev-clock.c    | 17 +++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/hw/qdev-clock.h b/include/hw/qdev-clock.h
index b3b3a3e021c..a340f65ff90 100644
--- a/include/hw/qdev-clock.h
+++ b/include/hw/qdev-clock.h
@@ -101,4 +101,59 @@ Clock *qdev_alias_clock(DeviceState *dev, const char *name,
  */
 void qdev_finalize_clocklist(DeviceState *dev);
 
+/**
+ * ClockPortInitElem:
+ * @name: name of the clock (can't be NULL)
+ * @output: indicates whether the clock is input or output
+ * @callback: for inputs, optional callback to be called on clock's update
+ * with device as opaque
+ * @offset: optional offset to store the ClockIn or ClockOut pointer in device
+ * state structure (0 means unused)
+ */
+struct ClockPortInitElem {
+    const char *name;
+    bool is_output;
+    ClockCallback *callback;
+    size_t offset;
+};
+
+#define clock_offset_value(devstate, field) \
+    (offsetof(devstate, field) + \
+     type_check(Clock *, typeof_field(devstate, field)))
+
+#define QDEV_CLOCK(out_not_in, devstate, field, cb) { \
+    .name = (stringify(field)), \
+    .is_output = out_not_in, \
+    .callback = cb, \
+    .offset = clock_offset_value(devstate, field), \
+}
+
+/**
+ * QDEV_CLOCK_(IN|OUT):
+ * @devstate: structure type. @dev argument of qdev_init_clocks below must be
+ * a pointer to that same type.
+ * @field: a field in @_devstate (must be Clock*)
+ * @callback: (for input only) callback (or NULL) to be called with the device
+ * state as argument
+ *
+ * The name of the clock will be derived from @field
+ */
+#define QDEV_CLOCK_IN(devstate, field, callback) \
+    QDEV_CLOCK(false, devstate, field, callback)
+
+#define QDEV_CLOCK_OUT(devstate, field) \
+    QDEV_CLOCK(true, devstate, field, NULL)
+
+#define QDEV_CLOCK_END { .name = NULL }
+
+typedef struct ClockPortInitElem ClockPortInitArray[];
+
+/**
+ * qdev_init_clocks:
+ * @dev: the device to add clocks to
+ * @clocks: a QDEV_CLOCK_END-terminated array which contains the
+ * clocks information.
+ */
+void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks);
+
 #endif /* QDEV_CLOCK_H */
diff --git a/hw/core/qdev-clock.c b/hw/core/qdev-clock.c
index 62035aef830..a94cc444379 100644
--- a/hw/core/qdev-clock.c
+++ b/hw/core/qdev-clock.c
@@ -116,6 +116,23 @@ Clock *qdev_init_clock_in(DeviceState *dev, const char *name,
     return ncl->clock;
 }
 
+void qdev_init_clocks(DeviceState *dev, const ClockPortInitArray clocks)
+{
+    const struct ClockPortInitElem *elem;
+
+    for (elem = &clocks[0]; elem->name != NULL; elem++) {
+        Clock **clkp;
+        /* offset cannot be inside the DeviceState part */
+        assert(elem->offset > sizeof(DeviceState));
+        clkp = (Clock **)(((void *) dev) + elem->offset);
+        if (elem->is_output) {
+            *clkp = qdev_init_clock_out(dev, elem->name);
+        } else {
+            *clkp = qdev_init_clock_in(dev, elem->name, elem->callback, dev);
+        }
+    }
+}
+
 static NamedClockList *qdev_get_clocklist(DeviceState *dev, const char *name)
 {
     NamedClockList *ncl;
-- 
2.20.1


