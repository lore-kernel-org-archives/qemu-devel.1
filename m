Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5C5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB682072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaT/ejRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB682072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY4o-0008Bb-0P
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2h-0005yR-NX
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2g-0007xb-6a
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:03 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:41745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2f-0007tP-Su
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:02 -0500
Received: by mail-wr1-x430.google.com with SMTP id c9so1997935wrw.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=srkmaf06yoLUqqvgRxOJoc6+fa6oxP9fbSy0KoDwxQ0=;
 b=FaT/ejRMTb0VBSunUWeQmI3WFUVzgBwnc9sRDeraaDUVLLZ/lFY42ViODDOxDyHNQ1
 g02uW52LQEJNUIzlb3UwhIQuM9j7YC1ewa7Ql77Bf4H+YhtunX+YWo/S+nKzzZP3jEMY
 3eRwWDQDDGvV7MI9fdUrKjugMI6K0d9UCAVHjYCG0Szg1IFo6+CfVsboNPnIdX9wt0S7
 EMufhyuP/hAM/UIg0MsUX7VDDpSwYUXZb12p405n1DwdkfZDfsTlT1jJ/GMr8ivKPWcx
 3uEZWH7GwWwfVrAlmk12vV+AgiHgITQrt9aaN2x/DsoYqPV7cI8uCLKF37tfgDLZaac+
 ilNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=srkmaf06yoLUqqvgRxOJoc6+fa6oxP9fbSy0KoDwxQ0=;
 b=TCeNNYYHWyjm6mzoJnrKcmJw/u5sT8Mn7lzb64gXZ7uQJYIV4MKJOnXw5XhdnIESTi
 nKovbvEmVWlHrQybYCbwZKVwfwQzwVI0Akx9rIxiskqumM1y83mJb7GQRqJINvexG00C
 xYoyWt4mCGId3YvznxBjKJqAg2XAfI+cHxqKCQKoWrpJvBap2yIuuJUyZIt3/uCW2BGp
 Pi230Ox0mn35DXSwF0r/+aoNpCgQ7BG9LsXJvjkqh0DsKYhKRTE3CckawEoaboYVJlRP
 SBacOgK8i8Y1PJjBSaaPKIWSgs/zPggSHM0s9kmgCcI+vUoiX75TfyBlmjj7e6TPUU74
 P/7g==
X-Gm-Message-State: APjAAAXaFQG6FVn2u5k0Wzj1PcwpN6kILDCCkxG2RxESRccf1vjHdOr6
 IMoz2vEwlGF7Z1wNrTE0q+0VSul1
X-Google-Smtp-Source: APXvYqwNPOP0VPFg7LSrcB0hJRJkjSmj5r6V2FVC6r92H3MCq8yN3MIZzPXSCNvUs3duRCAf7QVTGg==
X-Received: by 2002:adf:f508:: with SMTP id q8mr2442302wro.334.1576670580371; 
 Wed, 18 Dec 2019 04:03:00 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.02.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:02:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/87] migration-test: Move memory size to common commandline
Date: Wed, 18 Dec 2019 13:01:31 +0100
Message-Id: <1576670573-48048-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
index 5a63158..9d40f2d 100644
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



