Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F09C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D92206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 17:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZg4x9at"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D92206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Il6-0002KU-QC
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 12:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33856)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijd-0000Ux-51
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ija-0002du-Ub
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:55109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ija-0002cH-Ny
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:06 -0500
Received: by mail-wm1-x32a.google.com with SMTP id g1so7246285wmh.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VQc7coEXjD/CTx7TtXjHvTSiKBr3RUfeg+AIAbQDHCI=;
 b=kZg4x9atRG1/nKaacg5/a9gSGsZLc/zqZIJBt9TFSvsuZljuLYhh/rW+l6jmp7n1YC
 5zAaxDOIwOw+bxAYG1nkell76ttDDiJd21hi6nYgM1yH9ZfmYSDjAt/k+qyRPPUZ1MVK
 rpqsgUIRKcewwWm1TuQEtGHNgGKoKeB+bBVyopXb1AjwhHp1U0JgQwXrkiWOB2nkxBIe
 NX0maEJXU9sL9joCgDqwwNflnXE9qC1W9rA2OcI+lIHLSYeUYSAKb08FbTEfpMmLumq8
 SLhQKxZ9aRzpnj1w7CV/uT3bOs954oKsTXlAhlsNZTlwkgnRgVV7NOupQSRdpJDtbMSG
 VcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VQc7coEXjD/CTx7TtXjHvTSiKBr3RUfeg+AIAbQDHCI=;
 b=DOlZT9qloI9MxPNCCv5TXaEQR9mbWWq2cD6VRvJL5itO3xif/kL1j2Ss0KhUj5RkPA
 ScBQN0mwB4TXHGBW+z1/lP1+Ii6mJLoRWEgasGjRLrxLUJ0HakQChlZ2XNgnOOPbwpYn
 WQlHVfZK1dpEAnRLdH1ufOdUErGq5qdadicO4n/pYYenLIxWbbP0KkIHP/qh3lvNDAPo
 Rtmk6DADi8pU3YhvW1fj9GIGcdJq/ZvSy4JumsDJ8dJwY8a0CpuH9jy9WdOO3SWkAuA3
 eU6Hi3MaFLFEUuKj+fda2IZkEGVh3gaEFauSq/lFD+rcggYZ0ovHssDx1F7CL9tx9hgQ
 Sxnw==
X-Gm-Message-State: APjAAAWc2KbquoLa38j0RnwK8NB7nnPpERRZhH94oHD+ViMYhHsV6M+d
 gImdrQlOJUrmuM/503CQdPIAPoZ99h0=
X-Google-Smtp-Source: APXvYqxHBlcZgPmcfNTXohDrcoeWfB61I5PBsk2j4hlxm98iAteZeVQZRALqOQAr/ok2tL3xqCKe9w==
X-Received: by 2002:a7b:cbcf:: with SMTP id n15mr6930192wmi.21.1581616625486; 
 Thu, 13 Feb 2020 09:57:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/30] qapi: Remove hardcoded tabs
Date: Thu, 13 Feb 2020 17:56:27 +0000
Message-Id: <20200213175647.17628-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
Most of the hardcoded tabs got removed in passing in
fixing the indent in lines that they were in, but
these are not part of doc comments.
---
 qapi/block-core.json | 4 ++--
 qapi/migration.json  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index c62b7db2814..31f7a1281c6 100644
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


