Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC6CC4345D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15EB422B40
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 17:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2Z/MJGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15EB422B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyem8-0001nB-Am
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 13:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyelV-0001Jz-8Y
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:12:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jyelR-0007zn-Si
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 13:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595524332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tVqO/zUm8oBxk8F5vi2pyvX9bbKu7CPYJlBL+o34TT4=;
 b=S2Z/MJGjfYlXvINFDpo7uCzhzM2vyJ6KiumGlhTS+leKaiLJYxo1J6TVDN5FzVxsBuD7lc
 N7b4mZ2lVAYBlwQmYvQDaWcFi4ZUlNM/PTXByzHx2Jgm/yejw1BXdcxM6VQ+WwjtyMZp5H
 kiqVmHu37l3McvSzpW+xl3s3LD0D294=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-ixsQfMRoMxqwU9sya3K3bw-1; Thu, 23 Jul 2020 13:12:09 -0400
X-MC-Unique: ixsQfMRoMxqwU9sya3K3bw-1
Received: by mail-wm1-f72.google.com with SMTP id z74so2570791wmc.4
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 10:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tVqO/zUm8oBxk8F5vi2pyvX9bbKu7CPYJlBL+o34TT4=;
 b=nX4SXmN5sIFKmFzZKqpS/rbXzpJjihSXhkOwvZ2U2taxlvcTen3UZERFlBQA9nc2S3
 mpyIF8nDyCF3kkLY+H7T0pQG1qT0GhZFUmX/cq9JaKzboDIY0UxTUn8o4ELk2sYmnGfJ
 xXBOgk9brgbwQXqAbJqJoLLaf7/2NxuZcMU88N5xIfdz9kE6VXQO2id9NBeI1mqKiR5+
 4d+PZ0/JfKdVDdj9ToOr0G2XhB8o+AgTBh3D6+ar3ATesQAqhWAFyPcdlhiIQtS5QMHj
 WIsJzB373//reAucpWxh7jYdnTZp9l6cIeJNPI7bJrAUvfH+aC3k4hQKxa4DQtoxgey+
 ICng==
X-Gm-Message-State: AOAM532cvQEopBbbuFIfpGF/DjwC7Y6gFUWRVPDahoLwkiHfyLRwjvHH
 S+nJOTkqedk2275YizhxsTrUz3QfbHALODARPoEJZtcBZCUh7LVm5FJTBIJDg7AgJv5tUFFuJFx
 7boV6jLSc4YEsHTg=
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr5167149wmd.111.1595524328115; 
 Thu, 23 Jul 2020 10:12:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4GMa3PL9mu/4Jaa4JkgUGW3hi5ooaurXr/KwDPByrFhERPezK3iWy9Mn69KJg4oTE7ptX1Q==
X-Received: by 2002:a1c:80d3:: with SMTP id b202mr5167128wmd.111.1595524327887; 
 Thu, 23 Jul 2020 10:12:07 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id z16sm4398485wrr.35.2020.07.23.10.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 10:12:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1? v2] qapi/error: Check format string argument in
 error_*prepend()
Date: Thu, 23 Jul 2020 19:12:05 +0200
Message-Id: <20200723171205.14949-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:04:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

error_propagate_prepend() "behaves like error_prepend()", and
error_prepend() uses "formatting @fmt, ... like printf()".
error_prepend() checks its format string argument, but
error_propagate_prepend() does not. Fix by addint the format
attribute to error_propagate_prepend() and error_vprepend().

This would have caught the bug fixed in the previous commit:

    CC      hw/sd/milkymist-memcard.o
  hw/sd/milkymist-memcard.c: In function ‘milkymist_memcard_realize’:
  hw/sd/milkymist-memcard.c:284:70: error: format ‘%s’ expects a matching ‘char *’ argument [-Werror=format=]
    284 |         error_propagate_prepend(errp, err, "failed to init SD card: %s");
        |                                                                     ~^
        |                                                                      |
        |                                                                      char *

Missed in commit 4b5766488f "error: Fix use of error_prepend() with
&error_fatal, &error_abort".

Inspired-by: Stefan Weil <sw@weilnetz.de>
Suggested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Since v1:
- Reword (Markus)
- Add error_vprepend (Stefan)
- Use local style to add the attribute *after* the declaration,
  which is invalid on definition where we get (depending on the
  toolchain):

  . error: attributes should be specified before the declarator in a function definition

  . error: attributes are not allowed on a function-definition

Supersedes: <20200723091309.18690-1-philmd@redhat.com>
---
 include/qapi/error.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/qapi/error.h b/include/qapi/error.h
index 7932594dce..eaa05c4837 100644
--- a/include/qapi/error.h
+++ b/include/qapi/error.h
@@ -382,13 +382,15 @@ void error_propagate(Error **dst_errp, Error *local_err);
  * Please use ERRP_GUARD() and error_prepend() instead when possible.
  */
 void error_propagate_prepend(Error **dst_errp, Error *local_err,
-                             const char *fmt, ...);
+                             const char *fmt, ...)
+    GCC_FMT_ATTR(3, 4);
 
 /*
  * Prepend some text to @errp's human-readable error message.
  * The text is made by formatting @fmt, @ap like vprintf().
  */
-void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
+void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
 
 /*
  * Prepend some text to @errp's human-readable error message.
-- 
2.21.3


