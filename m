Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CD4C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CFF5206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CFF5206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEHb-0001zl-FV
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50125)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aastier@freebox.fr>) id 1idEGR-00014j-0z
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:07:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aastier@freebox.fr>) id 1idEGP-00077t-Ms
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:07:22 -0500
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:44602)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aastier@freebox.fr>) id 1idEGP-0006ym-2J
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:07:21 -0500
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by smtpfb2-g21.free.fr (Postfix) with ESMTP id 032BA42D5E4
 for <qemu-devel@nongnu.org>; Fri,  6 Dec 2019 09:51:16 +0100 (CET)
Received: from anisse-station.iliad.local (unknown
 [IPv6:2a01:e34:ec0d:40e0:6c55:3f21:f604:859c])
 by smtp3-g21.free.fr (Postfix) with ESMTPS id E81C713F85F;
 Fri,  6 Dec 2019 09:51:08 +0100 (CET)
From: Anisse Astier <aastier@freebox.fr>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] socket: websocket refresh of max_size outside of poll
Date: Fri,  6 Dec 2019 09:50:57 +0100
Message-Id: <20191206085057.15612-1-aastier@freebox.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157556562680.28471.17998029208459109470@37313f22b938>
References: <157556562680.28471.17998029208459109470@37313f22b938>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.27.42.10
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
Cc: Anisse Astier <aastier@freebox.fr>, Julia Suvorova <jusual@mail.ru>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because serial backend readiness isn't checked, the socket frontend (in
websocket mode) would send new characters before previous characters
were consumed. This lead to skipped characters, or worse, SysRq keys
being triggered.

This patch ensures the readable size is refreshed before consuming any
data. Normally, this size is refreshed in the event loop by the glib
prepare io_watch_poll_prepare calling tcp_chr_read_poll; but since the
websocket reader is a greedy because it needs a buffer to decode the
websocket protocol, (whereas tcp one ready bytes as necessary), there's
nothing to read or poll, so the max_size wouldn't be refreshed.

Buglink: https://bugs.launchpad.net/qemu/+bug/1828608
Signed-off-by: Anisse Astier <aastier@freebox.fr>
---
Changes since v1:
 - style changes

---
 chardev/char-socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 185fe38dda..9267ecd813 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -505,6 +505,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
     uint8_t buf[CHR_READ_BUF_LEN];
     int len, size;
=20
+    if (s->is_websock)
+        /* Buffered greedy reader needs max_size refresh */
+        s->max_size =3D qemu_chr_be_can_write(chr);
     if ((s->state !=3D TCP_CHARDEV_STATE_CONNECTED) ||
         s->max_size <=3D 0) {
         return TRUE;
--=20
2.20.1


