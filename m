Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF8C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 09:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F6F2072D
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 09:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="WfUdZXVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F6F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9m0Y-0006LL-Ab
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 05:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k9m03-0005wD-0H
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 05:09:15 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51086 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1k9m00-0005YD-PH
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 05:09:14 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 7D52F542D0;
 Sun, 23 Aug 2020 09:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1598173747; x=
 1599988148; bh=wJ/2K3BgspuKgRFRYh1Qy4lgv1AI8fXCEnnDDkxSlOE=; b=W
 fUdZXVCfwsOEXH4zz9VoMEaaOEDRZ9t8vqh+dOKa9VdUIzgQ7HTqLhQJink/I+5X
 vQJFT/SRWxUatOHEeB1JvJ2blLnGeBOZdihItph+VYTjvdYZ/K8NX+rq2im/v7s2
 /M9DmyIgvtRuxHUDjcY3x1TF+TIeNItQZFAsvqDnUk=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWVQZWiL9xVp; Sun, 23 Aug 2020 12:09:07 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id BD43453929;
 Sun, 23 Aug 2020 12:09:07 +0300 (MSK)
Received: from localhost (10.199.0.58) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 23
 Aug 2020 12:09:07 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] meson: Don't make object files for dtrace on macOS
Date: Sun, 23 Aug 2020 12:05:47 +0300
Message-ID: <20200823090546.47957-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.0.58]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 05:09:10
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dtrace on macOS uses unresolved symbols with a special prefix to define
probes [1], only headers should be generated for USDT (dtrace(1)). But
it doesn't support backwards compatible no-op -G flag [2] and implicit
build rules fail.

1. https://markmail.org/message/6grq2ygr5nwdwsnb
2. https://markmail.org/message/5xrxt2w5m42nojkz

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Cameron Esfahani <dirty@apple.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 trace/meson.build | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

This is an update of the previous patch that is no longer valid due to
conversion of the build system to meson:
https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg02493.html

diff --git a/trace/meson.build b/trace/meson.build
index 56e870848e..1c1fb31a61 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -39,12 +39,15 @@ foreach dir : [ '.' ] + trace_events_subdirs
                                    output: fmt.format('trace-dtrace', 'h'),
                                    input: trace_dtrace,
                                    command: [ 'dtrace', '-o', '@OUTPUT@', '-h', '-s', '@INPUT@' ])
-    trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
-                                   output: fmt.format('trace-dtrace', 'o'),
-                                   input: trace_dtrace,
-                                   command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
+    trace_ss.add(trace_dtrace_h)
+    if host_machine.system() != 'darwin'
+      trace_dtrace_o = custom_target(fmt.format('trace-dtrace', 'o'),
+                                     output: fmt.format('trace-dtrace', 'o'),
+                                     input: trace_dtrace,
+                                     command: [ 'dtrace', '-o', '@OUTPUT@', '-G', '-s', '@INPUT@' ])
+      trace_ss.add(trace_dtrace_o)
+    endif
 
-    trace_ss.add(trace_dtrace_h, trace_dtrace_o)
     genh += trace_dtrace_h
   endif
 endforeach
-- 
2.24.3 (Apple Git-128)


