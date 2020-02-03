Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12A9C3524E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A3D2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyBh9e4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A3D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyXlx-00031N-Tj
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47672)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjh-0006U8-8s
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iyXjf-0000si-Vh
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:37090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iyXjf-0000qR-Pc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:09:39 -0500
Received: by mail-wm1-x32c.google.com with SMTP id f129so15977957wmf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u6yIuf1UsBQnjA5NOgVX0/eCNysWnIhl9yRu6xx8hY0=;
 b=iyBh9e4rv4BNt/Mjk1osCUxPPb67n0/v+8Dj30yWNizdbmlEPbT7QSu0GwMCDYmezM
 1jlxG8juJC+fA1NEPSIf0HSAaEMYZwPeF0Zl3QUB8PjPYmlm+gcX1DmnOfvmq2XEE3vT
 oLixBu9tIQdblCOXxsn/xQdnzC6lnghDc8xkZLaWc2kbv2O6nJWx/SkTR0dqAiF6DBN7
 Kx2blSl0EixSi4g7Nps9LW6rH1Q2lb0m8AcH2TQt88CIMm+l3XXyC5E7gAAIHPtlGmzp
 IGNIXXs8h287gnmwPktjoA1Dkpo+Rn2AQSIJOFIpWFMFWMKvzH8qidrFKUH7yW7UB4ey
 mY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u6yIuf1UsBQnjA5NOgVX0/eCNysWnIhl9yRu6xx8hY0=;
 b=FtLmPOQXTYhhCBeEfTREuDyYqACFyMnECtDew5/LNu/h3M+bJN7lSZgiQ8QOzXgu4X
 2Tcv18QT17EXT5kpjIbDqnqVY2icDJCNazUzW500g6SgsTpaTLrPpurJbjzrKpk8kjoN
 ErPMBfKhiNJ6XJkr4dE/R1CcuhU9FT51MTIJb3zgotdHwOmMdwkOZdPD5UrBQYyw1QR2
 8CiNzOc6/e9MFJAx6uVyTLlQnf9n0sy/OO1ovDa9im56XDjS9ncHyt7FlznKc2ljSL0Q
 ATFPrs6hObgjlStlC9EPmaN0ZtxM4F4hiwRE/ASumodi8p57/PiMaYSvtftdBhPL6zDa
 Q/tQ==
X-Gm-Message-State: APjAAAUaWiL+uNRDp8FqEki3/3IJEsg4g3m6r90dYWbLfCr1SGgfn7bL
 u0kKje6c4qGIMDwp0bmUehawcw==
X-Google-Smtp-Source: APXvYqwpFWCtUYgH8N0he/fRKG1VfmXqSNOHgBiAMwJZU7vAKBUnB1FrWvGuppiRKbmWW5sfSDP8lQ==
X-Received: by 2002:a1c:df09:: with SMTP id w9mr26220319wmg.143.1580720978691; 
 Mon, 03 Feb 2020 01:09:38 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x7sm24483380wrq.41.2020.02.03.01.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 01:09:35 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 983691FF90;
 Mon,  3 Feb 2020 09:09:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 03/17] gitlab-ci: Refresh the list of iotests
Date: Mon,  3 Feb 2020 09:09:18 +0000
Message-Id: <20200203090932.19147-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203090932.19147-1-alex.bennee@linaro.org>
References: <20200203090932.19147-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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
index 228783993e5..c15e394f09a 100644
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


