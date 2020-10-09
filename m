Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE6FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C7321D41
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXN35m29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C7321D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmUl-0006Tm-Kt
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmDH-00009x-8S
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmDE-0001aC-PB
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602226147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jnQ1XXBShemBdeQxqX+TEAIgc/npcLrb5M/nVdh5n5o=;
 b=OXN35m29OeXWFh+kWXlnnUifemyre/1VzHz800X1HAoW4j0FqFqTW7w4DCf8EICZkRw3oj
 0kixNxxfoIKZVB08kNALEpiSBG4xFKhrp4gHzaXgQS4X3SHA7S8lSi4cUEQTdXJ7OJ+YSE
 +MWe9bISIQnQeM23qjCGuwMvZIIfVlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-WTUU5pOoM0OgTeL0BYdQPA-1; Fri, 09 Oct 2020 02:49:04 -0400
X-MC-Unique: WTUU5pOoM0OgTeL0BYdQPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82D0A1018F83;
 Fri,  9 Oct 2020 06:49:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E60519481;
 Fri,  9 Oct 2020 06:49:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 943F8112CE12; Fri,  9 Oct 2020 08:48:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] error: Remove NULL checks on error_propagate() calls
 (again)
Date: Fri,  9 Oct 2020 08:48:57 +0200
Message-Id: <20201009064858.323624-2-armbru@redhat.com>
In-Reply-To: <20201009064858.323624-1-armbru@redhat.com>
References: <20201009064858.323624-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, Jens Freimann <jfreimann@redhat.com>,
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
Message-Id: <20200722084048.1726105-4-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 hw/net/virtio-net.c   | 8 ++------
 migration/colo.c      | 4 +---
 migration/migration.c | 8 ++------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7bf27b9db7..a160a9da9c 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -817,9 +817,7 @@ static void failover_add_primary(VirtIONet *n, Error **errp)
             "sure primary device has parameter"
             " failover_pair_id=<virtio-net-id>\n");
 }
-    if (err) {
-        error_propagate(errp, err);
-    }
+    error_propagate(errp, err);
 }
 
 static int is_my_primary(void *opaque, QemuOpts *opts, Error **errp)
@@ -873,9 +871,7 @@ static DeviceState *virtio_connect_failover_devices(VirtIONet *n,
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
index 80788d46b5..3f1d3dfd95 100644
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
index aca7fdcd0b..0575ecb379 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -623,9 +623,7 @@ void migration_fd_process_incoming(QEMUFile *f, Error **errp)
     }
 
     if (migration_incoming_setup(f, &local_err)) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-        }
+        error_propagate(errp, local_err);
         return;
     }
     migration_incoming_process();
@@ -647,9 +645,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
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


