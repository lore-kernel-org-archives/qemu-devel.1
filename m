Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABBC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FE8206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 18:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJaXMXmB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FE8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfpNP-00008R-4b
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 14:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMD-000768-U8
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47233
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jfpMC-0000NP-TO
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 14:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591036819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GMgXmwsT0ZMPDuvgnPnj8GTOcKiU1qr0vzAPPB73P1Q=;
 b=NJaXMXmBdbhI1b5E9V5WAbHmVrjftf0eE74s3jE4NkP0xPEQpG9sdZ6F1FAScv0q26Ylwo
 S25CVldoCFBti4kyoPvg3+AqsvaxJNUeTOmk6l1TQnT7xK5Hd5ZqgUYG0UqFRIIVjbvw/v
 j6xQUKBM3PkrrJsSx8jok1szhh+6/Jk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-RUubKlE8MQCQNt9GYhO5Mw-1; Mon, 01 Jun 2020 14:40:17 -0400
X-MC-Unique: RUubKlE8MQCQNt9GYhO5Mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94731107ACF6;
 Mon,  1 Jun 2020 18:40:16 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1624110016DA;
 Mon,  1 Jun 2020 18:40:14 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] migration/rdma: cleanup rdma context before g_free to
 avoid memleaks
Date: Mon,  1 Jun 2020 19:39:54 +0100
Message-Id: <20200601184004.272784-3-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
References: <20200601184004.272784-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 13:44:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_HK_NAME_DR=0.01, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

When error happen in initializing 'rdma_return_path', we should cleanup rdma context
before g_free(rdma) to avoid some memleaks. This patch fix that.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200508100755.7875-3-pannengyuan@huawei.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/rdma.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 72e8b1c95b..ec45d33ba3 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4094,20 +4094,20 @@ void rdma_start_outgoing_migration(void *opaque,
         rdma_return_path = qemu_rdma_data_init(host_port, errp);
 
         if (rdma_return_path == NULL) {
-            goto err;
+            goto return_path_err;
         }
 
         ret = qemu_rdma_source_init(rdma_return_path,
             s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL], errp);
 
         if (ret) {
-            goto err;
+            goto return_path_err;
         }
 
         ret = qemu_rdma_connect(rdma_return_path, errp);
 
         if (ret) {
-            goto err;
+            goto return_path_err;
         }
 
         rdma->return_path = rdma_return_path;
@@ -4120,6 +4120,8 @@ void rdma_start_outgoing_migration(void *opaque,
     s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
     migrate_fd_connect(s, NULL);
     return;
+return_path_err:
+    qemu_rdma_cleanup(rdma);
 err:
     g_free(rdma);
     g_free(rdma_return_path);
-- 
2.26.2


