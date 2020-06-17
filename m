Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DF2E207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 14:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3zK+G0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DF2E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlZT2-0006AE-P7
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 10:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNd-0002rW-6S
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jlZNW-0001eZ-Ne
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 10:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592405365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqJdrth38nvygdcTzodKR39xUdQaBYTwoxQvC0MCKFk=;
 b=N3zK+G0ye13ErAnxgchY6Tj1mYK6WgCTjsqB6ZlIqiWyFq+zR2zbotOFQx4bNP3W8foHrX
 MJIxqhqTM4HZQRQmR3dKk7F1eeBltvj6Gn4lFFyHXJUREMlJdQ7IavNQqmYU/PJBOcSYuL
 VIGkvCqbfZHHLHQvEujy3mLwfM1IjlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-NmsVLae4NsC2FElFn0PKQg-1; Wed, 17 Jun 2020 10:49:21 -0400
X-MC-Unique: NmsVLae4NsC2FElFn0PKQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 125BC835BB8;
 Wed, 17 Jun 2020 14:49:20 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-44.ams2.redhat.com [10.36.114.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13BEF7CAA0;
 Wed, 17 Jun 2020 14:49:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/43] block: Refactor subdirectory recursion during make
Date: Wed, 17 Jun 2020 16:48:31 +0200
Message-Id: <20200617144909.192176-6-kwolf@redhat.com>
In-Reply-To: <20200617144909.192176-1-kwolf@redhat.com>
References: <20200617144909.192176-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

Rather than listing block/monitor from the top-level Makefile.objs, we
should instead list monitor from block/Makefile.objs.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Fixes: bb4e58c613
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200608173339.3244211-1-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 Makefile.objs       | 2 +-
 block/Makefile.objs | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index c09d95dfe3..7ce2588b89 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -13,7 +13,7 @@ chardev-obj-y = chardev/
 
 authz-obj-y = authz/
 
-block-obj-y = block/ block/monitor/ nbd/ scsi/
+block-obj-y = block/ nbd/ scsi/
 block-obj-y += block.o blockjob.o job.o
 block-obj-y += qemu-io-cmds.o
 block-obj-$(CONFIG_REPLICATION) += replication.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3635b6b4c1..96028eedce 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -46,6 +46,7 @@ block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
 common-obj-y += monitor/
+block-obj-y += monitor/
 
 block-obj-y += stream.o
 
-- 
2.25.4


