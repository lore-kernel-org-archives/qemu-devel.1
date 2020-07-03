Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E5320723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhX8BgxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E5320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHvA-00061S-FN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHf0-0005Qk-9W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:07:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHex-0004yU-36
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZxzgbY0wTkljt/EIcrPmrPRKcNp5zQS1Y4vQ0bafojw=;
 b=VhX8BgxQq2bZavQNN//1Omt5nKMHHs/uS84PX+BdBybOtp8paHWdIW8lKpJS9EUf/uPGS0
 +uPv0E8rqYDdidCVjpPmXsKuhHTejVABfVeBm97LwMyf53U9jaQbK9Scrt1QKiHcPfCKu4
 BYxb/2HwikUGmWEmqqOo2N6rFsdjUJk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-ysxpQMUKNm-44GLJukqC5g-1; Fri, 03 Jul 2020 05:04:05 -0400
X-MC-Unique: ysxpQMUKNm-44GLJukqC5g-1
Received: by mail-wr1-f69.google.com with SMTP id y13so31107281wrp.13
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZxzgbY0wTkljt/EIcrPmrPRKcNp5zQS1Y4vQ0bafojw=;
 b=OU4zneLBt/vsoy7sdktpCtKMk5bDFS8Ejzs75aRNMbbswXSeFguiUUtzvBurQg8bmG
 FfyGIbRT2ESw+naaCt9ma3/FhCQNn9PDBGMeGewIzFjoIsAmS0MR6X/G2CyIfumW3anL
 KVXu+Gk/zFN6HUPgXNVEnlac1kyA+ycjKYSmzN/fIN2Xm83sJAVPzT9hF3PdSuAfcp1r
 dCSTgnHFDvInil1W+kQkZNunS1NkGgT4vcVAROdU6WtpqwR+3r3ZrGczHNm3qPV+d51R
 43Jj/d2cJeX8sCmEQBzDG5wZVgVZOodZ2GYDP0LYn7coSBAOlS1LJIGafo/e+8lgIjQS
 DuCQ==
X-Gm-Message-State: AOAM533AHQo3D3MsvO6dkyjfP+vWzAS6362E+GmK34qgGjkaSqWCAU6L
 WgtEnuRu5ku5GJkFJc/W6t6usMYyhHeTHee5862WeMhycdyRIORtci2HGuOQyxxkDJqoUIPgEV+
 IyEEM6Y00ppm6jvA=
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr35090392wme.186.1593767044428; 
 Fri, 03 Jul 2020 02:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoXMe/rD/7RnQBvEfegqwXv7OIm23PiFFWYgzAgjS4lFwwQLu2bFpHNTFcrV601IursYfejA==
X-Received: by 2002:a05:600c:2182:: with SMTP id
 e2mr35090378wme.186.1593767044206; 
 Fri, 03 Jul 2020 02:04:04 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 z25sm12292724wmk.28.2020.07.03.02.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:04:03 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:04:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/41] migration/colo: Use ram_block_discard_disable()
Message-ID: <20200703090252.368694-13-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

COLO will copy all memory in a RAM block, disable discarding of RAM.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Lukas Straub <lukasstraub2@web.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200626072248.78761-10-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/colo.h |  2 +-
 migration/migration.c    |  8 +++++++-
 migration/savevm.c       | 11 +++++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 1636e6f907..768e1f04c3 100644
--- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,7 +25,7 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
 
 /* loadvm */
-void migration_incoming_enable_colo(void);
+int migration_incoming_enable_colo(void);
 void migration_incoming_disable_colo(void);
 bool migration_incoming_colo_enabled(void);
 void *colo_process_incoming_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index d365d82209..92e44e021e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -338,12 +338,18 @@ bool migration_incoming_colo_enabled(void)
 
 void migration_incoming_disable_colo(void)
 {
+    ram_block_discard_disable(false);
     migration_colo_enabled = false;
 }
 
-void migration_incoming_enable_colo(void)
+int migration_incoming_enable_colo(void)
 {
+    if (ram_block_discard_disable(true)) {
+        error_report("COLO: cannot disable RAM discard");
+        return -EBUSY;
+    }
     migration_colo_enabled = true;
+    return 0;
 }
 
 void migrate_add_address(SocketAddress *address)
diff --git a/migration/savevm.c b/migration/savevm.c
index b979ea6e7f..6e01724605 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2111,8 +2111,15 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
 
 static int loadvm_process_enable_colo(MigrationIncomingState *mis)
 {
-    migration_incoming_enable_colo();
-    return colo_init_ram_cache();
+    int ret = migration_incoming_enable_colo();
+
+    if (!ret) {
+        ret = colo_init_ram_cache();
+        if (ret) {
+            migration_incoming_disable_colo();
+        }
+    }
+    return ret;
 }
 
 /*
-- 
MST


