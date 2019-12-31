Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DCFC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D85205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCqC5ciE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D85205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHIZ-0005uA-0T
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBr-0005B7-Jr
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBq-0002SM-Ae
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38159
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBq-0002Q2-4H
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmZVTB7dAUFXmt9nBsUuXJIwbbOeYxCoxcT6SlrnKy8=;
 b=ZCqC5ciE4C1wmF+7yr/CAuxjonAXxM6hhUMly9553mJfXnLIYTMNI6Pw7IpBjve5hAzR7f
 UzhtwwygbIgwjMEK326iYmJ0CvApdo8PB+HFjR6U9oY6QxFZ/OIsg7noP9sK5bCsfBGtHT
 T9/QAJK/pvr3DkZWICi2cmMtXNRsLgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-lq6hQalWPluE7D4a7GYV0A-1; Tue, 31 Dec 2019 08:03:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554F918031CD
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFB54620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:57 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/86] arm:aspeed: actually check RAM size
Date: Tue, 31 Dec 2019 14:02:54 +0100
Message-Id: <1577797450-88458-11-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: lq6hQalWPluE7D4a7GYV0A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's supposed that SOC will check if "-m" provided
RAM size is valid by setting "ram-size" property and
then board would read back valid (possibly corrected
value) to allocate/map RAM MemoryRegion with valid size.
Well it isn't doing so, since check is called too late
indirectly from
  aspeed_sdmc_reset()->asc->compute_conf()
or much later when guest writes to configuration
register.

So depending on "-m" value QEMU end-ups with a warning
and an invalid MemoryRegion size allocated and mapped.
(examples:
 -M ast2500-evb -m 1M
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-00000000800fffff (prio 0, ram): ram
      0000000080100000-00000000bfffffff (prio 0, i/o): max_ram
 -M ast2500-evb -m 3G
    0000000080000000-000000017ffffffe (prio 0, i/o): aspeed-ram-container
      0000000080000000-000000013fffffff (prio 0, ram): ram
      [DETECTED OVERFLOW!] 0000000140000000-00000000bfffffff (prio 0, i/o):=
 max_ram
)
On top of that sdmc falls back and reports to guest
"default" size, it thinks machine should have.

For CLI side machine should honor whatever user configured
or error out to make user fix CLI.

This patch makes ram-size check actually work and
changes behavior from a warning later on during
machine reset to error_fatal at the moment SOC is
realized so user will have to fix RAM size on CLI
to start machine.

It also gets out of the way mutable ram-size logic,
so we could consolidate RAM allocation logic around
pre-allocated hostmem backend (supplied by user or
auto created by generic machine code depending on
supplied -m/mem-path/mem-prealloc options.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/aspeed.c       | 9 +--------
 hw/misc/aspeed_sdmc.c | 5 +++++
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index cc06af4..525c547 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -213,14 +213,7 @@ static void aspeed_machine_init(MachineState *machine)
                                 "hw-prot-key", &error_abort);
     }
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
-                             &error_abort);
-
-    /*
-     * Allocate RAM after the memory controller has checked the size
-     * was valid. If not, a default value is used.
-     */
-    ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "ram-size",
-                                        &error_abort);
+                             &error_fatal);
=20
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_size)=
;
     memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 3fc80f0..b398e36 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -165,6 +165,11 @@ static void aspeed_sdmc_realize(DeviceState *dev, Erro=
r **errp)
     AspeedSDMCState *s =3D ASPEED_SDMC(dev);
     AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
=20
+    if (!g_hash_table_contains(asc->ram2feat,
+                               GINT_TO_POINTER(s->ram_size >> 20))) {
+        error_setg(errp, "Invalid RAM size 0x%" PRIx64, s->ram_size);
+        return;
+    }
     s->max_ram_size =3D asc->max_ram_size;
=20
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
--=20
2.7.4


