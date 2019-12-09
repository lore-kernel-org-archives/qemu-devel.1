Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA5FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 542D32077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 15:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVt1heXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542D32077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieKct-0000AK-5a
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 10:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXq-0003L7-Ci
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ieKXp-0001Ey-A4
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:54 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51800)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ieKXp-0001EM-4H
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 10:01:53 -0500
Received: by mail-wm1-x342.google.com with SMTP id g206so15857664wme.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2019 07:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4/2rFG2uQPrnJ3NY/tRy/zI0rCDFvW24BIkyj5B4cS8=;
 b=aVt1heXPjfklF8r5JXHDoRMl1pjQ+Qcg3kziIyQElXzTT6N3IgAOAbs71zqQMSORDI
 6vr2nUdUdlAkzBmS9QddlhUB9HKS/2XuMjvD0jekW6C3Pe6zR/kwxYAi53HtX5jHI6Lo
 hKVNT1yh7E8zux9EFZT0ig2HP6QzaeEGgbJhAgBhFmxaPIWDeG7eLnY5GWGJSkFJdiXW
 FIYP6yxTTn1GLotZi75nO2pZQzmvidxDVZnyhnSx0s8w6u+d4pwnm4IpyshOhR+0nGNy
 bdYQSHKgBrA62ftD9tLaM15txlApqwRv2zw5j5UMyKS5s6Dx4ySC8iAM5IUNvDzkGgI7
 im6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=4/2rFG2uQPrnJ3NY/tRy/zI0rCDFvW24BIkyj5B4cS8=;
 b=pmhmOqAIKrDapHase1Ij/6G7pE217vv18TnFbqtjkV2J8XG9KHdy4C8pWIdqBvSwB4
 UEZ18PW0luFmXgbefOx4xMLJDj+Kj6sTD/oft23rToMDhlVbSNPYhXlqjPJGxT1o6GnG
 74VEg9LcSK1Fhac/vdWj3M6qUVibCmoyU5M3OlAZc1IrjT5/OmkYh6Pr+udTZP1UuaV1
 Bb2gN+uYs5oczBfQbEMSRh5/q8cLC3DT4hH21j6ngbcuxAkJfD/2i/kLXLFdRJMX9G0C
 9BaqQZHwmTdQG/tHFev5u8+qXOcqXF3vWOR2iRoNLtKW0/6rl4ELgmj1w/OeuYehh0o/
 mcmA==
X-Gm-Message-State: APjAAAUQKAERLSjM40QgECLC22eaXKKl83Pu6KCptDJFttfJfr922wPA
 5Ezz66hVkXjURhWuypNDWvKuezxz
X-Google-Smtp-Source: APXvYqzzoTQHMLsSext7/G6Hc3Cyqw9mYv8UFHrMXvFldX0VkxQj2irJggTRYPjJwLQMZB8a+dutTA==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr26540735wmg.34.1575903711884; 
 Mon, 09 Dec 2019 07:01:51 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g9sm27219371wro.67.2019.12.09.07.01.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Dec 2019 07:01:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/18] vl: extract accelerator option processing to a
 separate function
Date: Mon,  9 Dec 2019 16:01:31 +0100
Message-Id: <1575903705-12925-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
References: <1575903705-12925-1-git-send-email-pbonzini@redhat.com>
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
Cc: thuth@redhat.com, elmarco@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As a first step towards supporting multiple "-accel" options, push the
late processing of -icount and -accel into a new function, and use
qemu_opts_foreach to retrieve -accel options instead of stashing
them into globals.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index f69fea1..1ad6dfb 100644
--- a/vl.c
+++ b/vl.c
@@ -2831,6 +2831,25 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
     return 0;
 }
 
+static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
+{
+    if (tcg_enabled()) {
+        qemu_tcg_configure(opts, &error_fatal);
+    }
+    return 0;
+}
+
+static void configure_accelerators(void)
+{
+    qemu_opts_foreach(qemu_find_opts("accel"),
+                      do_configure_accelerator, NULL, &error_fatal);
+
+    if (!tcg_enabled() && use_icount) {
+        error_report("-icount is not allowed with hardware virtualization");
+        exit(1);
+    }
+}
+
 int main(int argc, char **argv, char **envp)
 {
     int i;
@@ -4258,14 +4277,7 @@ int main(int argc, char **argv, char **envp)
     qemu_spice_init();
 
     cpu_ticks_init();
-    if (!tcg_enabled() && use_icount) {
-        error_report("-icount is not allowed with hardware virtualization");
-        exit(1);
-    }
-
-    if (tcg_enabled()) {
-        qemu_tcg_configure(accel_opts, &error_fatal);
-    }
+    configure_accelerators();
 
     if (default_net) {
         QemuOptsList *net = qemu_find_opts("net");
-- 
1.8.3.1



