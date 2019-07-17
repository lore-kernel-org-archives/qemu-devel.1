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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA2FC76188
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4817D20818
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 02:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgTY3C5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4817D20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnZlq-0002dx-Vo
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 22:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53055)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlO-0001BS-7h
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shirley17fei@gmail.com>) id 1hnZlN-0006Er-6s
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43261)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
 id 1hnZlN-0006EN-16
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 22:33:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id i189so10041848pfg.10
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 19:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0e/ngLNRrmzCNyqP64QJRvjo9UERFAOaH0yurKB6MKM=;
 b=VgTY3C5FlBFNP+zsNZptHLjdSr7Bm7rJIgpOJipQqkimKQfIygNwZ9Z7p/fZT4yTj1
 cs8PIbmiN0P7WgdYbeNWjrmzeUzWXNLI2pqmMerMXoZd8Xyqyi0s3d35zNFku5oFAS7C
 xnmxxae6+nMWJkdKMM+z7TUxT13+KQcKYmazM1EVx7Y/GX16ReCeh8CYAWVUotB7vH0O
 bYojWkJnF3OD9btXxsx7+1Ztl01try/XVStZCAla6OZ3UJX0aoLF2Tp1KspPrmTt4g2Z
 V/D6XAlISlyqmklPFS1T+HQgXK6hr2QScG5+W/3vilVsasDkov1+byb8RoOO+ArHQmF4
 rK2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0e/ngLNRrmzCNyqP64QJRvjo9UERFAOaH0yurKB6MKM=;
 b=pXDnokEBJyiHQbW3awQT3p/ObGOa8jRpVeLQLCkYS8hP+DrtoSY6yeiAmVK+RZJkPW
 VwDhNL5SCp5dzA8t7R1QpclksG5DDmiYs6RINFRjkgsfwKvBcL64uAfcZC6b3p+WdObC
 VgwQjRhKoBCXnO6IxqyRKnyXnhL0vn7Ipzsv1x6WJv0l+TdO2ajhkxlO/MGAipSnnM4B
 6x3CAsyVWl3ywgrSo3DprxtVh1+/5jBUZ9edJ6NjGT5Lr62D5GHxIsxS7QEAUmvgh2vH
 naZuY7xYdGbovcD5vuXzPGlJlreL5ma5sE7RHUPYoNfDFeT18jy4b21f+ATxzlh7Cte/
 Bu+g==
X-Gm-Message-State: APjAAAWWSUD/9UWiGpywq9GHzXc8AiT3AJwPToV/hMO+woYHBtKqlUH8
 VcFcKmSGPb5HP+KUB0+pByYWZLBK
X-Google-Smtp-Source: APXvYqwThnvZOBaddq+r3mDPCL8uVk7NraVd+t0OgZQw75Lxm+c4AN/CJ3QYpT8nTi6TBia6IJX4UQ==
X-Received: by 2002:a17:90a:346c:: with SMTP id
 o99mr39834390pjb.20.1563330827879; 
 Tue, 16 Jul 2019 19:33:47 -0700 (PDT)
Received: from n3-021-211.byted.org ([49.7.44.72])
 by smtp.gmail.com with ESMTPSA id b1sm20986530pfi.91.2019.07.16.19.33.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 19:33:46 -0700 (PDT)
From: Fei Li <shirley17fei@gmail.com>
To: qemu-devel@nongnu.org,
	shirley17fei@gmail.com
Date: Wed, 17 Jul 2019 10:33:05 +0800
Message-Id: <20190717023310.197246-7-shirley17fei@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190717023310.197246-1-shirley17fei@gmail.com>
References: <20190717023310.197246-1-shirley17fei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v14 06/11] qemu_thread: supplement error
 handling for emulated_realize
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
Cc: Christophe Fergeau <cfergeau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Fei Li <fli@suse.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fei Li <fli@suse.com>

Utilize the existed errp to propagate the error and do the
corresponding cleanup to replace the temporary &error_abort.
If the second thread fails to be created, use a VEvent to
cancel the first thread before the join().

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Christophe Fergeau <cfergeau@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Fei Li <fli@suse.com>
---
 hw/usb/ccid-card-emulated.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 4d95ee07aa..bdf1971e6b 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -545,11 +545,18 @@ static void emulated_realize(CCIDCardState *base, Error **errp)
         error_setg(errp, "%s: failed to initialize vcard", TYPE_EMULATED_CCID);
         goto out2;
     }
-    /* TODO: let the further caller handle the error instead of abort() here */
-    qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
-                       card, QEMU_THREAD_JOINABLE, &error_abort);
-    qemu_thread_create(&card->apdu_thread_id, "ccid/apdu", handle_apdu_thread,
-                       card, QEMU_THREAD_JOINABLE, &error_abort);
+    if (qemu_thread_create(&card->event_thread_id, "ccid/event", event_thread,
+                           card, QEMU_THREAD_JOINABLE, errp) < 0) {
+        goto out2;
+    }
+    if (qemu_thread_create(&card->apdu_thread_id, "ccid/apdu",
+                           handle_apdu_thread, card,
+                           QEMU_THREAD_JOINABLE, errp) < 0) {
+        VEvent *vevent = vevent_new(VEVENT_LAST, NULL, NULL);
+        vevent_queue_vevent(vevent); /* stop vevent thread */
+        qemu_thread_join(&card->event_thread_id);
+        goto out2;
+    }
 
     return;
 
-- 
2.11.0


