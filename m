Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF17AC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F9320833
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F9320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45794 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtW3-0003X3-U2
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:22:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLe-0003FI-8c
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1hDtLd-00057T-2x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1hDtLb-00055s-9B
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:11:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 843B1308CF9A;
	Tue,  9 Apr 2019 16:11:42 +0000 (UTC)
Received: from localhost (ovpn-112-27.ams2.redhat.com [10.36.112.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1C0535D9C9;
	Tue,  9 Apr 2019 16:11:41 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Apr 2019 18:10:04 +0200
Message-Id: <20190409161009.6322-16-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Tue, 09 Apr 2019 16:11:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 15/20] monitor: add qmp_return_get_monitor()
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409161004.NrsnG0GaLovKlPV6Hics4TRfEs9Rz40AN6vZHK45Djw@z>

If necessary, add an helper that can be used to retrieve the
associated monitor. This is useful for asynchronous commands that may
have to update cur_mon for various reasons.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/monitor.h | 3 +++
 monitor.c                 | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index c1b40a9cac..5f25cd2616 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -5,6 +5,7 @@
 #include "block/block.h"
 #include "qapi/qapi-types-misc.h"
 #include "qemu/readline.h"
+#include "qapi/qmp/dispatch.h"
=20
 extern __thread Monitor *cur_mon;
=20
@@ -51,4 +52,6 @@ int monitor_fdset_dup_fd_find(int dup_fd);
 void monitor_vfprintf(FILE *stream,
                       const char *fmt, va_list ap) GCC_FMT_ATTR(2, 0);
=20
+Monitor *qmp_return_get_monitor(QmpReturn *qret);
+
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index b1c4647a37..76bc2f8c7c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -324,6 +324,12 @@ bool monitor_cur_is_qmp(void)
     return cur_mon && monitor_is_qmp(cur_mon);
 }
=20
+Monitor *qmp_return_get_monitor(QmpReturn *qret)
+{
+    return qret->session ?
+        container_of(qret->session, Monitor, qmp.session) : NULL;
+}
+
 void monitor_read_command(Monitor *mon, int show_prompt)
 {
     if (!mon->rs)
--=20
2.21.0.196.g041f5ea1cf


