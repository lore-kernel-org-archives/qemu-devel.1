Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4666ECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B6E20650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 16:49:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B6E20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKQ0K-00081O-2F
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iKPj8-0003vx-Ld
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iKPj6-0006Nm-Ms
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56916)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iKPj6-0006MK-Et
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 12:31:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A7C6780166F;
 Tue, 15 Oct 2019 16:31:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0599E19C58;
 Tue, 15 Oct 2019 16:31:04 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/32] hw/i386/pc: Reduce gsi_handler scope
Date: Tue, 15 Oct 2019 18:26:54 +0200
Message-Id: <20191015162705.28087-22-philmd@redhat.com>
In-Reply-To: <20191015162705.28087-1-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 15 Oct 2019 16:31:10 +0000 (UTC)
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

pc_gsi_create() is the single function that uses gsi_handler.
Make it a static variable.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/i386/pc.c         | 2 +-
 include/hw/i386/pc.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a7597c6c44..59de0c8a1f 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -346,7 +346,7 @@ GlobalProperty pc_compat_1_4[] =3D {
 };
 const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
=20
-void gsi_handler(void *opaque, int n, int level)
+static void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d0c6b9d469..75b44e156c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -172,8 +172,6 @@ typedef struct GSIState {
     qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
 } GSIState;
=20
-void gsi_handler(void *opaque, int n, int level);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
=20
 /* vmport.c */
--=20
2.21.0


