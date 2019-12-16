Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4284C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:33:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0392067C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWZL6Kbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0392067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtJV-00024W-B8
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEv-0004gG-Gv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtEu-0006x4-AH
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:57 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42388)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtEu-0006vV-3K
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:28:56 -0500
Received: by mail-wr1-x42a.google.com with SMTP id q6so8016008wro.9
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TSnXYhqE7z+X9M0OA1mdhorAedFwu58e9uHTbkURf20=;
 b=QWZL6KbqdXeZ7E/uTHME9OaY8f1QgP9Nd5a0OhnsBcg5ioJ3jzu6dXK427+6ZkZ9lA
 H0Ln9nnCn8fecLJ6CJbMSoNa+JE2HbISxp5s5IUv0L5eISZsGWIVaS0NOzWXmagA+O/O
 NTd8OylZPXMv+1JXWHJOVqlwMHwriW8XLptzpypZ/BN9gTg29Kf55gGSWtl38b1amJ91
 kV9XaQbMrVubg9EYTjNiD9svnJwtMzM7/kProteGAt/19/0tRZ4qNd0bAau1OE02SqQ+
 kKVeQHVEC1qfH2eN+TISDCMM77qoLVOdifmO8LDU3ih+YiMTcS0W3aWiwFHdbo6qmI4H
 HaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=TSnXYhqE7z+X9M0OA1mdhorAedFwu58e9uHTbkURf20=;
 b=GQBXv3xV3kBiZ9l3zXRADRfgU87+HEUFxqFvG9sGpnx0Vkwl2O9Nohr8UQCoOXfP0a
 +1Pg+QK0iQuz2B5WGka1Or/Lp2BBPJ17cdSY1Rt3rfRK8ROgBdVGdGubcD+eRZEhRGB2
 1dWqLNF/3h9UDd+92bmY45NHaQmOOBkxDbfh6GJGxZLUDr0cAkFHuhK6Cy2cn2GECt8F
 lDZaFIpCmTGezmgRR37bYt5ZhiK8YD6tvRdf1wvmEnZomGaEXltF+B0EGnH/WA+LHIHT
 a5T20tWDP7hVRB7WpE2VShqF7J95jLajQc7mZtGtxQ0P4mg0cbVqoJHii5boJE8at99T
 6Xjw==
X-Gm-Message-State: APjAAAWqeidgxTS0K0PSwqGqEeTvF6mYZ65yTdrb39ECSCT0yIKIC1Z4
 16CdYXtPRrhwrg+i64xhY7YL/mr+
X-Google-Smtp-Source: APXvYqzMnR/QPgRA61pW0lfcqXaHWMrIIFXoNQrJkuDFMqmN+zZHP6JGO+LkZL83+4EpJ44hzgOvMQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr31139360wrq.176.1576513734936; 
 Mon, 16 Dec 2019 08:28:54 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.28.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:28:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/62] migration-test: Move -name handling to common commandline
Date: Mon, 16 Dec 2019 17:27:51 +0100
Message-Id: <1576513726-53700-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
 tests/migration-test.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 85c98f0..a83e43b 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -579,12 +579,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "150M";
-        cmd_src = g_strdup_printf(" -name source,debug-threads=on"
-                                  " -serial file:%s/src_serial"
+        cmd_src = g_strdup_printf(" -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
                                   tmpfs, bootpath);
-        cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
-                                  " -serial file:%s/dest_serial"
+        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
                                   tmpfs, bootpath, uri);
@@ -595,11 +593,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "";
         machine_args = "";
         memory_size = "128M";
-        cmd_src = g_strdup_printf(" -name source,debug-threads=on"
-                                  " -serial file:%s/src_serial -bios %s",
+        cmd_src = g_strdup_printf(" -serial file:%s/src_serial -bios %s",
                                   tmpfs, bootpath);
-        cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
-                                  " -serial file:%s/dest_serial -bios %s"
+        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial -bios %s"
                                   " -incoming %s",
                                   tmpfs, bootpath, uri);
         start_address = S390_TEST_MEM_START;
@@ -609,15 +605,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_args = ",vsmt=8";
         memory_size = "256M";
         cmd_src = g_strdup_printf("-nodefaults"
-                                  " -name source,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -prom-env 'use-nvramrc?=true' -prom-env "
                                   "'nvramrc=hex .\" _\" begin %x %x "
                                   "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
                                   "until'", tmpfs, end_address,
                                   start_address);
-        cmd_dst = g_strdup_printf(" -name target,debug-threads=on"
-                                  " -serial file:%s/dest_serial"
+        cmd_dst = g_strdup_printf(" -serial file:%s/dest_serial"
                                   " -incoming %s",
                                   tmpfs, uri);
 
@@ -628,11 +622,11 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         machine_type = "virt,";
         machine_args = "gic-version=max";
         memory_size = "150M";
-        cmd_src = g_strdup_printf("-name vmsource,debug-threads=on -cpu max "
+        cmd_src = g_strdup_printf("-cpu max "
                                   "-serial file:%s/src_serial "
                                   "-kernel %s",
                                   tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-name vmdest,debug-threads=on -cpu max "
+        cmd_dst = g_strdup_printf("-cpu max "
                                   "-serial file:%s/dest_serial "
                                   "-kernel %s "
                                   "-incoming %s",
@@ -666,6 +660,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
+                                 "-name source,debug-threads=on "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
@@ -676,6 +671,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     g_free(cmd_source);
 
     cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
+                                 "-name target,debug-threads=on "
                                  "-m %s "
                                  "%s %s %s %s",
                                  machine_type, machine_args,
-- 
1.8.3.1



