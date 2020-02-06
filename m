Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DCFC352A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E33620659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbCnjgXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E33620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlBn-0001hx-Ef
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl03-0006mi-DU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzy-0006Qg-To
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:33 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzv-0006B1-1X
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:29 -0500
Received: by mail-wr1-x42e.google.com with SMTP id w12so8229642wrt.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iafVdg3waVWv4MsmBKz7Z/kOldmt8SzM/gApHhbQWYM=;
 b=MbCnjgXj0lRGhKJMlw47Kdi598FD6EoG88uBxplHMe7iyr0lAsfEo3bcBNgF3sgYCr
 PrhAOqpWfDg0AObWJKLoNtrbH8EnmpnhtiT2NIWmp+8KQRg7vOb0Ff2w5zM2SY2x+AW7
 Yl0PNE4/0AGFnpqY9cQLsYduBdIFYEOM69ibJ0ihWuYfVCZVKzU0CpoT/UGR2T389AZL
 J9QrF5hsU8mSvTekiytTNRrWhERxwnGwWjwASSrYIbLEJLkjWeC3FUKhsnBhx6HRTUs5
 Vqcdheq2A/eNWWWwexJ/RaVkr/fV+wjMkrXyeowbJrxiHPY7MHDok/cm9/kq/Js5Mqq7
 JJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iafVdg3waVWv4MsmBKz7Z/kOldmt8SzM/gApHhbQWYM=;
 b=axk6kzwB4T+HrVg1pn3t8bG1gP9lK7NZXcBMAp6HJtGXS/6pv/M0hHM/OJnMBn6r50
 bku4rUQ2ggvpcPl2ZpFI/e7fIzadRzuHEpMR0KgDl+YrsXD5keydy1f1y4xo5J6q+sP/
 z4xCkXrZ4BjvC5jzQPia5OeiVZ8JC+Bb+qsvb4WTm5LsPQ7JDgBLYo+fh1jtgP+cGlrq
 9VIXGzMx+Q7VmMefeuvFTWfN35k0J2nU3a9E/zLo2AEjk7jmz8yHTDNskRHUlVCftYm8
 hBFqaVShApuBLiIIUy53SxVk7r0imksRcsQhxyscyIZYWjllk8g84yCJ7AZm7Fz6//fD
 liwQ==
X-Gm-Message-State: APjAAAUyr9IWCrizaw5zA79oFYAD45Tw5rgMCi9AiKH7gn4MbQo55ubk
 SXuA+f9Da1nrFQDG/rQ7Vdz4jKF1xyo=
X-Google-Smtp-Source: APXvYqwzOE/ejjqatK6lWYo+rPhgtJe0UifoHWifAvtWEjxjgKsnqzE2HkKOfPzp67IclABR8w17aw==
X-Received: by 2002:a5d:608f:: with SMTP id w15mr4875905wrt.20.1581010284467; 
 Thu, 06 Feb 2020 09:31:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/29] qapi/{block, misc,
 tmp}.json: Use explicit bulleted lists
Date: Thu,  6 Feb 2020 17:30:27 +0000
Message-Id: <20200206173040.17337-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
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

renders in the HTML and manpage like this:

     Returns: nothing on success If node is not a valid block device,
     DeviceNotFound If name is not found, GenericError with an explanation

because whitespace is not significant.

Use an actual bulleted list, so that the formatting is correct.

This commit gathers up the remaining json files which had
places needing this fix.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block.json | 33 ++++++++++++++-------------------
 qapi/misc.json  | 36 ++++++++++++++++--------------------
 qapi/tpm.json   |  4 ++--
 3 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 905297bab2e..e509cc53506 100644
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


