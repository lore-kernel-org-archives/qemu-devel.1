Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C51C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F22D22067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRCNwmqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22D22067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtGn-0006em-DQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEt-0004dc-R1
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEs-0006tB-Gj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:55 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEs-0006rA-8p
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:54 -0500
Received: by mail-wr1-x435.google.com with SMTP id b6so8070091wrq.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MigzyWj+F7hTHupvGUMkFQy7vhes1xwrq5hfxQuvvdk=;
 b=tRCNwmqec1PksABPpXFhpmRzE6dkX0FHy9s1IfcFQyGmRI7z9XoJhTKMkPy+Fl/BTA
 6gMolq6VOb4AV54un0fJ0w8BkbJFL8ME6M8D+6VQ/AmQBPV7r/xZg65/UT6iLg8ao2+x
 SR7syR9f/Rs52ih5RJaY56EYFYeU+DwDxIOlZpjFSUcqXc3c4kIHhQTgmreXiqfDbyT1
 ZOw7veq0c2C2B5F1J+MS+NeacGa5ZCPbbng0MnfvRlupE43pjE7goQjcJbm/Hw4RwMhS
 5UWDGwyXgYsuodz5164oPmlTDGsBAWSTLuYLWf/zuL4pHzGRVXT88wyfeENRwlmBqJjN
 i9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=MigzyWj+F7hTHupvGUMkFQy7vhes1xwrq5hfxQuvvdk=;
 b=ouMJlOj078CxhOcKW0Vk+JQesitE2c8m59aQWdbFyGs+pscc6MIr/QRZOdZAJ0iVhb
 LdZ/h0ZOHjYeNj2FMuujh2E+ohgl/cAz9FJP7B6RbA/W++sF2C8k+NzG35TtyKvSessF
 dBbUQ0ApTwckIZmPvAm3kF0j6619MOWLIJib5mZQuktssA1rdzjdzxLrk1qINCiQ6/CV
 AAl1/6BQwEoP4VJs1PWjmbxyAyeR/sgvfeNRHcxRuWZ4QGzXx78tdWmwhJ9byt4kQuBJ
 1CkPWw1cZVVXkqu8mxSwJ3I2F4aegV4JWlAJX+XZ6ocKvKPSLIj2PmS+c2Zf+wuV72z1
 r0cA==
X-Gm-Message-State: APjAAAW08uRuFibn3DwpX2UiWoT4R/NLi4ktVFSQXUNW0RPs12ApgjFE
 gL4XWS+idhHY1v8TJPI6Vk4cgrky
X-Google-Smtp-Source: APXvYqxu4W6COsEZb1Nue9k3E46pUFCYfa+sbPSxVfP0mkR5PtpQhurI4ELDMc7JnCsWO2oIVJ/2pQ==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr31114588wrp.322.1576513732953; 
 Mon, 16 Dec 2019 08:28:52 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/62] migration-test: Move memory size to common commandline
Date: Mon, 16 Dec 2019 17:27:49 +0100
Message-Id: <1576513726-53700-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 tests/migration-test.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 39203f6..18857f0 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -565,6 +565,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *arch = qtest_get_arch();
     const char *machine_type;
     const char *machine_args;
+    const char *memory_size;
 
     opts_src = opts_src ? opts_src : "";
     opts_dst = opts_dst ? opts_dst : "";
@@ -585,15 +586,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
         machine_type = "";
         machine_args = "";
-        extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-m 150M"
-                                  " -name source,debug-threads=on"
+        memory_size = "150M";
+        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
+        cmd_src = g_strdup_printf(" -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw %s",
                                   tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-m 150M"
-                                  " -name target,debug-threads=on"
+        cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s %s",
@@ -605,14 +605,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
         machine_type = "";
         machine_args = "";
-        extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-m 128M"
-                                  " -name source,debug-threads=on"
+        memory_size = "128M";
+        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
+        cmd_src = g_strdup_printf(" -name source,debug-threads=on"
                                   " -serial file:%s/src_serial -bios %s %s",
                                   tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-m 128M"
-                                  " -name target,debug-threads=on"
+        cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial -bios %s"
                                   " -incoming %s %s",
                                   tmpfs, bootpath, uri,
@@ -622,8 +621,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     } else if (strcmp(arch, "ppc64") == 0) {
         machine_type = "";
         machine_args = ",vsmt=8";
-        extra_opts = use_shmem ? get_shmem_opts("256M", shmem_path) : NULL;
-        cmd_src = g_strdup_printf("-m 256M -nodefaults"
+        memory_size = "256M";
+        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
+        cmd_src = g_strdup_printf("-nodefaults"
                                   " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=true' -prom-env "
@@ -631,8 +631,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                   "until' %s", tmpfs, end_address,
                                   start_address, extra_opts ? extra_opts : "");
-        cmd_dst = g_strdup_printf("-m 256M"
-                                  " -name target,debug-threads=on"
+        cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s %s",
                                   tmpfs, uri,
@@ -644,14 +643,15 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
         machine_type = "virt,";
         machine_args = "gic-version=max";
-        extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
+        memory_size = "150M";
+        extra_opts = use_shmem ? get_shmem_opts(memory_size, shmem_path) : NULL;
         cmd_src = g_strdup_printf("-name vmsource,debug-threads=on -cpu max "
-                                  "-m 150M -serial file:%s/src_serial "
+                                  "-serial file:%s/src_serial "
                                   "-kernel %s %s",
                                   tmpfs, bootpath,
                                   extra_opts ? extra_opts : "");
         cmd_dst = g_strdup_printf("-name vmdest,debug-threads=on -cpu max "
-                                  "-m 150M -serial file:%s/dest_serial "
+                                  "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s %s",
                                   tmpfs, bootpath, uri,
@@ -674,15 +674,21 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         ignore_stderr = "";
     }
 
-    cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s %s %s %s",
+    cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
+                                 "-m %s "
+                                 "%s %s %s",
                                  machine_type, machine_args,
+                                 memory_size,
                                  cmd_src, opts_src, ignore_stderr);
     g_free(cmd_src);
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
-    cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s %s %s %s",
+    cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
+                                 "-m %s "
+                                 "%s %s %s",
                                  machine_type, machine_args,
+                                 memory_size,
                                  cmd_dst, opts_dst, ignore_stderr);
     g_free(cmd_dst);
     *to = qtest_init(cmd_target);
-- 
1.8.3.1



