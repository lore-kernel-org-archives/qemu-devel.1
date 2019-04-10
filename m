Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B655C10F0E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D21F20857
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 01:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D21F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51531 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE1n8-0005Pq-FL
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 21:12:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0v7-0003h2-07
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghook@redhat.com>) id 1hE0v5-0001m4-U6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:16:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ghook@redhat.com>) id 1hE0v5-0001kf-Lw
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 20:16:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0763D3DFCD
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 00:08:09 +0000 (UTC)
Received: from rhel74-ghook-amd.khw1.lab.eng.bos.redhat.com
	(rhel74-ghook-amd.khw1.lab.eng.bos.redhat.com [10.16.200.139])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF326146F;
	Wed, 10 Apr 2019 00:08:08 +0000 (UTC)
From: Gary R Hook <ghook@redhat.com>
To: rhvirt-patches@redhat.com
Date: Tue,  9 Apr 2019 20:08:02 -0400
Message-Id: <20190410000803.1744-2-ghook@redhat.com>
In-Reply-To: <20190410000803.1744-1-ghook@redhat.com>
References: <20190410000803.1744-1-ghook@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 10 Apr 2019 00:08:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Mailman-Approved-At: Tue, 09 Apr 2019 21:10:01 -0400
Subject: [Qemu-devel] [RHEL-8.1 virt 1/2] memory: Fix the memory region type
 assignment order
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, ghook@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410000802.eFhyldKmFMNKSY_hCvBHvbxLEkQQHvK0sl2JbGZJ02E@z>

BZ: 1667249
Branch: rhel-8.1.0
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
Upstream Status: 4.0.0-rc1
Build Info: https://brewweb.engineering.redhat.com/brew/taskinfo?taskID=20980582
Conflicts: None

commit 2ddb89b00f947f785c9ca6742f28f954e3b75e62
Author: Singh, Brijesh <brijesh.singh@amd.com>
Date:   Mon Feb 4 22:23:39 2019 +0000

    memory: Fix the memory region type assignment order

    Currently, a callback registered through the RAMBlock notifier
    is not able to get the memory region type (i.e callback is not
    able to use memory_region_is_ram_device function). This is
    because mr->ram assignment happens _after_ the memory is allocated
    whereas the callback is executed during allocation.

    Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1667249
    Suggested-by: Alex Williamson <alex.williamson@redhat.com>
    Cc: Paolo Bonzini <pbonzini@redhat.com>
    Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
    Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
    Message-Id: <20190204222322.26766-2-brijesh.singh@amd.com>
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Cc: Paolo Bonzini <pbonzini@redhat.com> 
Cc: qemu-devel@nongnu.org 
---
 memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 4974f972d5..04ff5e9108 100644
--- a/memory.c
+++ b/memory.c
@@ -1631,10 +1631,17 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        uint64_t size,
                                        void *ptr)
 {
-    memory_region_init_ram_ptr(mr, owner, name, size, ptr);
+    memory_region_init(mr, owner, name, size);
+    mr->ram = true;
+    mr->terminates = true;
     mr->ram_device = true;
     mr->ops = &ram_device_mem_ops;
     mr->opaque = mr;
+    mr->destructor = memory_region_destructor_ram;
+    mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
+    /* qemu_ram_alloc_from_ptr cannot fail with ptr != NULL.  */
+    assert(ptr != NULL);
+    mr->ram_block = qemu_ram_alloc_from_ptr(size, ptr, mr, &error_fatal);
 }
 
 void memory_region_init_alias(MemoryRegion *mr,
-- 
2.18.1


