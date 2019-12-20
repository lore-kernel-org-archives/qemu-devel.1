Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D72C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A6CD24680
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 12:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKxqL+Hz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6CD24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54457 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiHMW-0008Ma-Mv
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 07:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36784)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAv-0000ku-A2
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiHAu-0001U2-2w
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiHAt-0001Q3-Od
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 07:14:31 -0500
Received: by mail-wr1-x443.google.com with SMTP id y11so9213129wrt.6
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 04:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZYdZReL1NF4ccjo0j5hGGmu8VTV/596/vKb83rC+xjU=;
 b=uKxqL+Hzw4iaAyf2GQL3ih302+LPHD0BDKm0lOAWQE8yHtx4s7INbPSymA8JDx6sRY
 ET2+uPQ6b5llAglhMnBxJaLv7hWLR2jU4SpfIDU14BPPiP5jYv4UQIxPCR8hd2Cq0wLG
 cpPufAmiWJQdGs3zH2oF1wf6WRA7vxrqaVxWBYuw5nkSOt9D5Z4GGU+usgVNd2J1mJsu
 KnGg5matGM04D9YEJgjz7Hyovm1U+y/F8HEW+GVFK/7RMCEheIEx9zTMfhN8eyV5pQC2
 yamKp9+uPDrrpklg1VMtp1QFxTYlZJwOMWzKqlX5NgUH1SoX/Pix4cixn/IzZ+bmy/y0
 7c1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZYdZReL1NF4ccjo0j5hGGmu8VTV/596/vKb83rC+xjU=;
 b=pk6HkyTAdFnd+f5ddhMv+XFdqzGkQYXG/BUWfXHg99n+NW4qYll78CYDqnC3Rq3+Cf
 w0EsWMQp6btcGMaTJeQ3L7N/0XmHi/r9Lp2bfJF9hqtU6i235ssnuLaecS5u0VLGV5GO
 YxuvspyTmN2V4pVhoR776o9/nAXjS2q0hpIc0+M9YpaFBdFhGUO2KvloZGB1nS6ce4mB
 +U52WhENvLLG8AOOwVesaJ8n8aT011I2Zm3iPyZDE+SyI+oh/LsZwYJadc3D/BXl5Rcw
 7lrmjHsfAAUwHMyxxsX5+O9Xwhm3mQrxwy3fHYXre66MWwXfpWTNDyTp7jUbO7JFQN/s
 +Npw==
X-Gm-Message-State: APjAAAVb73Ze5jpYnxfw0QA6ywIjVAkQrBx0ljhEdyzYxsQMUxpgyIKk
 xaukQ6pyY06KUMX0LDviwgs40w==
X-Google-Smtp-Source: APXvYqyv3bGy7i/LMFHBtU8VHkAV+bq4MRobYOWWRDHBRb17vm0dQtpObxpm5TwrCv/+7rCGh7PsmQ==
X-Received: by 2002:adf:f2c1:: with SMTP id d1mr14599626wrp.111.1576844070397; 
 Fri, 20 Dec 2019 04:14:30 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm9131236wmc.47.2019.12.20.04.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 04:14:25 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 155C61FFAB;
 Fri, 20 Dec 2019 12:04:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v4 21/21] gdbstub: do not split gdb_monitor_write payload
Date: Fri, 20 Dec 2019 12:04:38 +0000
Message-Id: <20191220120438.16114-22-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220120438.16114-1-alex.bennee@linaro.org>
References: <20191220120438.16114-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 alan.hayward@arm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Damien Hedde <damien.hedde@greensocs.com>

Since we can now send packets of arbitrary length:
simplify gdb_monitor_write() and send the whole payload
in one packet.

Suggested-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20191211160514.58373-3-damien.hedde@greensocs.com>
---
 gdbstub.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 49e760283db..5d0cdb81e4f 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, int event)
     }
 }
 
-static void gdb_monitor_output(const char *msg, int len)
-{
-    g_autoptr(GString) buf = g_string_new("O");
-    memtohex(buf, (uint8_t *)msg, len);
-    put_packet(buf->str);
-}
-
 static int gdb_monitor_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    const char *p = (const char *)buf;
-    int max_sz;
-
-    max_sz = (MAX_PACKET_LENGTH / 2) + 1;
-    for (;;) {
-        if (len <= max_sz) {
-            gdb_monitor_output(p, len);
-            break;
-        }
-        gdb_monitor_output(p, max_sz);
-        p += max_sz;
-        len -= max_sz;
-    }
+    g_autoptr(GString) hex_buf = g_string_new("O");
+    memtohex(hex_buf, buf, len);
+    put_packet(hex_buf->str);
     return len;
 }
 
-- 
2.20.1


