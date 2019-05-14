Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976BC04A6B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7758F20843
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 04:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7758F20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38887 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQP0Z-0008L5-Ib
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 00:25:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQOzh-0007to-C6
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hQOzg-0006eD-Cp
	for qemu-devel@nongnu.org; Tue, 14 May 2019 00:24:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>)
	id 1hQOzg-0006dU-7c; Tue, 14 May 2019 00:24:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C35E7C057F3C;
	Tue, 14 May 2019 04:24:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47BC85D71E;
	Tue, 14 May 2019 04:24:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 805EF1747D; Tue, 14 May 2019 06:24:43 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 06:24:43 +0200
Message-Id: <20190514042443.10735-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Tue, 14 May 2019 04:24:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] kbd-state: fix autorepeat handling
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


