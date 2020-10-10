Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D6DC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBD6E207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 20:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPWJN8JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD6E207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRLmY-000472-FM
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 16:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRLgQ-00072q-4g
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25239)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kRLgO-00075Y-Lf
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 16:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602362495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jfyUSzLpMg0aVhpMIGqjnBnWhwQ55mwb9u9gWmSSZ1k=;
 b=YPWJN8JCdxWpGHUfICfutBsAPKd+e0HpMXFeT3gbjbTNo6bToX0R7WBAJ1Of0ZrzUz71OJ
 NYxfFx//QjN+wj6UQOK6/8BO+VThoA3Y2XF5scuRkNr5f6qBxg74mt6KhcJF2a5H7JvLok
 Afcfj5Sk8DxA5zd3/Q7jvEwkwjwGs9M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-dThHvkfUM-e2UfrXsOEUVA-1; Sat, 10 Oct 2020 16:41:33 -0400
X-MC-Unique: dThHvkfUM-e2UfrXsOEUVA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A24081868423
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 20:41:32 +0000 (UTC)
Received: from localhost (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B9C210013C4;
 Sat, 10 Oct 2020 20:41:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] coroutine: let CoQueue wake up outside a coroutine
Date: Sun, 11 Oct 2020 00:41:04 +0400
Message-Id: <20201010204106.1368710-2-marcandre.lureau@redhat.com>
In-Reply-To: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
References: <20201010204106.1368710-1-marcandre.lureau@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 16:30:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The assert() was added in commit b681a1c73e15 ("block: Repair the
throttling code."), when the qemu_co_queue_do_restart() function
required to be running in a coroutine. It was later made unnecessary in
commit a9d9235567e7 ("coroutine-lock: reschedule coroutine on the
AioContext it was running on").

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-coroutine-lock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 36927b5f88..5816bf8900 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -85,15 +85,13 @@ static bool qemu_co_queue_do_restart(CoQueue *queue, bool single)
     return true;
 }
 
-bool coroutine_fn qemu_co_queue_next(CoQueue *queue)
+bool qemu_co_queue_next(CoQueue *queue)
 {
-    assert(qemu_in_coroutine());
     return qemu_co_queue_do_restart(queue, true);
 }
 
-void coroutine_fn qemu_co_queue_restart_all(CoQueue *queue)
+void qemu_co_queue_restart_all(CoQueue *queue)
 {
-    assert(qemu_in_coroutine());
     qemu_co_queue_do_restart(queue, false);
 }
 
-- 
2.28.0


