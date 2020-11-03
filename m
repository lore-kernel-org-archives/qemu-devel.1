Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51DDC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:28:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BF222370
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQKDKzGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BF222370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyEz-0002S9-HB
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kZyDK-0000f7-SZ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kZyDH-0007LA-T8
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604417231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hH5TorZYjW239QE7ItCnoGr9Wj+bLbZgC2Do3e/8ooI=;
 b=SQKDKzGqFLx1uU08UqOm2by9Zs8UbaNcLTznF5VzMOlkL7/sizRUtsEFwEGJ1Ui5nXQe48
 eS/kENddxzxt3cr5cfg/3WU81jVbySNqgXaSUdDskL/EN+BdzSPRHsYWPn0p0neEknVzLY
 620D8M+uBsJuMVqnU17QFTJXyJSRO2U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-k1qfNuY-NUupEj0PpxIprw-1; Tue, 03 Nov 2020 10:27:09 -0500
X-MC-Unique: k1qfNuY-NUupEj0PpxIprw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 128F356C91;
 Tue,  3 Nov 2020 15:27:08 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-113-164.ams2.redhat.com [10.36.113.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF026EF70;
 Tue,  3 Nov 2020 15:27:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/6] qmp: fix aio_poll() assertion failure on Windows
Date: Tue,  3 Nov 2020 16:26:53 +0100
Message-Id: <20201103152658.119563-2-kwolf@redhat.com>
In-Reply-To: <20201103152658.119563-1-kwolf@redhat.com>
References: <20201103152658.119563-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Volker Rümelin <vr_qemu@t-online.de>

Commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine" modified
aio_poll() in util/aio-posix.c to avoid an assertion failure. This
change is missing in util/aio-win32.c.

Apply the changes to util/aio-posix.c to util/aio-win32.c too.
This fixes an assertion failure on Windows whenever QEMU exits.

$ ./qemu-system-x86_64.exe -machine pc,accel=tcg -display gtk
**
ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion failed:
(in_aio_context_home_thread(ctx))
Bail out! ERROR:../qemu/util/aio-win32.c:337:aio_poll: assertion
failed: (in_aio_context_home_thread(ctx))

Fixes: 9ce44e2ce2 ("qmp: Move dispatcher to a coroutine")
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
Message-Id: <20201021064033.8600-1-vr_qemu@t-online.de>
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 util/aio-win32.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/aio-win32.c b/util/aio-win32.c
index e7b1d649e9..168717b51b 100644
--- a/util/aio-win32.c
+++ b/util/aio-win32.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "block/block.h"
+#include "qemu/main-loop.h"
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qapi/error.h"
@@ -333,8 +334,13 @@ bool aio_poll(AioContext *ctx, bool blocking)
      * There cannot be two concurrent aio_poll calls for the same AioContext (or
      * an aio_poll concurrent with a GSource prepare/check/dispatch callback).
      * We rely on this below to avoid slow locked accesses to ctx->notify_me.
+     *
+     * aio_poll() may only be called in the AioContext's thread. iohandler_ctx
+     * is special in that it runs in the main thread, but that thread's context
+     * is qemu_aio_context.
      */
-    assert(in_aio_context_home_thread(ctx));
+    assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
+                                      qemu_get_aio_context() : ctx));
     progress = false;
 
     /* aio_notify can avoid the expensive event_notifier_set if
-- 
2.28.0


