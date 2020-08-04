Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3DDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:31:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10957206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 08:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqJXKxQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10957206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2sMK-0005BK-6R
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 04:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2sLQ-0004eg-A9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:30:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38859
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k2sLO-0000tA-Iu
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 04:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596529845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qJyLfH0SE7cELoGLuVcpGHeOCoHxxtifd6T1uceBMKY=;
 b=NqJXKxQ3xiZCe/Cd8PTqstOackP+rq7+/L2rbLkLeQ0ilpZnLYCWmXZ5ojMjKTlBDBfsKn
 sQUT/oay3+1UW/1/DMDLA8BVaKX5lmtdDpYUU4tjgyO/t34i68eJFa5qSjJlUXh8xCxIbP
 saRJCyqvA5E1hzww43SpF67T8S9HxIU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-i1gseuDFNO6JqQUG2OAr6w-1; Tue, 04 Aug 2020 04:30:43 -0400
X-MC-Unique: i1gseuDFNO6JqQUG2OAr6w-1
Received: by mail-ej1-f69.google.com with SMTP id i4so293385ejk.9
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 01:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=qJyLfH0SE7cELoGLuVcpGHeOCoHxxtifd6T1uceBMKY=;
 b=VIvFwgBpvxOkwXLTP1YhUytgooDxeiqELZiqicTThSvEiyDtSYX7BGcgivZ4gY+5Kt
 FXILrtmhqA7cl7kFSMD4OfkaFB7HR+s6fstKV9aIEpxnLB46GmJVi7DXbm+R2ZXMn5GR
 C1v13TDibTSt85YvKqO94/BN58ihzR7NGjUoBLJrAiPO2npXdu7hpTc51d5W8vpsW3v7
 FVGK9IywFYtEAk0Tg8ohI1B5RLr4G8YSg2dhZIWouzHRY3KYYfSIOI4ko23k4AnBi6k3
 Oj6erRbsJuQy/CbV0NNH8NZ7UE+dolAEV4qeicu3/E8AkG9uhg5MGOamOEAv9nKB46sS
 aABg==
X-Gm-Message-State: AOAM531AMP93Gvarouvpku6MschvKSzkkmBt1ZbZR6bwKEDV8paGISDm
 cYXj2XicNp5KeF8spnsKYuha5TY/RW1Fy/OxVUxTZAf7Izlrjb1Z9bmj+MaEnx3VuRp6p4WUpGq
 CFPKZrw78sSB9cd8=
X-Received: by 2002:a50:eb92:: with SMTP id y18mr4314831edr.51.1596529842266; 
 Tue, 04 Aug 2020 01:30:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzklrTU9ocjqU1aaApeNStMv2k33YbmiAjdYneQJaMIY6qgfqe/jDCgnYvVYREFzoNafbvH1A==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr4314812edr.51.1596529842060; 
 Tue, 04 Aug 2020 01:30:42 -0700 (PDT)
Received: from x1w.redhat.com (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id a16sm17705852ejy.78.2020.08.04.01.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2020 01:30:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1] .travis.yml: Deprecate it in favor of GitLab CI
Date: Tue,  4 Aug 2020 10:30:40 +0200
Message-Id: <20200804083040.24659-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: libvir-list@redhat.com, Fam Zheng <fam@euphon.net>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As of QEMU 5.2 we prefer to focus our CI development on GitLab.
Mark Travis-CI as deprecated (adding a big warning).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 docs/system/deprecated.rst | 11 +++++++++++
 .travis.yml                |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 851dbdeb8a..c17a5b0896 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -17,6 +17,17 @@ they were first deprecated in the 2.10.0 release.
 What follows is a list of all features currently marked as
 deprecated.
 
+Build and test automation
+-------------------------
+
+``Travis-CI`` (Since 5.2)
+'''''''''''''''''''''''''
+
+``Travis-CI`` is deprecated in favor of GitLab-CI.
+
+The '.travis.yml' configuration should only be modified to remove jobs
+when equivalent exist on GitLab-CI. Adding new jobs is not allowed.
+
 System emulator command line arguments
 --------------------------------------
 
diff --git a/.travis.yml b/.travis.yml
index 6695c0620f..4ad243f511 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,3 +1,10 @@
+#  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
+#
+#  As of QEMU 5.2, this file is now deprecated in favor of GitLab CI.
+#  Do not modify, except to remove jobs ported to GitLab CI.
+#
+#  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING  WARNING
+
 # The current Travis default is a VM based 16.04 Xenial on GCE
 # Additional builds with specific requirements for a full VM need to
 # be added as additional matrix: entries later on
-- 
2.21.3


