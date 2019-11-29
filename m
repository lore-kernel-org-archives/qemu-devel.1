Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0063C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:38:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AC621736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWgM/z5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AC621736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahPU-0003D7-Lw
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:38:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqx-0002Dx-8a
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqr-0003RI-Em
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:34 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37775)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagqp-0003Nx-8B
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:29 -0500
Received: by mail-wm1-x343.google.com with SMTP id f129so15200845wmf.2
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7qR4CglT38h4RrB/48A3ve+rvnXStcx62AzXZuMT/HA=;
 b=IWgM/z5fCdtIMvwoVahfbTRwTMlIeJTZR0gvPYiYP7LVw0BrhE/bSZgEpd1FUFJmLv
 jkhwVjib8k6BSdqD4OvM+Vtd0hF3X0JS27m/3EFhAji1WXrycz6ZaCxjiSOOjei6reiv
 rLulXnVT79+DQhkYlZdkYHnH+7gcrlzvhXNJRkHazJc6V7o46PXZM9cmPU5+3w3VdvHw
 IDppNkcfC9Hls30dHiXenUUdUGTavnYmnhhiFEWXezfpjOvDM9wwLiHBWOOLS38QOAFb
 RBRB2DLcxs3Mfg/9JXVb9TwO4hujYXiJYAj2nxx2KyBSmKMMdbT+t+0tbhqZaTX9bOSQ
 5kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=7qR4CglT38h4RrB/48A3ve+rvnXStcx62AzXZuMT/HA=;
 b=gEnpPVCUb5J8elNhKyBXgcdmq0l99YX3wpULnHvzTliHuUeJFYNB/TLFhZUdCF4J5k
 bFeZmTCLzI81SSuJssmOfkgOuiviJL3wFq/x45QUpzvSIo2AZ/EbHC9lj14eJoLszcTe
 fTYQ5gjoiqRkwl3N9IBYTNBM4j4ywytFuNI/d13B40ip5VRu1paXbtfYDeP7cJMcp7nu
 NrD6uqyfGKz1nOg8qF2PVigH8B9cJ6AK00DFWgTGOI3YFA31vlsSHCeknRPQjWc+kmiQ
 er8lzQ2MhiZqKjZNKdny3Tt5ZlGUzKbfnDcEPcd5bpKe5aVyXt39M+0QwgukZqER3ril
 NXYQ==
X-Gm-Message-State: APjAAAUIJKKOfOOROwJ+qtCwYX2nv8sO0Ro1mhAY9QoLtgaaPQ0qHyYP
 RG3NQywC5pHJaO6KdMmNCHqB8CC9
X-Google-Smtp-Source: APXvYqwAB2jZ7Hus0NBK8VoulJb2ImEJ0+fc80BejkogCfl7xmt+PrpW4HScI7g2BQt+C3f03P6tFA==
X-Received: by 2002:a7b:c768:: with SMTP id x8mr15480299wmk.26.1575036144750; 
 Fri, 29 Nov 2019 06:02:24 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:24 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] docs: Create bitops.rst as example of kernel-docs
Date: Fri, 29 Nov 2019 15:02:15 +0100
Message-Id: <20191129140217.17797-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
References: <20191129140217.17797-1-pbonzini@redhat.com>
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Create a bitops.rst which is just a container for the
kernel-doc comments in qemu/bitops.h.

This is mostly a test of the kernel-doc extension machinery.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190521122519.12573-7-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/bitops.rst | 8 ++++++++
 docs/devel/index.rst  | 1 +
 2 files changed, 9 insertions(+)
 create mode 100644 docs/devel/bitops.rst

diff --git a/docs/devel/bitops.rst b/docs/devel/bitops.rst
new file mode 100644
index 0000000000..6addaecf8d
--- /dev/null
+++ b/docs/devel/bitops.rst
@@ -0,0 +1,8 @@
+==================
+Bitwise operations
+==================
+
+The header ``qemu/bitops.h`` provides utility functions for
+performing bitwise operations.
+
+.. kernel-doc:: include/qemu/bitops.h
diff --git a/docs/devel/index.rst b/docs/devel/index.rst
index c86a3cdff2..ac862152dc 100644
--- a/docs/devel/index.rst
+++ b/docs/devel/index.rst
@@ -23,3 +23,4 @@ Contents:
    secure-coding-practices
    tcg
    tcg-plugins
+   bitops
-- 
2.21.0



