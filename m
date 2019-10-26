Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D9C47E49
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD8120663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyWJ3CJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD8120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQQS-0001bx-H6
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQOx-00007d-6U
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQOs-0007H7-8E
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:02:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23120
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQOq-0007FI-TM
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572112969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hYMnPZ5D9VTwMvNBI3kAdcKgWePOg0WTs5W1q22l8A8=;
 b=SyWJ3CJ5548fJFh7yhTJ0ano7XSWyfqMyTuqSK9W1xlpE31Wj+eTMPY4rR/WkfP3lHH/eQ
 Z1LPbYKM8YsaUksftGHyHHBEnkaB/jT0agRryalxxXAdFNxuUQZJS8Y0DO8r2nkAxvfOek
 /CvlIq3C+eruc4XAM30h2LAp7bMixVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-lY_riGLcNZ29LAoQqNPbHA-1; Sat, 26 Oct 2019 14:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D12DD100550E;
 Sat, 26 Oct 2019 18:02:43 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5606D60C57;
 Sat, 26 Oct 2019 18:02:29 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/20] Revert "irq: introduce qemu_irq_proxy()"
Date: Sat, 26 Oct 2019 20:01:27 +0200
Message-Id: <20191026180143.7369-5-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: lY_riGLcNZ29LAoQqNPbHA-1
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
Cc: Esteban Bosse <estebanbosse@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

This function isn't used anymore.

This reverts commit 22ec3283efba9ba0792790da786d6776d83f2a92.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Esteban Bosse <estebanbosse@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/core/irq.c    | 14 --------------
 include/hw/irq.h |  5 -----
 2 files changed, 19 deletions(-)

diff --git a/hw/core/irq.c b/hw/core/irq.c
index 7cc0295d0e..fb3045b912 100644
--- a/hw/core/irq.c
+++ b/hw/core/irq.c
@@ -120,20 +120,6 @@ qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2)
     return qemu_allocate_irq(qemu_splitirq, s, 0);
 }
=20
-static void proxy_irq_handler(void *opaque, int n, int level)
-{
-    qemu_irq **target =3D opaque;
-
-    if (*target) {
-        qemu_set_irq((*target)[n], level);
-    }
-}
-
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n)
-{
-    return qemu_allocate_irqs(proxy_irq_handler, target, n);
-}
-
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, in=
t n)
 {
     int i;
diff --git a/include/hw/irq.h b/include/hw/irq.h
index fe527f6f51..24ba0ece11 100644
--- a/include/hw/irq.h
+++ b/include/hw/irq.h
@@ -51,11 +51,6 @@ qemu_irq qemu_irq_invert(qemu_irq irq);
  */
 qemu_irq qemu_irq_split(qemu_irq irq1, qemu_irq irq2);
=20
-/* Returns a new IRQ set which connects 1:1 to another IRQ set, which
- * may be set later.
- */
-qemu_irq *qemu_irq_proxy(qemu_irq **target, int n);
-
 /* For internal use in qtest.  Similar to qemu_irq_split, but operating
    on an existing vector of qemu_irq.  */
 void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, in=
t n);
--=20
2.21.0


