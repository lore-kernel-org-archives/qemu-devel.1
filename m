Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755D5C10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E898213F2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="1aAOfbh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E898213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDgBv-0007JK-DU
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:08:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6p-00033T-Uj
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6n-0006eM-IL
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:35 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30]:45786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg6n-0006dC-B8
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:33 -0400
Received: by mail-io1-xd30.google.com with SMTP id s7so12839110iom.12
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Fv5fB8GVOlQA6/nl/SV+rrrwTraGemNdwfTmaMiR9Mg=;
	b=1aAOfbh16dPsGkRMJiuTMMgggdg9ZKqPU4qqiu9Fxj/IjRb0L5UJ0vqIMg4ZtlxM0m
	SYxQZtMIo8tgkhxKgr8wzDxFeFaWFxnDl9BfFqIx+pQryItsfoLETiWH7WUIU88xFiOX
	3+wIUFW49MbI8NXb55m3Z2fhjDu03+r3u+4508SDgSpaj/G4MTPjKdOvZX+snMKK2K2d
	+tSkVZNOkRY4NbEROf4JK//3KpuWqvyTu5VejRK0RywjQ8VL2H0ZjhxDzFvfPMeB/vWa
	fZ1WgB6Q7ZIbvp41DECZBKgIJW5ZvqCCdtRG+zlskctuG3FL5mR1qkRxG57Vcwlv1VX/
	zPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Fv5fB8GVOlQA6/nl/SV+rrrwTraGemNdwfTmaMiR9Mg=;
	b=rUPUJKCUjRiik9rG8+p915mVviAEdqVkcUdk3u9KexZ8GHFrt7J/9Z5iSrbV0uefAi
	iM4Y6fmpzZ1rbL9cn6d/HTmVIz0IOLZwAz8eVcQq4oU661r/uKXHYKc/RRzakuWqHeoT
	7wFaf7hRS3uvYxnYElr/mlzQBb8J7NfHXo858OUWerbk167MZqqB6YULr9z5XOIHgpA+
	EmuZN270xyjL0kdiYIzNUDC1N/tCmKTQX4uL34ZYeafDYfcgrnmSQPyaSdKXrB+ak6Ia
	rbgQZjVkmYHFv34qc6vC7aQyPrlEnB/ykq0zXEt34e2TovMCqvC7gNid2qBH8Jxp/Ojz
	WWHg==
X-Gm-Message-State: APjAAAVdPEWM0aP4FwwdJoALtl8NgZiDNMAOOnRKigUvf093uGK+h87V
	LCf/Tb3ajVOPxn71+Z+sY9N/ITdm1e00CA==
X-Google-Smtp-Source: APXvYqzc0kW7Yk3J6D1IjRlLkg4kv26r40WdjztL2Xw/NyquTzslM89tfnxc7zULj88KnantyDJ7xw==
X-Received: by 2002:a5e:8f04:: with SMTP id c4mr23661236iok.131.1554775412474; 
	Mon, 08 Apr 2019 19:03:32 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	y203sm5969838itb.22.2019.04.08.19.03.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 19:03:31 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:01:30 -0400
Message-Id:
 <871e55199edc5c1ae1e5cb80e076a211d76c5a77.1554774454.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
References: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d30
Subject: [Qemu-devel] [PATCH v2 06/10] block/pflash_cfi02: Fix CFI in
 autoselect mode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409020130.2ris10dI3i9YbnJUwsHdJDMSEfPS8XvC0PVSWzj_yXw@z>

After a flash device enters CFI mode from autoselect mode, the reset
command returns the device to autoselect mode. An additional reset
command is necessary to return to read array mode.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c   | 21 +++++++++++++++++----
 tests/pflash-cfi02-test.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index c4efbe8cdf..be10036886 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -61,8 +61,9 @@ do {                                                       \
  */
 #define PFLASH_MAX_ERASE_REGIONS 4
 
-/* Special write cycle for CFI queries. */
+/* Special write cycles for CFI queries. */
 #define WCYCLE_CFI 7
+#define WCYCLE_AUTOSELECT_CFI 8
 
 struct PFlashCFI02 {
     /*< private >*/
@@ -325,6 +326,12 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         if (cmd == 0xF0) {
+            if (pfl->wcycle == WCYCLE_AUTOSELECT_CFI) {
+                /* Return to autoselect mode. */
+                pfl->wcycle = 3;
+                pfl->cmd = 0x90;
+                return;
+            }
             goto reset_flash;
         }
     }
@@ -350,7 +357,6 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         /* We're in read mode */
     check_unlock0:
         if (masked_addr == 0x55 && cmd == 0x98) {
-        enter_CFI_mode:
             /* Enter CFI query mode */
             pfl->wcycle = WCYCLE_CFI;
             pfl->cmd = 0x98;
@@ -427,9 +433,15 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 /* Unlock bypass reset */
                 goto reset_flash;
             }
-            /* We can enter CFI query mode from autoselect mode */
+            /*
+             * We can enter CFI query mode from autoselect mode, but we must
+             * return to autoselect mode after a reset.
+             */
             if (masked_addr == 0x55 && cmd == 0x98) {
-                goto enter_CFI_mode;
+                /* Enter autoselect CFI query mode */
+                pfl->wcycle = WCYCLE_AUTOSELECT_CFI;
+                pfl->cmd = 0x98;
+                return;
             }
             /* No break here */
         default:
@@ -510,6 +522,7 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
         }
         break;
     case WCYCLE_CFI: /* Special value for CFI queries */
+    case WCYCLE_AUTOSELECT_CFI:
         DPRINTF("%s: invalid write in CFI query mode\n", __func__);
         goto reset_flash;
     default:
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index dc85783a6a..ae1cd4e54b 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -437,6 +437,39 @@ static void test_geometry(const void *opaque)
     qtest_quit(global_qtest);
 }
 
+/*
+ * Test that
+ * 1. enter autoselect mode;
+ * 2. enter CFI mode; and then
+ * 3. exit CFI mode
+ * leaves the flash device in autoselect mode.
+ */
+static void test_cfi_in_autoselect(const void *opaque)
+{
+    const FlashConfig *c = opaque;
+    global_qtest = qtest_initf("-M musicpal,accel=qtest"
+                               " -drive if=pflash,file=%s,format=raw,"
+                               "copy-on-read",
+                               image_path);
+
+    /* 1. Enter autoselect. */
+    unlock(c);
+    flash_cmd(c, UNLOCK0_ADDR, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+
+    /* 2. Enter CFI. */
+    flash_cmd(c, CFI_ADDR, CFI_CMD);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x10)), ==, replicate(c, 'Q'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x11)), ==, replicate(c, 'R'));
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0x12)), ==, replicate(c, 'Y'));
+
+    /* 3. Exit CFI. */
+    reset(c);
+    g_assert_cmpint(flash_query(c, FLASH_ADDR(0)), ==, replicate(c, 0xBF));
+
+    qtest_quit(global_qtest);
+}
+
 static void cleanup(void *opaque)
 {
     unlink(image_path);
@@ -562,6 +595,9 @@ int main(int argc, char **argv)
         qtest_add_data_func(path, config, test_geometry);
         g_free(path);
     }
+
+    qtest_add_data_func("pflash-cfi02/cfi-in-autoselect", &configuration[0],
+                        test_cfi_in_autoselect);
     int result = g_test_run();
     cleanup(NULL);
     return result;
-- 
2.20.1 (Apple Git-117)


