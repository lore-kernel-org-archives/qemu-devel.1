Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC26C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B37D2067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPMn3PE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B37D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJig-0004Jk-GT
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBJdi-0005uf-Pa
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBJdh-0005fo-Ia
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25571
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBJdh-0005fg-EB
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5wMMOV9j8GXgLN/f8OZXnk4tnLPp7frltBDKpvp80Y=;
 b=IPMn3PE/wQ9g6rI21ZtskYTB57LGtF2kiY+QyfKJ0sfrBHa+L77gBT4uSiahG4xe4pdNhO
 hURAidbdjncWe9oraVJonkhielJufsdFwTvjpKCfqzdR57f76xs5AItvHmTo2qgLjVevzn
 9GLMOUajRDa1d5pg2pnHmpBrp+9QLp8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-3ANlaMNCMs6BJ7GVr7JQlQ-1; Mon, 09 Mar 2020 10:44:15 -0400
X-MC-Unique: 3ANlaMNCMs6BJ7GVr7JQlQ-1
Received: by mail-wm1-f71.google.com with SMTP id y7so2594637wmd.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YrE/gfNOEXj7sn4Or3GrKnxgngUq3VZvk0bAiaEuFtE=;
 b=qcl/tTOLtAgyB1mx+8/In1PSFQek4G8d49eA5J3PgCLaG4/GfSudBYwx2eZijHQbr3
 HQgnz7xV3Xtw02YzJWngXWSzfH/8z+ERZgbhH5blodE3KyQ8PE5oNxK4peSPDKeGCDw4
 CCOTzVSCnUAx2kn3fj66gro2Ikx124AZ25yBGfiT11F5H+l8Gkq/6edYHoUjR8EqJEh5
 Q+6NGX/J6LoKgsnu4fn3p+50MyPDYSHoLbsHVkAiD5oqYMnQ5UvU3omL+2i3MN9L0b4W
 PMF6HlIDQv8ov25i2h1/5FRBwlXbWlAFlg96X4EhMTZezTqGgRpw5aiIv9lNRvGGQi0b
 RRBg==
X-Gm-Message-State: ANhLgQ2SCKED+9aF8ZmZ9jdGtRFfM4yfMmczBAS7NtXSxMs+yrsvR/xX
 G/c2dDE+nt8pA4HMoAiLl9c0GnoCCw+668xgS7Y0Fi/bzk20SFI5uoo2/bpqVnFg8mciFNhV937
 ZRITwDbTQFzMkXDU=
X-Received: by 2002:a05:600c:2951:: with SMTP id
 n17mr19634498wmd.97.1583765053986; 
 Mon, 09 Mar 2020 07:44:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuZBW8hCI+4IFfxi9ZxxNSc+YYdvSo6iVO8aMLSLBaA1jhIR6uhTfEeLBgS/Bhey2ybV/cfyQ==
X-Received: by 2002:a05:600c:2951:: with SMTP id
 n17mr19634472wmd.97.1583765053777; 
 Mon, 09 Mar 2020 07:44:13 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id a1sm1980854wro.72.2020.03.09.07.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:44:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/core/loader: Provide rom_add_file() a 'max_size'
 argument
Date: Mon,  9 Mar 2020 15:43:51 +0100
Message-Id: <20200309144353.26457-4-philmd@redhat.com>
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

In commit d60fa42e8b we cared about loading ROMs smaller than
the underlying memory region (by zeroing the missing area) but
we forgot the case where a ROM file is bigger than the underlying
region.
Provide rom_add_file() a 'max_size' argument, and refuse loading
ROM files bigger than it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/hw/loader.h | 12 ++++++------
 hw/core/loader.c    | 19 +++++++++++++------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index a9eeea3952..99d690a628 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -254,7 +254,7 @@ extern bool option_rom_has_mr;
 extern bool rom_file_has_mr;
=20
 int rom_add_file(const char *file, const char *fw_dir,
-                 hwaddr addr, int32_t bootindex,
+                 hwaddr addr, uint64_t max_len, int32_t bootindex,
                  bool option_rom, MemoryRegion *mr, AddressSpace *as);
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                            size_t max_len, hwaddr addr,
@@ -292,16 +292,16 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size)=
;
 void *rom_ptr(hwaddr addr, size_t size);
 void hmp_info_roms(Monitor *mon, const QDict *qdict);
=20
-#define rom_add_file_fixed(_f, _a, _i)          \
-    rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
+#define rom_add_file_fixed(_f, _a, _i) \
+    rom_add_file(_f, NULL, _a, -1, _i, false, NULL, NULL)
 #define rom_add_blob_fixed(_f, _b, _l, _a)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
 #define rom_add_file_mr(_f, _mr, _i)            \
-    rom_add_file(_f, NULL, 0, _i, false, _mr, NULL)
+    rom_add_file(_f, NULL, 0, -1, _i, false, _mr, NULL)
 #define rom_add_file_as(_f, _as, _i)            \
-    rom_add_file(_f, NULL, 0, _i, false, NULL, _as)
+    rom_add_file(_f, NULL, 0, -1, _i, false, NULL, _as)
 #define rom_add_file_fixed_as(_f, _a, _i, _as)          \
-    rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
+    rom_add_file(_f, NULL, _a, -1, _i, false, NULL, _as)
 #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
=20
diff --git a/hw/core/loader.c b/hw/core/loader.c
index c67c483936..00436f1524 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -938,7 +938,7 @@ static void *rom_set_mr(Rom *rom, Object *owner, const =
char *name, bool ro)
 }
=20
 int rom_add_file(const char *file, const char *fw_dir,
-                 hwaddr addr, int32_t bootindex,
+                 hwaddr addr, uint64_t max_len, int32_t bootindex,
                  bool option_rom, MemoryRegion *mr,
                  AddressSpace *as)
 {
@@ -974,14 +974,21 @@ int rom_add_file(const char *file, const char *fw_dir=
,
         rom->fw_file =3D g_strdup(file);
     }
     rom->addr     =3D addr;
-    rom->romsize  =3D lseek(fd, 0, SEEK_END);
-    if (rom->romsize =3D=3D -1) {
+    rom->datasize =3D lseek(fd, 0, SEEK_END);
+    if (rom->datasize =3D=3D -1) {
         fprintf(stderr, "rom: file %-20s: get size error: %s\n",
                 rom->name, strerror(errno));
         goto err;
     }
=20
-    rom->datasize =3D rom->romsize;
+    rom->romsize =3D max_len ? max_len : rom->datasize;
+    if (rom->romsize < rom->datasize) {
+        fprintf(stderr,
+                "rom: file '%-20s' size too big: %zu (available: %zu)\n",
+                rom->name, rom->datasize, rom->romsize);
+        goto err;
+    }
+
     rom->data     =3D g_malloc0(rom->datasize);
     lseek(fd, 0, SEEK_SET);
     rc =3D read(fd, rom->data, rom->datasize);
@@ -1107,12 +1114,12 @@ int rom_add_elf_program(const char *name, GMappedFi=
le *mapped_file, void *data,
=20
 int rom_add_vga(const char *file)
 {
-    return rom_add_file(file, "vgaroms", 0, -1, true, NULL, NULL);
+    return rom_add_file(file, "vgaroms", 0, -1, -1, true, NULL, NULL);
 }
=20
 int rom_add_option(const char *file, int32_t bootindex)
 {
-    return rom_add_file(file, "genroms", 0, bootindex, true, NULL, NULL);
+    return rom_add_file(file, "genroms", 0, -1, bootindex, true, NULL, NUL=
L);
 }
=20
 static void rom_reset(void *unused)
--=20
2.21.1


