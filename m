Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F55C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60843208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="WLldS0y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60843208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3kT-0006u4-Fy
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:30:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gy-00049S-0I
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3gu-0000xB-GR
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:14 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:51148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3gs-0000uF-K9
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:10 -0400
Received: by mail-it1-x143.google.com with SMTP id q14so6835101itk.0
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ZdFx6lN3s3QrEP9/f0SJgY/3+st2GN+DoCW00fGR9us=;
	b=WLldS0y0Y3nmAF3Mi/J2XlJT0ri6MjQ8KO3k+E/trtmQk71jRsQqlHJsEJVu4UON/4
	sKwxqCydR5It9EUBPdN3hDeihniA83jwTvzsWdWs/WO/z87ipw9ECg1AdzGsIh9sOdJy
	IvC77yDWSgRQ48ARBnloItTfnL7cILDNMGIjag/cUxmtKdRLyShRqvLT6UwL5YxNAMB4
	PrBXxGBGCqCMjTNlF8gQ0EkhsEi77KIPAchdrLrIEgOQvVgTOe/G1A7amfefwh4Y5R3e
	ZXGLPmZf8y3P+NNM5FTIpZQPlZG0PgJe2ksPeQYlwmBqmCdUgU37QhqvM3eiOUSS4nTi
	G3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ZdFx6lN3s3QrEP9/f0SJgY/3+st2GN+DoCW00fGR9us=;
	b=GpXuZRKMpcSFhBfOtqmFmAfUAXKvQFmEbC81GHsxZOQiQYLQPphN8UhFauHVotQTdD
	DRTQNbxyfSZ53K35oML8GcGh+7xBmisowXrjh0z+QiyWGetBdq7WYAknhXKlkYEGhDRd
	NbeiRUDzv1glHPSVrs0VWidY123MMEvf9VdCkeNC969O1fVaU1/ycFqRj1Xn9arqyaYe
	Rny0hzHFOZpLMa5zGeAGq4kN/A2LmTXQCOA2U8ZCpCEb3H/ke9uAVkgO/GVlydwGiwbk
	XwXnH2J4KcyfSY6u6QtqjBsyFo1rFpELE7v1TL58nzfYJW3wN0KSKp18ou/K0nJiFV15
	9sMw==
X-Gm-Message-State: APjAAAWoezapj9dp2ab+j8yBsoWhNNjDNONF44NLQFWVIVRFujnC8KLq
	kVPr2ichJ7fZlz93BaO8SpTIUGJzOJX2cQ==
X-Google-Smtp-Source: APXvYqxb6WcTx1S/5kEippPHsj+E61trCwyo0GD4RHVzUwDmPjhzWCDhrm/gXBnjXwE67YvKdqhe+Q==
X-Received: by 2002:a24:9a03:: with SMTP id l3mr8930838ite.3.1556296027015;
	Fri, 26 Apr 2019 09:27:07 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	c7sm7548700ioc.63.2019.04.26.09.27.05
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 26 Apr 2019 09:27:06 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 12:26:17 -0400
Message-Id: <20190426162624.55977-4-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH v4 03/10] block/pflash_cfi02: Fix command
 address comparison
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
Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190426162617.XETGCvl4SdbD_DOpKjxal7fjvSgJkRAzBtQNKvyEEI0@z>

Most AMD commands only examine 11 bits of the address. This masks the
addresses used in the comparison to 11 bits. The exceptions are word or
sector addresses which use offset directly rather than the shifted
offset, boff.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 hw/block/pflash_cfi02.c   |  8 +++++++-
 tests/pflash-cfi02-test.c | 12 ++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 4b7af71806..e4bff0c8f8 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -296,11 +296,13 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
 
     DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n", __func__,
             offset, value, width);
-    boff = offset & (pfl->sector_len - 1);
+    boff = offset;
     if (pfl->width == 2)
         boff = boff >> 1;
     else if (pfl->width == 4)
         boff = boff >> 2;
+    /* Only the least-significant 11 bits are used in most cases. */
+    boff &= 0x7FF;
     switch (pfl->wcycle) {
     case 0:
         /* Set the device in I/O access mode if required */
@@ -519,6 +521,10 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* Only 11 bits are used in the comparison. */
+    pfl->unlock_addr0 &= 0x7FF;
+    pfl->unlock_addr1 &= 0x7FF;
+
     chip_len = pfl->sector_len * pfl->nb_blocs;
 
     memory_region_init_rom_device(&pfl->orig_mem, OBJECT(pfl),
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index 40af1bb523..ea5f8b2648 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -21,8 +21,8 @@
 
 #define FLASH_WIDTH 2
 #define CFI_ADDR (FLASH_WIDTH * 0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
-#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
+#define UNLOCK0_ADDR (FLASH_WIDTH * 0x555)
+#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AA)
 
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -190,6 +190,14 @@ static void test_flash(void)
     g_assert_cmpint(flash_read(6), ==, 0xCDEF);
     g_assert_cmpint(flash_read(8), ==, 0xFFFF);
 
+    /* Test ignored high order bits of address. */
+    flash_write(FLASH_WIDTH * 0x5555, UNLOCK0_CMD);
+    flash_write(FLASH_WIDTH * 0x2AAA, UNLOCK1_CMD);
+    flash_write(FLASH_WIDTH * 0x5555, AUTOSELECT_CMD);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0000), ==, 0x00BF);
+    g_assert_cmpint(flash_read(FLASH_WIDTH * 0x0001), ==, 0x236D);
+    reset();
+
     qtest_quit(global_qtest);
 }
 
-- 
2.20.1 (Apple Git-117)


