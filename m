Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EBEC1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0B5220735
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 18:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lix2ZnYO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B5220735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEGbx-00060u-1Y
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 14:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36616)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUS-0005WL-S6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jEGUR-0008Vq-6t
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:56 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:55848)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jEGUQ-0008PM-Rl
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 13:58:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id 6so256663wmi.5
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 10:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y70yduvZnlJuuEmJKz38qFwzokDPfNTPIIUVc1ktav0=;
 b=lix2ZnYOEUi01Log7I7WE+5KIg5Kmcf+6HH7/k98xE8P01xhpa5r1NzfZCM8CyQ/sJ
 +alaisFp2redPti1cORSloAKExOCo19GkBsiFiwsf6X8BqPXuKwRqr6YWwhsIkdHfTho
 IWi9PlPXyRLEYr34PWk2KIlfrtSRR1Z/ljgD097cJalxl5d2MnpyanQ8XMDerHctI0Xy
 w02crGpMwsGen4Pk0lkj6CBPxXl7wyzCha5/qUP4hbFs1lcSpJG/siErFWUQewlK8moz
 jiJ3IuUsrXa63cCFlzuiV+5WjzIharnoNd0ry7dp+kEu6YscXW0mw9evS1z0v0ro8FEc
 /ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y70yduvZnlJuuEmJKz38qFwzokDPfNTPIIUVc1ktav0=;
 b=PmYIloyFqInzf5nR4veiQjXopvivtOAPek4dhZYVZm8wFA1gHzREbOvUc5Z5ReI1P3
 les0eJpGddkN/6MCcTx0n0TljwfJSteC6WfgZP5Lue5O8O7GLI8qOHGYcx+HRlYGVex6
 3id35cXFEavVpVO3ASwa49ymuHawCBHk0mTJO2NVELXDSVuFmO7X7sB/W9g5At2+xcjy
 c5/ChUvg2KfUkRNPtg71Dc5BvaSyDf8fId+/YFFgXLX0mkqPlcKIJA+WOyWgv7XJItBH
 mpQRjV2ax3R8K3EIu4QIZdxMMTyub4l5l203ExHAEdT7IBg+5pv7CstokGVaLVG8/P+a
 B8hw==
X-Gm-Message-State: ANhLgQ3STxedag/5oVYo4IKvvaR7bcCX7ckFTQJfU9yFqpP7Fh4b3MXj
 dwlaw4SVlbHbu7b4I3SkUmirAw==
X-Google-Smtp-Source: ADFU+vv7Ewcy2Uwgn+QtGMa5hSYGerxGFXuRGdYK4UUIKnsueZCIE3hp0ljecu8Q+i3UnTNTRvOP1w==
X-Received: by 2002:a1c:b789:: with SMTP id h131mr171297wmf.141.1584467933564; 
 Tue, 17 Mar 2020 10:58:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u8sm5236356wrn.69.2020.03.17.10.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 10:58:44 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D16C1FFB3;
 Tue, 17 Mar 2020 17:50:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 27/28] gdbstub: do not split gdb_monitor_write payload
Date: Tue, 17 Mar 2020 17:50:52 +0000
Message-Id: <20200317175053.5278-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317175053.5278-1-alex.bennee@linaro.org>
References: <20200317175053.5278-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
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
Message-Id: <20200316172155.971-28-alex.bennee@linaro.org>

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


