Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D60AC43457
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11F5208D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 11:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kvp7zIbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11F5208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRwJr-0004mO-M8
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 07:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRwG8-0000dv-8F
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:44:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kRwG3-0008BI-P6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 07:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602503089;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04mH/EQN2FMbm79HfXdBhiaZTkRTdOPvt3HTGNa6fxc=;
 b=Kvp7zIbPOvrXELVgA2OQ1jWIODkAZ55mNAbg+rKw80ynhZ5Bmw0oEN3x54tJVJ2FfoEEU1
 Qe+mHuJhdLT0yPluywSexmM7DkfZAlUrkBPlXIwtfJj1AJgtTEIldDBi2E9P0jIOeDzQzJ
 1HyHezSqn+E8bOHih7Jw911sfP4dLp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-2j4df_44OH-hXeQLj3vaQg-1; Mon, 12 Oct 2020 07:44:47 -0400
X-MC-Unique: 2j4df_44OH-hXeQLj3vaQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01B6A18A8227;
 Mon, 12 Oct 2020 11:44:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-113-244.ams2.redhat.com
 [10.36.113.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9990C19C78;
 Mon, 12 Oct 2020 11:44:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, zhengchuan@huawei.com,
 stefanha@redhat.com, peterx@redhat.com
Subject: [PULL 6/6] migration/dirtyrate: present dirty rate only when querying
 the rate has completed
Date: Mon, 12 Oct 2020 12:44:25 +0100
Message-Id: <20201012114425.104765-7-dgilbert@redhat.com>
In-Reply-To: <20201012114425.104765-1-dgilbert@redhat.com>
References: <20201012114425.104765-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 02:58:41
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chuan Zheng <zhengchuan@huawei.com>

Make dirty_rate field optional, present dirty rate only when querying
the rate has completed.
The qmp results is shown as follow:
@unstarted:
{"return":{"status":"unstarted","start-time":0,"calc-time":0},"id":"libvirt-12"}
@measuring:
{"return":{"status":"measuring","start-time":102931,"calc-time":1},"id":"libvirt-85"}
@measured:
{"return":{"status":"measured","dirty-rate":4,"start-time":150146,"calc-time":1},"id":"libvirt-15"}

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Message-Id: <1601350938-128320-3-git-send-email-zhengchuan@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/dirtyrate.c | 3 +--
 qapi/migration.json   | 8 +++-----
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 40e41e793e..ab9e1301f6 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -69,9 +69,8 @@ static struct DirtyRateInfo *query_dirty_rate_info(void)
     struct DirtyRateInfo *info = g_malloc0(sizeof(DirtyRateInfo));
 
     if (qatomic_read(&CalculatingState) == DIRTY_RATE_STATUS_MEASURED) {
+        info->has_dirty_rate = true;
         info->dirty_rate = dirty_rate;
-    } else {
-        info->dirty_rate = -1;
     }
 
     info->status = CalculatingState;
diff --git a/qapi/migration.json b/qapi/migration.json
index 7f5e6fd681..974021a5c8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1743,10 +1743,8 @@
 #
 # Information about current dirty page rate of vm.
 #
-# @dirty-rate: @dirtyrate describing the dirty page rate of vm
-#              in units of MB/s.
-#              If this field returns '-1', it means querying has not
-#              yet started or completed.
+# @dirty-rate: an estimate of the dirty page rate of the VM in units of
+#              MB/s, present only when estimating the rate has completed.
 #
 # @status: status containing dirtyrate query status includes
 #          'unstarted' or 'measuring' or 'measured'
@@ -1759,7 +1757,7 @@
 #
 ##
 { 'struct': 'DirtyRateInfo',
-  'data': {'dirty-rate': 'int64',
+  'data': {'*dirty-rate': 'int64',
            'status': 'DirtyRateStatus',
            'start-time': 'int64',
            'calc-time': 'int64'} }
-- 
2.28.0


