Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A0C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204B8206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlWHyHLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204B8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2InP-0005Z9-6F
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:01:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjS-00007Y-9G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjR-0002P2-AH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:58 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43699)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjR-0002NM-4R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:56:57 -0500
Received: by mail-wr1-x434.google.com with SMTP id r11so7776034wrq.10
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=g2WZpfNoMWL/DfUoo26twQ8bt2763a6Rl0JvwrClvQs=;
 b=XlWHyHLG1QEHmvjeZvjkLlCerr0xlPubWaomPJugssnSIl1etyMCbT4VRCgmQ2sw2r
 vOfhpsqVXJpuLTOFLR7eSFpquI4tlLiQILUJEAAAbK6UtkL9ZAp42aBHCDItBE39OA4P
 YnF2xYHSo9XeRcgDZrlBTEw+UIy8K0VXiy5wHARNXbAB0ih48IJeUUGgvDxVCPem4LmX
 mudojxNGhEGD3nu6DrDrxf6AVe3HBNIXXCo7x/VJ2eeL8Hw2YlvZje/hhmNDpI5rJpGr
 gBHaoq5iKG+g2qfOQ/JGjsE9OZpbKFC+DZp2KfTPlK+5ww0JxKZhWgQxEhWQsaU9xRnJ
 81BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g2WZpfNoMWL/DfUoo26twQ8bt2763a6Rl0JvwrClvQs=;
 b=ZmuR7K+QZrdxZLJdUCVLSR8etbfKtWwpmWmCtFNJKyb/GD6jnnjcHQMEuaz1YkUugh
 6zu5Nk5AQl7UKKTdksgIY9azoUqrQtgvmwrgbLW/t2Hdjruu/8S3N3RA4C4APEolphSa
 suQS75pZsLiZtM1NwnqTLQU9eAg4VwCN2YuuOaA3L7NJooc5r41oOh0Q4pKWi1OebztK
 Qjq0BBCZvxIxT5BkWlP8oLkzml0RwOsMik/AjtTHoRMHuMG8wZOhUF9AbdgTCdquPqg3
 sJ3py8CRZWxqR6FdPwjo9E0X4HZ28UruEZw6i7zxPeJTF4q2QRpgkeTSG03kq0WrZZFU
 aKjA==
X-Gm-Message-State: APjAAAX9b8OUqHf5ztYvaVFQ4Hjr7/NSrrsDcaJD8Whaee3cTQkf3Voc
 1hLTHF0J2Et5W4pXQ1rF7mKhmXZzqLg=
X-Google-Smtp-Source: APXvYqzSR42TgFvA5POGIbBseeCQorZaGXeW0oi5bLUw+40gFc7tw5/MLZMcv7bljicZSWhx1n5oNQ==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr22514041wro.230.1581616615883; 
 Thu, 13 Feb 2020 09:56:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/30] qga/qapi-schema.json: Fix missing '-' in
 GuestDiskBusType doc comment
Date: Thu, 13 Feb 2020 17:56:21 +0000
Message-Id: <20200213175647.17628-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

The doc comment for GuestDiskBusType doesn't match up with the
enumeration because of a missing hyphen in 'file-backed-virtual'.
This means the docs are rendered wrongly:
       "virtual"
           Win virtual bus type "file-backed" virtual: Win file-backed bus type

       "file-backed-virtual"
           Not documented

Add the missing hyphen.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qga/qapi-schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index fb4605cc19c..23ce6af597d 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -809,7 +809,7 @@
 # @sas: Win serial-attaches SCSI bus type
 # @mmc: Win multimedia card (MMC) bus type
 # @virtual: Win virtual bus type
-# @file-backed virtual: Win file-backed bus type
+# @file-backed-virtual: Win file-backed bus type
 #
 # Since: 2.2; 'Unknown' and all entries below since 2.4
 ##
-- 
2.20.1


