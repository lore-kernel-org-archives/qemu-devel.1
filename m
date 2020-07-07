Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A471C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051D1206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anrhrbds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051D1206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqVr-0007zr-Go
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7X-00030M-Ng
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jsq7B-0006su-NW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594137996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NArWD0KtszU3VgE7xMqpphGuM4rsempDaNwJ3gu2ivQ=;
 b=anrhrbds+ifR6KGdRr5TcvrNB0zw0uRlRsvF86Cingez814bBd+pFBBPlQviD9JFxNT2tw
 hFhLWGpE9AIzb31mD4TX1veieon/KjdZutXZolx/Itm+/QrY1DA39qen8m0wGKsVG4zcXE
 KzTaD0gJyfCVH/F6BZPPeFkhY0B7In8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-L_J7AGPGNjSpY6YyRWhpow-1; Tue, 07 Jul 2020 12:06:32 -0400
X-MC-Unique: L_J7AGPGNjSpY6YyRWhpow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 294F818829C5;
 Tue,  7 Jul 2020 16:06:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7436A71674;
 Tue,  7 Jul 2020 16:06:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04B5511275FB; Tue,  7 Jul 2020 18:06:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 33/45] error: Avoid unnecessary error_propagate() after
 error_setg()
Date: Tue,  7 Jul 2020 18:06:01 +0200
Message-Id: <20200707160613.848843-34-armbru@redhat.com>
In-Reply-To: <20200707160613.848843-1-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Replace

    error_setg(&err, ...);
    error_propagate(errp, err);

by

    error_setg(errp, ...);

Related pattern:

    if (...) {
        error_setg(&err, ...);
        goto out;
    }
    ...
 out:
    error_propagate(errp, err);
    return;

When all paths to label out are that way, replace by

    if (...) {
        error_setg(errp, ...);
        return;
    }

and delete the label along with the error_propagate().

When we have at most one other path that actually needs to propagate,
and maybe one at the end that where propagation is unnecessary, e.g.

    foo(..., &err);
    if (err) {
        goto out;
    }
    ...
    bar(..., &err);
 out:
    error_propagate(errp, err);
    return;

move the error_propagate() to where it's needed, like

    if (...) {
        foo(..., &err);
        error_propagate(errp, err);
        return;
    }
    ...
    bar(..., errp);
    return;

and transform the error_setg() as above.

In some places, the transformation results in obviously unnecessary
error_propagate().  The next few commits will eliminate them.

Bonus: the elimination of gotos will make later patches in this series
easier to review.

Candidates for conversion tracked down with this Coccinelle script:

    @@
    identifier err, errp;
    expression list args;
    @@
    -    error_setg(&err, args);
    +    error_setg(errp, args);
         ... when != err
         error_propagate(errp, err);

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 backends/cryptodev.c        | 11 +++---
 backends/hostmem-file.c     | 19 +++-------
 backends/hostmem-memfd.c    | 15 ++++----
 backends/hostmem.c          | 27 ++++++--------
 block/quorum.c              | 16 ++++----
 block/replication.c         | 11 +++---
 block/throttle-groups.c     | 22 +++++------
 block/vxhs.c                |  9 ++---
 hw/acpi/core.c              | 14 +++----
 hw/hyperv/vmbus.c           |  5 +--
 hw/i386/pc.c                | 35 ++++++------------
 hw/mem/nvdimm.c             | 17 ++++-----
 hw/mem/pc-dimm.c            | 14 +++----
 hw/misc/aspeed_sdmc.c       |  3 +-
 hw/ppc/rs6000_mc.c          |  9 ++---
 hw/ppc/spapr.c              | 73 ++++++++++++++++---------------------
 hw/ppc/spapr_pci.c          | 14 +++----
 hw/s390x/ipl.c              | 23 +++++-------
 hw/xen/xen_pt_config_init.c |  3 +-
 iothread.c                  | 12 +++---
 net/colo-compare.c          | 20 ++++------
 net/dump.c                  | 10 ++---
 net/filter-buffer.c         | 10 ++---
 qga/commands-win32.c        | 19 +++-------
 24 files changed, 169 insertions(+), 242 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 72b7077475..4de378532b 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -158,16 +158,15 @@ cryptodev_backend_set_queues(Object *obj, Visitor *v, const char *name,
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (!value) {
-        error_setg(&local_err, "Property '%s.%s' doesn't take value '%"
-                   PRIu32 "'", object_get_typename(obj), name, value);
-        goto out;
+        error_setg(errp, "Property '%s.%s' doesn't take value '%" PRIu32 "'",
+                   object_get_typename(obj), name, value);
+        return;
     }
     backend->conf.peers.queues = value;
-out:
-    error_propagate(errp, local_err);
 }
 
 static void
diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index 320dffbaa9..a44f5a61ac 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -114,18 +114,16 @@ static void file_memory_backend_set_align(Object *o, Visitor *v,
     uint64_t val;
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(&local_err, "cannot change property '%s' of %s",
-                   name, object_get_typename(o));
-        goto out;
+        error_setg(errp, "cannot change property '%s' of %s", name,
+                   object_get_typename(o));
+        return;
     }
 
     if (!visit_type_size(v, name, &val, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     fb->align = val;
-
- out:
-    error_propagate(errp, local_err);
 }
 
 static bool file_memory_backend_get_pmem(Object *o, Error **errp)
@@ -139,7 +137,6 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
     HostMemoryBackendFile *fb = MEMORY_BACKEND_FILE(o);
 
     if (host_memory_backend_mr_inited(backend)) {
-
         error_setg(errp, "cannot change property 'pmem' of %s.",
                    object_get_typename(o));
         return;
@@ -147,13 +144,9 @@ static void file_memory_backend_set_pmem(Object *o, bool value, Error **errp)
 
 #ifndef CONFIG_LIBPMEM
     if (value) {
-        Error *local_err = NULL;
-
-        error_setg(&local_err,
-                   "Lack of libpmem support while setting the 'pmem=on'"
+        error_setg(errp, "Lack of libpmem support while setting the 'pmem=on'"
                    " of %s. We can't ensure data persistence.",
                    object_get_typename(o));
-        error_propagate(errp, local_err);
         return;
     }
 #endif
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index d4281c0032..1e74a2b92f 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -81,21 +81,20 @@ memfd_backend_set_hugetlbsize(Object *obj, Visitor *v, const char *name,
     uint64_t value;
 
     if (host_memory_backend_mr_inited(MEMORY_BACKEND(obj))) {
-        error_setg(&local_err, "cannot change property value");
-        goto out;
+        error_setg(errp, "cannot change property value");
+        return;
     }
 
     if (!visit_type_size(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (!value) {
-        error_setg(&local_err, "Property '%s.%s' doesn't take value '%"
-                   PRIu64 "'", object_get_typename(obj), name, value);
-        goto out;
+        error_setg(errp, "Property '%s.%s' doesn't take value '%" PRIu64 "'",
+                   object_get_typename(obj), name, value);
+        return;
     }
     m->hugetlbsize = value;
-out:
-    error_propagate(errp, local_err);
 }
 
 static void
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 4e4103ac09..5cc264b0db 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -58,23 +58,22 @@ host_memory_backend_set_size(Object *obj, Visitor *v, const char *name,
     uint64_t value;
 
     if (host_memory_backend_mr_inited(backend)) {
-        error_setg(&local_err, "cannot change property %s of %s ",
-                   name, object_get_typename(obj));
-        goto out;
+        error_setg(errp, "cannot change property %s of %s ", name,
+                   object_get_typename(obj));
+        return;
     }
 
     if (!visit_type_size(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (!value) {
-        error_setg(&local_err,
+        error_setg(errp,
                    "property '%s' of %s doesn't take value '%" PRIu64 "'",
                    name, object_get_typename(obj), value);
-        goto out;
+        return;
     }
     backend->size = value;
-out:
-    error_propagate(errp, local_err);
 }
 
 static void
@@ -257,17 +256,15 @@ static void host_memory_backend_set_prealloc_threads(Object *obj, Visitor *v,
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (value <= 0) {
-        error_setg(&local_err,
-                   "property '%s' of %s doesn't take value '%d'",
-                   name, object_get_typename(obj), value);
-        goto out;
+        error_setg(errp, "property '%s' of %s doesn't take value '%d'", name,
+                   object_get_typename(obj), value);
+        return;
     }
     backend->prealloc_threads = value;
-out:
-    error_propagate(errp, local_err);
 }
 
 static void host_memory_backend_init(Object *obj)
diff --git a/block/quorum.c b/block/quorum.c
index beb3b6dbcc..5d52e605db 100644
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
index 5701eeb9e8..b844a09eb1 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -105,7 +105,7 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 
     mode = qemu_opt_get(opts, REPLICATION_MODE);
     if (!mode) {
-        error_setg(&local_err, "Missing the option mode");
+        error_setg(errp, "Missing the option mode");
         goto fail;
     }
 
@@ -113,7 +113,8 @@ static int replication_open(BlockDriverState *bs, QDict *options,
         s->mode = REPLICATION_MODE_PRIMARY;
         top_id = qemu_opt_get(opts, REPLICATION_TOP_ID);
         if (top_id) {
-            error_setg(&local_err, "The primary side does not support option top-id");
+            error_setg(errp,
+                       "The primary side does not support option top-id");
             goto fail;
         }
     } else if (!strcmp(mode, "secondary")) {
@@ -121,11 +122,11 @@ static int replication_open(BlockDriverState *bs, QDict *options,
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
@@ -136,8 +137,6 @@ static int replication_open(BlockDriverState *bs, QDict *options,
 
 fail:
     qemu_opts_del(opts);
-    error_propagate(errp, local_err);
-
     return ret;
 }
 
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index e411051160..3d7e7cf990 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -819,16 +819,17 @@ static void throttle_group_set(Object *obj, Visitor *v, const char * name,
      * transaction, as certain combinations are invalid.
      */
     if (tg->is_initialized) {
-        error_setg(&local_err, "Property cannot be set after initialization");
-        goto ret;
+        error_setg(errp, "Property cannot be set after initialization");
+        return;
     }
 
     if (!visit_type_int64(v, name, &value, &local_err)) {
-        goto ret;
+        error_propagate(errp, local_err);
+        return;
     }
     if (value < 0) {
-        error_setg(&local_err, "Property values cannot be negative");
-        goto ret;
+        error_setg(errp, "Property values cannot be negative");
+        return;
     }
 
     cfg = &tg->ts.cfg;
@@ -841,9 +842,9 @@ static void throttle_group_set(Object *obj, Visitor *v, const char * name,
         break;
     case BURST_LENGTH:
         if (value > UINT_MAX) {
-            error_setg(&local_err, "%s value must be in the"
-                       "range [0, %u]", info->name, UINT_MAX);
-            goto ret;
+            error_setg(errp, "%s value must be in the" "range [0, %u]",
+                       info->name, UINT_MAX);
+            return;
         }
         cfg->buckets[info->type].burst_length = value;
         break;
@@ -851,11 +852,6 @@ static void throttle_group_set(Object *obj, Visitor *v, const char * name,
         cfg->op_size = value;
         break;
     }
-
-ret:
-    error_propagate(errp, local_err);
-    return;
-
 }
 
 static void throttle_group_get(Object *obj, Visitor *v, const char *name,
diff --git a/block/vxhs.c b/block/vxhs.c
index 237df4f185..fecaeb82c9 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -326,14 +326,14 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
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
@@ -352,14 +352,14 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
 
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
@@ -412,7 +412,6 @@ out:
 
     if (ret < 0) {
         vxhs_unref();
-        error_propagate(errp, local_err);
         g_free(s->vdisk_hostinfo.host);
         g_free(s->vdisk_guid);
         g_free(s->tlscredsid);
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 45cbed49ab..8b240c3e09 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -257,13 +257,13 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         goto out;
     }
     if (hdrs->has_file == hdrs->has_data) {
-        error_setg(&err, "'-acpitable' requires one of 'data' or 'file'");
+        error_setg(errp, "'-acpitable' requires one of 'data' or 'file'");
         goto out;
     }
 
     pathnames = g_strsplit(hdrs->has_file ? hdrs->file : hdrs->data, ":", 0);
     if (pathnames == NULL || pathnames[0] == NULL) {
-        error_setg(&err, "'-acpitable' requires at least one pathname");
+        error_setg(errp, "'-acpitable' requires at least one pathname");
         goto out;
     }
 
@@ -272,7 +272,7 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         int fd = open(*cur, O_RDONLY | O_BINARY);
 
         if (fd < 0) {
-            error_setg(&err, "can't open file %s: %s", *cur, strerror(errno));
+            error_setg(errp, "can't open file %s: %s", *cur, strerror(errno));
             goto out;
         }
 
@@ -288,8 +288,8 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
                 memcpy(blob + bloblen, data, r);
                 bloblen += r;
             } else if (errno != EINTR) {
-                error_setg(&err, "can't read file %s: %s",
-                           *cur, strerror(errno));
+                error_setg(errp, "can't read file %s: %s", *cur,
+                           strerror(errno));
                 close(fd);
                 goto out;
             }
@@ -298,14 +298,12 @@ void acpi_table_add(const QemuOpts *opts, Error **errp)
         close(fd);
     }
 
-    acpi_table_install(blob, bloblen, hdrs->has_file, hdrs, &err);
+    acpi_table_install(blob, bloblen, hdrs->has_file, hdrs, errp);
 
 out:
     g_free(blob);
     g_strfreev(pathnames);
     qapi_free_AcpiTableOptions(hdrs);
-
-    error_propagate(errp, err);
 }
 
 unsigned acpi_table_len(void *current)
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index a8bcb41026..34392e892a 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1459,8 +1459,8 @@ static void create_channels(VMBus *vmbus, VMBusDevice *dev, Error **errp)
 
     dev->num_channels = vdc->num_channels ? vdc->num_channels(dev) : 1;
     if (dev->num_channels < 1) {
-        error_setg(&err, "invalid #channels: %u", dev->num_channels);
-        goto error_out;
+        error_setg(errp, "invalid #channels: %u", dev->num_channels);
+        return;
     }
 
     dev->channels = g_new0(VMBusChannel, dev->num_channels);
@@ -1477,7 +1477,6 @@ err_init:
     while (i--) {
         deinit_channel(&dev->channels[i]);
     }
-error_out:
     error_propagate(errp, err);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 55e1940675..70771d6632 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1327,7 +1327,6 @@ out:
 static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
-    Error *local_err = NULL;
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     /*
@@ -1336,21 +1335,18 @@ static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
      * addition to cover this case.
      */
     if (!pcms->acpi_dev || !x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
-        error_setg(&local_err,
+        error_setg(errp,
                    "memory hotplug is not enabled: missing acpi device or acpi disabled");
-        goto out;
+        return;
     }
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
-        error_setg(&local_err,
-                   "nvdimm device hot unplug is not supported yet.");
-        goto out;
+        error_setg(errp, "nvdimm device hot unplug is not supported yet.");
+        return;
     }
 
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
-                                   &local_err);
-out:
-    error_propagate(errp, local_err);
+                                   errp);
 }
 
 static void pc_memory_unplug(HotplugHandler *hotplug_dev,
@@ -1430,31 +1426,23 @@ static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     int idx = -1;
-    Error *local_err = NULL;
     X86CPU *cpu = X86_CPU(dev);
     PCMachineState *pcms = PC_MACHINE(hotplug_dev);
 
     if (!pcms->acpi_dev) {
-        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
-        goto out;
+        error_setg(errp, "CPU hot unplug not supported without ACPI");
+        return;
     }
 
     pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
     assert(idx != -1);
     if (idx == 0) {
-        error_setg(&local_err, "Boot CPU is unpluggable");
-        goto out;
+        error_setg(errp, "Boot CPU is unpluggable");
+        return;
     }
 
     hotplug_handler_unplug_request(HOTPLUG_HANDLER(pcms->acpi_dev), dev,
-                                   &local_err);
-    if (local_err) {
-        goto out;
-    }
-
- out:
-    error_propagate(errp, local_err);
-
+                                   errp);
 }
 
 static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
@@ -1859,10 +1847,9 @@ static void pc_machine_set_max_ram_below_4g(Object *obj, Visitor *v,
         return;
     }
     if (value > 4 * GiB) {
-        error_setg(&error,
+        error_setg(errp,
                    "Machine option 'max-ram-below-4g=%"PRIu64
                    "' expects size less than or equal to 4G", value);
-        error_propagate(errp, error);
         return;
     }
 
diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 1fa976c56c..838ebcd227 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -49,23 +49,22 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
     uint64_t value;
 
     if (nvdimm->nvdimm_mr) {
-        error_setg(&local_err, "cannot change property value");
-        goto out;
+        error_setg(errp, "cannot change property value");
+        return;
     }
 
     if (!visit_type_size(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (value < MIN_NAMESPACE_LABEL_SIZE) {
-        error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
-                   " at least 0x%lx", object_get_typename(obj),
-                   name, value, MIN_NAMESPACE_LABEL_SIZE);
-        goto out;
+        error_setg(errp, "Property '%s.%s' (0x%" PRIx64 ") is required"
+                   " at least 0x%lx", object_get_typename(obj), name, value,
+                   MIN_NAMESPACE_LABEL_SIZE);
+        return;
     }
 
     nvdimm->label_size = value;
-out:
-    error_propagate(errp, local_err);
 }
 
 static void nvdimm_get_uuid(Object *obj, Visitor *v, const char *name,
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 8a075fbf72..9d3f0b9691 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -44,24 +44,24 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                                    &error_abort);
     if ((slot < 0 || slot >= machine->ram_slots) &&
          slot != PC_DIMM_UNASSIGNED_SLOT) {
-        error_setg(&local_err, "invalid slot number %d, valid range is [0-%"
-                   PRIu64 "]", slot, machine->ram_slots - 1);
-        goto out;
+        error_setg(errp,
+                   "invalid slot number %d, valid range is [0-%" PRIu64 "]",
+                   slot, machine->ram_slots - 1);
+        return;
     }
 
     slot = pc_dimm_get_free_slot(slot == PC_DIMM_UNASSIGNED_SLOT ? NULL : &slot,
                                  machine->ram_slots, &local_err);
     if (local_err) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     object_property_set_int(OBJECT(dimm), PC_DIMM_SLOT_PROP, slot,
                             &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
     memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, legacy_align,
-                           &local_err);
-out:
-    error_propagate(errp, local_err);
+                           errp);
 }
 
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 28874445c3..40682af0b3 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -240,9 +240,8 @@ static void aspeed_sdmc_set_ram_size(Object *obj, Visitor *v, const char *name,
     }
 
     sz = size_to_str(value);
-    error_setg(&local_err, "Invalid RAM size %s", sz);
+    error_setg(errp, "Invalid RAM size %s", sz);
     g_free(sz);
-    error_propagate(errp, local_err);
 }
 
 static void aspeed_sdmc_initfn(Object *obj)
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index f8a498bd8a..ce97365f5e 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -169,7 +169,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
             memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
                                    s->simm_size[socket] * MiB, &local_err);
             if (local_err) {
-                goto out;
+                error_propagate(errp, local_err);
+                return;
             }
             memory_region_add_subregion_overlap(get_system_memory(), 0,
                                                 &s->simm[socket], socket);
@@ -177,10 +178,10 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
     }
     if (ram_size) {
         /* unable to push all requested RAM in SIMMs */
-        error_setg(&local_err, "RAM size incompatible with this board. "
+        error_setg(errp, "RAM size incompatible with this board. "
                    "Try again with something else, like %" PRId64 " MB",
                    s->ram_size / MiB - ram_size);
-        goto out;
+        return;
     }
 
     if (s->autoconfigure) {
@@ -196,8 +197,6 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
 
     isa_register_portio_list(ISA_DEVICE(dev), &s->portio, 0x0,
                              rs6000mc_port_list, s, "rs6000mc");
-out:
-    error_propagate(errp, local_err);
 }
 
 static const VMStateDescription vmstate_rs6000mc = {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 68e8b504b5..299908cc73 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2497,23 +2497,23 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
     unsigned int smp_threads = ms->smp.threads;
 
     if (!kvm_enabled() && (smp_threads > 1)) {
-        error_setg(&local_err, "TCG cannot support more than 1 thread/core "
-                     "on a pseries machine");
-        goto out;
+        error_setg(errp, "TCG cannot support more than 1 thread/core "
+                   "on a pseries machine");
+        return;
     }
     if (!is_power_of_2(smp_threads)) {
-        error_setg(&local_err, "Cannot support %d threads/core on a pseries "
-                     "machine because it must be a power of 2", smp_threads);
-        goto out;
+        error_setg(errp, "Cannot support %d threads/core on a pseries "
+                   "machine because it must be a power of 2", smp_threads);
+        return;
     }
 
     /* Detemine the VSMT mode to use: */
     if (vsmt_user) {
         if (spapr->vsmt < smp_threads) {
-            error_setg(&local_err, "Cannot support VSMT mode %d"
-                         " because it must be >= threads/core (%d)",
-                         spapr->vsmt, smp_threads);
-            goto out;
+            error_setg(errp, "Cannot support VSMT mode %d"
+                       " because it must be >= threads/core (%d)",
+                       spapr->vsmt, smp_threads);
+            return;
         }
         /* In this case, spapr->vsmt has been set by the command line */
     } else if (!smc->smp_threads_vsmt) {
@@ -2543,8 +2543,6 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
              * behaviour will be correct */
             if ((kvm_smt >= smp_threads) && ((spapr->vsmt % kvm_smt) == 0)) {
                 warn_report_err(local_err);
-                local_err = NULL;
-                goto out;
             } else {
                 if (!vsmt_user) {
                     error_append_hint(&local_err,
@@ -2554,13 +2552,11 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
                                       smp_threads, kvm_smt, spapr->vsmt);
                 }
                 kvmppc_error_append_smt_possible_hint(&local_err);
-                goto out;
+                error_propagate(errp, local_err);
             }
         }
     }
     /* else TCG: nothing to do currently */
-out:
-    error_propagate(errp, local_err);
 }
 
 static void spapr_init_cpus(SpaprMachineState *spapr)
@@ -3686,9 +3682,8 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     SpaprDrc *drc;
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
-        error_setg(&local_err,
-                   "nvdimm device hot unplug is not supported yet.");
-        goto out;
+        error_setg(errp, "nvdimm device hot unplug is not supported yet.");
+        return;
     }
 
     size = memory_device_get_region_size(MEMORY_DEVICE(dimm), &error_abort);
@@ -3697,7 +3692,8 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
     addr_start = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                          &local_err);
     if (local_err) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
 
     /*
@@ -3707,10 +3703,9 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
      * bail out to avoid detaching DRCs that were already released.
      */
     if (spapr_pending_dimm_unplugs_find(spapr, dimm)) {
-        error_setg(&local_err,
-                   "Memory unplug already in progress for device %s",
+        error_setg(errp, "Memory unplug already in progress for device %s",
                    dev->id);
-        goto out;
+        return;
     }
 
     spapr_pending_dimm_unplugs_add(spapr, nr_lmbs, dimm);
@@ -3729,8 +3724,6 @@ static void spapr_memory_unplug_request(HotplugHandler *hotplug_dev,
                           addr_start / SPAPR_MEMORY_BLOCK_SIZE);
     spapr_hotplug_req_remove_by_count_indexed(SPAPR_DR_CONNECTOR_TYPE_LMB,
                                               nr_lmbs, spapr_drc_index(drc));
-out:
-    error_propagate(errp, local_err);
 }
 
 /* Callback to be called during DRC release. */
@@ -3891,7 +3884,6 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     MachineState *machine = MACHINE(OBJECT(hotplug_dev));
     MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
-    Error *local_err = NULL;
     CPUCore *cc = CPU_CORE(dev);
     const char *base_core_type = spapr_get_cpu_core_type(machine->cpu_type);
     const char *type = object_get_typename(OBJECT(dev));
@@ -3900,18 +3892,18 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     unsigned int smp_threads = machine->smp.threads;
 
     if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
-        error_setg(&local_err, "CPU hotplug not supported for this machine");
-        goto out;
+        error_setg(errp, "CPU hotplug not supported for this machine");
+        return;
     }
 
     if (strcmp(base_core_type, type)) {
-        error_setg(&local_err, "CPU core type should be %s", base_core_type);
-        goto out;
+        error_setg(errp, "CPU core type should be %s", base_core_type);
+        return;
     }
 
     if (cc->core_id % smp_threads) {
-        error_setg(&local_err, "invalid core id %d", cc->core_id);
-        goto out;
+        error_setg(errp, "invalid core id %d", cc->core_id);
+        return;
     }
 
     /*
@@ -3921,26 +3913,23 @@ static void spapr_core_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      * total vcpus not a multiple of threads-per-core.
      */
     if (mc->has_hotpluggable_cpus && (cc->nr_threads != smp_threads)) {
-        error_setg(&local_err, "invalid nr-threads %d, must be %d",
-                   cc->nr_threads, smp_threads);
-        goto out;
+        error_setg(errp, "invalid nr-threads %d, must be %d", cc->nr_threads,
+                   smp_threads);
+        return;
     }
 
     core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
     if (!core_slot) {
-        error_setg(&local_err, "core id %d out of range", cc->core_id);
-        goto out;
+        error_setg(errp, "core id %d out of range", cc->core_id);
+        return;
     }
 
     if (core_slot->cpu) {
-        error_setg(&local_err, "core %d already populated", cc->core_id);
-        goto out;
+        error_setg(errp, "core %d already populated", cc->core_id);
+        return;
     }
 
-    numa_cpu_pre_plug(core_slot, dev, &local_err);
-
-out:
-    error_propagate(errp, local_err);
+    numa_cpu_pre_plug(core_slot, dev, errp);
 }
 
 int spapr_phb_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 223bb8f464..2a6a48744a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1499,10 +1499,10 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
          * we need to let them know it's not enabled
          */
         if (plugged_dev->hotplugged) {
-            error_setg(&local_err, QERR_BUS_NO_HOTPLUG,
+            error_setg(errp, QERR_BUS_NO_HOTPLUG,
                        object_get_typename(OBJECT(phb)));
         }
-        goto out;
+        return;
     }
 
     g_assert(drc);
@@ -1517,15 +1517,16 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
      */
     if (plugged_dev->hotplugged && bus->devices[PCI_DEVFN(slotnr, 0)] &&
         PCI_FUNC(pdev->devfn) != 0) {
-        error_setg(&local_err, "PCI: slot %d function 0 already ocuppied by %s,"
+        error_setg(errp, "PCI: slot %d function 0 already ocuppied by %s,"
                    " additional functions can no longer be exposed to guest.",
                    slotnr, bus->devices[PCI_DEVFN(slotnr, 0)]->name);
-        goto out;
+        return;
     }
 
     spapr_drc_attach(drc, DEVICE(pdev), &local_err);
     if (local_err) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
 
     /* If this is function 0, signal hotplug for all the device functions.
@@ -1551,9 +1552,6 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
             }
         }
     }
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7c893e5683..d46b1f094f 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -117,7 +117,6 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
     uint64_t pentry;
     char *magic;
     int kernel_size;
-    Error *err = NULL;
 
     int bios_size;
     char *bios_filename;
@@ -135,8 +134,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
 
         bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (bios_filename == NULL) {
-            error_setg(&err, "could not find stage1 bootloader");
-            goto error;
+            error_setg(errp, "could not find stage1 bootloader");
+            return;
         }
 
         bios_size = load_elf(bios_filename, NULL,
@@ -155,8 +154,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
         g_free(bios_filename);
 
         if (bios_size == -1) {
-            error_setg(&err, "could not load bootloader '%s'", bios_name);
-            goto error;
+            error_setg(errp, "could not load bootloader '%s'", bios_name);
+            return;
         }
 
         /* default boot target is the bios */
@@ -170,8 +169,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
         if (kernel_size < 0) {
             kernel_size = load_image_targphys(ipl->kernel, 0, ram_size);
             if (kernel_size < 0) {
-                error_setg(&err, "could not load kernel '%s'", ipl->kernel);
-                goto error;
+                error_setg(errp, "could not load kernel '%s'", ipl->kernel);
+                return;
             }
             /* if this is Linux use KERN_IMAGE_START */
             magic = rom_ptr(LINUX_MAGIC_ADDR, 6);
@@ -183,8 +182,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
                 if (ipl_psw) {
                     pentry = be32_to_cpu(*ipl_psw) & PSW_MASK_SHORT_ADDR;
                 } else {
-                    error_setg(&err, "Could not get IPL PSW");
-                    goto error;
+                    error_setg(errp, "Could not get IPL PSW");
+                    return;
                 }
             }
         }
@@ -217,8 +216,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
             initrd_size = load_image_targphys(ipl->initrd, initrd_offset,
                                               ram_size - initrd_offset);
             if (initrd_size == -1) {
-                error_setg(&err, "could not load initrd '%s'", ipl->initrd);
-                goto error;
+                error_setg(errp, "could not load initrd '%s'", ipl->initrd);
+                return;
             }
 
             /*
@@ -248,8 +247,6 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
      * TODO: there should be a better way to do this.
      */
     qemu_register_reset(resettable_cold_reset_fn, dev);
-error:
-    error_propagate(errp, err);
 }
 
 static Property s390_ipl_properties[] = {
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 31ec5add1d..d0d7c720a6 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -2052,10 +2052,9 @@ void xen_pt_config_init(XenPCIPassthroughState *s, Error **errp)
                                                   reg_grp_offset,
                                                   &reg_grp_entry->size);
             if (rc < 0) {
-                error_setg(&err, "Failed to initialize %d/%zu, type = 0x%x,"
+                error_setg(errp, "Failed to initialize %d/%zu, type = 0x%x,"
                            " rc: %d", i, ARRAY_SIZE(xen_pt_emu_reg_grps),
                            xen_pt_emu_reg_grps[i].grp_type, rc);
-                error_propagate(errp, err);
                 xen_pt_config_delete(s);
                 return;
             }
diff --git a/iothread.c b/iothread.c
index cb65ef0e56..aa8830fed2 100644
--- a/iothread.c
+++ b/iothread.c
@@ -244,13 +244,14 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
     int64_t value;
 
     if (!visit_type_int64(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
 
     if (value < 0) {
-        error_setg(&local_err, "%s value must be in range [0, %"PRId64"]",
+        error_setg(errp, "%s value must be in range [0, %" PRId64 "]",
                    info->name, INT64_MAX);
-        goto out;
+        return;
     }
 
     *field = value;
@@ -260,11 +261,8 @@ static void iothread_set_poll_param(Object *obj, Visitor *v,
                                     iothread->poll_max_ns,
                                     iothread->poll_grow,
                                     iothread->poll_shrink,
-                                    &local_err);
+                                    errp);
     }
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void iothread_class_init(ObjectClass *klass, void *class_data)
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 6835d42363..d75169e28f 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1097,17 +1097,15 @@ static void compare_set_timeout(Object *obj, Visitor *v,
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (!value) {
-        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+        error_setg(errp, "Property '%s.%s' requires a positive value",
                    object_get_typename(obj), name);
-        goto out;
+        return;
     }
     s->compare_timeout = value;
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void compare_get_expired_scan_cycle(Object *obj, Visitor *v,
@@ -1129,17 +1127,15 @@ static void compare_set_expired_scan_cycle(Object *obj, Visitor *v,
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (!value) {
-        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+        error_setg(errp, "Property '%s.%s' requires a positive value",
                    object_get_typename(obj), name);
-        goto out;
+        return;
     }
     s->expired_scan_cycle = value;
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void compare_pri_rs_finalize(SocketReadState *pri_rs)
diff --git a/net/dump.c b/net/dump.c
index 8c487a5590..f7a302f56c 100644
--- a/net/dump.c
+++ b/net/dump.c
@@ -196,17 +196,15 @@ static void filter_dump_set_maxlen(Object *obj, Visitor *v, const char *name,
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (value == 0) {
-        error_setg(&local_err, "Property '%s.%s' doesn't take value '%u'",
+        error_setg(errp, "Property '%s.%s' doesn't take value '%u'",
                    object_get_typename(obj), name, value);
-        goto out;
+        return;
     }
     nfds->maxlen = value;
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static char *file_dump_get_filename(Object *obj, Error **errp)
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 8e42934b37..143627fcaf 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -174,17 +174,15 @@ static void filter_buffer_set_interval(Object *obj, Visitor *v,
     uint32_t value;
 
     if (!visit_type_uint32(v, name, &value, &local_err)) {
-        goto out;
+        error_propagate(errp, local_err);
+        return;
     }
     if (!value) {
-        error_setg(&local_err, "Property '%s.%s' requires a positive value",
+        error_setg(errp, "Property '%s.%s' requires a positive value",
                    object_get_typename(obj), name);
-        goto out;
+        return;
     }
     s->interval = value;
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static void filter_buffer_init(Object *obj)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 5ba56327dd..0f4911082f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -278,13 +278,10 @@ out:
 static void execute_async(DWORD WINAPI (*func)(LPVOID), LPVOID opaque,
                           Error **errp)
 {
-    Error *local_err = NULL;
-
     HANDLE thread = CreateThread(NULL, 0, func, opaque, 0, NULL);
     if (!thread) {
-        error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
                    "failed to dispatch asynchronous command");
-        error_propagate(errp, local_err);
     }
 }
 
@@ -1270,35 +1267,31 @@ typedef enum {
 static void check_suspend_mode(GuestSuspendMode mode, Error **errp)
 {
     SYSTEM_POWER_CAPABILITIES sys_pwr_caps;
-    Error *local_err = NULL;
 
     ZeroMemory(&sys_pwr_caps, sizeof(sys_pwr_caps));
     if (!GetPwrCapabilities(&sys_pwr_caps)) {
-        error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
                    "failed to determine guest suspend capabilities");
-        goto out;
+        return;
     }
 
     switch (mode) {
     case GUEST_SUSPEND_MODE_DISK:
         if (!sys_pwr_caps.SystemS4) {
-            error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
+            error_setg(errp, QERR_QGA_COMMAND_FAILED,
                        "suspend-to-disk not supported by OS");
         }
         break;
     case GUEST_SUSPEND_MODE_RAM:
         if (!sys_pwr_caps.SystemS3) {
-            error_setg(&local_err, QERR_QGA_COMMAND_FAILED,
+            error_setg(errp, QERR_QGA_COMMAND_FAILED,
                        "suspend-to-ram not supported by OS");
         }
         break;
     default:
-        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "mode",
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "mode",
                    "GuestSuspendMode");
     }
-
-out:
-    error_propagate(errp, local_err);
 }
 
 static DWORD WINAPI do_suspend(LPVOID opaque)
-- 
2.26.2


