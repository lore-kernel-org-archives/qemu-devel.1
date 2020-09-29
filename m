Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9651C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5586F20897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekx07a9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5586F20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCPk-0004ra-9x
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNCO8-0002lL-8S
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kNCO6-0000qv-H8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:57:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601373453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1f3YTMl5c0j0SsKEbAXMyJZG9mnpbLedmZLZMwJ2AmE=;
 b=ekx07a9o1y3woYgkNGOAZdNQssMUJ/J5wFwSVI68hVHa7ZljdV3FvVjViWryYPoNPGKFkn
 vPBjpwYsh+A+CcZN62j+ezmcG6cfuLoXO+adGgFqxErcKi6AkVqi9LiEf7YvV703MjAjno
 R1IWLwZEHtD1LRxwBmziJuET4dRtoAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-1nBExx7NOUmseJO-T7JUmA-1; Tue, 29 Sep 2020 05:57:30 -0400
X-MC-Unique: 1nBExx7NOUmseJO-T7JUmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F27231074662;
 Tue, 29 Sep 2020 09:57:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F51C7A431;
 Tue, 29 Sep 2020 09:57:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B41449A95; Tue, 29 Sep 2020 11:57:17 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/9] spice: remove the single monitor config logic
Date: Tue, 29 Sep 2020 11:57:13 +0200
Message-Id: <20200929095717.26745-6-kraxel@redhat.com>
In-Reply-To: <20200929095717.26745-1-kraxel@redhat.com>
References: <20200929095717.26745-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Introduced in commit 9c956e646178fee8c14ce7dfae5a9d7cb901876c ("spice:
prepare for upcoming spice-server change"), the new logic never
materialized in the spice server source tree. Let's remove it for now,
until it actually changes in Spice.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20200927145751.365446-5-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/spice-display.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 625d9232b95a..b304c13149a8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -674,28 +674,10 @@ static int interface_client_monitors_config(QXLInstance *sin,
 
     info = *dpy_get_ui_info(ssd->dcl.con);
 
-    if (mc->num_of_monitors == 1) {
-        /*
-         * New spice-server version which filters the list of monitors
-         * to only include those that belong to our display channel.
-         *
-         * single-head configuration (where filtering doesn't matter)
-         * takes this code path too.
-         */
-        info.width  = mc->monitors[0].width;
-        info.height = mc->monitors[0].height;
-    } else {
-        /*
-         * Old spice-server which gives us all monitors, so we have to
-         * figure ourself which entry we need.  Array index is the
-         * channel_id, which is the qemu console index, see
-         * qemu_spice_add_display_interface().
-         */
-        head = qemu_console_get_index(ssd->dcl.con);
-        if (mc->num_of_monitors > head) {
-            info.width  = mc->monitors[head].width;
-            info.height = mc->monitors[head].height;
-        }
+    head = qemu_console_get_index(ssd->dcl.con);
+    if (mc->num_of_monitors > head) {
+        info.width  = mc->monitors[head].width;
+        info.height = mc->monitors[head].height;
     }
 
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
-- 
2.27.0


