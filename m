Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A59EC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:19:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59958246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 09:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQW4w+bg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59958246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8hEm-0005ic-GK
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 04:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1j8hDp-0004WG-Dk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1j8hDo-0007lH-28
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:18:44 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1j8hDn-0007l1-Ux
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 04:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583140722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tT2kLPOMNRTg/Z4EFFVY83WZKeDzXwkkUlw/aCa4C6M=;
 b=WQW4w+bgG3lb3X/HTviUEMSFqGknl99EUOX+m2KtkxztsPuUBUUIF9OetC8OxPFbP1k5iP
 O71G3RdaRNuB6q4C0csBrp2ZBhO/5Cj93eTCvmL7ySKX83QFJCTEGKo4yDtkjnhps014ib
 ZhoJqrqA/uzEDhh89X8vzpienhjYtc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-ygT06yrVODufIIxv7oFdcg-1; Mon, 02 Mar 2020 04:18:41 -0500
X-MC-Unique: ygT06yrVODufIIxv7oFdcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90028800D50
 for <qemu-devel@nongnu.org>; Mon,  2 Mar 2020 09:18:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com
 [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFFF5385;
 Mon,  2 Mar 2020 09:18:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E5FE39D6B; Mon,  2 Mar 2020 10:18:36 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] qxl: map rom r/o
Date: Mon,  2 Mar 2020 10:18:36 +0100
Message-Id: <20200302091836.29012-3-kraxel@redhat.com>
In-Reply-To: <20200302091836.29012-1-kraxel@redhat.com>
References: <20200302091836.29012-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Map qxl rom read-only into the guest, so the guest can't tamper with the
content.  qxl has a shadow copy of the rom to deal with that, but the
shadow doesn't cover the mode list.  A privilidged user in the guest can
manipulate the mode list and that to trick qemu into oob reads, leading
to a DoS via segfault if that read access happens to hit unmapped memory.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200225055920.17261-2-kraxel@redhat.com
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


