Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95ACC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B9E20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwCpgJ1j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B9E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZmr-00079E-5q
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53087)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlS-0001S2-6s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlR-0006Hq-5A
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:54 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39835)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlQ-0006HI-Ud
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id u17so10369854pgi.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VM7YAJwry+wyZ2yuE+WkugvtQMJfdLiPFMhwqCS6SXA=;
 b=AwCpgJ1jy+igCKsUWWOo+oZNqPZgx31GZusSNWrwJpHO6kHb+xE5oWBxgqncc7INiC
 inryyUtPHeUBUmFWbu5gYzyw3SP2izEyK5UJGnaKMtav26WacuVlVOQCDNhdHvxAUs8J
 mQIGQ+zfgF26CwZbiPlus1j7Q6qvRz4dr3ow2UW1V+tBJNPcTSRK+gaxyxkw07ILEVgq
 f3s+9034EVU3MJ5lPIAZW8MQhaWaBwQ68QwD+zgB2RgwofJrD+dKUX9Qalfldtdu6UP5
 Vu1DzRlZ3/63CmVHxzTJjX1GSh3G34b1jJYvE9SBYRi2XUz8eFaKf97WlN2CJ4Zr/yS7
 E3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VM7YAJwry+wyZ2yuE+WkugvtQMJfdLiPFMhwqCS6SXA=;
 b=bdklQZ2JfG3HFT9rjRRLpznTd27flR3bgP5tmCk+rnAJULzqw4STfCZ1pVkatkCfmB
 5OazCIYRlbCEoCXVR3yZMRu+kjRN6hcWn+iMHcMaQ0+2JwxjYet3X3xVsR39Pf0YbHp7
 77xV/kJhxl9Cmqo7nvBZKZbIhLSskXza11UxzlK5zqv3R9jLfAV/aWKf+ChZLh8/fWO7
 OriNyLD7CdP3neoWjgLXr8xJLMQSZLzVcxDCm3Vuoe5zbotOmpvtXfrp5xyLYKBi9RA+
 0fzgs7kdCoDcwazMKZ98or4kiw6lRKBb2N4UICgRcUDJ9cm3kpKosKaaunXT5qTB7xOK
 wgNA==
X-Gm-Message-State: APjAAAWkkyqIJKMKDmUOImZs1CNsdABlkzxRBxuaHJnHC60VEa2cCC9h
 Sc8dhwWEKQpMxC4c7eSRPbmr4hJ3
X-Google-Smtp-Source: APXvYqx52Lkfej/uv7TQ0xluHXOfs3fh8G8OLSMq4JZQ3RDPh0ms84JK2QeUZUCL3YN4oE4u1L8iDg==
X-Received: by 2002:a65:4103:: with SMTP id w3mr25808719pgp.1.1563330831645;
 Tue, 16 Jul 2019 19:33:51 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:50 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:06 +0800
Message-Id: <20190717023310.197246-8-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v14 07/11] qemu_thread: supplement error
 handling for iothread_complete
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error and do the
corresponding cleanup to replace the temporary &error_abort.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 iothread.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/iothread.c b/iothread.c
index 2d5a5bfe6c..1ebacaf089 100644
--- a/iothread.c
+++ b/iothread.c
@@ -166,6 +166,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
     Error *local_error = NULL;
     IOThread *iothread = IOTHREAD(obj);
     char *name, *thread_name;
+    int thread_ok;
 
     iothread->stopping = false;
     iothread->running = true;
@@ -188,9 +189,7 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
                                 &local_error);
     if (local_error) {
         error_propagate(errp, local_error);
-        aio_context_unref(iothread->ctx);
-        iothread->ctx = NULL;
-        return;
+        goto fail;
     }
 
     /* This assumes we are called from a thread with useful CPU affinity for us
@@ -198,16 +197,23 @@ static void iothread_complete(UserCreatable *obj, Error **errp)
      */
     name = object_get_canonical_path_component(OBJECT(obj));
     thread_name = g_strdup_printf("IO %s", name);
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&iothread->thread, thread_name, iothread_run,
-                       iothread, QEMU_THREAD_JOINABLE, &error_abort);
+    thread_ok = qemu_thread_create(&iothread->thread, thread_name, iothread_run,
+                                   iothread, QEMU_THREAD_JOINABLE, errp);
     g_free(thread_name);
     g_free(name);
+    if (thread_ok < 0) {
+        qemu_sem_destroy(&iothread->init_done_sem);
+        goto fail;
+    }
 
     /* Wait for initialization to complete */
     while (iothread->thread_id == -1) {
         qemu_sem_wait(&iothread->init_done_sem);
     }
+    return;
+fail:
+    aio_context_unref(iothread->ctx);
+    iothread->ctx = NULL;
 }
 
 typedef struct {
-- 
2.11.0


