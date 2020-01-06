Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306EEC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1B52075A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKX3bFOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1B52075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioTw9-000086-4y
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioTdm-0001pT-5q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioTdk-0002Y2-KW
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:45:57 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioTdk-0002XI-BX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:45:56 -0500
Received: by mail-wr1-x443.google.com with SMTP id d16so49872634wre.10
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nezePDIoKL9YqKg2Drhg7Q51VT90qdtkt9dfDguD9NM=;
 b=xKX3bFOOEMstqpKGkBlo/F0zZHcA2CXFEDE4NYWpXYNWv4LMyY6Gifgdh4Wi4bpsjs
 eCkOUO+CEFW+0IReIhMUeHJDs7mHNiIpD5IcrhhsPv8YzkaCJiBOvkSxszH80Ct28Eto
 YVBv3G7yiBzYQA3lvWDyHhmencJOegSEOUEYRqUamrpO8TdyjNnSydTxWNVN42RIaOP0
 mNR/Cz5p81u1OYsZpdAK60Ha1nL5zDv+F31ec/O/OU4srZ//mqT5a0AHQpPE2+/ob/Sg
 YfM4csOlWmmqM/zks1mvu24TkSb8Vs9s1msv8flLE3MX5yM8lTpJ/bfqgbz/CHZ1BJy1
 CoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nezePDIoKL9YqKg2Drhg7Q51VT90qdtkt9dfDguD9NM=;
 b=eqb7nm+cYGSf9apv1BOO08BdAjm0Dw2KfMThJE8rlqzuGSULppbVa2H/WmK2tYw0ah
 rgclRGysjIw5FXs7jCe/0yoMXfwYodee1s4xpGDNSwCd/uVdOinVtql2iRRlwUuDHHwL
 xXIvv5K1aoUmK6DE899c/QJ6hXMXa5ZtMRLRPQNTJ5e3w0bUQaq7cAegYe50o8pKjFqG
 7ue8GDqLNCyzOFwOo3avcUChQN/mbAkSP6OeCrkVomjS+AeAN3d9N5tcBPNKbSuo3dxA
 FDhvYzrkWZJHTQlBfJDoNHe+sGZ/opbgDVuo0w65FFieC7q0eIE4h0Izaeg6qoImgiTo
 mXqg==
X-Gm-Message-State: APjAAAU1KIqWuXVZlHMku0Tu5X0XFwUM3zokXJSiuIRCiIYIm/UWfwj+
 I2ZUaoYB22tGvXsy2RMNIfz4tMQ+5lp+/g==
X-Google-Smtp-Source: APXvYqyy26J3FMfONcg02o8VjG90VPW6dJegg6pG17RBZk46DGbpxWnCGof90IcNQD42pstwfvPHcg==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr102740787wrj.349.1578321954372; 
 Mon, 06 Jan 2020 06:45:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g7sm72929943wrq.21.2020.01.06.06.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 06:45:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/iothread: Always connect iothread GSource to a
 GMainContext
Date: Mon,  6 Jan 2020 14:45:52 +0000
Message-Id: <20200106144552.7205-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On older versions of glib (anything prior to glib commit 0f056ebe
from May 2019), the implementation of g_source_ref() and
g_source_unref() is not threadsafe for a GSource which is not
attached to a GMainContext.

QEMU's real iothread.c implementation always attaches its
iothread->ctx's GSource to a GMainContext created for that iothread,
so it is OK, but the simple test framework implementation in
tests/iothread.c was not doing this.  This was causing intermittent
assertion failures in the test-aio-multithread subtest
"/aio/multi/mutex/contended" test on the BSD hosts.  (It's unclear
why only BSD seems to have been affected -- perhaps a combination of
the specific glib version being used in the VMs and their happening
to run on a host with a lot of CPUs).

Borrow the iothread_init_gcontext() from the real iothread.c
and add the corresponding cleanup code and the calls to
g_main_context_push/pop_thread_default() so we actually use
the GMainContext we create.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't really have a good understanding of the glib APIs here,
so I'm mostly just cribbing code from the real iothread.c;
review by people who do know the glib/iothread stuff better
welcomed. It does seem to fix the intermittent test failure
on NetBSD, at least, where we were running into an assertion
failure because a g_source_unref() incorrectly thought it
had decremented the refcount to 0 and should delete a context
that was actually still in use.

 tests/iothread.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/iothread.c b/tests/iothread.c
index 13c9fdcd8df..d3a2ee9a014 100644
--- a/tests/iothread.c
+++ b/tests/iothread.c
@@ -21,6 +21,8 @@
 
 struct IOThread {
     AioContext *ctx;
+    GMainContext *worker_context;
+    GMainLoop *main_loop;
 
     QemuThread thread;
     QemuMutex init_done_lock;
@@ -35,6 +37,17 @@ AioContext *qemu_get_current_aio_context(void)
     return my_iothread ? my_iothread->ctx : qemu_get_aio_context();
 }
 
+static void iothread_init_gcontext(IOThread *iothread)
+{
+    GSource *source;
+
+    iothread->worker_context = g_main_context_new();
+    source = aio_get_g_source(iothread_get_aio_context(iothread));
+    g_source_attach(source, iothread->worker_context);
+    g_source_unref(source);
+    iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
+}
+
 static void *iothread_run(void *opaque)
 {
     IOThread *iothread = opaque;
@@ -44,6 +57,20 @@ static void *iothread_run(void *opaque)
     my_iothread = iothread;
     qemu_mutex_lock(&iothread->init_done_lock);
     iothread->ctx = aio_context_new(&error_abort);
+
+    /*
+     * We must connect the ctx to a GMainContext, because in older versions
+     * of glib the g_source_ref()/unref() functions are not threadsafe
+     * on sources without a context.
+     */
+    iothread_init_gcontext(iothread);
+
+    /*
+     * g_main_context_push_thread_default() must be called before anything
+     * in this new thread uses glib.
+     */
+    g_main_context_push_thread_default(iothread->worker_context);
+
     qemu_cond_signal(&iothread->init_done_cond);
     qemu_mutex_unlock(&iothread->init_done_lock);
 
@@ -51,6 +78,7 @@ static void *iothread_run(void *opaque)
         aio_poll(iothread->ctx, true);
     }
 
+    g_main_context_pop_thread_default(iothread->worker_context);
     rcu_unregister_thread();
     return NULL;
 }
@@ -66,6 +94,8 @@ void iothread_join(IOThread *iothread)
 {
     aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
     qemu_thread_join(&iothread->thread);
+    g_main_context_unref(iothread->worker_context);
+    g_main_loop_unref(iothread->main_loop);
     qemu_cond_destroy(&iothread->init_done_cond);
     qemu_mutex_destroy(&iothread->init_done_lock);
     aio_context_unref(iothread->ctx);
-- 
2.20.1


