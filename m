Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09407C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2786A21D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sq1vfTOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2786A21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmWf-0003Sw-Rp
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVS-0002B3-8X
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmVO-0004Cd-5a
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:07:17 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ikZ5UtE3+vjTJczLSWLwfVuGSIdVlZO2PJ0ByXz+1L8=;
 b=Sq1vfTOpcs7vELZLNm4IHog+k3g44CZJBvMJ2/mTukgrj+UJa74fjVRXw9JSzaO1i9Idxl
 oFMHUjz6Myv3wZxjQaurBKkKEIPCahfxgB0TPCGSmKg3SMY99aJ3UBvf4MlncrciEC70zL
 vkJIaqsil9MV8RhMbYRDfAjoSquMmlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-KF4qLxXBPGCAgDrw4VwhmA-1; Fri, 25 Sep 2020 08:07:09 -0400
X-MC-Unique: KF4qLxXBPGCAgDrw4VwhmA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D759410066FC;
 Fri, 25 Sep 2020 12:07:07 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F92673692;
 Fri, 25 Sep 2020 12:07:05 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 01/26] migration: Properly destroy variables on incoming side
Date: Fri, 25 Sep 2020 13:06:30 +0100
Message-Id: <20200925120655.295142-2-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
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

From: Peter Xu <peterx@redhat.com>

In migration_incoming_state_destroy(), we've got a few variables that aren't
destroyed properly, namely:

    main_thread_load_event
    postcopy_pause_sem_dst
    postcopy_pause_sem_fault
    rp_mutex

Destroy them properly.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200908203022.341615-2-peterx@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d9d1e0b190..3495c9e542 100644
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


