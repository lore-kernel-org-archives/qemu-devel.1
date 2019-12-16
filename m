Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1E9C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3E9206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZ+3HaWe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3E9206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtMm-0005nq-9A
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:37:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEx-0004jc-K2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEv-0006zM-A7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:59 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:45282)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEv-0006xW-2v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:57 -0500
Received: by mail-wr1-x42c.google.com with SMTP id j42so3844541wrj.12
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=jT9I9Ps2g95xmQ93zjEe27cZoWHjzkat4j8Vl4duSTw=;
 b=aZ+3HaWeOCiGOrOdWPNbhDMyL7jMBPUlx8Dv1ED6JsFjdQGsbJYGyFH20OJFFaMYje
 fCjemAxrfgGv9rEp56jae8uUutW6PuywTYNLWZ6084K1bHQC++JkQHDss00EL7DAsqmS
 b1ylVEmOOi5J2aD4IzooUX/grAuompkjaZD2KziQQGxm7sykkdh+7pFMWXAA670v6H/H
 UXC97WVRvv6U8OzNSVgOAE2rN7ldZSZlijD0nV6hBxj+lnLQZMXe8OV6nFmnbks7gK+6
 6XafnEqB0uMkPLpf6mZ61rYOakO/wwj8v6b9R/7+tiZxJFZxXZlhPZ/h0Y2dEYyGQYYm
 jeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=jT9I9Ps2g95xmQ93zjEe27cZoWHjzkat4j8Vl4duSTw=;
 b=nrsDiFOd/o12dVPg3s2sru3lGMzsBMKFWS70bY1tttc9p37HtCoReMo0f3qoPVmyeL
 Y9pfWBLl32vRWoGCXH0/0/LvxlyMcyWoCcIH/xFcrpxomf4ANaTVBBL445KkXJtrrboq
 bdSPyhca1rc48ySvTGDmHpsqBZHqRWtkWXbFCtSDAViEGZcgzzfpSIUXiZPg0IqrAh0T
 ZdlllucD/tQyiFNWr+pykdv6N8n4Hl09MDL+nrqfQEuPMXtVYZO/Pgcjmb+Dy0ZtSxUg
 TixoRDId60+get3xbBzkJ5hEuukr2A/56cYvIV8jlpeGYIZOJ1zm2cdFWMGSHmlChW0J
 N8ew==
X-Gm-Message-State: APjAAAXNgOkGuI0L4METDaN7OfGYXZUm84ZFKVli+SwNKG9uqjDDguUm
 R3xDLZXbMdebgGY4DKxj7jJA5by4
X-Google-Smtp-Source: APXvYqyb2A1EPr0b4NAa9FOELWVsP8XWOaCCR0g4/NxnrEswUva/t58xEBsPpQla0gPSUROMKlOigg==
X-Received: by 2002:adf:f18b:: with SMTP id h11mr30141404wro.56.1576513735826; 
 Mon, 16 Dec 2019 08:28:55 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/62] migration-test: Move -serial handling to common
 commandline
Date: Mon, 16 Dec 2019 17:27:52 +0100
Message-Id: <1576513726-53700-9-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
 tests/migration-test.c | 41 ++++++++++++++++-------------------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index a83e43b..85e270c 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -579,13 +579,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        cmd_src = g_strdup_printf(" -serial file:%s/src_serial"
-                                  " -drive file=%s,format=raw",
-                                  tmpfs, bootpath);
-        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial"
-                                  " -drive file=%s,format=raw"
+        cmd_src = g_strdup_printf("-drive file=%s,format=raw", bootpath);
+        cmd_dst = g_strdup_printf("-drive file=%s,format=raw"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -593,28 +590,22 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        cmd_src = g_strdup_printf(" -serial file:%s/src_serial -bios %s",
-                                  tmpfs, bootpath);
-        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial -bios %s"
+        cmd_src = g_strdup_printf("-bios %s", bootpath);
+        cmd_dst = g_strdup_printf("-bios %s"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
         memory_size = "256M";
-        cmd_src = g_strdup_printf("-nodefaults"
-                                  " -serial file:%s/src_serial"
-                                  " -prom-env 'use-nvramrc?=true' -prom-env "
+        cmd_src = g_strdup_printf("-nodefaults "
+                                  "-prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until'", tmpfs, end_address,
-                                  start_address);
-        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial"
-                                  " -incoming %s",
-                                  tmpfs, uri);
-
+                                  "until'", end_address, start_address);
+        cmd_dst = g_strdup_printf(" -incoming %s", uri);
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
@@ -623,14 +614,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_args = "gic-version=max";
         memory_size = "150M";
         cmd_src = g_strdup_printf("-cpu max "
-                                  "-serial file:%s/src_serial "
                                   "-kernel %s",
-                                  tmpfs, bootpath);
+                                  bootpath);
         cmd_dst = g_strdup_printf("-cpu max "
-                                  "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  bootpath, uri);
 
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -661,10 +650,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
     cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-name source,debug-threads=on "
+                                 "-serial file:%s/src_serial "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 memory_size,
+                                 tmpfs, memory_size,
                                  cmd_src, shmem_opts, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
@@ -673,9 +663,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
+                                 "-serial file:%s/dest_serial "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-                                 memory_size,
+                                 tmpfs, memory_size,
                                  cmd_dst, shmem_opts, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
-- 
1.8.3.1



