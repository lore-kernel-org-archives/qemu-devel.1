Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DD120836
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MGT6IZMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DD120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8zM-0007ac-Tc
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8Vm-0004X8-L7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VD-00059y-Rb
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTBm/kLekBBTAbmGDO3gnSmTOXa5KE/0qiE6PbFMHgA=;
 b=MGT6IZMD0/dRtkcdvBopiqS/d5m0K2jG+nAiAnfl5rcJV78ehbTK2/wEya3jCN2LvQ5uPD
 Occd/ZllRtrGHyaXgzELjqZw0nuRTJBH6yLbeE+370Vs2MAVmITJVrhLQ6rmEYXFbyE6XF
 qNSHfYJsTDNalepqdkxBfN1eQV86VHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-9izfTIkgMma_kdkbv5BDkg-1; Wed, 24 Jun 2020 12:43:52 -0400
X-MC-Unique: 9izfTIkgMma_kdkbv5BDkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89C7E2D59;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F1660F8A;
 Wed, 24 Jun 2020 16:43:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 283B31138480; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/46] block: Avoid unnecessary error_propagate() after
 error_setg()
Date: Wed, 24 Jun 2020 18:43:17 +0200
Message-Id: <20200624164344.3778251-20-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous commit enables another round of the transformation from
recent commit "error: Avoid unnecessary error_propagate() after
error_setg()".

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/quorum.c      | 16 +++++++---------
 block/replication.c | 12 +++++-------
 block/vxhs.c        | 10 ++++------
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 9ed20e1998..6df9449fc2 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -910,13 +910,12 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     /* count how many different children are present */
     s->num_children = qdict_array_entries(options, "children.");
     if (s->num_children < 0) {
-        error_setg(&local_err, "Option children is not a valid array");
+        error_setg(errp, "Option children is not a valid array");
         ret = -EINVAL;
         goto exit;
     }
     if (s->num_children < 1) {
-        error_setg(&local_err,
-                   "Number of provided children must be 1 or more");
+        error_setg(errp, "Number of provided children must be 1 or more");
         ret = -EINVAL;
         goto exit;
     }
@@ -929,7 +928,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->threshold = qemu_opt_get_number(opts, QUORUM_OPT_VOTE_THRESHOLD, 0);
     /* and validate it against s->num_children */
-    ret = quorum_valid_threshold(s->threshold, s->num_children, &local_err);
+    ret = quorum_valid_threshold(s->threshold, s->num_children, errp);
     if (ret < 0) {
         goto exit;
     }
@@ -942,7 +941,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
                               -EINVAL, NULL);
     }
     if (ret < 0) {
-        error_setg(&local_err, "Please set read-pattern as fifo or quorum");
+        error_setg(errp, "Please set read-pattern as fifo or quorum");
         goto exit;
     }
     s->read_pattern = ret;
@@ -950,7 +949,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->read_pattern == QUORUM_READ_PATTERN_QUORUM) {
         s->is_blkverify = qemu_opt_get_bool(opts, QUORUM_OPT_BLKVERIFY, false);
         if (s->is_blkverify && (s->num_children != 2 || s->threshold != 2)) {
-            error_setg(&local_err, "blkverify=on can only be set if there are "
+            error_setg(errp, "blkverify=on can only be set if there are "
                        "exactly two files and vote-threshold is 2");
             ret = -EINVAL;
             goto exit;
@@ -959,7 +958,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
         s->rewrite_corrupted = qemu_opt_get_bool(opts, QUORUM_OPT_REWRITE,
                                                  false);
         if (s->rewrite_corrupted && s->is_blkverify) {
-            error_setg(&local_err,
+            error_setg(errp,
                        "rewrite-corrupted=on cannot be used with blkverify=on");
             ret = -EINVAL;
             goto exit;
@@ -979,6 +978,7 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
                                          &child_of_bds, BDRV_CHILD_DATA, false,
                                          &local_err);
         if (local_err) {
+            error_propagate(errp, local_err);
             ret = -EINVAL;
             goto close_exit;
         }
@@ -1004,8 +1004,6 @@ close_exit:
     g_free(opened);
 exit:
     qemu_opts_del(opts);
-    /* propagate error */
-    error_propagate(errp, local_err);
     return ret;
 }
 
diff --git a/block/replication.c b/block/replication.c
index 7f4ab357a4..0c70215784 100644
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
@@ -105,7 +104,7 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 
     mode = qemu_opt_get(opts, REPLICATION_MODE);
     if (!mode) {
-        error_setg(&local_err, "Missing the option mode");
+        error_setg(errp, "Missing the option mode");
         goto fail;
     }
 
@@ -113,7 +112,8 @@ static int replication_open(BlockDriverState *bs, QDict *options,
         s->mode = REPLICATION_MODE_PRIMARY;
         top_id = qemu_opt_get(opts, REPLICATION_TOP_ID);
         if (top_id) {
-            error_setg(&local_err, "The primary side does not support option top-id");
+            error_setg(errp,
+                       "The primary side does not support option top-id");
             goto fail;
         }
     } else if (!strcmp(mode, "secondary")) {
@@ -121,11 +121,11 @@ static int replication_open(BlockDriverState *bs, QDict *options,
         top_id = qemu_opt_get(opts, REPLICATION_TOP_ID);
         s->top_id = g_strdup(top_id);
         if (!s->top_id) {
-            error_setg(&local_err, "Missing the option top-id");
+            error_setg(errp, "Missing the option top-id");
             goto fail;
         }
     } else {
-        error_setg(&local_err,
+        error_setg(errp,
                    "The option mode's value should be primary or secondary");
         goto fail;
     }
@@ -136,8 +136,6 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 
 fail:
     qemu_opts_del(opts);
-    error_propagate(errp, local_err);
-
     return ret;
 }
 
diff --git a/block/vxhs.c b/block/vxhs.c
index 20513a43f4..ef2848fb60 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -300,7 +300,6 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     QemuOpts *opts = NULL;
     QemuOpts *tcp_opts = NULL;
     char *of_vsa_addr = NULL;
-    Error *local_err = NULL;
     const char *vdisk_id_opt;
     const char *server_host_opt;
     int ret = 0;
@@ -326,14 +325,14 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
     /* vdisk-id is the disk UUID */
     vdisk_id_opt = qemu_opt_get(opts, VXHS_OPT_VDISK_ID);
     if (!vdisk_id_opt) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER, VXHS_OPT_VDISK_ID);
+        error_setg(errp, QERR_MISSING_PARAMETER, VXHS_OPT_VDISK_ID);
         ret = -EINVAL;
         goto out;
     }
 
     /* vdisk-id may contain a leading '/' */
     if (strlen(vdisk_id_opt) > UUID_FMT_LEN + 1) {
-        error_setg(&local_err, "vdisk-id cannot be more than %d characters",
+        error_setg(errp, "vdisk-id cannot be more than %d characters",
                    UUID_FMT_LEN);
         ret = -EINVAL;
         goto out;
@@ -352,14 +351,14 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
 
     server_host_opt = qemu_opt_get(tcp_opts, VXHS_OPT_HOST);
     if (!server_host_opt) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER,
+        error_setg(errp, QERR_MISSING_PARAMETER,
                    VXHS_OPT_SERVER"."VXHS_OPT_HOST);
         ret = -EINVAL;
         goto out;
     }
 
     if (strlen(server_host_opt) > MAXHOSTNAMELEN) {
-        error_setg(&local_err, "server.host cannot be more than %d characters",
+        error_setg(errp, "server.host cannot be more than %d characters",
                    MAXHOSTNAMELEN);
         ret = -EINVAL;
         goto out;
@@ -412,7 +411,6 @@ out:
 
     if (ret < 0) {
         vxhs_unref();
-        error_propagate(errp, local_err);
         g_free(s->vdisk_hostinfo.host);
         g_free(s->vdisk_guid);
         g_free(s->tlscredsid);
-- 
2.26.2


