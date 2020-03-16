Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAEC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D93C20719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyDM+qnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D93C20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxkS-0006o5-7J
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIK-0004cA-Em
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIJ-0007x9-3s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27222)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxII-0007tX-RG
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zzu/3WU0sPNH9lefVz4BswbZFwOVpA8KpkL8eSt/B6Q=;
 b=iyDM+qnBOT73VedkYticsJv0blJWCeEBPpDQkqIYH9PUQ4r5iXWk1u647pxb1QokCBcvJe
 2bWngYBmoUQSHKaS3Qyc1rleLVA9QwQ3AY3Ls4v2Oi0s38jrJbL5GrU3PqleDyWZvExhqD
 e5ZxM/U/Ymhbkg2JFRQ9+b5mV+dDt9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-RJygm3ZMNo-v_wHqleMVdw-1; Mon, 16 Mar 2020 17:29:04 -0400
X-MC-Unique: RJygm3ZMNo-v_wHqleMVdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26916801A02
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:29:04 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 314F319756;
 Mon, 16 Mar 2020 21:29:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 52/61] scripts/cocci: Patch to let devices own their
 MemoryRegions
Date: Mon, 16 Mar 2020 22:27:19 +0100
Message-Id: <1584394048-44994-53-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

When a device creates a MemoryRegion without setting its ownership,
the MemoryRegion is added to the machine "/unattached" container in
the QOM tree.

Example with the Samsung SMDKC210 board:

  $ arm-softmmu/qemu-system-arm -M smdkc210 -S -monitor stdio
  (qemu) info qom-tree
  /machine (smdkc210-machine)
    /unattached (container)
      /io[0] (qemu:memory-region)
      /exynos4210.dram0[0] (qemu:memory-region)
      /exynos4210.irom[0] (qemu:memory-region)
      /exynos4210.iram[0] (qemu:memory-region)
      /exynos4210.chipid[0] (qemu:memory-region)
      ...
      /device[26] (exynos4210.uart)
        /exynos4210.uart[0] (qemu:memory-region)
    /soc (exynos4210)
      ^
       \__ [*]

The irom/iram/chipid regions should go under 'soc' at [*].

Add a semantic patch to let the device own the memory region.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 .../coccinelle/memory-region-housekeeping.cocci    | 56 ++++++++++++++++++=
++++
 1 file changed, 56 insertions(+)

diff --git a/scripts/coccinelle/memory-region-housekeeping.cocci b/scripts/=
coccinelle/memory-region-housekeeping.cocci
index 5e6b31d..c768d81 100644
--- a/scripts/coccinelle/memory-region-housekeeping.cocci
+++ b/scripts/coccinelle/memory-region-housekeeping.cocci
@@ -101,3 +101,59 @@ expression ERRP;
 +memory_region_init_rom_device(MR, NULL, OPS, OPAQUE, NAME, SIZE, ERRP);
  ...
 -vmstate_register_ram_global(MR);
+
+
+// Device is owner
+@@
+typedef DeviceState;
+identifier device_fn, dev, obj;
+expression E1, E2, E3, E4, E5;
+@@
+static void device_fn(DeviceState *dev, ...)
+{
+  ...
+  Object *obj =3D OBJECT(dev);
+  <+...
+(
+- memory_region_init(E1, NULL, E2, E3);
++ memory_region_init(E1, obj, E2, E3);
+|
+- memory_region_init_io(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_io(E1, obj, E2, E3, E4, E5);
+|
+- memory_region_init_alias(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_alias(E1, obj, E2, E3, E4, E5);
+|
+- memory_region_init_rom(E1, NULL, E2, E3, E4);
++ memory_region_init_rom(E1, obj, E2, E3, E4);
+|
+- memory_region_init_ram_shared_nomigrate(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_ram_shared_nomigrate(E1, obj, E2, E3, E4, E5);
+)
+  ...+>
+}
+@@
+identifier device_fn, dev;
+expression E1, E2, E3, E4, E5;
+@@
+static void device_fn(DeviceState *dev, ...)
+{
+  <+...
+(
+- memory_region_init(E1, NULL, E2, E3);
++ memory_region_init(E1, OBJECT(dev), E2, E3);
+|
+- memory_region_init_io(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_io(E1, OBJECT(dev), E2, E3, E4, E5);
+|
+- memory_region_init_alias(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_alias(E1, OBJECT(dev), E2, E3, E4, E5);
+|
+- memory_region_init_rom(E1, NULL, E2, E3, E4);
++ memory_region_init_rom(E1, OBJECT(dev), E2, E3, E4);
+|
+- memory_region_init_ram_shared_nomigrate(E1, NULL, E2, E3, E4, E5);
++ memory_region_init_ram_shared_nomigrate(E1, OBJECT(dev), E2, E3, E4, E5)=
;
+)
+  ...+>
+}
--=20
1.8.3.1



