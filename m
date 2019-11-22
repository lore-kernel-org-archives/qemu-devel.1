Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D55C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 09:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25452070E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 09:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="pxaMR8FF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25452070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY5Br-00048j-6X
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 04:25:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iY5B4-0003fH-8W
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iY5B1-0007vd-35
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:24:32 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:52294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1iY5B0-0007ur-Hf
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 04:24:31 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 7C8092E1547;
 Fri, 22 Nov 2019 12:24:26 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net
 (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 1nHpQYuaPq-OQTutWFe; Fri, 22 Nov 2019 12:24:26 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1574414666; bh=insK5ULVBnraPS+Iwhi0j+3xaw3LrkQmybXW3buT7bc=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=pxaMR8FFDlNWp77cJ6UtgZwkath4ZQ4MHx8jz9LtZCQ2DanldT0mbzNZf4SPt9Twa
 Whj+MVqhilOnByVLcKpy2TtAhPM6hO+r50GmkcydfFmis31xeEz70V9ZKHeWW8hmq3
 EVu3IFXw+lHXMEA2KeW5LBKgn7hEhEWdVpTTEvfc=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:1460:716c:11e2:7064])
 by myt5-6212ef07a9ec.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 IIDretiYZ4-OQVah5Yc; Fri, 22 Nov 2019 12:24:26 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH] monitor: Fix slow reading
Date: Fri, 22 Nov 2019 12:23:47 +0300
Message-Id: <20191122092347.28309-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Markus Armbruster <armbru@redhat.com>, yc-core@yandex-team.ru,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The monitor_can_read (as a callback of qemu_chr_fe_set_handlers)
should return size of buffer which monitor_qmp_read or monitor_read
can process.
Currently, monitor_can_read returns 1 as a result of logical not.
Thus, for each QMP command, len(QMD) iterations of the main loop
are required to handle a command.
In fact, these both functions can process any buffer size.
So, return 1024 as a reasonable size which is enough to process
the most QMP commands, but not too big to block the main loop for
a long time.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 monitor/monitor.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6448..cac3f39727 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -50,6 +50,13 @@ typedef struct {
     int64_t rate;       /* Minimum time (in ns) between two events */
 } MonitorQAPIEventConf;
=20
+/*
+ * The maximum buffer size which the monitor can process in one iteratio=
n
+ * of the main loop. We don't want to block the loop for a long time
+ * because of JSON parser, so use a reasonable value.
+ */
+#define MONITOR_READ_LEN_MAX 1024
+
 /* Shared monitor I/O thread */
 IOThread *mon_iothread;
=20
@@ -498,7 +505,7 @@ int monitor_can_read(void *opaque)
 {
     Monitor *mon =3D opaque;
=20
-    return !atomic_mb_read(&mon->suspend_cnt);
+    return atomic_mb_read(&mon->suspend_cnt) ? 0 : MONITOR_READ_LEN_MAX;
 }
=20
 void monitor_list_append(Monitor *mon)
--=20
2.24.0


