Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DCAC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:47:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B6121852
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arT9LUaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B6121852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tE8-0005Io-2w
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sD0-0006ZJ-GB
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCy-0007VQ-NN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCy-0007V1-8p
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id l11so39145167wrx.5
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=cYGflcnLYW7UqqaIj7H9EUpz5deH3v/RJ+Xg1QiY1Lo=;
 b=arT9LUaGEBE0a/oPLB1rrIChwmhT1k9ov5UTXsM7GHYpKNdjEOcCWMyioyQl4cpjm1
 cI452Abyjrws+FOvvdbuba/w2ZlHk/JtUaV3ptU44pus2FtvIaoSv7KyTbXTSJi3mr+a
 dPXCH7YWoPw8tRwjV37pOmqXkkwRYjvFtMD/6Rq2nmmN69mTM9sleMXK03+R+1mcFABe
 f3POTnpbEBa8QJtXrfMKGOvPpqs5ggCKP9OdYStgVVoNbkXewlI64299+bOL8M1wG9nr
 LUg4XNBVbs5KjVaPXyCFUPjGt+UfjLH715Zc3iD9dLCbLVIUfVpacRqgKdxlB8z04nvC
 Xj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=cYGflcnLYW7UqqaIj7H9EUpz5deH3v/RJ+Xg1QiY1Lo=;
 b=Ga2qbS+3RjaPuAVEUPyINag1fyqFXDsrsCRZTYy5oslmrhKwtXzfQwI95R26HvSKWA
 HFqEgWzA/4lBNak1AdyxblmeKvL7X4Jf0DAARE21/vNqzruH5HXigpt5VpwkKMBHnFWz
 I8GrqyDvp3Q9tKj37Jsgig1LZLegtQ+KocHOf8AP0qxyhvlaMSguOZiQaQTm5bP5NsZC
 Q5I50k3g+mteDZCaLTuj0q/iLbptcd0T17Bqv/v6shXv8ZHVICtJypupZlpkNRW/F26a
 V/C4EiUpqvlAzVZRdAq0oRt/Ppvn9BmwUNQGxoF5S8mdoKYFak8vA8HPhW70mFvmIY63
 lFoQ==
X-Gm-Message-State: APjAAAUbKUxyFrfI2kd4jXhuxk1l90kAg6HwZ37OWo5ZKtcN7P9sa9Hj
 hh6NzJCX2wFAceRgM2+VsF8+JpmG
X-Google-Smtp-Source: APXvYqwSiIjFdXfCQUwB5bWGHgvEECnLPIv6U22bV8ptt5N5yVIcnVNXVXcqArp/CON1CNGIayevUA==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr111270wrs.268.1568644946700; 
 Mon, 16 Sep 2019 07:42:26 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:54 +0200
Message-Id: <1568644929-9124-15-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 14/29] cpus: Fix throttling during vm_stop
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

Throttling thread sleeps in VCPU thread. For high throttle percentage
this sleep is more than 10ms. E.g. for 60% - 15ms, for 99% - 990ms.
vm_stop() kicks all VCPUs and waits for them. It's called at the end of
migration and because of the long sleep the migration downtime might be
more than 100ms even for downtime-limit 1ms.
Use qemu_cond_timedwait for high percentage to wake up during vm_stop.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190909131335.16848-3-yury-kotov@yandex-team.ru>
---
 cpus.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/cpus.c b/cpus.c
index 85cd451..d2c61ff 100644
--- a/cpus.c
+++ b/cpus.c
@@ -77,6 +77,8 @@
 
 #endif /* CONFIG_LINUX */
 
+static QemuMutex qemu_global_mutex;
+
 int64_t max_delay;
 int64_t max_advance;
 
@@ -782,7 +784,7 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
 {
     double pct;
     double throttle_ratio;
-    long sleeptime_ns;
+    int64_t sleeptime_ns, endtime_ns;
 
     if (!cpu_throttle_get_percentage()) {
         return;
@@ -790,11 +792,20 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_cpu_data opaque)
 
     pct = (double)cpu_throttle_get_percentage()/100;
     throttle_ratio = pct / (1 - pct);
-    sleeptime_ns = (long)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS);
-
-    qemu_mutex_unlock_iothread();
-    g_usleep(sleeptime_ns / 1000); /* Convert ns to us for usleep call */
-    qemu_mutex_lock_iothread();
+    /* Add 1ns to fix double's rounding error (like 0.9999999...) */
+    sleeptime_ns = (int64_t)(throttle_ratio * CPU_THROTTLE_TIMESLICE_NS + 1);
+    endtime_ns = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
+    while (sleeptime_ns > 0 && !cpu->stop) {
+        if (sleeptime_ns > SCALE_MS) {
+            qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
+                                sleeptime_ns / SCALE_MS);
+        } else {
+            qemu_mutex_unlock_iothread();
+            g_usleep(sleeptime_ns / SCALE_US);
+            qemu_mutex_lock_iothread();
+        }
+        sleeptime_ns = endtime_ns - qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
+    }
     atomic_set(&cpu->throttle_thread_scheduled, 0);
 }
 
@@ -1172,8 +1183,6 @@ static void qemu_init_sigbus(void)
 }
 #endif /* !CONFIG_LINUX */
 
-static QemuMutex qemu_global_mutex;
-
 static QemuThread io_thread;
 
 /* cpu creation */
-- 
1.8.3.1



