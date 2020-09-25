Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACCDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACD32086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTuyQgp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACD32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoFp-0007lf-Fk
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kLo9b-0007WY-ME
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kLo9V-0001Eo-2o
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:52:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0l8qvWRrHwiSkIqmmCGlnK1Woq1I9l3yvB4ZPhG79Y=;
 b=BTuyQgp/N24hDAWCDP19Rtm4aIdrPxHtAoG3iypjGxQ/zipQEAM9nd7/TLsax31gAsxaJM
 MmfuEzkQ21wL/bbo3XEx3huZDxzvq8Mkx7plEim0oCjgccR2CeVMK6HRHKVQrMZxL03fK4
 oBGYj+MEWA/1A47M7AYPJF6/qyn75nU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-smtO4rB3MaStHgHX8zcFJA-1; Fri, 25 Sep 2020 09:52:31 -0400
X-MC-Unique: smtO4rB3MaStHgHX8zcFJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6189AF204;
 Fri, 25 Sep 2020 13:52:30 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE341002C17;
 Fri, 25 Sep 2020 13:52:18 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] spice: remove the single monitor config logic
Date: Fri, 25 Sep 2020 17:50:55 +0400
Message-Id: <20200925135057.291556-5-marcandre.lureau@redhat.com>
In-Reply-To: <20200925135057.291556-1-marcandre.lureau@redhat.com>
References: <20200925135057.291556-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Introduced in commit 9c956e646178fee8c14ce7dfae5a9d7cb901876c ("spice:
prepare for upcoming spice-server change"), the new logic never
materialized in the spice server source tree. Let's remove it for now,
until it actually changes in Spice.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/spice-display.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/ui/spice-display.c b/ui/spice-display.c
index 625d9232b9..b304c13149 100644
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
2.26.2


