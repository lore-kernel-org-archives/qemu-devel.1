Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC93C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 10:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D26520828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 10:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tmR6bxzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D26520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2CR7-0003zH-R4
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 06:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2COA-0000o0-Px
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 06:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i2CO9-0002EI-Qj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 06:38:18 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:42486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i2CO9-0002DB-EX
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 06:38:17 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id D9F862E0A46;
 Mon, 26 Aug 2019 13:38:13 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
 [2a02:6b8:0:1619::137])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 wf2NXWJQkh-cDPi6dGa; Mon, 26 Aug 2019 13:38:13 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1566815893; bh=7YAQSK+oeups3g+tbEdPAbH70EWMPW/3wcWO0iLUXCs=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=tmR6bxzk41i/ZuxCKlVUG0WWkemMtBxytdRdO/1poU8OdvZnnY4GGzSXNUTu7IfGD
 8yk/UMO2juNmFxvDj+ie9Ah7JmJ8rLjgjAoCWDpiv+hra5quTJ+4sIpT2mid/Gip8z
 6oo/3weT0QTCdpTL3HgMEzaBXtQU3PN1Twa/Us9U=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:dc67:69ff:2705:c046])
 by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 mDIbqN0Ee6-cD0SNILL; Mon, 26 Aug 2019 13:38:13 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Date: Mon, 26 Aug 2019 13:37:25 +0300
Message-Id: <20190826103726.25538-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190826103726.25538-1-yury-kotov@yandex-team.ru>
References: <20190826103726.25538-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1472:2741:0:8b6:217
Subject: [Qemu-devel] [PATCH v5 2/3] cpus: Fix throttling during vm_stop
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
Cc: "open list:Overall" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Throttling thread sleeps in VCPU thread. For high throttle percentage
this sleep is more than 10ms. E.g. for 60% - 15ms, for 99% - 990ms.
vm_stop() kicks all VCPUs and waits for them. It's called at the end of
migration and because of the long sleep the migration downtime might be
more than 100ms even for downtime-limit 1ms.
Use qemu_cond_timedwait for high percentage to wake up during vm_stop.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 cpus.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/cpus.c b/cpus.c
index 85cd451a86..d2c61ff155 100644
--- a/cpus.c
+++ b/cpus.c
@@ -77,6 +77,8 @@
=20
 #endif /* CONFIG_LINUX */
=20
+static QemuMutex qemu_global_mutex;
+
 int64_t max_delay;
 int64_t max_advance;
=20
@@ -782,7 +784,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on=
_cpu_data opaque)
 {
     double pct;
     double throttle_ratio;
-    long sleeptime_ns;
+    int64_t sleeptime_ns, endtime_ns;
=20
     if (!cpu_throttle_get_percentage()) {
         return;
@@ -790,11 +792,20 @@ static void cpu_throttle_thread(CPUState *cpu, run_=
on_cpu_data opaque)
=20
     pct =3D (double)cpu_throttle_get_percentage()/100;
     throttle_ratio =3D pct / (1 - pct);
-    sleeptime_ns =3D (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
-
-    qemu_mutex_unlock_iothread();
-    g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call *=
/
-    qemu_mutex_lock_iothread();
+    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
+    sleeptime_ns =3D (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_N=
S + 1);
+    endtime_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns=
;
+    while (sleeptime_ns > 0 && !cpu->stop) {
+        if (sleeptime_ns > SCALE_MS) {
+            qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
+                                sleeptime_ns / SCALE_MS);
+        } else {
+            qemu_mutex_unlock_iothread();
+            g_usleep(sleeptime_ns / SCALE_US);
+            qemu_mutex_lock_iothread();
+        }
+        sleeptime_ns =3D endtime_ns - qemu_clock_get_ns(QEMU_CLOCK_REALT=
IME);
+    }
     atomic_set(&cpu->throttle_thread_scheduled, 0);
 }
=20
@@ -1172,8 +1183,6 @@ static void qemu_init_sigbus(void)
 }
 #endif /* !CONFIG_LINUX */
=20
-static QemuMutex qemu_global_mutex;
-
 static QemuThread io_thread;
=20
 /* cpu creation */
--=20
2.22.0


