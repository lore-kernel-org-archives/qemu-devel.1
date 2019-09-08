Return-Path: <SRS0=PtAT=XD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D7C4332F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6C8214DB
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2019 06:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsKg+Hhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6C8214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6qW2-0004U7-Hq
	for qemu-devel@archiver.kernel.org; Sun, 08 Sep 2019 02:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUI-0002me-FQ
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUH-0002Qy-At
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:50 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i6qUH-0002Pa-2o
 for qemu-devel@nongnu.org; Sun, 08 Sep 2019 02:15:49 -0400
Received: by mail-wm1-x341.google.com with SMTP id c10so10339902wmc.0
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2019 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gvbw57hiwlFryOdHGOwYOwKt/bEEEiHivu3sJ0Hxopw=;
 b=FsKg+Hhfk9Acx5bx98OBBJNNKmF5Vm3lcggSlwFvXm26IYYe2ttQsjfSGhkdPyKOw2
 s9l4o9w9dK+QlEP09XQRqefcEKjH2ENTPFKeOoX007GPYebD80oylE2ld9F+n3HEqoGR
 wstANu+y/Ya225zBa7EKQGevNAxiLwqvu4lZf8Xx89rhOM28/3R/wMXSpnM+s57ybpB4
 zAoizS93dp6rcz4L6nVyu9l3vKkEWhiO+64iYeh6JFhFDZoO2zyEy7T3YobDR5c0QGh1
 G+p5GRyGFz29SQ+UKcbXqcRsPmmsW1jBrxHZP6Ts0/7R5dF0Il12ujE8zH8OsT2obZnk
 w5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gvbw57hiwlFryOdHGOwYOwKt/bEEEiHivu3sJ0Hxopw=;
 b=VVejevvL6Tk2VWySy9y0ngX2lGrfe4LrEixNJ9BHFgeeFj9ukfV7bB8jrYtKZTLJ2S
 4wlBBpQynAtEpqR7SXvGAHydf54tgJyY7wD2IudkWK5j629ugh4MfmWYGOse/JctNau+
 AMx+nUTw/K/m/2KUXbU2wWvGAUZ81jSJe8zckNZAJTU2psRKvad2fRukQQh1X2cb+xYs
 UpORFjbj3dWIMcJRsjMmmrNnDKnuyV4gipdchkpJpA/hxl6nCnROTqtmrCRWzo5XygNW
 EVcNdxc/toxNZdtCturrVIVOvSD6rZGTc5T6OFk55gHprD0lGyK2KNxbz1rgOIZE7mHl
 Bmzg==
X-Gm-Message-State: APjAAAXkBmIk29F3xnd1HfEUWL3uJqhhLcnKYjjpVyNjf++XnMOQZ2Xj
 OHx7pINonFnsiUFkONvSWC/r1SLb
X-Google-Smtp-Source: APXvYqy9wzWhZeehhEligxEhK7Ml+4Clhbz4jXngT3R6rU2xvllg8oUog1skvYeC/SoKnMolPjZ2Ag==
X-Received: by 2002:a1c:7407:: with SMTP id p7mr14634968wmc.31.1567923347848; 
 Sat, 07 Sep 2019 23:15:47 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id g201sm15616552wmg.34.2019.09.07.23.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Sep 2019 23:15:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Sun,  8 Sep 2019 08:15:37 +0200
Message-Id: <20190908061543.25136-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908061543.25136-1-f4bug@amsat.org>
References: <20190908061543.25136-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v6 2/8] linux-user/strace: Add print_timezone()
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
Cc: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
checkpatch error:
ERROR: storage class should be at the beginning of the declaration
---
 linux-user/strace.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f326c357a2..5ee9d62c25 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -63,6 +63,7 @@ UNUSED static void print_string(abi_long, int);
 UNUSED static void print_buf(abi_long addr, abi_long len, int last);
 UNUSED static void print_raw_param(const char *, abi_long, int);
 UNUSED static void print_timeval(abi_ulong, int);
+UNUSED static void print_timezone(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
 UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
@@ -1254,6 +1255,26 @@ print_timeval(abi_ulong tv_addr, int last)
         gemu_log("NULL%s", get_comma(last));
 }
 
+static void
+print_timezone(abi_ulong tz_addr, int last)
+{
+    if (tz_addr) {
+        struct target_timezone *tz;
+
+        tz = lock_user(VERIFY_READ, tz_addr, sizeof(*tz), 1);
+        if (!tz) {
+            print_pointer(tz_addr, last);
+            return;
+        }
+        gemu_log("{" TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld "}%s",
+                 tswapal(tz->tz_minuteswest), tswapal(tz->tz_dsttime),
+                 get_comma(last));
+        unlock_user(tz, tz_addr, 0);
+    } else {
+        gemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
-- 
2.20.1


