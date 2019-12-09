Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5559DC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:57:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 251ED2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 12:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXgeTDG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251ED2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieIay-0008Ax-6A
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 07:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ieIXL-0004Tm-Ir
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ieIXK-0003Ro-Gt
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ieIXK-0003Ra-D6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 07:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575895993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MlIeblQRv5fu5oXdGI9yCHmB9MmeWIo1PL9hdY9YMbo=;
 b=hXgeTDG+kLblFpiXjIKU5bQup4m8q0B7GGjOF4NqzQzEIDirFCGIrLns/+39+MjYR0Os6Q
 Yq8an3l2vakgsBN5FDs9k/Y9/7ZpuyipBIjw+Ulb6gGU0QhhFcUzLlYQG13mgLy4NEA3gS
 WckMvAOKKP4PkEQIei7zfUdz3D89M+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-Yi1mPtecNPmSebJY_BbsBw-1; Mon, 09 Dec 2019 07:53:06 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9231B101F4E3;
 Mon,  9 Dec 2019 12:53:05 +0000 (UTC)
Received: from thuth.com (ovpn-116-121.ams2.redhat.com [10.36.116.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8114C6E3FB;
 Mon,  9 Dec 2019 12:53:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/4] hw/audio: Remove the "use_broken_id" hack from the
 AC97 device
Date: Mon,  9 Dec 2019 13:52:46 +0100
Message-Id: <20191209125248.5849-3-thuth@redhat.com>
In-Reply-To: <20191209125248.5849-1-thuth@redhat.com>
References: <20191209125248.5849-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Yi1mPtecNPmSebJY_BbsBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the old pc-0.x machine types are gone, we do not need
the "use_broken_id" hack anymore.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/audio/ac97.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index a136b97f68..78cda88333 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -161,7 +161,6 @@ typedef struct AC97BusMasterRegs {
 typedef struct AC97LinkState {
     PCIDevice dev;
     QEMUSoundCard card;
-    uint32_t use_broken_id;
     uint32_t glob_cnt;
     uint32_t glob_sta;
     uint32_t cas;
@@ -1373,13 +1372,6 @@ static void ac97_realize(PCIDevice *dev, Error **err=
p)
     c[PCI_BASE_ADDRESS_0 + 6] =3D 0x00;
     c[PCI_BASE_ADDRESS_0 + 7] =3D 0x00;
=20
-    if (s->use_broken_id) {
-        c[PCI_SUBSYSTEM_VENDOR_ID] =3D 0x86;
-        c[PCI_SUBSYSTEM_VENDOR_ID + 1] =3D 0x80;
-        c[PCI_SUBSYSTEM_ID] =3D 0x00;
-        c[PCI_SUBSYSTEM_ID + 1] =3D 0x00;
-    }
-
     c[PCI_INTERRUPT_LINE] =3D 0x00;      /* intr_ln interrupt line rw */
     c[PCI_INTERRUPT_PIN] =3D 0x01;      /* intr_pn interrupt pin ro */
=20
@@ -1411,7 +1403,6 @@ static int ac97_init (PCIBus *bus)
=20
 static Property ac97_properties[] =3D {
     DEFINE_AUDIO_PROPERTIES(AC97LinkState, card),
-    DEFINE_PROP_UINT32 ("use_broken_id", AC97LinkState, use_broken_id, 0),
     DEFINE_PROP_END_OF_LIST (),
 };
=20
--=20
2.18.1


