Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA06C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:37:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182D8212F5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="bitbOCJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182D8212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK3qU-0003t4-KW
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 12:37:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h6-0004GX-BK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hK3h4-00013j-FV
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:24 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:52297)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hK3h4-0000zG-9f
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 12:27:22 -0400
Received: by mail-it1-x143.google.com with SMTP id x132so6800199itf.2
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 09:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=/jtNWxB61SZw8gmWc4QLGq2l28K8nb8bWXBa9rEihZY=;
	b=bitbOCJbc0qOeUGjyEFrVHTixRuriDk5SRjebwSIBNIbbGmZJfUNNpMiyyPUFzqSE5
	AlE1+Boi4Qy4a5rUy1KBWQgUkuQJXKe/SHUZZ/oq8RaINH1ksLTfX9HBpnpXfRNTHIP3
	Vx2NvFrPvkdunsBIB3hvhuU1+vpEvGtmtn0ADGxIX5hnghaZRZk3iPknoGzy5thYFEdG
	Fvy4/b0KT3HWSHliL0rV35kAQIGMO/IP3rC7Y6QUIFc6Kq/4/Y/YXyOPitZaQZeXn4Rf
	bl3boXKuN7Q2Bb8xPsHTYURZtxccfhqTrRMyce34cfdiX0rNEh+oKW28uyDcRIl+Qjyh
	0l7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=/jtNWxB61SZw8gmWc4QLGq2l28K8nb8bWXBa9rEihZY=;
	b=Ma3SK0RNtREmM8POw1i2YBLinJS1mYPvaxza58JV96+fPJ89NDcXAuQzU55zMlGgk5
	HOaRpioa7bSiGHWbPMH8ZaKN8ps1rlUpFFSHd0n6yOYB7FNq+bG4cl7sENEaF3BQpDf0
	mu3KHvw2rYBeoNCN/glICUUvO/e4s436RFkdZqdkK2LMHKJ/4LT4ML7zVMFXQE2oXN+C
	mj9/+Dfr7v51pr+Agg7JZe7C1sRNbsOeQ62Z6G0q7Z7xeJ1qfH/vW5+iQ88AizmOXQk6
	6me4EfzMRR8SpUPzCuttJvux4uoIFJJJHB6OhjqQFHlH7zcvHdzTkAdo7XUd14fMYTmv
	fduA==
X-Gm-Message-State: APjAAAXcZ2or2v8vGqqTggRHiEQ52w6/PfQT4cU37nOokXqZRL9Qam0K
	KX2G/yzgX7+eXz53pR/0nkKBWe9LHln0ww==
X-Google-Smtp-Source: APXvYqzC+u18lrPykPMI4QhLTCi5Ewn8XSh2Pd0OAsTylGFQvooVTvxfmDt8O6flGWJp23r5TUgxCQ==
X-Received: by 2002:a02:880a:: with SMTP id r10mr9099579jai.67.1556296035933; 
	Fri, 26 Apr 2019 09:27:15 -0700 (PDT)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	c7sm7548700ioc.63.2019.04.26.09.27.14
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 26 Apr 2019 09:27:15 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
To: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Apr 2019 12:26:24 -0400
Message-Id: <20190426162624.55977-11-stephen.checkoway@oberlin.edu>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
References: <20190426162624.55977-1-stephen.checkoway@oberlin.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: [Qemu-devel] [PATCH v4 10/10] block/pflash_cfi02: Use the chip
 erase time specified in the CFI table
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
Message-ID: <20190426162624.LBUBpL81aZLrKjqzcTrWQvZom5iuyCyspwqBLtcoHI8@z>

When erasing the chip, use the typical time specified in the CFI table
rather than arbitrarily selecting 5 seconds.

Since the currently unconfigurable value set in the table is 12, this
means a chip erase takes 4096 ms so this isn't a big change in behavior.

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
---
 hw/block/pflash_cfi02.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index d9087cafff..76c8af4365 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -633,9 +633,9 @@ static void pflash_write(void *opaque, hwaddr offset, uint64_t value,
                 pflash_update(pfl, 0, pfl->total_len);
             }
             set_dq7(pfl, 0x00);
-            /* Let's wait 5 seconds before chip erase is done */
+            /* Wait the time specified at CFI address 0x22. */
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                      (NANOSECONDS_PER_SECOND * 5));
+                      (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
             break;
         case 0x30:
             /* Sector erase */
-- 
2.20.1 (Apple Git-117)


