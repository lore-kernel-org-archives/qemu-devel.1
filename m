Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE0CC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4820C208C3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 14:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4820C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIZa7-0006TQ-Te
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 10:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iIZXL-0002XZ-Re
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iIZXG-00020C-Kv
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:35:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52320)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iIZXG-0001zv-FZ
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 10:35:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48FC2302C09A;
 Thu, 10 Oct 2019 14:35:21 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77B4660BE1;
 Thu, 10 Oct 2019 14:35:18 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 11/15] hw/intc/apic: reject pic ints if isa_pic == NULL
Date: Thu, 10 Oct 2019 16:31:22 +0200
Message-Id: <20191010143125.67246-13-slp@redhat.com>
In-Reply-To: <20191010143125.67246-1-slp@redhat.com>
References: <20191010143125.67246-1-slp@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 10 Oct 2019 14:35:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, Sergio Lopez <slp@redhat.com>, mst@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com,
 sgarzare@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In apic_accept_pic_intr(), reject PIC interruptions if a i8259 PIC has
not been instantiated (isa_pic =3D=3D NULL).

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/intc/apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index bce89911dc..2a74f7b4bf 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -610,7 +610,7 @@ int apic_accept_pic_intr(DeviceState *dev)
=20
     if ((s->apicbase & MSR_IA32_APICBASE_ENABLE) =3D=3D 0 ||
         (lvt0 & APIC_LVT_MASKED) =3D=3D 0)
-        return 1;
+        return isa_pic !=3D NULL;
=20
     return 0;
 }
--=20
2.21.0


