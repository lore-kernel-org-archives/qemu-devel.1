Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D94C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8A220856
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8A220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2k31-0003TZ-IH
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 18:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2k20-0002y1-6U
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2k1w-0000Kr-0G
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:33:37 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:13164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i2k1v-0000JK-JJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:33:35 -0400
IronPort-SDR: OAvEhB+bHLQvUpCLa00m0F6AHP1UfkdlbHMeEnTMFoB1CA4PGzv+pBslD+PXl13wfLHZLj3bBR
 kjbgzvb2j70Oz0s+XYUBdRyQo4iEC0AQemK/2JJxy5qdaR3O6dJdjfgQc1hRQvZakJJKAhdAHC
 FZxpslZDQgTnlAx6bjR4ebnmqSm2VHssFWG/Xx4M8KSQUiJGG7qnZAJVHJwHyzCs1HpAgr3Ao4
 g2j/jjDHIZzXUVTolksQZNk/0/32zvWEAE/A5HSMTGgGa5I3IPq3SYR8KbpjroyGICr9wFFSSh
 8/Q=
X-IronPort-AV: E=Sophos;i="5.64,438,1559548800"; d="scan'208";a="40785472"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa2.mentor.iphmx.com with ESMTP; 27 Aug 2019 14:33:32 -0800
IronPort-SDR: BrONIf1MvffMu65/y7Ld1qwnzVAkZ3rzPu4PRYiU/c8Zduf0dUYVVEJbo1qr3Moxja8+1j8zNv
 2vo4KIxOvPc1irHfMgabcN5fBvKwt7EApxX4f64yGrlUkGie+04kRJokTfScH6uK2DDOnmDPeW
 VjCzICcOrxoug024Gt38ahzo2IQhmLhboL5dde8/Wpo3MWbOAa9bxnHz9+BkwP0vyX0DC9/LSs
 6NwNZ6RTi8Umn3Pghmz+cxbxJ2qq6lNsQWGwLTFJkgceKQFo4AJTiZAafU0pRN5X/WKBX+oTIM
 xBY=
From: Sandra Loosemore <sandra@codesourcery.com>
To: <qemu-devel@nongnu.org>
Date: Tue, 27 Aug 2019 16:33:17 -0600
Message-ID: <20190827223317.8614-1-sandra@codesourcery.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.98
Subject: [Qemu-devel] [PATCH V3] gdbstub: Fix handler for 'F' packet
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Handling of the 'F' packet has been broken since commit
4b20fab101b9e2d0fb47454209637a17fc7a13d5, which converted it to use
the new packet parsing infrastructure.  Per the GDB RSP specification

https://sourceware.org/gdb/current/onlinedocs/gdb/The-F-Reply-Packet.html

the second parameter may be omitted, but the rewritten implementation
was failing to recognize this case.  The result was that QEMU was
repeatedly resending the fileio request and ignoring GDB's replies of
successful completion.  This patch restores the behavior of the
previous code in allowing the errno parameter to be omitted and
passing 0 to the callback in that case.

Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
---
 gdbstub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index b92ba59..3e8bcd0 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -1820,11 +1820,15 @@ static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
 
 static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
 {
-    if (gdb_ctx->num_params >= 2 && gdb_ctx->s->current_syscall_cb) {
+    if (gdb_ctx->num_params >= 1 && gdb_ctx->s->current_syscall_cb) {
         target_ulong ret, err;
 
         ret = (target_ulong)gdb_ctx->params[0].val_ull;
-        err = (target_ulong)gdb_ctx->params[1].val_ull;
+        if (gdb_ctx->num_params >= 2) {
+            err = (target_ulong)gdb_ctx->params[1].val_ull;
+        } else {
+            err = 0;
+        }
         gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
         gdb_ctx->s->current_syscall_cb = NULL;
     }
-- 
2.8.1


