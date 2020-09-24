Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B7C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:38:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E424221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 15:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbWH3GoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E424221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLTKX-0007Gu-E9
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTA7-0001Cw-KP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kLTA3-0005Ru-Nb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 11:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600961274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w82YOpe8gfvzvybGS5qdsCTsw/+g7UNG1/h8tYzz8tw=;
 b=fbWH3GoQnDBroiVJQPQk06xj3TtXfIOLnvBvtQ9pKvdOn7WK01TUo9Bs8oYiKFuh0DvrAk
 v0SkMMGp7LcHQRoaCcwcF2GMzNfRR/hNQlSm8u8RAO3n0bd8tLP9pRqp5q6ADZiDaMCZBE
 Z+rt6p4C3wpsDmzohEfT67gqMQxFUFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-dtooQuPDMR-rC0t5ZYAXoQ-1; Thu, 24 Sep 2020 11:27:51 -0400
X-MC-Unique: dtooQuPDMR-rC0t5ZYAXoQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3828064167;
 Thu, 24 Sep 2020 15:27:42 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-72.ams2.redhat.com [10.36.114.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EABEF6E715;
 Thu, 24 Sep 2020 15:27:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 05/31] qemu-storage-daemon: Use qmp_block_export_add()
Date: Thu, 24 Sep 2020 17:26:51 +0200
Message-Id: <20200924152717.287415-6-kwolf@redhat.com>
In-Reply-To: <20200924152717.287415-1-kwolf@redhat.com>
References: <20200924152717.287415-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 mreitz@redhat.com
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


