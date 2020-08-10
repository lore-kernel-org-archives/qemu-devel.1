Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9781DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F9B22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnNSPh56"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F9B22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dqh-00055d-Pw
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoT-0008Rp-8c
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:29 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoR-0004iu-50
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id a14so9318214wra.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t2oLRViBghCHbdyXmGQBzzRr3hni6nS3HlY20oR/lCA=;
 b=nnNSPh56DmulajgCy67Z51y4DF+H/Ng+6HdBphytQ94EQo2s7ghCq2w4SRaS7VWqZi
 6wFcUWsttT7r+VWam+e9kYu+wTzfTrSCjBZ6APLLZE0iakPepeWCCDYQb8x2GqV+SwjD
 uCpJy9qTS8FA+Y5/5q/niJNDp1V9PzkcMtzNRVKu3wI5d/HY7Fj496P52L0/KJumQ06e
 xeEZf3OgpHSkaOlXqbCsKcjoeiTiScn2+dzJj3J4D/C46Ro7+X0OKmCzOzE3/AmEiPvI
 jmFL9JCXmrFRrN9d0/NxDafxtYCi3v1/3kEJA7v3iJI6jiMQzAJaDXoP9fXXdMsv7UsR
 UnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t2oLRViBghCHbdyXmGQBzzRr3hni6nS3HlY20oR/lCA=;
 b=SGruFx2MfLUumMyvLqWPSQEU5BOkUSPnmjzNZGWPpZFj1unltNOj/UTz1iewKCClOb
 zaQm+HGX85ml2pZ5R41jyIrte/yvGs3CdGvLtOlanTa5SP1RcEMcEJwSAMsd5WsGjEF2
 Hg75VEJLPH5m33YfNtNcdVRanE1H4tI/rsZysTyMjE+wbJLhep2WdwecrBPog5g6wOCG
 w6cM5wLZ2qahVk1iukmWn/Hefr/Qb4Bx/fBFhPkRvJqlkI4jjflDIgY5NG9LMBeKSaie
 nA6EfO2qcIj7a/rOeN+u62c3xQHF7T5ng0J1tRw6AvEaRBPYPgEpjWfESmKsdW5jbOF/
 Nqag==
X-Gm-Message-State: AOAM533+Xgx3oMF9kZY6nMaqwVmZdFQQW5rjL60J+JliZnMH5nwNiiNW
 exosiTp+Uza9GQgcGaSUSV/Msqi4D6ITfA==
X-Google-Smtp-Source: ABdhPJya6N63kaphWiBcE3NKQ+rw7GfGKRNX27v9XXAnx/ldGraST3kP1VIxPyRUdJsaRqFTDrxxyw==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr27860646wrs.226.1597089024831; 
 Mon, 10 Aug 2020 12:50:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 02/20] qapi: Fix indentation, again
Date: Mon, 10 Aug 2020 20:50:01 +0100
Message-Id: <20200810195019.25427-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
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

Unfortunately since we didn't manage to get the script changes that
enforced the new style in, a variety of commits (eg df4097aeaf71,
2e4457032105) introduced new doc text which doesn't follow the new
stricter rules for indentation on multi-line doc comments.  Bring
those into line with the new rules.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/audio.json      | 12 ++++++------
 qapi/block-core.json |  8 ++++----
 qapi/control.json    |  4 ++--
 qapi/machine.json    |  6 +++---
 qapi/migration.json  |  8 ++++----
 qapi/misc.json       |  4 ++--
 qapi/net.json        |  2 +-
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index f62bd0d7f6e..3b843878d23 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -159,20 +159,20 @@
 # recording.
 #
 # @server-name: select from among several possible concurrent server instances
-# (default: environment variable $JACK_DEFAULT_SERVER if set, else "default")
+#               (default: environment variable $JACK_DEFAULT_SERVER if set, else "default")
 #
 # @client-name: the client name to use. The server will modify this name to
-# create a unique variant, if needed unless @exact-name is true (default: the
-# guest's name)
+#               create a unique variant, if needed unless @exact-name is true (default: the
+#               guest's name)
 #
 # @connect-ports: if set, a regular expression of JACK client port name(s) to
-# monitor for and automatically connect to
+#                 monitor for and automatically connect to
 #
 # @start-server: start a jack server process if one is not already present
-# (default: false)
+#                (default: false)
 #
 # @exact-name: use the exact name requested otherwise JACK automatically
-# generates a unique one, if needed (default: false)
+#              generates a unique one, if needed (default: false)
 #
 # Since: 5.1
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 197bdc1c36d..f04bb3f0dd5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -369,7 +369,7 @@
 #
 # Features:
 # @deprecated: Member @encryption_key_missing is deprecated.  It is
-#     always false.
+#              always false.
 #
 # Since: 0.14.0
 #
@@ -504,7 +504,7 @@
 #
 # Features:
 # @deprecated: Member @status is deprecated.  Use @recording and
-#     @locked instead.
+#              @locked instead.
 #
 # Since: 1.3
 ##
@@ -614,7 +614,7 @@
 #
 # Features:
 # @deprecated: Member @dirty-bitmaps is deprecated.  Use @inserted
-#     member @dirty-bitmaps instead.
+#              member @dirty-bitmaps instead.
 #
 # Since:  0.14.0
 ##
@@ -1642,7 +1642,7 @@
 #
 # Features:
 # @deprecated: Members @base and @top are deprecated.  Use @base-node
-#     and @top-node instead.
+#              and @top-node instead.
 #
 # Returns: - Nothing on success
 #          - If @device does not exist, DeviceNotFound
diff --git a/qapi/control.json b/qapi/control.json
index de51e9916c3..134f842bafa 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -177,8 +177,8 @@
 #
 # Features:
 # @deprecated: This command is deprecated, because its output doesn't
-#     reflect compile-time configuration.  Use 'query-qmp-schema'
-#     instead.
+#              reflect compile-time configuration.  Use 'query-qmp-schema'
+#              instead.
 #
 # Returns: A list of @EventInfo.
 #
diff --git a/qapi/machine.json b/qapi/machine.json
index 481b1f07ecc..5aee2bbd169 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -191,8 +191,8 @@
 #
 # Features:
 # @deprecated: This command is deprecated, because it interferes with
-#     the guest.  Use 'query-cpus-fast' instead to avoid the vCPU
-#     interruption.
+#              the guest.  Use 'query-cpus-fast' instead to avoid the vCPU
+#              interruption.
 #
 # Returns: a list of @CpuInfo for each virtual CPU
 #
@@ -316,7 +316,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use `device_add` instead.
-#     See the `query-hotpluggable-cpus` command for details.
+#              See the `query-hotpluggable-cpus` command for details.
 #
 # Returns: Nothing on success
 #
diff --git a/qapi/migration.json b/qapi/migration.json
index e07c9c0f1aa..66a6fbb89d8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1264,7 +1264,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'migrate-set-parameters' instead.
+#              'migrate-set-parameters' instead.
 #
 # Returns: nothing on success
 #
@@ -1288,7 +1288,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'migrate-set-parameters' instead.
+#              'migrate-set-parameters' instead.
 #
 # Returns: nothing on success
 #
@@ -1312,7 +1312,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'migrate-set-parameters' instead.
+#              'migrate-set-parameters' instead.
 #
 # The size will be rounded down to the nearest power of 2.
 # The cache size can be modified before and during ongoing migration
@@ -1338,7 +1338,7 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  Use
-#     'query-migrate-parameters' instead.
+#              'query-migrate-parameters' instead.
 #
 # Returns: XBZRLE cache size in bytes
 #
diff --git a/qapi/misc.json b/qapi/misc.json
index 9d32820dc1b..8cf6ebe67cb 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -877,8 +877,8 @@
 #
 # Features:
 # @deprecated: This command is deprecated.  For changing block
-#     devices, use 'blockdev-change-medium' instead; for changing VNC
-#     parameters, use 'change-vnc-password' instead.
+#              devices, use 'blockdev-change-medium' instead; for changing VNC
+#              parameters, use 'change-vnc-password' instead.
 #
 # Returns: - Nothing on success.
 #          - If @device is not a valid block device, DeviceNotFound
diff --git a/qapi/net.json b/qapi/net.json
index ddb113e5e5a..a3a13360018 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -457,7 +457,7 @@
 #
 # Since: 2.7
 #
-# @vhost-vdpa since 5.1
+#        @vhost-vdpa since 5.1
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
-- 
2.20.1


