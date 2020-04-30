Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA7C4724C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:51:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98CA2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 15:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5ZHgtsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98CA2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUBSm-0004YT-SL
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 11:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43826)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUBQF-0002rk-Lf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jUBOF-0001Dd-EK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:48:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57092
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jUBOF-0001DW-22
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 11:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588261578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hHGxMV5BSZd3+T1bklarPIXa1FVU+s7H3RYB75xQUrg=;
 b=U5ZHgtsOU0E70Ky4CMLSwVrJ1me/wtBabUYQBt9Qt9DnYMy8RlGtlSk5ObhCXfdCP0nOu3
 ki70xMXKJHIvnfPOth7SQ9LM5u4vvng+ZVIPMpqt3zid3vo04ZchyGtlGc0B8QbXVSoIde
 H36RD+46Feo22XpDOLa+0BnrmfpBs7M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-owdTjbckN1uB-tmUXGSKkw-1; Thu, 30 Apr 2020 11:46:12 -0400
X-MC-Unique: owdTjbckN1uB-tmUXGSKkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29255107ACF6;
 Thu, 30 Apr 2020 15:46:11 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BB2210013BD;
 Thu, 30 Apr 2020 15:46:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hostmem: don't use mbind() if host-nodes is epmty
Date: Thu, 30 Apr 2020 11:46:06 -0400
Message-Id: <20200430154606.6421-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pbonzini@redhat.com, mhohmann@physnet.uni-hamburg.de, berrange@redhat.com,
 ehabkost@redhat.com, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since 5.0 QEMU uses hostmem backend for allocating main guest RAM.
The backend however calls mbind() which is typically NOP
in case of default policy/absent host-nodes bitmap.
However when runing in container with black-listed mbind()
syscall, QEMU fails to start with error
 "cannot bind memory to host NUMA nodes: Operation not permitted"
even when user hasn't provided host-nodes to pin to explictly
(which is the case with -m option)

To fix issue, call mbind() only in case when user has provided
host-nodes explicitly (i.e. host_nodes bitmap is not empty).
That should allow to run QEMU in containers with black-listed
mbind() without memory pinning. If QEMU provided memory-pinning
is required user still has to white-list mbind() in container
configuration.

Reported-by: Manuel Hohmann <mhohmann@physnet.uni-hamburg.de>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: berrange@redhat.com
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
CC: mhohmann@physnet.uni-hamburg.de
CC: qemu-stable@nongnu.org
---
 backends/hostmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/backends/hostmem.c b/backends/hostmem.c
index 327f9eebc3..0efd7b7bd6 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -383,8 +383,10 @@ host_memory_backend_memory_complete(UserCreatable *uc,=
 Error **errp)
         assert(sizeof(backend->host_nodes) >=3D
                BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));
         assert(maxnode <=3D MAX_NODES);
-        if (mbind(ptr, sz, backend->policy,
-                  maxnode ? backend->host_nodes : NULL, maxnode + 1, flags=
)) {
+
+        if (maxnode &&
+            mbind(ptr, sz, backend->policy, backend->host_nodes, maxnode +=
 1,
+                  flags)) {
             if (backend->policy !=3D MPOL_DEFAULT || errno !=3D ENOSYS) {
                 error_setg_errno(errp, errno,
                                  "cannot bind memory to host NUMA nodes");
--=20
2.18.1


