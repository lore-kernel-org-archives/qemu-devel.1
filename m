Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C5CC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:20:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0ED8222C4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 15:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/gINsO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0ED8222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irNzY-0001PS-G0
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 10:20:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpl-0005Us-UC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1irNpk-0007iI-IM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:21 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38851)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1irNpj-0007b2-90
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 10:10:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so12536863wrh.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 07:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9o0h/AvlZG4OInglAABEjBAMRDTZzGfk2bscVX4lDdE=;
 b=B/gINsO/LWdL9RseVZOoQpoYVgFjbPv2x+l0FYIU0LhMwv6OXDxRo4Nt9xh8Ynjwt8
 ZX/UGXyuual9QzI1Ht/ZUl0V3gBgRXHrjr/4Uyta6TWSy9zIS6pz6FhPfcHcmRs/2SKo
 9QFBXUVbvNRjt6WX8rEDdydqEBqJdcQSQVkVgCUgeIpibXnAOr6P2pZrUxMw5bAKg9NO
 Ws3VojqO6KpxCYP1bSZhA5d9ZJowdNi0FhvKFPUv6TKpfH9ZEGKtCyn1OPZQqVF5ozIf
 bzmk1BkbzuNbH2BtenRFt5K3t7i43HiVBvwHQjVLk6+Y0OC6EjKdYuZMzdql+93siPpc
 gVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9o0h/AvlZG4OInglAABEjBAMRDTZzGfk2bscVX4lDdE=;
 b=X03XGWIYMjLfOGOeoOVgS2Ftuw+CR/buwfk2ZBRapYbZOqFS+ZhmadQH47fPVWks/a
 tTm+tuc1h1f1Ia+oOOSqakJsU7oreR3KKbHykUaktHi2EodhxoFb2KP6PN7lsu8FTqKy
 PxBt/IdUEVGVAo/Pijh6MIbBTfDnfhQ35zEEvgeEnpfW8D4drXMIkh5JeFuUaAHeOz7a
 0JPWedyTlfNCpMftEwPq70RkaXum3eS39lBmYdaHvl4Gy5V95a4lTlfXUsxikkwdFAwI
 51UUuvXjaqOaL3Iqz/pb4Z8yWWZ1V0bE7YdOpaICdKu3BTpH+KKwTCBMut+2SdL8v9+a
 YEgw==
X-Gm-Message-State: APjAAAWtmrNkihAP5TWpsL1Rl8DkrDKG0ShGkh6+UvrkS2eYfPW5n8Yy
 T07rjDf5x/yCqqmS73p2RO58UsYxFPc=
X-Google-Smtp-Source: APXvYqyEFrJcgAfh9ObIQ6GwwCF7MJn74L4u61KdOMByxGKrBhGy5BtUtD6Y4qp/CIHxcl+lwjjByg==
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr24217264wrm.24.1579014613066; 
 Tue, 14 Jan 2020 07:10:13 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q3sm18155438wmj.38.2020.01.14.07.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 07:10:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D306C1FF8F;
 Tue, 14 Jan 2020 15:09:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 22/22] gdbstub: do not split gdb_monitor_write payload
Date: Tue, 14 Jan 2020 15:09:53 +0000
Message-Id: <20200114150953.27659-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114150953.27659-1-alex.bennee@linaro.org>
References: <20200114150953.27659-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
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
index b9fb8c0a95..6e461d871e 100644
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


