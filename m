Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6958C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B078020758
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5BivysU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B078020758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTQ0-00042t-VP
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJy-0001Nm-Bg
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56859
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTJw-0004qh-IA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j02F5ic5GFszUU2+6LTrgWj0JvABR23KJP15O63NAeA=;
 b=f5BivysUbIOP4tayQCTcroxZmBjTwINYdpCkH3yAla2FgYBjj1xJbtmGWhrEVd4zQ+8TtI
 xfDcS2xjqzA9ciDOcek91h3ZRXMU6YA1ZyhrStmEP7U8tugGBvMo4w7Z+/7pK4HrtVwAZh
 +47c9H90Cfw/2Jg76lsvtmUN3CVexrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-qKW3wQuIMQ6w2foK1v45mg-1; Tue, 14 Jul 2020 18:22:37 -0400
X-MC-Unique: qKW3wQuIMQ6w2foK1v45mg-1
Received: by mail-wr1-f69.google.com with SMTP id i14so18551wru.17
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j02F5ic5GFszUU2+6LTrgWj0JvABR23KJP15O63NAeA=;
 b=s8vBT42gVYQ+7gopXCPXfXBZV4owFE2mogvdxMxv2Mr/yld0CtfhhNGphFyUsZrul7
 c6Ab8AcN8zl+lLkOJ7LDoVvFrKNIteqvqKpkLDTTsZpMYIrhkOgkXgzP8M//IzaAgSdC
 A8wUIQ6HZsPsO2vd5/sUYGvNTXHTseuim6GPr6KPQnDVvxRTZbVaUwksOYoql2a7vSPs
 WxCADXmtvEUhybJiHmbIIKZYUjSLFLUH0waY0jJoHsONmuWnnx5VXU1rlAWgXgdKlLpA
 pRqsifsAPdXZbsAXVMkpcz2mD2G9aIJVuXWf793rIpYDVCoZEV/BTgvcen2Acgiv2I+X
 h28A==
X-Gm-Message-State: AOAM533w48axILcqMPWCsvGUvGFILhMnQITLiwMeaX7AEhojFHPlWPcM
 U0RWKXZXasz56DGAEeWcizJDPnCTVrPZOe6x92Fzg2mt+bqZ5mh/XSy/UsaYQJtDZkjPmteeB9C
 8LU+u+b7D+DD+b4c=
X-Received: by 2002:a1c:7f82:: with SMTP id a124mr5465654wmd.132.1594765356326; 
 Tue, 14 Jul 2020 15:22:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvC7OqoVsBQA0sERYprgjXmkhrNV6Tou5Y09ZSqk6LiCFWVwLqhTg6huEvyc6bFAdtz29q1w==
X-Received: by 2002:a1c:7f82:: with SMTP id a124mr5465640wmd.132.1594765356084; 
 Tue, 14 Jul 2020 15:22:36 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y16sm164008wro.71.2020.07.14.15.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 13/19] python/machine.py: change default wait timeout to 3
 seconds
Date: Wed, 15 Jul 2020 00:21:26 +0200
Message-Id: <20200714222132.10815-14-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Machine.wait() does not appear to be used except in the acceptance tests,
and an infinite timeout by default in a test suite is not the most helpful.

Change it to 3 seconds, like the default shutdown timeout.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200710050649.32434-13-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/machine.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 736a3c906f..69055189bd 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -486,12 +486,12 @@ def kill(self):
         """
         self.shutdown(hard=True)
 
-    def wait(self, timeout: Optional[int] = None) -> None:
+    def wait(self, timeout: Optional[int] = 3) -> None:
         """
         Wait for the VM to power off and perform post-shutdown cleanup.
 
         :param timeout: Optional timeout in seconds.
-                        Default None, an infinite wait.
+                        Default 3 seconds, A value of None is an infinite wait.
         """
         self.shutdown(has_quit=True, timeout=timeout)
 
-- 
2.21.3


