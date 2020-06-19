Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B943DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:22:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86CB420DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJ3PAkzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86CB420DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGyN-0000Qp-P1
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu1-0001sn-6j
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55695
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGtz-00037f-Ey
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592572670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=jPa2YSuhcE8XmFP/p7u4U5O131eiJBvelXpiMbSwNpA=;
 b=HJ3PAkzALOFY1Y3KKaIc9+t9+r6gGF/zs/+tDumFMMsmie0p/bJPh7HNTiT9zXHXcQCj2R
 8BcvvQJWG1+G8jXJnxTXIuc8ThjAQaSMEIoNu5rETEmUU0NjkU4LitPf1d+xfPvzhGgAl4
 epnlMTCTZicMpewmqvAqVcjKNbcQivg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-5QRxkxiIMZS7ugoNQBWIjA-1; Fri, 19 Jun 2020 09:17:48 -0400
X-MC-Unique: 5QRxkxiIMZS7ugoNQBWIjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A452910059A1;
 Fri, 19 Jun 2020 13:17:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C43C60F88;
 Fri, 19 Jun 2020 13:17:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 963BE9D94; Fri, 19 Jun 2020 15:17:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] audio/jack: simplify the re-init code path
Date: Fri, 19 Jun 2020 15:17:40 +0200
Message-Id: <20200619131741.10857-7-kraxel@redhat.com>
In-Reply-To: <20200619131741.10857-1-kraxel@redhat.com>
References: <20200619131741.10857-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 05:19:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Geoffrey McRae <geoff@hostfission.com>

Instead of checking for the audodev state in each code path, centralize
the check into the initialize function itself to make it safe to call it
at any time.

Signed-off-by: Geoffrey McRae <geoff@hostfission.com>
Message-id: 20200613040518.38172-7-geoff@hostfission.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 audio/jackaudio.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index b2b53985ae61..72ed7c492998 100644
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
2.18.4


