Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76BEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750432084C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1iv3ZIe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750432084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdciT-0001Rj-Hz
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcf5-00056I-QY
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcf3-00033K-LM
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIjBlyXJ7X2S4+j+wnaT22TXvDB3n856fH07taNl2bM=;
 b=e1iv3ZIe87kake/2mju0NGe+gBdz88SpWdVmDlAVmQGPi2aDehbjOqKh4p2pKJFQrWL/8R
 VKBcUB+yJKr4nNgDeAbPmHdQqSkcyaLe6PYu0l5uR4omulRQZoFWlTQA78+QyWhdwljv4p
 i9Dh1a+4Icp8nbVSRjDftHliuB8wHG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-UP9TZw8yOR-X9kQMlX2XVw-1; Tue, 26 May 2020 12:42:36 -0400
X-MC-Unique: UP9TZw8yOR-X9kQMlX2XVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F9118FE860;
 Tue, 26 May 2020 16:42:35 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1C56E50D;
 Tue, 26 May 2020 16:42:31 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/11] iotests: Fix test 178
Date: Tue, 26 May 2020 11:42:07 -0500
Message-Id: <20200526164211.1569366-8-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A recent change to qemu-img changed expected error message output, but
178 takes long enough to execute that it does not get run by 'make
check' or './check -g quick'.

Fixes: 43d589b074
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200521192137.1120211-2-eblake@redhat.com>
---
 tests/qemu-iotests/178.out.qcow2 | 2 +-
 tests/qemu-iotests/178.out.raw   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index f59bf4b2fbc4..4b69524c80ee 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -13,7 +13,7 @@ qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo'
 qemu-img: --output must be used with human or json as argument.
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
 qemu-img: Unknown file format 'foo'

 == Size calculation for a new file (human) ==
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
index 404ca908d8c2..20e17da115cb 100644
--- a/tests/qemu-iotests/178.out.raw
+++ b/tests/qemu-iotests/178.out.raw
@@ -13,7 +13,7 @@ qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo'
 qemu-img: --output must be used with human or json as argument.
-qemu-img: Image size must be less than 8 EiB!
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
 qemu-img: Unknown file format 'foo'

 == Size calculation for a new file (human) ==
-- 
2.26.2


