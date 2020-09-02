Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41CC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:56:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651A320758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bf6FJOkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651A320758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDakL-0003f2-Iq
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDahq-0007vR-WF
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kDaho-0002as-0I
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599083648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IOvHRzBDlGh16AJzQZ7ZZ3jriOEZlCNFhKTqMi1Gfbc=;
 b=Bf6FJOkdj/4SDXzpDdqXfzMk1CdoxqJAAaqEkeh34lg5rqWI8yZWRd9/Usloj29zaF0mFu
 9NUNqpbTN6dSqsv9KsGMcF1CEHVvTn5E2J6R/ZJO0saqojezbm6roZnjJQmuMgpY03eNre
 vpVYSJ28lyBl+K/ucANs3WaBJIe1/Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-NEoNEDqYNTCE8QqKPHO-yw-1; Wed, 02 Sep 2020 17:54:04 -0400
X-MC-Unique: NEoNEDqYNTCE8QqKPHO-yw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59C52802B63;
 Wed,  2 Sep 2020 21:54:03 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-128.phx2.redhat.com [10.3.113.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3E5B76E01;
 Wed,  2 Sep 2020 21:54:02 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/6] iotests/259: Fix reference output
Date: Wed,  2 Sep 2020 16:53:56 -0500
Message-Id: <20200902215400.2673028-3-eblake@redhat.com>
In-Reply-To: <20200902215400.2673028-1-eblake@redhat.com>
References: <20200902215400.2673028-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

The error message has changed recently, breaking the test.  Fix it.

Fixes: a2b333c01880f56056d50c238834d62e32001e54
       ("block: nbd: Fix convert qcow2 compressed to nbd")
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200811080830.289136-1-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/259.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/259.out b/tests/qemu-iotests/259.out
index e27b9ff38d75..1aaadfda4ead 100644
--- a/tests/qemu-iotests/259.out
+++ b/tests/qemu-iotests/259.out
@@ -10,5 +10,5 @@ disk size: unavailable

 --- Testing creation for which the node would need to grow ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=qcow2 size=67108864 preallocation=metadata
-qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Image format driver does not support resize
+qemu-img: TEST_DIR/t.IMGFMT: Could not resize image: Cannot grow NBD nodes
 *** done
-- 
2.28.0


