Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC54C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7432D20732
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPKOUu+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7432D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLmR-0007uK-AP
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLl0-0004zR-Bv
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32440
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFLkr-0004SC-Vk
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599502834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w82YOpe8gfvzvybGS5qdsCTsw/+g7UNG1/h8tYzz8tw=;
 b=iPKOUu+cw9TG0b+W51LuScVnnjEBuSj63bLeGFnihEk7WAlXHzRm5l/LXElmNA/mtoh0f9
 NUW1/Vxe82GFj67Y9tnS5RZoY1zE1PHPfXwuzDtvzKeRHAtop3jyOcm1UE5pTbMAQ0LSCL
 /dtek6+cJ1Xenzhj0LfyAkSes1SyPW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-XXaSsPmAPdCWJz88Sb7dNg-1; Mon, 07 Sep 2020 14:20:32 -0400
X-MC-Unique: XXaSsPmAPdCWJz88Sb7dNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CDCE1084C85;
 Mon,  7 Sep 2020 18:20:31 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4F16760BF3;
 Mon,  7 Sep 2020 18:20:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 05/29] qemu-storage-daemon: Use qmp_block_export_add()
Date: Mon,  7 Sep 2020 20:19:47 +0200
Message-Id: <20200907182011.521007-6-kwolf@redhat.com>
In-Reply-To: <20200907182011.521007-1-kwolf@redhat.com>
References: <20200907182011.521007-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 02:54:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason to duplicate the functionality locally, we can now just reuse
the QMP command block-export-add for --export.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 storage-daemon/qemu-storage-daemon.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/storage-daemon/qemu-storage-daemon.c b/storage-daemon/qemu-storage-daemon.c
index ed26097254..b6f678d3ab 100644
--- a/storage-daemon/qemu-storage-daemon.c
+++ b/storage-daemon/qemu-storage-daemon.c
@@ -150,17 +150,6 @@ static void init_qmp_commands(void)
                          qmp_marshal_qmp_capabilities, QCO_ALLOW_PRECONFIG);
 }
 
-static void init_export(BlockExportOptions *export, Error **errp)
-{
-    switch (export->type) {
-    case BLOCK_EXPORT_TYPE_NBD:
-        qmp_nbd_server_add(&export->u.nbd, errp);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static void process_options(int argc, char *argv[])
 {
     int c;
@@ -241,7 +230,7 @@ static void process_options(int argc, char *argv[])
                 visit_type_BlockExportOptions(v, NULL, &export, &error_fatal);
                 visit_free(v);
 
-                init_export(export, &error_fatal);
+                qmp_block_export_add(export, &error_fatal);
                 qapi_free_BlockExportOptions(export);
                 break;
             }
-- 
2.25.4


