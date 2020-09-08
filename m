Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C10C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C531B20759
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZkFXYxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C531B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFkHF-0005rn-PF
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkGA-0004DJ-M3
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kFkG7-0007uQ-VK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599597029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dj8PFivSAcJNd/FlfrotVGRkKpULTf3HJuqDkHyOKcI=;
 b=JZkFXYxU74o/+fNAaQEpTKePd3L625hk8wTCKD0CW74JN2GufuXccizgb2CSKMgnNkKdJ+
 JXrY/IkUTWbwA/H/nsn8wEYGmnLFmT9wX43pctVaZ52LiG9VghNayWLnkNP7tVYNglRr6k
 M+lTpmOX8YdF9VPsqzeXGPlCZzz0MlI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-htux_8cAMgO8vaMV3kPvkw-1; Tue, 08 Sep 2020 16:30:27 -0400
X-MC-Unique: htux_8cAMgO8vaMV3kPvkw-1
Received: by mail-qt1-f199.google.com with SMTP id t11so347065qtn.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 13:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Dj8PFivSAcJNd/FlfrotVGRkKpULTf3HJuqDkHyOKcI=;
 b=WKG8HH+3M8jCHYeHnyRYXSdV3MaENA7p8YEEAJZQnof21Ix4aDUqY/yfukgimP1Xye
 YipncfVeFCbfbNNdIMjm8w2xIJzJf26c0/dGEyvk4L8j9Ik5G1gJGqdHLF2iKsQZi+74
 Lt3SCgDZmSMt+A4PwhcMMF32v7tgSyb3/1NNEA81HjUYHsnMlnhKwlE5naQ64Gqlw6KC
 X5DpfSTOvSUuGHzl+sAwSWp99OCBnb1mIhAYtPZy2hkLSyjDmVpMxNuD6CugYNDEe0+v
 QYL2G2Ef7xZUFsV3FG5MXNu3MvBr5KGMaA9HTTLDssNwiw9CrzVr04GVGiDcUTrGipie
 QxPw==
X-Gm-Message-State: AOAM5318hH/GeuLjJGgjdUIzQe2MzuYGBgAmK/wkTX3otwezuCZ709hm
 2KvY+4PiogZiOEvUHHQ0qy6rPU32Psy54kxsbfT7enZajbjOZVBNLlRQkiLKwenna3mz9C3wv+6
 ccOoVmhnULayv4i8=
X-Received: by 2002:a37:a392:: with SMTP id m140mr331073qke.195.1599597026806; 
 Tue, 08 Sep 2020 13:30:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKZqNGoI2qPVsxlQ52PMAe3LlObIL1VytGC6hZhmsjYNWZh1Ab2xnTyyqn+bHm0i+mZUMu0A==
X-Received: by 2002:a37:a392:: with SMTP id m140mr331048qke.195.1599597026507; 
 Tue, 08 Sep 2020 13:30:26 -0700 (PDT)
Received: from xz-x1.redhat.com
 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id o28sm595397qtl.62.2020.09.08.13.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:30:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/6] migration: Properly destroy variables on incoming side
Date: Tue,  8 Sep 2020 16:30:17 -0400
Message-Id: <20200908203022.341615-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908203022.341615-1-peterx@redhat.com>
References: <20200908203022.341615-1-peterx@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 12:54:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Xiaohui Li <xiaohli@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In migration_incoming_state_destroy(), we've got a few variables that aren't
destroyed properly, namely:

    main_thread_load_event
    postcopy_pause_sem_dst
    postcopy_pause_sem_fault
    rp_mutex

Destroy them properly.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 58a5452471..749d9b145b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -238,12 +238,15 @@ void migration_incoming_state_destroy(void)
         mis->postcopy_remote_fds = NULL;
     }
 
-    qemu_event_reset(&mis->main_thread_load_event);
-
     if (mis->socket_address_list) {
         qapi_free_SocketAddressList(mis->socket_address_list);
         mis->socket_address_list = NULL;
     }
+
+    qemu_event_destroy(&mis->main_thread_load_event);
+    qemu_sem_destroy(&mis->postcopy_pause_sem_dst);
+    qemu_sem_destroy(&mis->postcopy_pause_sem_fault);
+    qemu_mutex_destroy(&mis->rp_mutex);
 }
 
 static void migrate_generate_event(int new_state)
-- 
2.26.2


