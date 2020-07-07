Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D25C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73E1720708
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVmFUhAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E1720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqmS-0006m8-Ki
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZe-0007xK-DH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZc-0004D5-QW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+p6YA2/IQj/mVaMKF1Aasa3PnRi3csR0wcUPb/LERXc=;
 b=aVmFUhATB4nIei4BDvvzygwTYGp/vSdsjvMyXCegN39q042aFEDTOgKnoFO4v8A4m8Y82k
 N8YvhYtpdb9Au7DsICJU0hkeifLjUwJVGhdGvDt/5heY1M0kyapR1lNB/V2NtQrtJqn+9/
 BWAiBBdalvXdkjxdiih+Qh2gGdw4IHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-sGho9b6rNKS4_ybDfYRMpA-1; Tue, 07 Jul 2020 12:35:56 -0400
X-MC-Unique: sGho9b6rNKS4_ybDfYRMpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D6658B789B;
 Tue,  7 Jul 2020 16:35:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BDF278460;
 Tue,  7 Jul 2020 16:35:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 06/12] vmdk: Add trivial backing_fmt support
Date: Tue,  7 Jul 2020 18:34:58 +0200
Message-Id: <20200707163504.194740-7-kwolf@redhat.com>
In-Reply-To: <20200707163504.194740-1-kwolf@redhat.com>
References: <20200707163504.194740-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

vmdk already requires that if backing_file is present, that it be
another vmdk image (see vmdk_co_do_create).  Meanwhile, we want to
move towards always being explicit about the backing format for other
drivers where it matters.  So for convenience, make qemu-img create -F
vmdk work, while rejecting all other explicit formats (note that this
is only for QemuOpts usage; there is no change to the QAPI to allow a
format through -blockdev).

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200706203954.341758-5-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block/vmdk.c b/block/vmdk.c
index 62da465126..6c58e5ec2e 100644
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
2.25.4


