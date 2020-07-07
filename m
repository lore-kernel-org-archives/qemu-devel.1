Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF83C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99100206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ibH20QCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99100206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqY9-0003t1-PR
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7d-0003Gb-Lr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39866
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7E-0006u7-Aj
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hll8vBewecymRqfZFlO3Xccr8uRsxpPGe2FHFSIy0NQ=;
 b=ibH20QCmMWXsUs4idMtAPlBcqRT1ysAUxeQzu3j7sXSK3E2W4sjVsJLvcVFJU0vB+Vvcj/
 hEuRdm3ZxpGB1GLCwrBNKkoqabzk6e5kLn4VRkVKF8qFnxXj1D8nS4/6tkUgdEKjkrFAme
 otk7oSxPrSk0YJY+OQO9sZQJT+RH2u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-XgsqwPHzN36uK9_ucdVHqQ-1; Tue, 07 Jul 2020 12:06:38 -0400
X-MC-Unique: XgsqwPHzN36uK9_ucdVHqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92FD180183C;
 Tue,  7 Jul 2020 16:06:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 118F219D7B;
 Tue,  7 Jul 2020 16:06:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 184FA1196440; Tue,  7 Jul 2020 18:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 37/45] error: Reduce unnecessary error propagation
Date: Tue,  7 Jul 2020 18:06:05 +0200
Message-Id: <20200707160613.848843-38-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, groug@kaod.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When all we do with an Error we receive into a local variable is
propagating to somewhere else, we can just as well receive it there
right away, even when we need to keep error_propagate() for other
error paths.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c             | 2 +-
 block/gluster.c     | 8 ++++----
 block/parallels.c   | 2 +-
 block/quorum.c      | 2 +-
 block/replication.c | 3 +--
 block/vxhs.c        | 4 ++--
 hw/core/qdev.c      | 2 +-
 hw/net/virtio-net.c | 4 ++--
 8 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/block.c b/block.c
index 60d2945c2c..2dcf9afd61 100644
--- a/block.c
+++ b/block.c
@@ -6073,7 +6073,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
 
     /* Parse -o options */
     if (options) {
-        if (!qemu_opts_do_parse(opts, options, NULL, &local_err)) {
+        if (!qemu_opts_do_parse(opts, options, NULL, errp)) {
             goto out;
         }
     }
diff --git a/block/gluster.c b/block/gluster.c
index c620880f27..4f1448e2bc 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -523,7 +523,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
     /* create opts info from runtime_json_opts list */
     opts = qemu_opts_create(&runtime_json_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto out;
     }
 
@@ -554,7 +554,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         /* create opts info from runtime_type_opts list */
         opts = qemu_opts_create(&runtime_type_opts, NULL, 0, &error_abort);
-        if (!qemu_opts_absorb_qdict(opts, backing_options, &local_err)) {
+        if (!qemu_opts_absorb_qdict(opts, backing_options, errp)) {
             goto out;
         }
 
@@ -584,7 +584,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         if (gsconf->type == SOCKET_ADDRESS_TYPE_INET) {
             /* create opts info from runtime_inet_opts list */
             opts = qemu_opts_create(&runtime_inet_opts, NULL, 0, &error_abort);
-            if (!qemu_opts_absorb_qdict(opts, backing_options, &local_err)) {
+            if (!qemu_opts_absorb_qdict(opts, backing_options, errp)) {
                 goto out;
             }
 
@@ -632,7 +632,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         } else {
             /* create opts info from runtime_unix_opts list */
             opts = qemu_opts_create(&runtime_unix_opts, NULL, 0, &error_abort);
-            if (!qemu_opts_absorb_qdict(opts, backing_options, &local_err)) {
+            if (!qemu_opts_absorb_qdict(opts, backing_options, errp)) {
                 goto out;
             }
 
diff --git a/block/parallels.c b/block/parallels.c
index ff27a85c01..180dd41e2b 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -828,7 +828,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail_options;
     }
 
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto fail_options;
     }
 
diff --git a/block/quorum.c b/block/quorum.c
index 5d52e605db..6df9449fc2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -921,7 +921,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     opts = qemu_opts_create(&quorum_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto exit;
     }
diff --git a/block/replication.c b/block/replication.c
index dcd430624e..0c70215784 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -85,7 +85,6 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 {
     int ret;
     BDRVReplicationState *s = bs->opaque;
-    Error *local_err = NULL;
     QemuOpts *opts = NULL;
     const char *mode;
     const char *top_id;
@@ -99,7 +98,7 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 
     ret = -EINVAL;
     opts = qemu_opts_create(&replication_runtime_opts, NULL, 0, &error_abort);
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         goto fail;
     }
 
diff --git a/block/vxhs.c b/block/vxhs.c
index fecaeb82c9..dc0e254730 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -318,7 +318,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     tcp_opts = qemu_opts_create(&runtime_tcp_opts, NULL, 0, &error_abort);
 
-    if (!qemu_opts_absorb_qdict(opts, options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
         goto out;
     }
@@ -345,7 +345,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     /* get the 'server.' arguments */
     qdict_extract_subqdict(options, &backing_options, VXHS_OPT_SERVER".");
 
-    if (!qemu_opts_absorb_qdict(tcp_opts, backing_options, &local_err)) {
+    if (!qemu_opts_absorb_qdict(tcp_opts, backing_options, errp)) {
         ret = -EINVAL;
         goto out;
     }
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 17bd8fc2ec..62b45af8e9 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -869,7 +869,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     }
 
     if (value && !dev->realized) {
-        if (!check_only_migratable(obj, &local_err)) {
+        if (!check_only_migratable(obj, errp)) {
             goto fail;
         }
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 04b012e487..7502ff0b1e 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3119,8 +3119,8 @@ static bool failover_replug_primary(VirtIONet *n, Error **errp)
     qdev_set_parent_bus(n->primary_dev, n->primary_bus);
     n->primary_should_be_hidden = false;
     if (!qemu_opt_set_bool(n->primary_device_opts,
-                           "partially_hotplugged", true, &err)) {
-        goto out;
+                           "partially_hotplugged", true, errp)) {
+        return false;
     }
     hotplug_ctrl = qdev_get_hotplug_handler(n->primary_dev);
     if (hotplug_ctrl) {
-- 
2.26.2


