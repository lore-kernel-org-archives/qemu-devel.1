Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B9FCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F02D20717
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrC2TNJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F02D20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUJF-0005N7-Pd
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 12:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGm-00022s-4H
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iPUGk-0004s7-VY
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:56 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:40179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iPUGj-0004qh-PQ
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 12:22:54 -0400
Received: by mail-wr1-x432.google.com with SMTP id o28so14335085wro.7
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sLnJuV1CfPJkVM9GKln4msacMdvBWBdZJ+5D0UICXmE=;
 b=XrC2TNJmex2/AA6vwp4mdzWB6sJ3gEPkJEmmdwxZfGlDt/hZzjaaVScz94MeAoRzZ7
 PZiqeTSk14Lb0uYQkVgu4holHBVPD1aqhzhlkz40wwLNMBREE/Nmqz01JZCCFBqiD73d
 hfsmtFHdWQ8h87Ywtx1ul6F211EFWTYzrQ7oAX4KJDQE8JuCnn+2rGf4PKuwTKtYu/wt
 /74lJPWlQ8XuXrawbVqRRnZ2VXmxRCtKt7hQLPbMMKJyhEo2TMQ3v4T/5oL0ZJnpdYjH
 3T8yWayJ9ydZaSPLObW+dgekcWzst1EuT5enOPqs/nKDUai3xlTu7WJXZBM/x1Eb5DDw
 9CYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sLnJuV1CfPJkVM9GKln4msacMdvBWBdZJ+5D0UICXmE=;
 b=bNHdQf0aMdyqqP/QXUGC9bowYWvoRdIX1a3lRvVU0yuJupfphQHrOM5yvaYOnrmzSX
 zj1vXBGmmNO99zacuS0o9PaPlLn2OtR7BUKvrn3ucNjmlbKwGGGQqyP0gMerN8+mZbVP
 aqGqFLPAfz+igvQzb5DNYfrisGkFFsG0trKEaBrqSBc09wIxEgQaEfir1U1lLOxUcIqx
 bigciNIBKICF7SmP/dWBDj7EJ/3XxF2hOAIZjPTHtPTqOdxa7g2xp+WynjwL+oe+Or33
 XYjIA8Rvzvo1DZsYv98LOfn0xEipJ/1KYYPcKPo666wa5G4M80p06gxqh56fRQgeyWcJ
 zUHA==
X-Gm-Message-State: APjAAAVGdPS2k6Sck7Ns1RpdxRHupG/rI+E3Vdi94a5wmR6XYfMn7mYx
 N5hUKllJxNUiUhaYQpP36rmJmwRYL10=
X-Google-Smtp-Source: APXvYqxpfAT+5trWYX/sB6rzO/wo9mCBtpCp1wFXSyvI8Fq9ioc560eSsWxRpL4hiT4Cs3IoC/FHRQ==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr19761878wrr.42.1572366172513; 
 Tue, 29 Oct 2019 09:22:52 -0700 (PDT)
Received: from donizetti.metropole.lan (94.222.26.109.rev.sfr.net.
 [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id q12sm9285661wrw.91.2019.10.29.09.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 09:22:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] docs: disable sphinx warning about missing cross
 references
Date: Tue, 29 Oct 2019 17:22:45 +0100
Message-Id: <20191029162248.13383-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029162248.13383-1-pbonzini@redhat.com>
References: <20191029162248.13383-1-pbonzini@redhat.com>
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sphinx is a bit *too* strict about missing cross references to
C types, where it complains about missing references to uint8_t.
Even if that were fixed in kernel-doc, we would still have lots
of missing references to types that are not yet documented.  So
unfortunately let's disable for now the nitpicking mode.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com> # still not a good idea, probably
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d20e7ffce3..8aa915ff26 100644
--- a/Makefile
+++ b/Makefile
@@ -986,7 +986,7 @@ sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html $(MANUAL_BUILDDIR)/interop/index
 # Note the use of different doctree for each (manual, builder) tuple;
 # this works around Sphinx not handling parallel invocation on
 # a single doctree: https://github.com/sphinx-doc/sphinx/issues/2946
-build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -n -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
+build-manual = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -b $2 -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1-$2 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
 # We assume all RST files in the manual's directory are used in it
 manual-deps = $(wildcard $(SRC_PATH)/docs/$1/*.rst) $(SRC_PATH)/docs/$1/conf.py $(SRC_PATH)/docs/conf.py
 
-- 
2.21.0



