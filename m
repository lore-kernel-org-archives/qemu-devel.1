Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B12C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:47:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA80F206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYVPyURk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA80F206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBvp-0005TB-WE
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBu0-0003AK-D2
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:46:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37141
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBty-0008SG-Sx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593506762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4OdiuYWUT/NsSh0UZ4Bu8hFH0cnJCjLcFyd/R6GnuQ=;
 b=bYVPyURkHUU5OE6AD5QGjLB89gYRZgzNIsZARE65f56xTb50J30gTn4xyI+qFCzjZJ+/7V
 JS9gpzqtmicjKojW9xeNNWA4MnkmdesPO/jVqG/OfYG6v57etmTX4sg/4s3wft0srhERB4
 /4iv6G+Z+PZCG+0c98UmFvCTNrOKOXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-qzH8Kp4yNCOjcWWswHO05g-1; Tue, 30 Jun 2020 04:45:58 -0400
X-MC-Unique: qzH8Kp4yNCOjcWWswHO05g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D9C6464;
 Tue, 30 Jun 2020 08:45:57 +0000 (UTC)
Received: from localhost (ovpn-113-102.ams2.redhat.com [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F375D9E7;
 Tue, 30 Jun 2020 08:45:56 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/4] migration: Prevent memleak by ...params_test_apply
Date: Tue, 30 Jun 2020 10:45:49 +0200
Message-Id: <20200630084552.46362-2-mreitz@redhat.com>
In-Reply-To: <20200630084552.46362-1-mreitz@redhat.com>
References: <20200630084552.46362-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The created structure is not really a proper QAPI object, so we cannot
and will not free its members.  Strings therein should therefore not be
duplicated, or we will leak them.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 migration/migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 481a590f72..47c7da4e55 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1336,12 +1336,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
 
     if (params->has_tls_creds) {
         assert(params->tls_creds->type == QTYPE_QSTRING);
-        dest->tls_creds = g_strdup(params->tls_creds->u.s);
+        dest->tls_creds = params->tls_creds->u.s;
     }
 
     if (params->has_tls_hostname) {
         assert(params->tls_hostname->type == QTYPE_QSTRING);
-        dest->tls_hostname = g_strdup(params->tls_hostname->u.s);
+        dest->tls_hostname = params->tls_hostname->u.s;
     }
 
     if (params->has_max_bandwidth) {
-- 
2.26.2


