Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB50C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4AB42064C
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVRbG2nR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4AB42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLg8-0003fP-U9
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51312)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiLeg-00030d-94
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:33:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jiLef-0008BV-MJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591637628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OAXxpmJgVc0Vy2zGXMgTtnJmdtAPv0HOdTtMtKvBz6o=;
 b=CVRbG2nRy5A8pgGRS312n6Vw2TQ0e7U0GuICUPkuHxTm75DQM6WY+yYoWy/R+E+tyC32KC
 YXvVTbQTS9Sn6RH9TaImjZhjPQ9cRzot0XRXuKvFi9rGyzBngN5V/93TL1DVke2FwZ60+e
 AiMdY01ajmU4AdRabY0FBe+PvqrW5Bk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-0O8ZXoneOM-KhrlPg-r6EA-1; Mon, 08 Jun 2020 13:33:44 -0400
X-MC-Unique: 0O8ZXoneOM-KhrlPg-r6EA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86AF1009600;
 Mon,  8 Jun 2020 17:33:43 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C20C1A835;
 Mon,  8 Jun 2020 17:33:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] block: Refactor subdirectory recursion during make
Date: Mon,  8 Jun 2020 12:33:39 -0500
Message-Id: <20200608173339.3244211-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rather than listing block/monitor from the top-level Makefile.objs, we
should instead list monitor from block/Makefile.objs.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Fixes: bb4e58c613
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Makefile.objs       | 2 +-
 block/Makefile.objs | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.objs b/Makefile.objs
index 99774cfd2545..0c08eb863a14 100644
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
index 87357529f339..5947da08575f 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -47,6 +47,7 @@ block-obj-y += aio_task.o
 block-obj-y += backup-top.o
 block-obj-y += filter-compress.o
 common-obj-y += monitor/
+block-obj-y += monitor/

 block-obj-y += stream.o

-- 
2.27.0


