Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A25C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E37F2072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enTGWBfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E37F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYBl-00021H-Md
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:12:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2o-00063w-Bd
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2l-0008M2-2Z
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:10 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39523)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2k-0008Hy-Qb
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:06 -0500
Received: by mail-wm1-x32f.google.com with SMTP id 20so1481093wmj.4
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hDnMTI6Tisyyc4MUAZDZjzS6Nao0qdWk6sKjID5q248=;
 b=enTGWBfIQQZ4aaMxTNMEmogZ7YcH7CGbrEXTQfK0tNVWdGUQjJyrmJ/xjsntZ5qq8N
 eMATICr9B8EfvrEPh60NZ1Tq6lx0Xp/8dHW80KH8vjhQPvqvwdG2adm3D7AXCDR1/AET
 xose8T/DCjPZX9TqzH14Zs52xEm5kjLH9IQzu0skJL/xIXcgQKck1DYSlnF3z8bfthGY
 aNt2X6C9wzZQLLwkXv4MhDq4NVx7xKIJ08g0pUC0YPFagx0IvTfTDxgT29TbrmyYqKLo
 YbpzIeY6Owc4lWlnvO7XtbbI+MHZsYDqRKRUAXAfC/srS3k7+KjLL6/ZKmvhnWevwws6
 vb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=hDnMTI6Tisyyc4MUAZDZjzS6Nao0qdWk6sKjID5q248=;
 b=FN8KjrzIO1bXy/onnE26nLIvJSQQxJnaZEHgXei11hWwKJsBj5VmUasv3JvoSWHXgQ
 9RBz4mNKuWRMCaMgZNqRF3YluROpistC4+4D5/V+CF2TwIDM2oeb/YH5DC81PIiiqAQO
 0g9hq2o/6/UFjVKDLAsM7sDSSZoG2MEFM8Fm0ZHk8i+rGCh6fxERvfUm7vV5CWYDq2Rt
 cWhysnvDsmOFqXJVUdZngh0vr98N3xWaF1ZiFouZET5IdIiTNo3UXZ1Yr1xR61sw7Dbu
 oNecZGIemxeJHu5e9ujGj/Par0Fg5b+FH73QwMWM1Znn3G61eiCKdazQSbr6ydUhrzp5
 D7ZQ==
X-Gm-Message-State: APjAAAV8x8yL0bqvwzEB+BPK7cF0kAeYO0RrXbmSsc1j5GKPEeqfua2I
 HnNaTMtU43MU2kANUz7VanWR/gkX
X-Google-Smtp-Source: APXvYqw1qtJaloA/iZRFhYRg0/IBUYePXPN5rlud5t1eyL2s7twKSS0dXtT5mmRiblKZH8/Wc43mYQ==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr2841557wmb.174.1576670585533; 
 Wed, 18 Dec 2019 04:03:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/87] migration-test: Rename cmd_src/dst to
 arch_source/arch_target
Date: Wed, 18 Dec 2019 13:01:36 +0100
Message-Id: <1576670573-48048-11-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

This explains better what they do and avoid confussino with
command_src/target.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com> #s390x
Tested-by: Laurent Vivier <lvivier@redhat.com>
---
 tests/migration-test.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 14f2ce3..37e9663 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -549,7 +549,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                bool use_shmem, const char *opts_src,
                                const char *opts_dst)
 {
-    gchar *cmd_src, *cmd_dst;
+    gchar *arch_source, *arch_target;
     gchar *cmd_source, *cmd_target;
     const gchar *ignore_stderr;
     char *bootpath = NULL;
@@ -579,8 +579,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        cmd_src = g_strdup_printf("-drive file=%s,format=raw", bootpath);
-        cmd_dst = g_strdup(cmd_src);
+        arch_source = g_strdup_printf("-drive file=%s,format=raw", bootpath);
+        arch_target = g_strdup(arch_source);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -588,20 +588,20 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        cmd_src = g_strdup_printf("-bios %s", bootpath);
-        cmd_dst = g_strdup(cmd_src);
+        arch_source = g_strdup_printf("-bios %s", bootpath);
+        arch_target = g_strdup(arch_source);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
         memory_size = "256M";
-        cmd_src = g_strdup_printf("-nodefaults "
-                                  "-prom-env 'use-nvramrc?=true' -prom-env "
-                                  "'nvramrc=hex .\" _\" begin %x %x "
-                                  "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until'", end_address, start_address);
-        cmd_dst = g_strdup("");
+        arch_source = g_strdup_printf("-nodefaults "
+                                      "-prom-env 'use-nvramrc?=true' -prom-env "
+                                      "'nvramrc=hex .\" _\" begin %x %x "
+                                      "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
+                                      "until'", end_address, start_address);
+        arch_target = g_strdup("");
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
@@ -609,10 +609,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "virt,";
         machine_args = "gic-version=max";
         memory_size = "150M";
-        cmd_src = g_strdup_printf("-cpu max "
-                                  "-kernel %s",
-                                  bootpath);
-        cmd_dst = g_strdup(cmd_src);
+        arch_source = g_strdup_printf("-cpu max "
+                                      "-kernel %s",
+                                      bootpath);
+        arch_target = g_strdup(arch_source);
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
 
@@ -647,8 +647,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs,
-                                 cmd_src, shmem_opts, opts_src, ignore_stderr);
-    g_free(cmd_src);
+                                 arch_source, shmem_opts, opts_src,
+                                 ignore_stderr);
+    g_free(arch_source);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
@@ -660,8 +661,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size, tmpfs, uri,
-                                 cmd_dst, shmem_opts, opts_dst, ignore_stderr);
-    g_free(cmd_dst);
+                                 arch_target, shmem_opts, opts_dst,
+                                 ignore_stderr);
+    g_free(arch_target);
     *to = qtest_init(cmd_target);
     g_free(cmd_target);
 
-- 
1.8.3.1



