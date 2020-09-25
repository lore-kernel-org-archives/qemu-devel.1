Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE4C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9F12087D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3ovRp5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9F12087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmid-0001zD-Ak
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWP-0003nw-RE
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWL-0004J1-EM
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxEAC75mi2s7k0AhS1X4K1mrKuNvTrCWZYRq97YBjh0=;
 b=d3ovRp5Yp/2eN9yn/DW9DUVgSuI4S7gO11wMV4xSeVSXa13/8lZK+0tPTo9mVfx8GFMvzx
 SrHeHFX8sImSam/X+nwTK2XyM7Ia5DEcphaOioG/UanrG30TyfuTxWBkYrLHk1zxj4g3wE
 Rg7IOfmhutE9BdNKUP+J55RAqck3gWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-lybUy8fMPN2g6CHcbX7olA-1; Fri, 25 Sep 2020 08:08:08 -0400
X-MC-Unique: lybUy8fMPN2g6CHcbX7olA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D5AE425E6;
 Fri, 25 Sep 2020 12:08:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D947273693;
 Fri, 25 Sep 2020 12:08:04 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 17/26] migration/tls: save hostname into MigrationState
Date: Fri, 25 Sep 2020 13:06:46 +0100
Message-Id: <20200925120655.295142-18-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chuan Zheng <zhengchuan@huawei.com>

hostname is need in multifd-tls, save hostname into MigrationState.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
Message-Id: <1600139042-104593-2-git-send-email-zhengchuan@huawei.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/channel.c   | 1 +
 migration/migration.c | 1 +
 migration/migration.h | 5 +++++
 migration/tls.c       | 2 ++
 4 files changed, 9 insertions(+)

diff --git a/migration/channel.c b/migration/channel.c
index 20e4c8e2dc..8a783baa0b 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -90,5 +90,6 @@ void migration_channel_connect(MigrationState *s,
         }
     }
     migrate_fd_connect(s, error);
+    g_free(s->hostname);
     error_free(error);
 }
diff --git a/migration/migration.c b/migration/migration.c
index de34c995af..838ca79f57 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1896,6 +1896,7 @@ void migrate_init(MigrationState *s)
     s->migration_thread_running = false;
     error_free(s->error);
     s->error = NULL;
+    s->hostname = NULL;
 
     migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
 
diff --git a/migration/migration.h b/migration/migration.h
index e74042362d..deb411aaad 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -259,6 +259,11 @@ struct MigrationState
      * (which is in 4M chunk).
      */
     uint8_t clear_bitmap_shift;
+
+    /*
+     * This save hostname when out-going migration starts
+     */
+    char *hostname;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/tls.c b/migration/tls.c
index 7a02ec8656..8fbf9ac796 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -154,6 +154,8 @@ void migration_tls_channel_connect(MigrationState *s,
         return;
     }
 
+    /* Save hostname into MigrationState for handshake */
+    s->hostname = g_strdup(hostname);
     trace_migration_tls_outgoing_handshake_start(hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
     qio_channel_tls_handshake(tioc,
-- 
2.26.2


