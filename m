Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACA9C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2569206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqNQIeIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2569206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRAE6-0004BU-LS
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kR9uz-0002g8-Gq
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:07:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kR9ux-0007s7-A7
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 04:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602317269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xHqQnAwA7oXuSxTeGKkpLFQtNKGOeRfYuB4FhFcEEG0=;
 b=dqNQIeIQ5puHykhrg0kCoHXVmImefSIfFUQuyDnRFXJcaEjdxgCxIKzECtJpLyPACAjqix
 6H5TQrThQQVjcjWrWa+bHWTrKIMKGG3I3zaHqdyZsVGHMiBUrfimpM23vLljzf7kGx4ORv
 T9nZtufyxq0973CUBICJbhNMVJAzGJQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196--QzCNAZVNU2ZNv0SWq7GoQ-1; Sat, 10 Oct 2020 04:07:45 -0400
X-MC-Unique: -QzCNAZVNU2ZNv0SWq7GoQ-1
Received: by mail-wr1-f72.google.com with SMTP id u15so6264127wrn.4
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 01:07:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xHqQnAwA7oXuSxTeGKkpLFQtNKGOeRfYuB4FhFcEEG0=;
 b=dYSD2r0CJ16EAR/33l9DAtUDhsnAKw8aKW4PW4Y78X3IRICod74iaLyw5x1e9afrEm
 KleWKwQPfkGOHcmm+goTMZbjpuoDLm+UCdQ01Nk8Px5b0cTJAGCge25YotpsZJowW+0b
 sXiw6PwdvF8iMwExJmiQDKzkD+5kTqM3IDa0OLvtQ9kGlTnFQjw7/4nPgzNxMsyOMXQ7
 CsR/DGZF+n9XBJ9G4xK2pye0iVaVyERfSjn0DSusNCELxE4KmKsvCCEBaFsJ5SR8pdoq
 GJbvv88Ui9wNjsMwTyw2YebLN/YtOfe7dMCwf7MN+9W7Tirt00LgKLMxLA41WfpZkm0d
 b95A==
X-Gm-Message-State: AOAM533u3nJDNFucmWyXquxMNhTu+J3yjoG2CgoSh7b7uyJGJoCBXuoB
 3mpFlB+DLQXXWefh3jjnKKULB+SbTDQJGOI7R2Vkv19PkZljOBesc3SOKPMc23UILSTnLOCGzMy
 fHgDr4zjAi+00IDM=
X-Received: by 2002:a1c:8088:: with SMTP id b130mr1679156wmd.132.1602317264417; 
 Sat, 10 Oct 2020 01:07:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx70cAQzS/VoecjmTdwTk/mTMF8eBTCR1ZZCybe+HMwCVS95N6PgNzWef6XN/NSpLA0AkIdtQ==
X-Received: by 2002:a1c:8088:: with SMTP id b130mr1679136wmd.132.1602317264219; 
 Sat, 10 Oct 2020 01:07:44 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g83sm14695079wmf.15.2020.10.10.01.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2020 01:07:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] docs/devel/testing.rst: Update outdated Avocado URLs
Date: Sat, 10 Oct 2020 10:07:41 +0200
Message-Id: <20201010080741.2932406-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: avocado-devel@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avocado documentation referred returns 404 error.
Update the broken links.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/devel/testing.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index bd64c1bdcdd..23a1697d9f4 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -696,7 +696,7 @@ To manually install Avocado and its dependencies, run:
 
 Alternatively, follow the instructions on this link:
 
-  http://avocado-framework.readthedocs.io/en/latest/GetStartedGuide.html#installing-avocado
+  https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/installing.html
 
 Overview
 --------
@@ -879,7 +879,7 @@ Parameter reference
 To understand how Avocado parameters are accessed by tests, and how
 they can be passed to tests, please refer to::
 
-  http://avocado-framework.readthedocs.io/en/latest/WritingTests.html#accessing-test-parameters
+  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#accessing-test-parameters
 
 Parameter values can be easily seen in the log files, and will look
 like the following:
-- 
2.26.2


