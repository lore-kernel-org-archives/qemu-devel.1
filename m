Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC9C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A1B218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qOnzYlFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A1B218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl6P-00084i-MO
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:38:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzQ-0006AF-3J
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzP-0004Ds-59
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:56 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:35043)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzO-0004Ah-Uk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:30:55 -0500
Received: by mail-wm1-x330.google.com with SMTP id b17so1011295wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DdTyceGkkwj9dEzcBkZjrrEjb4XQeMiC6gg82f8sScs=;
 b=qOnzYlFP2huECs+jOx6ZRFEEzjmdM7EPXg8vfEK7BrZvsEpWdOj7n+vMVqu063ucbB
 IZA6ML1S8L5PJWd2YhW9enEH5XPIJOeW8BkpQSVE992NQ9HIBbV2k6B8nsMdmB8lpRdJ
 RIPuJJ5MIlydCHfLC0EpCv5AGOI9pHh1xP1dIkr+hTitAdJDJR2Njm+nEBL9K+y4Md4z
 uJOPLUYmiEaa3CSBYjqtudwo4R1EJL/hlhNOMkjbaS3mlGZxMcXdbQ/5KCvUOTE+tpmu
 wg/3s9oYvN24E5f+XG4Pm62BaZBohmVkjxzlZ9a5PR2miPCQO7HpTc2NBKgAkQ3qOiHh
 q2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DdTyceGkkwj9dEzcBkZjrrEjb4XQeMiC6gg82f8sScs=;
 b=V0ZJseGG9ACcMxoUOM7Aup+YD4Dp6LnRouZspMugvyUN4qy8PO1VhHeNAIwxNWsdzT
 calZqAah8b4F9EjySTLtLCijtfu0yLpV1swdX9ln4tfivxnsjwu75GgKWak/U8QRPI/g
 bKtoF6Dhgz3ksUc+Er39k+k9TEY6LMjamB0Klgyuwar1JJpd+Mr/sSda4Ir9gB5e9/BA
 Drsjd2YHfVs2I/bxEODmBJv2plSI2hUNMeSUR3OL5q+LF0C7yRaA2Y+B7CfAFk/JBKLx
 yx5oTDKuR0u9xr1Nng8QlvMuNwdknPWXvTG54Djf0UFF4dGiTQSb73Eud3106Ctasjlc
 3EOw==
X-Gm-Message-State: APjAAAWgfkdzHKKgEXsMtG0N+gSPwsL1VuX5R7+MD7O2mEqlVTv7Mv+t
 m6+tNVZrU8ZaAsrS65/5rX9Tkdpp7QA=
X-Google-Smtp-Source: APXvYqw1DaTTKqGhgyqctUTvCMzPMCoLPYfBxmRcvs3MWeMRqrqDPsyyGPohO7+fEIa9yEC6FYjWxQ==
X-Received: by 2002:a1c:113:: with SMTP id 19mr5927295wmb.95.1581010253331;
 Thu, 06 Feb 2020 09:30:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:30:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/29] qga/qapi-schema.json: Fix missing '-' in
 GuestDiskBusType doc comment
Date: Thu,  6 Feb 2020 17:30:15 +0000
Message-Id: <20200206173040.17337-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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


