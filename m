Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6885C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B166521736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 14:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UShhFgHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B166521736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iahEE-0001dZ-MC
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 09:26:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37093)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqs-00023c-C8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iagqp-0003PG-AR
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:55820)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iagqn-0003KQ-WC
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 09:02:27 -0500
Received: by mail-wm1-x32e.google.com with SMTP id a131so9970522wme.5
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 06:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lx6DGULeUoiZGfGxG0Zx1Ji9gkFvHa0kVzeH7vCeWUY=;
 b=UShhFgHgj7KXd3tkLQdDvEoS53pMxysTrfFinCoHFFXVTGxzt18RDKP+ejfL3aOznk
 X3KxEpLftVXodMQtLkT+2Lt1TO2FlVBCUvdIfJjxWjLmnPPG7n6ciXjRhrMidz/oFHUJ
 2ygckf+rr0pGuZ9AkRDyIuv9BcH64+cxLJa0zEAP64yIIA9ecD1ivytSGBPVKkPXbnMt
 +FMVW949mYPiQvr/awp90c636Bkf+Ol137xH30PTJP+grKhrKQjVhKfoACkT0Fwl3bOe
 eqRWpciXBTFl1TweGMRGa8pCyuU0WAFmt4MCUynoSKazl+7QsTG9PR+8/9XDfrr7cM6Z
 Rvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lx6DGULeUoiZGfGxG0Zx1Ji9gkFvHa0kVzeH7vCeWUY=;
 b=OWOIMU9P0/B/mHvaTiLWvyZSANh1zD+PVNEGOEBTt4FzEAN/gItmWhVof6DabRDt8H
 OhB7nIJW6R9AkgdnnbMViZWxt88i9uugEsKOqXP+brHvLwpBC6NWko+N6PR/ZSwhVv73
 oRrTo9MRe0iw7J36BaJrR9ZV64s4QTtZXAOJ6ZnjBW9vd8iNlfiBMOnYZ+ajppJcCt2h
 KMlpkv2xpqgUx642+qFqluWuvvNlPlLI7eJBrXuJORwBQfBIoO3hUjTDXAmqk/jaGmJK
 laA/PJL2alEc6SLDDBnzNvKFT9wv/U0oYLtRMCrJOJj3AZNohD8olctVZckK2Uwjhp+A
 GhgQ==
X-Gm-Message-State: APjAAAWLy+RLUnqppILRVq5g2/AFjNTikR6gs7q8k2gQ+DAdagJt7L1n
 SO/nCYmbEwD8HCCwpL3oGoL6fMym
X-Google-Smtp-Source: APXvYqxEX0gDZelP6dDZvN6wTc+eVVBc3e5ru1citNwTAnnyTXXEuEHG/PpxfDkSuB0gPFTAj/GZFA==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr14039647wmd.23.1575036142861; 
 Fri, 29 Nov 2019 06:02:22 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:56e1:adff:fed9:caf0])
 by smtp.gmail.com with ESMTPSA id
 e7sm14190030wrp.43.2019.11.29.06.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2019 06:02:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] Makefile: disable Sphinx nitpicking
Date: Fri, 29 Nov 2019 15:02:13 +0100
Message-Id: <20191129140217.17797-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
References: <20191129140217.17797-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

Turn off Sphinx nitpicking as a temporary (?) measure so
sphinx builds complete even with warnings about missing
references.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20190521122519.12573-11-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b437a346d7..fcf16dc4cf 100644
--- a/Makefile
+++ b/Makefile
@@ -1010,7 +1010,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -n -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 
-- 
2.21.0



