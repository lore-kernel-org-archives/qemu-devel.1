Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC5721D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9hXj/tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC5721D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMtKD-0000kt-Li
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMt1X-00058O-2e
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47328)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kMt1U-0002Wf-R6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 09:16:58 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601299016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KcMH1Z9iD7wiLLoErtbSM8e7hIQfnJtCz/BdBnjIoDE=;
 b=E9hXj/ttOOKVUCJG6roNSkkTk8AnquaBKgaze5C7IfMgcrf37nDuoW+18NLxDSOAxZb4Si
 DeRqeuwLimqYpl14P32V178NwM3KUSTKJ+WWgzWgb8orkp2HGjx4Y6CLfOq83n1kt5L3Re
 TLGwyaCTI5GqokblaDJbQMteUA+/YwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Id_Xj7YtP72JGDc9kX_n4A-1; Mon, 28 Sep 2020 09:16:52 -0400
X-MC-Unique: Id_Xj7YtP72JGDc9kX_n4A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50C161835A00;
 Mon, 28 Sep 2020 13:16:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BFABD55771;
 Mon, 28 Sep 2020 13:16:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9353E40845; Mon, 28 Sep 2020 15:16:38 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] hw/usb: Use lock guard macros
Date: Mon, 28 Sep 2020 15:16:38 +0200
Message-Id: <20200928131638.9486-6-kraxel@redhat.com>
In-Reply-To: <20200928131638.9486-1-kraxel@redhat.com>
References: <20200928131638.9486-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Amey Narkhede <ameynarkhede03@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Amey Narkhede <ameynarkhede03@gmail.com>

Use qemu LOCK_GUARD macros from "qemu/lockable.h" in
hw/usb/ccid-card-emulated.c, saves manual unlock calls.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200923134327.576139-1-ameynarkhede03@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/ccid-card-emulated.c | 54 ++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 5e4649d36700..2d566f7db104 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -30,6 +30,7 @@
 #include <libcacard.h>
 
 #include "qemu/thread.h"
+#include "qemu/lockable.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "ccid.h"
@@ -244,34 +245,34 @@ static void *handle_apdu_thread(void* arg)
             card->quit_apdu_thread = 0; /* debugging */
             break;
         }
-        qemu_mutex_lock(&card->vreader_mutex);
-        while (!QSIMPLEQ_EMPTY(&card->guest_apdu_list)) {
-            event = QSIMPLEQ_FIRST(&card->guest_apdu_list);
-            assert((unsigned long)event > 1000);
-            QSIMPLEQ_REMOVE_HEAD(&card->guest_apdu_list, entry);
-            if (event->p.data.type != EMUL_GUEST_APDU) {
-                DPRINTF(card, 1, "unexpected message in handle_apdu_thread\n");
+        WITH_QEMU_LOCK_GUARD(&card->vreader_mutex) {
+            while (!QSIMPLEQ_EMPTY(&card->guest_apdu_list)) {
+                event = QSIMPLEQ_FIRST(&card->guest_apdu_list);
+                assert((unsigned long)event > 1000);
+                QSIMPLEQ_REMOVE_HEAD(&card->guest_apdu_list, entry);
+                if (event->p.data.type != EMUL_GUEST_APDU) {
+                    DPRINTF(card, 1, "unexpected message in handle_apdu_thread\n");
+                    g_free(event);
+                    continue;
+                }
+                if (card->reader == NULL) {
+                    DPRINTF(card, 1, "reader is NULL\n");
+                    g_free(event);
+                    continue;
+                }
+                recv_len = sizeof(recv_data);
+                reader_status = vreader_xfr_bytes(card->reader,
+                        event->p.data.data, event->p.data.len,
+                        recv_data, &recv_len);
+                DPRINTF(card, 2, "got back apdu of length %d\n", recv_len);
+                if (reader_status == VREADER_OK) {
+                    emulated_push_response_apdu(card, recv_data, recv_len);
+                } else {
+                    emulated_push_error(card, reader_status);
+                }
                 g_free(event);
-                continue;
             }
-            if (card->reader == NULL) {
-                DPRINTF(card, 1, "reader is NULL\n");
-                g_free(event);
-                continue;
-            }
-            recv_len = sizeof(recv_data);
-            reader_status = vreader_xfr_bytes(card->reader,
-                    event->p.data.data, event->p.data.len,
-                    recv_data, &recv_len);
-            DPRINTF(card, 2, "got back apdu of length %d\n", recv_len);
-            if (reader_status == VREADER_OK) {
-                emulated_push_response_apdu(card, recv_data, recv_len);
-            } else {
-                emulated_push_error(card, reader_status);
-            }
-            g_free(event);
         }
-        qemu_mutex_unlock(&card->vreader_mutex);
     }
     return NULL;
 }
@@ -365,7 +366,7 @@ static void card_event_handler(EventNotifier *notifier)
     EmulEvent *event, *next;
 
     event_notifier_test_and_clear(&card->notifier);
-    qemu_mutex_lock(&card->event_list_mutex);
+    QEMU_LOCK_GUARD(&card->event_list_mutex);
     QSIMPLEQ_FOREACH_SAFE(event, &card->event_list, entry, next) {
         DPRINTF(card, 2, "event %s\n", emul_event_to_string(event->p.gen.type));
         switch (event->p.gen.type) {
@@ -398,7 +399,6 @@ static void card_event_handler(EventNotifier *notifier)
         g_free(event);
     }
     QSIMPLEQ_INIT(&card->event_list);
-    qemu_mutex_unlock(&card->event_list_mutex);
 }
 
 static int init_event_notifier(EmulatedState *card, Error **errp)
-- 
2.27.0


