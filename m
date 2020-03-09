Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5235C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02B321655
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV0of2+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02B321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBJf2-00079d-QX
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 10:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBJdY-0005cc-9l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBJdW-0005RY-7a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43539
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBJdW-0005QK-3g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 10:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583765045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h36vhIUgzGSA7tp2m1K7rtFcj4xL8Bgg5StjTVdwGng=;
 b=YV0of2+324P19iGSV1m1rhzGBSPGGoP4goSOeOk+fWHyBVe1m5zS9judj4RYjBwRGLF/Pk
 uyYhyPutuJOAo365JGpEVIBRKpF3Ptvw09VgyLlXs1o/3q+xOEzczyG2CtaxEVgSk50yuA
 HK/AfAo9l8DKPWmG6G76wcBpzJQV9NA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-jkxWU9DhMkulRvqLUY8wzw-1; Mon, 09 Mar 2020 10:44:04 -0400
X-MC-Unique: jkxWU9DhMkulRvqLUY8wzw-1
Received: by mail-wm1-f70.google.com with SMTP id z12so1114053wml.7
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 07:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mtcdQIrRNEFT9G2O7fcZe2gihBUfqh+MPKQ0KJhXHDE=;
 b=ZX0WM/hwGexdYLVraHm5DD48ZqsWIGJrU81LY/B1vAGcTOpa+oSFQU+QSiyj9sez+1
 386UmBb/OhE/Tq52efIFau76rmsjBIbD8IXCy5xKyhrOniPTKTaGUF9q12jgV0vaX88x
 H8xr+ZYpRY2nTU4NcMZ97AwdrotYtv/PPL/Kl6/1Sywv/oJ9w29nmYFRGFgKP6PUVxtZ
 ZrHKYaUBFBlwi/Iebvert3wbBtdbwDjdYercVOOa/2WfcDffXUeSyNSg1JR0UZlR8NdI
 ELIdzDRwUAhH7TD7hCcB5jlXOASkyuNcXHY3x9jdjITj0cg2crnt12r/n5bWWACwM8Ti
 tZxA==
X-Gm-Message-State: ANhLgQ3p4p3lwxngmSo14Yb+NEFdi2xCdaEyJs6T5vflepj73nZ0OFLm
 NBLF2JsVa2RXiPJMPwesrPmfhQtgVrs4bANzPLJWhaKhvIWbd7HxZS8ce6Epr40qYycZBfUWHZq
 NtZyrO9npE89+KHg=
X-Received: by 2002:adf:eaca:: with SMTP id o10mr21278967wrn.401.1583765042790; 
 Mon, 09 Mar 2020 07:44:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtddIkFcc5/sCSwuQ1bTgeSOlkyKAP+QNb3vuRqDSMraeuL6ZChGagu25hg9Fu2RzkSg7u8Dg==
X-Received: by 2002:adf:eaca:: with SMTP id o10mr21278939wrn.401.1583765042571; 
 Mon, 09 Mar 2020 07:44:02 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id c26sm25211118wmb.8.2020.03.09.07.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 07:44:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] hw/sparc64/niagara: Pass available memory region size to
 add_rom_or_fail
Date: Mon,  9 Mar 2020 15:43:49 +0100
Message-Id: <20200309144353.26457-2-philmd@redhat.com>
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

In few commits we'll let rom_add_file_fixed() take a 'size'
argument holding the maximum file length that can be loaded
as ROM. In preparation, modify the Niagara machine, so the
generic change will be easier to review.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/sparc64/niagara.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index ab5ef8c5b3..f58d008d3d 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -85,7 +85,8 @@ typedef struct NiagaraBoardState {
 #define NIAGARA_OBP_OFFSET  0x80000ULL
 #define PROM_SIZE_MAX       (4 * MiB)
=20
-static void add_rom_or_fail(const char *file, const hwaddr addr)
+static void add_rom_or_fail(const char *file, const hwaddr addr,
+                            uint64_t region_size)
 {
     /* XXX remove qtest_enabled() check once firmware files are
      * in the qemu tree
@@ -126,13 +127,15 @@ static void niagara_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(sysmem, NIAGARA_PROM_BASE, &s->prom);
=20
-    add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE);
-    add_rom_or_fail("1up-md.bin", NIAGARA_MD_ROM_BASE);
-    add_rom_or_fail("1up-hv.bin", NIAGARA_HV_ROM_BASE);
+    add_rom_or_fail("nvram1", NIAGARA_NVRAM_BASE, NIAGARA_NVRAM_SIZE);
+    add_rom_or_fail("1up-md.bin", NIAGARA_MD_ROM_BASE, NIAGARA_MD_ROM_SIZE=
);
+    add_rom_or_fail("1up-hv.bin", NIAGARA_HV_ROM_BASE, NIAGARA_HV_ROM_SIZE=
);
=20
-    add_rom_or_fail("reset.bin", NIAGARA_PROM_BASE);
-    add_rom_or_fail("q.bin", NIAGARA_PROM_BASE + NIAGARA_Q_OFFSET);
-    add_rom_or_fail("openboot.bin", NIAGARA_PROM_BASE + NIAGARA_OBP_OFFSET=
);
+    add_rom_or_fail("reset.bin", NIAGARA_PROM_BASE, NIAGARA_Q_OFFSET);
+    add_rom_or_fail("q.bin", NIAGARA_PROM_BASE + NIAGARA_Q_OFFSET,
+                    NIAGARA_OBP_OFFSET);
+    add_rom_or_fail("openboot.bin", NIAGARA_PROM_BASE + NIAGARA_OBP_OFFSET=
,
+                    PROM_SIZE_MAX - NIAGARA_OBP_OFFSET);
=20
     /* the virtual ramdisk is kind of initrd, but it resides
        outside of the partition RAM */
--=20
2.21.1


