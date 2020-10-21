Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6565EC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D6362074F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 06:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6362074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV7os-0003lT-4R
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 02:41:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kV7np-0003KU-IN; Wed, 21 Oct 2020 02:40:53 -0400
Received: from mailout10.t-online.de ([194.25.134.21]:46790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1kV7nn-0001v0-Kq; Wed, 21 Oct 2020 02:40:53 -0400
Received: from fwd35.aul.t-online.de (fwd35.aul.t-online.de [172.20.27.145])
 by mailout10.t-online.de (Postfix) with SMTP id 65923414DBB7;
 Wed, 21 Oct 2020 08:40:46 +0200 (CEST)
Received: from linpower.localnet
 (XHw1aZZ6oh2gJB+91i7GCs4lxVJ7uxY8FMt0yJpnXP4ALUndL-a-8sdoCB3MTV2Z4m@[79.208.17.62])
 by fwd35.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kV7nW-1qc5rc0; Wed, 21 Oct 2020 08:40:34 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id BA9622006DD; Wed, 21 Oct 2020 08:40:33 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] qmp: fix aio_poll() assertion failure on Windows
Date: Wed, 21 Oct 2020 08:40:33 +0200
Message-Id: <20201021064033.8600-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ID: XHw1aZZ6oh2gJB+91i7GCs4lxVJ7uxY8FMt0yJpnXP4ALUndL-a-8sdoCB3MTV2Z4m
X-TOI-EXPURGATEID: 150726::1603262434-0000E07B-282709CF/0/0 CLEAN NORMAL
X-TOI-MSGID: 2ed298dc-7241-4475-90c3-52dec2575cea
Received-SPF: none client-ip=194.25.134.21;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout10.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:40:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, SPOOFED_FREEMAIL=1.987 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
2.26.2


