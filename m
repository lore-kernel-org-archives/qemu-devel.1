Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F73C352BE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DC621556
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qa47vX2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DC621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOkU-0004Ui-EU
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jOOb9-0003tO-O2
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jOOb8-0005Hg-NK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jOOb8-0005HU-JI
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586882382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0m/vE/JDp/YTnEV/4OiBeyYKV7QGW/+0j4jil7uRNo=;
 b=Qa47vX2hbRo72j/ucVH761ASWt5NTL4PpsH0JMxT2micUdqibmEupXhQ5Mozriv1OIEdeL
 kHE8OLITEOdo4ZRY9GtmG22sZrQdF0cXnhSm85tw1eXBnXA+Zh1RbtZC9tjXVUqM7gEqAH
 BIQ0g5wSnekE/kDn8nAZVGx/nEyQf4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Ms7C1-KBM3y5zUiJyBeR0w-1; Tue, 14 Apr 2020 12:39:40 -0400
X-MC-Unique: Ms7C1-KBM3y5zUiJyBeR0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FD0A1034B42
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 16:39:39 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 790EA60BEC;
 Tue, 14 Apr 2020 16:39:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] hostmem: set default prealloc_threads to valid value
Date: Tue, 14 Apr 2020 12:39:35 -0400
Message-Id: <20200414163937.29669-2-pbonzini@redhat.com>
In-Reply-To: <20200414163937.29669-1-pbonzini@redhat.com>
References: <20200414163937.29669-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

Commit 4ebc74dbbf removed default prealloc_threads initialization
by mistake, and that makes QEMU crash with division on zero at
  numpages_per_thread =3D numpages / memset_num_threads;
when QEMU is started with following backend
  -object memory-backend-ram,id=3Dram-node0,prealloc=3Dyes,size=3D128M

Return back initialization removed by 4ebc74dbbf to fix issue.

Fixes: 4ebc74dbbf7ad50e4101629f3f5da5fdc1544051
Reported-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Message-Id: <20200325094423.24293-2-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index a70867b255..327f9eebc3 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -280,6 +280,7 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge =3D machine_mem_merge(machine);
     backend->dump =3D machine_dump_guest_core(machine);
+    backend->prealloc_threads =3D 1;
 }
=20
 static void host_memory_backend_post_init(Object *obj)
--=20
2.18.2



