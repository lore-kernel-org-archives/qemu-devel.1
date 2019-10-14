Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A7BC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0112920650
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArQdQWmu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0112920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyAb-0005MN-3B
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvV-0007YP-1n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvU-0006Ih-0r
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:08 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvT-0006HN-RA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:07 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so16247258wml.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7e3kGGDhCCeDmaWnT5E6lm7XvO8I2yKVtKu9Sla1anI=;
 b=ArQdQWmumjGXoXSIKblyHPxWNGkITe3vRfYdLJ+A/tNTNMEa+c3phhEvaFnPx1D6ms
 vnrhQlQxyLv3mG95GwVs6M9GYruXb6MBCGiOzIUIRVQj1M7bpgDjcJpZFi8ljpRFe0GV
 Qrtwprlmz6II+yrvPcYWEjy08Xh22gR6qTAnlnwIv4tQ9pn4DY3iHapo73owHSmPbZBv
 y2psxOMymqZ3Sdujw5kWVP6zEvc1AV8oOzMS1qzKwO9OA1C5eaNGrjgtB8cK7VomlzGp
 HeMyFKnUZiPfDIBmpAN7ANqGIV1V+GtUCOJC+WzrKnK75eJY1MQWO5GQG3O+B+0cj+Mu
 tCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7e3kGGDhCCeDmaWnT5E6lm7XvO8I2yKVtKu9Sla1anI=;
 b=Y/SzURMsIfGw7sXNcdjKlRZxobll5Plb0ihIXru2SMJk/an8uD47FhV+M7j6OdOylQ
 nf+PgntBvKwbj8dgB6jU8MA2mMupN4kOQLQM4TCRwvfw/JC9biGcC8F72uhL/kKQg0lG
 MbSZrUdJjzV95ztVNaHIaEBeTnTydSFPOQhd1PUHYgKThTFUT0QIpgGfBqhZTsg5lJgL
 DoEbHZwuSAHEqh/0ls5RDG9RA2xJJo6vFoEhvDJO733BtEZIxe80w78iFcM8IolD3g8i
 Lj4GWMc2SXeTcPXB+vo/zqjhTGJSZSj/bBxHQ9NrlNhfOLRu/xzGDV46T6AX+ynPW1No
 3Snw==
X-Gm-Message-State: APjAAAUtMZW6LSmuXG48knJ6+2Fpb+s9Y5fj7NA8EmK4RzdQ1uw8lBcy
 +MSSzx5fUdldfJMb5OmrqdRicHmP3uY=
X-Google-Smtp-Source: APXvYqxKS7sj4abCA9cOBucAjYq04ZkYjPx1B55p8Hhnl7yzej7nHnU3jR10D65l725OuxpJhzANfA==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr14155783wmb.77.1571050206744; 
 Mon, 14 Oct 2019 03:50:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p85sm24611469wme.23.2019.10.14.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E67A41FF98;
 Mon, 14 Oct 2019 11:49:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 40/55] tests/tcg/Makefile.target: fix path to
 config-host.mak
Date: Mon, 14 Oct 2019 11:49:33 +0100
Message-Id: <20191014104948.4291-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 robert.foley@futurewei.com, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since moving where the tests are run the path to config-host.mak has
been wrong. This doesn't affect much but things like the time fallback
for CONFIG_DEBUG_TCG and will also get in the way of checking for
PLUGINS support.

Fixes: fc76c56d3f4
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 5a9a6faba4..84abbd24f3 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -30,7 +30,7 @@
 #
 
 all:
--include ../../config-host.mak
+-include ../../../config-host.mak
 -include ../config-$(TARGET).mak
 
 # for including , in command strings
-- 
2.20.1


