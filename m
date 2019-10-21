Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F4BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B7820640
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZRyyZdw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B7820640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMWJ9-0005v2-0j
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBX-0005UK-FV
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBV-0003AT-H9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:15 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iMWBR-00038H-Pg
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 07:49:12 -0400
Received: by mail-wm1-x343.google.com with SMTP id f22so12459462wmc.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8NQh2EnS1JgP+wDg616iXQrQceQKStyvquiY+j2RVrE=;
 b=LZRyyZdwseS7+zVS+ewx1DMbss0zeH8x4kMndWUwewVGpkooXJdLhKtYUO+EXxG3o6
 Wx9cbGv52MF20MvlFdCaGDWI/xxByiRokPQsCMw6hhL+5xphf08s1KPN4ZRO/OgZRrGo
 nSVVZrs6o2sXO+l62a36lESrzcIrxrf7N47ifpyPGVpYidkUxmiAAVjqLLNS2XLmJHoz
 IVj4uXI1puPT6yaOx0fPuroMYhrMeUvVnKwBFPUWUobJDkNt3Qux4OMYh1JrvZNPgHVX
 jc3TjjJydswOtjdQjm5WlPjRPxarIzq/HIxoJwf7Lm1DYIRlP3Z3ZFtz8m6M2hUWq45K
 1L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8NQh2EnS1JgP+wDg616iXQrQceQKStyvquiY+j2RVrE=;
 b=DwnZPdm2/2MHsSNB6lHX+tf8Vf6GHd0geiRZA/VoJn7t/z5ImB7QnqZUqruD6Bxgv7
 gVfk/Z4KRudoXu6RnNtO1goOqsnVw0NIfAN8hPpFkilYC2pJwfy1XwDfqCvSaOH9C/nk
 Ln1WSb6fqNf9qdH4tSItVGS0lmMWOMJXsZ7SBF93mJZVRAIYP5tkQQdlqY6vuHcZEBDl
 65J3gN17YEnqG5uZj0+uq3GNYKloE9u9YWM48kbLNzfMG8tMPMCk+yvMwtJIqfVKrlWQ
 +zH6Si6StvgYxTGd9b6g3sWTkOEHymqk/m3YDBgpM4BIA9allytMdX2kRHJO/W2a2UJG
 Z4QQ==
X-Gm-Message-State: APjAAAXqYbUxmncVM/g9V1KK3g8aWWBfm0//oCFiJ92FRTJiqEQuC5MA
 N7BYq9HckZruVeDFlVF7NnejQS/3
X-Google-Smtp-Source: APXvYqx20xKnmyWBhq/jF7o50m+V4hM/+XJ98M+7wgwfjssqrnqwa7RPAwoOaPRyjKVdQySnJr9lLA==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr19518924wmj.48.1571658543471; 
 Mon, 21 Oct 2019 04:49:03 -0700 (PDT)
Received: from localhost.localdomain
 (129.red-83-57-174.dynamicip.rima-tde.net. [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id x5sm17156137wrt.75.2019.10.21.04.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 04:49:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 2/9] linux-user/strace: Add print_timezone()
Date: Mon, 21 Oct 2019 13:48:50 +0200
Message-Id: <20191021114857.20538-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021114857.20538-1-f4bug@amsat.org>
References: <20191021114857.20538-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v7: tz_minuteswest and tz_dsttime are abi_int -> %d/tswap32 (lvivier)

checkpatch error:
 ERROR: storage class should be at the beginning of the declaration
 #9: FILE: linux-user/strace.c:66:
 +UNUSED static void print_timezone(abi_ulong, int);
---
 linux-user/strace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f326c357a2..2cd6687cd9 100644
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
@@ -1254,6 +1255,25 @@ print_timeval(abi_ulong tv_addr, int last)
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
+        gemu_log("{%d,%d}%s", tswap32(tz->tz_minuteswest),
+                 tswap32(tz->tz_dsttime), get_comma(last));
+        unlock_user(tz, tz_addr, 0);
+    } else {
+        gemu_log("NULL%s", get_comma(last));
+    }
+}
+
 #undef UNUSED
 
 #ifdef TARGET_NR_accept
-- 
2.21.0


