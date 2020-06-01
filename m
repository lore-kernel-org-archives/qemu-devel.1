Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28093206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxrvJP98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28093206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpPZ-0003uy-Cc
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMV-0007b9-0J
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMT-0000SF-V1
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7M+J/2znzkx8+cKiqPdzPYOAgBpJPS+zBZ02z45Olk=;
 b=KxrvJP98oTSaVe/aG3gMYT8ulO1EfTelCIkkRq/4nvqrh21CK26lRXBE+W0AiwR8gEg1Ab
 0bxWo+2OV8lYywKsaOYBmBVmbEXhWYobaClcb682P8LT5sdW6mlZcnpLVsjOjUpWtYj0Ir
 3NCTCQeTEABx4f316zqaJ0xsZxvyr64=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-XfOcel0SOIeP4x87JDiAIA-1; Mon, 01 Jun 2020 14:40:33 -0400
X-MC-Unique: XfOcel0SOIeP4x87JDiAIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C85D107ACF7;
 Mon,  1 Jun 2020 18:40:32 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE26E10021B3;
 Mon,  1 Jun 2020 18:40:27 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/12] migration/colo.c: Flush ram cache only after receiving
 device state
Date: Mon,  1 Jun 2020 19:40:01 +0100
Message-Id: <20200601184004.272784-10-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 14:40:33
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

If we suceed in receiving ram state, but fail receiving the device
state, there will be a mismatch between the two.

Fix this by flushing the ram cache only after the vmstate has been
received.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Message-Id: <3289d007d494cb0e2f05b1cf4ae6a78d300fede3.1589193382.git.lukasstraub2@web.de>
Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 1 +
 migration/ram.c  | 5 +----
 migration/ram.h  | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index d00b3b9d6b..4105999634 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -748,6 +748,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     qemu_mutex_lock_iothread();
     vmstate_loading = true;
+    colo_flush_ram_cache();
     ret = qemu_load_device_state(fb);
     if (ret < 0) {
         error_setg(errp, "COLO: load device state failed");
diff --git a/migration/ram.c b/migration/ram.c
index 859f835f1a..41cc530d9d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3360,7 +3360,7 @@ static bool postcopy_is_running(void)
  * Flush content of RAM cache into SVM's memory.
  * Only flush the pages that be dirtied by PVM or SVM or both.
  */
-static void colo_flush_ram_cache(void)
+void colo_flush_ram_cache(void)
 {
     RAMBlock *block = NULL;
     void *dst_host;
@@ -3632,9 +3632,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
     }
     trace_ram_load_complete(ret, seq_iter);
 
-    if (!ret  && migration_incoming_in_colo_state()) {
-        colo_flush_ram_cache();
-    }
     return ret;
 }
 
diff --git a/migration/ram.h b/migration/ram.h
index 5ceaff7cb4..2eeaacfa13 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -65,6 +65,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
 
 /* ram cache */
 int colo_init_ram_cache(void);
+void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
 
-- 
2.26.2


