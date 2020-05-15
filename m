Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3640C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:00:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 773802074D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GJPKRaqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 773802074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZx4-0004pW-AO
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZip-0002Xd-Vz
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44964
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZin-00029V-5H
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhnJGFzeKaIi/ojLCCBmmi5M+k7UnDjT4Eviqdn7LQE=;
 b=GJPKRaqphQ8rg1w5pJ/R7SMV1g910f7dSyahgJRM/uV3APJcPhyOj6Ns0ReUOCnosduE8D
 XbQnQqjTCTGH85exExILOen0pIHAMy6YtGIvyCIHSo08EvQg6aeJyBZLK+N41wWhnj9/VS
 WF6IHBoNreY7Jvtz0Gs0bLRlYYO7GTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-xAZZdpBGOsSg9_eGUYCcug-1; Fri, 15 May 2020 08:45:46 -0400
X-MC-Unique: xAZZdpBGOsSg9_eGUYCcug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 419C3107ACF2;
 Fri, 15 May 2020 12:45:45 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1752E024;
 Fri, 15 May 2020 12:45:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 12/51] block: Use bdrv_make_empty() where possible
Date: Fri, 15 May 2020 14:44:42 +0200
Message-Id: <20200515124521.335403-13-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200429141126.85159-3-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/replication.c | 3 +--
 block/vvfat.c       | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index eb480a8e08..9a9f36e524 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -331,9 +331,8 @@ static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
         return;
     }
 
-    ret = s->active_disk->bs->drv->bdrv_make_empty(s->active_disk->bs);
+    ret = bdrv_make_empty(s->active_disk, errp);
     if (ret < 0) {
-        error_setg(errp, "Cannot make active disk empty");
         return;
     }
 
diff --git a/block/vvfat.c b/block/vvfat.c
index 6d5c090dec..34c121c07a 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -2960,9 +2960,7 @@ static int do_commit(BDRVVVFATState* s)
         return ret;
     }
 
-    if (s->qcow->bs->drv && s->qcow->bs->drv->bdrv_make_empty) {
-        s->qcow->bs->drv->bdrv_make_empty(s->qcow->bs);
-    }
+    bdrv_make_empty(s->qcow, NULL);
 
     memset(s->used_clusters, 0, sector2cluster(s, s->sector_count));
 
-- 
2.25.4


