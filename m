Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09324C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C415620716
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioOoB3Nx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C415620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY9H-0006l6-A6
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:09:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2j-00060W-1k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2h-00084M-F0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:04 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2h-0007z5-3n
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:03 -0500
Received: by mail-wm1-x334.google.com with SMTP id d139so4489865wmd.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aH3EykeL08EUheSeMlIhlQO84iNBgJfxB8x8n+2PQ/0=;
 b=ioOoB3NxuLOzcJHDbLNGZi7sZQbdaAsNahg0lKjnjxVQrJR1P6gNHUjdzEZrEA19Us
 h3+i6dJPf/NmzlyidLCVfVieZWHIlaiaqKLeRO80Xs61yEm6T/Sp/51u9kDIjA6Jfb9i
 Pf5nn0K54gRPh6+rtHXdNYVLvI0sp2EhE+G3UHUSAw+sp5gQKmuCo4p3c/5EsiJbflvq
 KzLPCXGdl+4uu4+ZB0tMetw5ZJvGay4TMBE1EZ5xmtWQHgVU6i3eI6RbZWkRz9i0aeQJ
 G11KGMkZjbX9ClmWCKm0+XBXM3YHGVP6+WcR7+lgL+lemFjV9U7FWtqODRXe2OVVHs2b
 1gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=aH3EykeL08EUheSeMlIhlQO84iNBgJfxB8x8n+2PQ/0=;
 b=c1rt37KHm7mqFt93gQhnPBF8xdkEo5Igbs+16AGmBejiQd6I3sgkMZoDpYWxv1abMt
 vLV7mYL6B4mBlq7G5P8NBJCT0y9+qDEhHLSCInGF6Sl3zXbZn5bnrxPYoB8jPT3VE0ej
 XYO6+8+sDjzbIbi7ySxji9Qo0D3pLTz1DJ+XaE4vA0guBWOX2tnbayqU1rfcyt8mLvH8
 yxNi7GcX5AU9o9ZahIRPVACcNz7kKlzDVSlsoO9vTmTPmgb2dCD09V8zw+pE420PEXr2
 2Rx6ZD6dSo8weznM/Wk34g9vtLPWGi4IAvTOE7YZ/wEm21n+QykdGwbw6X97kgqxCnJU
 ZgfQ==
X-Gm-Message-State: APjAAAWEQmyaDzAPk/1PpaDPC5qGglJ3oVtfMBWGsTyNQis7e00zyl0G
 Hs+BQtE561Z1uEshET+GzsdVQ3Mz
X-Google-Smtp-Source: APXvYqwEKgd7hr2a9uFcGVItVQLxGG1RROYeMjajswDvI70fq0Fqcr++314xfGXrUlpaCuOLaUEs3Q==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr2955083wmk.15.1576670581640; 
 Wed, 18 Dec 2019 04:03:01 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:00 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/87] migration-test: Move shmem handling to common commandline
Date: Wed, 18 Dec 2019 13:01:32 +0100
Message-Id: <1576670573-48048-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
 tests/migration-test.c | 76 ++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 42 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 9d40f2d..e17d432 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -380,13 +380,6 @@ static void cleanup(const char *filename)
     g_free(path);
 }
 
-static char *get_shmem_opts(const char *mem_size, const char *shmem_path)
-{
-    return g_strdup_printf("-object memory-backend-file,id=mem0,size=%s"
-                           ",mem-path=%s,share=on -numa node,memdev=mem0",
-                           mem_size, shmem_path);
-}
-
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
     switch (addr->type) {
@@ -560,8 +553,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     gchar *cmd_source, *cmd_target;
     const gchar *ignore_stderr;
     char *bootpath = NULL;
-    char *extra_opts = NULL;
-    char *shmem_path = NULL;
+    char *shmem_opts;
+    char *shmem_path;
     const char *arch = qtest_get_arch();
     const char *machine_type;
     const char *machine_args;
@@ -575,7 +568,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
             g_test_skip("/dev/shm is not supported");
             return -1;
         }
-        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
     }
 
     got_stop = false;
@@ -587,18 +579,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf(" -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
-                                  " -drive file=%s,format=raw %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  " -drive file=%s,format=raw",
+                                  tmpfs, bootpath);
         cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
-                                  " -incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
@@ -606,36 +595,31 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf(" -name source,debug-threads=on"
-                                  " -serial file:%s/src_serial -bios %s %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  " -serial file:%s/src_serial -bios %s",
+                                  tmpfs, bootpath);
         cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial -bios %s"
-                                  " -incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, bootpath, uri);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
         memory_size = "256M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf("-nodefaults"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
-                                  "until' %s", tmpfs, end_address,
-                                  start_address, extra_opts ? extra_opts : "");
+                                  "until'", tmpfs, end_address,
+                                  start_address);
         cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
-                                  " -incoming %s %s",
-                                  tmpfs, uri,
-                                  extra_opts ? extra_opts : "");
+                                  " -incoming %s",
+                                  tmpfs, uri);
 
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
@@ -644,18 +628,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "virt,";
         machine_args = "gic-version=max";
         memory_size = "150M";
-        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf("-name vmsource,debug-threads=on -cpu max "
                                   "-serial file:%s/src_serial "
-                                  "-kernel %s %s",
-                                  tmpfs, bootpath,
-                                  extra_opts ? extra_opts : "");
+                                  "-kernel %s",
+                                  tmpfs, bootpath);
         cmd_dst = g_strdup_printf("-name vmdest,debug-threads=on -cpu max "
                                   "-serial file:%s/dest_serial "
                                   "-kernel %s "
-                                  "-incoming %s %s",
-                                  tmpfs, bootpath, uri,
-                                  extra_opts ? extra_opts : "");
+                                  "-incoming %s",
+                                  tmpfs, bootpath, uri);
 
         start_address = ARM_TEST_MEM_START;
         end_address = ARM_TEST_MEM_END;
@@ -666,7 +647,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     g_free(bootpath);
-    g_free(extra_opts);
 
     if (hide_stderr) {
         ignore_stderr = "2>/dev/null";
@@ -674,26 +654,38 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
+    if (use_shmem) {
+        shmem_path = g_strdup_printf("/dev/shm/qemu-%d", getpid());
+        shmem_opts = g_strdup_printf(
+            "-object memory-backend-file,id=mem0,size=%s"
+            ",mem-path=%s,share=on -numa node,memdev=mem0",
+            memory_size, shmem_path);
+    } else {
+        shmem_path = NULL;
+        shmem_opts = g_strdup("");
+    }
+
     cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-m %s "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size,
-                                 cmd_src, opts_src, ignore_stderr);
+                                 cmd_src, shmem_opts, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
     cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
                                  "-m %s "
-                                 "%s %s %s",
+                                 "%s %s %s %s",
                                  machine_type, machine_args,
                                  memory_size,
-                                 cmd_dst, opts_dst, ignore_stderr);
+                                 cmd_dst, shmem_opts, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
     g_free(cmd_target);
 
+    g_free(shmem_opts);
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid becase QEMU has already opened this file
-- 
1.8.3.1



