Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D28C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0F242075D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 11:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9CoLIEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0F242075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Smc-0000Rn-11
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 07:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5SiC-0002cG-Ah
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:45:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43092
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1k5SiA-0008O7-Hh
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 07:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597146297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URgG/GQpF3hxWKP3cotTkm5KWSX2MRj+zKuw0yApTls=;
 b=f9CoLIEtf+tQvtVGsF5ytGuLZOGhV1jGKjKizRsNBXjNxb4A6ze9g2XwWi7yHSJL1+tXIf
 epXKBTSlycw4cpMri1LY0+m7amgdgj7j+g0ktKMIpXPUNfjNHny1jsVzph/ghIIfZNzB9P
 JP7O2czD8/7Vsj5u3QDGYySpoc/MoNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-IDx7D9ygN06mMvLOfUanVA-1; Tue, 11 Aug 2020 07:44:54 -0400
X-MC-Unique: IDx7D9ygN06mMvLOfUanVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6005D1005510;
 Tue, 11 Aug 2020 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.74.8.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 88CCE5FC01;
 Tue, 11 Aug 2020 11:44:48 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 9/9] memory: assert MemoryRegionOps callbacks are defined
Date: Tue, 11 Aug 2020 17:11:33 +0530
Message-Id: <20200811114133.672647-10-ppandit@redhat.com>
In-Reply-To: <20200811114133.672647-1-ppandit@redhat.com>
References: <20200811114133.672647-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ppandit@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 04:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When registering a MemoryRegionOps object, assert that its
read/write callback methods are defined. This avoids potential
guest crash via a NULL pointer dereference.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 softmmu/memory.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Update v4: add Reviewed-by tag
  -> https://lists.nongnu.org/archive/html/qemu-devel/2020-07/msg05324.html

diff --git a/softmmu/memory.c b/softmmu/memory.c
index af25987518..1f4b37b3a6 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1485,7 +1485,13 @@ void memory_region_init_io(MemoryRegion *mr,
                            uint64_t size)
 {
     memory_region_init(mr, owner, name, size);
-    mr->ops = ops ? ops : &unassigned_mem_ops;
+    if (ops) {
+        assert(ops->read || ops->read_with_attrs);
+        assert(ops->write || ops->write_with_attrs);
+        mr->ops = ops;
+    } else {
+        mr->ops = &unassigned_mem_ops;
+    }
     mr->opaque = opaque;
     mr->terminates = true;
 }
@@ -1663,6 +1669,8 @@ void memory_region_init_rom_device_nomigrate(MemoryRegion *mr,
 {
     Error *err = NULL;
     assert(ops);
+    assert(ops->read || ops->read_with_attrs);
+    assert(ops->write || ops->write_with_attrs);
     memory_region_init(mr, owner, name, size);
     mr->ops = ops;
     mr->opaque = opaque;
-- 
2.26.2


