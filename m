Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D2C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09A4206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KVqCqXfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09A4206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6G8q-00046n-U2
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G76-0001pD-HN
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k6G74-0001Dg-W9
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597336198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zk7z5h8S3NWxmmAkCxBtINH2cvSr9u+MxB0Ck8Ngt4Q=;
 b=KVqCqXfR/NN8ows3twrAL77odTVOIjuKfNUCzEUWwvFNi+rRtWNQNy9nniLXZcoHADRycn
 vjhzEUu7a04o706dl9fGYt6LVKDnOwdkSq1fZaYInxKpyzvL3d5lEaQqkH7eP3gFO6YIPD
 47widmPDHn/1ujxFjjslOcr2GSUQeTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-566-1hKB9V1aOGONraYORSqLww-1; Thu, 13 Aug 2020 12:29:54 -0400
X-MC-Unique: 1hKB9V1aOGONraYORSqLww-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2F551DDE8;
 Thu, 13 Aug 2020 16:29:53 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-97.ams2.redhat.com [10.36.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C37975C1A3;
 Thu, 13 Aug 2020 16:29:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [RFC PATCH 05/22] qemu-storage-daemon: Use qmp_block_export_add()
Date: Thu, 13 Aug 2020 18:29:18 +0200
Message-Id: <20200813162935.210070-6-kwolf@redhat.com>
In-Reply-To: <20200813162935.210070-1-kwolf@redhat.com>
References: <20200813162935.210070-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
---
 qemu-storage-daemon.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/qemu-storage-daemon.c b/qemu-storage-daemon.c
index ed26097254..b6f678d3ab 100644
--- a/qemu-storage-daemon.c
+++ b/qemu-storage-daemon.c
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


