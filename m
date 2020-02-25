Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04283C35DF2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:02:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35CD20732
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 06:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cDpgg97k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35CD20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6TIK-0005dV-VI
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 01:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j6TGP-0003zZ-1c
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:00:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j6TGN-0000VS-TU
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:00:12 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j6TGN-0000Tv-Pm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 01:00:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582610411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xajBEGYWjfHpz6efNBjFQNX4VpyfGfJO9a0s/56wfzA=;
 b=cDpgg97kKQdtL2dPhz5cV2xS7KWho+Xa5ojy/N44/Pc6EKjdLCpKO07ykRWRDYNAzUr94K
 jeQlZXQKOnftejEZH7uJCY5DHNc3gg5CC7YWUY+ECwVQUDm8xfRdcbFhaXti/atbmkLBMJ
 ivmIhx19CEAW+KSMAq8eWdJbn8tqfYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-EQatYADTN9CjcWr7u5sw7g-1; Tue, 25 Feb 2020 00:59:31 -0500
X-MC-Unique: EQatYADTN9CjcWr7u5sw7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B491800D50;
 Tue, 25 Feb 2020 05:59:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-87.ams2.redhat.com
 [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9183E5D9CD;
 Tue, 25 Feb 2020 05:59:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 845FB9D23; Tue, 25 Feb 2020 06:59:20 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qxl: map rom r/o
Date: Tue, 25 Feb 2020 06:59:19 +0100
Message-Id: <20200225055920.17261-2-kraxel@redhat.com>
In-Reply-To: <20200225055920.17261-1-kraxel@redhat.com>
References: <20200225055920.17261-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 ppandit@redhat.com, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Map qxl rom read-only into the guest, so the guest can't tamper with the
content.  qxl has a shadow copy of the rom to deal with that, but the
shadow doesn't cover the mode list.  A privilidged user in the guest can
manipulate the mode list and that to trick qemu into oob reads, leading
to a DoS via segfault if that read access happens to hit unmapped memory.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 21a43a1d5ec2..227da69a50d9 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2136,7 +2136,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Err=
or **errp)
     pci_set_byte(&config[PCI_INTERRUPT_PIN], 1);
=20
     qxl->rom_size =3D qxl_rom_size();
-    memory_region_init_ram(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
+    memory_region_init_rom(&qxl->rom_bar, OBJECT(qxl), "qxl.vrom",
                            qxl->rom_size, &error_fatal);
     init_qxl_rom(qxl);
     init_qxl_ram(qxl);
--=20
2.18.2


