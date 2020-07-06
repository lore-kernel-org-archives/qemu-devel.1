Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF35C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF02D20663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2CSzn8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF02D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXvs-0005Q0-35
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52744)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuX-0003Gz-VI
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48168
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuV-0002aj-CM
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594068018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dNzyunD+pXhvAn7yN59D05TDaVZOw7qKdTybXGhF/gE=;
 b=W2CSzn8biLyNueKZoPkLLyT9C0m+1PKnapwdIFHSaa9RWUarLkMeXxzm7R0pdIEGXbwoy2
 gOPxKelZrT63qMBhepkuWVvWnCnLFORZHF/SlnSy8UfF8EHiWF8Uvtud+58bjkRMlG0+y/
 R9iAjS7+cQGJZQ3CuoQqohx8fjLUFVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-Lv8V9O8BNdq1Jot4-GkQng-1; Mon, 06 Jul 2020 16:40:14 -0400
X-MC-Unique: Lv8V9O8BNdq1Jot4-GkQng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFC97100CCC4;
 Mon,  6 Jul 2020 20:40:11 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72D3F7B400;
 Mon,  6 Jul 2020 20:40:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/10] sheepdog: Add trivial backing_fmt support
Date: Mon,  6 Jul 2020 15:39:47 -0500
Message-Id: <20200706203954.341758-4-eblake@redhat.com>
In-Reply-To: <20200706203954.341758-1-eblake@redhat.com>
References: <20200706203954.341758-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: kwolf@redhat.com, pkrempa@redhat.com,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 kchamart@redhat.com, libvir-list@redhat.com, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, mreitz@redhat.com,
 "open list:Trivial patches" <qemu-trivial@nongnu.org>,
 Liu Yuan <namei.unix@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Sheepdog already requires that if backing_file is present, that it be
another sheepdog image (see sd_co_create).  Meanwhile, we want to move
towards always being explicit about the backing format for other
drivers where it matters.  So for convenience, make qemu-img create -F
sheepdog work, while rejecting all other explicit formats (note that
this is only for QemuOpts usage; there is no change to the QAPI to
allow a format through -blockdev).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/sheepdog.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index 27a30d17f4c9..548ce54cbc7e 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2157,13 +2157,21 @@ static int coroutine_fn sd_co_create_opts(BlockDriver *drv,
                                           Error **errp)
 {
     BlockdevCreateOptions *create_options = NULL;
-    QDict *qdict, *location_qdict;
+    QDict *qdict = NULL, *location_qdict;
     Visitor *v;
-    char *redundancy;
+    char *redundancy = NULL;
     Error *local_err = NULL;
     int ret;
+    char *backing_fmt = NULL;

     redundancy = qemu_opt_get_del(opts, BLOCK_OPT_REDUNDANCY);
+    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
+
+    if (backing_fmt && strcmp(backing_fmt, "sheepdog") != 0) {
+        error_setg(errp, "backing_file must be a sheepdog image");
+        ret = -EINVAL;
+        goto fail;
+    }

     qdict = qemu_opts_to_qdict(opts, NULL);
     qdict_put_str(qdict, "driver", "sheepdog");
@@ -2228,6 +2236,7 @@ fail:
     qapi_free_BlockdevCreateOptions(create_options);
     qobject_unref(qdict);
     g_free(redundancy);
+    g_free(backing_fmt);
     return ret;
 }

@@ -3185,6 +3194,11 @@ static QemuOptsList sd_create_opts = {
             .type = QEMU_OPT_STRING,
             .help = "File name of a base image"
         },
+        {
+            .name = BLOCK_OPT_BACKING_FMT,
+            .type = QEMU_OPT_STRING,
+            .help = "Must be 'sheepdog' if present",
+        },
         {
             .name = BLOCK_OPT_PREALLOC,
             .type = QEMU_OPT_STRING,
-- 
2.27.0


