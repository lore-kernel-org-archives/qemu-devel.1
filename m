Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F0BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F74F2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 20:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pF06MuQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F74F2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv5m1-00017T-Jl
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 15:41:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kp-0007wc-34
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iv5kn-0005nL-TG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:35 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:42493)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iv5kn-0005mA-NA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 15:40:33 -0500
Received: by mail-wr1-x433.google.com with SMTP id q6so3562075wro.9
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 12:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DM/iBTyh2fgUt8WZi/uAjOeBrV5p8xgv4SqZb7PmcyM=;
 b=pF06MuQlTiebqtsEadqxlyao3qzmI6AAe3dPUg+pUb2X2thZCN6+MNOJe2GV0jieJj
 IhpUR5ufOoL83G+rSW/dVTZLhkT3qxTGNOwrNg2xrb9WlKuTJhoUd8/OZR3ekjbETWBn
 EKb/h7d/2r9EcUnX2IZKP1b/rAT3fNghX8WflRGnFLYJsapio/5G7OoIYE6Tl9hDoSjK
 45/OKFD9IzULOoSk9DuBi4nFthl+77WSuTTzIXxypHCAZwVpN+jIiTHiEMNYokjg94TT
 qCl3DHDn6MkuuTWyMY1fn5pr4+5Ie2b9imMMukBkoRq+9mZtowHLhAXBn5qaxIoQXCM4
 T7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DM/iBTyh2fgUt8WZi/uAjOeBrV5p8xgv4SqZb7PmcyM=;
 b=I6doA3bzhGZnNVXwg4He7CEpK3LO2Q6t6LAFgPeYUc1grAV/Et57ZJGeBV/us3W2lC
 zLcuW1MOr4CVcIKnYmQ9Wa83dDW3C+EJZ6jBD9PPlhut5K1LdqKHZUbIEj682wFEdsXy
 qOhdGcmICxElLok32HvK0lzg6nu1gO78LZinrkVTZ6eaC+PAkIRBnDfxHuzfGcwTD9aI
 38yN44jnU3oWyoSS1AR/1N+34Y5fC0sH6BmNioqMX1r+jjA06d59TqXx11OzWSoBMx2M
 iK6huVnyVGKR1sMq+f0AriSFDGL7Emfg/QD8BouMqpoUxVc84Rk7jOczIpDqkcAVFKg/
 bi+g==
X-Gm-Message-State: APjAAAVOFSpaFnL4ocppN2Hhiju+mdNYASZbRBZLoCQRWUh4eZf/Pdle
 jxk55C0EkdJd+55jtcEKe6qr4w==
X-Google-Smtp-Source: APXvYqxa3CE2Mzl0NbIS7x3erYeX/6g7F1yFTJUKeveVB5DgnOzp0H4YnNxNyMxm2JtGHMSpC5epeg==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr5972566wrt.4.1579898432037;
 Fri, 24 Jan 2020 12:40:32 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f1sm9052872wro.85.2020.01.24.12.40.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 12:40:27 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AA0461FF90;
 Fri, 24 Jan 2020 20:40:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 03/13] gitlab-ci: Refresh the list of iotests
Date: Fri, 24 Jan 2020 20:40:16 +0000
Message-Id: <20200124204026.2107-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124204026.2107-1-alex.bennee@linaro.org>
References: <20200124204026.2107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

iotest 147 and 205 have recently been marked as "NBD-only", so they
are currently simply skipped and thus can be removed.

iotest 129 occasionally fails in the gitlab-CI, and according to Max,
there are some known issues with this test (see for example this URL:
https://lists.nongnu.org/archive/html/qemu-block/2019-06/msg00499.html ),
so for the time being, let's disable it until the problems are fixed.

The iotests 040, 127, 203 and 256 are scheduled to become part of "make
check-block", so we also do not have to test them seperately here anymore.

On the other side, new iotests have been added to the QEMU repository
in the past months, so we can now add some new test > 256 instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200121131936.8214-1-thuth@redhat.com>
---
 .gitlab-ci.yml | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 228783993e..c15e394f09 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -54,12 +54,12 @@ build-tcg-disabled:
  - make check-qapi-schema
  - cd tests/qemu-iotests/
  - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
-            052 063 077 086 101 104 106 113 147 148 150 151 152 157 159 160
-            163 170 171 183 184 192 194 197 205 208 215 221 222 226 227 236
- - ./check -qcow2 028 040 051 056 057 058 065 067 068 082 085 091 095 096 102
-            122 124 127 129 132 139 142 144 145 147 151 152 155 157 165 194
-            196 197 200 202 203 205 208 209 215 216 218 222 227 234 246 247
-            248 250 254 255 256
+            052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
+            170 171 183 184 192 194 197 208 215 221 222 226 227 236 253 277
+ - ./check -qcow2 028 051 056 057 058 065 067 068 082 085 091 095 096 102 122
+            124 132 139 142 144 145 151 152 155 157 165 194 196 197 200 202
+            208 209 215 216 218 222 227 234 246 247 248 250 254 255 257 258
+            260 261 262 263 264 270 272 273 277 279
 
 build-user:
  script:
-- 
2.20.1


