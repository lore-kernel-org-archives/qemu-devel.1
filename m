Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC680C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9820820772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7JcdjQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9820820772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGvI-0000UB-Ov
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqF-0000I8-2J
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqD-0005lE-KX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqD-0005kc-H9
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n8HmSTm9WnCU4dZKskIiwKW5MV+WGIgJj9Ow7s72VtQ=;
 b=Z7JcdjQHIGcwtQ/GJRKlkp2YpxPmSxY5/eXsKvXXzKAK8H8eUhEgI+xOV+/0ds0pGsF6d8
 8xsINY/mPGN/zrKjzDSiHszyPAKskIUJtL2/WoJLKS7ncVvRLXNsWPcTRHeS4DDtVd43oR
 UJZRPf5KUaYbjoP/ebZ+rRByxvlBg3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-9hi62n6oOYGbecItYSsOqg-1; Tue, 31 Mar 2020 09:22:01 -0400
X-MC-Unique: 9hi62n6oOYGbecItYSsOqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E7C1052BA7;
 Tue, 31 Mar 2020 13:22:01 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650C91036D00;
 Tue, 31 Mar 2020 13:21:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 05/14] hw/net/smc91c111: Let smc91c111_can_receive() return
 a boolean
Date: Tue, 31 Mar 2020 21:21:30 +0800
Message-Id: <1585660899-11228-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The smc91c111_can_receive() function simply returns a boolean value.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/smc91c111.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index e9eb6f6..02be60c 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -130,16 +130,16 @@ static void smc91c111_update(smc91c111_state *s)
     qemu_set_irq(s->irq, level);
 }
=20
-static int smc91c111_can_receive(smc91c111_state *s)
+static bool smc91c111_can_receive(smc91c111_state *s)
 {
     if ((s->rcr & RCR_RXEN) =3D=3D 0 || (s->rcr & RCR_SOFT_RST)) {
-        return 1;
+        return true;
     }
     if (s->allocated =3D=3D (1 << NUM_PACKETS) - 1 ||
         s->rx_fifo_len =3D=3D NUM_PACKETS) {
-        return 0;
+        return false;
     }
-    return 1;
+    return true;
 }
=20
 static inline void smc91c111_flush_queued_packets(smc91c111_state *s)
--=20
2.5.0


