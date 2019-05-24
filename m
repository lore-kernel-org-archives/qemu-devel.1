Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5332DC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:10:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EA220675
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 16:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC73GDvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EA220675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57010 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCmL-0002wn-BX
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 12:10:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCds-0004I5-2M
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hUCdp-0002Hl-VV
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hUCdp-0002Fo-Ot
	for qemu-devel@nongnu.org; Fri, 24 May 2019 12:01:57 -0400
Received: by mail-wm1-x342.google.com with SMTP id v22so2500094wml.1
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=YsLm+sh0ogQXpVuCi/Ts5K2BgX2LI/eiSGa1dNH+IPU=;
	b=nC73GDvjYDlRaR0hPVh2e/sAokG6TJY1lqZ67XpZXRRhxxaDGhID0oyUOutf+VQ0M8
	T31ahb4SgWyT8Sp4F/0Ga3IDk5zceN04WnijWgL2Y2/uaaeVGARPLrQ1/2sR2tbEgtI/
	Ehkx8KnvLZoxR7tu4ormojWMmzLqP/Hr8I6jI0deYPVZX0szhR/5QsPbukzE7S+xTwoE
	QlOz32sN5Sd200vncREP7N4kHLTlRMVkol8FEclZz96c4GA7GJ5idDHi9EIjzO2tjrxu
	g7ioNZRhajpY/86Xj4V6I3mDqhCmVDS+uhe8x++PmuTqhOvpELxoa9LMKQXRyr3nknik
	0qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=YsLm+sh0ogQXpVuCi/Ts5K2BgX2LI/eiSGa1dNH+IPU=;
	b=N3d2i4KN/eZOCd1Tmyq6P7OEpB/VDI14fjXCJ8htbF/Hu5HwuSWqB8kKZxwZb03VP7
	V3/ZTxl5LQeqP8MyMa30fwS8i0Qe5MqVwlX92/AKE/WCM8YZ+DIfjwNkPWfxVbacZ3eG
	K0Ya/snh8peLEk15xuvlMwF8lS8rYd+CYZWhyfOnajsREu1g/Swe/XDWrYZb9bVCoTNi
	p6cvgX/RhSVrl9KO9BFPG6YFQlqz7kjmdvBYuxZe2+s8ElKrhHVsDbbo0uUxRLEz1QY+
	10/K65cTlWV4BEgkfkx23s3r9Up+AWVqGlhX42Jc7Fb/+d2xu8Y90V26obgLfjzZhY6j
	ngSg==
X-Gm-Message-State: APjAAAU72U3PcwL6jSRg4JEru7pP9s7sTXPYXmOZ9MOnz6k79aiJpd6b
	0Oshjym7QKuDXaLZs1AmyAUqxs1E
X-Google-Smtp-Source: APXvYqznP2rkEGcL/CofW7922FeYWEaDJbBYEwYXkUCQMhn1og3untgjuwWMA7NtAFZeN0zMPJlriQ==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr389463wmb.155.1558713714647; 
	Fri, 24 May 2019 09:01:54 -0700 (PDT)
Received: from jondnuc.lan ([176.230.64.37])
	by smtp.gmail.com with ESMTPSA id s11sm370863wro.17.2019.05.24.09.01.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 24 May 2019 09:01:54 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 19:01:17 +0300
Message-Id: <20190524160118.31134-20-arilou@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524160118.31134-1-arilou@gmail.com>
References: <20190524160118.31134-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v11 19/20] gdbstub: Clear unused variables in
 gdb_handle_packet
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: alex.bennee@linaro.org, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index 097b7d1231..9dd934a079 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -2270,17 +2270,11 @@ static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static int gdb_handle_packet(GDBState *s, const char *line_buf)
 {
-    const char *p;
-    int ch;
-    uint8_t mem_buf[MAX_PACKET_LENGTH];
-    char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
     const GdbCmdParseEntry *cmd_parser = NULL;
 
     trace_gdbstub_io_command(line_buf);
 
-    p = line_buf;
-    ch = *p++;
-    switch(ch) {
+    switch (line_buf[0]) {
     case '!':
         put_packet(s, "OK");
         break;
@@ -2497,8 +2491,7 @@ static int gdb_handle_packet(GDBState *s, const char *line_buf)
         break;
     default:
         /* put empty packet */
-        buf[0] = '\0';
-        put_packet(s, buf);
+        put_packet(s, "");
         break;
     }
 
-- 
2.21.0


