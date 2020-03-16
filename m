Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2951C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84D5D20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJdP4CWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D5D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxVD-0005hv-MQ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHL-00039u-M1
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHK-0003A7-GG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:57031)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHK-00034y-AA
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Wh4wBQ+NBmUGn+TfvnBC6WQkHU0SPyP+0/CoeP1DtI=;
 b=bJdP4CWor3JL44KAII+lE4OvIsFXPQs1acUDPHDmZOtkmwwkrBjIjajQCxDO7EUYeLT1S+
 fGLLD5R7gbKIQAc9UwRkTWk+/IAo6N2f08klnkWyFIqWmlB9J8350u/ncvrytrFgXIEulk
 XDvXZUB6IH5xhE3AG81nOOPWdDmIHgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-_5Xx59m6PaSG5oQUtEks-Q-1; Mon, 16 Mar 2020 17:28:03 -0400
X-MC-Unique: _5Xx59m6PaSG5oQUtEks-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8283149C0;
 Mon, 16 Mar 2020 21:28:01 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E69119C4F;
 Mon, 16 Mar 2020 21:28:00 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/61] memory: Fix start offset for bitmap log_clear hook
Date: Mon, 16 Mar 2020 22:26:43 +0100
Message-Id: <1584394048-44994-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Matt Borgerson <contact@mborgerson.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Matt Borgerson <contact@mborgerson.com>

Currently only the final page offset is being passed to the `log_clear`
hook via `memory_region_clear_dirty_bitmap` after it is used as an
iterator in `cpu_physical_memory_test_and_clear_dirty`. This patch
corrects the start address and size of the region.

Signed-off-by: Matt Borgerson <contact@mborgerson.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index 0cc500d..de9d949 100644
--- a/exec.c
+++ b/exec.c
@@ -1315,7 +1315,7 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_add=
r_t start,
                                               unsigned client)
 {
     DirtyMemoryBlocks *blocks;
-    unsigned long end, page;
+    unsigned long end, page, start_page;
     bool dirty =3D false;
     RAMBlock *ramblock;
     uint64_t mr_offset, mr_size;
@@ -1325,7 +1325,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_add=
r_t start,
     }
=20
     end =3D TARGET_PAGE_ALIGN(start + length) >> TARGET_PAGE_BITS;
-    page =3D start >> TARGET_PAGE_BITS;
+    start_page =3D start >> TARGET_PAGE_BITS;
+    page =3D start_page;
=20
     WITH_RCU_READ_LOCK_GUARD() {
         blocks =3D atomic_rcu_read(&ram_list.dirty_memory[client]);
@@ -1345,8 +1346,8 @@ bool cpu_physical_memory_test_and_clear_dirty(ram_add=
r_t start,
             page +=3D num;
         }
=20
-        mr_offset =3D (ram_addr_t)(page << TARGET_PAGE_BITS) - ramblock->o=
ffset;
-        mr_size =3D (end - page) << TARGET_PAGE_BITS;
+        mr_offset =3D (ram_addr_t)(start_page << TARGET_PAGE_BITS) - rambl=
ock->offset;
+        mr_size =3D (end - start_page) << TARGET_PAGE_BITS;
         memory_region_clear_dirty_bitmap(ramblock->mr, mr_offset, mr_size)=
;
     }
=20
--=20
1.8.3.1



