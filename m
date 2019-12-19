Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EABC2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F8132146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 16:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="UwXpEUT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8132146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihyOi-0007aL-6R
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 11:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ihyLc-0003uA-MS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1ihyLZ-0006Fn-Nu
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:19 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:46850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1ihyLZ-0005yF-7H
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 11:08:17 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id BAFA42E147A;
 Thu, 19 Dec 2019 19:08:13 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net
 (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 nwcp3tAqvu-8Dr0S5Zt; Thu, 19 Dec 2019 19:08:13 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1576771693; bh=H9TZtWHJVRxS3TvRnjYanFb1oNTF0ttl18nsyYJzQx8=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=UwXpEUT8/k8A/yEyMZ+NiPX+C9MLEegFmNUCW2lWUQWwPOPOurfXBi/Ead+hqjKRh
 NQhMdgB9TugrtkPZSXa9F9BZSQYAAIZFjrGmAW008/jh3N6vUTMeJ3GdJKgy7i0BT2
 /ivz753X0DvDflJY6zTtep47VJKn1cuz2eBLEIj0=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:9915:7a93:bd7b:686c])
 by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 FfZMqtXGzo-8DWeZQtc; Thu, 19 Dec 2019 19:08:13 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] monitor: Split monitor_can_read for QMP and HMP
Date: Thu, 19 Dec 2019 19:07:55 +0300
Message-Id: <20191219160756.22389-2-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
References: <20191219160756.22389-1-yury-kotov@yandex-team.ru>
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
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, yc-core@yandex-team.ru,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch itself doesn't make sense, it is needed for the next patch.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 monitor/hmp.c              |  7 +++++++
 monitor/monitor-internal.h |  1 -
 monitor/monitor.c          |  7 -------
 monitor/qmp.c              | 11 +++++++++--
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/monitor/hmp.c b/monitor/hmp.c
index 8942e28933..6f0e29dece 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1322,6 +1322,13 @@ static void monitor_read(void *opaque, const uint8=
_t *buf, int size)
     cur_mon =3D old_mon;
 }
=20
+static int monitor_can_read(void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    return !atomic_mb_read(&mon->suspend_cnt);
+}
+
 static void monitor_event(void *opaque, int event)
 {
     Monitor *mon =3D opaque;
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index d78f5ca190..c0ba29abf1 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -166,7 +166,6 @@ int monitor_puts(Monitor *mon, const char *str);
 void monitor_data_init(Monitor *mon, bool is_qmp, bool skip_flush,
                        bool use_io_thread);
 void monitor_data_destroy(Monitor *mon);
-int monitor_can_read(void *opaque);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
=20
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 12898b6448..d25cc8ea4a 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -494,13 +494,6 @@ void monitor_resume(Monitor *mon)
     trace_monitor_suspend(mon, -1);
 }
=20
-int monitor_can_read(void *opaque)
-{
-    Monitor *mon =3D opaque;
-
-    return !atomic_mb_read(&mon->suspend_cnt);
-}
-
 void monitor_list_append(Monitor *mon)
 {
     qemu_mutex_lock(&monitor_lock);
diff --git a/monitor/qmp.c b/monitor/qmp.c
index b67a8e7d1f..37884c6c43 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -311,6 +311,13 @@ static void handle_qmp_command(void *opaque, QObject=
 *req, Error *err)
     qemu_bh_schedule(qmp_dispatcher_bh);
 }
=20
+static int monitor_qmp_can_read(void *opaque)
+{
+    Monitor *mon =3D opaque;
+
+    return !atomic_mb_read(&mon->suspend_cnt);
+}
+
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
 {
     MonitorQMP *mon =3D opaque;
@@ -384,7 +391,7 @@ static void monitor_qmp_setup_handlers_bh(void *opaqu=
e)
     assert(mon->common.use_io_thread);
     context =3D iothread_get_g_main_context(mon_iothread);
     assert(context);
-    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+    qemu_chr_fe_set_handlers(&mon->common.chr, monitor_qmp_can_read,
                              monitor_qmp_read, monitor_qmp_event,
                              NULL, &mon->common, context, true);
     monitor_list_append(&mon->common);
@@ -422,7 +429,7 @@ void monitor_init_qmp(Chardev *chr, bool pretty)
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
-        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_can_read,
+        qemu_chr_fe_set_handlers(&mon->common.chr, monitor_qmp_can_read,
                                  monitor_qmp_read, monitor_qmp_event,
                                  NULL, &mon->common, NULL, true);
         monitor_list_append(&mon->common);
--=20
2.24.1


