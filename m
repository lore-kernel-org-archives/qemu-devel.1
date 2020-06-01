Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEDCC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A430D206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deGkgGyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A430D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpSM-0000nO-S7
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMW-0007el-9w
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51368
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMT-0000SD-UV
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+FN1zcapjr0sEz7A/6P3XkfnOZi9u0bL8Y57NhZZIc=;
 b=deGkgGybuWqr3jE7rlsN0oAoVtdx7IqIKK8bhOPRluDN5Di1Nw+P9VUQH76nIUHDpKe/hb
 8Md4LrbTbkDGcL3T6ABByOcDZRjkrt9Yx2XsKGlOaQiJCRYE65+jYVSzcrCvztUbBQSgha
 JdsVL4zaX0RHHfgnLrqAyRvzvIasSOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-kv0ee3l6POSFxU3bf43szw-1; Mon, 01 Jun 2020 14:40:35 -0400
X-MC-Unique: kv0ee3l6POSFxU3bf43szw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5010835B40;
 Mon,  1 Jun 2020 18:40:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BD1010021B3;
 Mon,  1 Jun 2020 18:40:32 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] migration/colo.c: Relaunch failover even if there was an
 error
Date: Mon,  1 Jun 2020 19:40:02 +0100
Message-Id: <20200601184004.272784-11-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 05:35:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

If vmstate_loading is true, secondary_vm_do_failover will set failover
status to FAILOVER_STATUS_RELAUNCH and return success without initiating
failover. However, if there is an error during the vmstate_loading
section, failover isn't relaunched. Instead we then wait for
failover on colo_incoming_sem.

Fix this by relaunching failover even if there was an error. Also,
to make this work properly, set vmstate_loading to false when
returning during the vmstate_loading section.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Message-Id: <f60b0a8e2fadaaec792e04819dfc46951842d6ba.1589193382.git.lukasstraub2@web.de>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 4105999634..59639f519f 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -752,6 +752,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     ret = qemu_load_device_state(fb);
     if (ret < 0) {
         error_setg(errp, "COLO: load device state failed");
+        vmstate_loading = false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -760,6 +761,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     replication_get_error_all(&local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading = false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -768,6 +770,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     replication_do_checkpoint_all(&local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading = false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -779,6 +782,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     if (local_err) {
         error_propagate(errp, local_err);
+        vmstate_loading = false;
         qemu_mutex_unlock_iothread();
         return;
     }
@@ -789,9 +793,6 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     qemu_mutex_unlock_iothread();
 
     if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
-        failover_set_state(FAILOVER_STATUS_RELAUNCH,
-                        FAILOVER_STATUS_NONE);
-        failover_request_active(NULL);
         return;
     }
 
@@ -890,6 +891,14 @@ void *colo_process_incoming_thread(void *opaque)
             error_report_err(local_err);
             break;
         }
+
+        if (failover_get_state() == FAILOVER_STATUS_RELAUNCH) {
+            failover_set_state(FAILOVER_STATUS_RELAUNCH,
+                            FAILOVER_STATUS_NONE);
+            failover_request_active(NULL);
+            break;
+        }
+
         if (failover_get_state() != FAILOVER_STATUS_NONE) {
             error_report("failover request");
             break;
@@ -897,8 +906,6 @@ void *colo_process_incoming_thread(void *opaque)
     }
 
 out:
-    vmstate_loading = false;
-
     /*
      * There are only two reasons we can get here, some error happened
      * or the user triggered failover.
-- 
2.26.2


