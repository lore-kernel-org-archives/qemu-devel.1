Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617EC11D04
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91809206ED
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 13:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCvJ16ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91809206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4lZ9-0008B6-PF
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 08:08:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55647)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j4lWu-0004L1-Hj
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j4lWs-0004pp-TV
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:12 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31490
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j4lWs-0004ny-P9
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 08:06:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582203968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2dyL776lIMWtwu3QHoE9WDBeqqqUYswvxKzWPwHYPB4=;
 b=JCvJ16maPY37AqOfLAfiw+cJdb9rrxvgOiTkH2CWeSdoumPkFJgWVEhhKXCPsQQZurxK5e
 90x/aX+AR0+DKFgfcTK+5GAcGLKxNzkQL7fWMo0rKPjUKLvp9XqR2IA1wimsT2gZ3WPaM5
 tsqW3Zy96sL9H+8tbBVnn9F074RiVnI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-KodaD4z6Ove54oQYbyvvxg-1; Thu, 20 Feb 2020 08:06:02 -0500
X-MC-Unique: KodaD4z6Ove54oQYbyvvxg-1
Received: by mail-wr1-f72.google.com with SMTP id o9so1713641wrw.14
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 05:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JJNOlxhz3YaDnBzT0LwFaaq/SOy/0tsQ/KrZZBdtHoE=;
 b=jhI+Xt+HK5VXjfmPRcm5CWuuiv0UjuycVk5JmRRkWEu1pN76l/FNscUTPPDnJo4hVb
 HLE8l2qYX3FmPbb7PTApE/1GEpT9Khz8rrdK/dsVVY62xoSjXIQy8mAwLOcLx860yIJB
 2+iryi9MEJtXINbrgYCts7Ce3jOXDcDUPGQSzpq7p4JIwzwLdJugv/fbP7ArDyI5+iyN
 99LbR6ae2EtDh5LCzEGhjFOZXzGqaF3K5JJBUMwg4LzZ6zyZYnUkxyynmCprpzkEX0c8
 yugqmayd8W2zeA8nWdQlsMQk9MoBpFQpbM4GgkMsFueF5iwHVTa32/56JZ4hfnf26FM5
 impg==
X-Gm-Message-State: APjAAAUJRZWkUZzleKaWZ86uufwUVV4FNC0/3vBXduPnYG3kZy4Wuf3x
 zDFWk7cVwoxG6j13HWV29W1t18myFRPlwD/07yFtHYXl1mvVr+JiR48S2LV4oI0vL4cQBGz5Ggk
 KTQ89v41IDEyYsh8=
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr4485845wmj.175.1582203961576; 
 Thu, 20 Feb 2020 05:06:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqz8KNQ719hweoepCwU/16r5sB1wpPqBKHDZc0xAJklXBupLNm7eWc89eDGk1e864X9IS4bitQ==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr4485824wmj.175.1582203961311; 
 Thu, 20 Feb 2020 05:06:01 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id b67sm4594690wmc.38.2020.02.20.05.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2020 05:06:00 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 02/20] hw: Remove unnecessary cast when calling
 dma_memory_read()
Date: Thu, 20 Feb 2020 14:05:30 +0100
Message-Id: <20200220130548.29974-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220130548.29974-1-philmd@redhat.com>
References: <20200220130548.29974-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, Paul Durrant <paul@xen.org>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since its introduction in commit d86a77f8abb, dma_memory_read()
always accepted void pointer argument. Remove the unnecessary
casts.

This commit was produced with the included Coccinelle script
scripts/coccinelle/exec_rw_const.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 scripts/coccinelle/exec_rw_const.cocci | 15 +++++++++++++++
 hw/arm/smmu-common.c                   |  3 +--
 hw/arm/smmuv3.c                        | 10 ++++------
 hw/sd/sdhci.c                          | 15 +++++----------
 4 files changed, 25 insertions(+), 18 deletions(-)
 create mode 100644 scripts/coccinelle/exec_rw_const.cocci

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/ex=
ec_rw_const.cocci
new file mode 100644
index 0000000000..a0054f009d
--- /dev/null
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -0,0 +1,15 @@
+// Usage:
+//  spatch --sp-file scripts/coccinelle/exec_rw_const.cocci --dir . --in-p=
lace
+
+// Remove useless cast
+@@
+expression E1, E2, E3, E4;
+type T;
+@@
+(
+- dma_memory_read(E1, E2, (T *)E3, E4)
++ dma_memory_read(E1, E2, E3, E4)
+|
+- dma_memory_write(E1, E2, (T *)E3, E4)
++ dma_memory_write(E1, E2, E3, E4)
+)
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 23eb117041..0f2573f004 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -74,8 +74,7 @@ static int get_pte(dma_addr_t baseaddr, uint32_t index, u=
int64_t *pte,
     dma_addr_t addr =3D baseaddr + index * sizeof(*pte);
=20
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret =3D dma_memory_read(&address_space_memory, addr,
-                          (uint8_t *)pte, sizeof(*pte));
+    ret =3D dma_memory_read(&address_space_memory, addr, pte, sizeof(*pte)=
);
=20
     if (ret !=3D MEMTX_OK) {
         info->type =3D SMMU_PTW_ERR_WALK_EABT;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 8b5f157dc7..57a79df55b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -279,8 +279,7 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr=
, STE *buf,
=20
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret =3D dma_memory_read(&address_space_memory, addr,
-                          (void *)buf, sizeof(*buf));
+    ret =3D dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf)=
);
     if (ret !=3D MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=3D0x%"PRIx64"\n", addr)=
;
@@ -301,8 +300,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32=
_t ssid,
=20
     trace_smmuv3_get_cd(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret =3D dma_memory_read(&address_space_memory, addr,
-                           (void *)buf, sizeof(*buf));
+    ret =3D dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf)=
);
     if (ret !=3D MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=3D0x%"PRIx64"\n", addr)=
;
@@ -406,8 +404,8 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, =
STE *ste,
         l2_ste_offset =3D sid & ((1 << s->sid_split) - 1);
         l1ptr =3D (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std)=
);
         /* TODO: guarantee 64-bit single-copy atomicity */
-        ret =3D dma_memory_read(&address_space_memory, l1ptr,
-                              (uint8_t *)&l1std, sizeof(l1std));
+        ret =3D dma_memory_read(&address_space_memory, l1ptr, &l1std,
+                              sizeof(l1std));
         if (ret !=3D MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 69dc3e6b90..d5abdaad41 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -701,8 +701,7 @@ static void get_adma_description(SDHCIState *s, ADMADes=
cr *dscr)
     hwaddr entry_addr =3D (hwaddr)s->admasysaddr;
     switch (SDHC_DMA_TYPE(s->hostctl1)) {
     case SDHC_CTRL_ADMA2_32:
-        dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma2,
-                        sizeof(adma2));
+        dma_memory_read(s->dma_as, entry_addr, &adma2, sizeof(adma2));
         adma2 =3D le64_to_cpu(adma2);
         /* The spec does not specify endianness of descriptor table.
          * We currently assume that it is LE.
@@ -713,8 +712,7 @@ static void get_adma_description(SDHCIState *s, ADMADes=
cr *dscr)
         dscr->incr =3D 8;
         break;
     case SDHC_CTRL_ADMA1_32:
-        dma_memory_read(s->dma_as, entry_addr, (uint8_t *)&adma1,
-                        sizeof(adma1));
+        dma_memory_read(s->dma_as, entry_addr, &adma1, sizeof(adma1));
         adma1 =3D le32_to_cpu(adma1);
         dscr->addr =3D (hwaddr)(adma1 & 0xFFFFF000);
         dscr->attr =3D (uint8_t)extract32(adma1, 0, 7);
@@ -726,13 +724,10 @@ static void get_adma_description(SDHCIState *s, ADMAD=
escr *dscr)
         }
         break;
     case SDHC_CTRL_ADMA2_64:
-        dma_memory_read(s->dma_as, entry_addr,
-                        (uint8_t *)(&dscr->attr), 1);
-        dma_memory_read(s->dma_as, entry_addr + 2,
-                        (uint8_t *)(&dscr->length), 2);
+        dma_memory_read(s->dma_as, entry_addr, (&dscr->attr), 1);
+        dma_memory_read(s->dma_as, entry_addr + 2, (&dscr->length), 2);
         dscr->length =3D le16_to_cpu(dscr->length);
-        dma_memory_read(s->dma_as, entry_addr + 4,
-                        (uint8_t *)(&dscr->addr), 8);
+        dma_memory_read(s->dma_as, entry_addr + 4, (&dscr->addr), 8);
         dscr->addr =3D le64_to_cpu(dscr->addr);
         dscr->attr &=3D (uint8_t) ~0xC0;
         dscr->incr =3D 12;
--=20
2.21.1


