Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8ADC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BB8520838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCQE/I5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB8520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl6f-0000Ak-Of
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:38:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzi-0006fP-Mr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzh-0005Vr-JD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:14 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:42906)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzh-0005O9-Cg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:13 -0500
Received: by mail-wr1-x432.google.com with SMTP id k11so8179824wrd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w5pl3TzQvaQVnyMYNeKi2uN7fk7InvWwzklZYoBOlQs=;
 b=qCQE/I5LhFJZLl3wTpxiQ4MIIL60lARoR1glCBE7G8fp/atAaTrEWixCOvehMbY5RI
 Gk7znuUqw9p4ACtsR6enTWBiIXa2PpB7WNIyyON6kyFiixK8jnIpmFyPBINh7HGA/ga5
 Ts7NDhjhn5U1uhr3Sh6LvL9KeYlXGfQL8hon9CbRAai6vGfA0tifoPZoi7WlCWzxNjzE
 Os7Y5I7gt80qX53sCGWgbAKuJdS87qgwWFtru+IesWPPt6dlIUCepZc/NUkpiFz6rPH+
 OIla3Eo486wyZKtk1CmKul2HLdAsnXblkX+y+ukRaSHm8fAQWhp/AnXRQ6FZSds/Xo1S
 OcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w5pl3TzQvaQVnyMYNeKi2uN7fk7InvWwzklZYoBOlQs=;
 b=pybBgYdmHOUNdyLbyi2oEWOOknYJh670jM/SHSozfuuPiuwBWJ4yq7wLbuIChCJNC/
 c71B2VYTaHRb/hBM+RYHVu3Z8WDAKRYShMkBKd+ItTGlj9FlhUlVlk6HNx1OFa3PgKBA
 ArcGsfeUF1r168Ycdym8qUKhZijXFmOiz15IP3+1KFm5kLd3QHrV6H1XuqGKgkjPhrj7
 nTFzbn781pYG9Cv9YUXmyIBKlYadEzg9obyzDraFwU69qHjuxNfKlFKQEMIWPq9AF1hw
 sRzwh9SJwxkuV9s8Wgtj1Sc/radc6A7vjvcusK9lw6Of/S0rRcIAC+Tcc7jAtjUqZj7p
 UDZQ==
X-Gm-Message-State: APjAAAWiXwHReR1ubBbAc2yUnOmZALpKzAsSDmINNnRcfQaIGjiZ4zXn
 FNEN6KCNHuYMK7zQzjqNllSv+fUwGOc=
X-Google-Smtp-Source: APXvYqzd+oGWCXam7t3UwdHZpSkTqh4gTv76VckK9mk5OcMqPdr+RBcHCDWE9MLln0rF8StBqTJgsA==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr4970537wrq.67.1581010270862; 
 Thu, 06 Feb 2020 09:31:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/29] qapi: Remove hardcoded tabs
Date: Thu,  6 Feb 2020 17:30:21 +0000
Message-Id: <20200206173040.17337-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
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

There are some stray hardcoded tabs in some of our json files;
remove them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Most of the hardcoded tabs got removed in passing in
fixing the indent in lines that they were in, but
these are not part of doc comments.
---
 qapi/block-core.json | 4 ++--
 qapi/migration.json  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 006a0bf7a7c..6cc8a4f73e0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2938,8 +2938,8 @@
             '*pr-manager': 'str',
             '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions',
-	    '*drop-cache': {'type': 'bool',
-	                    'if': 'defined(CONFIG_LINUX)'},
+            '*drop-cache': {'type': 'bool',
+                            'if': 'defined(CONFIG_LINUX)'},
             '*x-check-cache-dropped': 'bool' },
   'features': [ { 'name': 'dynamic-auto-read-only',
                   'if': 'defined(CONFIG_POSIX)' } ] }
diff --git a/qapi/migration.json b/qapi/migration.json
index aa160e9e42d..11033b7a8e6 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -98,7 +98,7 @@
 ##
 { 'struct': 'CompressionStats',
   'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
-	   'compressed-size': 'int', 'compression-rate': 'number' } }
+           'compressed-size': 'int', 'compression-rate': 'number' } }
 
 ##
 # @MigrationStatus:
@@ -713,7 +713,7 @@
             '*multifd-channels': 'int',
             '*xbzrle-cache-size': 'size',
             '*max-postcopy-bandwidth': 'size',
-	    '*max-cpu-throttle': 'int' } }
+            '*max-cpu-throttle': 'int' } }
 
 ##
 # @migrate-set-parameters:
@@ -845,7 +845,7 @@
             '*block-incremental': 'bool' ,
             '*multifd-channels': 'uint8',
             '*xbzrle-cache-size': 'size',
-	    '*max-postcopy-bandwidth': 'size',
+            '*max-postcopy-bandwidth': 'size',
             '*max-cpu-throttle':'uint8'} }
 
 ##
-- 
2.20.1


