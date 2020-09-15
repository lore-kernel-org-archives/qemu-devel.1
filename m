Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA11C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:56:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DDF206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 10:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g1XM8lMA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DDF206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI8cz-0005YH-3c
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 06:56:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UG-0000Z6-E3
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kI8UE-0004a6-BI
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 06:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600166817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qzOm2DmuuR/9Ie19niGExs/IYglc8i+tCED3cG83MII=;
 b=g1XM8lMAXqSjCK863l1wKEjOWacqFvKZ2uy/rtHFpVJRbdtYZGATaYbDPGYaIDY5btjLFZ
 moIpleYjQ3IZ6+tmHISpF77OQj/sHtjqsiMp0YXf5VpWJofKx4GwReufIODY6HVaYgAbtd
 suUHx12mlmgEW5IUgeNjRPRVqu4QAW4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-cWEZkKQUM2Cx1fclbO2U5Q-1; Tue, 15 Sep 2020 06:46:55 -0400
X-MC-Unique: cWEZkKQUM2Cx1fclbO2U5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E9521084D64;
 Tue, 15 Sep 2020 10:46:54 +0000 (UTC)
Received: from localhost (ovpn-113-7.ams2.redhat.com [10.36.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0215619C4F;
 Tue, 15 Sep 2020 10:46:53 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 11/22] qcow2: Rewrite the documentation of
 qcow2_alloc_cluster_offset()
Date: Tue, 15 Sep 2020 12:46:16 +0200
Message-Id: <20200915104627.699552-12-mreitz@redhat.com>
In-Reply-To: <20200915104627.699552-1-mreitz@redhat.com>
References: <20200915104627.699552-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alberto Garcia <berto@igalia.com>

The current text corresponds to an earlier, simpler version of this
function and it does not explain how it works now.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <bb5bd06f07c5a05b0818611de0d06ec5b66c8df3.1599150873.git.berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-cluster.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f65ccc5840..ce1260e746 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1714,18 +1714,22 @@ out:
 }
 
 /*
- * alloc_cluster_offset
+ * For a given area on the virtual disk defined by @offset and @bytes,
+ * find the corresponding area on the qcow2 image, allocating new
+ * clusters (or subclusters) if necessary. The result can span a
+ * combination of allocated and previously unallocated clusters.
  *
- * For a given offset on the virtual disk, find the cluster offset in qcow2
- * file. If the offset is not found, allocate a new cluster.
+ * On return, @host_offset is set to the beginning of the requested
+ * area. This area is guaranteed to be contiguous on the qcow2 file
+ * but it can be smaller than initially requested. In this case @bytes
+ * is updated with the actual size.
  *
- * If the cluster was already allocated, m->nb_clusters is set to 0 and
- * other fields in m are meaningless.
- *
- * If the cluster is newly allocated, m->nb_clusters is set to the number of
- * contiguous clusters that have been allocated. In this case, the other
- * fields of m are valid and contain information about the first allocated
- * cluster.
+ * If any clusters or subclusters were allocated then @m contains a
+ * list with the information of all the affected regions. Note that
+ * this can happen regardless of whether this function succeeds or
+ * not. The caller is responsible for updating the L2 metadata of the
+ * allocated clusters (on success) or freeing them (on failure), and
+ * for clearing the contents of @m afterwards in both cases.
  *
  * If the request conflicts with another write request in flight, the coroutine
  * is queued and will be reentered when the dependency has completed.
-- 
2.26.2


