Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4202C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDEE206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 16:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xb6DoRYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDEE206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQvio-0007J5-4x
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 12:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54038)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveL-0000qS-Cj
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jQveK-0004BI-L6
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43958
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jQveK-00049p-7e
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 12:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587486086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfxPjer3693hNyeNhfCTsgqPk6evPUCTajLlOJ7juug=;
 b=Xb6DoRYKa3qZd9WzVEw9m+aTDPfZsH/B62tLa89BV1ZYlohXg+ds01JpAhevddaJTVa3K5
 CuUj9Hu6qLBRuRZAUfzfKuC4eW/FAHyodwVhk2fMTmFHhENZuSA0cvdWJ7tCM5Bz6OOfg4
 pinZGTmZ7FudUW7P6n3w58MafZpVwCo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-Cw98MCrjM6O0BF4Wks1YIA-1; Tue, 21 Apr 2020 12:21:24 -0400
X-MC-Unique: Cw98MCrjM6O0BF4Wks1YIA-1
Received: by mail-qk1-f197.google.com with SMTP id f187so14601955qkd.11
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 09:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ul0LDfa/tHiLxLabo660k4W93ALf8ff07OzkSYpgBqo=;
 b=q9P0fx6hWfqgHYWbrzCidDvcyt8lSKE2arTzaGHCTLihRZGPtutiOJQVHKgQfRaaz9
 Smsv/f5TU9+BteCM/bX7rWwloJW4rPgHKMuqbwM6io8LM3qeGl3Mw9HFeFhTUvqMBlhc
 45Uro+gtJxB3wfq8iVs/jsPWlcIBGrxTyYDz9pN63FKNyZnIyP5FmkOe/e86lS0OJGrN
 t8QHqsn6tye+yID7emTgfsbI/w7C0h/74DHBO2U/5G1eyh/5eSWbu/8zrtpsJLzLdWoA
 MLSmFTwrAQ9EzTbtfO8a34GN8c7ICCCtzJfZgIwxzLt5c8B0C9nb8kOLaA3cYeeXmxm2
 MYyw==
X-Gm-Message-State: AGi0PubA0CeRL1ntmDmyjveGQS0NXQ3PI17Vv660OMRkdmYko7XWaNbc
 dfKyxB72+e3Kjt4mnSeuY96y51VRmPl65cvgIe0aaIhNA2Lbq4lCz4C6u0w2Olu3azejjI0CcMM
 5ev4tjFTF7duej0s=
X-Received: by 2002:a37:9f47:: with SMTP id i68mr22316537qke.356.1587486084251; 
 Tue, 21 Apr 2020 09:21:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypLLDAMpxE+jbOaakotFGhzVpCp0dQ3NIYrW9cCU826rFnBmgn1FJZN/LXc9VBILD0WxKjJ/UA==
X-Received: by 2002:a37:9f47:: with SMTP id i68mr22316510qke.356.1587486084027; 
 Tue, 21 Apr 2020 09:21:24 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id u17sm2065530qka.0.2020.04.21.09.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 09:21:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/8] cpus: Introduce qemu_cond_timedwait_iothread()
Date: Tue, 21 Apr 2020 12:21:04 -0400
Message-Id: <20200421162108.594796-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200421162108.594796-1-peterx@redhat.com>
References: <20200421162108.594796-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, peterx@redhat.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is the sister function of qemu_cond_wait_iothread().  Use it at the on=
ly
place where we do cond_timedwait() on BQL.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 cpus.c                   | 9 +++++++--
 include/qemu/main-loop.h | 7 +++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/cpus.c b/cpus.c
index 00f6e361af..263eddc8b0 100644
--- a/cpus.c
+++ b/cpus.c
@@ -726,8 +726,8 @@ static void cpu_throttle_thread(CPUState *cpu, run_on_c=
pu_data opaque)
     endtime_ns =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + sleeptime_ns;
     while (sleeptime_ns > 0 && !cpu->stop) {
         if (sleeptime_ns > SCALE_MS) {
-            qemu_cond_timedwait(cpu->halt_cond, &qemu_global_mutex,
-                                sleeptime_ns / SCALE_MS);
+            qemu_cond_timedwait_iothread(cpu->halt_cond,
+                                         sleeptime_ns / SCALE_MS);
         } else {
             qemu_mutex_unlock_iothread();
             g_usleep(sleeptime_ns / SCALE_US);
@@ -1844,6 +1844,11 @@ void qemu_cond_wait_iothread(QemuCond *cond)
     qemu_cond_wait(cond, &qemu_global_mutex);
 }
=20
+void qemu_cond_timedwait_iothread(QemuCond *cond, int ms)
+{
+    qemu_cond_timedwait(cond, &qemu_global_mutex, ms);
+}
+
 static bool all_vcpus_paused(void)
 {
     CPUState *cpu;
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index a6d20b0719..a0e59c5563 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -303,6 +303,13 @@ void qemu_mutex_unlock_iothread(void);
  */
 void qemu_cond_wait_iothread(QemuCond *cond);
=20
+/*
+ * qemu_cond_timedwait_iothread: Wait on condition for the main loop mutex
+ *
+ * This is the same as qemu_cond_wait_iothread() but allows a timeout.
+ */
+void qemu_cond_timedwait_iothread(QemuCond *cond, int ms);
+
 /* internal interfaces */
=20
 void qemu_fd_register(int fd);
--=20
2.24.1


