Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F30C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC7C207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asaWiwMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC7C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jltSn-0002lN-65
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 08:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jltRI-0001fY-Ic
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:14:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40717
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1jltRG-0001OC-GO
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 08:14:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592482477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BqgcYS0MIdVPDVQzytea64k+zZrG7Asl8VfW0xFTbeY=;
 b=asaWiwMg/ScHbfq2/C/ucx2VR5puPmo9LPY5Vy5EL5fIWFWqdzj0HPl3ry7v1oEoprVf/U
 9r4bpPovgitmrv6agTXa5kc3FOkuYFTauLVYnUot4oxuZpEkIq06dIuiK5q+qG3Y3dHAHP
 aD0+7i18NEDV4lfqLK7gopCV0isQqFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-399xKMsnM-6lXPxjLvWHGA-1; Thu, 18 Jun 2020 08:14:33 -0400
X-MC-Unique: 399xKMsnM-6lXPxjLvWHGA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EDE51054FA4;
 Thu, 18 Jun 2020 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-52.phx2.redhat.com
 [10.3.112.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB04F60BF3;
 Thu, 18 Jun 2020 12:14:24 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1] memory: assert MemoryRegionOps callbacks are defined
Date: Thu, 18 Jun 2020 17:42:18 +0530
Message-Id: <20200618121218.215808-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ppandit@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When registering a MemoryRegionOps object, assert that its
read/write callback methods are defined. This avoids potential
guest crash via a NULL pointer dereference.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 memory.c | 5 +++++
 1 file changed, 5 insertions(+)

Update v1: add assert while registering MemoryRegionOps
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05187.html

diff --git a/memory.c b/memory.c
index 91ceaf9fcf..6e94fd5958 100644
--- a/memory.c
+++ b/memory.c
@@ -1495,6 +1495,9 @@ void memory_region_init_io(MemoryRegion *mr,
                            const char *name,
                            uint64_t size)
 {
+    assert(ops);
+    assert(ops->read);
+    assert(ops->write);
     memory_region_init(mr, owner, name, size);
     mr->ops = ops ? ops : &unassigned_mem_ops;
     mr->opaque = opaque;
@@ -1674,6 +1677,8 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
 {
     Error *err = NULL;
     assert(ops);
+    assert(ops->read);
+    assert(ops->write);
     memory_region_init(mr, owner, name, size);
     mr->ops = ops;
     mr->opaque = opaque;
-- 
2.26.2


