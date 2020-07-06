Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B2C433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8622C20663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 20:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JROnbTxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8622C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsXxj-0000gr-Rp
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 16:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuU-0003B2-LR
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28855
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsXuS-0002We-Ji
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 16:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594068015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EPqpSgUt6DDbkbtCknxzu7tgVde2nJvZJCDkg/HX0w=;
 b=JROnbTxHe5zK2BZe9aJY243eIiX1HE5IIR3R6zofvZY6lsx1TAuk53/bpaqwSs802edaxd
 XE3QNjuA146n/rl9N9J9iMo4JwsfrkO+Vtule0o3GghG2gB4gyaV9bwUVoaag9nNF6wtA8
 awpnDYTzGwEY3aUCRV979yf5g9X9WNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-IouY_cVpNMm-FoMF_BOIHA-1; Mon, 06 Jul 2020 16:40:14 -0400
X-MC-Unique: IouY_cVpNMm-FoMF_BOIHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B88A8107ACF3;
 Mon,  6 Jul 2020 20:40:12 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEE697B419;
 Mon,  6 Jul 2020 20:40:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 04/10] vmdk: Add trivial backing_fmt support
Date: Mon,  6 Jul 2020 15:39:48 -0500
Message-Id: <20200706203954.341758-5-eblake@redhat.com>
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
Cc: kwolf@redhat.com, Fam Zheng <fam@euphon.net>, pkrempa@redhat.com,
 qemu-block@nongnu.org, kchamart@redhat.com, libvir-list@redhat.com,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 mreitz@redhat.com, "open list:Trivial patches" <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

vmdk already requires that if backing_file is present, that it be
another vmdk image (see vmdk_co_do_create).  Meanwhile, we want to
move towards always being explicit about the backing format for other
drivers where it matters.  So for convenience, make qemu-img create -F
vmdk work, while rejecting all other explicit formats (note that this
is only for QemuOpts usage; there is no change to the QAPI to allow a
format through -blockdev).

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/vmdk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 62da4651263b..6c58e5ec2e43 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2638,6 +2638,14 @@ static int coroutine_fn vmdk_co_create_opts(BlockDriver *drv,
     bool zeroed_grain;
     bool compat6;
     VMDKCreateOptsData data;
+    char *backing_fmt = NULL;
+
+    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
+    if (backing_fmt && strcmp(backing_fmt, "vmdk") != 0) {
+        error_setg(errp, "backing_file must be a vmdk image");
+        ret = -EINVAL;
+        goto exit;
+    }

     if (filename_decompose(filename, path, prefix, postfix, PATH_MAX, errp)) {
         ret = -EINVAL;
@@ -2696,6 +2704,7 @@ static int coroutine_fn vmdk_co_create_opts(BlockDriver *drv,
                             vmdk_co_create_opts_cb, &data, errp);

 exit:
+    g_free(backing_fmt);
     g_free(adapter_type);
     g_free(backing_file);
     g_free(hw_version);
@@ -3031,6 +3040,11 @@ static QemuOptsList vmdk_create_opts = {
             .type = QEMU_OPT_STRING,
             .help = "File name of a base image"
         },
+        {
+            .name = BLOCK_OPT_BACKING_FMT,
+            .type = QEMU_OPT_STRING,
+            .help = "Must be 'vmdk' if present",
+        },
         {
             .name = BLOCK_OPT_COMPAT6,
             .type = QEMU_OPT_BOOL,
-- 
2.27.0


