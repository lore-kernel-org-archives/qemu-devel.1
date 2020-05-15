Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E89C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE85520758
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXMI/cQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE85520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZn4-0001uT-Kp
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZif-0002F9-8X
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35204
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZie-00026r-AI
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fyi3nukATwLELbAJliwdhiY94zBfnD+xlptums6tQDk=;
 b=UXMI/cQxgKKpBNTB7l7uNfxJSI7F1oUsJvLocwBq1E/CFgpk92FNqPhFx5Jp71TPA0kyF9
 Yux8y8EapKFQv+A41lNzU2aO5xyuyg/E0QTFI/B0dub3FPKqg4B1UTQ3dzhcQoPTwcJyoa
 KP9lR49Q6rtbZ3hYR+8WcwDRqYyVfvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-Pz34IHz2Od6nLof-l0qzpQ-1; Fri, 15 May 2020 08:45:37 -0400
X-MC-Unique: Pz34IHz2Od6nLof-l0qzpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 533C319200C2;
 Fri, 15 May 2020 12:45:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A79E2E024;
 Fri, 15 May 2020 12:45:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/51] block/replication.c: Avoid cancelling the job twice
Date: Fri, 15 May 2020 14:44:35 +0200
Message-Id: <20200515124521.335403-6-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Lukas Straub <lukasstraub2@web.de>

If qemu in colo secondary mode is stopped, it crashes because
s->backup_job is canceled twice: First with job_cancel_sync_all()
in qemu_cleanup() and then in replication_stop().

Fix this by assigning NULL to s->backup_job when the job completes
so replication_stop() and replication_do_checkpoint() won't touch
the job.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Message-Id: <20200511090801.7ed5d8f3@luklap>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/replication.c b/block/replication.c
index 971f0fe266..c03980a192 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -398,6 +398,8 @@ static void backup_job_cleanup(BlockDriverState *bs)
     BDRVReplicationState *s = bs->opaque;
     BlockDriverState *top_bs;
 
+    s->backup_job = NULL;
+
     top_bs = bdrv_lookup_bs(s->top_id, s->top_id, NULL);
     if (!top_bs) {
         return;
-- 
2.25.4


