Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76901C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FE382073A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 11:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSUXENiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FE382073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irh0n-0008CP-D1
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 06:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1irgzz-0006vg-VE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1irgzr-0004KA-TJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:38:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32374
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1irgzp-0004HW-T4
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 06:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579088280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4P+bM/vZpE5lNkOKVhAXPHeZ4S2lSKTreH2z68EN97s=;
 b=jSUXENiXXEHP1uMSU6xl8oOCFkcmGrcvkJswjCgIwDhLx2aTJVMrfLXl/oOeHDi51gizKn
 FMIBOyT8XbIxnrD0gbS1UXBlHnUyw0AQzfx5OVt4g2BwS6VyTsJohVyjXX5HoVvu8E14fh
 8+wwFsGc/NeG6QV/k7Y15VhlnHet0iU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-KA-DoQh-Miiv-re6hlqBmg-1; Wed, 15 Jan 2020 06:37:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 273E864A97;
 Wed, 15 Jan 2020 11:37:58 +0000 (UTC)
Received: from thuth.com (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7D4A811E7;
 Wed, 15 Jan 2020 11:37:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] hw/input: Do not enable CONFIG_PCKBD by default
Date: Wed, 15 Jan 2020 12:37:48 +0100
Message-Id: <20200115113748.24757-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: KA-DoQh-Miiv-re6hlqBmg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-trivial@nongnu.org, Philippe Mathieu-Daude <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The i8042 device is part of the chipset of a machine, so it should
be selected by the machines or chipsets (e.g. SuperIO chipsets),
and not be enabled by default.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/input/Kconfig | 1 -
 hw/isa/Kconfig   | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 287f08887b..a2f25725be 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -7,7 +7,6 @@ config LM832X
=20
 config PCKBD
     bool
-    default y
     select PS2
     depends on ISA_BUS
=20
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 8a38813cc1..c7f07854f7 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -16,6 +16,7 @@ config I82378
 config ISA_SUPERIO
     bool
     select ISA_BUS
+    select PCKBD
=20
 config PC87312
     bool
--=20
2.18.1


