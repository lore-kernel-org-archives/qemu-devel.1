Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2C0C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F042084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 16:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxhCfxDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F042084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz0dt-0004D2-VP
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 11:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0cr-0003At-T2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iz0cq-0000Ki-OO
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:00:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:40801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iz0cq-0000FZ-H6
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 11:00:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id t14so4308434wmi.5
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=n+N9ZCxDyj94lQukako/uZ4xAZ4JqBTficyMVzgKSNk=;
 b=oxhCfxDYPAgiHXkZ4fD6mAjMLWo+BB/vAi40lI94j0MJ5LekMbJBnbXqIREyRwFPwW
 vf0NjkFBekJthX3owrxWhGANKTwCrKFcQjASYUFdNhADOgy73GClHMLeijpJz5BhcCHI
 tDsThIPDe10NpdNfrRkAMsYPtvZBmyaiZ/1Tes97a6vzCpbO6yYqaocIH8lA7JaU0CEQ
 5EQOAdH/woouC0VwYQvTjc3PiHP7NZobErxk0fcoCZwnjELxmMkIwdLOMm/0ZX35/fgo
 GWmi9somaEwT9Zww8x6/ffRLaJT79oPBY3e/j3kHQI/uZvo/3SXn+XrRv4on5PTqopgl
 dhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=n+N9ZCxDyj94lQukako/uZ4xAZ4JqBTficyMVzgKSNk=;
 b=fmS7YmFIQ8wkS7i9+/ZT6meJ8GXO53kJ2UdKN2eZ9S5nB07Y2c256oa76D14x6GxnU
 23JLEl9v2mQaE6n12Sipe+BA+oQfDcJmrXcr2OPRob1KPz+SF1IF2gWbvY5nj3LTBxfN
 hhYYQ+8b4tfBsWOw/UdvdgBpTV2BOxQCvBRH6ETo9x+tOiEKWfnMVSFqKIdJYEKwJfKU
 IZU49kM19xTUS6jKbrXVBCg0VQYdODNP0v0V0bmD4WLVWlqtZ7TNSebFyXxi+qXCsWGI
 4l4v4GOtXvPfyR/DRAUxp7NM3MM3myn7f+u0KHO3vY28aNHLSp3K//lz6/IhtmzYFim/
 Slow==
X-Gm-Message-State: APjAAAVXGgjL2THUmsOWj7sQ/uZNbjrpAmN0nCLxD+fAzv+b+XLtvziz
 z7YRVk7Sj29L44I3n5A/3+tXK/hE
X-Google-Smtp-Source: APXvYqzUOPwSm/ofVCIanOxGCjyksKB3/a/kLrLpISoXcQqkSZx+wGJaZ2XD/YfRJdKzLdO4YjsC7w==
X-Received: by 2002:a05:600c:251:: with SMTP id
 17mr6428321wmj.59.1580832030733; 
 Tue, 04 Feb 2020 08:00:30 -0800 (PST)
Received: from donizetti.redhat.com ([151.20.243.54])
 by smtp.gmail.com with ESMTPSA id 21sm4196795wmo.8.2020.02.04.08.00.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 08:00:29 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/signrom: remove Python 2 support, add shebang
Date: Tue,  4 Feb 2020 17:00:28 +0100
Message-Id: <20200204160028.16211-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: <20200130163232.10446-1-philmd@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/signrom.py | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/scripts/signrom.py b/scripts/signrom.py
index 313ee28a17..9be5dab1cf 100644
--- a/scripts/signrom.py
+++ b/scripts/signrom.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+
 from __future__ import print_function
 #
 # Option ROM signing utility
@@ -44,14 +46,8 @@ fout.write(data)
 
 checksum = 0
 for b in data:
-    # catch Python 2 vs. 3 differences
-    if isinstance(b, int):
-        checksum += b
-    else:
-        checksum += ord(b)
-checksum = (256 - checksum) % 256
-
-# Python 3 no longer allows chr(checksum)
+    checksum = (checksum - b) & 255
+
 fout.write(struct.pack('B', checksum))
 
 fin.close()
-- 
2.21.0


