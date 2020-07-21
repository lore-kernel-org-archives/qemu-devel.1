Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7005EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:52:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C15B20792
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 11:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHIObmrI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C15B20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxqoi-0000nV-Hj
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 07:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxqm7-0005Un-3j
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:49:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxqm4-00064V-5V
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 07:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595332171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LO2o6iouqBBqtiAy+J1nbi0a6TP3rCZ4xkeB4F6aIr0=;
 b=cHIObmrI//RpRqDvtaLcusfCrj27e29ghc87lGhlA/+96MPzYdodu4M7xk5hs6zmQQ8L2Q
 8rYIFFupcDtOzp/CAAKjnFqpKcRsH0SXTI1jyola3FcIhpgW6EMpH1QzlwvtiucCp/Dqr3
 T44ybBI7m932Y7Xn25/wGYLddjnQP/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-2Co-EZb5OdiCTmbyd-PKxQ-1; Tue, 21 Jul 2020 07:49:29 -0400
X-MC-Unique: 2Co-EZb5OdiCTmbyd-PKxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E0D4100AA44;
 Tue, 21 Jul 2020 11:49:28 +0000 (UTC)
Received: from localhost (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B71C1872E6;
 Tue, 21 Jul 2020 11:49:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/3] block/crypto: disallow write sharing by default
Date: Tue, 21 Jul 2020 13:49:18 +0200
Message-Id: <20200721114920.1174149-2-mreitz@redhat.com>
In-Reply-To: <20200721114920.1174149-1-mreitz@redhat.com>
References: <20200721114920.1174149-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Maxim Levitsky <mlevitsk@redhat.com>

My commit 'block/crypto: implement the encryption key management'
accidently allowed raw luks images to be shared between different
qemu processes without share-rw=on explicit override.
Fix that.

Fixes: bbfdae91fb ("block/crypto: implement the encryption key management")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1857490

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Message-Id: <20200719122059.59843-2-mlevitsk@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index 8725c1bc02..0807557763 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -881,7 +881,7 @@ block_crypto_child_perms(BlockDriverState *bs, BdrvChild *c,
      * For backward compatibility, manually share the write
      * and resize permission
      */
-    *nshared |= (BLK_PERM_WRITE | BLK_PERM_RESIZE);
+    *nshared |= shared & (BLK_PERM_WRITE | BLK_PERM_RESIZE);
     /*
      * Since we are not fully a format driver, don't always request
      * the read/resize permission but only when explicitly
-- 
2.26.2


