Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BBAC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB542082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 12:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCgrlnva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB542082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihBlk-0006pX-Et
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 07:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1ihBki-0005so-AW
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1ihBkg-0001Vy-OI
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:15:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1ihBkg-0001VB-Gr
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 07:14:58 -0500
Received: by mail-wm1-x344.google.com with SMTP id t14so2875426wmi.5
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 04:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LvGv/oA29v3zt0SGusdkh9CXABD727Mt4qfYOd5YuqE=;
 b=cCgrlnva6/4AFedL+p7UWTQL4gS+7t/xWsC1mTFh/FVwlzFp3dzNDNdd0vwTFZeGI0
 w140mzPNWiLN/n9iuw3w+z2xHJxoe6Jrvbj8KGR0WeXGjMXM4I6i1za1waxxon5e06tk
 mLGY/uaexDKUYNuyjzffCsDVra0hPWo6EO7zXkww0rFP1lFMK9RuzLNXJJZ8wFwOwMCI
 94vfHoDBKQawByKQh0P2lc24ixba35LYBctaxtTdsQqiPA8Xnds1TidKKa3jphftmcvg
 T2frAKwS0jjSD4YbJQ5Pm9HiDtkZxeJPpROoPDijh3ELY+f/gLcf83wDW7U5VpaKlIFr
 WEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LvGv/oA29v3zt0SGusdkh9CXABD727Mt4qfYOd5YuqE=;
 b=jAQwf5XJRBXmvJfqw1s5LA5SLt7dtTn8P/S3w5A+sH+YY4vth70L9au35hivwfJwqq
 SIcia8jGZqX0yCdrKyKYN82PfPI/CvAYEx6gy0SA4yRS4fkEWIWj2n/eGMaNClgQu8We
 niR7ztVnUNWHnMf7097CdW6gbNve7axVnqSWIb9WA++asQhg3DgQZjh7AK9gKfCVEnMD
 kD1unDT70CP8vXN5pYSr0a+FanmXsR7fnJ2nNFx5YwrVzOLJcuWQUZzIEq9ki/Dzetza
 54aRB4oLhNMZQF2Bm6ZAuyp0KlscdnKpkftbY6FWeaPeW3/YzuXbbWgLRAj67qecL60+
 I1wQ==
X-Gm-Message-State: APjAAAVdDIxkmzv37yOa12EH+UT9mgLGu+JO9cE95+j5IZ/QVrar07Ht
 uDCXbE0CeIAcdwZytCocWXqYEA==
X-Google-Smtp-Source: APXvYqynFC4g2gwGpazgzNfUAl8dnsKE3kAbFNeAM9sMqC14g9ffpON/axhpIE9jU14bEai6hMz3fA==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr4838878wmg.95.1576584896241; 
 Tue, 17 Dec 2019 04:14:56 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u22sm26484597wru.30.2019.12.17.04.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 04:14:54 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 22B6F1FF87;
 Tue, 17 Dec 2019 12:14:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] semihosting: suspend recieving CPU when blocked (HACK,
 WIP)
Date: Tue, 17 Dec 2019 12:14:43 +0000
Message-Id: <20191217121443.14757-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
References: <77dd4863-6301-b17d-529c-451d491d4794@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: pbonzini@redhat.com, keithp@keithp.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sleeping in the semihosting code is problematic as we deadlock the
whole system. This includes issuing a "quit" via the HMP or presumably
if gdbserver got involved. What we really want is to return to the
main loop and gt woken up when there is data to process. We can then
re-execute the instruction which will succeed this time.

[AJB:

So this at least solves the hang of not being able to quit system
emulation while blocked. However there are two things we still need to
ensure:

 - the PC has not advanced until completion so we can redo the instruction
 - we actually wake up the CPU in console_read

In my testcase console_read never seems to get called. I've tried with
both an external pipe loopback and using the ringbuf:

qemu-system-aarch64 -M virt --display none -cpu cortex-a57 -kernel systest-a64-with-console.axf -semihosting-config
 enable=on,chardev=sh0 -serial mon:stdio -chardev ringbuf,logfile=foo,id=sh0

]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/cpu-all.h   |  1 +
 hw/semihosting/console.c | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e96781a4559..093d7a76edd 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -31,6 +31,7 @@
 #define EXCP_HALTED     0x10003 /* cpu is halted (waiting for external event) */
 #define EXCP_YIELD      0x10004 /* cpu wants to yield timeslice to another */
 #define EXCP_ATOMIC     0x10005 /* stop-the-world and emulate atomic */
+#define EXCP_BLOCKED    0x10006 /* cpu is blocked (semihosting) */
 
 /* some important defines:
  *
diff --git a/hw/semihosting/console.c b/hw/semihosting/console.c
index 4db68d62270..bda457a0608 100644
--- a/hw/semihosting/console.c
+++ b/hw/semihosting/console.c
@@ -20,6 +20,7 @@
 #include "hw/semihosting/semihost.h"
 #include "hw/semihosting/console.h"
 #include "exec/gdbstub.h"
+#include "exec/exec-all.h"
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include <pthread.h>
@@ -109,50 +110,49 @@ void qemu_semihosting_console_outc(CPUArchState *env, target_ulong addr)
 
 typedef struct SemihostingConsole {
     CharBackend         backend;
-    pthread_mutex_t     mutex;
-    pthread_cond_t      cond;
+    CPUState            *sleeping_cpu;
     bool                got;
     Fifo8               fifo;
 } SemihostingConsole;
 
-static SemihostingConsole console = {
-    .mutex = PTHREAD_MUTEX_INITIALIZER,
-    .cond = PTHREAD_COND_INITIALIZER
-};
+static SemihostingConsole console;
 
 static int console_can_read(void *opaque)
 {
     SemihostingConsole *c = opaque;
     int ret;
-    pthread_mutex_lock(&c->mutex);
+    g_assert(qemu_mutex_iothread_locked());
     ret = (int) fifo8_num_free(&c->fifo);
-    pthread_mutex_unlock(&c->mutex);
     return ret;
 }
 
 static void console_read(void *opaque, const uint8_t *buf, int size)
 {
     SemihostingConsole *c = opaque;
-    pthread_mutex_lock(&c->mutex);
+    g_assert(qemu_mutex_iothread_locked());
     while (size-- && !fifo8_is_full(&c->fifo)) {
         fifo8_push(&c->fifo, *buf++);
     }
-    pthread_cond_broadcast(&c->cond);
-    pthread_mutex_unlock(&c->mutex);
+    if (c->sleeping_cpu) {
+        cpu_resume(c->sleeping_cpu);
+    }
 }
 
 target_ulong qemu_semihosting_console_inc(CPUArchState *env)
 {
     uint8_t ch;
     SemihostingConsole *c = &console;
-    qemu_mutex_unlock_iothread();
-    pthread_mutex_lock(&c->mutex);
-    while (fifo8_is_empty(&c->fifo)) {
-        pthread_cond_wait(&c->cond, &c->mutex);
+    g_assert(qemu_mutex_iothread_locked());
+    g_assert(current_cpu);
+    if (fifo8_is_empty(&c->fifo)) {
+        c->sleeping_cpu = current_cpu;
+        c->sleeping_cpu->stop = true;
+        c->sleeping_cpu->exception_index = EXCP_BLOCKED;
+        cpu_loop_exit(c->sleeping_cpu);
+        /* never returns */
     }
+    c->sleeping_cpu = NULL;
     ch = fifo8_pop(&c->fifo);
-    pthread_mutex_unlock(&c->mutex);
-    qemu_mutex_lock_iothread();
     return (target_ulong) ch;
 }
 
-- 
2.20.1


