Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1051AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:11:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30AE2187F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30AE2187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiin4-0006SF-5l
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiilu-0005BW-BT
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiilr-00020m-RY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:10:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiilq-0001zR-9P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:10:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E87503082B69
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 17:10:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-140.brq.redhat.com [10.40.204.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4DBE21001B14;
 Wed,  3 Jul 2019 17:10:07 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  3 Jul 2019 19:10:05 +0200
Message-Id: <20190703171005.26231-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 03 Jul 2019 17:10:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can pass trace trace options with the -trace command line
argument.

Tracing might be useful when running qtests. To avoid to have
to modify the tests and recompile, add the possibility to pass
trace options via the shell environment.

We add:
- QEMU_TRACE_EVENTS:    List of events to enable (coma separated)
- QEMU_TRACE_EVENTFILE: File with list of events to enable
- QEMU_TRACE_LOGFILE:   File to log the trace events.

Example of use:

  $ QEMU_TRACE_EVENTS=3Dpl011\* make check-qtest-arm
    TEST    check-qtest-arm: tests/boot-serial-test
  18650@1562168430.027490:pl011_can_receive LCR 0x00000000 read_count 0 r=
eturning 1
  18650@1562168430.027535:pl011_can_receive LCR 0x00000000 read_count 0 r=
eturning 1
  18650@1562168430.027544:pl011_can_receive LCR 0x00000000 read_count 0 r=
eturning 1
  18650@1562168430.028037:pl011_can_receive LCR 0x00000000 read_count 0 r=
eturning 1
  18650@1562168430.028049:pl011_can_receive LCR 0x00000000 read_count 0 r=
eturning 1
  18650@1562168430.028057:pl011_can_receive LCR 0x00000000 read_count 0 r=
eturning 1
  18653@1562168430.053250:pl011_write addr 0x00000000 value 0x00000054
  18653@1562168430.053276:pl011_irq_state irq state 0
  [...]

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
I'm not sure where to document that...
---
 trace/control.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/trace/control.c b/trace/control.c
index 43fb7868db..aea802623c 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -288,6 +288,8 @@ void trace_fini_vcpu(CPUState *vcpu)
=20
 bool trace_init_backends(void)
 {
+    char *trace_env;
+
 #ifdef CONFIG_TRACE_SIMPLE
     if (!st_init()) {
         fprintf(stderr, "failed to initialize simple tracing backend.\n"=
);
@@ -306,6 +308,13 @@ bool trace_init_backends(void)
     openlog(NULL, LOG_PID, LOG_DAEMON);
 #endif
=20
+    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
+    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
+    trace_env =3D getenv("QEMU_TRACE_EVENTS");
+    if (trace_env) {
+        trace_enable_events(trace_env);
+    }
+
     return true;
 }
=20
--=20
2.20.1


