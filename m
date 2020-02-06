Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D2C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:40:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD9F20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hc/R2JNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD9F20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl8q-0003zz-4s
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl05-0006o9-C4
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl01-0006cV-L5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:37 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:33091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzy-0006GT-Qa
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:31 -0500
Received: by mail-wr1-x42f.google.com with SMTP id u6so8240253wrt.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8Q3qcfVtQBbM2YwOrLV7NuxogQrx/IXYuo0cjcWYW7M=;
 b=Hc/R2JNsdYlv7+ZPYvbd3MSd4KU3dDiu0mQTAw/VnmRWvO88hwjmWMUj+dagJ5TCRi
 vXpc3rmg7+h/MRr0cPcZiHcnMwUrp7K7QEtkDYTo4OjiHgsz43jgo/ZKQanSxNxG0Byn
 V2Sjn7iUKAkoZOP8CDGBWkWVc4thOO0dz780/d79IU2W+b8L95XtDLxQ5BtedGbs3TyP
 4MxeEzFQE1o61HQN9vpBfcHuZ8uup4X7MWwL3i0G7ha9cb86ZBCf33ipftIoy3MKvj8W
 KTyVXqYNQgF0DWMT+0Ukq97t9iwDMwon+sMaG0vir5LYMcXQMckyaaE7Yz8hnZHMnrEc
 pWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8Q3qcfVtQBbM2YwOrLV7NuxogQrx/IXYuo0cjcWYW7M=;
 b=RiB3blWlZz54t4Tb0ohqV1VbjeeS+BgeXU1tHqOWd5bE3pFXO9U9TOlmm+UJQQJt89
 IiRZPmjKk40LuSyzaXItc71swheXdC/ZdUN3bXcfd2Kis1oUv40rbF1FP31fh0Q7P4/a
 tkQ4hX3AGKEOOrp/m6LPu5a4FOh+0FFmMbqfj2d0/TTITZjoHRycNoAcf2o+BGNqJR6n
 cldrXqapICr2uxqPDPK3AfBoqfvdIH16a3e+7hC4k6Cmxa4x6lrrwox98RzQosHZVuCe
 /TJ8TsL3Q0MIv+BzCNur0WtKgyCzUR0Edbo3ax0fCSElyd8/9czQwW5F9TIZdqPiW+kz
 xZAA==
X-Gm-Message-State: APjAAAWRmIkEqVOB5mVZsc9DqIzdkwDYDHM9pWvyOf6NSA0f/zJOEB+P
 vUn9Y5So2Oq2WH1h1Zf+asLWv38HWGY=
X-Google-Smtp-Source: APXvYqze11AuYP+PUlei0byGw6RgFymLeJolzZKWWrXE+ObcbO0LcXH9DwiAgaQh2gv8lklyfY4yfg==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr5049287wrw.277.1581010285881; 
 Thu, 06 Feb 2020 09:31:25 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:25 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/29] qapi: Add blank lines before bulleted lists
Date: Thu,  6 Feb 2020 17:30:28 +0000
Message-Id: <20200206173040.17337-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
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

rST insists on a blank line before and after a bulleted list,
but our texinfo doc generator did not. Add some extra blank
lines in the doc comments so they're acceptable rST input.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json | 1 +
 qapi/char.json       | 2 ++
 qapi/trace.json      | 1 +
 qapi/ui.json         | 1 +
 4 files changed, 5 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 9e878e39336..092cd8f13d9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4757,6 +4757,7 @@
 #
 # Once the tray opens, a DEVICE_TRAY_MOVED event is emitted. There are cases in
 # which no such event will be generated, these include:
+#
 # - if the guest has locked the tray, @force is false and the guest does not
 #   respond to the eject request
 # - if the BlockBackend denoted by @device does not have a guest device attached
diff --git a/qapi/char.json b/qapi/char.json
index 8a9f1e75097..6907b2bfdba 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -133,6 +133,7 @@
 # @data: data to write
 #
 # @format: data encoding (default 'utf8').
+#
 #          - base64: data must be base64 encoded text.  Its binary
 #            decoding gets written.
 #          - utf8: data's UTF-8 encoding is written
@@ -167,6 +168,7 @@
 # @size: how many bytes to read at most
 #
 # @format: data encoding (default 'utf8').
+#
 #          - base64: the data read is returned in base64 encoding.
 #          - utf8: the data read is interpreted as UTF-8.
 #            Bug: can screw up when the buffer contains invalid UTF-8
diff --git a/qapi/trace.json b/qapi/trace.json
index 4955e5a7503..47c68f04da7 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -53,6 +53,7 @@
 # Returns: a list of @TraceEventInfo for the matching events
 #
 #          An event is returned if:
+#
 #          - its name matches the @name pattern, and
 #          - if @vcpu is given, the event has the "vcpu" property.
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index f527bbdc26e..b368401fd1d 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -935,6 +935,7 @@
 # Input event union.
 #
 # @type: the input type, one of:
+#
 #        - 'key': Input event of Keyboard
 #        - 'btn': Input event of pointer buttons
 #        - 'rel': Input event of relative pointer motion
-- 
2.20.1


