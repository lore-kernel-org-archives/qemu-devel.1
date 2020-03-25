Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC494C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31220772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 09:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PHGj4rYr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2dn-000180-Oj
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 05:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jH2aR-0005Xy-Og
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jH2aQ-0005KW-Mc
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jH2aQ-0005Js-JK
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 05:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585129474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiFZDJTFclqzjCTSx+nVDwgRLTlGoJoYljIc1b69wDQ=;
 b=PHGj4rYrbI0WPy63trY70+L7eHrIKQfPKXK2c7PZkXvnBACTJFbt9GfDl5D6rp42deKGOo
 rpyXkBQF2HdlzVLVIciwlncL62X7Z/vHwiJv0U8kNlkDQoG0ftqDdtg99n+hydVWO/RTNS
 q7KNi1q02cPdvleRoZhuUt4udl5MOTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-TozugXaMP1qgjiZZCLzYxw-1; Wed, 25 Mar 2020 05:44:32 -0400
X-MC-Unique: TozugXaMP1qgjiZZCLzYxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F236DB60
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 09:44:31 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 336568D576;
 Wed, 25 Mar 2020 09:44:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.0 1/2] hostmem: set default prealloc_threads to valid
 value
Date: Wed, 25 Mar 2020 05:44:22 -0400
Message-Id: <20200325094423.24293-2-imammedo@redhat.com>
In-Reply-To: <20200325094423.24293-1-imammedo@redhat.com>
References: <20200325094423.24293-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 4ebc74dbbf removed default prealloc_threads initialization
by mistake, and that makes QEMU crash with division on zero at
  numpages_per_thread =3D numpages / memset_num_threads;
when QEMU is started with following backend
  -object memory-backend-ram,id=3Dram-node0,prealloc=3Dyes,size=3D128M

Return back initialization removed by 4ebc74dbbf to fix issue.

Fixes: 4ebc74dbbf7ad50e4101629f3f5da5fdc1544051
Reported-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
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
2.18.1


