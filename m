Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEFEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7884B20835
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 00:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="c8XyFkDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7884B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjXTp-0008EZ-LY
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 20:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jjXSu-0006yy-9r
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 20:22:36 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:33206)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jjXSr-0001I8-LP
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 20:22:36 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id 18B39444F3;
 Fri, 12 Jun 2020 10:16:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1591920973;
 bh=4mBB536DbAS9sE4vqkezGeotRfzVhV6sbOAIDj85Mv8=;
 h=From:Date:Subject:To:Cc:From;
 b=c8XyFkDeNelzVT9lickZk8+qtF4bLp/GbNEuWVCViYxRYb6EHtXvv9pcfuxgS7Sox
 C1nd6CwM3RH2dAnscdv5gy8Y880y5IahiD+U9/QUw2VNtp3jUWg+Sp1Q3As+wiaIlr
 UjMqWhhk/mecRAGbALnwlcWXs5bVLdNGVCZd5ZIc=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id EE1AF3A06BF; Fri, 12 Jun 2020 10:16:12 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
Date: Fri, 12 Jun 2020 01:25:16 +1000
Subject: [PATCH 6/6] audio/jack: simplify the re-init code path
To: <qemu-devel@nongnu.org>
Cc: <kraxel@redhat.com>
X-Mailer: mail (GNU Mailutils 3.5)
Message-Id: <20200612001612.EE1AF3A06BF@moya.office.hostfission.com>
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 20:16:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
---
 audio/jackaudio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index b2b53985ae..72ed7c4929 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -395,6 +395,10 @@ static int qjack_client_init(QJackClient *c)
     char client_name[jack_client_name_size()];
     jack_options_t options = JackNullOption;
 
+    if (c->state == QJACK_STATE_RUNNING) {
+        return 0;
+    }
+
     c->connect_ports = true;
 
     snprintf(client_name, sizeof(client_name), "%s-%s",
@@ -485,9 +489,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
     QJackOut *jo  = (QJackOut *)hw;
     Audiodev *dev = (Audiodev *)drv_opaque;
 
-    if (jo->c.state != QJACK_STATE_DISCONNECTED) {
-        return 0;
-    }
+    qjack_client_fini(&jo->c);
 
     jo->c.out       = true;
     jo->c.enabled   = false;
@@ -523,9 +525,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
     QJackIn  *ji  = (QJackIn *)hw;
     Audiodev *dev = (Audiodev *)drv_opaque;
 
-    if (ji->c.state != QJACK_STATE_DISCONNECTED) {
-        return 0;
-    }
+    qjack_client_fini(&ji->c);
 
     ji->c.out       = false;
     ji->c.enabled   = false;
-- 
2.20.1


