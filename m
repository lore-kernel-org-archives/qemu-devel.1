Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89EFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 02:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939B420823
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="iahvWvhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939B420823
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjZ49-0006pT-SA
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 22:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geoff@hostfission.com>)
 id 1jjZ3H-00056T-Ds
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 22:04:15 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:34030)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geoff@hostfission.com>) id 1jjZ3F-0004sD-SQ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 22:04:15 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id 3EB1B443E9;
 Fri, 12 Jun 2020 12:04:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1591927451;
 bh=BTNWhWjpxI/xGtBTerQqtN0TeU/W0mUOO+TVisdGLMA=;
 h=From:Date:Subject:To:Cc:From;
 b=iahvWvhqZhxQUAg64Csg6GVscKYWkbl9zRBK/TLrNNXq+xSNPpA2kpyPB2mlZhVkX
 cojy8yuRuQ4G/wTlSU4A8HMR9fl4Dn13XzCvoI7ftIBA8Vyhy3jflIcd3SYh7+ymxT
 qQS5NT1bwovv841zMal0PwEBQLBePY/MA7fSxofU=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id 27BA33A0172; Fri, 12 Jun 2020 12:04:10 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
Date: Thu, 11 Jun 2020 20:55:47 +1000
Subject: [PATCH 1/6] audio/jack: fix invalid minimum buffer size check
To: <qemu-devel@nongnu.org>
Cc: <kraxel@redhat.com>
X-Mailer: mail (GNU Mailutils 3.5)
Message-Id: <20200612020411.27BA33A0172@moya.office.hostfission.com>
Received-SPF: pass client-ip=139.99.139.48; envelope-from=geoff@hostfission.com;
 helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 20:16:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
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
 audio/jackaudio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 722ddb1dfe..d0b6f748f2 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -434,17 +434,6 @@ static int qjack_client_init(QJackClient *c)
     jack_set_xrun_callback(c->client, qjack_xrun, c);
     jack_on_shutdown(c->client, qjack_shutdown, c);
 
-    /*
-     * ensure the buffersize is no smaller then 512 samples, some (all?) qemu
-     * virtual devices do not work correctly otherwise
-     */
-    if (c->buffersize < 512) {
-        c->buffersize = 512;
-    }
-
-    /* create a 2 period buffer */
-    qjack_buffer_create(&c->fifo, c->nchannels, c->buffersize * 2);
-
     /* allocate and register the ports */
     c->port = g_malloc(sizeof(jack_port_t *) * c->nchannels);
     for (int i = 0; i < c->nchannels; ++i) {
@@ -468,6 +457,17 @@ static int qjack_client_init(QJackClient *c)
     jack_activate(c->client);
     c->buffersize = jack_get_buffer_size(c->client);
 
+    /*
+     * ensure the buffersize is no smaller then 512 samples, some (all?) qemu
+     * virtual devices do not work correctly otherwise
+     */
+    if (c->buffersize < 512) {
+        c->buffersize = 512;
+    }
+
+    /* create a 2 period buffer */
+    qjack_buffer_create(&c->fifo, c->nchannels, c->buffersize * 2);
+
     qjack_client_connect_ports(c);
     c->state = QJACK_STATE_RUNNING;
     return 0;
-- 
2.20.1


