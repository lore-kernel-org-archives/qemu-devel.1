Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E137C10F13
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:05:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11DF0213F2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 02:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="SLbi2aJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11DF0213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDg8E-0003sS-Ap
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 22:05:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6T-0002i4-I4
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hDg6S-0006IX-EH
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:13 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29]:40346)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hDg6S-0006HC-2P
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 22:03:12 -0400
Received: by mail-io1-xd29.google.com with SMTP id d201so12864414iof.7
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 19:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=JK1jenobNkp2h3wHQtfPIyfKfvzIb1aDxQY+2ztH4do=;
	b=SLbi2aJs55LqOopZ9zGQjuaRffnjKaoPoKUrEJbGi24dS/Ms+mibpBYx6sBB21wkN2
	q5XWuBGGiSf4JQCuLLTtSqFNgC4jIaVeO9RufP5uJOYuYx+2rOe3nPT1ubNiBZPO+zHd
	g+6JdlTPfCOvRb3O60uO1EsmCjRVTOvTMPyxwQjh5lWAduFTVs2L3WCDSRoRLIFVuff7
	izXHmV/bfZkxcbG5wKa3o9FklHe2jMBg+uq4uiEO/vvt5EhqT8gEOAno2Yr1+fn2ICOc
	hJd8l/A9ho3edzO7P/wwlQt/7B0URIKnITP1myIkdw77wK/ew0BUO/JAzAIFREO0KKbL
	xHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=JK1jenobNkp2h3wHQtfPIyfKfvzIb1aDxQY+2ztH4do=;
	b=RRgx9crz+sM0NXJJJal41thg1FVoBZUEGq633dUXbxctyf/0qUTSBbciexR/O6G7kh
	L+i1kzWbl8QhoH2JaPkjf6QPL34ifnnAb6Fb8memNJPKSimVX+/ZwOub7LXKyIq9MFMv
	aSClG0R6gFYbms+DWKWJcS/+vG4+PrKN8vzVKBxWeyNFNpmSemqqySqSOP6IOlTpNJ14
	YjXgOZq1jeNQgRCn+MDj1UC/PHCO7rUSx8pWdkmVejwmJ2FUi1856IIoUvZ2gdrllARG
	moL3yG5iaSzfX80JJoSWPDrlAn65nXgFHzZ9mm4hoDnBHvTT+djVzFF5ofNBShiDrYhF
	uUHA==
X-Gm-Message-State: APjAAAX2Uap9htawoU+lrFL/2zquPf2CMDb5zhoEOfvfKL5/QLwaUVq0
	ZFXCgLyqHD5b69CVqOJ80FlXpFIN+gTzpg==
X-Google-Smtp-Source: APXvYqx2Ydoh9ir2n8CGVeRhu/0UUijZ331XXUZ3+cQM9do/hmnTOO1p7ufjiyhOz9XwCS5+rsl4kg==
X-Received: by 2002:a6b:440b:: with SMTP id r11mr12820833ioa.48.1554775391234; 
	Mon, 08 Apr 2019 19:03:11 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	y203sm5969838itb.22.2019.04.08.19.03.10
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 08 Apr 2019 19:03:10 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: qemu-devel@nongnu.org
Date: Mon,  8 Apr 2019 22:01:27 -0400
Message-Id:
 <fa42dc0818631d51cc33b2422a31519280ec05ba.1554774454.git.stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
References: <cover.1554774454.git.stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d29
Subject: [Qemu-devel] [PATCH v2 03/10] block/pflash_cfi02: Fix command
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
	Thomas Huth <thuth@redhat.com>,
	Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190409020127.4x-EcDhkX4YjSErmCYJz_VwLOPEdStlhoBbiz8--hNU@z>

Most AMD commands only examine 11 bits of the address. This masks the
addresses used in the comparison to 11 bits. The exceptions are word or
sector addresses which use offset directly rather than the shifted
offset, boff.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
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
index b113fca5af..b91bb66a79 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -23,8 +23,8 @@
 
 #define FLASH_WIDTH 2
 #define CFI_ADDR (FLASH_WIDTH * 0x55)
-#define UNLOCK0_ADDR (FLASH_WIDTH * 0x5555)
-#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AAA)
+#define UNLOCK0_ADDR (FLASH_WIDTH * 0x555)
+#define UNLOCK1_ADDR (FLASH_WIDTH * 0x2AA)
 
 #define CFI_CMD 0x98
 #define UNLOCK0_CMD 0xAA
@@ -192,6 +192,14 @@ static void test_flash(void)
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


