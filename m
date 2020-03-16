Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2C7C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C2D20658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OrNqDE4C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C2D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxSe-0001y4-E6
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42403)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHd-0003fv-Sz
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxHb-0004pg-QW
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:25 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21354)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxHb-0004oA-L6
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WK5h4P8m8J06henO1MK/mBW4W9LphSNTnmEs0tNIUNI=;
 b=OrNqDE4CI9jliLCchSG2Vy8pNghdoUFkXdaL7DUvjzkJLAWtWR5cxGdDPr7KWIWfUc5hIH
 BppLZI+3gAxLTy94wrnlNyK+k2MbYW4/1CZSURNU8m0DkOugsmPWu/67874A4Zm8QmEGgS
 0iw92c0TxHYlnFrbuK4f5IeN9kXw1cI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-4lyT3BCQMxChqMIJRu6LdA-1; Mon, 16 Mar 2020 17:28:21 -0400
X-MC-Unique: 4lyT3BCQMxChqMIJRu6LdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6FC7800D50
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:20 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B441319C4F;
 Mon, 16 Mar 2020 21:28:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/61] hw/audio/intel-hda: Use memory region alias to reduce
 .rodata by 4.34MB
Date: Mon, 16 Mar 2020 22:26:53 +0100
Message-Id: <1584394048-44994-27-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

The intel-hda model uses an array of register indexed by the
register address. This array also contains a pair of aliased
registers at offset 0x2000. This creates a huge hole in the
array, which ends up eating 4.6MiB of .rodata (size reported
on x86_64 host, building with --extra-cflags=3D-Os).

By using a memory region alias, we reduce this array to 132kB.

Before:

  (qemu) info mtree
    00000000febd4000-00000000febd7fff (prio 1, i/o): intel-hda

After:

  (qemu) info mtree
    00000000febd4000-00000000febd7fff (prio 1, i/o): intel-hda
    00000000febd4000-00000000febd7fff (prio 1, i/o): intel-hda-container
      00000000febd4000-00000000febd5fff (prio 0, i/o): intel-hda
      00000000febd6000-00000000febd7fff (prio 0, i/o): alias intel-hda-alia=
s @intel-hda 0000000000000000-0000000000001fff

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/intel-hda.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 1bcc3e5..e8d18b7 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -181,7 +181,9 @@ struct IntelHDAState {
     IntelHDAStream st[8];
=20
     /* state */
+    MemoryRegion container;
     MemoryRegion mmio;
+    MemoryRegion alias;
     uint32_t rirb_count;
     int64_t wall_base_ns;
=20
@@ -670,12 +672,6 @@ static const struct IntelHDAReg regtab[] =3D {
         .offset   =3D offsetof(IntelHDAState, wall_clk),
         .rhandler =3D intel_hda_get_wall_clk,
     },
-    [ ICH6_REG_WALLCLK + 0x2000 ] =3D {
-        .name     =3D "WALLCLK(alias)",
-        .size     =3D 4,
-        .offset   =3D offsetof(IntelHDAState, wall_clk),
-        .rhandler =3D intel_hda_get_wall_clk,
-    },
=20
     /* dma engine */
     [ ICH6_REG_CORBLBASE ] =3D {
@@ -837,12 +833,6 @@ static const struct IntelHDAReg regtab[] =3D {
         .size     =3D 4,                                                \
         .offset   =3D offsetof(IntelHDAState, st[_i].lpib),             \
     },                                                                \
-    [ ST_REG(_i, ICH6_REG_SD_LPIB) + 0x2000 ] =3D {                     \
-        .stream   =3D _i,                                               \
-        .name     =3D _t stringify(_i) " LPIB(alias)",                  \
-        .size     =3D 4,                                                \
-        .offset   =3D offsetof(IntelHDAState, st[_i].lpib),             \
-    },                                                                \
     [ ST_REG(_i, ICH6_REG_SD_CBL) ] =3D {                               \
         .stream   =3D _i,                                               \
         .name     =3D _t stringify(_i) " CBL",                          \
@@ -1125,9 +1115,15 @@ static void intel_hda_realize(PCIDevice *pci, Error =
**errp)
         error_free(err);
     }
=20
+    memory_region_init(&d->container, OBJECT(d),
+                       "intel-hda-container", 0x4000);
     memory_region_init_io(&d->mmio, OBJECT(d), &intel_hda_mmio_ops, d,
-                          "intel-hda", 0x4000);
-    pci_register_bar(&d->pci, 0, 0, &d->mmio);
+                          "intel-hda", 0x2000);
+    memory_region_add_subregion(&d->container, 0x0000, &d->mmio);
+    memory_region_init_alias(&d->alias, OBJECT(d), "intel-hda-alias",
+                             &d->mmio, 0, 0x2000);
+    memory_region_add_subregion(&d->container, 0x2000, &d->alias);
+    pci_register_bar(&d->pci, 0, 0, &d->container);
=20
     hda_codec_bus_init(DEVICE(pci), &d->codecs, sizeof(d->codecs),
                        intel_hda_response, intel_hda_xfer);
--=20
1.8.3.1



