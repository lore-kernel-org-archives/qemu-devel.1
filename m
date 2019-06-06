Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFAC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6DA4206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9vg+zVS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6DA4206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYudD-00063l-Ug
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 11:48:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYuXw-0001s9-Js
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hYuXv-0001JV-Kx
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:43:20 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hYuXv-0001Gp-C1
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 11:43:19 -0400
Received: by mail-wr1-x442.google.com with SMTP id m3so2961432wrv.2
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LqSNzOPOVJw9rsvpaWin3k5tpPNT/bVkcPC7OHiBDoM=;
	b=S9vg+zVS7tzYjM3haTyt3+QOFA8EJhYMMbIJ7G+d4WZomkI7MR8hg4oxVkK+AvLVvS
	ND6fbQxKR135zXta70D8HU4//+jhHCjXksRRQgiKuPZkcdRfmRzxBgUIkLu5MZ4G+QTa
	Ky5bGozNzwovEHvfzTY59lYz02dtSEXh9wNjLvFddP59GPjPKJ6fsiQmZ8gTEi/m3ikE
	8Bf5iZ5dHDskwDg97BYkUpk3mUeLsMOjPMJkXlvhF4mF/lBJPccuIbG9K2dIRqZ0FO2y
	L6emb51FAvl0YtDlc3s1NyDxq+qCJaK5UHT8I4gFqQ9hSUe0qpnV6t/SWHgPg24kglJz
	4Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=LqSNzOPOVJw9rsvpaWin3k5tpPNT/bVkcPC7OHiBDoM=;
	b=s9VnU35XUCKvVXPDgt7tVFfhKVezCtbugCyiy3vZTuG+k9pliftmfbqtSjygQoshhM
	UlcLTy7tXC4uI3GzFuLPEid7NQ2+RB4HIXemRZlko5bcR63CK3WP3muxxP6zAej6ry49
	w9OPPRRjKlelcsgNPq393hXS8nKGflenB4tcObpznDtKjY2oJURyTtVKFKqnCYuJt/bB
	VK2vtIZJq6gGgo+U/rR/mPwgMZ520gp7guIVXk/UTL9ISS8AbIYUBHXiEJkd70bJDh0t
	T+myqGbJ2lqkZafL9NS+0N0YaQY/USda8zajAMMjuPM4QbwKrBwmiKqH4fhPIqb4lUix
	8I4g==
X-Gm-Message-State: APjAAAU3DQpOLK9jsprXowAfSO4ESMn23d2aP7itygdMm6YrpoAPCUTm
	rxHGQhBpP/1m+IVsLZu8SdQ9Kw==
X-Google-Smtp-Source: APXvYqxCf2l8Lpa17skDbhUeMIL4CGBrTpPlGzqJmYm9P2dzbNDhB9bB9Z+AE2sjDvDJHaQiVNGhCw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr6815410wrn.239.1559835797728; 
	Thu, 06 Jun 2019 08:43:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	z14sm2133483wrh.86.2019.06.06.08.43.17
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Thu, 06 Jun 2019 08:43:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id A4D4B1FF87;
	Thu,  6 Jun 2019 16:43:16 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 16:43:10 +0100
Message-Id: <20190606154310.15830-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] cputlb: cast size_t to target_ulong before
 using for address masks
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Andrew Randrianasulu <randrianasulu@gmail.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While size_t is defined to happily access the biggest host object this
isn't the case when generating masks for 64 bit guests on 32 bit
hosts. Otherwise we end up truncating the address when we fall back to
our unaligned helper.

Cc: Andrew Randrianasulu <randrianasulu@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/cputlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b796ab1cbe..8f814a1a2c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1306,7 +1306,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         uint64_t r1, r2;
         unsigned shift;
     do_unaligned_access:
-        addr1 = addr & ~(size - 1);
+        addr1 = addr & ~((target_ulong)size - 1);
         addr2 = addr1 + size;
         r1 = full_load(env, addr1, oi, retaddr);
         r2 = full_load(env, addr2, oi, retaddr);
-- 
2.20.1


