Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A809CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 745DF206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPd5yRrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745DF206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpPQ-0003a1-Ls
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMH-00078I-3f
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMG-0000Og-A3
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7IilwtTIGucuZ+gmpKnC2btYQwg+/emdQgburwkuF3U=;
 b=PPd5yRrTBvMS4XzBaLlEy32L3OfZXB7uCFkHN8p40yMvGPJqfH+SDiWFbFgtv8m6CoT6Co
 Fl6kF6eQ9bmlzAVI+aFqp4UX+LZgbkDEwhg/QSt/1tJNlGJuY2OAg8cmheiQUsXYE2sTFA
 soFF0lujpc4Kgjilo2zBTTwrP4IyTUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-0urXWhINOgOpQlyOO1q_rA-1; Mon, 01 Jun 2020 14:40:15 -0400
X-MC-Unique: 0urXWhINOgOpQlyOO1q_rA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEB3119057A8;
 Mon,  1 Jun 2020 18:40:14 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 403F010016DA;
 Mon,  1 Jun 2020 18:40:13 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/12] migration/rdma: fix potential nullptr access in
 rdma_start_incoming_migration
Date: Mon,  1 Jun 2020 19:39:53 +0100
Message-Id: <20200601184004.272784-2-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 11:55:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, lukasstraub2@web.de, quintela@redhat.com,
 pannengyuan@huawei.com, f4bug@amsat.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

'rdma' is NULL when taking the first error branch in rdma_start_incoming_migration.
And it will cause a null pointer access in label 'err'. Fix that.

Fixes: 59c59c67ee6b0327ae932deb303caa47919aeb1e
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200508100755.7875-2-pannengyuan@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
  Note this is CID 1428762
---
 migration/rdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 967fda5b0c..72e8b1c95b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4056,7 +4056,9 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp)
     return;
 err:
     error_propagate(errp, local_err);
-    g_free(rdma->host);
+    if (rdma) {
+        g_free(rdma->host);
+    }
     g_free(rdma);
     g_free(rdma_return_path);
 }
-- 
2.26.2


