Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4881C3F2CE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B241B206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3yfzBSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B241B206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55239 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE8tG-0007Q0-RA
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jE8sI-0005oB-C4
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jE8sD-0004kJ-On
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:51:02 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jE8sD-0004ja-L3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584438657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9inKhgTKTv0zqUNtHcvV+Fodc2GZ+KSmWsdMNps03Lw=;
 b=d3yfzBSSwLrPh3/VeqYSI63Fx2aSYuMSyDjtm/ch1b+3edd/INYIXV6Q0BwYp7Nbl9zblP
 FHz6va+dfMDj0j40nVw/i5pMXF+iYKp1uYXPAhN/EycR3XT5yccYOsQiNrv3L60hXZCmbq
 zmIfT7aiC8QE2WwRIRkNHGnu70CVJcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-djqS0EqCMci9L8iicU9oeg-1; Tue, 17 Mar 2020 05:50:55 -0400
X-MC-Unique: djqS0EqCMci9L8iicU9oeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D94F7801E6C;
 Tue, 17 Mar 2020 09:50:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com
 [10.36.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2578F37B;
 Tue, 17 Mar 2020 09:50:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1A88B204A0; Tue, 17 Mar 2020 10:50:50 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] usb-serial: Fix timeout closing the device
Date: Tue, 17 Mar 2020 10:50:49 +0100
Message-Id: <20200317095049.28486-5-kraxel@redhat.com>
In-Reply-To: <20200317095049.28486-1-kraxel@redhat.com>
References: <20200317095049.28486-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Jason Andryuk <jandryuk@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Andryuk <jandryuk@gmail.com>

Linux guests wait ~30 seconds when closing the emulated /dev/ttyUSB0.
During that time, the kernel driver is sending many control URBs
requesting GetModemStat (5).  Real hardware returns a status with
FTDI_THRE (Transmitter Holding Register) and FTDI_TEMT (Transmitter
Empty) set.  QEMU leaves them clear, and it seems Linux is waiting for
FTDI_TEMT to be set to indicate the tx queue is empty before closing.

Set the bits when responding to a GetModemStat query and avoid the
shutdown delay.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Message-id: 20200316174610.115820-5-jandryuk@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index 77b964588b5f..d2c03681b7f0 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -332,7 +332,7 @@ static void usb_serial_handle_control(USBDevice *dev, U=
SBPacket *p,
         break;
     case DeviceInVendor | FTDI_GET_MDM_ST:
         data[0] =3D usb_get_modem_lines(s) | 1;
-        data[1] =3D 0;
+        data[1] =3D FTDI_THRE | FTDI_TEMT;
         p->actual_length =3D 2;
         break;
     case DeviceOutVendor | FTDI_SET_EVENT_CHR:
--=20
2.18.2


