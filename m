Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F7CC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:44:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E926247F1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFFKyBt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E926247F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXoYs-0002Ad-FJ
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 12:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoUx-0005XL-5c
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXoUu-0000sI-6p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 12:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603903227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwfVXRhQA82A5xD9GkELRckQ93zr4+8h6ghz6ZCncOU=;
 b=IFFKyBt+lXTekTXEHXyu2P6jfyhqXHrnf4OFYHG3F1RmPQNBw15T2TnIAQ6bMq7tpjpBjz
 DHmaKSCUUWav19qZ3TiPxjbus8pJMf/1n7qrajSGznmsynisCAXJlNealcJpu126/S21pS
 IlnZ86b8hejMEsf/eS+gF7wSWTHgIxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121--67IHYDJNYK_piLw-gJOiw-1; Wed, 28 Oct 2020 12:40:24 -0400
X-MC-Unique: -67IHYDJNYK_piLw-gJOiw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 328F7108E1A1;
 Wed, 28 Oct 2020 16:40:23 +0000 (UTC)
Received: from gimli.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD05A5B4BA;
 Wed, 28 Oct 2020 16:40:22 +0000 (UTC)
Subject: [PULL v2 06/32] vfio: Add migration state change notifier
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 10:40:22 -0600
Message-ID: <160390322240.12234.5303868265141620825.stgit@gimli.home>
In-Reply-To: <160390309510.12234.8858324597971641979.stgit@gimli.home>
References: <160390309510.12234.8858324597971641979.stgit@gimli.home>
User-Agent: StGit/0.21-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
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
Cc: Kirti Wankhede <kwankhede@nvidia.com>, Cornelia Huck <cohuck@redhat.com>,
 Neo Jia <cjia@nvidia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kirti Wankhede <kwankhede@nvidia.com>

Added migration state change notifier to get notification on migration state
change. These states are translated to VFIO device state and conveyed to
vendor driver.

Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>
Reviewed-by: Neo Jia <cjia@nvidia.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/migration.c           |   28 ++++++++++++++++++++++++++++
 hw/vfio/trace-events          |    1 +
 include/hw/vfio/vfio-common.h |    2 ++
 3 files changed, 31 insertions(+)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index e1ffae05e288..7ec85b6469c5 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -175,6 +175,30 @@ static void vfio_vmstate_change(void *opaque, int running, RunState state)
             (migration->device_state & mask) | value);
 }
 
+static void vfio_migration_state_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+    VFIOMigration *migration = container_of(notifier, VFIOMigration,
+                                            migration_state);
+    VFIODevice *vbasedev = migration->vbasedev;
+    int ret;
+
+    trace_vfio_migration_state_notifier(vbasedev->name,
+                                        MigrationStatus_str(s->state));
+
+    switch (s->state) {
+    case MIGRATION_STATUS_CANCELLING:
+    case MIGRATION_STATUS_CANCELLED:
+    case MIGRATION_STATUS_FAILED:
+        ret = vfio_migration_set_state(vbasedev,
+                      ~(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RESUMING),
+                      VFIO_DEVICE_STATE_RUNNING);
+        if (ret) {
+            error_report("%s: Failed to set state RUNNING", vbasedev->name);
+        }
+    }
+}
+
 static void vfio_migration_exit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
@@ -219,8 +243,11 @@ static int vfio_migration_init(VFIODevice *vbasedev,
     }
 
     migration = vbasedev->migration;
+    migration->vbasedev = vbasedev;
     migration->vm_state = qemu_add_vm_change_state_handler(vfio_vmstate_change,
                                                            vbasedev);
+    migration->migration_state.notify = vfio_migration_state_notifier;
+    add_migration_state_change_notifier(&migration->migration_state);
     return 0;
 
 err:
@@ -270,6 +297,7 @@ void vfio_migration_finalize(VFIODevice *vbasedev)
     if (vbasedev->migration) {
         VFIOMigration *migration = vbasedev->migration;
 
+        remove_migration_state_change_notifier(&migration->migration_state);
         qemu_del_vm_change_state_handler(migration->vm_state);
         vfio_migration_exit(vbasedev);
     }
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 41de81f12f60..78d7d83b5ef8 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -150,3 +150,4 @@ vfio_display_edid_write_error(void) ""
 vfio_migration_probe(const char *name, uint32_t index) " (%s) Region %d"
 vfio_migration_set_state(const char *name, uint32_t state) " (%s) state %d"
 vfio_vmstate_change(const char *name, int running, const char *reason, uint32_t dev_state) " (%s) running %d reason %s device state %d"
+vfio_migration_state_notifier(const char *name, const char *state) " (%s) state %s"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9a571f1fb552..2bd593ba38bb 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -59,10 +59,12 @@ typedef struct VFIORegion {
 } VFIORegion;
 
 typedef struct VFIOMigration {
+    struct VFIODevice *vbasedev;
     VMChangeStateEntry *vm_state;
     VFIORegion region;
     uint32_t device_state;
     int vm_running;
+    Notifier migration_state;
 } VFIOMigration;
 
 typedef struct VFIOAddressSpace {


