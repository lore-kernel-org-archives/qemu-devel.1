Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BC2C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 23:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503D42073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 23:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G91cikUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503D42073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iceH6-0001by-G2
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 18:41:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iceF4-0000hP-Up
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 18:39:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iceF1-0007Pp-Lv
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 18:39:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44164
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iceF1-0007Ip-F3
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 18:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575502769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=56FSxIvhhdFu6OFWJ9EhlaNXrN21sWo44GwOSyq4zy0=;
 b=G91cikUbP8O8b7HohRPUwTl8mlwAwRYvx0+MdCdU2GDo674c8TpGvXdB9YV0l9HwXEgzxx
 zeC4yOdSLrZ01fO5Bf2fRMOXWAvWjLG5B/r6SNJ4RvIXdBFeVNudNBgZbv7kpvxmJ5WpNy
 XhxbGXnPlIflYWqKHySHO9aFXDGkQG4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-Fl5qRZGoPSyIsxTdjtjNoA-1; Wed, 04 Dec 2019 18:39:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFA06107ACC7;
 Wed,  4 Dec 2019 23:39:26 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-76.brq.redhat.com [10.40.205.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0E825D9C5;
 Wed,  4 Dec 2019 23:39:21 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0] hw/alpha/dp264: Use the DECchip Tulip network
 interface
Date: Thu,  5 Dec 2019 00:39:18 +0100
Message-Id: <20191204233918.6073-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Fl5qRZGoPSyIsxTdjtjNoA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Emilio G . Cota" <cota@braap.org>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 34ea023d4b9 introduced the Tulip PCI NIC.
Since this better models the DP264 hardware, use it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/alpha/dp264.c | 4 ++--
 hw/alpha/Kconfig | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 51b3cf7a61..4424551ba1 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -85,9 +85,9 @@ static void clipper_init(MachineState *machine)
     /* VGA setup.  Don't bother loading the bios.  */
     pci_vga_init(pci_bus);
=20
-    /* Network setup.  e1000 is good enough, failing Tulip support.  */
+    /* Network setup */
     for (i =3D 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, "e1000", NULL);
+        pci_nic_init_nofail(&nd_table[i], pci_bus, "tulip", NULL);
     }
=20
     /* 2 82C37 (dma) */
diff --git a/hw/alpha/Kconfig b/hw/alpha/Kconfig
index 15c59ff264..552e6a4c23 100644
--- a/hw/alpha/Kconfig
+++ b/hw/alpha/Kconfig
@@ -2,7 +2,7 @@ config DP264
     bool
     imply PCI_DEVICES
     imply TEST_DEVICES
-    imply E1000_PCI
+    imply TULIP
     select I82374
     select I8254
     select I8259
--=20
2.21.0


