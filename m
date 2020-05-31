Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFDDC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 621BA2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VK0pEc+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621BA2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfR4W-0001TU-Ef
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQzb-0001Aj-6j
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfQza-0006hA-A1
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z30VvxAdMFSGdKMqEcqqUvnaAOKiyK2ObUonHxxh/Vo=;
 b=VK0pEc+U32sXaS/XI22yRdHsemPkGU09nPaFU3JYVmDB9pBhyV+TSQkawZXC/DXJTCVCOS
 g5ymL/awY/iD09uiMoQ4ljbwsseMVwF1cXbFORqrmlypoasGQOfVTKuQ8himpA6kccn4JN
 GTGNpEYvPWw5vZRZfo2WSCSwsUUMa7Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-osGQnmjkP9OJKBYOu3oiaQ-1; Sun, 31 May 2020 12:39:16 -0400
X-MC-Unique: osGQnmjkP9OJKBYOu3oiaQ-1
Received: by mail-wr1-f72.google.com with SMTP id e7so3139123wrp.14
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z30VvxAdMFSGdKMqEcqqUvnaAOKiyK2ObUonHxxh/Vo=;
 b=nfZnEX1amM/xyjnZi/lQ7P6d08mHgt6eI9yuZ8NBlGuHxLRkLepNsSUN/j+ZDOGKuk
 9EPJozozn+391+jnoZ4k7ogQWomt5i/qJ53OdQjOpWtI7xJyYWZRh7N28kpaIzFrTH3e
 W7BYKz06p+pEG+xUJqPy3OIl/MXgpoICcqXCVB4H95VqQizdDxv5dSISmbUKA4o+memW
 nJSIoiDT5uF1rLMl6AxIC3EgkcH7v4xBUf2Izfj67UKINZObB6FVZiZ4XqAEfIK78V6S
 LZB0EMuOFqEwi9Sen0Fi1lM9zon49DpJiUuakk5MIiXkLLmSOEVfBaFeoLKuVcdDbab2
 4tGw==
X-Gm-Message-State: AOAM5319XgOjvCUo3jmgEUUeL+wz1mkVvzxvApQHJQ4reh0ER9AXzRnh
 Wam6dV4Jf6lmNOy8zL7tdpHu2hb93dl7IRFve2jogn0kysCe4KVF77UscbbJKyrL59s2v30Phpx
 mlzbj1y5rOYyrCWc=
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr16889176wmp.7.1590943155577; 
 Sun, 31 May 2020 09:39:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOLd8dSnD3qnmQhUEm/Dn1hZEFh70mX5LIcVUN2qnXfZwKc4kvuMmAfTDZzOM7VoEzCzWu+g==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr16889160wmp.7.1590943155392; 
 Sun, 31 May 2020 09:39:15 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id l204sm9390658wmf.19.2020.05.31.09.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:39:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/25] scripts/modules/module_block: Use Python 3 interpreter &
 add pseudo-main
Date: Sun, 31 May 2020 18:38:26 +0200
Message-Id: <20200531163846.25363-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:39:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200512103238.7078-6-philmd@redhat.com>
---
 scripts/modules/module_block.py | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/scripts/modules/module_block.py b/scripts/modules/module_block.py
index f23191fac1..1109df827d 100644
--- a/scripts/modules/module_block.py
+++ b/scripts/modules/module_block.py
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 #
 # Module information generator
 #
@@ -80,19 +80,20 @@ def print_bottom(fheader):
 #endif
 ''')
 
-# First argument: output file
-# All other arguments: modules source files (.c)
-output_file = sys.argv[1]
-with open(output_file, 'w') as fheader:
-    print_top(fheader)
+if __name__ == '__main__':
+    # First argument: output file
+    # All other arguments: modules source files (.c)
+    output_file = sys.argv[1]
+    with open(output_file, 'w') as fheader:
+        print_top(fheader)
 
-    for filename in sys.argv[2:]:
-        if os.path.isfile(filename):
-            process_file(fheader, filename)
-        else:
-            print("File " + filename + " does not exist.", file=sys.stderr)
-            sys.exit(1)
+        for filename in sys.argv[2:]:
+            if os.path.isfile(filename):
+                process_file(fheader, filename)
+            else:
+                print("File " + filename + " does not exist.", file=sys.stderr)
+                sys.exit(1)
 
-    print_bottom(fheader)
+        print_bottom(fheader)
 
-sys.exit(0)
+    sys.exit(0)
-- 
2.21.3


