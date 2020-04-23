Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE89C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:42:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112D6205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="YiqtKcBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112D6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRgnd-0003Ps-4k
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 14:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgm6-0001FF-RO
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jRgm6-0004KE-FK
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 14:40:38 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:45238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jRgm2-00048m-TR; Thu, 23 Apr 2020 14:40:36 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 65C3C2E150C;
 Thu, 23 Apr 2020 21:40:32 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 GEhWYPOk17-eUQmj5PB; Thu, 23 Apr 2020 21:40:32 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1587667232; bh=6AUSdMRun+4uomw8GjlwQJKUpFkMPJnEm3m4a1og08I=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=YiqtKcBHfLkbWDYhZ0Vcu+Ouj4kWCtgKHPx5Q2WwYgmVXB6mef08ag3YYDDzdlG63
 2Z/PaAXBnSbhxgkqPrtC2hXs3Tv382XV4PAshynUzX1kbqhklJFRFCGqTWns+C6c78
 fjaBdB3LtScf2B/NeHdQHtIl7tsKD5mlb6l5gPeA=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b081:1313::1:e])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 7hClKENKMK-eUXeJJgf; Thu, 23 Apr 2020 21:40:30 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v1 3/7] char-socket: initialize reconnect timer only if
 close is emitted
Date: Thu, 23 Apr 2020 21:39:34 +0300
Message-Id: <23b36a73ce1150cc501f436684ca558608de3322.1587667007.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1587667007.git.dimastep@yandex-team.ru>
References: <cover.1587667007.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=77.88.29.217;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 14:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 77.88.29.217
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, arei.gonglei@huawei.com,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During vhost-user reconnect functionality testing the following assert
was hit:
  qemu-system-x86_64: chardev/char-socket.c:125:
  qemu_chr_socket_restart_timer: Assertion `!s->reconnect_timer' failed.
  Aborted (core dumped)
This is observed only if the connection is closed by the vhost-user-blk
daemon during the initialization routine. In this case the
tcp_chr_disconnect_locked() routine is called twice. First time it is
called in the tcp_chr_write() routine, after getting the SIGPIPE signal.
Second time it is called when vhost_user_blk_connect() routine return
error. In general it looks correct, because the initialization routine
can return error in many cases.
The tcp_chr_disconnect_locked() routine could be fixed. The timer will
be restarted only if the close event is emitted.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 chardev/char-socket.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index c128cca..83ca4d9 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -476,7 +476,7 @@ static void update_disconnected_filename(SocketChardev *s)
 static void tcp_chr_disconnect_locked(Chardev *chr)
 {
     SocketChardev *s = SOCKET_CHARDEV(chr);
-    bool emit_close = s->state == TCP_CHARDEV_STATE_CONNECTED;
+    bool was_connected = s->state == TCP_CHARDEV_STATE_CONNECTED;
 
     tcp_chr_free_connection(chr);
 
@@ -485,11 +485,11 @@ static void tcp_chr_disconnect_locked(Chardev *chr)
                                               chr, NULL, chr->gcontext);
     }
     update_disconnected_filename(s);
-    if (emit_close) {
+    if (was_connected) {
         qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
-    }
-    if (s->reconnect_time) {
-        qemu_chr_socket_restart_timer(chr);
+        if (s->reconnect_time) {
+            qemu_chr_socket_restart_timer(chr);
+        }
     }
 }
 
-- 
2.7.4


