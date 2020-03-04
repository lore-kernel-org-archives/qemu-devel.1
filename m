Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DC3C3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC9820848
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 22:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fw08/Qfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC9820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9cMk-0002NJ-6j
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 17:19:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33058)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j9cLa-0000Io-8E
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j9cLZ-0006qJ-5M
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j9cLZ-0006py-1N
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 17:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583360312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8g6dQ3CpRHKhm3JtMqVTXiTXrin8V/riv5Rhf5txJno=;
 b=fw08/QfeeWa0QGNYY/7RVPhCLO+3xHITguMS7pewmASzK4eiX1RnEa7PwBIezq81PmfwCA
 wZwrgmbMNPRLiR3TaPvVlEKm0XAqq7h+4UyehYgczb0FTFqYL5PrnIAjr9tYOiBj2Pm/ir
 OCn5cpfiL+rBgamybTOTtAyulZQfv0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-_bGDrGbbMjO37IDn_5BCwA-1; Wed, 04 Mar 2020 17:18:31 -0500
X-MC-Unique: _bGDrGbbMjO37IDn_5BCwA-1
Received: by mail-wr1-f72.google.com with SMTP id n12so1429757wrp.19
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2020 14:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8ag/+xxkZSZEkgkSM8quJuguUY+bU0lgLQ4HQ0DMXWs=;
 b=eVi3NXqYYwIagkkSrlsomJX03bmdC9ErWqXzSY7TSmU88U0jTIMgcXRa1dics3z8/C
 Rf6XagxTD1PeyFSWnIYWXLifECT+v241yCAiRyGGgXWrCdhlU8ImnNS1RVmsWtZZQonQ
 GntkOHL/lT0LoJFE7/BMVdzdrJiPoVqZlsG3IDP+p80vkAb0rRobPLyZBvS5Xd7c0QSV
 HJsJ4G8pCb4QQQyrR7wUTezZh+OHdL/1o04qykC2N4l2NP5KcQVdxvpGuYOOFo6l8qLL
 YDo0+f7y8M0YjtcY7ORLhIBENsWINrRpxleP2qpkJrXM+I4j9UX2lUVxa6FIGWdyV2LR
 TEeg==
X-Gm-Message-State: ANhLgQ0fpspeZGOgc43W7q9+8woIVvQq+Cl2XTT4hjWw+xV9A3bknbJA
 tP0nsoI/lCfIE7L1IRop2g4v+rllgdu4hMtwd80kbt7PGrhprmM+JXH4UKhIAbp/Pzd8En/Nwzy
 fp2Yuig4Aj05MK3U=
X-Received: by 2002:a1c:9e85:: with SMTP id h127mr5311631wme.145.1583360309774; 
 Wed, 04 Mar 2020 14:18:29 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtKcWBVy9Ebsa5ZD89bCp6BN1joSIMvdFbksX94m3Mg3Rrj4N072ncdORfw0lP3e8sa5zBJbg==
X-Received: by 2002:a1c:9e85:: with SMTP id h127mr5311613wme.145.1583360309508; 
 Wed, 04 Mar 2020 14:18:29 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id q125sm6721082wme.19.2020.03.04.14.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2020 14:18:29 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/audio/intel-hda: Use memory region alias to reduce
 .rodata by 4.34MB
Date: Wed,  4 Mar 2020 23:18:05 +0100
Message-Id: <20200304221807.25212-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200304221807.25212-1-philmd@redhat.com>
References: <20200304221807.25212-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/audio/intel-hda.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 1bcc3e5cf8..e8d18b7c58 100644
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
2.21.1


