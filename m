Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F72C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 834D520791
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 17:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hjYGd63w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834D520791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv2dm-0006pL-P0
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 13:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv2cj-0005Xp-I2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:52:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jv2ci-0007Rj-2N
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 13:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594662735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSXs5uHMzPA+HV1XAvpWMRauXPt+1ol/OUGDFgw63qY=;
 b=hjYGd63wYiB9YJBr6soR/7tHfETAp92aA2L8CtJeqRgboOcw4sNbOJbFxw+7efDzKYsdcU
 JRo9tL+zVWEbeB3JJeDF0JX5Iz8QDjOJkQ9HmO+vUVOYlrYz+XmMmVCY+PgElJzihpwiVY
 jxN5SfB1BOzW6Zw1WNcrHk///sOAuuE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-YDGEhIfXOiqhMMwsyt0rHA-1; Mon, 13 Jul 2020 13:52:13 -0400
X-MC-Unique: YDGEhIfXOiqhMMwsyt0rHA-1
Received: by mail-wr1-f71.google.com with SMTP id j5so18269347wro.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 10:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FSXs5uHMzPA+HV1XAvpWMRauXPt+1ol/OUGDFgw63qY=;
 b=WVZwF/wsgywfm4jugieoN+bRD2tWBqRzCKRBRROsMTJZJMoQpX6AQrb91pb7TENXp8
 AmSktlavcsNXxs4XEjxNrG4mjDYaYGz/b6PeaIW6wOzoy2REzJWppf8+WugjbejLfpBD
 tiN0uRs1RdKzKjrhbqUTLznPYoVwx48p5UVhKLq/sh4hn/UMgSBjY/RjKysUnktgPfsp
 xUrwfe64qlmCisuudVyUG1RrMslGPnc0yWadMT83MHAIQU/b0rGeShZz9Y/9km2hXnCp
 96KfGJS1t46KGMOcwomeLZi7rwJGYQF+lUPPdG5y/xsqNdTuLg9pCiRtdddxvIpF8NV6
 XXsg==
X-Gm-Message-State: AOAM530k2P9/OLz22sfyX6qXUB8Qa4+3Csk7WVsumhG9yj1ERp6gO2ci
 yf08UmTkN4qdlih5DRkunphAl9SOzg0J5n+36+5xEzqgJMDsimnbkg/N0rqC/0RMA8Y2tzjcGtW
 AlxSyvOq5sUNUhkw=
X-Received: by 2002:adf:e944:: with SMTP id m4mr611462wrn.252.1594662732594;
 Mon, 13 Jul 2020 10:52:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyP7rPlRlUnk2sAaeqLgtKS1lklCmWrKjUzqz7luoyBtXeMzc3dhGDr7Bsbje1lRNpcEinWMg==
X-Received: by 2002:adf:e944:: with SMTP id m4mr611446wrn.252.1594662732390;
 Mon, 13 Jul 2020 10:52:12 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id p29sm442463wmi.43.2020.07.13.10.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 10:52:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] migration/migration.c: Remove superfluous breaks
Date: Mon, 13 Jul 2020 19:52:06 +0200
Message-Id: <20200713175206.13659-4-quintela@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200713175206.13659-1-quintela@redhat.com>
References: <20200713175206.13659-1-quintela@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


