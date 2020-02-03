Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2974C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A250A2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 15:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tnkQzwip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A250A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iydzL-0003X4-Ob
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 10:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iydyI-0002C7-DL
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:49:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iydyH-0007Fv-Ar
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:49:10 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iydyH-0007EZ-3b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 10:49:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id b17so17777799wmb.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z29qcbGslcdRUe1S2FcpZlBxZZxjI437E/0xGHrGcrE=;
 b=tnkQzwip2341FrD+Vk4w6XLzWhd25dcZ2HpALxqin5oscthLkye2/Ji0PWMlxHzCXx
 piUK2bGCry15gfIKXYm7r34lM093el6ct/h5ePD/KsykccJ5RV19czKrlBBFJIgMOERM
 PA/B5S+0RTmY6G4NffigTgiBUsIven6IJ+2/jHy9ZrnYBsf0wEk2pzSIkiIwYIXoYobO
 2AaALO66GwZW3GuQiUlesVxyj7hYViyCl8PNJb/XedoPGCz4hoFndEMZ7dIwlYISbMOy
 qGelUNu3epKS5C9JL8fML+qRm01gJYQBXJYcZPu0veQWflTNA/BZzQC7e5Evydj/8ANp
 tMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z29qcbGslcdRUe1S2FcpZlBxZZxjI437E/0xGHrGcrE=;
 b=JJKPE+cgOiFECC1zWREt74rxSbJSJfjpg1B3RwRqOMgAQUniw7e8C38G5M8Q9EYyRq
 f0mSYPgJ2icG6spL7JESglewTLsCojooBGgMg1xpnWn1yOuyMOJSWKTCinUvB/05gCcl
 uVFt49opOvq0sr5tnDWTlb0Q9b6ZW4mJxKncG6V7j7XnslmKN/LhPX/9OsNketOU+Gbz
 1klhtCaj8GtbzMUQOICy+X46PDWMyfewo/NkFh/MpWwuDtYKW5UZs0pWt4MsOPfnGIKo
 LExP7cj/dNEHIRg4bHMpCq6VWP7orWpNGykPPoG82hJHjxKIV5JNWgBkncvL1vGWcqrJ
 aFzA==
X-Gm-Message-State: APjAAAWY57Z5yjFTNoIGfiwm+brvD1la4HOwv8/8JVpugVQZau+XLEMP
 1Ic21OSWUFaUOzheDWgUvdEmW7C4HVCjRQ==
X-Google-Smtp-Source: APXvYqz4CGEMJjhlCgDAnrrPBSKjJqsVaXbiTr7qtxoSfs5yVlOTaNbNKFaeQJsla/dZ0zi2hGny7g==
X-Received: by 2002:a7b:c084:: with SMTP id r4mr28206011wmh.99.1580744947731; 
 Mon, 03 Feb 2020 07:49:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m9sm7212049wrx.55.2020.02.03.07.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 07:49:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] qga/qapi-schema.json: Fix missing '-' in GuestDiskBusType doc
 comment
Date: Mon,  3 Feb 2020 15:49:05 +0000
Message-Id: <20200203154905.13252-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
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
---
I noticed this while I was working on generation of rST format
documentation from the json doc comments. This is a prerequisite
for that work, so nobody needs to queue this patch (I'll include
it in my series along with some other mere-formatting fixes for
the doc comments) but I thought I might as well send it out
for review now so it doesn't get lost in a big boring-looking
Sphinx/rST patchset :-)

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


