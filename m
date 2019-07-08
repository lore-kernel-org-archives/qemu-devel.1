Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C32C606AF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:24:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 360A3204EC
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 13:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7wnSgeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360A3204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkTd5-0007OD-HX
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52276)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbQ-000619-47
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkTbO-0003xt-Eb
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkTbO-0003x3-73
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 09:22:42 -0400
Received: by mail-wm1-x344.google.com with SMTP id 207so15798055wma.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=g9eAQagE0QheHxHPruslRXBJov60L65Bz5mc5X82Q1s=;
 b=J7wnSgeATIQ2AvmHjvU8KPSc540FeoJA9oP0Jv73H3zKYojxl/5ZNRQxJR369N6/0S
 Qzhtrsi+AzpaNVsbhvG/xd9wv87Fi6HqA4mw85nfzsm368cZa+QgGtG8PWum2efvUnxz
 CG/EF1Q738uwONJ7ZjBCYL7PFliYoiciXve9aMJMe6DybpPnf+L+5xVgTEUOEjQeQ0p2
 cGEM9CQSNq3t1oVmKcBWZF+UwgKrw985/U1rJHHFIgmyIUuGNDPomL9BsmwfYzQWCeaJ
 l+hMH1iU5DufV6n5AZGHjVj6KpVraLsbHeUunJhdPgk+t9pl//WlMMNyPNP0xRK6BGXH
 CYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g9eAQagE0QheHxHPruslRXBJov60L65Bz5mc5X82Q1s=;
 b=hTjeKkhoNHG6iwnD5xREOneGUn6i/CzENKiLYrTxb+IEhLWYdVX7oYSIkUUTV+J7Tj
 PSktOK5G09pYTKEz/EY9jbipOdHKYKU9x0UzxSj/X9++AOt9xtJdFBy+/4v5vmHPCwQj
 5HSsOKZBV6ifJsGkthYYjWtYQFlJjPKcc5vIGbe7JxRJ7HPGAyqOG5HvSmVJ3a6wKpTQ
 3Tkadubbtc7GQYS8oBHTmqKUXsa1QouiylHCMejP/Hem8cLA+fWbEo6BYmlemGbWlAAq
 aGcQIZCdCkktQtdv8NXh/kVpcmmRY6baBGGhsHClscfemzjmCn0d7BDuvI/NTpTEpskH
 t6zw==
X-Gm-Message-State: APjAAAUMkuV4KIGftfDoX/x+6sDOjseihkrl97YAckABHghIn6RT81X+
 pzeLp/E95bSLVbYwpMAfYhJn14zmCSkE6A==
X-Google-Smtp-Source: APXvYqzbfQsMdA3r3GqoxZK9Jvc00ytLiNS+n0T8IUZUvfI+RUcowzDrzbjVBcDI8YNnqWpacPuj4A==
X-Received: by 2002:a05:600c:303:: with SMTP id
 q3mr17365420wmd.130.1562592160921; 
 Mon, 08 Jul 2019 06:22:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v15sm13773744wrt.25.2019.07.08.06.22.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 08 Jul 2019 06:22:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 14:22:35 +0100
Message-Id: <20190708132237.7911-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708132237.7911-1-peter.maydell@linaro.org>
References: <20190708132237.7911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PULL 2/4] tests/migration-test: Fix read off end of
 aarch64_kernel array
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test aarch64 kernel is in an array defined with
 unsigned char aarch64_kernel[] = { [...] }

which means it could be any size; currently it's quite small.
However we write it to a file using init_bootfile(), which
writes exactly 512 bytes to the file. This will break if
we ever end up with a kernel larger than that, and will
read garbage off the end of the array in the current setup
where the kernel is smaller.

Make init_bootfile() take an argument giving the length of
the data to write. This allows us to use it for all architectures
(previously s390 had a special-purpose init_bootfile_s390x
which hardcoded the file to write so it could write the
correct length). We assert that the x86 bootfile really is
exactly 512 bytes as it should be (and as we were previously
just assuming it was).

This was detected by the clang-7 asan:
==15607==ERROR: AddressSanitizer: global-buffer-overflow on address 0x55a796f51d20 at pc 0x55a796b89c2f bp 0x7ffc58e89160 sp 0x7ffc58e88908
READ of size 512 at 0x55a796f51d20 thread T0
    #0 0x55a796b89c2e in fwrite (/home/petmay01/linaro/qemu-from-laptop/qemu/build/sanitizers/tests/migration-test+0xb0c2e)
    #1 0x55a796c46492 in init_bootfile /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:99:5
    #2 0x55a796c46492 in test_migrate_start /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:593
    #3 0x55a796c44101 in test_baddest /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:854:9
    #4 0x7f906ffd3cc9  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72cc9)
    #5 0x7f906ffd3bfa  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72bfa)
    #6 0x7f906ffd3bfa  (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72bfa)
    #7 0x7f906ffd3ea1 in g_test_run_suite (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72ea1)
    #8 0x7f906ffd3ec0 in g_test_run (/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x72ec0)
    #9 0x55a796c43707 in main /home/petmay01/linaro/qemu-from-laptop/qemu/tests/migration-test.c:1187:11
    #10 0x7f906e9abb96 in __libc_start_main /build/glibc-OTsEL5/glibc-2.27/csu/../csu/libc-start.c:310
    #11 0x55a796b6c2d9 in _start (/home/petmay01/linaro/qemu-from-laptop/qemu/build/sanitizers/tests/migration-test+0x932d9)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190702150311.20467-1-peter.maydell@linaro.org
---
 tests/migration-test.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 0cd014dbe51..b6434628e1c 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -91,23 +91,13 @@ static const char *tmpfs;
  */
 #include "tests/migration/i386/a-b-bootblock.h"
 #include "tests/migration/aarch64/a-b-kernel.h"
-
-static void init_bootfile(const char *bootpath, void *content)
-{
-    FILE *bootfile = fopen(bootpath, "wb");
-
-    g_assert_cmpint(fwrite(content, 512, 1, bootfile), ==, 1);
-    fclose(bootfile);
-}
-
 #include "tests/migration/s390x/a-b-bios.h"
 
-static void init_bootfile_s390x(const char *bootpath)
+static void init_bootfile(const char *bootpath, void *content, size_t len)
 {
     FILE *bootfile = fopen(bootpath, "wb");
-    size_t len = sizeof(s390x_elf);
 
-    g_assert_cmpint(fwrite(s390x_elf, len, 1, bootfile), ==, 1);
+    g_assert_cmpint(fwrite(content, len, 1, bootfile), ==, 1);
     fclose(bootfile);
 }
 
@@ -537,7 +527,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     got_stop = false;
     bootpath = g_strdup_printf("%s/bootsect", tmpfs);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        init_bootfile(bootpath, x86_bootsect);
+        /* the assembled x86 boot sector should be exactly one sector large */
+        assert(sizeof(x86_bootsect) == 512);
+        init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
         extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
         cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name source,debug-threads=on"
@@ -555,7 +547,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         start_address = X86_TEST_MEM_START;
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
-        init_bootfile_s390x(bootpath);
+        init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
         extra_opts = use_shmem ? get_shmem_opts("128M", shmem_path) : NULL;
         cmd_src = g_strdup_printf("-machine accel=%s -m 128M"
                                   " -name source,debug-threads=on"
@@ -590,7 +582,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         start_address = PPC_TEST_MEM_START;
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
-        init_bootfile(bootpath, aarch64_kernel);
+        init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
         extra_opts = use_shmem ? get_shmem_opts("150M", shmem_path) : NULL;
         cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=max "
                                   "-name vmsource,debug-threads=on -cpu max "
-- 
2.20.1


