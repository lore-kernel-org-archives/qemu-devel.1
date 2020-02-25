Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23057C35E03
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D7D20732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAOev4/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D7D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6b1v-0002bv-3Q
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apN-0006e6-Ga
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apJ-0005Gx-Mz
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37985)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apJ-0005Ge-Go
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id e8so14887088wrm.5
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rbxvM6zBsEyzHKe8nAvY0XhamX4FQe6hP23LCjFR3Y0=;
 b=AAOev4/kVlRSlw0bl6cT+8Yfxz7LU8jZgbfr2JV6Iut2/gk4JMxnQ9c47D03f1sWHT
 1nsdlgaBxsR4J4wQ2IjtTuxPJcBXMFZWHDyOZt9zTgYVfYpeRITrWwIky6BHE3EIKgJB
 ef7EI7922kGtZAGnNgNBQgSf/1dMya7gE8nkNTKhv3l/IFnj3v6Z0UaDC6kJPuMTCMlg
 7VjI/1x7nxLrePNffnGEhs5MWw4R58P7aVuv7aOHCDUfjFNt62BP2F8P3MHxoA3O+Tny
 +j2PvCfHgc8Ep8jiUmZF7n2oMhw2aGSFlTX7fbBIXSrlu4FUFpGFQL5O+S8Bqvirzh4e
 P6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rbxvM6zBsEyzHKe8nAvY0XhamX4FQe6hP23LCjFR3Y0=;
 b=mCHXkENQ6VuC3i+8mtvLNYnzopU0y6EZ/KYXD2Rbsahf7ZH7RT1Aub4wSmhxDPX3GP
 T8s34YCYD84QiMh+MdEYJIXymGqwVn8oXpRQ/7rFTL51al8JTqR4nLy+gLGq5DMBjNIM
 cbNDKop6pMEAnDctEuzuk6iMNYD8NQId3gbRYYw5M5IDTNNyxwapJQKpxB5DzinocKFQ
 5VAaw22lAeJ/rGyyPrUxtTrJqow1UAKw/kEcYrfJ14m+bvJkRw/WOZ6JtJB2A4GEstFP
 bZJKEKIrKE+E3nxBIQwOdSOQbm8DGIEYzN8Xioaiyo0sqDDP0tbmaW3wcNLb06S6dCdu
 ghDw==
X-Gm-Message-State: APjAAAXFjVTVpof92W1Ni8VULTxY+WQObE2v1UyMzL/NjM8WxIie56hq
 tF2Mmz1YtMLH0FXYMx27v3RYb8dPTHI7Ow==
X-Google-Smtp-Source: APXvYqzJcwNKu42Ndh+7aXgzgCoNaqLPhRXzRokZRzhvTpxeHssu67rsdqASwSo3bkkalYiB8D1KBw==
X-Received: by 2002:a05:6000:188:: with SMTP id
 p8mr72207833wrx.336.1582639484162; 
 Tue, 25 Feb 2020 06:04:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/12] qapi/machine.json: Escape a literal '*' in doc
 comment
Date: Tue, 25 Feb 2020 14:04:27 +0000
Message-Id: <20200225140437.20609-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
References: <20200225140437.20609-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For rST, '*' is a kind of inline markup (for emphasis), so
"*-softmmu" is a syntax error because of the missing closing '*'.
Escape the '*' with a '\'.

The texinfo document generator will leave the '\' in the
output, which is not ideal, but that generator is going to
go away in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a4..58580602524 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -12,7 +12,7 @@
 #
 # The comprehensive enumeration of QEMU system emulation ("softmmu")
 # targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
+# look for the \*-softmmu targets near the "--target-list" option. The
 # individual target constants are not documented here, for the time
 # being.
 #
-- 
2.20.1


