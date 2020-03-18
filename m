Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A36C5ACD7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:49:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B8D20767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 13:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWDhe2Z4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B8D20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEZ4v-0006Ua-Od
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 09:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jusual@redhat.com>) id 1jEZ4I-0005yr-W5
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jusual@redhat.com>) id 1jEZ4H-0002Qv-7D
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:49:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:47344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jusual@redhat.com>) id 1jEZ4H-0002LH-0L
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 09:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584539348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tDXB/8+Q9VTzUqH6QIri9JT1cxyBCk802SIj4HcYUp4=;
 b=bWDhe2Z4E2MIww8pv/aR4m7qC5FlvqbS0VhE+tkA5wkjWC7W+GaRtsPqaJ63/L1R/HTUz3
 uy+i5cNF3rNSNoqR3Tiq/cajImZ37zbONsFihtzKEA/iWwFfAUsZMoT+Hud1CW2bWCXi4C
 /eauDL+UDK032r0zhbPBjGc4VQ7jeSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-cPIBvck8NrWIG10ooCm2yg-1; Wed, 18 Mar 2020 09:49:06 -0400
X-MC-Unique: cPIBvck8NrWIG10ooCm2yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4099C18B5FA0;
 Wed, 18 Mar 2020 13:49:05 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-41.sin2.redhat.com
 [10.67.116.41])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F40D60BEC;
 Wed, 18 Mar 2020 13:48:57 +0000 (UTC)
From: Julia Suvorova <jusual@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/rdma/vmw/pvrdma_dev_ring: Replace strncpy with pstrcpy
Date: Wed, 18 Mar 2020 14:48:49 +0100
Message-Id: <20200318134849.237011-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: qemu-trivial@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ring->name is defined as 'char name[MAX_RING_NAME_SZ]'. Replace untruncated
strncpy with QEMU function.
This case prevented QEMU from compiling with --enable-sanitizers.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 hw/rdma/vmw/pvrdma_dev_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_dev_ring.c b/hw/rdma/vmw/pvrdma_dev_ring.c
index d7bc7f5ccc..c2b3dd70a9 100644
--- a/hw/rdma/vmw/pvrdma_dev_ring.c
+++ b/hw/rdma/vmw/pvrdma_dev_ring.c
@@ -16,6 +16,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "cpu.h"
+#include "qemu/cutils.h"
=20
 #include "trace.h"
=20
@@ -30,8 +31,7 @@ int pvrdma_ring_init(PvrdmaRing *ring, const char *name, =
PCIDevice *dev,
     int i;
     int rc =3D 0;
=20
-    strncpy(ring->name, name, MAX_RING_NAME_SZ);
-    ring->name[MAX_RING_NAME_SZ - 1] =3D 0;
+    pstrcpy(ring->name, MAX_RING_NAME_SZ, name);
     ring->dev =3D dev;
     ring->ring_state =3D ring_state;
     ring->max_elems =3D max_elems;
--=20
2.24.1


