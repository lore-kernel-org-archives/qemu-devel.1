Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB0BC76196
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D95F21873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfWlAxEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D95F21873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoSvz-0005NR-F8
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoSvE-00025t-P9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoSvD-00013X-Qw
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44995)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoSvD-00013C-Ll
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:27:39 -0400
Received: by mail-pf1-x443.google.com with SMTP id t16so14174552pfe.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VbxxmY/24bsPob27bllLMEzR8PuoDY5UrmHVTChvkdU=;
 b=MfWlAxEd6lzErwYD6x92/g8V7ZKt9qP0BL770ctR8hsChSiuFptUaMHx7KQn8HrFFB
 urkbejzfkKq67UorGQFpxgnYMNVqL0yfHzJc9EHV5Eon8IaCAjIUR+DwkzqLjem2UWfb
 ifm5BlDHFV7+MelEt8c0uGuOPmMdIDnR37DQqVRRMcljf9kyEogw9HEwTiHRZofC8+Oz
 gXdRulSd1DuOq6rWX50OTb9sQ3/blvn7v/rYjEJI6Aq0cBqagOjZ19bVaKUtp7O2Uenx
 6EoFMHNG+C4qDLOgNSMk/8eN2eWfAdeY1j8H5rsNK5apYXV2NtzRnEps6nwawL6vl24D
 ySog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VbxxmY/24bsPob27bllLMEzR8PuoDY5UrmHVTChvkdU=;
 b=QS1PtDaNmjk+ZIIggIhQNFnchUcV9zGRboZxnQyIBjz7sNiZnRL929CKSWAa+Wjc1n
 nBoU1r463LPPEQNhPKFpq55tW3tNMTdvQTVtedF1W5xMiCJflZvFKIGmEqA8V4Dp5ijs
 /nhnU3287UcF0CQZKovie8ndEIPsPrFXTSstS9HT5IXzpiUhm9gMcy9iC4mTmXK9DcKy
 y+UeOKFE81psYLEZ9MPfqsBx6zRMG6yqZzo0m2Tc2KHwawR0boIc6m27Uk7rmO4L+0xL
 VylPOtg9HtzJF7DdvA3UEw/b+/uDvA3ketGMrJc3g9bHYXeBDjr4aN6b1fryzSvLMVGB
 BHtQ==
X-Gm-Message-State: APjAAAVuApmWJxz/1U1ETjJllL/cQ5bezJkX9Qo79HPxMYk6ZfxLQAJz
 QIZwtoTrYTKEl8nu+T30Kwt2rJ9r
X-Google-Smtp-Source: APXvYqyaHF8j/+rL2FgSimyVubSPki+QanekU19n8Xnbd9hmCWwlv2gJPi+g4v5g9RZxawy6au+Rvg==
X-Received: by 2002:a65:518a:: with SMTP id h10mr53443899pgq.117.1563542858267; 
 Fri, 19 Jul 2019 06:27:38 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id s7sm26520357pjn.28.2019.07.19.06.27.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:27:37 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 18:57:08 +0530
Message-Id: <20190719132720.27519-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719132720.27519-1-mehta.aaru20@gmail.com>
References: <20190719132720.27519-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v6 02/14] qapi/block-core: add option for
 io_uring
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
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only enumerates option for devices that support it

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
---
 qapi/block-core.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..0a3d4ae7d2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2792,11 +2792,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (since 4.1)
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.21.0


