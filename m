Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C4FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70872087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70872087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfaV-0000fj-SX
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:20:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTs-0004GV-NK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTn-000894-1p
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hRfTl-0007tt-6e; Fri, 17 May 2019 12:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 841B3308429D;
	Fri, 17 May 2019 16:12:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A35061001E93;
	Fri, 17 May 2019 16:12:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C34BD17535; Fri, 17 May 2019 18:12:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:12:41 +0200
Message-Id: <20190517161241.11813-5-kraxel@redhat.com>
In-Reply-To: <20190517161241.11813-1-kraxel@redhat.com>
References: <20190517161241.11813-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Fri, 17 May 2019 16:12:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/4] kbd-state: fix autorepeat handling
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When allowing multiple down-events in a row (key autorepeat) we can't
use change_bit() any more to update the state, because autorepeat events
don't change the key state.  We have to explicitly use set_bit() and
clear_bit() instead.

Cc: qemu-stable@nongnu.org
Fixes: 35921860156e kbd-state: don't block auto-repeat events
Buglink: https://bugs.launchpad.net/qemu/+bug/1828272
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20190514042443.10735-1-kraxel@redhat.com
---
 ui/kbd-state.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/ui/kbd-state.c b/ui/kbd-state.c
index f3ab2d7a665d..1668d17ddabc 100644
--- a/ui/kbd-state.c
+++ b/ui/kbd-state.c
@@ -59,7 +59,11 @@ void qkbd_state_key_event(QKbdState *kbd, QKeyCode qcode, bool down)
     }
 
     /* update key and modifier state */
-    change_bit(qcode, kbd->keys);
+    if (down) {
+        set_bit(qcode, kbd->keys);
+    } else {
+        clear_bit(qcode, kbd->keys);
+    }
     switch (qcode) {
     case Q_KEY_CODE_SHIFT:
     case Q_KEY_CODE_SHIFT_R:
-- 
2.18.1


