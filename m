Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE8DC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6E221926
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6E221926
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFv6-0006tF-21
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36587)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqFug-0005UG-LA
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqFuf-0004cP-IX
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:58:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32782)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hqFuf-0004bv-Aw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:58:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A85743DE0F;
 Wed, 24 Jul 2019 11:58:28 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-166.ams2.redhat.com
 [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CD667600D1;
 Wed, 24 Jul 2019 11:58:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	pavel.dovgaluk@ispras.ru
Date: Wed, 24 Jul 2019 12:58:21 +0100
Message-Id: <20190724115823.4199-3-dgilbert@redhat.com>
In-Reply-To: <20190724115823.4199-1-dgilbert@redhat.com>
References: <20190724115823.4199-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 24 Jul 2019 11:58:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [for 4.2 PATCH v2 2/4] timer: Remove reset notifiers
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Remove the reset notifer from the core qemu-timer code.
The only user was mc146818 and we've just remove it's use.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/qemu/timer.h | 22 ----------------------
 util/qemu-timer.c    | 21 +--------------------
 2 files changed, 1 insertion(+), 42 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 5d978e1634..6817c78ef4 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -227,28 +227,6 @@ void qemu_clock_enable(QEMUClockType type, bool enab=
led);
  */
 void qemu_start_warp_timer(void);
=20
-/**
- * qemu_clock_register_reset_notifier:
- * @type: the clock type
- * @notifier: the notifier function
- *
- * Register a notifier function to call when the clock
- * concerned is reset.
- */
-void qemu_clock_register_reset_notifier(QEMUClockType type,
-                                        Notifier *notifier);
-
-/**
- * qemu_clock_unregister_reset_notifier:
- * @type: the clock type
- * @notifier: the notifier function
- *
- * Unregister a notifier function to call when the clock
- * concerned is reset.
- */
-void qemu_clock_unregister_reset_notifier(QEMUClockType type,
-                                          Notifier *notifier);
-
 /**
  * qemu_clock_run_timers:
  * @type: clock on which to operate
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 1cc1b2f2c3..2faaaf9926 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -48,7 +48,6 @@ typedef struct QEMUClock {
     /* We rely on BQL to protect the timerlists */
     QLIST_HEAD(, QEMUTimerList) timerlists;
=20
-    NotifierList reset_notifiers;
     int64_t last;
=20
     QEMUClockType type;
@@ -133,7 +132,6 @@ static void qemu_clock_init(QEMUClockType type, QEMUT=
imerListNotifyCB *notify_cb
     clock->enabled =3D (type =3D=3D QEMU_CLOCK_VIRTUAL ? false : true);
     clock->last =3D INT64_MIN;
     QLIST_INIT(&clock->timerlists);
-    notifier_list_init(&clock->reset_notifiers);
     main_loop_tlg.tl[type] =3D timerlist_new(type, notify_cb, NULL);
 }
=20
@@ -630,7 +628,7 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup=
 *tlg)
=20
 int64_t qemu_clock_get_ns(QEMUClockType type)
 {
-    int64_t now, last;
+    int64_t now;
     QEMUClock *clock =3D qemu_clock_ptr(type);
=20
     switch (type) {
@@ -645,11 +643,7 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
         }
     case QEMU_CLOCK_HOST:
         now =3D REPLAY_CLOCK(REPLAY_CLOCK_HOST, get_clock_realtime());
-        last =3D clock->last;
         clock->last =3D now;
-        if (now < last || now > (last + get_max_clock_jump())) {
-            notifier_list_notify(&clock->reset_notifiers, &now);
-        }
         return now;
     case QEMU_CLOCK_VIRTUAL_RT:
         return REPLAY_CLOCK(REPLAY_CLOCK_VIRTUAL_RT, cpu_get_clock());
@@ -668,19 +662,6 @@ void qemu_clock_set_last(QEMUClockType type, uint64_=
t last)
     clock->last =3D last;
 }
=20
-void qemu_clock_register_reset_notifier(QEMUClockType type,
-                                        Notifier *notifier)
-{
-    QEMUClock *clock =3D qemu_clock_ptr(type);
-    notifier_list_add(&clock->reset_notifiers, notifier);
-}
-
-void qemu_clock_unregister_reset_notifier(QEMUClockType type,
-                                          Notifier *notifier)
-{
-    notifier_remove(notifier);
-}
-
 void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
--=20
2.21.0


