Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC128C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857672074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 08:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="sITrZXmm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857672074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvz6r-0000PP-Nd
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 04:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jvz66-0007bi-Vy
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:18:31 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:43072 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jvz65-0008QR-9q
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 04:18:30 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 05A424C902;
 Thu, 16 Jul 2020 08:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1594887506; x=1596701907; bh=nkNZsz7/JkOV/cy6qwKLx+4fdJUxZ+Y0cXW
 zs1V9bwQ=; b=sITrZXmmHrSZ6k9Pho5SzkUQQBNp5bsodqwuv7qSmXGtsJp6T16
 LpnXK2VrrBytWv00WSwKwMFdHoMqZMuto7ToBE/buPrXmPc0RFsyuVlpbNh/+lQn
 kRurUB10rCNox2GOb2Lg9A6zx+uskKuq0UitHnXCCHbuU2ZzQVbro9tc=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IV_gzIq2UEke; Thu, 16 Jul 2020 11:18:26 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id D2D8E4C83C;
 Thu, 16 Jul 2020 11:18:26 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 16
 Jul 2020 11:18:26 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] scripts/tracetool: Fix dtrace generation for macOS
Date: Thu, 16 Jul 2020 11:17:51 +0300
Message-ID: <20200716081754.22422-2-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200716081754.22422-1-r.bolshakov@yadro.com>
References: <20200716081754.22422-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:18:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dtrace USDT is fully supported since OS X 10.6. There are a few
peculiarities compared to other dtrace flavors.

1. It doesn't accept empty files.
2. It doesn't recognize bool type but accepts ANSI C _Bool.

Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 scripts/tracetool/format/d.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index 0afb5f3f47..be4a2aa254 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -13,6 +13,7 @@ __email__      = "stefanha@redhat.com"
 
 
 from tracetool import out
+from sys import platform
 
 
 # Reserved keywords from
@@ -34,7 +35,8 @@ def generate(events, backend, group):
 
     # SystemTap's dtrace(1) warns about empty "provider qemu {}" but is happy
     # with an empty file.  Avoid the warning.
-    if not events:
+    # But dtrace on macOS can't deal with empty files.
+    if not events and platform != "darwin":
         return
 
     out('/* This file is autogenerated by tracetool, do not edit. */'
@@ -44,6 +46,11 @@ def generate(events, backend, group):
     for e in events:
         args = []
         for type_, name in e.args:
+            if platform == "darwin":
+                if type_ == 'bool':
+                    type_ = '_Bool'
+                if type_ == 'bool *':
+                    type_ = '_Bool *'
             if name in RESERVED_WORDS:
                 name += '_'
             args.append(type_ + ' ' + name)
-- 
2.26.1


