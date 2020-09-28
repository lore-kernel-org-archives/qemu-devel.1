Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A241CC4741F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB25208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0hiuJET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB25208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMuzZ-0002Qw-6m
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 11:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kMuxD-0000hJ-8h
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:20:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kMuxB-0004fJ-Do
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:20:38 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601306436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgsbJZNGtZLPwqf4hJl7ETIoycZUo6lm4VegHe5Wlk8=;
 b=C0hiuJET5xmYHH8fnYhvq8oWlt6ShruIe8aM/oZTU816ubqb97TM0avoFV8AxYmkn5vNIh
 yTmcASo/3mwX4yHlNnOORofixSYHPmWz4Rs0F0Ct84XH/k3mDvSSiu/jJlsVSzkOephQUC
 GX4ADfQWVG6XrnHVEXsmcPMtZsyxk/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-qqkVrcg-MASXDO1p8IFaiA-1; Mon, 28 Sep 2020 11:20:31 -0400
X-MC-Unique: qqkVrcg-MASXDO1p8IFaiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5CE6ADC01
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 15:20:30 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-190.ams2.redhat.com
 [10.36.114.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB60B614F5;
 Mon, 28 Sep 2020 15:20:29 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	peterx@redhat.com
Subject: [PULL 1/1] Revert "migration: Properly destroy variables on incoming
 side"
Date: Mon, 28 Sep 2020 16:20:24 +0100
Message-Id: <20200928152024.209894-2-dgilbert@redhat.com>
In-Reply-To: <20200928152024.209894-1-dgilbert@redhat.com>
References: <20200928152024.209894-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This reverts commit c02039a6f3730ddcf683a0ba9a175688c6db71a0.

This is breaking test 068 that does a loadvm twice.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 838ca79f57..aca7fdcd0b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -238,15 +238,12 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_remote_fds = NULL;
     }
 
+    qemu_event_reset(&mis->main_thread_load_event);
+
     if (mis->socket_address_list) {
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list = NULL;
     }
-
-    qemu_event_destroy(&mis->main_thread_load_event);
-    qemu_sem_destroy(&mis->postcopy_pause_sem_dst);
-    qemu_sem_destroy(&mis->postcopy_pause_sem_fault);
-    qemu_mutex_destroy(&mis->rp_mutex);
 }
 
 static void migrate_generate_event(int new_state)
-- 
2.26.2


