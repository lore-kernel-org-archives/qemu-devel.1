Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D2DC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D797D21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6p0JB2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D797D21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoT3o-0003xS-Lp
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37747)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT3P-0002ad-T0
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mehta.aaru20@gmail.com>) id 1hoT3O-0007cw-Rl
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:36:07 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mehta.aaru20@gmail.com>)
 id 1hoT3O-0007cU-MB; Fri, 19 Jul 2019 09:36:06 -0400
Received: by mail-pg1-x541.google.com with SMTP id i70so3745290pgd.4;
 Fri, 19 Jul 2019 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=d/2bUWcNzFxcpnKI7+ugh8PRZBa+/iFU8UDy66IrG/E=;
 b=j6p0JB2mIYzALaHGp+rXetNIKQbE+IUCYAwyvRmie+krxpy7FQNz/MpGEJnbjAXyop
 yLTsgIorHcVBOPkD5WrskRKABlv5YV92SH/lTFUvtLvWnh++TUifek8ewJjTKvFGQhKE
 nfhso8CQiguYg1XqyDip0F0VaIwusuT5bpd4j9gFoy4d4DkUzvmX99KfUsKDwmKVYBgZ
 QvBRFDGOOA4qgcKzasWF8ItyagEQwZmDYBUiB1GPEBRQ8oCXvunEoIcCK/c8xEm3z7M9
 4kz2vVwqQ4pT2Mawi4kHbkNbcwzqwsn4JgVnbpdd94wptYsIwD38Bz11FytIPY8n+WBf
 i5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d/2bUWcNzFxcpnKI7+ugh8PRZBa+/iFU8UDy66IrG/E=;
 b=pGLhbcVhBUgpZMajV6Ha/WL34z5fatIVs31atJMDHOuXX9FVARsPMzld7aDzzsITsU
 looKwMlAASoIGfxgnLh4S4voEQIdYdkZGLBFNh9JKY4MiQAYm6yTMTryt0Q968Zodzfd
 RrYky2vIIuECdd20yfmnDd67JflFUyU6keSdCsP2OA6lXK+AF4Cx+8rugREl1uR7ADRR
 jJ7hQ2Z4F3MPxgucN0wSvXaL3K72hOtwVwRh+/TxkDiF7OCHZG+BwJggtHZCIiiAIweO
 rX4HEsIx5BF1QOp9TI3YdsJVoT3AeOKTYs+SGcpj5DjDSCNG0/0ahsTfTXoqNnqciO5o
 Tqfg==
X-Gm-Message-State: APjAAAWaVh8TOEavtIk427cGqlzw2CRBq7j0yLAQyPoER3d/Xm0cv+ap
 dFCVoyXr5pBuefvDmu6pk2SHsJvbFn0=
X-Google-Smtp-Source: APXvYqw8yTYJEwz8H3UxIJeMJriQ/VGKoyOT1mj8Dmo4hqBc65yC2yQu3GG79qWE1ZbN4wInFAvMjA==
X-Received: by 2002:a63:5a4d:: with SMTP id k13mr52588802pgm.174.1563543365460; 
 Fri, 19 Jul 2019 06:36:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:433:31a4:f2fb:dab8:3a89:c056])
 by smtp.gmail.com with ESMTPSA id 11sm31895369pfw.33.2019.07.19.06.35.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 06:36:04 -0700 (PDT)
From: Aarushi Mehta <mehta.aaru20@gmail.com>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 19:05:18 +0530
Message-Id: <20190719133530.28688-3-mehta.aaru20@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719133530.28688-1-mehta.aaru20@gmail.com>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
Subject: [Qemu-devel] [PATCH v6 02/14] qapi/block-core: add option for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 saket.sinha89@gmail.com, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefan@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Only enumerates option for devices that support it

Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 0d43d4f37c..0a3d4ae7d2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2792,11 +2792,13 @@
 #
 # @threads:     Use qemu's thread pool
 # @native:      Use native AIO backend (only Linux and Windows)
+# @io_uring:    Use linux io_uring (since 4.1)
 #
 # Since: 2.9
 ##
 { 'enum': 'BlockdevAioOptions',
-  'data': [ 'threads', 'native' ] }
+  'data': [ 'threads', 'native',
+            { 'name': 'io_uring', 'if': 'defined(CONFIG_LINUX_IO_URING)' } ] }
 
 ##
 # @BlockdevCacheOptions:
-- 
2.21.0


