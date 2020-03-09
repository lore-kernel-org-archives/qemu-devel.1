Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B39C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:51:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 940422067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G51d+VSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940422067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJke-0007PH-QF
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBJe6-0006Db-LE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBJe2-0005wY-Q4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBJe1-0005vW-7l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ae/DAthWYWnXFNJs2ZCVZFc++oa1moJbYKYzRxX6NG8=;
 b=G51d+VSgKl4FuKiP/7rAWs7qnFJ6J4r4vHC3NhVfDLUR9DlEB3D91uKNQ3TdzAZRDYL5kl
 LlV8gs7ay7JOkrZ8YUVoa0uS75AYCfzI6VWuZ7ozYwrtNHQ0hLC892dT1mRm1qh2Sq6A4o
 TyETMeMqE4fkt+x2QPf63KTeDB2uuoM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-NQTE83D7N1CNkcjTZpbMRg-1; Mon, 09 Mar 2020 10:44:27 -0400
X-MC-Unique: NQTE83D7N1CNkcjTZpbMRg-1
Received: by mail-wm1-f69.google.com with SMTP id y7so2594836wmd.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U2DNSz+3tOcbaDjqIFmED7Unc0icLsBC4ouqrGCxisU=;
 b=emrCJT6Lb/KRelAdDZh+E5udaV+OZKmKVlwi5HGzgInqshLJorKgtCjiTfiCYH7Fgy
 AIay5afGkbGi6F27MPQND41YWYgt0arFSpgPFk1Mu2iNHpHaXWRRwa1AukMQcf7aadU7
 ncj4wKZvBrJauU8YimyI5B8RHa+hdVmRolFP/lD3O1CGb/B/S0T00/jVwKFO45RCa961
 HTV0xflbQX1+ShH6FwVqmR1iP3hVcFKHhed85rueaTQByaDs+Ry4UqWFxRo91lwgw41z
 jNFHm7czWehVZKa4JhWuyLMd4z2Sp5Yi6y9RrRe6mAlV8QSAhBsbxde6aFnPiqdS5Ex4
 H5xQ==
X-Gm-Message-State: ANhLgQ0kdsYm5AdDZYmY1q9PitfKA2tP2w3gnHJYLV2Oufm5aGS2sQzX
 NAMJClHKNncSXTpFwT4cEfdF2NIGftHy02nDqDVsyMcpVCdM8CN0zbaSuvPtVJOe090twG9hBDu
 RPe/vV1o6QKVle3I=
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr20457005wme.30.1583765066258; 
 Mon, 09 Mar 2020 07:44:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuLBjKm24vlbyeMtBj8ZSlKIOTyqTtSwCXt40/48jbGPQ6gsnCPP8dswseeRBiqSXk4NLgIQA==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr20456992wme.30.1583765066033; 
 Mon, 09 Mar 2020 07:44:26 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id w1sm24910094wmc.11.2020.03.09.07.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:44:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/core/loader: Provide rom_add_file_fixed() a 'max_size'
 argument
Date: Mon,  9 Mar 2020 15:43:53 +0100
Message-Id: <20200309144353.26457-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200309144353.26457-1-philmd@redhat.com>
References: <20200309144353.26457-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let rom_add_file_fixed() call rom_add_file() with a 'max_size'
argument, to avoid writing more than the available space for
the ROMs.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/loader.h  | 4 ++--
 hw/i386/x86.c        | 2 +-
 hw/ppc/sam460ex.c    | 2 +-
 hw/sparc64/niagara.c | 5 +++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 34ac630eb1..30ed80128e 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -292,8 +292,8 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size);
 void *rom_ptr(hwaddr addr, size_t size);
 void hmp_info_roms(Monitor *mon, const QDict *qdict);
=20
-#define rom_add_file_fixed(_f, _a, _i) \
-    rom_add_file(_f, NULL, _a, -1, _i, false, NULL, NULL)
+#define rom_add_file_fixed(_f, _a, _ms, _i) \
+    rom_add_file(_f, NULL, _a, _ms, _i, false, NULL, NULL)
 #define rom_add_blob_fixed(_f, _b, _l, _a)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
 #define rom_add_file_mr(_f, _mr, _i)            \
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 7f38e6ba8b..bdac66206a 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -783,7 +783,7 @@ void x86_bios_rom_init(MemoryRegion *rom_memory, bool i=
sapc_ram_fw)
     if (!isapc_ram_fw) {
         memory_region_set_readonly(bios, true);
     }
-    ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
+    ret =3D rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), bios_siz=
e, -1);
     if (ret !=3D 0) {
     bios_error:
         fprintf(stderr, "qemu: could not load PC BIOS '%s'\n", bios_name);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 898453cf30..5eab479ae5 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -127,7 +127,7 @@ static int sam460ex_load_uboot(void)
                 " using default u-boot image");*/
         rom_add_file_fixed(UBOOT_FILENAME,
                            UBOOT_LOAD_BASE | ((hwaddr)FLASH_BASE_H << 32),
-                           -1);
+                           UBOOT_SIZE, -1);
     }
=20
     return 0;
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index f58d008d3d..4dd9a77dcb 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -91,7 +91,7 @@ static void add_rom_or_fail(const char *file, const hwadd=
r addr,
     /* XXX remove qtest_enabled() check once firmware files are
      * in the qemu tree
      */
-    if (!qtest_enabled() && rom_add_file_fixed(file, addr, -1)) {
+    if (!qtest_enabled() && rom_add_file_fixed(file, addr, region_size, -1=
)) {
         error_report("Unable to load a firmware for -M niagara");
         exit(1);
     }
@@ -148,7 +148,8 @@ static void niagara_init(MachineState *machine)
             memory_region_add_subregion(get_system_memory(),
                                         NIAGARA_VDISK_BASE, &s->vdisk_ram)=
;
             dinfo->is_default =3D 1;
-            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE, =
-1);
+            rom_add_file_fixed(blk_bs(blk)->filename, NIAGARA_VDISK_BASE,
+                               size, -1);
         } else {
             error_report("could not load ram disk '%s'",
                          blk_bs(blk)->filename);
--=20
2.21.1


