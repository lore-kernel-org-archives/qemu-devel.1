Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8935FC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 11:04:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5323321655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 11:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cG6r2rRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5323321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifikA-0007gH-H4
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 06:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ififX-00054B-93
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:59:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ififW-0006L8-6v
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:59:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ififW-0006K3-2d
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576234773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AmmOFuYGtKlXxuusm4o7US5u79QybDIbfYEE1TIgLbk=;
 b=cG6r2rRmThPqdf3yyNGGY+OGhrcsZb70F+pCofxhFY+GbmvxdGbGI6m7Pqw/so7OscmyyT
 TLkB9rolBBYfoTDHG0Jk3P3SMfrhpP78I3Om4veIRUa1z5oR2sFX4GRzHnYV2IXhpcxdae
 QYk/TvL6VuMJrV5JIziWOJopCFi9RSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-6KJGTFsLNr-EC8dW4WINIA-1; Fri, 13 Dec 2019 05:59:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A63EE800D48;
 Fri, 13 Dec 2019 10:59:29 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-134.brq.redhat.com [10.40.204.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 216916764A;
 Fri, 13 Dec 2019 10:59:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/isa/isa-bus: Use ISA_NUM_IRQS instead of magic number
Date: Fri, 13 Dec 2019 11:59:21 +0100
Message-Id: <20191213105921.9529-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 6KJGTFsLNr-EC8dW4WINIA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a definition for the number of ISA IRQs, use it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/isa/isa-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 388800603b..1d79ed133c 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -85,7 +85,7 @@ void isa_bus_irqs(ISABus *bus, qemu_irq *irqs)
 qemu_irq isa_get_irq(ISADevice *dev, int isairq)
 {
     assert(!dev || ISA_BUS(qdev_get_parent_bus(DEVICE(dev))) =3D=3D isabus=
);
-    if (isairq < 0 || isairq > 15) {
+    if (isairq < 0 || isairq > >=3D ISA_NUM_IRQS) {
         hw_error("isa irq %d invalid", isairq);
     }
     return isabus->irqs[isairq];
--=20
2.21.0


