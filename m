Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A8EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2092020674
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oj9gHQYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2092020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqBG-0001eA-C4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7D-00026k-Mz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:39 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34719
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq75-0006p8-Gl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U44+qVR3RrcwFM5tEDa602LUqogW1Bzgznv3ZYS4f1M=;
 b=Oj9gHQYaiCfkvFuFAKKD5LGDN4syQd+lyUE2FqMXm0KD0hdKiI/zViJKtiH3J2e+Fjv/KM
 vsfTaatR4KDZBFELiXg5CTxK/v0VggeNpw+G2FK5LmRAdwL9Fe8tHs3qOQc/cAsaVbvi+s
 YD7ehBAWa1TOBYZhLtPQcFe4G2LB6+U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-XHuVrULnNbCkAlbfCCe7cg-1; Tue, 07 Jul 2020 12:06:26 -0400
X-MC-Unique: XHuVrULnNbCkAlbfCCe7cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7273018829C0;
 Tue,  7 Jul 2020 16:06:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE7BA797E4;
 Tue,  7 Jul 2020 16:06:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88AF111326F2; Tue,  7 Jul 2020 18:06:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/45] qemu-option: Check return value instead of @err
 where convenient
Date: Tue,  7 Jul 2020 18:05:35 +0200
Message-Id: <20200707160613.848843-8-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Convert uses like

    opts = qemu_opts_create(..., &err);
    if (err) {
        ...
    }

to

    opts = qemu_opts_create(..., errp);
    if (!opts) {
        ...
    }

Eliminate error_propagate() that are now unnecessary.  Delete @err
that are now unused.

Note that we can't drop parallels_open()'s error_propagate() here.  We
continue to execute it even in the converted case.  It's a no-op then:
local_err is null.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 block/parallels.c  |  4 ++--
 blockdev.c         |  5 ++---
 qdev-monitor.c     |  5 ++---
 util/qemu-config.c | 10 ++++------
 util/qemu-option.c | 12 ++++--------
 5 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 63a1cde8af..f26f03c926 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -824,8 +824,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         }
     }
 
-    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, &local_err);
-    if (local_err != NULL) {
+    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
+    if (!opts) {
         goto fail_options;
     }
 
diff --git a/blockdev.c b/blockdev.c
index 31d5eaf6bf..b52ed9de86 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -504,9 +504,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
     /* Check common options by copying from bs_opts to opts, all other options
      * stay in bs_opts for processing by bdrv_open(). */
     id = qdict_get_try_str(bs_opts, "id");
-    opts = qemu_opts_create(&qemu_common_drive_opts, id, 1, &error);
-    if (error) {
-        error_propagate(errp, error);
+    opts = qemu_opts_create(&qemu_common_drive_opts, id, 1, errp);
+    if (!opts) {
         goto err_no_opts;
     }
 
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 13a13a811a..079cb6001e 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -799,9 +799,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
     QemuOpts *opts;
     DeviceState *dev;
 
-    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, errp);
+    if (!opts) {
         return;
     }
     if (!monitor_cur_is_qmp() && qdev_device_help(opts)) {
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 772f5a219e..c0d0e9b8ef 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -493,9 +493,8 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
         goto out;
     }
 
-    subopts = qemu_opts_create(opts, NULL, 0, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    subopts = qemu_opts_create(opts, NULL, 0, errp);
+    if (!subopts) {
         goto out;
     }
 
@@ -538,10 +537,9 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
             }
 
             opt_name = g_strdup_printf("%s.%u", opts->name, i++);
-            subopts = qemu_opts_create(opts, opt_name, 1, &local_err);
+            subopts = qemu_opts_create(opts, opt_name, 1, errp);
             g_free(opt_name);
-            if (local_err) {
-                error_propagate(errp, local_err);
+            if (!subopts) {
                 goto out;
             }
 
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 0ebfd97a98..fd1fd23521 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -670,11 +670,9 @@ void qemu_opts_set(QemuOptsList *list, const char *id,
                    const char *name, const char *value, Error **errp)
 {
     QemuOpts *opts;
-    Error *local_err = NULL;
 
-    opts = qemu_opts_create(list, id, 1, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    opts = qemu_opts_create(list, id, 1, errp);
+    if (!opts) {
         return;
     }
     qemu_opt_set(opts, name, value, errp);
@@ -1012,10 +1010,8 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
     QemuOpts *opts;
     const QDictEntry *entry;
 
-    opts = qemu_opts_create(list, qdict_get_try_str(qdict, "id"), 1,
-                            &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    opts = qemu_opts_create(list, qdict_get_try_str(qdict, "id"), 1, errp);
+    if (!opts) {
         return NULL;
     }
 
-- 
2.26.2


