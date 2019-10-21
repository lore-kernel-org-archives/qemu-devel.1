Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D79CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:51:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3A8206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaaQZMEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3A8206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWDz-0007eG-Te
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBZ-0005UW-El
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBX-0003Au-E2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:17 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:33728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBR-00038a-Q1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id 6so1186856wmf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kVPn/TqsVrLsIWtsYnTYm7mIPjPA8vCaNQCpnpdWJRs=;
 b=ZaaQZMEIekiB+mZvzO3UPAfQ63y7KMYcpOfBE+mCuBT9eIucUiGueEjleHuz+pY+o3
 OEqHcFUCrmYAXu7fhCO9qF0o42w6c+gyj/9mBvj3pwp/frvH6x6J6sjVEnx5zFSP/HEZ
 86ooKHw/gIfQYYMoUwV3uBcDXDzpAgw26o42uWY47ht6LNQy7TjdFTfp/ioM+oO9wNvu
 I5tVZy7t2cqDQNvOqJKgRMDwiPvDacgyQKvYIskTA/zHUUsFrfxXGXOc/ohC5vmvOa7M
 wkyhp5SFFFuaoRFrK2Sx18HzS7qBGvmnn8uIDbHwseFraW974YJu2FaeI6vL64hO5wbd
 fWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=kVPn/TqsVrLsIWtsYnTYm7mIPjPA8vCaNQCpnpdWJRs=;
 b=GpioHnBlvnXgGuwI99CzaUZbef8zbI0ZBxsPne7EfIzrzMwVKDM3Ze42IMPmBAdvqR
 +mj1h0g3cjJkTyvuxKKgICsUwnyZalZhtoDJYEAP6in37xQb79t0/eqHdIpimM3EBEVc
 OH9C5bcK53q/j7oOITB2KLhUiSnSw92d6idVLDYTqnaThIRiLjVlKgOO0LBcKAkZp2bg
 DiklXBinofByQHJ5WKdFGB88F3107b8B3XBrRY2Ts8JfOwkpSS2BB25SDfHOb0lkOG9x
 nB7AyAhYNOZivN2CR40sHtzh45P046uXcUU3H+fHmwlMoREXEYwzMSuvb5IX2XK7x+oh
 z0rw==
X-Gm-Message-State: APjAAAV6nkKQG4qFXNca/PkdOpPR+wHSV1jYdhugu+XFwsVRDitclEk+
 vi7ktXOZINKCAubfJdQ73X7Tu02f
X-Google-Smtp-Source: APXvYqzVG8jajY24keh4SgZ1BdA+Q7TLB9Q9vV203Y3HpCMvA89X8iHHiqI/Cd/iKltuVXObltLc3A==
X-Received: by 2002:a1c:b6c4:: with SMTP id g187mr2974263wmf.54.1571658545489; 
 Mon, 21 Oct 2019 04:49:05 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 3/9] linux-user/strace: Improve settimeofday()
Date: Mon, 21 Oct 2019 13:48:51 +0200
Message-Id: <20191021114857.20538-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c    | 13 +++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2cd6687cd9..fd5596a640 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1583,6 +1583,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_settimeofday
+static void
+print_settimeofday(const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_timeval(arg0, 0);
+    print_timezone(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 63a946642d..1ff9168369 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1345,7 +1345,7 @@
 { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_settimeofday
-{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_settimeofday, NULL },
 #endif
 #ifdef TARGET_NR_setuid
 { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
-- 
2.21.0


