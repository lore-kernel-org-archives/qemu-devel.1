Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC532C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8174E20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhQ08Gl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8174E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlGB-0001JA-Kl
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzy-0006lD-SA
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzl-0005fa-0M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:28 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzi-0005Xq-Op
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id t23so900875wmi.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xgEZfV10KVwym47ddO9nXG+T95nZ8PI5TI4fV+/G1Nw=;
 b=QhQ08Gl9eBHdty9Y97OtJUbyd2ME8WhHB8tno4eB1uQuTGNKmPP4ehncLJnmFA89u3
 kR9COy3ffIYd0YfrvLLVjcXlCZITMyNIgnI5wnVTbZRroMA2P6vvu7qu7MYRC4sDB3Ol
 CcntQtNiM9k2UdRM1Zd+NkV/+ZyanBfyYtGLDpgOgF7FRPTeEC13T4BykvRew/mXrWbY
 uGfIRku+YxC35CeBGBZpfCV6Yi91S/IPXQg9liGe/JMIk0ocLnzN3eH+JE6JFHzP5CVP
 ReLMU4q2D36/BnyDw+LIJQKkc4ap2L6k5jOerA6NmnuoOU2V53+ldTeW2FRFXHba6mho
 JHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xgEZfV10KVwym47ddO9nXG+T95nZ8PI5TI4fV+/G1Nw=;
 b=UlnqaKV45Z6anbHtTutR2pv4JJmean8Xlp1qE5bcOUfjjv5gajtVtFL4b3wIKi2ga9
 ijlw0PkOBvPWVqnNlMEboQDMyo3zA2nLy6uN94zwnIzwOnMOXmbIBxHFEaDhWmNrUlsJ
 xG4WAxXQp14OpFdXuyt1qUtrOo1LpNER9z9UQv/UIg1S9ARNzrFP8fzx2kYR5i5RXJ7Q
 LJq9MTvJU2Y79yAgf9lqu/i5XObBkR3qrIO8fEAJ1kwyGzCYviJ8XGKmP7cfx4KOzqwo
 FvSktSRXvwvQiutMa5gU6J8vtfBvFKh8EEyrHLQ2AqB4FF1XeEqtbE8/9bEp8FxE47oA
 RBYg==
X-Gm-Message-State: APjAAAVkW8agkc7z3Hhw1rKbhh09RdGXhjEZFGOvL/9pUJsiXswIIl7o
 6t1MY8m2h4EzoguHeSvfjJ2mTMd8VCA=
X-Google-Smtp-Source: APXvYqzdku/tJpB7r9wC9Zhav0Qi3U3aJtc98TdemOnlvF/HtzUVwzy2zbWHy2BqQpiPgucpMnTz7A==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr5387823wmg.143.1581010267982; 
 Thu, 06 Feb 2020 09:31:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/29] qapi: Fix indent level on doc comments in json files
Date: Thu,  6 Feb 2020 17:30:20 +0000
Message-Id: <20200206173040.17337-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The texinfo doc generation doesn't care much about
indentation levels, but we would like to add a rST
backend, and rST does care about indentation.

Make the doc comments more strongly consistent about indentation
for multiline constructs like:

@arg: description line 1
      description line 2

Returns: line one
         line 2

so that there is always exactly one space after the
colon, and subsequent lines align with the first.

This commit is a purely whitespace change, and it does
not alter the generated .texi files (because the texi
generation code strips away all the extra whitespace).
This does mean that we end up with some over-length lines.

Note that when the documentation for an argument fits
on a single line like this:

@arg: one line only

then stray extra spaces after the ':' don't affect the
rST output, so I have not attempted to methodically
fix them, though the preference is a single space here too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json     | 776 +++++++++++++++++++--------------------
 qapi/block.json          |  14 +-
 qapi/char.json           |   8 +-
 qapi/dump.json           |   4 +-
 qapi/introspect.json     |  12 +-
 qapi/job.json            |  32 +-
 qapi/machine-target.json |  18 +-
 qapi/machine.json        |  12 +-
 qapi/migration.json      | 198 +++++-----
 qapi/misc-target.json    |   8 +-
 qapi/misc.json           | 102 ++---
 qapi/net.json            |  20 +-
 qapi/qdev.json           |  10 +-
 qapi/qom.json            |   4 +-
 qapi/rocker.json         |  12 +-
 qapi/run-state.json      |  34 +-
 qapi/sockets.json        |   8 +-
 qapi/trace.json          |  14 +-
 qapi/transaction.json    |   4 +-
 qapi/ui.json             |  36 +-
 20 files changed, 663 insertions(+), 663 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 076a4a4808e..006a0bf7a7c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -162,7 +162,7 @@
 # @backing-image: info of the backing image (since 1.6)
 #
 # @format-specific: structure supplying additional format-specific
-# information (since 1.7)
+#                   information (since 1.7)
 #
 # Since: 1.3
 #
@@ -708,7 +708,7 @@
 # Get a list of BlockInfo for all virtual block devices.
 #
 # Returns: a list of @BlockInfo describing each virtual block device. Filter
-# nodes that were created implicitly are skipped over.
+#          nodes that were created implicitly are skipped over.
 #
 # Since: 0.14.0
 #
@@ -1352,8 +1352,8 @@
 # @existing: QEMU should look for an existing image file.
 #
 # @absolute-paths: QEMU should create a new image with absolute paths
-# for the backing file. If there is no backing file available, the new
-# image will not be backed either.
+#                  for the backing file. If there is no backing file available, the new
+#                  image will not be backed either.
 #
 # Since: 1.1
 ##
@@ -1370,8 +1370,8 @@
 # @node-name: graph node name to generate the snapshot from (Since 2.0)
 #
 # @snapshot-file: the target of the new overlay image. If the file
-# exists, or if it is a device, the overlay will be created in the
-# existing file/device. Otherwise, a new file will be created.
+#                 exists, or if it is a device, the overlay will be created in the
+#                 existing file/device. Otherwise, a new file will be created.
 #
 # @snapshot-node-name: the graph node name of the new image (Since 2.0)
 #
@@ -1456,8 +1456,8 @@
 #                    a node name is autogenerated. (Since: 4.2)
 #
 # Note: @on-source-error and @on-target-error only affect background
-# I/O.  If an error occurs during a guest write request, the device's
-# rerror/werror actions will be used.
+#       I/O.  If an error occurs during a guest write request, the device's
+#       rerror/werror actions will be used.
 #
 # Since: 4.2
 ##
@@ -1578,13 +1578,13 @@
 #                   to verify "image-node-name" is in the chain
 #                   described by "device".
 #
-# @device:          The device name or node-name of the root node that owns
-#                   image-node-name.
+# @device: The device name or node-name of the root node that owns
+#          image-node-name.
 #
-# @backing-file:    The string to write as the backing file.  This
-#                   string is not validated, so care should be taken
-#                   when specifying the string or the image chain may
-#                   not be able to be reopened again.
+# @backing-file: The string to write as the backing file.  This
+#                string is not validated, so care should be taken
+#                when specifying the string or the image chain may
+#                not be able to be reopened again.
 #
 # Returns: Nothing on success
 #
@@ -1605,7 +1605,7 @@
 # @job-id: identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
 #
-# @device:  the device name or node-name of a root node
+# @device: the device name or node-name of a root node
 #
 # @base-node: The node name of the backing image to write data into.
 #             If not specified, this is the deepest backing image.
@@ -1625,36 +1625,36 @@
 #       node; other strings, even if addressing the same file, are not
 #       accepted (deprecated, use @base-node instead)
 #
-# @backing-file:  The backing file string to write into the overlay
-#                           image of 'top'.  If 'top' is the active layer,
-#                           specifying a backing file string is an error. This
-#                           filename is not validated.
+# @backing-file: The backing file string to write into the overlay
+#                image of 'top'.  If 'top' is the active layer,
+#                specifying a backing file string is an error. This
+#                filename is not validated.
 #
-#                           If a pathname string is such that it cannot be
-#                           resolved by QEMU, that means that subsequent QMP or
-#                           HMP commands must use node-names for the image in
-#                           question, as filename lookup methods will fail.
+#                If a pathname string is such that it cannot be
+#                resolved by QEMU, that means that subsequent QMP or
+#                HMP commands must use node-names for the image in
+#                question, as filename lookup methods will fail.
 #
-#                           If not specified, QEMU will automatically determine
-#                           the backing file string to use, or error out if
-#                           there is no obvious choice. Care should be taken
-#                           when specifying the string, to specify a valid
-#                           filename or protocol.
-#                           (Since 2.1)
+#                If not specified, QEMU will automatically determine
+#                the backing file string to use, or error out if
+#                there is no obvious choice. Care should be taken
+#                when specifying the string, to specify a valid
+#                filename or protocol.
+#                (Since 2.1)
 #
-#                    If top == base, that is an error.
-#                    If top == active, the job will not be completed by itself,
-#                    user needs to complete the job with the block-job-complete
-#                    command after getting the ready event. (Since 2.0)
+#                If top == base, that is an error.
+#                If top == active, the job will not be completed by itself,
+#                user needs to complete the job with the block-job-complete
+#                command after getting the ready event. (Since 2.0)
 #
-#                    If the base image is smaller than top, then the base image
-#                    will be resized to be the same size as top.  If top is
-#                    smaller than the base image, the base will not be
-#                    truncated.  If you want the base image size to match the
-#                    size of the smaller top, you can safely truncate it
-#                    yourself once the commit operation successfully completes.
+#                If the base image is smaller than top, then the base image
+#                will be resized to be the same size as top.  If top is
+#                smaller than the base image, the base will not be
+#                truncated.  If you want the base image size to match the
+#                size of the smaller top, you can safely truncate it
+#                yourself once the commit operation successfully completes.
 #
-# @speed:  the maximum speed, in bytes per second
+# @speed: the maximum speed, in bytes per second
 #
 # @filter-node-name: the node name that should be assigned to the
 #                    filter driver that the commit job inserts into the graph
@@ -2439,52 +2439,52 @@
 # @iops_wr: write I/O operations per second
 #
 # @bps_max: total throughput limit during bursts,
-#                     in bytes (Since 1.7)
+#           in bytes (Since 1.7)
 #
 # @bps_rd_max: read throughput limit during bursts,
-#                        in bytes (Since 1.7)
+#              in bytes (Since 1.7)
 #
 # @bps_wr_max: write throughput limit during bursts,
-#                        in bytes (Since 1.7)
+#              in bytes (Since 1.7)
 #
 # @iops_max: total I/O operations per second during bursts,
-#                      in bytes (Since 1.7)
+#            in bytes (Since 1.7)
 #
 # @iops_rd_max: read I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
+#               in bytes (Since 1.7)
 #
 # @iops_wr_max: write I/O operations per second during bursts,
-#                         in bytes (Since 1.7)
+#               in bytes (Since 1.7)
 #
 # @bps_max_length: maximum length of the @bps_max burst
-#                            period, in seconds. It must only
-#                            be set if @bps_max is set as well.
-#                            Defaults to 1. (Since 2.6)
+#                  period, in seconds. It must only
+#                  be set if @bps_max is set as well.
+#                  Defaults to 1. (Since 2.6)
 #
 # @bps_rd_max_length: maximum length of the @bps_rd_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_rd_max is set as well.
-#                               Defaults to 1. (Since 2.6)
+#                     burst period, in seconds. It must only
+#                     be set if @bps_rd_max is set as well.
+#                     Defaults to 1. (Since 2.6)
 #
 # @bps_wr_max_length: maximum length of the @bps_wr_max
-#                               burst period, in seconds. It must only
-#                               be set if @bps_wr_max is set as well.
-#                               Defaults to 1. (Since 2.6)
+#                     burst period, in seconds. It must only
+#                     be set if @bps_wr_max is set as well.
+#                     Defaults to 1. (Since 2.6)
 #
 # @iops_max_length: maximum length of the @iops burst
-#                             period, in seconds. It must only
-#                             be set if @iops_max is set as well.
-#                             Defaults to 1. (Since 2.6)
+#                   period, in seconds. It must only
+#                   be set if @iops_max is set as well.
+#                   Defaults to 1. (Since 2.6)
 #
 # @iops_rd_max_length: maximum length of the @iops_rd_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_rd_max is set as well.
-#                                Defaults to 1. (Since 2.6)
+#                      burst period, in seconds. It must only
+#                      be set if @iops_rd_max is set as well.
+#                      Defaults to 1. (Since 2.6)
 #
 # @iops_wr_max_length: maximum length of the @iops_wr_max
-#                                burst period, in seconds. It must only
-#                                be set if @iops_wr_max is set as well.
-#                                Defaults to 1. (Since 2.6)
+#                      burst period, in seconds. It must only
+#                      be set if @iops_wr_max is set as well.
+#                      Defaults to 1. (Since 2.6)
 #
 # @iops_size: an I/O size in bytes (Since 1.7)
 #
@@ -2511,31 +2511,31 @@
 # transaction. All fields are optional. When setting limits, if a field is
 # missing the current value is not changed.
 #
-# @iops-total:             limit total I/O operations per second
-# @iops-total-max:         I/O operations burst
-# @iops-total-max-length:  length of the iops-total-max burst period, in seconds
-#                          It must only be set if @iops-total-max is set as well.
-# @iops-read:              limit read operations per second
-# @iops-read-max:          I/O operations read burst
-# @iops-read-max-length:   length of the iops-read-max burst period, in seconds
-#                          It must only be set if @iops-read-max is set as well.
-# @iops-write:             limit write operations per second
-# @iops-write-max:         I/O operations write burst
-# @iops-write-max-length:  length of the iops-write-max burst period, in seconds
-#                          It must only be set if @iops-write-max is set as well.
-# @bps-total:              limit total bytes per second
-# @bps-total-max:          total bytes burst
-# @bps-total-max-length:   length of the bps-total-max burst period, in seconds.
-#                          It must only be set if @bps-total-max is set as well.
-# @bps-read:               limit read bytes per second
-# @bps-read-max:           total bytes read burst
-# @bps-read-max-length:    length of the bps-read-max burst period, in seconds
-#                          It must only be set if @bps-read-max is set as well.
-# @bps-write:              limit write bytes per second
-# @bps-write-max:          total bytes write burst
-# @bps-write-max-length:   length of the bps-write-max burst period, in seconds
-#                          It must only be set if @bps-write-max is set as well.
-# @iops-size:              when limiting by iops max size of an I/O in bytes
+# @iops-total: limit total I/O operations per second
+# @iops-total-max: I/O operations burst
+# @iops-total-max-length: length of the iops-total-max burst period, in seconds
+#                         It must only be set if @iops-total-max is set as well.
+# @iops-read: limit read operations per second
+# @iops-read-max: I/O operations read burst
+# @iops-read-max-length: length of the iops-read-max burst period, in seconds
+#                        It must only be set if @iops-read-max is set as well.
+# @iops-write: limit write operations per second
+# @iops-write-max: I/O operations write burst
+# @iops-write-max-length: length of the iops-write-max burst period, in seconds
+#                         It must only be set if @iops-write-max is set as well.
+# @bps-total: limit total bytes per second
+# @bps-total-max: total bytes burst
+# @bps-total-max-length: length of the bps-total-max burst period, in seconds.
+#                        It must only be set if @bps-total-max is set as well.
+# @bps-read: limit read bytes per second
+# @bps-read-max: total bytes read burst
+# @bps-read-max-length: length of the bps-read-max burst period, in seconds
+#                       It must only be set if @bps-read-max is set as well.
+# @bps-write: limit write bytes per second
+# @bps-write-max: total bytes write burst
+# @bps-write-max-length: length of the bps-write-max burst period, in seconds
+#                        It must only be set if @bps-write-max is set as well.
+# @iops-size: when limiting by iops max size of an I/O in bytes
 #
 # Since: 2.11
 ##
@@ -2582,28 +2582,28 @@
 #
 # @device: the device or node name of the top image
 #
-# @base:   the common backing file name.
-#                    It cannot be set if @base-node is also set.
+# @base: the common backing file name.
+#        It cannot be set if @base-node is also set.
 #
 # @base-node: the node name of the backing file.
-#                       It cannot be set if @base is also set. (Since 2.8)
+#             It cannot be set if @base is also set. (Since 2.8)
 #
 # @backing-file: The backing file string to write into the top
-#                          image. This filename is not validated.
+#                image. This filename is not validated.
 #
-#                          If a pathname string is such that it cannot be
-#                          resolved by QEMU, that means that subsequent QMP or
-#                          HMP commands must use node-names for the image in
-#                          question, as filename lookup methods will fail.
+#                If a pathname string is such that it cannot be
+#                resolved by QEMU, that means that subsequent QMP or
+#                HMP commands must use node-names for the image in
+#                question, as filename lookup methods will fail.
 #
-#                          If not specified, QEMU will automatically determine
-#                          the backing file string to use, or error out if there
-#                          is no obvious choice.  Care should be taken when
-#                          specifying the string, to specify a valid filename or
-#                          protocol.
-#                          (Since 2.1)
+#                If not specified, QEMU will automatically determine
+#                the backing file string to use, or error out if there
+#                is no obvious choice.  Care should be taken when
+#                specifying the string, to specify a valid filename or
+#                protocol.
+#                (Since 2.1)
 #
-# @speed:  the maximum speed, in bytes per second
+# @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error (default report).
 #            'stop' and 'enospc' can only be used if the block device
@@ -2653,8 +2653,8 @@
 #          the name of the parameter), but since QEMU 2.7 it can have
 #          other values.
 #
-# @speed:  the maximum speed, in bytes per second, or 0 for unlimited.
-#          Defaults to 0.
+# @speed: the maximum speed, in bytes per second, or 0 for unlimited.
+#         Defaults to 0.
 #
 # Returns: Nothing on success
 #          If no background operation is active on this device, DeviceNotActive
@@ -2820,8 +2820,8 @@
 #
 # Determines how to handle discard requests.
 #
-# @ignore:      Ignore the request
-# @unmap:       Forward as an unmap request
+# @ignore: Ignore the request
+# @unmap: Forward as an unmap request
 #
 # Since: 2.9
 ##
@@ -2834,10 +2834,10 @@
 # Describes the operation mode for the automatic conversion of plain
 # zero writes by the OS to driver specific optimized zero write commands.
 #
-# @off:      Disabled (default)
-# @on:       Enabled
-# @unmap:    Enabled and even try to unmap blocks if possible. This requires
-#            also that @BlockdevDiscardOptions is set to unmap for this device.
+# @off: Disabled (default)
+# @on: Enabled
+# @unmap: Enabled and even try to unmap blocks if possible. This requires
+#         also that @BlockdevDiscardOptions is set to unmap for this device.
 #
 # Since: 2.1
 ##
@@ -2849,9 +2849,9 @@
 #
 # Selects the AIO backend to handle I/O requests
 #
-# @threads:     Use qemu's thread pool
-# @native:      Use native AIO backend (only Linux and Windows)
-# @io_uring:    Use linux io_uring (since 5.0)
+# @threads: Use qemu's thread pool
+# @native: Use native AIO backend (only Linux and Windows)
+# @io_uring: Use linux io_uring (since 5.0)
 #
 # Since: 2.9
 ##
@@ -2864,10 +2864,10 @@
 #
 # Includes cache-related options for block devices
 #
-# @direct:      enables use of O_DIRECT (bypass the host page cache;
-#               default: false)
-# @no-flush:    ignore any flush requests for the device (default:
-#               false)
+# @direct: enables use of O_DIRECT (bypass the host page cache;
+#          default: false)
+# @no-flush: ignore any flush requests for the device (default:
+#            false)
 #
 # Since: 2.9
 ##
@@ -2905,18 +2905,18 @@
 #
 # Driver specific block device options for the file backend.
 #
-# @filename:    path to the image file
-# @pr-manager:  the id for the object that will handle persistent reservations
-#               for this device (default: none, forward the commands via SG_IO;
-#               since 2.11)
-# @aio:         AIO backend (default: threads) (since: 2.8)
-# @locking:     whether to enable file locking. If set to 'auto', only enable
-#               when Open File Descriptor (OFD) locking API is available
-#               (default: auto, since 2.10)
-# @drop-cache:  invalidate page cache during live migration.  This prevents
-#               stale data on the migration destination with cache.direct=off.
-#               Currently only supported on Linux hosts.
-#               (default: on, since: 4.0)
+# @filename: path to the image file
+# @pr-manager: the id for the object that will handle persistent reservations
+#              for this device (default: none, forward the commands via SG_IO;
+#              since 2.11)
+# @aio: AIO backend (default: threads) (since: 2.8)
+# @locking: whether to enable file locking. If set to 'auto', only enable
+#           when Open File Descriptor (OFD) locking API is available
+#           (default: auto, since 2.10)
+# @drop-cache: invalidate page cache during live migration.  This prevents
+#              stale data on the migration destination with cache.direct=off.
+#              Currently only supported on Linux hosts.
+#              (default: on, since: 4.0)
 # @x-check-cache-dropped: whether to check that page cache was dropped on live
 #                         migration.  May cause noticeable delays if the image
 #                         file is large, do not use in production.
@@ -2949,7 +2949,7 @@
 #
 # Driver specific block device options for the null backend.
 #
-# @size:    size of the device in bytes.
+# @size: size of the device in bytes.
 # @latency-ns: emulated latency (in nanoseconds) in processing
 #              requests. Default to zero which completes requests immediately.
 #              (Since 2.4)
@@ -2966,8 +2966,8 @@
 #
 # Driver specific block device options for the NVMe backend.
 #
-# @device:    PCI controller address of the NVMe device in
-#             format hhhh:bb:ss.f (host:bus:slot.function)
+# @device: PCI controller address of the NVMe device in
+#          format hhhh:bb:ss.f (host:bus:slot.function)
 # @namespace: namespace number of the device, starting from 1.
 #
 # Note that the PCI @device must have been unbound from any host
@@ -2983,15 +2983,15 @@
 #
 # Driver specific block device options for the vvfat protocol.
 #
-# @dir:         directory to be exported as FAT image
-# @fat-type:    FAT type: 12, 16 or 32
-# @floppy:      whether to export a floppy image (true) or
-#               partitioned hard disk (false; default)
-# @label:       set the volume label, limited to 11 bytes. FAT16 and
-#               FAT32 traditionally have some restrictions on labels, which are
-#               ignored by most operating systems. Defaults to "QEMU VVFAT".
-#               (since 2.4)
-# @rw:          whether to allow write operations (default: false)
+# @dir: directory to be exported as FAT image
+# @fat-type: FAT type: 12, 16 or 32
+# @floppy: whether to export a floppy image (true) or
+#          partitioned hard disk (false; default)
+# @label: set the volume label, limited to 11 bytes. FAT16 and
+#         FAT32 traditionally have some restrictions on labels, which are
+#         ignored by most operating systems. Defaults to "QEMU VVFAT".
+#         (since 2.4)
+# @rw: whether to allow write operations (default: false)
 #
 # Since: 2.9
 ##
@@ -3005,7 +3005,7 @@
 # Driver specific block device options for image format that have no option
 # besides their data source.
 #
-# @file:        reference to or definition of the data source block device
+# @file: reference to or definition of the data source block device
 #
 # Since: 2.9
 ##
@@ -3034,9 +3034,9 @@
 # Driver specific block device options for image format that have no option
 # besides their data source and an optional backing file.
 #
-# @backing:     reference to or definition of the backing file block
-#               device, null disables the backing file entirely.
-#               Defaults to the backing file stored the image file.
+# @backing: reference to or definition of the backing file block
+#           device, null disables the backing file entirely.
+#           Defaults to the backing file stored the image file.
 #
 # Since: 2.9
 ##
@@ -3049,15 +3049,15 @@
 #
 # General overlap check modes.
 #
-# @none:        Do not perform any checks
+# @none: Do not perform any checks
 #
-# @constant:    Perform only checks which can be done in constant time and
-#               without reading anything from disk
+# @constant: Perform only checks which can be done in constant time and
+#            without reading anything from disk
 #
-# @cached:      Perform only checks which can be done without reading anything
-#               from disk
+# @cached: Perform only checks which can be done without reading anything
+#          from disk
 #
-# @all:         Perform all available overlap checks
+# @all: Perform all available overlap checks
 #
 # Since: 2.9
 ##
@@ -3096,10 +3096,10 @@
 # Specifies which metadata structures should be guarded against unintended
 # overwriting.
 #
-# @flags:   set of flags for separate specification of each metadata structure
-#           type
+# @flags: set of flags for separate specification of each metadata structure
+#         type
 #
-# @mode:    named mode which chooses a specific set of flags
+# @mode: named mode which chooses a specific set of flags
 #
 # Since: 2.9
 ##
@@ -3132,9 +3132,9 @@
 #
 # Driver specific block device options for qcow.
 #
-# @encrypt:               Image decryption options. Mandatory for
-#                         encrypted images, except when doing a metadata-only
-#                         probe of the image.
+# @encrypt: Image decryption options. Mandatory for
+#           encrypted images, except when doing a metadata-only
+#           probe of the image.
 #
 # Since: 2.10
 ##
@@ -3169,51 +3169,51 @@
 #
 # Driver specific block device options for qcow2.
 #
-# @lazy-refcounts:        whether to enable the lazy refcounts
-#                         feature (default is taken from the image file)
+# @lazy-refcounts: whether to enable the lazy refcounts
+#                  feature (default is taken from the image file)
 #
-# @pass-discard-request:  whether discard requests to the qcow2
-#                         device should be forwarded to the data source
+# @pass-discard-request: whether discard requests to the qcow2
+#                        device should be forwarded to the data source
 #
 # @pass-discard-snapshot: whether discard requests for the data source
 #                         should be issued when a snapshot operation (e.g.
 #                         deleting a snapshot) frees clusters in the qcow2 file
 #
-# @pass-discard-other:    whether discard requests for the data source
-#                         should be issued on other occasions where a cluster
-#                         gets freed
+# @pass-discard-other: whether discard requests for the data source
+#                      should be issued on other occasions where a cluster
+#                      gets freed
 #
-# @overlap-check:         which overlap checks to perform for writes
-#                         to the image, defaults to 'cached' (since 2.2)
+# @overlap-check: which overlap checks to perform for writes
+#                 to the image, defaults to 'cached' (since 2.2)
 #
-# @cache-size:            the maximum total size of the L2 table and
-#                         refcount block caches in bytes (since 2.2)
+# @cache-size: the maximum total size of the L2 table and
+#              refcount block caches in bytes (since 2.2)
 #
-# @l2-cache-size:         the maximum size of the L2 table cache in
-#                         bytes (since 2.2)
+# @l2-cache-size: the maximum size of the L2 table cache in
+#                 bytes (since 2.2)
 #
-# @l2-cache-entry-size:   the size of each entry in the L2 cache in
-#                         bytes. It must be a power of two between 512
-#                         and the cluster size. The default value is
-#                         the cluster size (since 2.12)
+# @l2-cache-entry-size: the size of each entry in the L2 cache in
+#                       bytes. It must be a power of two between 512
+#                       and the cluster size. The default value is
+#                       the cluster size (since 2.12)
 #
-# @refcount-cache-size:   the maximum size of the refcount block cache
-#                         in bytes (since 2.2)
+# @refcount-cache-size: the maximum size of the refcount block cache
+#                       in bytes (since 2.2)
 #
-# @cache-clean-interval:  clean unused entries in the L2 and refcount
-#                         caches. The interval is in seconds. The default value
-#                         is 600 on supporting platforms, and 0 on other
-#                         platforms. 0 disables this feature. (since 2.5)
+# @cache-clean-interval: clean unused entries in the L2 and refcount
+#                        caches. The interval is in seconds. The default value
+#                        is 600 on supporting platforms, and 0 on other
+#                        platforms. 0 disables this feature. (since 2.5)
 #
-# @encrypt:               Image decryption options. Mandatory for
-#                         encrypted images, except when doing a metadata-only
-#                         probe of the image. (since 2.10)
+# @encrypt: Image decryption options. Mandatory for
+#           encrypted images, except when doing a metadata-only
+#           probe of the image. (since 2.10)
 #
-# @data-file:             reference to or definition of the external data file.
-#                         This may only be specified for images that require an
-#                         external data file. If it is not specified for such
-#                         an image, the data file name is loaded from the image
-#                         file. (since 4.0)
+# @data-file: reference to or definition of the external data file.
+#             This may only be specified for images that require an
+#             external data file. If it is not specified for such
+#             an image, the data file name is loaded from the image
+#             file. (since 4.0)
 #
 # Since: 2.9
 ##
@@ -3304,8 +3304,8 @@
 #
 # Trigger events supported by blkdebug.
 #
-# @l1_shrink_write_table:      write zeros to the l1 table to shrink image.
-#                              (since 2.11)
+# @l1_shrink_write_table: write zeros to the l1 table to shrink image.
+#                         (since 2.11)
 #
 # @l1_shrink_free_l2_clusters: discard the l2 tables. (since 2.11)
 #
@@ -3363,25 +3363,25 @@
 #
 # Describes a single error injection for blkdebug.
 #
-# @event:       trigger event
+# @event: trigger event
 #
-# @state:       the state identifier blkdebug needs to be in to
-#               actually trigger the event; defaults to "any"
+# @state: the state identifier blkdebug needs to be in to
+#         actually trigger the event; defaults to "any"
 #
-# @iotype:      the type of I/O operations on which this error should
-#               be injected; defaults to "all read, write,
-#               write-zeroes, discard, and flush operations"
-#               (since: 4.1)
+# @iotype: the type of I/O operations on which this error should
+#          be injected; defaults to "all read, write,
+#          write-zeroes, discard, and flush operations"
+#          (since: 4.1)
 #
-# @errno:       error identifier (errno) to be returned; defaults to
-#               EIO
+# @errno: error identifier (errno) to be returned; defaults to
+#         EIO
 #
-# @sector:      specifies the sector index which has to be affected
-#               in order to actually trigger the event; defaults to "any
-#               sector"
+# @sector: specifies the sector index which has to be affected
+#          in order to actually trigger the event; defaults to "any
+#          sector"
 #
-# @once:        disables further events after this one has been
-#               triggered; defaults to false
+# @once: disables further events after this one has been
+#        triggered; defaults to false
 #
 # @immediately: fail immediately; defaults to false
 #
@@ -3401,13 +3401,13 @@
 #
 # Describes a single state-change event for blkdebug.
 #
-# @event:       trigger event
+# @event: trigger event
 #
-# @state:       the current state identifier blkdebug needs to be in;
-#               defaults to "any"
+# @state: the current state identifier blkdebug needs to be in;
+#         defaults to "any"
 #
-# @new_state:   the state identifier blkdebug is supposed to assume if
-#               this event is triggered
+# @new_state: the state identifier blkdebug is supposed to assume if
+#             this event is triggered
 #
 # Since: 2.9
 ##
@@ -3421,41 +3421,41 @@
 #
 # Driver specific block device options for blkdebug.
 #
-# @image:           underlying raw block device (or image file)
+# @image: underlying raw block device (or image file)
 #
-# @config:          filename of the configuration file
+# @config: filename of the configuration file
 #
-# @align:           required alignment for requests in bytes, must be
-#                   positive power of 2, or 0 for default
+# @align: required alignment for requests in bytes, must be
+#         positive power of 2, or 0 for default
 #
-# @max-transfer:    maximum size for I/O transfers in bytes, must be
-#                   positive multiple of @align and of the underlying
-#                   file's request alignment (but need not be a power of
-#                   2), or 0 for default (since 2.10)
+# @max-transfer: maximum size for I/O transfers in bytes, must be
+#                positive multiple of @align and of the underlying
+#                file's request alignment (but need not be a power of
+#                2), or 0 for default (since 2.10)
 #
-# @opt-write-zero:  preferred alignment for write zero requests in bytes,
-#                   must be positive multiple of @align and of the
-#                   underlying file's request alignment (but need not be a
-#                   power of 2), or 0 for default (since 2.10)
+# @opt-write-zero: preferred alignment for write zero requests in bytes,
+#                  must be positive multiple of @align and of the
+#                  underlying file's request alignment (but need not be a
+#                  power of 2), or 0 for default (since 2.10)
 #
-# @max-write-zero:  maximum size for write zero requests in bytes, must be
-#                   positive multiple of @align, of @opt-write-zero, and of
-#                   the underlying file's request alignment (but need not
-#                   be a power of 2), or 0 for default (since 2.10)
+# @max-write-zero: maximum size for write zero requests in bytes, must be
+#                  positive multiple of @align, of @opt-write-zero, and of
+#                  the underlying file's request alignment (but need not
+#                  be a power of 2), or 0 for default (since 2.10)
 #
-# @opt-discard:     preferred alignment for discard requests in bytes, must
-#                   be positive multiple of @align and of the underlying
-#                   file's request alignment (but need not be a power of
-#                   2), or 0 for default (since 2.10)
+# @opt-discard: preferred alignment for discard requests in bytes, must
+#               be positive multiple of @align and of the underlying
+#               file's request alignment (but need not be a power of
+#               2), or 0 for default (since 2.10)
 #
-# @max-discard:     maximum size for discard requests in bytes, must be
-#                   positive multiple of @align, of @opt-discard, and of
-#                   the underlying file's request alignment (but need not
-#                   be a power of 2), or 0 for default (since 2.10)
+# @max-discard: maximum size for discard requests in bytes, must be
+#               positive multiple of @align, of @opt-discard, and of
+#               the underlying file's request alignment (but need not
+#               be a power of 2), or 0 for default (since 2.10)
 #
-# @inject-error:    array of error injection descriptions
+# @inject-error: array of error injection descriptions
 #
-# @set-state:       array of state-change descriptions
+# @set-state: array of state-change descriptions
 #
 # @take-child-perms: Permissions to take on @image in addition to what
 #                    is necessary anyway (which depends on how the
@@ -3485,14 +3485,14 @@
 #
 # Driver specific block device options for blklogwrites.
 #
-# @file:            block device
+# @file: block device
 #
-# @log:             block device used to log writes to @file
+# @log: block device used to log writes to @file
 #
 # @log-sector-size: sector size used in logging writes to @file, determines
 #                   granularity of offsets and sizes of writes (default: 512)
 #
-# @log-append:      append to an existing log (default: false)
+# @log-append: append to an existing log (default: false)
 #
 # @log-super-update-interval: interval of write requests after which the log
 #                             super block is updated to disk (default: 4096)
@@ -3511,9 +3511,9 @@
 #
 # Driver specific block device options for blkverify.
 #
-# @test:    block device to be tested
+# @test: block device to be tested
 #
-# @raw:     raw image used for verification
+# @raw: raw image used for verification
 #
 # Since: 2.9
 ##
@@ -3526,7 +3526,7 @@
 #
 # Driver specific block device options for blkreplay.
 #
-# @image:     disk image which should be controlled with blkreplay
+# @image: disk image which should be controlled with blkreplay
 #
 # Since: 4.2
 ##
@@ -3551,10 +3551,10 @@
 #
 # Driver specific block device options for Quorum
 #
-# @blkverify:      true if the driver must print content mismatch
+# @blkverify: true if the driver must print content mismatch
 #                  set to false by default
 #
-# @children:       the children block devices to use
+# @children: the children block devices to use
 #
 # @vote-threshold: the vote limit under which a read will fail
 #
@@ -3578,16 +3578,16 @@
 #
 # Driver specific block device options for Gluster
 #
-# @volume:      name of gluster volume where VM image resides
+# @volume: name of gluster volume where VM image resides
 #
-# @path:        absolute path to image file in gluster volume
+# @path: absolute path to image file in gluster volume
 #
-# @server:      gluster servers description
+# @server: gluster servers description
 #
-# @debug:       libgfapi log level (default '4' which is Error)
-#               (Since 2.8)
+# @debug: libgfapi log level (default '4' which is Error)
+#         (Since 2.8)
 #
-# @logfile:     libgfapi log file (default /dev/stderr) (Since 2.8)
+# @logfile: libgfapi log file (default /dev/stderr) (Since 2.8)
 #
 # Since: 2.9
 ##
@@ -3622,30 +3622,30 @@
 ##
 # @BlockdevOptionsIscsi:
 #
-# @transport:       The iscsi transport type
+# @transport: The iscsi transport type
 #
-# @portal:          The address of the iscsi portal
+# @portal: The address of the iscsi portal
 #
-# @target:          The target iqn name
+# @target: The target iqn name
 #
-# @lun:             LUN to connect to. Defaults to 0.
+# @lun: LUN to connect to. Defaults to 0.
 #
-# @user:            User name to log in with. If omitted, no CHAP
-#                   authentication is performed.
+# @user: User name to log in with. If omitted, no CHAP
+#        authentication is performed.
 #
 # @password-secret: The ID of a QCryptoSecret object providing
 #                   the password for the login. This option is required if
 #                   @user is specified.
 #
-# @initiator-name:  The iqn name we want to identify to the target
-#                   as. If this option is not specified, an initiator name is
-#                   generated automatically.
+# @initiator-name: The iqn name we want to identify to the target
+#                  as. If this option is not specified, an initiator name is
+#                  generated automatically.
 #
-# @header-digest:   The desired header digest. Defaults to
-#                   none-crc32c.
+# @header-digest: The desired header digest. Defaults to
+#                 none-crc32c.
 #
-# @timeout:         Timeout in seconds after which a request will
-#                   timeout. 0 means no timeout and is the default.
+# @timeout: Timeout in seconds after which a request will
+#           timeout. 0 means no timeout and is the default.
 #
 # Driver specific block device options for iscsi
 #
@@ -3674,29 +3674,29 @@
 ##
 # @BlockdevOptionsRbd:
 #
-# @pool:               Ceph pool name.
+# @pool: Ceph pool name.
 #
-# @image:              Image name in the Ceph pool.
+# @image: Image name in the Ceph pool.
 #
-# @conf:               path to Ceph configuration file.  Values
-#                      in the configuration file will be overridden by
-#                      options specified via QAPI.
+# @conf: path to Ceph configuration file.  Values
+#        in the configuration file will be overridden by
+#        options specified via QAPI.
 #
-# @snapshot:           Ceph snapshot name.
+# @snapshot: Ceph snapshot name.
 #
-# @user:               Ceph id name.
+# @user: Ceph id name.
 #
 # @auth-client-required: Acceptable authentication modes.
-#                      This maps to Ceph configuration option
-#                      "auth_client_required".  (Since 3.0)
+#                        This maps to Ceph configuration option
+#                        "auth_client_required".  (Since 3.0)
 #
-# @key-secret:         ID of a QCryptoSecret object providing a key
-#                      for cephx authentication.
-#                      This maps to Ceph configuration option
-#                      "key".  (Since 3.0)
+# @key-secret: ID of a QCryptoSecret object providing a key
+#              for cephx authentication.
+#              This maps to Ceph configuration option
+#              "key".  (Since 3.0)
 #
-# @server:             Monitor host address and port.  This maps
-#                      to the "mon_host" Ceph option.
+# @server: Monitor host address and port.  This maps
+#          to the "mon_host" Ceph option.
 #
 # Since: 2.9
 ##
@@ -3715,10 +3715,10 @@
 #
 # Driver specific block device options for sheepdog
 #
-# @vdi:         Virtual disk image name
-# @server:      The Sheepdog server to connect to
-# @snap-id:     Snapshot ID
-# @tag:         Snapshot tag name
+# @vdi: Virtual disk image name
+# @server: The Sheepdog server to connect to
+# @snap-id: Snapshot ID
+# @tag: Snapshot tag name
 #
 # Only one of @snap-id and @tag may be present.
 #
@@ -3768,7 +3768,7 @@
 #
 # An enumeration of NFS transport types
 #
-# @inet:        TCP transport
+# @inet: TCP transport
 #
 # Since: 2.9
 ##
@@ -3780,9 +3780,9 @@
 #
 # Captures the address of the socket
 #
-# @type:        transport type used for NFS (only TCP supported)
+# @type: transport type used for NFS (only TCP supported)
 #
-# @host:        host address for NFS server
+# @host: host address for NFS server
 #
 # Since: 2.9
 ##
@@ -3795,29 +3795,29 @@
 #
 # Driver specific block device option for NFS
 #
-# @server:                  host address
+# @server: host address
 #
-# @path:                    path of the image on the host
+# @path: path of the image on the host
 #
-# @user:                    UID value to use when talking to the
-#                           server (defaults to 65534 on Windows and getuid()
-#                           on unix)
+# @user: UID value to use when talking to the
+#        server (defaults to 65534 on Windows and getuid()
+#        on unix)
 #
-# @group:                   GID value to use when talking to the
-#                           server (defaults to 65534 on Windows and getgid()
-#                           in unix)
+# @group: GID value to use when talking to the
+#         server (defaults to 65534 on Windows and getgid()
+#         in unix)
 #
-# @tcp-syn-count:           number of SYNs during the session
-#                           establishment (defaults to libnfs default)
+# @tcp-syn-count: number of SYNs during the session
+#                 establishment (defaults to libnfs default)
 #
-# @readahead-size:          set the readahead size in bytes (defaults
-#                           to libnfs default)
+# @readahead-size: set the readahead size in bytes (defaults
+#                  to libnfs default)
 #
-# @page-cache-size:         set the pagecache size in bytes (defaults
-#                           to libnfs default)
+# @page-cache-size: set the pagecache size in bytes (defaults
+#                   to libnfs default)
 #
-# @debug:                   set the NFS debug level (max 2) (defaults
-#                           to libnfs default)
+# @debug: set the NFS debug level (max 2) (defaults
+#         to libnfs default)
 #
 # Since: 2.9
 ##
@@ -3837,22 +3837,22 @@
 # Driver specific block device options shared by all protocols supported by the
 # curl backend.
 #
-# @url:                     URL of the image file
+# @url: URL of the image file
 #
-# @readahead:               Size of the read-ahead cache; must be a multiple of
-#                           512 (defaults to 256 kB)
+# @readahead: Size of the read-ahead cache; must be a multiple of
+#             512 (defaults to 256 kB)
 #
-# @timeout:                 Timeout for connections, in seconds (defaults to 5)
+# @timeout: Timeout for connections, in seconds (defaults to 5)
 #
-# @username:                Username for authentication (defaults to none)
+# @username: Username for authentication (defaults to none)
 #
-# @password-secret:         ID of a QCryptoSecret object providing a password
-#                           for authentication (defaults to no password)
+# @password-secret: ID of a QCryptoSecret object providing a password
+#                   for authentication (defaults to no password)
 #
-# @proxy-username:          Username for proxy authentication (defaults to none)
+# @proxy-username: Username for proxy authentication (defaults to none)
 #
-# @proxy-password-secret:   ID of a QCryptoSecret object providing a password
-#                           for proxy authentication (defaults to no password)
+# @proxy-password-secret: ID of a QCryptoSecret object providing a password
+#                         for proxy authentication (defaults to no password)
 #
 # Since: 2.9
 ##
@@ -3871,9 +3871,9 @@
 # Driver specific block device options for HTTP connections over the curl
 # backend.  URLs must start with "http://".
 #
-# @cookie:      List of cookies to set; format is
-#               "name1=content1; name2=content2;" as explained by
-#               CURLOPT_COOKIE(3). Defaults to no cookies.
+# @cookie: List of cookies to set; format is
+#          "name1=content1; name2=content2;" as explained by
+#          CURLOPT_COOKIE(3). Defaults to no cookies.
 #
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie data in a
 #                 secure way. See @cookie for the format. (since 2.10)
@@ -3891,12 +3891,12 @@
 # Driver specific block device options for HTTPS connections over the curl
 # backend.  URLs must start with "https://".
 #
-# @cookie:      List of cookies to set; format is
-#               "name1=content1; name2=content2;" as explained by
-#               CURLOPT_COOKIE(3). Defaults to no cookies.
+# @cookie: List of cookies to set; format is
+#          "name1=content1; name2=content2;" as explained by
+#          CURLOPT_COOKIE(3). Defaults to no cookies.
 #
-# @sslverify:   Whether to verify the SSL certificate's validity (defaults to
-#               true)
+# @sslverify: Whether to verify the SSL certificate's validity (defaults to
+#             true)
 #
 # @cookie-secret: ID of a QCryptoSecret object providing the cookie data in a
 #                 secure way. See @cookie for the format. (since 2.10)
@@ -3927,8 +3927,8 @@
 # Driver specific block device options for FTPS connections over the curl
 # backend.  URLs must start with "ftps://".
 #
-# @sslverify:   Whether to verify the SSL certificate's validity (defaults to
-#               true)
+# @sslverify: Whether to verify the SSL certificate's validity (defaults to
+#             true)
 #
 # Since: 2.9
 ##
@@ -3941,11 +3941,11 @@
 #
 # Driver specific block device options for NBD.
 #
-# @server:      NBD server address
+# @server: NBD server address
 #
-# @export:      export name
+# @export: export name
 #
-# @tls-creds:   TLS credentials ID
+# @tls-creds: TLS credentials ID
 #
 # @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place of
 #                  traditional "base:allocation" block status (see
@@ -3973,8 +3973,8 @@
 #
 # Driver specific block device options for the raw driver.
 #
-# @offset:      position where the block device starts
-# @size:        the assumed size of the device
+# @offset: position where the block device starts
+# @size: the assumed size of the device
 #
 # Since: 2.9
 ##
@@ -3987,9 +3987,9 @@
 #
 # Driver specific block device options for VxHS
 #
-# @vdisk-id:    UUID of VxHS volume
-# @server:      vxhs server IP, port
-# @tls-creds:   TLS credentials ID
+# @vdisk-id: UUID of VxHS volume
+# @server: vxhs server IP, port
+# @tls-creds: TLS credentials ID
 #
 # Since: 2.10
 ##
@@ -4003,9 +4003,9 @@
 #
 # Driver specific block device options for the throttle driver
 #
-# @throttle-group:   the name of the throttle-group object to use. It
-#                    must already exist.
-# @file:             reference to or definition of the data source block device
+# @throttle-group: the name of the throttle-group object to use. It
+#                  must already exist.
+# @file: reference to or definition of the data source block device
 # Since: 2.11
 ##
 { 'struct': 'BlockdevOptionsThrottle',
@@ -4018,19 +4018,19 @@
 # Options for creating a block device.  Many options are available for all
 # block devices, independent of the block driver:
 #
-# @driver:        block driver name
-# @node-name:     the node name of the new node (Since 2.0).
-#                 This option is required on the top level of blockdev-add.
-#                 Valid node names start with an alphabetic character and may
-#                 contain only alphanumeric characters, '-', '.' and '_'. Their
-#                 maximum length is 31 characters.
-# @discard:       discard-related options (default: ignore)
-# @cache:         cache-related options
-# @read-only:     whether the block device should be read-only (default: false).
-#                 Note that some block drivers support only read-only access,
-#                 either generally or in certain configurations. In this case,
-#                 the default value does not work and the option must be
-#                 specified explicitly.
+# @driver: block driver name
+# @node-name: the node name of the new node (Since 2.0).
+#             This option is required on the top level of blockdev-add.
+#             Valid node names start with an alphabetic character and may
+#             contain only alphanumeric characters, '-', '.' and '_'. Their
+#             maximum length is 31 characters.
+# @discard: discard-related options (default: ignore)
+# @cache: cache-related options
+# @read-only: whether the block device should be read-only (default: false).
+#             Note that some block drivers support only read-only access,
+#             either generally or in certain configurations. In this case,
+#             the default value does not work and the option must be
+#             specified explicitly.
 # @auto-read-only: if true and @read-only is false, QEMU may automatically
 #                  decide not to open the image read-write as requested, but
 #                  fall back to read-only instead (and switch between the modes
@@ -4039,8 +4039,8 @@
 #                  (default: false, since 3.1)
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
-# @force-share:   force share all permission on added nodes.
-#                 Requires read-only=true. (Since 2.10)
+# @force-share: force share all permission on added nodes.
+#               Requires read-only=true. (Since 2.10)
 #
 # Remaining options are determined by the block driver.
 #
@@ -4106,8 +4106,8 @@
 #
 # Reference to a block device.
 #
-# @definition:      defines a new block device inline
-# @reference:       references the ID of an existing block device
+# @definition: defines a new block device inline
+# @reference: references the ID of an existing block device
 #
 # Since: 2.9
 ##
@@ -4120,11 +4120,11 @@
 #
 # Reference to a block device.
 #
-# @definition:      defines a new block device inline
-# @reference:       references the ID of an existing block device.
-#                   An empty string means that no block device should
-#                   be referenced.  Deprecated; use null instead.
-# @null:            No block device should be referenced (since 2.10)
+# @definition: defines a new block device inline
+# @reference: references the ID of an existing block device.
+#             An empty string means that no block device should
+#             be referenced.  Deprecated; use null instead.
+# @null: No block device should be referenced (since 2.10)
 #
 # Since: 2.9
 ##
@@ -4765,12 +4765,12 @@
 #
 # @device: Block device name (deprecated, use @id instead)
 #
-# @id:     The name or QOM path of the guest device (since: 2.8)
+# @id: The name or QOM path of the guest device (since: 2.8)
 #
-# @force:  if false (the default), an eject request will be sent to
-#          the guest if it has locked the tray (and the tray will not be opened
-#          immediately); if true, the tray will be opened regardless of whether
-#          it is locked
+# @force: if false (the default), an eject request will be sent to
+#         the guest if it has locked the tray (and the tray will not be opened
+#         immediately); if true, the tray will be opened regardless of whether
+#         it is locked
 #
 # Since: 2.5
 #
@@ -4803,9 +4803,9 @@
 #
 # If the tray was already closed before, this will be a no-op.
 #
-# @device:  Block device name (deprecated, use @id instead)
+# @device: Block device name (deprecated, use @id instead)
 #
-# @id:      The name or QOM path of the guest device (since: 2.8)
+# @id: The name or QOM path of the guest device (since: 2.8)
 #
 # Since: 2.5
 #
@@ -4837,7 +4837,7 @@
 #
 # If the tray is open and there is no medium inserted, this will be a no-op.
 #
-# @id:     The name or QOM path of the guest device
+# @id: The name or QOM path of the guest device
 #
 # Since: 2.12
 #
@@ -4877,7 +4877,7 @@
 # device's tray must currently be open (unless there is no attached guest
 # device) and there must be no medium inserted already.
 #
-# @id:        The name or QOM path of the guest device
+# @id: The name or QOM path of the guest device
 #
 # @node-name: name of a node in the block driver state graph
 #
@@ -4911,11 +4911,11 @@
 # Specifies the new read-only mode of a block device subject to the
 # @blockdev-change-medium command.
 #
-# @retain:      Retains the current read-only mode
+# @retain: Retains the current read-only mode
 #
-# @read-only:   Makes the device read-only
+# @read-only: Makes the device read-only
 #
-# @read-write:  Makes the device writable
+# @read-write: Makes the device writable
 #
 # Since: 2.3
 #
@@ -4932,18 +4932,18 @@
 # combines blockdev-open-tray, blockdev-remove-medium, blockdev-insert-medium
 # and blockdev-close-tray).
 #
-# @device:          Block device name (deprecated, use @id instead)
+# @device: Block device name (deprecated, use @id instead)
 #
-# @id:              The name or QOM path of the guest device
-#                   (since: 2.8)
+# @id: The name or QOM path of the guest device
+#      (since: 2.8)
 #
-# @filename:        filename of the new image to be loaded
+# @filename: filename of the new image to be loaded
 #
-# @format:          format to open the new image with (defaults to
-#                   the probed format)
+# @format: format to open the new image with (defaults to
+#          the probed format)
 #
-# @read-only-mode:  change the read-only mode of the device; defaults
-#                   to 'retain'
+# @read-only-mode: change the read-only mode of the device; defaults
+#                  to 'retain'
 #
 # Since: 2.5
 #
@@ -5028,8 +5028,8 @@
 #        the access size
 #
 # @fatal: if set, the image is marked corrupt and therefore unusable after this
-#        event and must be repaired (Since 2.2; before, every
-#        BLOCK_IMAGE_CORRUPTED event was fatal)
+#         event and must be repaired (Since 2.2; before, every
+#         BLOCK_IMAGE_CORRUPTED event was fatal)
 #
 # Note: If action is "stop", a STOP event will eventually follow the
 #       BLOCK_IO_ERROR event.
@@ -5077,10 +5077,10 @@
 #
 # @reason: human readable string describing the error cause.
 #          (This field is a debugging aid for humans, it should not
-#           be parsed by applications) (since: 2.2)
+#          be parsed by applications) (since: 2.2)
 #
 # Note: If action is "stop", a STOP event will eventually follow the
-# BLOCK_IO_ERROR event
+#       BLOCK_IO_ERROR event
 #
 # Since: 0.13.0
 #
@@ -5222,7 +5222,7 @@
 # @speed: rate limit, bytes per second
 #
 # Note: The "ready to complete" status is always reset by a @BLOCK_JOB_ERROR
-# event
+#       event
 #
 # Since: 1.3
 #
@@ -5356,15 +5356,15 @@
 # @node: the name of the node that will be added.
 #
 # Note: this command is experimental, and its API is not stable. It
-# does not support all kinds of operations, all kinds of children, nor
-# all block drivers.
+#       does not support all kinds of operations, all kinds of children, nor
+#       all block drivers.
 #
-# FIXME Removing children from a quorum node means introducing gaps in the
-# child indices. This cannot be represented in the 'children' list of
-# BlockdevOptionsQuorum, as returned by .bdrv_refresh_filename().
+#       FIXME Removing children from a quorum node means introducing gaps in the
+#       child indices. This cannot be represented in the 'children' list of
+#       BlockdevOptionsQuorum, as returned by .bdrv_refresh_filename().
 #
-# Warning: The data in a new quorum child MUST be consistent with that of
-# the rest of the array.
+#       Warning: The data in a new quorum child MUST be consistent with that of
+#       the rest of the array.
 #
 # Since: 2.7
 #
@@ -5411,7 +5411,7 @@
 #         is already attached
 #
 # Note: this command is experimental and intended for test cases that need
-# control over IOThreads only.
+#       control over IOThreads only.
 #
 # Since: 2.12
 #
diff --git a/qapi/block.json b/qapi/block.json
index 145c268bb64..905297bab2e 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -190,12 +190,12 @@
 #
 # Ejects a device from a removable drive.
 #
-# @device:  Block device name (deprecated, use @id instead)
+# @device: Block device name (deprecated, use @id instead)
 #
-# @id:      The name or QOM path of the guest device (since: 2.8)
+# @id: The name or QOM path of the guest device (since: 2.8)
 #
-# @force:   If true, eject regardless of whether the drive is locked.
-#           If not specified, the default value is false.
+# @force: If true, eject regardless of whether the drive is locked.
+#         If not specified, the default value is false.
 #
 # Returns:  Nothing on success
 #
@@ -251,7 +251,7 @@
 #        export name. (Since 2.12)
 #
 # @writable: Whether clients should be able to write to the device via the
-#     NBD connection (default false).
+#            NBD connection (default false).
 
 # @bitmap: Also export the dirty bitmap reachable from @device, so the
 #          NBD client can use NBD_OPT_SET_META_CONTEXT with
@@ -278,10 +278,10 @@
 # Potential additional modes to be added in the future:
 #
 # hide: Just hide export from new clients, leave existing connections as is.
-#       Remove export after all clients are disconnected.
+# Remove export after all clients are disconnected.
 #
 # soft: Hide export from new clients, answer with ESHUTDOWN for all further
-#       requests from existing clients.
+# requests from existing clients.
 #
 # Since: 2.12
 ##
diff --git a/qapi/char.json b/qapi/char.json
index a6e81ac7bc6..8a9f1e75097 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -262,11 +262,11 @@
 # @tn3270: enable tn3270 protocol on server
 #          sockets (default: false) (Since: 2.10)
 # @websocket: enable websocket protocol on server
-#           sockets (default: false) (Since: 3.1)
+#             sockets (default: false) (Since: 3.1)
 # @reconnect: For a client socket, if a socket is disconnected,
-#          then attempt a reconnect after the given number of seconds.
-#          Setting this to zero disables this function. (default: 0)
-#          (Since: 2.2)
+#             then attempt a reconnect after the given number of seconds.
+#             Setting this to zero disables this function. (default: 0)
+#             (Since: 2.2)
 #
 # Since: 1.4
 ##
diff --git a/qapi/dump.json b/qapi/dump.json
index 2b35409a7b2..a1eed7b15c5 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -38,8 +38,8 @@
 #          using gdb to process the core file.
 #
 #          IMPORTANT: this option can make QEMU allocate several gigabytes
-#                     of RAM. This can happen for a large guest, or a
-#                     malicious guest pretending to be large.
+#          of RAM. This can happen for a large guest, or a
+#          malicious guest pretending to be large.
 #
 #          Also, paging=true has the following limitations:
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 031a954fa9a..8756e7920e1 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -34,15 +34,15 @@
 # alternate that includes the original type alongside something else.
 #
 # Returns: array of @SchemaInfo, where each element describes an
-# entity in the ABI: command, event, type, ...
+#          entity in the ABI: command, event, type, ...
 #
-# The order of the various SchemaInfo is unspecified; however, all
-# names are guaranteed to be unique (no name will be duplicated with
-# different meta-types).
+#          The order of the various SchemaInfo is unspecified; however, all
+#          names are guaranteed to be unique (no name will be duplicated with
+#          different meta-types).
 #
 # Note: the QAPI schema is also used to help define *internal*
-# interfaces, by defining QAPI types.  These are not part of the QMP
-# wire ABI, and therefore not returned by this command.
+#       interfaces, by defining QAPI types.  These are not part of the QMP
+#       wire ABI, and therefore not returned by this command.
 #
 # Since: 2.5
 ##
diff --git a/qapi/job.json b/qapi/job.json
index a121b615fb0..5e658281f5c 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -214,28 +214,28 @@
 #
 # Information about a job.
 #
-# @id:                  The job identifier
+# @id: The job identifier
 #
-# @type:                The kind of job that is being performed
+# @type: The kind of job that is being performed
 #
-# @status:              Current job state/status
+# @status: Current job state/status
 #
-# @current-progress:    Progress made until now. The unit is arbitrary and the
-#                       value can only meaningfully be used for the ratio of
-#                       @current-progress to @total-progress. The value is
-#                       monotonically increasing.
+# @current-progress: Progress made until now. The unit is arbitrary and the
+#                    value can only meaningfully be used for the ratio of
+#                    @current-progress to @total-progress. The value is
+#                    monotonically increasing.
 #
-# @total-progress:      Estimated @current-progress value at the completion of
-#                       the job. This value can arbitrarily change while the
-#                       job is running, in both directions.
+# @total-progress: Estimated @current-progress value at the completion of
+#                  the job. This value can arbitrarily change while the
+#                  job is running, in both directions.
 #
-# @error:               If this field is present, the job failed; if it is
-#                       still missing in the CONCLUDED state, this indicates
-#                       successful completion.
+# @error: If this field is present, the job failed; if it is
+#         still missing in the CONCLUDED state, this indicates
+#         successful completion.
 #
-#                       The value is a human-readable error message to describe
-#                       the reason for the job failure. It should not be parsed
-#                       by applications.
+#         The value is a human-readable error message to describe
+#         the reason for the job failure. It should not be parsed
+#         by applications.
 #
 # Since: 3.0
 ##
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index 04623224720..f2c82949d80 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -40,13 +40,13 @@
 #        model details.
 #
 # Note: When a non-migration-safe CPU model is expanded in static mode, some
-# features enabled by the CPU model may be omitted, because they can't be
-# implemented by a static CPU model definition (e.g. cache info passthrough and
-# PMU passthrough in x86). If you need an accurate representation of the
-# features enabled by a non-migration-safe CPU model, use @full. If you need a
-# static representation that will keep ABI compatibility even when changing QEMU
-# version or machine-type, use @static (but keep in mind that some features may
-# be omitted).
+#       features enabled by the CPU model may be omitted, because they can't be
+#       implemented by a static CPU model definition (e.g. cache info passthrough and
+#       PMU passthrough in x86). If you need an accurate representation of the
+#       features enabled by a non-migration-safe CPU model, use @full. If you need a
+#       static representation that will keep ABI compatibility even when changing QEMU
+#       version or machine-type, use @static (but keep in mind that some features may
+#       be omitted).
 #
 # Since: 2.8.0
 ##
@@ -148,7 +148,7 @@
 #          with wrong types.
 #
 # Note: this command isn't specific to s390x, but is only implemented
-# on this architecture currently.
+#       on this architecture currently.
 #
 # Since: 2.8.0
 ##
@@ -191,7 +191,7 @@
 #          with wrong types.
 #
 # Note: this command isn't specific to s390x, but is only implemented
-# on this architecture currently.
+#       on this architecture currently.
 #
 # Since: 2.8.0
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index b3d30bc8162..704b2b0fe31 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -680,7 +680,7 @@
 # 5.2.27.5: Table 5-147: Field "Cache Attributes" of ACPI 6.3 spec.
 #
 # @none: None (no memory side cache in this proximity domain,
-#              or cache write policy unknown)
+#        or cache write policy unknown)
 #
 # @write-back: Write Back (WB)
 #
@@ -706,7 +706,7 @@
 # @level: the cache level described in this structure.
 #
 # @associativity: the cache associativity,
-#         none/direct-mapped/complex(complex cache indexing).
+#                 none/direct-mapped/complex(complex cache indexing).
 #
 # @policy: the write policy, none/write-back/write-through.
 #
@@ -823,10 +823,10 @@
 # @core-id: core number within die the CPU belongs to# @thread-id: thread number within core the CPU belongs to
 #
 # Note: currently there are 5 properties that could be present
-# but management should be prepared to pass through other
-# properties with device_add command to allow for future
-# interface extension. This also requires the filed names to be kept in
-# sync with the properties passed to -device/device_add.
+#       but management should be prepared to pass through other
+#       properties with device_add command to allow for future
+#       interface extension. This also requires the filed names to be kept in
+#       sync with the properties passed to -device/device_add.
 #
 # Since: 2.7
 ##
diff --git a/qapi/migration.json b/qapi/migration.json
index b7348d0c8bf..aa160e9e42d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -28,22 +28,22 @@
 # @normal-bytes: number of normal bytes sent (since 1.2)
 #
 # @dirty-pages-rate: number of pages dirtied by second by the
-#        guest (since 1.3)
+#                    guest (since 1.3)
 #
 # @mbps: throughput in megabits/sec. (since 1.6)
 #
 # @dirty-sync-count: number of times that dirty ram was synchronized (since 2.1)
 #
 # @postcopy-requests: The number of page requests received from the destination
-#        (since 2.7)
+#                     (since 2.7)
 #
 # @page-size: The number of bytes per page for the various page-based
-#        statistics (since 2.10)
+#             statistics (since 2.10)
 #
 # @multifd-bytes: The number of bytes sent through multifd (since 3.0)
 #
 # @pages-per-second: the number of memory pages transferred per second
-#        (Since 4.0)
+#                    (Since 4.0)
 #
 # Since: 0.14.0
 ##
@@ -131,7 +131,7 @@
 # @pre-switchover: Paused before device serialisation. (since 2.11)
 #
 # @device: During device serialisation when pause-before-switchover is enabled
-#        (since 2.11)
+#          (since 2.11)
 #
 # @wait-unplug: wait for device unplug request by guest OS to be completed.
 #               (since 4.2)
@@ -167,41 +167,41 @@
 #                status is 'active' or 'completed' (since 1.2)
 #
 # @total-time: total amount of milliseconds since migration started.
-#        If migration has ended, it returns the total migration
-#        time. (since 1.2)
+#              If migration has ended, it returns the total migration
+#              time. (since 1.2)
 #
 # @downtime: only present when migration finishes correctly
-#        total downtime in milliseconds for the guest.
-#        (since 1.3)
+#            total downtime in milliseconds for the guest.
+#            (since 1.3)
 #
 # @expected-downtime: only present while migration is active
-#        expected downtime in milliseconds for the guest in last walk
-#        of the dirty bitmap. (since 1.3)
+#                     expected downtime in milliseconds for the guest in last walk
+#                     of the dirty bitmap. (since 1.3)
 #
 # @setup-time: amount of setup time in milliseconds _before_ the
-#        iterations begin but _after_ the QMP command is issued. This is designed
-#        to provide an accounting of any activities (such as RDMA pinning) which
-#        may be expensive, but do not actually occur during the iterative
-#        migration rounds themselves. (since 1.6)
+#              iterations begin but _after_ the QMP command is issued. This is designed
+#              to provide an accounting of any activities (such as RDMA pinning) which
+#              may be expensive, but do not actually occur during the iterative
+#              migration rounds themselves. (since 1.6)
 #
 # @cpu-throttle-percentage: percentage of time guest cpus are being
-#        throttled during auto-converge. This is only present when auto-converge
-#        has started throttling guest cpus. (Since 2.7)
+#                           throttled during auto-converge. This is only present when auto-converge
+#                           has started throttling guest cpus. (Since 2.7)
 #
 # @error-desc: the human readable error description string, when
 #              @status is 'failed'. Clients should not attempt to parse the
 #              error strings. (Since 2.7)
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during postcopy
-#           live migration. This is only present when the postcopy-blocktime
-#           migration capability is enabled. (Since 3.0)
+#                      live migration. This is only present when the postcopy-blocktime
+#                      migration capability is enabled. (Since 3.0)
 #
 # @postcopy-vcpu-blocktime: list of the postcopy blocktime per vCPU.  This is
-#           only present when the postcopy-blocktime migration capability
-#           is enabled. (Since 3.0)
+#                           only present when the postcopy-blocktime migration capability
+#                           is enabled. (Since 3.0)
 #
 # @compression: migration compression statistics, only returned if compression
-#           feature is on and status is 'active' or 'completed' (Since 3.1)
+#               feature is on and status is 'active' or 'completed' (Since 3.1)
 #
 # @socket-address: Only used for tcp, to know what the real port is (Since 4.0)
 #
@@ -355,54 +355,54 @@
 #          loads, by sending compressed difference of the pages
 #
 # @rdma-pin-all: Controls whether or not the entire VM memory footprint is
-#          mlock()'d on demand or all at once. Refer to docs/rdma.txt for usage.
-#          Disabled by default. (since 2.0)
+#                mlock()'d on demand or all at once. Refer to docs/rdma.txt for usage.
+#                Disabled by default. (since 2.0)
 #
 # @zero-blocks: During storage migration encode blocks of zeroes efficiently. This
-#          essentially saves 1MB of zeroes per block on the wire. Enabling requires
-#          source and target VM to support this feature. To enable it is sufficient
-#          to enable the capability on the source VM. The feature is disabled by
-#          default. (since 1.6)
+#               essentially saves 1MB of zeroes per block on the wire. Enabling requires
+#               source and target VM to support this feature. To enable it is sufficient
+#               to enable the capability on the source VM. The feature is disabled by
+#               default. (since 1.6)
 #
 # @compress: Use multiple compression threads to accelerate live migration.
-#          This feature can help to reduce the migration traffic, by sending
-#          compressed pages. Please note that if compress and xbzrle are both
-#          on, compress only takes effect in the ram bulk stage, after that,
-#          it will be disabled and only xbzrle takes effect, this can help to
-#          minimize migration traffic. The feature is disabled by default.
-#          (since 2.4 )
+#            This feature can help to reduce the migration traffic, by sending
+#            compressed pages. Please note that if compress and xbzrle are both
+#            on, compress only takes effect in the ram bulk stage, after that,
+#            it will be disabled and only xbzrle takes effect, this can help to
+#            minimize migration traffic. The feature is disabled by default.
+#            (since 2.4 )
 #
 # @events: generate events for each migration state change
 #          (since 2.4 )
 #
 # @auto-converge: If enabled, QEMU will automatically throttle down the guest
-#          to speed up convergence of RAM migration. (since 1.6)
+#                 to speed up convergence of RAM migration. (since 1.6)
 #
 # @postcopy-ram: Start executing on the migration target before all of RAM has
-#          been migrated, pulling the remaining pages along as needed. The
-#          capacity must have the same setting on both source and target
-#          or migration will not even start. NOTE: If the migration fails during
-#          postcopy the VM will fail.  (since 2.6)
+#                been migrated, pulling the remaining pages along as needed. The
+#                capacity must have the same setting on both source and target
+#                or migration will not even start. NOTE: If the migration fails during
+#                postcopy the VM will fail.  (since 2.6)
 #
 # @x-colo: If enabled, migration will never end, and the state of the VM on the
-#        primary side will be migrated continuously to the VM on secondary
-#        side, this process is called COarse-Grain LOck Stepping (COLO) for
-#        Non-stop Service. (since 2.8)
+#          primary side will be migrated continuously to the VM on secondary
+#          side, this process is called COarse-Grain LOck Stepping (COLO) for
+#          Non-stop Service. (since 2.8)
 #
 # @release-ram: if enabled, qemu will free the migrated ram pages on the source
-#        during postcopy-ram migration. (since 2.9)
+#               during postcopy-ram migration. (since 2.9)
 #
 # @block: If enabled, QEMU will also migrate the contents of all block
-#          devices.  Default is disabled.  A possible alternative uses
-#          mirror jobs to a builtin NBD server on the destination, which
-#          offers more flexibility.
-#          (Since 2.10)
+#         devices.  Default is disabled.  A possible alternative uses
+#         mirror jobs to a builtin NBD server on the destination, which
+#         offers more flexibility.
+#         (Since 2.10)
 #
 # @return-path: If enabled, migration will use the return path even
 #               for precopy. (since 2.10)
 #
 # @pause-before-switchover: Pause outgoing migration before serialising device
-#          state and before disabling block IO (since 2.11)
+#                           state and before disabling block IO (since 2.11)
 #
 # @multifd: Use more than one fd for migration (since 4.0)
 #
@@ -410,11 +410,11 @@
 #                 (since 2.12)
 #
 # @postcopy-blocktime: Calculate downtime for postcopy live migration
-#                     (since 3.0)
+#                      (since 3.0)
 #
 # @late-block-activate: If enabled, the destination will not activate block
-#           devices (and thus take locks) immediately at the end of migration.
-#           (since 3.0)
+#                       devices (and thus take locks) immediately at the end of migration.
+#                       (since 3.0)
 #
 # @x-ignore-shared: If enabled, QEMU will not migrate shared memory (since 4.0)
 #
@@ -494,24 +494,24 @@
 # Migration parameters enumeration
 #
 # @announce-initial: Initial delay (in milliseconds) before sending the first
-#          announce (Since 4.0)
+#                    announce (Since 4.0)
 #
 # @announce-max: Maximum delay (in milliseconds) between packets in the
-#          announcement (Since 4.0)
+#                announcement (Since 4.0)
 #
 # @announce-rounds: Number of self-announce packets sent after migration
-#          (Since 4.0)
+#                   (Since 4.0)
 #
 # @announce-step: Increase in delay (in milliseconds) between subsequent
-#          packets in the announcement (Since 4.0)
+#                 packets in the announcement (Since 4.0)
 #
 # @compress-level: Set the compression level to be used in live migration,
-#          the compression level is an integer between 0 and 9, where 0 means
-#          no compression, 1 means the best compression speed, and 9 means best
-#          compression ratio which will consume more CPU.
+#                  the compression level is an integer between 0 and 9, where 0 means
+#                  no compression, 1 means the best compression speed, and 9 means best
+#                  compression ratio which will consume more CPU.
 #
 # @compress-threads: Set compression thread count to be used in live migration,
-#          the compression thread count is an integer between 1 and 255.
+#                    the compression thread count is an integer between 1 and 255.
 #
 # @compress-wait-thread: Controls behavior when all compression threads are
 #                        currently busy. If true (default), wait for a free
@@ -519,10 +519,10 @@
 #                        send the page uncompressed. (Since 3.1)
 #
 # @decompress-threads: Set decompression thread count to be used in live
-#          migration, the decompression thread count is an integer between 1
-#          and 255. Usually, decompression is at least 4 times as fast as
-#          compression, so set the decompress-threads to the number about 1/4
-#          of compress-threads is adequate.
+#                      migration, the decompression thread count is an integer between 1
+#                      and 255. Usually, decompression is at least 4 times as fast as
+#                      compression, so set the decompress-threads to the number about 1/4
+#                      of compress-threads is adequate.
 #
 # @cpu-throttle-initial: Initial percentage of time guest cpus are throttled
 #                        when migration auto-converge is activated. The
@@ -560,14 +560,14 @@
 #                  downtime in milliseconds (Since 2.8)
 #
 # @x-checkpoint-delay: The delay time (in ms) between two COLO checkpoints in
-#          periodic mode. (Since 2.8)
+#                      periodic mode. (Since 2.8)
 #
 # @block-incremental: Affects how much storage is migrated when the
-# 	block migration capability is enabled.  When false, the entire
-# 	storage backing chain is migrated into a flattened image at
-# 	the destination; when true, only the active qcow2 layer is
-# 	migrated and the destination must already have access to the
-# 	same backing chain as was used on the source.  (since 2.10)
+#                     block migration capability is enabled.  When false, the entire
+#                     storage backing chain is migrated into a flattened image at
+#                     the destination; when true, only the active qcow2 layer is
+#                     migrated and the destination must already have access to the
+#                     same backing chain as was used on the source.  (since 2.10)
 #
 # @multifd-channels: Number of channels used to migrate data in
 #                    parallel. This is the same number that the
@@ -580,8 +580,8 @@
 #                     (Since 2.11)
 #
 # @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
-#                     Defaults to 0 (unlimited).  In bytes per second.
-#                     (Since 3.0)
+#                          Defaults to 0 (unlimited).  In bytes per second.
+#                          (Since 3.0)
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99. (Since 3.1)
@@ -604,16 +604,16 @@
 # @MigrateSetParameters:
 #
 # @announce-initial: Initial delay (in milliseconds) before sending the first
-#          announce (Since 4.0)
+#                    announce (Since 4.0)
 #
 # @announce-max: Maximum delay (in milliseconds) between packets in the
-#          announcement (Since 4.0)
+#                announcement (Since 4.0)
 #
 # @announce-rounds: Number of self-announce packets sent after migration
-#          (Since 4.0)
+#                   (Since 4.0)
 #
 # @announce-step: Increase in delay (in milliseconds) between subsequent
-#          packets in the announcement (Since 4.0)
+#                 packets in the announcement (Since 4.0)
 #
 # @compress-level: compression level
 #
@@ -665,11 +665,11 @@
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
 # @block-incremental: Affects how much storage is migrated when the
-# 	block migration capability is enabled.  When false, the entire
-# 	storage backing chain is migrated into a flattened image at
-# 	the destination; when true, only the active qcow2 layer is
-# 	migrated and the destination must already have access to the
-# 	same backing chain as was used on the source.  (since 2.10)
+#                     block migration capability is enabled.  When false, the entire
+#                     storage backing chain is migrated into a flattened image at
+#                     the destination; when true, only the active qcow2 layer is
+#                     migrated and the destination must already have access to the
+#                     same backing chain as was used on the source.  (since 2.10)
 #
 # @multifd-channels: Number of channels used to migrate data in
 #                    parallel. This is the same number that the
@@ -682,8 +682,8 @@
 #                     (Since 2.11)
 #
 # @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
-#                     Defaults to 0 (unlimited).  In bytes per second.
-#                     (Since 3.0)
+#                          Defaults to 0 (unlimited).  In bytes per second.
+#                          (Since 3.0)
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    The default value is 99. (Since 3.1)
@@ -737,16 +737,16 @@
 # The optional members aren't actually optional.
 #
 # @announce-initial: Initial delay (in milliseconds) before sending the
-#          first announce (Since 4.0)
+#                    first announce (Since 4.0)
 #
 # @announce-max: Maximum delay (in milliseconds) between packets in the
-#          announcement (Since 4.0)
+#                announcement (Since 4.0)
 #
 # @announce-rounds: Number of self-announce packets sent after migration
-#          (Since 4.0)
+#                   (Since 4.0)
 #
 # @announce-step: Increase in delay (in milliseconds) between subsequent
-#          packets in the announcement (Since 4.0)
+#                 packets in the announcement (Since 4.0)
 #
 # @compress-level: compression level
 #
@@ -799,11 +799,11 @@
 # @x-checkpoint-delay: the delay time between two COLO checkpoints. (Since 2.8)
 #
 # @block-incremental: Affects how much storage is migrated when the
-# 	block migration capability is enabled.  When false, the entire
-# 	storage backing chain is migrated into a flattened image at
-# 	the destination; when true, only the active qcow2 layer is
-# 	migrated and the destination must already have access to the
-# 	same backing chain as was used on the source.  (since 2.10)
+#                     block migration capability is enabled.  When false, the entire
+#                     storage backing chain is migrated into a flattened image at
+#                     the destination; when true, only the active qcow2 layer is
+#                     migrated and the destination must already have access to the
+#                     same backing chain as was used on the source.  (since 2.10)
 #
 # @multifd-channels: Number of channels used to migrate data in
 #                    parallel. This is the same number that the
@@ -816,12 +816,12 @@
 #                     (Since 2.11)
 #
 # @max-postcopy-bandwidth: Background transfer bandwidth during postcopy.
-#                     Defaults to 0 (unlimited).  In bytes per second.
-#                     (Since 3.0)
+#                          Defaults to 0 (unlimited).  In bytes per second.
+#                          (Since 3.0)
 #
 # @max-cpu-throttle: maximum cpu throttle percentage.
 #                    Defaults to 99.
-#                     (Since 3.1)
+#                    (Since 3.1)
 #
 # Since: 2.4
 ##
@@ -1047,8 +1047,8 @@
 # The reason for a COLO exit.
 #
 # @none: failover has never happened. This state does not occur
-# in the COLO_EXIT event, and is only visible in the result of
-# query-colo-status.
+#        in the COLO_EXIT event, and is only visible in the result of
+#        query-colo-status.
 #
 # @request: COLO exit is due to an external request.
 #
@@ -1281,11 +1281,11 @@
 # of the VM are not saved by this command.
 #
 # @filename: the file to save the state of the devices to as binary
-# data. See xen-save-devices-state.txt for a description of the binary
-# format.
+#            data. See xen-save-devices-state.txt for a description of the binary
+#            format.
 #
 # @live: Optional argument to ask QEMU to treat this command as part of a live
-# migration. Default to true. (since 2.11)
+#        migration. Default to true. (since 2.11)
 #
 # Returns: Nothing on success
 #
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index a00fd821ebc..dee3b459301 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -230,14 +230,14 @@
 # QEMU/KVM software version, but also decided by the hardware that
 # the program is running upon.
 #
-# @version:  version of GIC to be described. Currently, only 2 and 3
-#            are supported.
+# @version: version of GIC to be described. Currently, only 2 and 3
+#           are supported.
 #
 # @emulated: whether current QEMU/hardware supports emulated GIC
 #            device in user space.
 #
-# @kernel:   whether current QEMU/hardware supports hardware
-#            accelerated GIC device in kernel.
+# @kernel: whether current QEMU/hardware supports hardware
+#          accelerated GIC device in kernel.
 #
 # Since: 2.6
 ##
diff --git a/qapi/misc.json b/qapi/misc.json
index 33b94e35896..626a342b008 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -14,11 +14,11 @@
 #
 # Arguments:
 #
-# @enable:   An optional list of QMPCapability values to enable.  The
-#            client must not enable any capability that is not
-#            mentioned in the QMP greeting message.  If the field is not
-#            provided, it means no QMP capabilities will be enabled.
-#            (since 2.12)
+# @enable: An optional list of QMPCapability values to enable.  The
+#          client must not enable any capability that is not
+#          mentioned in the QMP greeting message.  If the field is not
+#          provided, it means no QMP capabilities will be enabled.
+#          (since 2.12)
 #
 # Example:
 #
@@ -27,11 +27,11 @@
 # <- { "return": {} }
 #
 # Notes: This command is valid exactly when first connecting: it must be
-# issued before any other command will be accepted, and will fail once the
-# monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)
+#        issued before any other command will be accepted, and will fail once the
+#        monitor is accepting other commands. (see qemu docs/interop/qmp-spec.txt)
 #
-# The QMP client needs to explicitly enable QMP capabilities, otherwise
-# all the QMP capabilities will be turned off by default.
+#        The QMP client needs to explicitly enable QMP capabilities, otherwise
+#        all the QMP capabilities will be turned off by default.
 #
 # Since: 0.13
 #
@@ -46,8 +46,8 @@
 # Enumeration of capabilities to be advertised during initial client
 # connection, used for agreeing on particular QMP extension behaviors.
 #
-# @oob:   QMP ability to support out-of-band requests.
-#         (Please refer to qmp-spec.txt for more information on OOB)
+# @oob: QMP ability to support out-of-band requests.
+#       (Please refer to qmp-spec.txt for more information on OOB)
 #
 # Since: 2.12
 #
@@ -60,11 +60,11 @@
 #
 # A three-part version number.
 #
-# @major:  The major version number.
+# @major: The major version number.
 #
-# @minor:  The minor version number.
+# @minor: The minor version number.
 #
-# @micro:  The micro version number.
+# @micro: The micro version number.
 #
 # Since: 2.4
 ##
@@ -77,16 +77,16 @@
 #
 # A description of QEMU's version.
 #
-# @qemu:        The version of QEMU.  By current convention, a micro
-#               version of 50 signifies a development branch.  A micro version
-#               greater than or equal to 90 signifies a release candidate for
-#               the next minor version.  A micro version of less than 50
-#               signifies a stable release.
+# @qemu: The version of QEMU.  By current convention, a micro
+#        version of 50 signifies a development branch.  A micro version
+#        greater than or equal to 90 signifies a release candidate for
+#        the next minor version.  A micro version of less than 50
+#        signifies a stable release.
 #
-# @package:     QEMU will always set this field to an empty string.  Downstream
-#               versions of QEMU should set this to a non-empty string.  The
-#               exact format depends on the downstream however it highly
-#               recommended that a unique name is used.
+# @package: QEMU will always set this field to an empty string.  Downstream
+#           versions of QEMU should set this to a non-empty string.  The
+#           exact format depends on the downstream however it highly
+#           recommended that a unique name is used.
 #
 # Since: 0.14.0
 ##
@@ -98,7 +98,7 @@
 #
 # Returns the current version of QEMU.
 #
-# Returns:  A @VersionInfo object describing the current version of QEMU.
+# Returns: A @VersionInfo object describing the current version of QEMU.
 #
 # Since: 0.14.0
 #
@@ -321,7 +321,7 @@
 # Since: 1.2.0
 #
 # Note: This command is deprecated, because its output doesn't reflect
-# compile-time configuration.  Use query-qmp-schema instead.
+#       compile-time configuration.  Use query-qmp-schema instead.
 #
 # Example:
 #
@@ -375,8 +375,8 @@
 # Returns a list of information about each iothread.
 #
 # Note: this list excludes the QEMU main loop thread, which is not declared
-# using the -object iothread command-line option.  It is always the main thread
-# of the process.
+#       using the -object iothread command-line option.  It is always the main thread
+#       of the process.
 #
 # Returns: a list of @IOThreadInfo for each iothread
 #
@@ -624,9 +624,9 @@
 # Return information about the PCI bus topology of the guest.
 #
 # Returns: a list of @PciInfo for each PCI bus. Each bus is
-# represented by a json-object, which has a key with a json-array of
-# all PCI devices attached to it. Each device is represented by a
-# json-object.
+#          represented by a json-object, which has a key with a json-array of
+#          all PCI devices attached to it. Each device is represented by a
+#          json-object.
 #
 # Since: 0.14.0
 #
@@ -788,10 +788,10 @@
 #
 # Since:  0.14.0
 #
-# Notes:  This function will succeed even if the guest is already in the stopped
-#         state.  In "inmigrate" state, it will ensure that the guest
-#         remains paused once migration finishes, as if the -S option was
-#         passed on the command line.
+# Notes: This function will succeed even if the guest is already in the stopped
+#        state.  In "inmigrate" state, it will ensure that the guest
+#        remains paused once migration finishes, as if the -S option was
+#        passed on the command line.
 #
 # Example:
 #
@@ -847,7 +847,7 @@
 # @filename: the file to save the memory to as binary data
 #
 # @cpu-index: the index of the virtual CPU to use for translating the
-#                       virtual address (defaults to CPU 0)
+#             virtual address (defaults to CPU 0)
 #
 # Returns: Nothing on success
 #
@@ -905,11 +905,11 @@
 #
 # Returns:  If successful, nothing
 #
-# Notes:  This command will succeed if the guest is currently running.  It
-#         will also succeed if the guest is in the "inmigrate" state; in
-#         this case, the effect of the command is to make sure the guest
-#         starts once migration finishes, removing the effect of the -S
-#         command line option if it was passed.
+# Notes: This command will succeed if the guest is currently running.  It
+#        will also succeed if the guest is in the "inmigrate" state; in
+#        this case, the effect of the command is to make sure the guest
+#        starts once migration finishes, removing the effect of the -S
+#        command line option if it was passed.
 #
 # Example:
 #
@@ -955,7 +955,7 @@
 # Returns:  nothing.
 #
 # Note: prior to 4.0, this command does nothing in case the guest
-# isn't suspended.
+#       isn't suspended.
 #
 # Example:
 #
@@ -1069,18 +1069,18 @@
 #          change password command.   Otherwise, this specifies a new server URI
 #          address to listen to for VNC connections.
 #
-# @arg:    If @device is a block device, then this is an optional format to open
-#          the device with.
-#          If @device is 'vnc' and @target is 'password', this is the new VNC
-#          password to set.  See change-vnc-password for additional notes.
+# @arg: If @device is a block device, then this is an optional format to open
+#       the device with.
+#       If @device is 'vnc' and @target is 'password', this is the new VNC
+#       password to set.  See change-vnc-password for additional notes.
 #
 # Returns: Nothing on success.
 #          If @device is not a valid block device, DeviceNotFound
 #
-# Notes:  This interface is deprecated, and it is strongly recommended that you
-#         avoid using it.  For changing block devices, use
-#         blockdev-change-medium; for changing VNC parameters, use
-#         change-vnc-password.
+# Notes: This interface is deprecated, and it is strongly recommended that you
+#        avoid using it.  For changing block devices, use
+#        blockdev-change-medium; for changing VNC parameters, use
+#        change-vnc-password.
 #
 # Since: 0.14.0
 #
@@ -1719,8 +1719,8 @@
 # of the VM are not loaded by this command.
 #
 # @filename: the file to load the state of the devices from as binary
-# data. See xen-save-devices-state.txt for a description of the binary
-# format.
+#            data. See xen-save-devices-state.txt for a description of the binary
+#            format.
 #
 # Since: 2.7
 #
diff --git a/qapi/net.json b/qapi/net.json
index 335295be506..109eff71cd4 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -47,9 +47,9 @@
 # Additional arguments depend on the type.
 #
 # TODO: This command effectively bypasses QAPI completely due to its
-# "additional arguments" business.  It shouldn't have been added to
-# the schema in this form.  It should be qapified properly, or
-# replaced by a properly qapified command.
+#       "additional arguments" business.  It shouldn't have been added to
+#       the schema in this form.  It should be qapified properly, or
+#       replaced by a properly qapified command.
 #
 # Since: 0.14.0
 #
@@ -213,7 +213,7 @@
 # @fd: file descriptor of an already opened tap
 #
 # @fds: multiple file descriptors of already opened multiqueue capable
-# tap
+#       tap
 #
 # @script: script to initialize the interface
 #
@@ -232,14 +232,14 @@
 # @vhostfd: file descriptor of an already opened vhost net device
 #
 # @vhostfds: file descriptors of multiple already opened vhost net
-# devices
+#            devices
 #
 # @vhostforce: vhost on for non-MSIX virtio guests
 #
 # @queues: number of queues to be created for multiqueue capable tap
 #
 # @poll-us: maximum number of microseconds that could
-# be spent on busy polling for tap (since 2.7)
+#           be spent on busy polling for tap (since 2.7)
 #
 # Since: 1.2
 ##
@@ -691,7 +691,7 @@
 # Parameters for self-announce timers
 #
 # @initial: Initial delay (in ms) before sending the first GARP/RARP
-#       announcement
+#           announcement
 #
 # @max: Maximum delay (in ms) between GARP/RARP announcement packets
 #
@@ -700,11 +700,11 @@
 # @step: Delay increase (in ms) after each self-announcement attempt
 #
 # @interfaces: An optional list of interface names, which restricts the
-#        announcement to the listed interfaces. (Since 4.1)
+#              announcement to the listed interfaces. (Since 4.1)
 #
 # @id: A name to be used to identify an instance of announce-timers
-#        and to allow it to modified later.  Not for use as
-#        part of the migration parameters. (Since 4.1)
+#      and to allow it to modified later.  Not for use as
+#      part of the migration parameters. (Since 4.1)
 #
 # Since: 4.0
 ##
diff --git a/qapi/qdev.json b/qapi/qdev.json
index c6d05032f4a..f4ed9735c43 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -19,8 +19,8 @@
 # Returns: a list of ObjectPropertyInfo describing a devices properties
 #
 # Note: objects can create properties at runtime, for example to describe
-# links between different devices and/or objects. These properties
-# are not included in the output of this command.
+#       links between different devices and/or objects. These properties
+#       are not included in the output of this command.
 #
 # Since: 1.2
 ##
@@ -58,9 +58,9 @@
 # <- { "return": {} }
 #
 # TODO: This command effectively bypasses QAPI completely due to its
-# "additional arguments" business.  It shouldn't have been added to
-# the schema in this form.  It should be qapified properly, or
-# replaced by a properly qapified command.
+#       "additional arguments" business.  It shouldn't have been added to
+#       the schema in this form.  It should be qapified properly, or
+#       replaced by a properly qapified command.
 #
 # Since: 0.13
 ##
diff --git a/qapi/qom.json b/qapi/qom.json
index 1e3c2ad5556..ecc60c4401c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -189,8 +189,8 @@
 # @typename: the type name of an object
 #
 # Note: objects can create properties at runtime, for example to describe
-# links between different devices and/or objects. These properties
-# are not included in the output of this command.
+#       links between different devices and/or objects. These properties
+#       are not included in the output of this command.
 #
 # Returns: a list of ObjectPropertyInfo describing object properties
 #
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 3587661161d..52597db491a 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -140,7 +140,7 @@
 # @ip-dst: IP header destination address
 #
 # Note: optional members may or may not appear in the flow key
-# depending if they're relevant to the flow key.
+#       depending if they're relevant to the flow key.
 #
 # Since: 2.4
 ##
@@ -170,7 +170,7 @@
 # @ip-tos: IP header TOS field
 #
 # Note: optional members may or may not appear in the flow mask
-# depending if they're relevant to the flow mask.
+#       depending if they're relevant to the flow mask.
 #
 # Since: 2.4
 ##
@@ -197,7 +197,7 @@
 # @out-pport: physical output port
 #
 # Note: optional members may or may not appear in the flow action
-# depending if they're relevant to the flow action.
+#       depending if they're relevant to the flow action.
 #
 # Since: 2.4
 ##
@@ -235,7 +235,7 @@
 # @name: switch name
 #
 # @tbl-id: flow table ID.  If tbl-id is not specified, returns
-# flow information for all tables.
+#          flow information for all tables.
 #
 # Returns: rocker OF-DPA flow information
 #
@@ -291,7 +291,7 @@
 # @ttl-check: perform TTL check
 #
 # Note: optional members may or may not appear in the group depending
-# if they're relevant to the group type.
+#       if they're relevant to the group type.
 #
 # Since: 2.4
 ##
@@ -311,7 +311,7 @@
 # @name: switch name
 #
 # @type: group type.  If type is not specified, returns
-# group information for all group types.
+#        group information for all group types.
 #
 # Returns: rocker OF-DPA group information
 #
diff --git a/qapi/run-state.json b/qapi/run-state.json
index b83a436a3e6..2e229077400 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -15,16 +15,16 @@
 # @finish-migrate: guest is paused to finish the migration process
 #
 # @inmigrate: guest is paused waiting for an incoming migration.  Note
-# that this state does not tell whether the machine will start at the
-# end of the migration.  This depends on the command-line -S option and
-# any invocation of 'stop' or 'cont' that has happened since QEMU was
-# started.
+#             that this state does not tell whether the machine will start at the
+#             end of the migration.  This depends on the command-line -S option and
+#             any invocation of 'stop' or 'cont' that has happened since QEMU was
+#             started.
 #
 # @internal-error: An internal error that prevents further guest execution
-# has occurred
+#                  has occurred
 #
 # @io-error: the last IOP has failed and the device is configured to pause
-# on I/O errors
+#            on I/O errors
 #
 # @paused: guest has been paused via the 'stop' command
 #
@@ -85,8 +85,8 @@
 # @guest-panic: Guest panicked, and command line turns that into a shutdown
 #
 # @subsystem-reset: Partial guest reset that does not trigger QMP events and
-#                  ignores --no-reboot. This is useful for sanitizing
-#                  hypercalls on s390 that are used during kexec/kdump/boot
+#                   ignores --no-reboot. This is useful for sanitizing
+#                   hypercalls on s390 that are used during kexec/kdump/boot
 #
 ##
 { 'enum': 'ShutdownCause',
@@ -140,13 +140,13 @@
 # about to exit.
 #
 # @guest: If true, the shutdown was triggered by a guest request (such as
-# a guest-initiated ACPI shutdown request or other hardware-specific action)
-# rather than a host request (such as sending qemu a SIGINT). (since 2.10)
+#         a guest-initiated ACPI shutdown request or other hardware-specific action)
+#         rather than a host request (such as sending qemu a SIGINT). (since 2.10)
 #
 # @reason: The @ShutdownCause which resulted in the SHUTDOWN. (since 4.0)
 #
 # Note: If the command-line option "-no-shutdown" has been specified, qemu will
-# not exit, and a STOP event will eventually follow the SHUTDOWN event
+#       not exit, and a STOP event will eventually follow the SHUTDOWN event
 #
 # Since: 0.12.0
 #
@@ -180,9 +180,9 @@
 # Emitted when the virtual machine is reset
 #
 # @guest: If true, the reset was triggered by a guest request (such as
-# a guest-initiated ACPI reboot request or other hardware-specific action)
-# rather than a host request (such as the QMP command system_reset).
-# (since 2.10)
+#         a guest-initiated ACPI reboot request or other hardware-specific action)
+#         rather than a host request (such as the QMP command system_reset).
+#         (since 2.10)
 #
 # @reason: The @ShutdownCause of the RESET. (since 4.0)
 #
@@ -283,7 +283,7 @@
 # @action: action that has been taken
 #
 # Note: If action is "reset", "shutdown", or "pause" the WATCHDOG event is
-# followed respectively by the RESET, SHUTDOWN, or STOP events
+#       followed respectively by the RESET, SHUTDOWN, or STOP events
 #
 # Note: This event is rate-limited.
 #
@@ -441,12 +441,12 @@
 # @disabled-wait: the CPU has entered a disabled wait state
 #
 # @extint-loop: clock comparator or cpu timer interrupt with new PSW enabled
-#              for external interrupts
+#               for external interrupts
 #
 # @pgmint-loop: program interrupt with BAD new PSW
 #
 # @opint-loop: operation exception interrupt with invalid code at the program
-#             interrupt new PSW
+#              interrupt new PSW
 #
 # Since: 2.12
 ##
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 32375f3a361..ea933ed4b2b 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -89,7 +89,7 @@
 # @port: port
 #
 # Note: string types are used to allow for possible future hostname or
-# service resolution support.
+#       service resolution support.
 #
 # Since: 2.8
 ##
@@ -104,9 +104,9 @@
 # Captures the address of a socket, which could also be a named file descriptor
 #
 # Note: This type is deprecated in favor of SocketAddress.  The
-# difference between SocketAddressLegacy and SocketAddress is that the
-# latter is a flat union rather than a simple union. Flat is nicer
-# because it avoids nesting on the wire, i.e. that form has fewer {}.
+#       difference between SocketAddressLegacy and SocketAddress is that the
+#       latter is a flat union rather than a simple union. Flat is nicer
+#       because it avoids nesting on the wire, i.e. that form has fewer {}.
 
 #
 # Since: 1.3
diff --git a/qapi/trace.json b/qapi/trace.json
index 799b254a186..4955e5a7503 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -52,14 +52,14 @@
 #
 # Returns: a list of @TraceEventInfo for the matching events
 #
-# An event is returned if:
-# - its name matches the @name pattern, and
-# - if @vcpu is given, the event has the "vcpu" property.
+#          An event is returned if:
+#          - its name matches the @name pattern, and
+#          - if @vcpu is given, the event has the "vcpu" property.
 #
-# Therefore, if @vcpu is given, the operation will only match per-vCPU events,
-# returning their state on the specified vCPU. Special case: if @name is an
-# exact match, @vcpu is given and the event does not have the "vcpu" property,
-# an error is returned.
+#          Therefore, if @vcpu is given, the operation will only match per-vCPU events,
+#          returning their state on the specified vCPU. Special case: if @name is an
+#          exact match, @vcpu is given and the event does not have the "vcpu" property,
+#          an error is returned.
 #
 # Since: 2.2
 #
diff --git a/qapi/transaction.json b/qapi/transaction.json
index 0590dbcd1ae..04301f1be79 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -132,8 +132,8 @@
 #          Errors depend on the operations of the transaction
 #
 # Note: The transaction aborts on the first failure.  Therefore, there will be
-# information on only one failed operation returned in an error condition, and
-# subsequent actions will not have been attempted.
+#       information on only one failed operation returned in an error condition, and
+#       subsequent actions will not have been attempted.
 #
 # Since: 1.1
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index e04525d8b44..aced267a1e4 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -18,10 +18,10 @@
 # @password: the new password
 #
 # @connected: how to handle existing clients when changing the
-#                       password.  If nothing is specified, defaults to `keep'
-#                       `fail' to fail the command if clients are connected
-#                       `disconnect' to disconnect existing clients
-#                       `keep' to maintain existing clients
+#             password.  If nothing is specified, defaults to `keep'
+#             `fail' to fail the command if clients are connected
+#             `disconnect' to disconnect existing clients
+#             `keep' to maintain existing clients
 #
 # Returns: Nothing on success
 #          If Spice is not enabled, DeviceNotFound
@@ -591,12 +591,12 @@
 #
 # Change the VNC server password.
 #
-# @password:  the new password to use with VNC authentication
+# @password: the new password to use with VNC authentication
 #
 # Since: 1.1
 #
-# Notes:  An empty password in this command will set the password to the empty
-#         string.  Existing clients are unaffected by executing this command.
+# Notes: An empty password in this command will set the password to the empty
+#        string.  Existing clients are unaffected by executing this command.
 ##
 { 'command': 'change-vnc-password',
   'data': { 'password': 'str' },
@@ -612,7 +612,7 @@
 # @client: client information
 #
 # Note: This event is emitted before any authentication takes place, thus
-# the authentication ID is not provided
+#       the authentication ID is not provided
 #
 # Since: 0.13.0
 #
@@ -915,9 +915,9 @@
 #
 # Pointer motion input event.
 #
-# @axis:   Which axis is referenced by @value.
-# @value:  Pointer position.  For absolute coordinates the
-#          valid range is 0 -> 0x7ffff
+# @axis: Which axis is referenced by @value.
+# @value: Pointer position.  For absolute coordinates the
+#         valid range is 0 -> 0x7ffff
 #
 # Since: 2.0
 ##
@@ -931,10 +931,10 @@
 # Input event union.
 #
 # @type: the input type, one of:
-#  - 'key': Input event of Keyboard
-#  - 'btn': Input event of pointer buttons
-#  - 'rel': Input event of relative pointer motion
-#  - 'abs': Input event of absolute pointer motion
+#        - 'key': Input event of Keyboard
+#        - 'btn': Input event of pointer buttons
+#        - 'rel': Input event of relative pointer motion
+#        - 'abs': Input event of absolute pointer motion
 #
 # Since: 2.0
 ##
@@ -970,9 +970,9 @@
 # Since: 2.6
 #
 # Note: The consoles are visible in the qom tree, under
-# /backend/console[$index]. They have a device link and head property,
-# so it is possible to map which console belongs to which device and
-# display.
+#       /backend/console[$index]. They have a device link and head property,
+#       so it is possible to map which console belongs to which device and
+#       display.
 #
 # Example:
 #
-- 
2.20.1


