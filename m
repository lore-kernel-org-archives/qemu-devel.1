Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC0C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6483206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxbOI9WP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6483206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtPS-0001Al-E3
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:39:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEx-0004iz-7l
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEw-00070w-2w
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:59 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:53581)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEv-0006z7-Sa
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:58 -0500
Received: by mail-wm1-x32c.google.com with SMTP id m24so6034546wmc.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3ihEo7p0QbN2mTro2zOBTwTmqJafQZGvJFrYh7PK3bc=;
 b=hxbOI9WPbLZK3RpWV7/cYjs31honWKW26bVGaTJjdKcdsZBZiwnZNezCWQBNqb2Uib
 lQRX8ADfKJ6851sOu2vZO4U+ueDjpZtinr39JJPpfC+FsJzrCApqXlIRSpX8ldRw8TgY
 FvFcVdLAlQDrWofyhhEc9ylwB9PLD47zoPV3ywRtHQn0Rd47UVprp4r7VpAgVSZ5ahWU
 NC+Odwl3ioIOLUNXbx7HoVUtQbMaLYbbEhc0EohZi2EM436SJYZUTKAMphzE7zGp12/1
 RDfPCu+w6qlop6/vAsUPYgaXPTpB/yInDEINVlhAWx7SLQgbi7bUaKs+2cPi8xqDgoOi
 fHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=3ihEo7p0QbN2mTro2zOBTwTmqJafQZGvJFrYh7PK3bc=;
 b=XYfqbAEX6av8Qz6TjAguDwxQ8ZWtNyuzlnSe2o0zMS8MmhiYSwMEBVveVlzeeQXn+m
 1cO3Y6DFQAvYtgDOCiI5JnbDp+ZMBCFrdnuEt1ttO/3/84BMcEtCQS6734VzFoys5GQ6
 B+8iTvPq4kVq63SJDG2fXJ273W20meWjIyBvqnZWb+KdLbzocnkNkiVKA3HTmgHJcDbe
 lPWMTh6JVdN2XwY6IPizL2qw/kCR6K7aVj0+fxJ/olLygaEm/EUqHg02DTGZXzqd10MR
 jAb0IwB4O/NelLL66DnynsC3KT8k6IkjMNqhcwgVjVg32+5JHrup3UQD4GWjIThXpGk9
 xmBQ==
X-Gm-Message-State: APjAAAUhTJQ97unFE443fbCmcuPHFSmGDjXdzSox5wTZCVQtGpRyWO6o
 gci4tYoVjE+ZgpsU5SOVPGpa15E/
X-Google-Smtp-Source: APXvYqxJw2EVkh/w9RmOma6rBmNuN1jS8omOA0WJsb8y5SH0Ohmi0V+ByvfN1j1RbdWnWHzfRcaebg==
X-Received: by 2002:a1c:9d8b:: with SMTP id g133mr30263697wme.27.1576513736631; 
 Mon, 16 Dec 2019 08:28:56 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:56 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/62] migration-test: Move -incomming handling to common
 commandline
Date: Mon, 16 Dec 2019 17:27:53 +0100
Message-Id: <1576513726-53700-10-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
Cc: Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Juan Quintela <quintela@redhat.com>

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 85e270c..5ab8cfd 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -580,9 +580,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_args = "";
         memory_size = "150M";
         cmd_src = g_strdup_printf("-drive file=%s,format=raw", bootpath);
-        cmd_dst = g_strdup_printf("-drive file=%s,format=raw"
-                                  " -incoming %s",
-                                  bootpath, uri);
+        cmd_dst = g_strdup(cmd_src);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -591,9 +589,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_args = "";
         memory_size = "128M";
         cmd_src = g_strdup_printf("-bios %s", bootpath);
-        cmd_dst = g_strdup_printf("-bios %s"
-                                  " -incoming %s",
-                                  bootpath, uri);
+        cmd_dst = g_strdup(cmd_src);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
@@ -605,7 +601,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                   "until'", end_address, start_address);
-        cmd_dst = g_strdup_printf(" -incoming %s", uri);
+        cmd_dst = g_strdup("");
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
@@ -616,11 +612,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         cmd_src = g_strdup_printf("-cpu max "
                                   "-kernel %s",
                                   bootpath);
-        cmd_dst = g_strdup_printf("-cpu max "
-                                  "-kernel %s "
-                                  "-incoming %s",
-                                  bootpath, uri);
-
+        cmd_dst = g_strdup(cmd_src);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
 
@@ -650,11 +642,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-name source,debug-threads=on "
-                                 "-serial file:%s/src_serial "
                                  "-m %s "
+                                 "-serial file:%s/src_serial "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 tmpfs, memory_size,
+                                 memory_size, tmpfs,
                                  cmd_src, shmem_opts, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
@@ -664,9 +656,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
+                                 "-incoming %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 tmpfs, memory_size,
+                                 memory_size, tmpfs, uri,
                                  cmd_dst, shmem_opts, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
-- 
1.8.3.1



