Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C77FC433ED
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF6F2076D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 15:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0b8ioRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF6F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv0rb-0001s4-NC
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 11:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv0ql-0000Yz-KT
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:58:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv0qk-0008Nx-1x
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 11:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594655916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSXs5uHMzPA+HV1XAvpWMRauXPt+1ol/OUGDFgw63qY=;
 b=Q0b8ioRw3zJKf0baRevOZM9QuR9pJEGKnZ7K6lHkNfHVzsdL21TxvjTvmIP1CGL2UxRTf+
 /ZS/vIt+qZFdRDFXCxxiCo/1DNXvQOB0kL0iYvB0V7URbAa/2mNDh65U9BredN8bDFzKt9
 QlcekQ0FHG9c4DmXAOpWPQbBNZLHw4I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-kgmh5IuKOhq_JHMb-VvZMA-1; Mon, 13 Jul 2020 11:58:35 -0400
X-MC-Unique: kgmh5IuKOhq_JHMb-VvZMA-1
Received: by mail-wr1-f70.google.com with SMTP id j5so17968268wro.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 08:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FSXs5uHMzPA+HV1XAvpWMRauXPt+1ol/OUGDFgw63qY=;
 b=nLodB/yMkr3Fiktrpn2kDXrIYf1ZrY1/qQSIy0i1xddB5TzG6CMP/a0LnFSvRvvO3f
 YxB3Jd0OgZx2HSuAPppJ5jOUOc05W6fMZ0L+HkYYa42x2NEbgdej4UWRnQDZohqN0qjP
 +/X4OrVfhac2EqR1bhRWz+s9yl8uY2RAbLna6cKh9wTleE4XB5gO1tJasmR56HhNuPw4
 8T4trIwTCQRLLpVgZsKPG+gCQG//AF77UZ+1zJUpHKH0kQG5lmkkkf0yQXNrKYl/rphx
 /OC1Ewd+ujSssKHqEux6DIWnmvO0eAytAWms+FDA1zHh6PE9qMzq9L/78d0I+CfU/8qD
 0EaA==
X-Gm-Message-State: AOAM530aphkqoUCRkeea/455rYYkvUGAC+yM777l6+9vqxL87DK+ePzC
 qyNJOeRbA0rWkowBP1KEU0PJP2krqLzlN749q7J0fqgGqvfbT7jTeajgqEa6O3fCEV+zSPRsorB
 S8NefAaDix7tz7fQ=
X-Received: by 2002:adf:e908:: with SMTP id f8mr14594wrm.3.1594655913768;
 Mon, 13 Jul 2020 08:58:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxTvkKMxKz1a0w2g1oG1cIZ8bxmtRL9oMzRNquu1xdFxvz2QOZW+Rw4VD8eorJGp7RbKw8UzQ==
X-Received: by 2002:adf:e908:: with SMTP id f8mr14582wrm.3.1594655913590;
 Mon, 13 Jul 2020 08:58:33 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id b10sm38018wmj.30.2020.07.13.08.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 08:58:32 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] migration/migration.c: Remove superfluous breaks
Date: Mon, 13 Jul 2020 17:58:27 +0200
Message-Id: <20200713155827.10670-4-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713155827.10670-1-quintela@redhat.com>
References: <20200713155827.10670-1-quintela@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=quintela@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 01:36:29
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, quintela@trasno.org,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 08519de56f..2ed9923227 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -986,7 +986,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         /* no migration has happened ever */
         /* do not overwrite destination migration status */
         return;
-        break;
     case MIGRATION_STATUS_SETUP:
         info->has_status = true;
         info->has_total_time = false;
@@ -1105,7 +1104,6 @@ static void fill_destination_migration_info(MigrationInfo *info)
     switch (mis->state) {
     case MIGRATION_STATUS_NONE:
         return;
-        break;
     case MIGRATION_STATUS_SETUP:
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
-- 
2.25.4


