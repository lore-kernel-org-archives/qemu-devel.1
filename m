Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CDBC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB7C20659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U4TnXLX9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB7C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ix2-00039W-Nl
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijg-0000aZ-RF
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ije-0002kT-Mi
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:12 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:39259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ije-0002i3-FS
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:10 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y11so7799805wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mu3MkvlL4TJMpHa8jn/jjpDGQdQ8pv8OsHnWYrWoDqc=;
 b=U4TnXLX90XXMV2WdPCsrWE+e9/UtZoiIRLQHYGsYarcEufmuRhJy2eISqhnxib1TEj
 gJLYJL9gi2/o9lXyw9VT2Lu1fy0Bc0KQFaqF9Ewd5l+xZMkiyt7yrLM4dR5ykjcSUENJ
 0HcXtuIHofsWeh9rqd09jGmt1wTsPGp1c28i369Ii/KFr9B3MeYNgZ6VrCyW4MS1Pshs
 AHCSNhR2Id/oSL2Y5I1tkpd2W2xWR87vhDmOHAkRtnzkcSq1X+d/1wk7WvF0g76cBz1G
 eb1JmfsQAoHw9voFVlATtbevDutPGdLHzX8n89GP4MQ7QIHEA18TfkQILa74MB0XAabd
 sC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mu3MkvlL4TJMpHa8jn/jjpDGQdQ8pv8OsHnWYrWoDqc=;
 b=blAvuUGKTPFSOjkKCqSDWnAnpD53GtyWkn9jR/nCHK3virT7gqnlYL98E54nUJ0ffX
 ch6UIRhVkHzyfMVwMKi+KHSQnYP0G8NuZ0SOlECUjyyc3FPh91NFrg3pQiWNw0mC3IJe
 VD1M9D3I04oIjDP0dxqgHtY2jzvGoMhlpxdkpyEq6K231qMENKk1PcdmokdHn6/G7qcd
 AtdSUxVgwy8f7WFIKccdrScDRcCocv5d0jzrGYhYAVS90Et1lvDveMrsYEwNlGg8DSu7
 f1yUtAMziRXTacSTNkJM/VDUt7mST6nd5cxZoi97RKL87jGw3/MmrhbsEm11+8yqiE8/
 i3oA==
X-Gm-Message-State: APjAAAWyjBvHWwPjado6ubuf/A9a4tM7pnjn1R9YnHqtgV59ompv5DVS
 l1xgcKL176ns/yrbKd8SNpX5xGkpTYg=
X-Google-Smtp-Source: APXvYqy0W4M2wcNg88Qiiym1yJKifncOYzw7oi0464jSEpr3YqhjaRF6+HBPXa4LOWg5uYwzlXZoFw==
X-Received: by 2002:adf:e610:: with SMTP id p16mr24461231wrm.81.1581616629063; 
 Thu, 13 Feb 2020 09:57:09 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/30] qapi/block-core.json: Use explicit bulleted lists
Date: Thu, 13 Feb 2020 17:56:30 +0000
Message-Id: <20200213175647.17628-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

A JSON block comment like this:
 Returns: nothing on success
          If @node is not a valid block device, DeviceNotFound
          If @name is not found, GenericError with an explanation

renders like this:

 Returns: nothing on success If node is not a valid block device,
 DeviceNotFound If name is not found, GenericError with an explanation

because whitespace is not significant.

Use an actual bulleted list, so that the formatting is correct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
v1->v2: minor commit msg tweak as suggested by Markus
---
 qapi/block-core.json | 108 +++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 31f7a1281c6..082aca3f699 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1326,8 +1326,8 @@
 #
 # @size:  new image size in bytes
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -1510,8 +1510,8 @@
 #
 # For the arguments, see the documentation of BlockdevSnapshotSync.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 0.14.0
 #
@@ -1586,9 +1586,8 @@
 #                when specifying the string or the image chain may
 #                not be able to be reopened again.
 #
-# Returns: Nothing on success
-#
-#          If "device" does not exist or cannot be determined, DeviceNotFound
+# Returns: - Nothing on success
+#          - If "device" does not exist or cannot be determined, DeviceNotFound
 #
 # Since: 2.1
 ##
@@ -1674,9 +1673,9 @@
 #                list without user intervention.
 #                Defaults to true. (Since 3.1)
 #
-# Returns: Nothing on success
-#          If @device does not exist, DeviceNotFound
-#          Any other error returns a GenericError.
+# Returns: - Nothing on success
+#          - If @device does not exist, DeviceNotFound
+#          - Any other error returns a GenericError.
 #
 # Since: 1.3
 #
@@ -1704,8 +1703,8 @@
 # The operation can be stopped before it has completed using the
 # block-job-cancel command.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, GenericError
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
 #
 # Since: 1.6
 #
@@ -1730,8 +1729,8 @@
 # The operation can be stopped before it has completed using the
 # block-job-cancel command.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 2.3
 #
@@ -1925,8 +1924,8 @@
 # format of the mirror image, default is to probe if mode='existing',
 # else the format of the source.
 #
-# Returns: nothing on success
-#          If @device is not a valid block device, GenericError
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
 #
 # Since: 1.3
 #
@@ -2097,9 +2096,9 @@
 #
 # Create a dirty bitmap with a name on the node, and start tracking the writes.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device or node, DeviceNotFound
-#          If @name is already taken, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device or node, DeviceNotFound
+#          - If @name is already taken, GenericError with an explanation
 #
 # Since: 2.4
 #
@@ -2120,10 +2119,10 @@
 # with block-dirty-bitmap-add. If the bitmap is persistent, remove it from its
 # storage too.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device or node, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
-#          if @name is frozen by an operation, GenericError
+# Returns: - nothing on success
+#          - If @node is not a valid block device or node, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
+#          - if @name is frozen by an operation, GenericError
 #
 # Since: 2.4
 #
@@ -2144,9 +2143,9 @@
 # backup from this point in time forward will only backup clusters
 # modified after this clear operation.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
 #
 # Since: 2.4
 #
@@ -2165,9 +2164,9 @@
 #
 # Enables a dirty bitmap so that it will begin tracking disk changes.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
 #
 # Since: 4.0
 #
@@ -2186,9 +2185,9 @@
 #
 # Disables a dirty bitmap so that it will stop tracking disk changes.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found, GenericError with an explanation
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found, GenericError with an explanation
 #
 # Since: 4.0
 #
@@ -2215,11 +2214,11 @@
 # of the source bitmaps. This can be used to achieve backup checkpoints, or in
 # simpler usages, to copy bitmaps.
 #
-# Returns: nothing on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If any bitmap in @bitmaps or @target is not found, GenericError
-#          If any of the bitmaps have different sizes or granularities,
-#              GenericError
+# Returns: - nothing on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If any bitmap in @bitmaps or @target is not found, GenericError
+#          - If any of the bitmaps have different sizes or granularities,
+#            GenericError
 #
 # Since: 4.0
 #
@@ -2251,10 +2250,10 @@
 #
 # Get bitmap SHA256.
 #
-# Returns: BlockDirtyBitmapSha256 on success
-#          If @node is not a valid block device, DeviceNotFound
-#          If @name is not found or if hashing has failed, GenericError with an
-#          explanation
+# Returns: - BlockDirtyBitmapSha256 on success
+#          - If @node is not a valid block device, DeviceNotFound
+#          - If @name is not found or if hashing has failed, GenericError with an
+#            explanation
 #
 # Since: 2.10
 ##
@@ -2371,8 +2370,8 @@
 # the device will be removed from its group and the rest of its
 # members will not be affected. The 'group' parameter is ignored.
 #
-# Returns: Nothing on success
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - Nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Since: 1.1
 #
@@ -2622,7 +2621,8 @@
 #                list without user intervention.
 #                Defaults to true. (Since 3.1)
 #
-# Returns: Nothing on success. If @device does not exist, DeviceNotFound.
+# Returns: - Nothing on success.
+#          - If @device does not exist, DeviceNotFound.
 #
 # Since: 1.1
 #
@@ -2656,8 +2656,8 @@
 # @speed: the maximum speed, in bytes per second, or 0 for unlimited.
 #         Defaults to 0.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotActive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNotActive
 #
 # Since: 1.1
 ##
@@ -2696,8 +2696,8 @@
 #         abandon the job immediately (even if it is paused) instead of waiting
 #         for the destination to complete its final synchronization (since 1.3)
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotActive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNotActive
 #
 # Since: 1.1
 ##
@@ -2720,8 +2720,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotActive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNotActive
 #
 # Since: 1.3
 ##
@@ -2742,8 +2742,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotActive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNotActive
 #
 # Since: 1.3
 ##
@@ -2770,8 +2770,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# Returns: Nothing on success
-#          If no background operation is active on this device, DeviceNotActive
+# Returns: - Nothing on success
+#          - If no background operation is active on this device, DeviceNotActive
 #
 # Since: 1.3
 ##
-- 
2.20.1


