Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12288C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FBD2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="me9bIlso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FBD2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SjV-0007Ik-Vf
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 12:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1j4SO5-0002Z0-C5
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1j4SO4-0007vk-Et
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:49 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:40166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1j4SO4-0007vI-8e
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:39:48 -0500
Received: by mail-pf1-x431.google.com with SMTP id b185so321717pfb.7
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 08:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pmyPbYDPgMfj7iewXRlwREPC4GaTkOAO8bGCy51JlgY=;
 b=me9bIlsoI9mi9isAShNfpwuA3sKkAuaDhcHsLJfUCKQx43EUxvuiDzlM8C4NBbaqCe
 pWcWjDd+5nfbN4PS7XtSC1W6iwJ0+c+u0UpjJPwgNVOa8zt+x9gAR9w6SvKjbsxkHrH+
 JOeHw6dUOJZJKbG9hoAAEYyHfzRWi2Bj9/GLmQPFD4Enw7m2UkzM33V3RmWdbYw6gPtD
 aH/0jWNX0NOyO6SHYsYkIJNHkCgvBHpDI5cdm8dqUhpz12VNsxWMZxRP4l2IlKGp+T5E
 IXDDDShhQf6qYsHIhznckgFc390aA4V2hRrFQdOUs4MRC44GgBTFUU/tJ/wdJL7d1KSF
 3cUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pmyPbYDPgMfj7iewXRlwREPC4GaTkOAO8bGCy51JlgY=;
 b=KZCFzHY/owSeCIYQ3lUVoZc4iZ3MVdZvVtv5iS+d+Z7LVRDxZwGnmafWk0z3gj02c6
 HzTneNbVx1knXb0J77G1VtDzLiQ41gTxS+AvPhqUH6QrHbLKCTXYmQ96Yo9gCa8pP4sH
 3jRPiUreh0Aqhz9+0enASHXUxkQxoo4+tTLTvoRDo+3FdPnYaXuXVKPJ24WBBuJPT7mp
 RDqdkM/PcHAhoqH/Gh8sTrfVaCfsmxkBX5LiXmWjxj4Fqu9fggn5KBBM3WWFWYNpNQ2E
 4WQIIj1sVwJrFDGVRCRTMvQ1tf47IUghnWNjrbs+7DBAf9GF/Rnr03Xu+cZkaTDF2MEC
 im/w==
X-Gm-Message-State: APjAAAWG8HBViVIa/atdswFo7udEOFUld9sygJ0GmnlLPAAWJjh6AaTi
 DaMfbL4k7t8fFUf7YKnDNCxzTlkWLKo=
X-Google-Smtp-Source: APXvYqzwXSINC6ZBEIjCZB79xAeW7IjB3zJj95Ws1yUKeTUUZ0no53AqJNm56W1NISBHsKTr5IPMog==
X-Received: by 2002:a63:7453:: with SMTP id e19mr1077790pgn.50.1582130387017; 
 Wed, 19 Feb 2020 08:39:47 -0800 (PST)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:3cc2:5eb7:e248:ad23])
 by smtp.gmail.com with ESMTPSA id a69sm112362pfa.129.2020.02.19.08.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2020 08:39:46 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/14] tests/vm: use $(PYTHON) consistently
Date: Wed, 19 Feb 2020 11:35:24 -0500
Message-Id: <20200219163537.22098-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219163537.22098-1-robert.foley@linaro.org>
References: <20200219163537.22098-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::431
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Change Makefile.include to use $(PYTHON) so for vm-boot-ssh to be
consistent with other cases like vm-build.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 tests/vm/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index 9e7c46a473..778e506755 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -80,7 +80,7 @@ vm-boot-serial-%: $(IMAGES_DIR)/%.img
 
 vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 	$(call quiet-command, \
-		$(SRC_PATH)/tests/vm/$* \
+		$(PYTHON) $(SRC_PATH)/tests/vm/$* \
 		$(if $(J),--jobs $(J)) \
 		--image "$<" \
 		--interactive \
-- 
2.17.1


