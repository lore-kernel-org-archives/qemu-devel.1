Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF30C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC5DD206A1
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 21:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APndEYWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5DD206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtHpp-000464-5u
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 17:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHcA-0000cw-AJ
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:28:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28059
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jtHc4-0002A4-2C
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594243699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8hysvJ4UW/d1lmUNF+Jd2VwlyftILQ1sRLuhd0HV88=;
 b=APndEYWps6IZQZBdBlYKXKP9Cy0+colzAKNWSxkQHisMNZ9M6zyDdV00imBEuEyq2reaWu
 muTlYtIW1bjYMP0p3WUNHxxcEUmytEbHrMgdxZHwQlxHQQAYEdARBO2wwROHG1Cfm+bzBA
 1rMK7V/mqUC6hRWV4PeY55pRkCgrV9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-JQF2lsovPr2Ur-YtgnkrtQ-1; Tue, 07 Jul 2020 17:25:25 -0400
X-MC-Unique: JQF2lsovPr2Ur-YtgnkrtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B12BC100CCC1;
 Tue,  7 Jul 2020 21:25:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59F085C1D0;
 Tue,  7 Jul 2020 21:25:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D6E7710C4AF0; Tue,  7 Jul 2020 23:25:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 51/53] virtio-9p: Use ERRP_GUARD()
Date: Tue,  7 Jul 2020 23:25:01 +0200
Message-Id: <20200707212503.1495927-52-armbru@redhat.com>
In-Reply-To: <20200707212503.1495927-1-armbru@redhat.com>
References: <20200707212503.1495927-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

If we want to check error after errp-function call, we need to
introduce local_err and then propagate it to errp. Instead, use
the ERRP_GUARD() macro, benefits are:
1. No need of explicit error_propagate call
2. No need of explicit local_err variable: use errp directly
3. ERRP_GUARD() leaves errp as is if it's not NULL or
   &error_fatal, this means that we don't break error_abort
   (we'll abort on error_set, not on error_propagate)

If we want to add some info to errp (by error_prepend() or
error_append_hint()), we must use the ERRP_GUARD() macro.
Otherwise, this info will not be added when errp == &error_fatal
(the program will exit prior to the error_append_hint() or
error_prepend() call).  Fix such a case in
v9fs_device_realize_common().

This commit is generated by command

    sed -n '/^virtio-9p$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/errp-guard.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Reported-by: Kevin Wolf <kwolf@redhat.com>
Reported-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Acked-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
[Commit message tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200707165037.1026246-7-armbru@redhat.com>
[ERRP_AUTO_PROPAGATE() renamed to ERRP_GUARD(), and
auto-propagated-errp.cocci to errp-guard.cocci.  Commit message
tweaked again.]
---
 hw/9pfs/9p-local.c | 12 +++++-------
 hw/9pfs/9p.c       |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 54e012e5b4..3107637209 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -1479,10 +1479,10 @@ static void error_append_security_model_hint(Error *const *errp)
 
 static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
 {
+    ERRP_GUARD();
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
     const char *multidevs = qemu_opt_get(opts, "multidevs");
-    Error *local_err = NULL;
 
     if (!sec_model) {
         error_setg(errp, "security_model property not set");
@@ -1516,11 +1516,10 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
             fse->export_flags &= ~V9FS_FORBID_MULTIDEVS;
             fse->export_flags &= ~V9FS_REMAP_INODES;
         } else {
-            error_setg(&local_err, "invalid multidevs property '%s'",
+            error_setg(errp, "invalid multidevs property '%s'",
                        multidevs);
-            error_append_hint(&local_err, "Valid options are: multidevs="
+            error_append_hint(errp, "Valid options are: multidevs="
                               "[remap|forbid|warn]\n");
-            error_propagate(errp, local_err);
             return -1;
         }
     }
@@ -1530,9 +1529,8 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
         return -1;
     }
 
-    if (fsdev_throttle_parse_opts(opts, &fse->fst, &local_err)) {
-        error_propagate_prepend(errp, local_err,
-                                "invalid throttle configuration: ");
+    if (fsdev_throttle_parse_opts(opts, &fse->fst, errp)) {
+        error_prepend(errp, "invalid throttle configuration: ");
         return -1;
     }
 
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 9755fba9a9..2ffd96ade9 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4011,6 +4011,7 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
 int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
                                Error **errp)
 {
+    ERRP_GUARD();
     int i, len;
     struct stat stat;
     FsDriverEntry *fse;
-- 
2.26.2


