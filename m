Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C78E20775
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ba1+kUP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C78E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtI5j-0005pY-En
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHeu-0004Sa-Bi
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:31:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24733
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHes-0002aY-6C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9reqhuTfdQt5fwE83qaXmGCLQ3HLKxxMiwFIppbc6k=;
 b=Ba1+kUP50B4TqQDb1WhZVzgz0lgVkt8dlyeNpFaMSc2a2j0cDSCQBH5F+tH0tTjELXQCg5
 xWCdLBysMrqn5IVFuvFxuLzJFF8Kh9cUpJraEf5CZVJApEnz0QvZiJxBfrDy8VT303qTQa
 cMH/XWoEtFZRi9FHmPapssIL6TyFmho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-xyObA5HDNBSXWfGRmMdrZg-1; Tue, 07 Jul 2020 17:25:23 -0400
X-MC-Unique: xyObA5HDNBSXWfGRmMdrZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94304800C64
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 21:25:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1984A5D9C9;
 Tue,  7 Jul 2020 21:25:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A97F010C4AE3; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/53] qapi: Smooth another visitor error checking pattern
Date: Tue,  7 Jul 2020 23:24:49 +0200
Message-Id: <20200707212503.1495927-40-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:11
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert

    visit_type_FOO(v, ..., &ptr, &err);
    ...
    if (err) {
        ...
    }

to

    visit_type_FOO(v, ..., &ptr, errp);
    ...
    if (!ptr) {
        ...
    }

for functions that set @ptr to non-null / null on success / error.

Eliminate error_propagate() that are now unnecessary.  Delete @err
that are now unused.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200707160613.848843-40-armbru@redhat.com>
---
 block/nfs.c          |  7 ++-----
 block/parallels.c    |  7 ++-----
 block/qcow.c         |  7 ++-----
 block/qcow2.c        |  7 ++-----
 block/qed.c          |  7 ++-----
 block/rbd.c          |  7 ++-----
 block/sheepdog.c     |  6 ++----
 block/ssh.c          |  7 ++-----
 block/vdi.c          |  7 ++-----
 block/vhdx.c         |  7 ++-----
 block/vpc.c          |  7 ++-----
 hw/acpi/core.c       |  5 ++---
 hw/block/xen-block.c |  6 ++----
 hw/core/numa.c       |  7 +++----
 monitor/monitor.c    | 21 +++++++--------------
 15 files changed, 36 insertions(+), 79 deletions(-)

diff --git a/block/nfs.c b/block/nfs.c
index b1718d125a..61a249a9fc 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -563,18 +563,15 @@ static BlockdevOptionsNfs *nfs_options_qdict_to_qapi(QDict *options,
     BlockdevOptionsNfs *opts = NULL;
     Visitor *v;
     const QDictEntry *e;
-    Error *local_err = NULL;
 
     v = qobject_input_visitor_new_flat_confused(options, errp);
     if (!v) {
         return NULL;
     }
 
-    visit_type_BlockdevOptionsNfs(v, NULL, &opts, &local_err);
+    visit_type_BlockdevOptionsNfs(v, NULL, &opts, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!opts) {
         return NULL;
     }
 
diff --git a/block/parallels.c b/block/parallels.c
index cb5259ac44..f489c0d4ba 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -625,7 +625,6 @@ static int coroutine_fn parallels_co_create_opts(BlockDriver *drv,
                                                  Error **errp)
 {
     BlockdevCreateOptions *create_options = NULL;
-    Error *local_err = NULL;
     BlockDriverState *bs = NULL;
     QDict *qdict;
     Visitor *v;
@@ -668,11 +667,9 @@ static int coroutine_fn parallels_co_create_opts(BlockDriver *drv,
         goto done;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto done;
     }
diff --git a/block/qcow.c b/block/qcow.c
index dca2a1fe7d..c22d1bf6b8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -943,7 +943,6 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
     QDict *qdict;
     Visitor *v;
     const char *val;
-    Error *local_err = NULL;
     int ret;
 
     static const QDictRenames opt_renames[] = {
@@ -995,11 +994,9 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
         goto fail;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index a9137a535b..9ed2396c88 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3683,7 +3683,6 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
     Visitor *v;
     BlockDriverState *bs = NULL;
     BlockDriverState *data_bs = NULL;
-    Error *local_err = NULL;
     const char *val;
     int ret;
 
@@ -3779,11 +3778,9 @@ static int coroutine_fn qcow2_co_create_opts(BlockDriver *drv,
         goto finish;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto finish;
     }
diff --git a/block/qed.c b/block/qed.c
index e369fd360a..7fa7f880f6 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -729,7 +729,6 @@ static int coroutine_fn bdrv_qed_co_create_opts(BlockDriver *drv,
     QDict *qdict;
     Visitor *v;
     BlockDriverState *bs = NULL;
-    Error *local_err = NULL;
     int ret;
 
     static const QDictRenames opt_renames[] = {
@@ -771,11 +770,9 @@ static int coroutine_fn bdrv_qed_co_create_opts(BlockDriver *drv,
         goto fail;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/rbd.c b/block/rbd.c
index 617553b022..688074c64b 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -681,7 +681,6 @@ static int qemu_rbd_convert_options(QDict *options, BlockdevOptionsRbd **opts,
                                     Error **errp)
 {
     Visitor *v;
-    Error *local_err = NULL;
 
     /* Convert the remaining options into a QAPI object */
     v = qobject_input_visitor_new_flat_confused(options, errp);
@@ -689,11 +688,9 @@ static int qemu_rbd_convert_options(QDict *options, BlockdevOptionsRbd **opts,
         return -EINVAL;
     }
 
-    visit_type_BlockdevOptionsRbd(v, NULL, opts, &local_err);
+    visit_type_BlockdevOptionsRbd(v, NULL, opts, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!opts) {
         return -EINVAL;
     }
 
diff --git a/block/sheepdog.c b/block/sheepdog.c
index a6a91442c9..6c487c8322 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2193,11 +2193,9 @@ static int coroutine_fn sd_co_create_opts(BlockDriver *drv,
         goto fail;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/ssh.c b/block/ssh.c
index f00b89684a..ebe3d8b631 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -616,7 +616,6 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
 {
     BlockdevOptionsSsh *result = NULL;
     QemuOpts *opts = NULL;
-    Error *local_err = NULL;
     const QDictEntry *e;
     Visitor *v;
 
@@ -636,11 +635,9 @@ static BlockdevOptionsSsh *ssh_parse_options(QDict *options, Error **errp)
         goto fail;
     }
 
-    visit_type_BlockdevOptionsSsh(v, NULL, &result, &local_err);
+    visit_type_BlockdevOptionsSsh(v, NULL, &result, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!result) {
         goto fail;
     }
 
diff --git a/block/vdi.c b/block/vdi.c
index 2f506a01ba..0a60be773e 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -907,7 +907,6 @@ static int coroutine_fn vdi_co_create_opts(BlockDriver *drv,
     uint64_t block_size = DEFAULT_CLUSTER_SIZE;
     bool is_static = false;
     Visitor *v;
-    Error *local_err = NULL;
     int ret;
 
     /* Parse options and convert legacy syntax.
@@ -958,11 +957,9 @@ static int coroutine_fn vdi_co_create_opts(BlockDriver *drv,
         ret = -EINVAL;
         goto done;
     }
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto done;
     }
diff --git a/block/vhdx.c b/block/vhdx.c
index ac5a9094c4..eed9c3b860 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2067,7 +2067,6 @@ static int coroutine_fn vhdx_co_create_opts(BlockDriver *drv,
     QDict *qdict;
     Visitor *v;
     BlockDriverState *bs = NULL;
-    Error *local_err = NULL;
     int ret;
 
     static const QDictRenames opt_renames[] = {
@@ -2108,11 +2107,9 @@ static int coroutine_fn vhdx_co_create_opts(BlockDriver *drv,
         goto fail;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/block/vpc.c b/block/vpc.c
index c8cf3957bc..77043c2424 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1096,7 +1096,6 @@ static int coroutine_fn vpc_co_create_opts(BlockDriver *drv,
     QDict *qdict;
     Visitor *v;
     BlockDriverState *bs = NULL;
-    Error *local_err = NULL;
     int ret;
 
     static const QDictRenames opt_renames[] = {
@@ -1135,11 +1134,9 @@ static int coroutine_fn vpc_co_create_opts(BlockDriver *drv,
         goto fail;
     }
 
-    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!create_options) {
         ret = -EINVAL;
         goto fail;
     }
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 8b240c3e09..f6d9ec4f13 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -239,7 +239,6 @@ static void acpi_table_install(const char unsigned *blob, size_t bloblen,
 void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     AcpiTableOptions *hdrs = NULL;
-    Error *err = NULL;
     char **pathnames = NULL;
     char **cur;
     size_t bloblen = 0;
@@ -249,11 +248,11 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         Visitor *v;
 
         v = opts_visitor_new(opts);
-        visit_type_AcpiTableOptions(v, NULL, &hdrs, &err);
+        visit_type_AcpiTableOptions(v, NULL, &hdrs, errp);
         visit_free(v);
     }
 
-    if (err) {
+    if (!hdrs) {
         goto out;
     }
     if (hdrs->has_file == hdrs->has_data) {
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 96c6c009c7..a775fba7c0 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -682,11 +682,9 @@ static char *xen_block_blockdev_add(const char *id, QDict *qdict,
     trace_xen_block_blockdev_add(node_name);
 
     v = qobject_input_visitor_new(QOBJECT(qdict));
-    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
+    visit_type_BlockdevOptions(v, NULL, &options, errp);
     visit_free(v);
-
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!options) {
         goto fail;
     }
 
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 1b3267a607..d1a94a14f8 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -516,10 +516,10 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
     Error *err = NULL;
     Visitor *v = opts_visitor_new(opts);
 
-    visit_type_NumaOptions(v, NULL, &object, &err);
+    visit_type_NumaOptions(v, NULL, &object, errp);
     visit_free(v);
-    if (err) {
-        goto end;
+    if (!object) {
+        return -1;
     }
 
     /* Fix up legacy suffix-less format */
@@ -530,7 +530,6 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
 
     set_numa_options(ms, object, &err);
 
-end:
     qapi_free_NumaOptions(object);
     if (err) {
         error_propagate(errp, err);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 19dcb8fbe3..b385a3d569 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -657,25 +657,18 @@ int monitor_init_opts(QemuOpts *opts, Error **errp)
 {
     Visitor *v;
     MonitorOptions *options;
-    Error *local_err = NULL;
+    int ret;
 
     v = opts_visitor_new(opts);
-    visit_type_MonitorOptions(v, NULL, &options, &local_err);
+    visit_type_MonitorOptions(v, NULL, &options, errp);
     visit_free(v);
-
-    if (local_err) {
-        goto out;
-    }
-
-    monitor_init(options, true, &local_err);
-    qapi_free_MonitorOptions(options);
-
-out:
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!options) {
         return -1;
     }
-    return 0;
+
+    ret = monitor_init(options, true, errp);
+    qapi_free_MonitorOptions(options);
+    return ret;
 }
 
 QemuOptsList qemu_mon_opts = {
-- 
2.26.2


