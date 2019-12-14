Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEDC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EA8B214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buos031Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA8B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igEYn-00033I-9h
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igEVb-0007u2-R4
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igEVZ-0007xv-Sp
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:27 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57044
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igEVZ-0007v8-L4
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 15:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576357165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MiLtQtAFIR7WooqjFNP7RA7pxFuVPXkVzD1becE3SHU=;
 b=buos031Z8ORubbwg0qb79p4ex9zeZFsxAUxe9CgYSIONBNo6hmzTAJsdkiLl//NhjWtqPo
 ghsiKdAA8Asb9gx/S+aNnNQ41uGqju4zhsndqAZH3MFeSUTRY38H71AuuV5oCo23CO3F6t
 bFyO55xXLLmjt1ypOSmA509jJplZ12E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-GUjV9-9vPW2uksM1tC2tFw-1; Sat, 14 Dec 2019 10:57:21 -0500
X-MC-Unique: GUjV9-9vPW2uksM1tC2tFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B6CA801E53;
 Sat, 14 Dec 2019 15:57:19 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-147.brq.redhat.com [10.40.205.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F5D75D6A7;
 Sat, 14 Dec 2019 15:57:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] hw/arm/xlnx-versal: Use memory_region_add_subregion()
 when priority is 0
Date: Sat, 14 Dec 2019 16:56:09 +0100
Message-Id: <20191214155614.19004-4-philmd@redhat.com>
In-Reply-To: <20191214155614.19004-1-philmd@redhat.com>
References: <20191214155614.19004-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Paul Burton <pburton@wavecomp.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is pointless to overlap a memory subregion with priority 0.
Use the simpler memory_region_add_subregion() function.

This patch was produced with the following spatch script:

    @@
    expression region;
    expression offset;
    expression subregion;
    @@
    -memory_region_add_subregion_overlap(region, offset, subregion, 0)
    +memory_region_add_subregion(region, offset, subregion)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/xlnx-versal-virt.c | 3 +--
 hw/arm/xlnx-versal.c      | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 462493c467..901e9ed86c 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -437,8 +437,7 @@ static void versal_virt_init(MachineState *machine)
=20
     /* Make the APU cpu address space visible to virtio and other
      * modules unaware of muliple address-spaces.  */
-    memory_region_add_subregion_overlap(get_system_memory(),
-                                        0, &s->soc.fpd.apu.mr, 0);
+    memory_region_add_subregion(get_system_memory(), 0, &s->soc.fpd.apu.=
mr);
=20
     s->binfo.ram_size =3D machine->ram_size;
     s->binfo.loader_start =3D 0x0;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 8b3d8d85b8..538d907f8a 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -281,8 +281,8 @@ static void versal_realize(DeviceState *dev, Error **=
errp)
     memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
                            MM_OCM_SIZE, &error_fatal);
=20
-    memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_oc=
m, 0);
-    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0)=
;
+    memory_region_add_subregion(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm);
+    memory_region_add_subregion(&s->fpd.apu.mr, 0, &s->mr_ps);
 }
=20
 static void versal_init(Object *obj)
--=20
2.21.0


