Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D790C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:42:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB03205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iatSxT9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB03205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAKg-0005Pd-61
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJ9-0003lZ-Br
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:40:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49276
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJ7-0000OM-Mz
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595407256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=veS8tDmS+pVLznx/cjKbiuRYwxp6bkibjxraPx62U9w=;
 b=iatSxT9lDTxZ+OnL8JpM5Kip/deZsCsW/fBxFxIfXenk01x4Ggr616idHDa2XNZq8wz472
 +f7lgQlyI/kLrM1iPG4qQIaQSkVoWGt2XlzBQ/upnCqk293AD2hYa25uxAkz6h9tN0ErbD
 BBdFvWyEkL9hnO5B06xH317qH6sljIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-dm0uZP-WPoSU57VpM9b-Ag-1; Wed, 22 Jul 2020 04:40:54 -0400
X-MC-Unique: dm0uZP-WPoSU57VpM9b-Ag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF658102C84A;
 Wed, 22 Jul 2020 08:40:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E54374F6B;
 Wed, 22 Jul 2020 08:40:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B5A7107F758; Wed, 22 Jul 2020 10:40:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] error: Remove NULL checks on error_propagate() calls
 (again)
Date: Wed, 22 Jul 2020 10:40:47 +0200
Message-Id: <20200722084048.1726105-4-armbru@redhat.com>
In-Reply-To: <20200722084048.1726105-1-armbru@redhat.com>
References: <20200722084048.1726105-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 21:28:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jens Freimann <jfreimann@redhat.com>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by rerunning:

    $ spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
             --macro-file scripts/cocci-macro-file.h \
             --use-gitgrep .

Cc: Jens Freimann <jfreimann@redhat.com>
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Juan Quintela <quintela@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/net/virtio-net.c   | 8 ++------
 migration/colo.c      | 4 +---
 migration/migration.c | 8 ++------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4895af1cbe..21b9a315ed 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -809,9 +809,7 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
             "sure primary device has parameter"
             " failover_pair_id=<virtio-net-id>\n");
 }
-    if (err) {
-        error_propagate(errp, err);
-    }
+    error_propagate(errp, err);
 }
 
 static int is_my_primary(void *opaque, QemuOpts *opts, Error **errp)
@@ -865,9 +863,7 @@ static DeviceState *virtio_connect_failover_devices(VirtIONet *n,
         n->primary_device_id = g_strdup(prim_dev->id);
         n->primary_device_opts = prim_dev->opts;
     } else {
-        if (err) {
-            error_propagate(errp, err);
-        }
+        error_propagate(errp, err);
     }
 
     return prim_dev;
diff --git a/migration/colo.c b/migration/colo.c
index ea7d1e9d4e..c6848c829b 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -798,9 +798,7 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
 
     colo_send_message(mis->to_src_file, COLO_MESSAGE_VMSTATE_LOADED,
                  &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-    }
+    error_propagate(errp, local_err);
 }
 
 static void colo_wait_handle_message(MigrationIncomingState *mis,
diff --git a/migration/migration.c b/migration/migration.c
index 2ed9923227..6a458b8fe5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -601,9 +601,7 @@ void migration_fd_process_incoming(QEMUFile *f, Error **errp)
     }
 
     if (migration_incoming_setup(f, &local_err)) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-        }
+        error_propagate(errp, local_err);
         return;
     }
     migration_incoming_process();
@@ -625,9 +623,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
         }
 
         if (migration_incoming_setup(f, &local_err)) {
-            if (local_err) {
-                error_propagate(errp, local_err);
-            }
+            error_propagate(errp, local_err);
             return;
         }
 
-- 
2.26.2


