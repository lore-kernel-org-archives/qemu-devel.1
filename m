Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42826C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D62020838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="i2Xdgw/t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D62020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8s7-0002Ft-3Y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47440)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl8pe-0008Ak-8c
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1hl8pc-0007sg-Ls
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:10 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1hl8pb-0007l9-St
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:24:08 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 6A6922E0A7B;
 Wed, 10 Jul 2019 12:24:03 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net
 [2a02:6b8:0:1472:2741:0:8b6:10])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 X8sHBziPgT-O2t030o3; Wed, 10 Jul 2019 12:24:03 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1562750643; bh=iNLAWaDyxeZFg8sfSzat7F4C9cqCNn/ipANDNCAdqNw=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=i2Xdgw/tTAx2HWOUSXLtnWVLvbl4/YDJSkB6cHeYvxA3cXMEMnV88AohiruJSbweR
 9LhzNLCbAHRH2UhRafw9IX1I/SxFD91yK0LLq4IW02ZFgj2CnLAQAirqV4jz+1pe2l
 l+sd0xaRv/D4xttWvLHqCS+1PmqJaXLhoUXDOJdM=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:649c:ccd6:daab:d003])
 by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 c6HGiW8rtf-O2waPrXp; Wed, 10 Jul 2019 12:24:02 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Weil <sw@weilnetz.de>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Wed, 10 Jul 2019 12:23:38 +0300
Message-Id: <20190710092338.23559-3-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
References: <20190710092338.23559-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [RFC PATCH 2/2] cpus: Fix throttling during vm_stop
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
Cc: "open list:Overall" <qemu-devel@nongnu.org>, yc-core@yandex-team.ru
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
 cpus.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/cpus.c b/cpus.c
index ffc57119ca..3c069cdc33 100644
--- a/cpus.c
+++ b/cpus.c
@@ -74,6 +74,8 @@
=20
 #endif /* CONFIG_LINUX */
=20
+static QemuMutex qemu_global_mutex;
+
 int64_t max_delay;
 int64_t max_advance;
=20
@@ -776,7 +778,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on=
_cpu_data opaque)
 {
     double pct;
     double throttle_ratio;
-    long sleeptime_ns;
+    int64_t sleeptime_ns;
=20
     if (!cpu_throttle_get_percentage()) {
         return;
@@ -784,11 +786,22 @@ static void cpu_throttle_thread(CPUState *cpu, run_=
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
+
+    while (sleeptime_ns >=3D SCALE_MS && !cpu->stop) {
+        int64_t start, end;
+        start =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+        qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
+                            sleeptime_ns / SCALE_MS);
+        end =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+        sleeptime_ns -=3D end - start;
+    }
+    if (sleeptime_ns >=3D SCALE_US && !cpu->stop) {
+        qemu_mutex_unlock_iothread();
+        g_usleep(sleeptime_ns / SCALE_US);
+        qemu_mutex_lock_iothread();
+    }
     atomic_set(&cpu->throttle_thread_scheduled, 0);
 }
=20
@@ -1166,8 +1179,6 @@ static void qemu_init_sigbus(void)
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


