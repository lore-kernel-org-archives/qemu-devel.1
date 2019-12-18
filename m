Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FABDC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079EC2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkbC5IyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079EC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYmt-0004Bc-NI
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3h-00076e-E8
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3g-0002fp-4e
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:05 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51515)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3f-0002cR-Q1
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id d73so1564076wmd.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PMUWoCpuqKP+tFU4xIk4lPZAxU6QOkIu0guoobq7qFU=;
 b=ZkbC5IyIou4nJ01fjN74/JoWx54TLPr4hibIPZ9IlIO6EykiHaQVukqbynsiwioBPU
 9xiM1B6LVfUfciOSHraHB1LRK+2Pnit/KymcWhDTEDAHT3WDOXIgv/qKIgvZpvTxxnN4
 tnLh58yrdCxFpSTzEpLBWe0RKi9gXq6m89o5svWe6jmd0UYy2pId3J4zplxrSfUsM4j8
 lUmINcHq6OmVhn7DIOj3sGvJIGzxj95Cj4ljQsxg7g3270raIEyuosEplJy4D4HBKpfz
 0Be8/XGl+oPNYRQr7sUD8lM0grjduYvjNoM5yPOnacI7NIKSG6Ff8smRGW9XIc9XFp1f
 MUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=PMUWoCpuqKP+tFU4xIk4lPZAxU6QOkIu0guoobq7qFU=;
 b=Gb/SzHNs81Vxf8SkMxF1mFBb+eyhSLMvEBUxqj4YON1M7noF9cbm76upJyr+5EleA6
 b7IcAy8UzFWFszv85gSIYu9Rb6hcq9TpL9eWPE688RfLe21rh4/oj/YT4HIB64zgatm0
 f8LBsOh9duXH9a5kfx6d73ECBaXVHK3MiT2lDbAxlN+PCq7+I2MtQLdYv3bPFN3ql8Qk
 pK8YmV1Fu9/V142c9iNzxpWXvp6/nHmTN08iep9utIgTB+WnaAq3777IDuXO0iEY/LK4
 w12ekr53HnRX24YXmjX7436yUzblonVVSqGTYhMBxe63qExzKZmbjYtl3HHqdSYSoTzt
 mxYg==
X-Gm-Message-State: APjAAAWp+oPv2XZhaKv1j20lK+PHKrwksNZqPeN0E5uA1HiWMEu0UtBp
 nSlGvbkHJs+YI/3O/7bmIcO8PJjx
X-Google-Smtp-Source: APXvYqydfsrLM1JR2rtTjcc0ucVHhvXnxLajZqRezAQz+XkwORV7OdQkWhneuFpqzki6TE7Fk4BTdA==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr3026723wmg.34.1576670642647; 
 Wed, 18 Dec 2019 04:04:02 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/87] hyperv: Use auto rcu_read macros
Date: Wed, 18 Dec 2019 13:02:25 +0100
Message-Id: <1576670573-48048-60-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
to replace the manual rcu_read_(un)lock calls.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 6ebf31c..da8ce82 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -546,14 +546,14 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
     }
 
     ret = HV_STATUS_INVALID_CONNECTION_ID;
-    rcu_read_lock();
-    QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
-        if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
-            ret = mh->handler(msg, mh->data);
-            break;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
+            if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
+                ret = mh->handler(msg, mh->data);
+                break;
+            }
         }
     }
-    rcu_read_unlock();
 
 unmap:
     cpu_physical_memory_unmap(msg, len, 0, 0);
@@ -619,7 +619,6 @@ int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
 
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
-    uint16_t ret;
     EventFlagHandler *handler;
 
     if (unlikely(!fast)) {
@@ -645,15 +644,12 @@ uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
         return HV_STATUS_INVALID_HYPERCALL_INPUT;
     }
 
-    ret = HV_STATUS_INVALID_CONNECTION_ID;
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     QLIST_FOREACH_RCU(handler, &event_flag_handlers, link) {
         if (handler->conn_id == param) {
             event_notifier_set(handler->notifier);
-            ret = 0;
-            break;
+            return 0;
         }
     }
-    rcu_read_unlock();
-    return ret;
+    return HV_STATUS_INVALID_CONNECTION_ID;
 }
-- 
1.8.3.1



