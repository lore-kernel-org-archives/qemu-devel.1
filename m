Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17001C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2873206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hgw6+ti9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2873206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDubU-0006hl-1M
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRX-0000uF-Bu
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jDtRV-00011G-VQ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jDtRV-0000v9-Gt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:22:21 -0400
Received: by mail-wr1-x442.google.com with SMTP id y2so6782930wrn.11
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S3cTxjypFmfXtVw2dMUn9D7l9wF5YaNxrf+weztp0sk=;
 b=Hgw6+ti92jYqYDNj/zW6KJUIBUAHwBPyqvaKpNo2UlET7sTMfqtLW2/Dmcn9z37RAJ
 NSNnhw6XJfYOt8fStg3SjzO+rHN9RN6tTdtIHCcXA09z8CyDm9dro6dPoUr/fh33ROsZ
 jBhTpnF3KcOjnBjFsWy8gOGBtmMMQYl2BCOsDHyWMSrZwfz1bQ5rYcze8ajs215PvFk9
 OJMrnirbERecQw2y4VINeZsE3i/A7Qd1j+3QvN4zQvUKVbzOmTQLumtns+j55Nd2PQQW
 tZRVpAnsoOKZd22IKL3l9pw+TEs1z7F6IqbURq/TH9Sbdyxj212Wfr7URYVt23nMv4em
 ziGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S3cTxjypFmfXtVw2dMUn9D7l9wF5YaNxrf+weztp0sk=;
 b=T46YP/Zebl75YOVB1q5nUWWAcRBZ7Xs/VLp/B3+FefQZ0T0mDsvm8+yUwchFZI5Amn
 jUCKrkxsvzLZrOnEvKWP2RtsEyM2z2YLv2fH7LDOd1W6jATB5HNVndIJMbmvRTGVw0EO
 tgu0EqP8d4la+FIDCMUuHAU3SINFP1EeGSO/oBCrtyZkAGhqQeOtc+LNgnwYlnCDezXE
 DNn1cop49aBlZGrg9f5PjUJ3i1imgnth8u4J7m6B2EFP85fQ8VvIGvy3y3o0Fn4upIUi
 VNMIjZMhXAFVAqGAsYmiC/CoONiwa4cR/Qqc8Yvw9dJtM1ucOP1UEcIeXXh+cwNEzCYK
 k9fg==
X-Gm-Message-State: ANhLgQ0HIL2voXX7C4naZqemeEf+yJ2OvfHm69yL9cYjQ3XfRC+08PQJ
 9uGfWG1VisVvaCNsXkStI9gInw==
X-Google-Smtp-Source: ADFU+vu5PXXwCYpp9+vjXDpB+n4QRutI3kkzx27vdMnnwR18hV50lsOEWmSVVU0x40kvWoNOObVfwQ==
X-Received: by 2002:adf:ab1d:: with SMTP id q29mr356744wrc.233.1584379338851; 
 Mon, 16 Mar 2020 10:22:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p10sm782836wrx.81.2020.03.16.10.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 10:22:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D78331FFB4;
 Mon, 16 Mar 2020 17:21:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 27/28] gdbstub: do not split gdb_monitor_write payload
Date: Mon, 16 Mar 2020 17:21:54 +0000
Message-Id: <20200316172155.971-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316172155.971-1-alex.bennee@linaro.org>
References: <20200316172155.971-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191211160514.58373-3-damien.hedde@greensocs.com>
---
 gdbstub.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index a60ef5125eb..9ae148cd1ff 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -3200,28 +3200,11 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
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


