Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA49C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:09:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A6C02072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxqzuzWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6C02072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihY9M-0006sa-2B
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:09:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45261)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2j-00061T-Nv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY2i-00089q-H1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:05 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY2i-00084g-6i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:04 -0500
Received: by mail-wr1-x436.google.com with SMTP id q10so1982645wrm.11
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S5gg3HelWS0RPKMW3/Z/axKXbBTscXO2B/ZJUs+kb3g=;
 b=kxqzuzWBzC02WaR4k1mOP91wbzCLveS5Rf95RJWHhB/KbLk0C2YIGhOesy6xtABbmQ
 RVUts1IBxJSBcPqhmcDVPhPz3N1XuTVZ+g7NBFhHnhi+gWMqZYeSXt5Fsm/04KTWHEe9
 UmtKfgoslzsvJa9P89GGv4yW0voJ3mwh3aoBe+q2naN2Adyksc09bnSNhZ6PvbNMB5od
 lVFAf7lNVQnmS/9QNMTA2oiqur3FLYAI/PnzQqkM1hQd7xyEE6IJ9YwF+Ve2PzIxd9hW
 IbKO0OE/VyaLKvUeEaQIyEmnnG5d6w3UT/MOGw+toAlwCtwMidZhfOJNIlw/fEF6nCnH
 XO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=S5gg3HelWS0RPKMW3/Z/axKXbBTscXO2B/ZJUs+kb3g=;
 b=lg4jN7q491zEPLJ53kXj0BLJN4CeF0v7V4RFjx9aoPryEj+pARzRVkkhJYFCQf9aam
 bePisTKM33BYEcN+zm805yc0YVJeYzrK717HYToCokzvvu3b8ZBnokZTUAp8Ux4tJn/O
 FDHuN9fjERQs9uI3jTTUxWZuW/xibsIDP4qezRGT0kdRLdMFguCofd1NJEphM9vFQXfR
 1XIdMGOGyHy5uUUAv1A7J9wwjgViXUoqpESk5TWCWdP/6Zhg1WZEMFzcUkJpbKtxjYIe
 CzNFscOJvbKLLXfBils028HcsuNgBXVUX4Jv8LRJmHyUkpTknlsLEIgpa1hJd0GBy89j
 HTRg==
X-Gm-Message-State: APjAAAW3QupRh47M5Awk+mcDVrWdS58jvKvGO0+nViWkumh2Y6Tgz+YD
 KQU6i++asj6jlQ/I3vkBvip+UOL/
X-Google-Smtp-Source: APXvYqwu8IUrzIftMIO4JIMuRaw5SHC7hqSiWV8Lfo7zBkHIQCan+9OSqLxLnkgY6666HFh2gUzgeA==
X-Received: by 2002:adf:f491:: with SMTP id l17mr2405428wro.149.1576670582780; 
 Wed, 18 Dec 2019 04:03:02 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/87] migration-test: Move -name handling to common commandline
Date: Wed, 18 Dec 2019 13:01:33 +0100
Message-Id: <1576670573-48048-8-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
index e17d432..6e828fb 100644
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



