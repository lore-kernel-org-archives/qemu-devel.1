Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB098C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32A220738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 20:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="kyVlr+X9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAfaH-00087U-TF
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 16:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAfY9-0005YM-5S
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:28:09 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35316 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAfY4-0006OQ-Up
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 16:28:08 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 9897457057;
 Tue, 25 Aug 2020 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-transfer-encoding:content-type:content-type:mime-version
 :references:in-reply-to:x-mailer:message-id:date:date:subject
 :subject:from:from:received:received:received; s=mta-01; t=
 1598387282; x=1600201683; bh=V0615/o4rDYJWyo2Vh9bJHGyTvqVrxlhmHO
 XQGtLiOQ=; b=kyVlr+X9dTUbmrA3M53Hm0o0kAHpaHPButXC1mIlBZHvtIwTABC
 pEvnYZ/lXGo6b9bf1W7ZwiwabQQhUsTOu/1IWlmrMSqB0+zgZZNmHfMqmUWfGrB5
 zpWjwJjwwOJo/xM3w+IqyZdXUBOJNUJ2X0dcaylBJ0tTC6sIm7Y5NS08=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6cWmjN2YdHJx; Tue, 25 Aug 2020 23:28:02 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id C270557505;
 Tue, 25 Aug 2020 23:28:01 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Tue, 25
 Aug 2020 23:28:01 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 4/4] configure: Test if $make actually exists
Date: Tue, 25 Aug 2020 23:27:55 +0300
Message-ID: <20200825202755.50626-5-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825202755.50626-1-r.bolshakov@yadro.com>
References: <20200825202755.50626-1-r.bolshakov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 16:28:01
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

configure doesn't detect if $make is installed on the build host.
This is also helpful for hosts where an alias for make is used, i.e.
configure would fail if gmake is not present on macOS.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
---
 configure | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configure b/configure
index 664084992b..9230832da2 100755
--- a/configure
+++ b/configure
@@ -2029,6 +2029,10 @@ if test -z "$python"
 then
     error_exit "Python not found. Use --python=/path/to/python"
 fi
+if ! has "$make"
+then
+    error_exit "GNU make ($make) not found"
+fi
 
 # Note that if the Python conditional here evaluates True we will exit
 # with status 1 which is a shell 'false' value.
-- 
2.28.0


