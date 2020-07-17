Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A38C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:56:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E2DA207EA
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TiAk2A32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E2DA207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPv2-0006Vq-JR
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtg-0004Te-MQ
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jwPtf-0008Lx-0T
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594990526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPX8kLVAtwDbN+zRHPq21aCcGSyvJDo9y17QVwL/Oug=;
 b=TiAk2A32oghzVTTFclWJBa+I8pGXtLSfzSq9O2n1Jhc2Amrtf8BTDk+nlXU+V2qdinh51C
 a2LrO8GBFbs+QawFqRbvLZHzA33U+bHmkbfe88NH5IjkU6304kavE4smSMgvyIJ3EEZBQI
 23hbG5LLPr0k47KBMc9HiHtUx6CdjrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-izjtwT_KO3WLVXp6bXZElA-1; Fri, 17 Jul 2020 08:55:23 -0400
X-MC-Unique: izjtwT_KO3WLVXp6bXZElA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F1AA100CCF2;
 Fri, 17 Jul 2020 12:55:21 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-80.ams2.redhat.com [10.36.113.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A8645B560;
 Fri, 17 Jul 2020 12:55:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 03/12] qemu-img resize: Require --shrink for shrinking all
 image formats
Date: Fri, 17 Jul 2020 14:55:01 +0200
Message-Id: <20200717125510.238374-4-kwolf@redhat.com>
In-Reply-To: <20200717125510.238374-1-kwolf@redhat.com>
References: <20200717125510.238374-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU 2.11 introduced the --shrink option for qemu-img resize to avoid
accidentally shrinking images (commit 4ffca8904a3). However, for
compatibility reasons, it was not enforced for raw images yet, but only
a deprecation warning was printed. This warning has existed for long
enough that we can now finally require --shrink for raw images, too, and
error out if it's not given.

Documentation already describes the state as it is after this patch.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200710121717.28339-1-kwolf@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index efb6ca139e..5308773811 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4004,20 +4004,12 @@ static int img_resize(int argc, char **argv)
     }
 
     if (total_size < current_size && !shrink) {
+        error_report("Use the --shrink option to perform a shrink operation.");
         warn_report("Shrinking an image will delete all data beyond the "
                     "shrunken image's end. Before performing such an "
                     "operation, make sure there is no important data there.");
-
-        if (g_strcmp0(bdrv_get_format_name(blk_bs(blk)), "raw") != 0) {
-            error_report(
-              "Use the --shrink option to perform a shrink operation.");
-            ret = -1;
-            goto out;
-        } else {
-            warn_report("Using the --shrink option will suppress this message. "
-                        "Note that future versions of qemu-img may refuse to "
-                        "shrink images without this option.");
-        }
+        ret = -1;
+        goto out;
     }
 
     /*
-- 
2.25.4


