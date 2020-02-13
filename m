Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8292CC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5243D206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tGwlv/+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5243D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Iph-0000mU-FY
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijp-0000hi-JP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijn-000304-US
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:21 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44779)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijn-0002vV-Lu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id m16so7783223wrx.11
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WG/jZg+6Ema0IEye1yAbgm9SmgPhpVrIhKYh9qk0Xfs=;
 b=tGwlv/+UqN4qdPmNebjLy5ZzPY0u+Eun/MdjMic5tj70EOCfrKbrZfbgPA8Ie3acGQ
 zmc27OEVXzXo1O1O8ZkfC6RmHxpXhA0D4cCPmshhMQ8gPyjEYkCb0QlQ8Rxzsqq3pAPb
 z39ETamZGVDjB9DHBJh9fbzBougvxNVHdJA0wvjI86UkUsE+NVlJuXnNjj70FreR3aBZ
 5lrAohY1/81WXo0hY/g9LS3roCI4sbvnd1ajsdbUtSySp9H89q96AAK6LBJx8R6W2PBs
 rvxfFRlyCN+USwFR3WXr+OiCjX1ECL+I8QGWsqMZMBieOCUdlnu6g/hsHfTgQ2onxo2V
 OHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WG/jZg+6Ema0IEye1yAbgm9SmgPhpVrIhKYh9qk0Xfs=;
 b=dM8M0FJteGHLguqcA8FBJbgUCypqFwhYzuxA+ZSu58hK4CURfUuP8n7dhi1uEhXoj6
 HsKcW6tS71NX6vga9LLKZxVb+G/1U4dBDYCMe6bAiJyVJRuTxHLNHtljLPQ/7lI+0qk4
 7QwLiJT90FNtdi66qxC6X0QtoOfKVdLeJf3S9KXVVxK6ELTqpQYX6vYQG9qEq8fxJkiQ
 xw2yrGQpO1ZsNopI0UV9GW7+Q9DXlthN4I1/AQWI1qSwK4KukS6dGhrcV5KLXgzaYMF0
 Dg2hx1dAmdQDrK08+jImgLKYacVQwRScaIoVkG3LrwRETagPyQD5ncvHDpG7OYkkQAU4
 SKDg==
X-Gm-Message-State: APjAAAX+hJocSTgqJAB0Iql868au6GaqWJKlW8jnecz4TUzUZxqd+I7Q
 mK0XjhDGsQgoRmI38/DlnOiG4naJtlw=
X-Google-Smtp-Source: APXvYqwXE0njSEe2USltb+IakH4cDPz2qDiqRPzhSgHNttD9hrIN2f8wvlQOpjNGbT94eYYZ38Lq6Q==
X-Received: by 2002:adf:db84:: with SMTP id u4mr23300767wri.317.1581616632071; 
 Thu, 13 Feb 2020 09:57:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/30] qapi/{block, misc, tmp,
 net}.json: Use explicit bulleted lists
Date: Thu, 13 Feb 2020 17:56:32 +0000
Message-Id: <20200213175647.17628-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

This commit gathers up the remaining json files which had
places needing this fix.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: minor commit msg tweak
---
 qapi/block.json | 33 ++++++++++++++-------------------
 qapi/misc.json  | 36 ++++++++++++++++--------------------
 qapi/tpm.json   |  4 ++--
 3 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 65eaacf31ad..da19834db41 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -115,15 +115,12 @@
 #
 # For the arguments, see the documentation of BlockdevSnapshotInternal.
 #
-# Returns: nothing on success
-#
-#          If @device is not a valid block device, GenericError
-#
-#          If any snapshot matching @name exists, or @name is empty,
-#          GenericError
-#
-#          If the format of the image used does not support it,
-#          BlockFormatFeatureNotSupported
+# Returns: - nothing on success
+#          - If @device is not a valid block device, GenericError
+#          - If any snapshot matching @name exists, or @name is empty,
+#            GenericError
+#          - If the format of the image used does not support it,
+#            BlockFormatFeatureNotSupported
 #
 # Since: 1.7
 #
@@ -154,12 +151,12 @@
 #
 # @name: optional the snapshot's name to be deleted
 #
-# Returns: SnapshotInfo on success
-#          If @device is not a valid block device, GenericError
-#          If snapshot not found, GenericError
-#          If the format of the image used does not support it,
-#          BlockFormatFeatureNotSupported
-#          If @id and @name are both not specified, GenericError
+# Returns: - SnapshotInfo on success
+#          - If @device is not a valid block device, GenericError
+#          - If snapshot not found, GenericError
+#          - If the format of the image used does not support it,
+#            BlockFormatFeatureNotSupported
+#          - If @id and @name are both not specified, GenericError
 #
 # Since: 1.7
 #
@@ -197,10 +194,8 @@
 # @force: If true, eject regardless of whether the drive is locked.
 #         If not specified, the default value is false.
 #
-# Returns:  Nothing on success
-#
-#           If @device is not a valid block device, DeviceNotFound
-#
+# Returns: - Nothing on success
+#          - If @device is not a valid block device, DeviceNotFound
 # Notes:    Ejecting a device with no media results in success
 #
 # Since: 0.14.0
diff --git a/qapi/misc.json b/qapi/misc.json
index 626a342b008..06c80b58a24 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -418,12 +418,10 @@
 #
 # Return information about the balloon device.
 #
-# Returns: @BalloonInfo on success
-#
-#          If the balloon driver is enabled but not functional because the KVM
-#          kernel module cannot support it, KvmMissingCap
-#
-#          If no balloon device is present, DeviceNotActive
+# Returns: - @BalloonInfo on success
+#          - If the balloon driver is enabled but not functional because the KVM
+#            kernel module cannot support it, KvmMissingCap
+#          - If no balloon device is present, DeviceNotActive
 #
 # Since: 0.14.0
 #
@@ -480,8 +478,8 @@
 #
 # @bar: the index of the Base Address Register for this region
 #
-# @type: 'io' if the region is a PIO region
-#        'memory' if the region is a MMIO region
+# @type: - 'io' if the region is a PIO region
+#        - 'memory' if the region is a MMIO region
 #
 # @size: memory size
 #
@@ -992,10 +990,10 @@
 #
 # @value: the target size of the balloon in bytes
 #
-# Returns: Nothing on success
-#          If the balloon driver is enabled but not functional because the KVM
+# Returns: - Nothing on success
+#          - If the balloon driver is enabled but not functional because the KVM
 #            kernel module cannot support it, KvmMissingCap
-#          If no balloon device is present, DeviceNotActive
+#          - If no balloon device is present, DeviceNotActive
 #
 # Notes: This command just issues a request to the guest.  When it returns,
 #        the balloon size may not have changed.  A guest can change the balloon
@@ -1074,8 +1072,8 @@
 #       If @device is 'vnc' and @target is 'password', this is the new VNC
 #       password to set.  See change-vnc-password for additional notes.
 #
-# Returns: Nothing on success.
-#          If @device is not a valid block device, DeviceNotFound
+# Returns: - Nothing on success.
+#          - If @device is not a valid block device, DeviceNotFound
 #
 # Notes: This interface is deprecated, and it is strongly recommended that you
 #        avoid using it.  For changing block devices, use
@@ -1225,11 +1223,9 @@
 #
 # @opaque: A free-form string that can be used to describe the fd.
 #
-# Returns: @AddfdInfo on success
-#
-#          If file descriptor was not received, FdNotSupplied
-#
-#          If @fdset-id is a negative value, InvalidParameterValue
+# Returns: - @AddfdInfo on success
+#          - If file descriptor was not received, FdNotSupplied
+#          - If @fdset-id is a negative value, InvalidParameterValue
 #
 # Notes: The list of fd sets is shared by all monitor connections.
 #
@@ -1257,8 +1253,8 @@
 #
 # @fd: The file descriptor that is to be removed.
 #
-# Returns: Nothing on success
-#          If @fdset-id or @fd is not found, FdNotFound
+# Returns: - Nothing on success
+#          - If @fdset-id or @fd is not found, FdNotFound
 #
 # Since: 1.2.0
 #
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 63878aa0f47..dc1f0817399 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -96,8 +96,8 @@
 #
 # A union referencing different TPM backend types' configuration options
 #
-# @type: 'passthrough' The configuration options for the TPM passthrough type
-#        'emulator' The configuration options for TPM emulator backend type
+# @type: - 'passthrough' The configuration options for the TPM passthrough type
+#        - 'emulator' The configuration options for TPM emulator backend type
 #
 # Since: 1.5
 ##
-- 
2.20.1


