Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3454C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5B021924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5B021924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NZ5-0002dW-W2
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crobinso@redhat.com>) id 1i7NYH-0001sY-Sy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crobinso@redhat.com>) id 1i7NYG-0006by-D7
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crobinso@redhat.com>) id 1i7NYG-0006bQ-80
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:34:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8E4B8980EE;
 Mon,  9 Sep 2019 17:34:06 +0000 (UTC)
Received: from worklaptop.redhat.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60E265D6B7;
 Mon,  9 Sep 2019 17:34:01 +0000 (UTC)
From: Cole Robinson <crobinso@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  9 Sep 2019 13:34:10 -0400
Message-Id: <e73e6edff68fd30d69c6a1d02c9ef9192f773c63.1568049871.git.crobinso@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Mon, 09 Sep 2019 17:34:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] hw/i386: Move CONFIG_ACPI_PCI to CONFIG_PC
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cole Robinson <crobinso@redhat.com>,
 richardw.yang@linux.intel.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

CONFIG_ACPI_PCI is a hard requirement of acpi-build.c, which is built
unconditionally for x86 target. Putting it in default-configs/ suggests
that it can be easily disabled, which isn't true.

Relocate the symbol with the other acpi-build.c requirements, under
'config PC'. This is similar to what is done for the arm 'virt' machine
type and CONFIG_ACPI_PCI

Signed-off-by: Cole Robinson <crobinso@redhat.com>
---
 default-configs/i386-softmmu.mak | 1 -
 hw/i386/Kconfig                  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index cd5ea391e8..ba3fb3ff50 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -25,4 +25,3 @@
 CONFIG_ISAPC=3Dy
 CONFIG_I440FX=3Dy
 CONFIG_Q35=3Dy
-CONFIG_ACPI_PCI=3Dy
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 6350438036..c7a9d6315c 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -29,6 +29,7 @@ config PC
     select MC146818RTC
     # For ACPI builder:
     select SERIAL_ISA
+    select ACPI_PCI
     select ACPI_VMGENID
     select VIRTIO_PMEM_SUPPORTED
=20
--=20
2.21.0


