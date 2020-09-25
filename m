Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086BDC4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0C52087D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTd8mKA/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0C52087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqXA-0008Fh-GU
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVI-0006PT-EF
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40792)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVG-0006ms-Bc
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:24 -0400
Received: by mail-wr1-x431.google.com with SMTP id j2so4218138wrx.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f3Y1p+WW0tVjbRnIDDuydFaNtzkRxU7Uq0iBhPhks/0=;
 b=RTd8mKA/+LdcjZQ+y7bRxAofNuJw16VSkhDUV2mRoEvX9NBzgbZomBumXHWa8NB7UF
 I88BVcd+qIymEGukHPMQmvRCu7PnqKR1WyBbTA/61u12Y4ZLqjU0LtCckj3KCQ99twZk
 xLGbJaPGWoMfaEW3JDOUQ5TDGdP4rekmaENNQLBO+fHT63Dmb16mhlfSmooNqTWt2ksu
 9n+rmST5saUwA1DH3vS3BvJmzD3TuIiB0edvOiXoyppNlVKDB3xp8tvMl9yHWnwf9eyC
 7YX1iK/Oq6vMg0YB6l6MCJvhsUEd3JvifGlCCUWsodVPG1CN0i/dPYZuaj4AcYYcr1In
 xFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=f3Y1p+WW0tVjbRnIDDuydFaNtzkRxU7Uq0iBhPhks/0=;
 b=k2hOFoTpAQRj6H63lYGIGAVRVbWKrKTUrcmq/lmUrCjADCzhdw8J6b27s7OEI+KMSx
 dyOjyWLvBVkROGdpXsYIntaT9LwGMca7vUJ0BNAB6Sd7EMTU0xceJyaRrTT/ABKDradr
 q/aJLBydA2YL2g/zy/v1jt0PiYoiNfoDpQF03NOdPvHNIoAoZmJac26iszZAzX0L0DaR
 8joUB9Hl7oHhFqV7GTCTtn02r6pYKFEYGNhG8o6EgEJ+py1Oq+MRp+rrqnIaM0Rjbp/z
 F5aEYAp7IxWAtD6YKaBXBhLNZnilOd2IlYlz5Sgt2cl8cwAAOIAzsTiQoa/UaRg8B/NM
 X4ZA==
X-Gm-Message-State: AOAM530wDhwFwJJ6IZucuGME/XPJRVvOVTBPUER6GY9s9dnMifmDh9ZP
 YYAkNLR/oShSfedB7ra/OndM0zZGsxuk9n8x
X-Google-Smtp-Source: ABdhPJwBl4fThuNXxxbkJDsQwMQZ9y43Kq0oHMc4oPQK3Kbrrt9dyIzgPibzg1A7KduvHW6/sVr0gA==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr5155248wra.383.1601050999311; 
 Fri, 25 Sep 2020 09:23:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 01/21] qapi: Fix doc comment indentation again
Date: Fri, 25 Sep 2020 17:22:56 +0100
Message-Id: <20200925162316.21205-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In commit 26ec4e53f2 and similar commits we fixed the indentation
for doc comments in our qapi json files to follow a new stricter
standard for indentation, which permits only:
    @arg: description line 1
          description line 2

or:
    @arg:
    line 1
    line 2

but because the script updates that enforce this are not yet in the
tree we have had a steady trickle of subsequent changes which didn't
follow the new rules.

Fix the latest round of mis-indented doc comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json |   4 +-
 qapi/migration.json  | 102 +++++++++++++++++++++----------------------
 2 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3c16f1e11d6..dd77a91174c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4316,8 +4316,8 @@
 # @data-file-raw: True if the external data file must stay valid as a
 #                 standalone (read-only) raw image without looking at qcow2
 #                 metadata (default: false; since: 4.0)
-# @extended-l2      True to make the image have extended L2 entries
-#                   (default: false; since 5.2)
+# @extended-l2: True to make the image have extended L2 entries
+#               (default: false; since 5.2)
 # @size: Size of the virtual disk in bytes
 # @version: Compatibility level (default: v3)
 # @backing-file: File name of the backing file if a backing file
diff --git a/qapi/migration.json b/qapi/migration.json
index 675f70bb673..b89052c6fd3 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -681,23 +681,23 @@
 #                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#          aliases for the purpose of dirty bitmap migration.  Such
-#          aliases may for example be the corresponding names on the
-#          opposite site.
-#          The mapping must be one-to-one, but not necessarily
-#          complete: On the source, unmapped bitmaps and all bitmaps
-#          on unmapped nodes will be ignored.  On the destination,
-#          encountering an unmapped alias in the incoming migration
-#          stream will result in a report, and all further bitmap
-#          migration data will then be discarded.
-#          Note that the destination does not know about bitmaps it
-#          does not receive, so there is no limitation or requirement
-#          regarding the number of bitmaps received, or how they are
-#          named, or on which nodes they are placed.
-#          By default (when this parameter has never been set), bitmap
-#          names are mapped to themselves.  Nodes are mapped to their
-#          block device name if there is one, and to their node name
-#          otherwise. (Since 5.2)
+#                        aliases for the purpose of dirty bitmap migration.  Such
+#                        aliases may for example be the corresponding names on the
+#                        opposite site.
+#                        The mapping must be one-to-one, but not necessarily
+#                        complete: On the source, unmapped bitmaps and all bitmaps
+#                        on unmapped nodes will be ignored.  On the destination,
+#                        encountering an unmapped alias in the incoming migration
+#                        stream will result in a report, and all further bitmap
+#                        migration data will then be discarded.
+#                        Note that the destination does not know about bitmaps it
+#                        does not receive, so there is no limitation or requirement
+#                        regarding the number of bitmaps received, or how they are
+#                        named, or on which nodes they are placed.
+#                        By default (when this parameter has never been set), bitmap
+#                        names are mapped to themselves.  Nodes are mapped to their
+#                        block device name if there is one, and to their node name
+#                        otherwise. (Since 5.2)
 #
 # Since: 2.4
 ##
@@ -841,23 +841,23 @@
 #                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#          aliases for the purpose of dirty bitmap migration.  Such
-#          aliases may for example be the corresponding names on the
-#          opposite site.
-#          The mapping must be one-to-one, but not necessarily
-#          complete: On the source, unmapped bitmaps and all bitmaps
-#          on unmapped nodes will be ignored.  On the destination,
-#          encountering an unmapped alias in the incoming migration
-#          stream will result in a report, and all further bitmap
-#          migration data will then be discarded.
-#          Note that the destination does not know about bitmaps it
-#          does not receive, so there is no limitation or requirement
-#          regarding the number of bitmaps received, or how they are
-#          named, or on which nodes they are placed.
-#          By default (when this parameter has never been set), bitmap
-#          names are mapped to themselves.  Nodes are mapped to their
-#          block device name if there is one, and to their node name
-#          otherwise. (Since 5.2)
+#                        aliases for the purpose of dirty bitmap migration.  Such
+#                        aliases may for example be the corresponding names on the
+#                        opposite site.
+#                        The mapping must be one-to-one, but not necessarily
+#                        complete: On the source, unmapped bitmaps and all bitmaps
+#                        on unmapped nodes will be ignored.  On the destination,
+#                        encountering an unmapped alias in the incoming migration
+#                        stream will result in a report, and all further bitmap
+#                        migration data will then be discarded.
+#                        Note that the destination does not know about bitmaps it
+#                        does not receive, so there is no limitation or requirement
+#                        regarding the number of bitmaps received, or how they are
+#                        named, or on which nodes they are placed.
+#                        By default (when this parameter has never been set), bitmap
+#                        names are mapped to themselves.  Nodes are mapped to their
+#                        block device name if there is one, and to their node name
+#                        otherwise. (Since 5.2)
 #
 # Since: 2.4
 ##
@@ -1037,23 +1037,23 @@
 #                      Defaults to 1. (Since 5.0)
 #
 # @block-bitmap-mapping: Maps block nodes and bitmaps on them to
-#          aliases for the purpose of dirty bitmap migration.  Such
-#          aliases may for example be the corresponding names on the
-#          opposite site.
-#          The mapping must be one-to-one, but not necessarily
-#          complete: On the source, unmapped bitmaps and all bitmaps
-#          on unmapped nodes will be ignored.  On the destination,
-#          encountering an unmapped alias in the incoming migration
-#          stream will result in a report, and all further bitmap
-#          migration data will then be discarded.
-#          Note that the destination does not know about bitmaps it
-#          does not receive, so there is no limitation or requirement
-#          regarding the number of bitmaps received, or how they are
-#          named, or on which nodes they are placed.
-#          By default (when this parameter has never been set), bitmap
-#          names are mapped to themselves.  Nodes are mapped to their
-#          block device name if there is one, and to their node name
-#          otherwise. (Since 5.2)
+#                        aliases for the purpose of dirty bitmap migration.  Such
+#                        aliases may for example be the corresponding names on the
+#                        opposite site.
+#                        The mapping must be one-to-one, but not necessarily
+#                        complete: On the source, unmapped bitmaps and all bitmaps
+#                        on unmapped nodes will be ignored.  On the destination,
+#                        encountering an unmapped alias in the incoming migration
+#                        stream will result in a report, and all further bitmap
+#                        migration data will then be discarded.
+#                        Note that the destination does not know about bitmaps it
+#                        does not receive, so there is no limitation or requirement
+#                        regarding the number of bitmaps received, or how they are
+#                        named, or on which nodes they are placed.
+#                        By default (when this parameter has never been set), bitmap
+#                        names are mapped to themselves.  Nodes are mapped to their
+#                        block device name if there is one, and to their node name
+#                        otherwise. (Since 5.2)
 #
 # Since: 2.4
 ##
-- 
2.20.1


