Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47CAC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8380420747
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 04:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hostfission.com header.i=@hostfission.com header.b="ES+GokTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8380420747
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=hostfission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkKUb-0006Nx-Nw
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 00:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@moya.office.hostfission.com>)
 id 1jkKTd-0004jC-B0
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:42:37 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:57380)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@moya.office.hostfission.com>)
 id 1jkKTa-0005Av-OZ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 00:42:37 -0400
Received: from moya.office.hostfission.com (office.hostfission.com
 [220.233.29.71])
 by mail1.hostfission.com (Postfix) with ESMTP id 46503445D3;
 Sat, 13 Jun 2020 14:06:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hostfission.com;
 s=mail; t=1592021161;
 bh=4UNyzqKwA72Hv2rXe7+67R0tuH+ZT6vZbiRtOXthWWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ES+GokTHDTwJo8TsehcaBH4pYPjLkE0pnv2y4ByexEJa6bSLzqVcEFVDNv+s9GyJS
 OTuF9/h5/CYbAJvkbTJww1e2W+biI6DQW0ZZn8wizZkN5JpptibPNyF1GCXEm6DYXc
 3wNravGdQjJtaXtD0h8Ocn6B8XEcuBOFdk0rHyBQ=
Received: by moya.office.hostfission.com (Postfix, from userid 0)
 id 2EA0F3A0506; Sat, 13 Jun 2020 14:06:00 +1000 (AEST)
From: Geoffrey McRae <geoff@hostfission.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	geoff@hostfission.com
Subject: [PATCH 1/6] audio/jack: fix invalid minimum buffer size check
Date: Sat, 13 Jun 2020 14:05:13 +1000
Message-Id: <20200613040518.38172-2-geoff@hostfission.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200613040518.38172-1-geoff@hostfission.com>
References: <20200613040518.38172-1-geoff@hostfission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=139.99.139.48;
 envelope-from=root@moya.office.hostfission.com; helo=mail1.hostfission.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 00:05:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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

JACK does not provide us with the configured buffer size until after
activiation which was overriding this minimum value. JACK itself doesn't
have this minimum limitation, but the QEMU virtual hardware and as such
it must be enforced, failure to do so results in audio discontinuities.

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


