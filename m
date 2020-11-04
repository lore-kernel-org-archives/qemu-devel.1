Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA358C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91B621556
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 13:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2oJGUQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91B621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaJFr-0000Sa-N6
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 08:55:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaJEv-0007iE-Em
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:54:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaJEs-0004NS-93
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 08:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604498053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwHvnchTG1ZbFYaKV7uGi8lOlG33T5ID8s9iw/JqnAk=;
 b=Q2oJGUQAeGMq9K5SFWOgfuUaUbdSGDrtYR7H/Br7I8BrZ3nnzx7/Q4CzITJi3cYM1gt+TL
 vzbL7A3L6GZ++9R5/TWtcU6HAuOHiNmPBfIPexJTWM98VH5k2olOHuL85jShzNCtvIKXT5
 3ljdNIw7GvaFZzwA6D+Hn1DpS7rNy8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-dSjNuUTpO-ymZvVnJIMiGg-1; Wed, 04 Nov 2020 08:54:12 -0500
X-MC-Unique: dSjNuUTpO-ymZvVnJIMiGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19B5910866B2
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 13:54:11 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C8F26EF55;
 Wed,  4 Nov 2020 13:54:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 04D439D0F; Wed,  4 Nov 2020 14:54:01 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] coroutine: let CoQueue wake up outside a coroutine
Date: Wed,  4 Nov 2020 14:53:58 +0100
Message-Id: <20201104135400.3938-2-kraxel@redhat.com>
In-Reply-To: <20201104135400.3938-1-kraxel@redhat.com>
References: <20201104135400.3938-1-kraxel@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Message-id: 20201027133602.3038018-2-marcandre.lureau@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 util/qemu-coroutine-lock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 36927b5f88d5..5816bf890094 100644
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
2.27.0


